Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF3876F7D6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjHDC0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjHDC0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:26:17 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE07BA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:26:15 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76714caf466so123037685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691115975; x=1691720775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTpwPYIEtJZhEQMyoZFlpz+eyGuIfW/wEpS8AWrCqsM=;
        b=WObKCCCmKSuLaHalMGxKJKzoB4rHBSwzFjPxUvE1DZwdVHLsCnHjzUL9HGAGQNuLwz
         sxx3LWYU2CQDntsQJpJe+X6CiGQwvomwTC6T573uga2UOEqGQGzxio8FzdnXyk1Ywr2U
         L3S2pxTU1KIWKJuPmol5ww0J6TfHb6G+/+3S1dGDZMQow/V0Zsg53hVGEqzRlXKwCSQ0
         oglKOc6rN4P3zNaXNg5NCGzn3TV434WSEgABnpTz1fvMKw59O5bBW8/gT6cqy6WT7BK6
         Fx1F9Nijbzs2viRuEse3DAImS2VBqyOLvcfikM+1RDsaTmQRhW0ID+beHYgFtNOwr1Fv
         mqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115975; x=1691720775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTpwPYIEtJZhEQMyoZFlpz+eyGuIfW/wEpS8AWrCqsM=;
        b=V9APerAgtYMqhc6msbtK6/T0QhJbLp5otmktPgK4vgCWKWCIkL5dNBKECtb5bHKtgV
         Lta6TANy1Cwe+b8qJsWm054pFKxdOJFY+EwMQf9ClIliJ4sJ/u5uulABQZVvghcAplLB
         vTk37+35kWm5ACCCCwk2qQmLT2Q7fxW7eNOgfKucy5OZHEykjpDcJkHEgGtRVV8Mt08e
         EN9aX+nL1RMFJO+kYYP91GQxgeCn4pgkqZ4TRzyDOfEdYfK2pfkLkjFhj/sO/Hd89kXn
         DcWXlVvnMZmYxpNkhoWU7VwijwbjtJ9csKhB97OQYUHnZA6x06n+YTrUIi00xPBNF5xc
         A1Bg==
X-Gm-Message-State: AOJu0Yzvs05ZYFjOIMp5mCrO9gSqgZTInV95HjfCA2D62X1ubGIyrdIq
        3tfNXK3oiFSSq9uIcYoKPR2SehKdHMCpbSUtthE=
X-Google-Smtp-Source: AGHT+IFzsm7efu5mxOJh5yGjdaQKx5K9M96EchYul4CIs05wM29OEAS92BFCbBTOkxDZcZ52EKn1DB6i1dCMSOQWpP0=
X-Received: by 2002:a05:620a:2182:b0:76c:bc4b:92b9 with SMTP id
 g2-20020a05620a218200b0076cbc4b92b9mr578889qka.11.1691115974950; Thu, 03 Aug
 2023 19:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230803144227.2187749-1-nogikh@google.com> <CAHCN7x+8Qq6w0eRC0NwBfhgS7XH7fmmPr9xwhR54rWFNY37Ugg@mail.gmail.com>
 <9e77ccc3-07db-f1fe-ef99-981852d4772b@infradead.org>
In-Reply-To: <9e77ccc3-07db-f1fe-ef99-981852d4772b@infradead.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 3 Aug 2023 21:26:03 -0500
Message-ID: <CAHCN7xKG=8ygSi8st31fe+t3Mn+k-7VUHKixFCZUuuDLOX8-kQ@mail.gmail.com>
Subject: Re: drivers/gpu/drm/bridge/samsung-dsim.c link error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Aleksandr Nogikh <nogikh@google.com>, l.stach@pengutronix.de,
        inki.dae@samsung.com, jagan@amarulasolutions.com,
        m.szyprowski@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 9:01=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Hi--
