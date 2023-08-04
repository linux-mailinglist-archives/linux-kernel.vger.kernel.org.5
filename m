Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E4276F7F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjHDCnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjHDCmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:42:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912A1735
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:42:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-268541d2947so898990a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691116973; x=1691721773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaU132AsVWTNpVn9AAedpCpeKo8rmE5ysTz6Gn+cdGk=;
        b=a24flyY4LVxUQEurTyMLb4nEQbhBcMQnwaZMqB8g/AhIjtV75KquLrY2f2Rlmf186/
         NzLA8L5GGprH/QXl+iYAsPxb5xr9env3kcow7qu9sWMUXmGxt0CpJEcLXri9TWDm7+zD
         L5jnKUQDLHkSC5Fxj+emTNAjGhv8pe8y/6dkVgcqgJQpPLx7Ale6wtjDkvIENoyuSMrV
         9Jqpal4xnu9GJQKM00ZiVRn5cldfGeXO1StSM5pJC2Fulu9koI0nSoXa7Y2KrUNGg2aj
         VE9L6Gci87NM/sgNr2h2W85XuY+eDZfjVlciH8tGMlkWTzgcpWc8hPV5d68Mlf0u3uTU
         1pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691116973; x=1691721773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaU132AsVWTNpVn9AAedpCpeKo8rmE5ysTz6Gn+cdGk=;
        b=SJwUvqM6Yo05cErDYh44CutLvowdR306BqeB+JaLyZuPdpJKhV2dpqxbHEIPRXjvS+
         hVg8Vwn34Mc5IpGsvNxrWOXuRHzhN9euBaB4AoDsZuIK+i74TdEFR7yo0IZ4ZBKlHuNY
         n7sqyFwGuB4bNcCRExJ0kBaSaqv3IIDlbsccucI6yq8E5wl4kQs/aU5YlJ8worVVWRsM
         JhNOEfaITOkNG4Xv6c/kKGXZZZYLZfMAjapwM1QhiQPjjD35Xs+NUdq5zpQmFs96TLw9
         42ty9hCPG6hLXnGnWHMIGsqL50MKnoif/b19ZZmmrfwlhyh1jT1HHbmaj9Rji7ZUO5+4
         /9sA==
X-Gm-Message-State: AOJu0Yzrc7zVqVWfBPTCuBVQW35MWCeWg6F3bgclud8KH7Q4qGCg0XnH
        iD+k8VckSOTLRkje4yIWO9Mc45yk0P1nv1owlks=
X-Google-Smtp-Source: AGHT+IEUGyvzmFvMLOR7ZEhxrnvUObzTuvnWYWvE6k85qmnnKqVqBrGY4OutqH1PHZ3PbKjKKtoVlGGGXtxc0f52dpM=
X-Received: by 2002:a17:90b:4b0f:b0:268:4df5:8b29 with SMTP id
 lx15-20020a17090b4b0f00b002684df58b29mr437297pjb.19.1691116972532; Thu, 03
 Aug 2023 19:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230803144227.2187749-1-nogikh@google.com> <CAHCN7x+8Qq6w0eRC0NwBfhgS7XH7fmmPr9xwhR54rWFNY37Ugg@mail.gmail.com>
 <9e77ccc3-07db-f1fe-ef99-981852d4772b@infradead.org> <CAHCN7xKG=8ygSi8st31fe+t3Mn+k-7VUHKixFCZUuuDLOX8-kQ@mail.gmail.com>
 <d8a57aee-bb8a-dc5a-7c4f-b8a293d37bec@infradead.org>
In-Reply-To: <d8a57aee-bb8a-dc5a-7c4f-b8a293d37bec@infradead.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 3 Aug 2023 21:42:41 -0500
Message-ID: <CAHCN7xKnRAmKh60dAtVaxz-dQtjzhBNtS0aN2swmddfo5FAD-Q@mail.gmail.com>
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

