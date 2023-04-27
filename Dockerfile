FROM alpine AS builder

RUN apk add -U --no-cache \
            file \
            upx \
    && wget https://github.com/docker/hub-tool/releases/download/v0.4.5/hub-tool-linux-amd64.tar.gz \
    && tar xfz hub-tool-linux-amd64.tar.gz \
    && cd hub-tool \
    && file hub-tool && ls -l hub-tool && sha256sum hub-tool \
    && upx hub-tool \
    && file hub-tool && ls -l hub-tool && sha256sum hub-tool \
    && ./hub-tool version


FROM scratch

COPY --from=builder /hub-tool/hub-tool /usr/bin/hub-tool

ENTRYPOINT ["/usr/bin/hub-tool"]