>
> On 8/3/23 08:24, Adam Ford wrote:
> > On Thu, Aug 3, 2023 at 9:42=E2=80=AFAM Aleksandr Nogikh <nogikh@google.=
com> wrote:
> >>
> >> Hello,
> >>
> >> We've been seing the following linker error on arm64 syzbot instances:
> >>
> >> ld.lld: error: undefined symbol: phy_mipi_dphy_get_default_config_for_=
hsclk
> >>>>> referenced by samsung-dsim.c:731 (drivers/gpu/drm/bridge/samsung-ds=
im.c:731)
> >>>>>               drivers/gpu/drm/bridge/samsung-dsim.o:(samsung_dsim_i=
nit) in archive vmlinux.a
> >>
> >> Steps to reproduce on the latest linux-next:
> >>
> >> $ git checkout next-20230803
> >> $ wget -O '.config' 'https://raw.githubusercontent.com/google/syzkalle=
r/master/dashboard/config/linux/upstream-arm64-kasan.config'
> >> $ make CC=3Dclang ARCH=3Darm64 LD=3Dld.lld CROSS_COMPILE=3Daarch64-lin=
ux-gnu- olddefconfig
> >>
> >> This also prints:
> >>
> >> WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
> >>   Depends on [n]: GENERIC_PHY [=3Dn]
> >>   Selected by [y]:
> >>   - DRM_NWL_MIPI_DSI [=3Dy] && DRM_BRIDGE [=3Dy] && DRM [=3Dy] && COMM=
ON_CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
> >>   - DRM_SAMSUNG_DSIM [=3Dy] && DRM [=3Dy] && DRM_BRIDGE [=3Dy] && COMM=
ON_CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
> >>
> >> $ make CC=3Dclang ARCH=3Darm64 LD=3Dld.lld CROSS_COMPILE=3Daarch64-lin=
ux-gnu- -j$(nproc)
> >>
> >> The kernel should have still compiled fine even despite the message ab=
ove, right?
>
> No. See drivers/Makefile:
> obj-$(CONFIG_GENERIC_PHY)       +=3D phy/
>
> so the drivers/phy/ subdir is only built when CONFIG_GENERIC_PHY is set,
> but it's not set.
>
> >> Could you please take a look?
> >
> > GENERIC_PHY_MIPI_DPHY was enabled to use
> > phy_mipi_dphy_get_default_config() which takes in the pixel clock,
> > bits-per-pixel, number of lanes and phy structure.  It applies a bunch
> > of math based on the info passed and fills in the structure, but that
> > function itself doesn't appear to be referencing phy code, so it's
> > likely safe.
> >
> > I think this can be resolved by enabling GENERIC_PHY.  I just checked
> > linux-next and when I built the arm64 defconfig, it enables
> > GENERIC_PHY=3Dy, so I don't think this is an issue.  I also checked the
>
> defconfig doesn't matter in this case. The .config that was provided has:
> # CONFIG_GENERIC_PHY is not set
> CONFIG_GENERIC_PHY_MIPI_DPHY=3Dy
>

Where/how was the .config generated?

Are you building linux-next or something else?  The .config file
generated when I build the arm64 defconfig  show both enabled:

$ grep GENERIC_PHY .config
CONFIG_GENERIC_PHY=3Dy
CONFIG_GENERIC_PHY_MIPI_DPHY=3Dy


> but yes, selecting GENERIC_PHY (needed in 3 places) does fix the warnings
> and build error.  2 instance in drm/bridge/Kconfig and one in
> drm/bridge/cadence/Kconfig (found by inspection).
>
>
>
> > multi_v7_defconfig for ARM and it also sets GENERIC_PHY=3Dy for 32-bit
> > ARM people using some of the Exynos boards.
> >
> > I don't know what version of Linux you're trying to build, but I can't
> > replicate your issue.
>
> I had no problem replicating the kconfig warnings and build error.

If you can replicate the problem, I'd suggest submitting a patch.

adam
>
> --
> ~Randy
