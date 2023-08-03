Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50B76E246
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjHCIAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHCIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:00:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BF4ED3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:47:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40a47e8e38dso157391cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691048875; x=1691653675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HX2QjhAjm1VtIJ7aq9ETcIbROYuaT4rznxqM4xCkPNc=;
        b=fsKM8DoTuZOfwAzvF0ApPYf/k3QnUZq6zjoVqUZ66DKlTqfk9ykOVtIpCTWOAmTvGx
         GzUI4DgtRAELLR5d/EA5m9OQRDHAL9mu5XIB+hjPL5HYyjlxVqWFFM+GaVQ0PIt/ptW9
         9+u4+TX2wnOxcAybwVOGP4xLrCwNTMgiYJBYqqEpQf+1jVVqHFEgpc80mUBCbWk0aWsd
         6uyGbu3RiHdpJFAoQ0y5brfpm6PCsRZrKVk6xGnNpA/3CJ9llTZ7KqYOGsSHGEx+J8cu
         Q12sYbRU6HcARk3EZYUQy8vF0cp0IdnVyNbt0lq9XLQcYI+BV2BBo2DPme4IyShYZ115
         gQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691048875; x=1691653675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HX2QjhAjm1VtIJ7aq9ETcIbROYuaT4rznxqM4xCkPNc=;
        b=NyMmZ8UvBuZr1xuBIzbfsdB4csjNfNvIaHVuXFHasLH+mfjSiaGtLG4JEWKQZIetwK
         duIE0Oa6atotBSeMokFKjmfhUgT5i/CA16GRgUXbxzuJiU48yDnPd1P5ZHGVUr6gt0hA
         FQVgez2mpDfYunvcsGGET/+zukWdar2r88sSeHYLjFUgdREJFlB7pWZPpGCuc0iWPK+D
         bHfokciuxC9FKmU8bFtLDM4mK5BGzwzMtV/WWdanN1ivNAv+Q3rOFZFI/RFGwFC5brho
         VqMQwsb8UxhTmMrk0jmim2rv9f2mtsJXvw9oshbGZaun3LcQC3U78SzbotJoyAjx53fR
         1iwg==
X-Gm-Message-State: ABy/qLZzwyyBpsVGvK2Q8Cn+4Zg6FsnfBrPtospByx3pte1Q1NcpjBmK
        ds7PS+eMoDl0Drd8ub1QNZMfPb7OQmZwRuez0TStHMCo74MPZ00jLQ225Q==
X-Google-Smtp-Source: APBJJlEvSoUL4BFDEsByLxH9z9PduXUo16Ko724GHnU1ikgKnpUSJIYzWcxXfB79sgXW5CD3nvoFVi7DjptAMpL6xTE=
X-Received: by 2002:a05:622a:1aa2:b0:405:3a65:b3d6 with SMTP id
 s34-20020a05622a1aa200b004053a65b3d6mr1183790qtc.13.1691048874911; Thu, 03
 Aug 2023 00:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230801100533.3350037-1-leitao@debian.org>
In-Reply-To: <20230801100533.3350037-1-leitao@debian.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 3 Aug 2023 09:47:43 +0200
Message-ID: <CANn89iKuHxUGphhDkKz2ZWS3YR3-BkieTb4b4gKMR9B7jxKpWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3] netconsole: Enable compile time configuration
To:     Breno Leitao <leitao@debian.org>
Cc:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, leit@meta.com,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 12:06=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Enable netconsole features to be set at compilation time. Create two
> Kconfig options that allow users to set extended logs and release
> prepending features at compilation time.
>
> Right now, the user needs to pass command line parameters to netconsole,
> such as "+"/"r" to enable extended logs and version prepending features.
>
> With these two options, the user could set the default values for the
> features at compile time, and don't need to pass it in the command line
> to get them enabled, simplifying the command line.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   v1 -> v2:
>         * Improvements in the Kconfig help section.
>   v2 -> v3:
>         * Honour the Kconfig settings when creating sysfs targets
>         * Add "by default" in a Kconfig help.
> ---
>  drivers/net/Kconfig      | 22 ++++++++++++++++++++++
>  drivers/net/netconsole.c | 10 ++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 368c6f5b327e..55fb9509bcae 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -332,6 +332,28 @@ config NETCONSOLE_DYNAMIC
>           at runtime through a userspace interface exported using configf=
s.
>           See <file:Documentation/networking/netconsole.rst> for details.
>
> +config NETCONSOLE_EXTENDED_LOG
> +       bool "Set kernel extended message by default"
> +       depends on NETCONSOLE
> +       default n
> +       help
> +         Set extended log support for netconsole message. If this option=
 is
