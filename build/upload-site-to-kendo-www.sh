#!/bin/bash
SYNC="rsync -rvcz --delete --inplace"
DEST="/usr/share/nginx/html/$2/"
USER="nginx"
SITE="_site"

if [[ "$3" != "" ]]; then
    SITE="$3"
fi

declare -a HOSTS=("ordkendowww01.telerik.local" "ordkendowww02.telerik.local")

function log {
    echo "[$(date +%T)] $1"
}

if [[ "$#" -ne 2 && "$#" -ne 3 ]]; then
    echo "Usage: $0 <source-dir> <dest-dir> <site-dir(optional)>"
    exit 1
fi

for host in "${HOSTS[@]}"
do
    log "Uploading site to $host"
    $SYNC $1/$SITE/ $USER@$host:$DEST || exit 1
done

log "Done"

