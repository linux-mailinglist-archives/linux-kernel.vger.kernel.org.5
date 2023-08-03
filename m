Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309C776E6D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjHCL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbjHCL3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:29:30 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E217A1981;
        Thu,  3 Aug 2023 04:29:24 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-99357737980so119851166b.2;
        Thu, 03 Aug 2023 04:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691062163; x=1691666963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qVUTi9M5sLcie6yIGG2nnYWviv8Jo0VEzp70AMTqbEE=;
        b=iFrKy0sETDaCuaQaqWt7dGy/PZ4/MU2p4PGFUMklXBtb+IKdJp7tbIeA1Mn7vcoE/9
         caWe7boyfiaXeIyqu5hZN9e5diARiTkU4+RjVhDLwUc3QN7zf2fYQ/XyqQr8a95j1iG9
         6an7wCd7AkD/EuIRuQcLAeV+tED8s6zQlZHokyCPH+wF7ZuFYOiHoBebE7z2P58nyw9a
         fwqj84+PxlZsWCYFTHwe8BQYTRMVhA68ztGCbBqIR9sE3jduUKJlpe0w909MXgXA717x
         kemQKsMDtc+Z4Mx1O5Nx0AueJl7A8286qkOaNX5dUR90P9EbzPZnafVhaWZ7vKln7DUM
         JF4g==
X-Gm-Message-State: ABy/qLbtFpbwQq1WCItr2C1+01eQmcFU/VP2mnV57925ptSD2DxrE5Qe
        hOSqV55DlzjZuPAVV/kBaS4=
X-Google-Smtp-Source: APBJJlE7c/wOwf/5XM2UVblac3j3wiFTw268rQNvK5rBO5aS7rWUiJ9mRnWYQUHlF2uTZL8gS4gcqQ==
X-Received: by 2002:a17:906:5198:b0:973:fd02:a41f with SMTP id y24-20020a170906519800b00973fd02a41fmr8429104ejk.40.1691062163118;
        Thu, 03 Aug 2023 04:29:23 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-008.fbsv.net. [2a03:2880:31ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id se9-20020a170906ce4900b0099364d9f0e6sm10389437ejb.117.2023.08.03.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 04:29:22 -0700 (PDT)
Date:   Thu, 3 Aug 2023 04:29:20 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     rdunlap@infradead.org, benjamin.poirier@gmail.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, leit@meta.com,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3] netconsole: Enable compile time configuration
Message-ID: <ZMuPkMlg1/kfRyXk@gmail.com>
References: <20230801100533.3350037-1-leitao@debian.org>
 <CANn89iKuHxUGphhDkKz2ZWS3YR3-BkieTb4b4gKMR9B7jxKpWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKuHxUGphhDkKz2ZWS3YR3-BkieTb4b4gKMR9B7jxKpWQ@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:47:43AM +0200, Eric Dumazet wrote:
> On Tue, Aug 1, 2023 at 12:06 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > Enable netconsole features to be set at compilation time. Create two
> > Kconfig options that allow users to set extended logs and release
> > prepending features at compilation time.
> >
> > Right now, the user needs to pass command line parameters to netconsole,
> > such as "+"/"r" to enable extended logs and version prepending features.
> >
> > With these two options, the user could set the default values for the
> > features at compile time, and don't need to pass it in the command line
> > to get them enabled, simplifying the command line.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   v1 -> v2:
> >         * Improvements in the Kconfig help section.
> >   v2 -> v3:
> >         * Honour the Kconfig settings when creating sysfs targets
> >         * Add "by default" in a Kconfig help.
> > ---
> >  drivers/net/Kconfig      | 22 ++++++++++++++++++++++
> >  drivers/net/netconsole.c | 10 ++++++++++
> >  2 files changed, 32 insertions(+)
> >
> > diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> > index 368c6f5b327e..55fb9509bcae 100644
> > --- a/drivers/net/Kconfig
> > +++ b/drivers/net/Kconfig
> > @@ -332,6 +332,28 @@ config NETCONSOLE_DYNAMIC
> >           at runtime through a userspace interface exported using configfs.
> >           See <file:Documentation/networking/netconsole.rst> for details.
> >
> > +config NETCONSOLE_EXTENDED_LOG
> > +       bool "Set kernel extended message by default"
> > +       depends on NETCONSOLE
> > +       default n
> > +       help
> > +         Set extended log support for netconsole message. If this option is
> > +         set, log messages are transmitted with extended metadata header in a
> > +         format similar to /dev/kmsg.  See
> > +         <file:Documentation/networking/netconsole.rst> for details.
> > +
> > +config NETCONSOLE_PREPEND_RELEASE
> > +       bool "Prepend kernel release version in the message by default"
> > +       depends on NETCONSOLE_EXTENDED_LOG
> > +       default n
> > +       help
> > +         Set kernel release to be prepended to each netconsole message by
> > +         default. If this option is set, the kernel release is prepended into
> > +         the first field of every netconsole message, so, the netconsole
> > +         server/peer can easily identify what kernel release is logging each
> > +         message.  See <file:Documentation/networking/netconsole.rst> for
> > +         details.
> > +
> >  config NETPOLL
> >         def_bool NETCONSOLE
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 87f18aedd3bd..e3b6155f4529 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -181,6 +181,11 @@ static struct netconsole_target *alloc_param_target(char *target_config)
> >         if (!nt)
> >                 goto fail;
> >
> > +       if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
> > +               nt->extended = true;
> > +       if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
> > +               nt->release = true;
> > +
> >         nt->np.name = "netconsole";
> >         strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
> >         nt->np.local_port = 6665;
> > @@ -681,6 +686,11 @@ static struct config_item *make_netconsole_target(struct config_group *group,
> >         nt->np.remote_port = 6666;
> >         eth_broadcast_addr(nt->np.remote_mac);
> >
> > +       if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
> > +               nt->extended = true;
> > +       if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
> > +               nt->release = true;
> > +
> 
> Instead of duplicating these, what about adding a preliminary helper
> in a separate patch ?

That is a good idea, I will update.

Thanks!