> +         set, log messages are transmitted with extended metadata header=
 in a
> +         format similar to /dev/kmsg.  See
> +         <file:Documentation/networking/netconsole.rst> for details.
> +
> +config NETCONSOLE_PREPEND_RELEASE
> +       bool "Prepend kernel release version in the message by default"
> +       depends on NETCONSOLE_EXTENDED_LOG
> +       default n
> +       help
> +         Set kernel release to be prepended to each netconsole message b=
y
> +         default. If this option is set, the kernel release is prepended=
 into
> +         the first field of every netconsole message, so, the netconsole
> +         server/peer can easily identify what kernel release is logging =
each
> +         message.  See <file:Documentation/networking/netconsole.rst> fo=
r
> +         details.
> +
>  config NETPOLL
>         def_bool NETCONSOLE
>
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 87f18aedd3bd..e3b6155f4529 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -181,6 +181,11 @@ static struct netconsole_target *alloc_param_target(=
char *target_config)
>         if (!nt)
>                 goto fail;
>
> +       if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
> +               nt->extended =3D true;
> +       if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
> +               nt->release =3D true;
> +
>         nt->np.name =3D "netconsole";
>         strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
>         nt->np.local_port =3D 6665;
> @@ -681,6 +686,11 @@ static struct config_item *make_netconsole_target(st=
ruct config_group *group,
>         nt->np.remote_port =3D 6666;
>         eth_broadcast_addr(nt->np.remote_mac);
>
> +       if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
> +               nt->extended =3D true;
> +       if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
> +               nt->release =3D true;
> +

Instead of duplicating these, what about adding a preliminary helper
in a separate patch ?

Something like this:

 drivers/net/netconsole.c |   45 ++++++++++++++++++++----------------------=
---
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 87f18aedd3bd7b3da9d2481dc9898e94dd75917b..a022ceaa2e3c4783ca0ea61c1c7=
b9f911d087abc
100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -167,26 +167,32 @@ static void netconsole_target_put(struct
netconsole_target *nt)

 #endif /* CONFIG_NETCONSOLE_DYNAMIC */

+/*
+ * Allocate and initialize with defaults.
+ * Note that these targets get their config_item fields zeroed-out.
+ */
+static struct netconsole_target *alloc_and_init(void)
+{
+       struct netconsole_target *nt =3D kzalloc(sizeof(*nt), GFP_KERNEL);
+
+       if (nt) {
+               nt->np.name =3D "netconsole";
+               strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
+               nt->np.local_port =3D 6665;
+               nt->np.remote_port =3D 6666;
+               eth_broadcast_addr(nt->np.remote_mac);
+       }
+       return nt;
+}
+
 /* Allocate new target (from boot/module param) and setup netpoll for it *=
/
 static struct netconsole_target *alloc_param_target(char *target_config)
 {
+       struct netconsole_target *nt =3D alloc_and_init();
        int err =3D -ENOMEM;
-       struct netconsole_target *nt;

-       /*
-        * Allocate and initialize with defaults.
-        * Note that these targets get their config_item fields zeroed-out.
-        */
-       nt =3D kzalloc(sizeof(*nt), GFP_KERNEL);
        if (!nt)
                goto fail;
-
-       nt->np.name =3D "netconsole";
-       strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
-       nt->np.local_port =3D 6665;
-       nt->np.remote_port =3D 6666;
-       eth_broadcast_addr(nt->np.remote_mac);
-
        if (*target_config =3D=3D '+') {
                nt->extended =3D true;
                target_config++;
@@ -664,23 +670,12 @@ static const struct config_item_type
netconsole_target_type =3D {
 static struct config_item *make_netconsole_target(struct config_group *gro=
up,
                                                  const char *name)
 {
+       struct netconsole_target *nt =3D alloc_and_init();
        unsigned long flags;
-       struct netconsole_target *nt;

-       /*
-        * Allocate and initialize with defaults.
-        * Target is disabled at creation (!enabled).
-        */
-       nt =3D kzalloc(sizeof(*nt), GFP_KERNEL);
        if (!nt)
                return ERR_PTR(-ENOMEM);

-       nt->np.name =3D "netconsole";
-       strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
-       nt->np.local_port =3D 6665;
-       nt->np.remote_port =3D 6666;
-       eth_broadcast_addr(nt->np.remote_mac);
-
        /* Initialize the config_item member */
        config_item_init_type_name(&nt->item, name, &netconsole_target_type=
);
