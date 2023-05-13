FROM node:lts-alpine as builder
RUN mkdir -p /verdaccio/plugins
ADD plugins/verdaccio-docker-memory /verdaccio/plugins/verdaccio-docker-memory
RUN cd /verdaccio/plugins/verdaccio-docker-memory \
  && npm install --production
FROM verdaccio/verdaccio:5
ADD docker.yaml /verdaccio/conf/config.yaml
COPY --chown=$VERDACCIO_USER_UID:root --from=builder \
  /verdaccio/plugins/verdaccio-docker-memory \
  /verdaccio/plugins/verdaccio-docker-memory