On Thu, Aug 3, 2023 at 9:37=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 8/3/23 19:26, Adam Ford wrote:
> > On Thu, Aug 3, 2023 at 9:01=E2=80=AFPM Randy Dunlap <rdunlap@infradead.=
org> wrote:
> >>
> >> Hi--
> >>
> >> On 8/3/23 08:24, Adam Ford wrote:
> >>> On Thu, Aug 3, 2023 at 9:42=E2=80=AFAM Aleksandr Nogikh <nogikh@googl=
e.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> We've been seing the following linker error on arm64 syzbot instance=
s:
> >>>>
> >>>> ld.lld: error: undefined symbol: phy_mipi_dphy_get_default_config_fo=
r_hsclk
> >>>>>>> referenced by samsung-dsim.c:731 (drivers/gpu/drm/bridge/samsung-=
dsim.c:731)
> >>>>>>>               drivers/gpu/drm/bridge/samsung-dsim.o:(samsung_dsim=
_init) in archive vmlinux.a
> >>>>
> >>>> Steps to reproduce on the latest linux-next:
> >>>>
> >>>> $ git checkout next-20230803
> >>>> $ wget -O '.config' 'https://raw.githubusercontent.com/google/syzkal=
ler/master/dashboard/config/linux/upstream-arm64-kasan.config'
> >>>> $ make CC=3Dclang ARCH=3Darm64 LD=3Dld.lld CROSS_COMPILE=3Daarch64-l=
inux-gnu- olddefconfig
> >>>>
> >>>> This also prints:
> >>>>
> >>>> WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPH=
Y
> >>>>   Depends on [n]: GENERIC_PHY [=3Dn]
> >>>>   Selected by [y]:
> >>>>   - DRM_NWL_MIPI_DSI [=3Dy] && DRM_BRIDGE [=3Dy] && DRM [=3Dy] && CO=
MMON_CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
> >>>>   - DRM_SAMSUNG_DSIM [=3Dy] && DRM [=3Dy] && DRM_BRIDGE [=3Dy] && CO=
MMON_CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
> >>>>
> >>>> $ make CC=3Dclang ARCH=3Darm64 LD=3Dld.lld CROSS_COMPILE=3Daarch64-l=
inux-gnu- -j$(nproc)
> >>>>
> >>>> The kernel should have still compiled fine even despite the message =
above, right?
> >>
> >> No. See drivers/Makefile:
> >> obj-$(CONFIG_GENERIC_PHY)       +=3D phy/
> >>
> >> so the drivers/phy/ subdir is only built when CONFIG_GENERIC_PHY is se=
t,
> >> but it's not set.
> >>
> >>>> Could you please take a look?
> >>>
> >>> GENERIC_PHY_MIPI_DPHY was enabled to use
> >>> phy_mipi_dphy_get_default_config() which takes in the pixel clock,
> >>> bits-per-pixel, number of lanes and phy structure.  It applies a bunc=
h
> >>> of math based on the info passed and fills in the structure, but that
> >>> function itself doesn't appear to be referencing phy code, so it's
> >>> likely safe.
> >>>
> >>> I think this can be resolved by enabling GENERIC_PHY.  I just checked
> >>> linux-next and when I built the arm64 defconfig, it enables
> >>> GENERIC_PHY=3Dy, so I don't think this is an issue.  I also checked t=
he
> >>
> >> defconfig doesn't matter in this case. The .config that was provided h=
as:
> >> # CONFIG_GENERIC_PHY is not set
> >> CONFIG_GENERIC_PHY_MIPI_DPHY=3Dy
> >>
> >
> > Where/how was the .config generated?
> >
>
> Aleksandr posted a link to the config file above.

I get that, but I am not sure how this was generated.

>
> > Are you building linux-next or something else?  The .config file
> > generated when I build the arm64 defconfig  show both enabled:
>
> linux-next.
>
>
> > $ grep GENERIC_PHY .config
> > CONFIG_GENERIC_PHY=3Dy
> > CONFIG_GENERIC_PHY_MIPI_DPHY=3Dy
> >
>
> Yes, this is not a defconfig file.

I know, but it is a .config file that is generated from make defconfig
ARCH=3Darm64
>
> >
> >> but yes, selecting GENERIC_PHY (needed in 3 places) does fix the warni=
ngs
> >> and build error.  2 instance in drm/bridge/Kconfig and one in
> >> drm/bridge/cadence/Kconfig (found by inspection).
> >>
> >>
> >>
> >>> multi_v7_defconfig for ARM and it also sets GENERIC_PHY=3Dy for 32-bi=
t
> >>> ARM people using some of the Exynos boards.
> >>>
> >>> I don't know what version of Linux you're trying to build, but I can'=
t
> >>> replicate your issue.
> >>
> >> I had no problem replicating the kconfig warnings and build error.
> >
> > If you can replicate the problem, I'd suggest submitting a patch.
>
> Sure, I'll do that.

Great!  thanks.

adam
>
> --
> ~Randy
