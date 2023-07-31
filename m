Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4493D76A031
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjGaSSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGaSSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:18:10 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B55E4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:18:02 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d075a831636so5181316276.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690827481; x=1691432281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySLy+AV7dr4UWGqiDpKR4cM7t70PT/im80pMgtGNRVU=;
        b=uGQ0FsJjNGGTds8dgQKW0N+O2Q9wuent66uj7m2jUAvptDA0nQXen6CcnfHqOm7tjz
         MFTYmfmlC+jb22zP46FQMgmH/jCpHzl5nQoIW8Cz7U/IjOkgCtLqGIkqlSLJDdVho+sj
         mvlpz8UqSgk2yjQ/GJohscCcP6DqWKHaScCLsqrevaFP9DoMDxxAOSAly3fi4puBwljG
         QGIenxkXcb8yLbkRLRnRFALyUSL3PEewXDyyktz7WnJSCjb0WLua3V3k3TuEfzOaznwr
         yyQkA8x4gxReK33ObDffgvDRY9hdG9C98eVqmq3INbu+6u7ILLr0zZw2GY0FYViuw4w7
         XS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827481; x=1691432281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySLy+AV7dr4UWGqiDpKR4cM7t70PT/im80pMgtGNRVU=;
        b=WeFyeivqy8nOunxLjxffzDQktRBVoru4Qucx64es00WoVkiRFstdBlBH3AivPHShDz
         C7vYk9GADnStIsx2XaTBjk4r3nZ9RaPovyuxPXU4RYAmXT2mnA1PeCNtx9cr3gb23Gj1
         2o86v/PbHlcy2PDhZmaVBGu97UFs1u+/rcw61N10OOhUCxhmb04qEnWFt8CwaAeYIoRE
         PFTA8PXuh8zPKBofFKxi1MSI8towYaNZUUnIg02k9RSMa9sqqHNv0OKKKrks6g+zsefc
         Q4+oa5u5QKQo2o8n7HuytsJHpHfThB5niRprSlCF+rs366h2b/Gyr5R32xYQmWcDfTM1
         R+bg==
X-Gm-Message-State: ABy/qLbzFcRKEBgwZaDDPDclN+1NHem6GNSMM1sX5Qfm2fJ/M67YsT4r
        CWH5ykltBrxYVUKj3lzQoCJRGRvgOZjNgaHsec5A7A==
X-Google-Smtp-Source: APBJJlFOWrkvd7btAMj0J4zTPZd0rvjDmvdBuVl6SPIqkqsklcfo/+esA+rZ5G47Fz1GPsX/1yGOtiPgJJzy0T64h90=
X-Received: by 2002:a25:dc86:0:b0:c73:9c0e:179d with SMTP id
 y128-20020a25dc86000000b00c739c0e179dmr11051261ybe.55.1690827480904; Mon, 31
 Jul 2023 11:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230731030740.12411-1-rdunlap@infradead.org> <CAJuCfpGQzpWptS0WBBzw8XesPFb5MeG5UVLFDce72wfXNA1joQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGQzpWptS0WBBzw8XesPFb5MeG5UVLFDce72wfXNA1joQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 31 Jul 2023 11:17:49 -0700
Message-ID: <CAJuCfpGQbyD7qPHSTE1o7srTv=sP8ZZTA0F9U1owNO7OEP_M1g@mail.gmail.com>
Subject: Re: [PATCH] PSI: select KERNFS as needed
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:14=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Sun, Jul 30, 2023 at 8:07=E2=80=AFPM Randy Dunlap <rdunlap@infradead.o=
rg> wrote:
> >
> > Users of KERNFS should select it to enforce its being built, so
> > do this to prevent a build error.
> >
> > In file included from ../kernel/sched/build_utility.c:97:
> > ../kernel/sched/psi.c: In function 'psi_trigger_poll':
> > ../kernel/sched/psi.c:1479:17: error: implicit declaration of function =
'kernfs_generic_poll' [-Werror=3Dimplicit-function-declaration]
> >  1479 |                 kernfs_generic_poll(t->of, wait);
> >
> > Fixes: aff037078eca ("sched/psi: use kernfs polling functions for PSI t=
rigger polling")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Reported-by: kernel test robot <lkp@intel.com>

shouldn't this include:
Closes: https://lore.kernel.org/oe-kbuild-all/202307310732.r65EQFY0-lkp@int=
el.com/
?

> > Link: lore.kernel.org/r/202307310732.r65EQFY0-lkp@intel.com
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
>
> Acked-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks!
>
>
> > ---
> >  init/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff -- a/init/Kconfig b/init/Kconfig
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -629,6 +629,7 @@ config TASK_IO_ACCOUNTING
> >
> >  config PSI
> >         bool "Pressure stall information tracking"
> > +       select KERNFS
> >         help
> >           Collect metrics that indicate how overcommitted the CPU, memo=
ry,
> >           and IO capacity are in the system.
