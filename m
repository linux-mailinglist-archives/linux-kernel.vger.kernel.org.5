Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510D76EE00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbjHCPY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbjHCPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 11:24:57 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64A30F8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 08:24:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2682b4ca7b7so547990a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691076296; x=1691681096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MELmtBLgpIAkH6zLFGWNZFur2jT4X5kL3K/Q5XACUw=;
        b=fLEW2On2ibR7NJze1K1StpP+uCIy4SCRk99kGtsdBM4AeX7woMF89USR0LtYaQywdy
         gfYIwI7j/gPKaRzcetqCkIDsEz6rlvXE1bGsR9jzk/IUs9w2xTq9kV+hWT2Dt8Oe8pCQ
         NnVTmraSueK5MeHK5Lq+A5kX/TTR5eXCcM4wKCeYvSz7dLbvhwdt0YQeSb1t9lSlxfX0
         Z8WPJPG/2dgkQuQyCadoSfcWrq84FFbctWjsMkpzjBM0ViPUkQcP0LzAiQeguP/fAZgx
         n9UjCk023dTLt6i1urA7wMpUBV54jmfMbjZ1v9U0S6kkduL5LleUS67bGDh42gahYk9+
         jI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691076296; x=1691681096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MELmtBLgpIAkH6zLFGWNZFur2jT4X5kL3K/Q5XACUw=;
        b=TOUpY/y13ouAOiIm3l658cJngJAqocxLALT+36AaWTc2RQ38TcUinpkpo+WOxCNanc
         2zfTiZ715WLzIvzgoQR2NvJyLDF/GI4db5+cUhxhszn1VjvfQEK2y2xD5Cp0NBXKRIC6
         CcqyKRNvQhNLw9odC5vqzdxz8/SUCbMyzw6KsgUDNaFRdgWJbzCNv007gGICC8u7UEJ4
         zRf0CPv+uIDmxPaAPA98TxBnRjByGG1XiVCX3oOKLM7C3XHYnXvwZkcfVB+YF7iKQQKe
         u/4RmzeDpge7jelv4k5okFNjVxWR9G6WadiQfF0w4quRLQjyjgcheNo4RF7JYcHtM4Q6
         3Vfg==
X-Gm-Message-State: ABy/qLb4MWxRx5eOnLUwI0NsbbKrBOqkok30N9nhRLM+EtZk26HnlbtI
        9xznmBNIxBuW2vQwG9A/M1Ml/AgqO2amHEpoRNw=
X-Google-Smtp-Source: APBJJlEDFvWynE4bzo0k1bR5I+gwvO4FHoNNjxDtXRQs6uvAG6+JXvipcu+b8B9Evyz9YMMhFPvUnJG2YB1HNumOlnM=
X-Received: by 2002:a17:90b:4f81:b0:268:17aa:8b78 with SMTP id
 qe1-20020a17090b4f8100b0026817aa8b78mr16376582pjb.20.1691076295517; Thu, 03
 Aug 2023 08:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230803144227.2187749-1-nogikh@google.com>
In-Reply-To: <20230803144227.2187749-1-nogikh@google.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 3 Aug 2023 10:24:44 -0500
Message-ID: <CAHCN7x+8Qq6w0eRC0NwBfhgS7XH7fmmPr9xwhR54rWFNY37Ugg@mail.gmail.com>
Subject: Re: drivers/gpu/drm/bridge/samsung-dsim.c link error
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     l.stach@pengutronix.de, inki.dae@samsung.com,
        jagan@amarulasolutions.com, m.szyprowski@samsung.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 9:42=E2=80=AFAM Aleksandr Nogikh <nogikh@google.com>=
 wrote:
>
> Hello,
>
> We've been seing the following linker error on arm64 syzbot instances:
>
> ld.lld: error: undefined symbol: phy_mipi_dphy_get_default_config_for_hsc=
lk
> >>> referenced by samsung-dsim.c:731 (drivers/gpu/drm/bridge/samsung-dsim=
.c:731)
> >>>               drivers/gpu/drm/bridge/samsung-dsim.o:(samsung_dsim_ini=
t) in archive vmlinux.a
>
> Steps to reproduce on the latest linux-next:
>
> $ git checkout next-20230803
> $ wget -O '.config' 'https://raw.githubusercontent.com/google/syzkaller/m=
aster/dashboard/config/linux/upstream-arm64-kasan.config'
> $ make CC=3Dclang ARCH=3Darm64 LD=3Dld.lld CROSS_COMPILE=3Daarch64-linux-=
gnu- olddefconfig
>
> This also prints:
>
> WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
>   Depends on [n]: GENERIC_PHY [=3Dn]
>   Selected by [y]:
>   - DRM_NWL_MIPI_DSI [=3Dy] && DRM_BRIDGE [=3Dy] && DRM [=3Dy] && COMMON_=
CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
>   - DRM_SAMSUNG_DSIM [=3Dy] && DRM [=3Dy] && DRM_BRIDGE [=3Dy] && COMMON_=
CLK [=3Dy] && OF [=3Dy] && HAS_IOMEM [=3Dy]
>
> $ make CC=3Dclang ARCH=3Darm64 LD=3Dld.lld CROSS_COMPILE=3Daarch64-linux-=
gnu- -j$(nproc)
>
> The kernel should have still compiled fine even despite the message above=
, right?
>
> Could you please take a look?

GENERIC_PHY_MIPI_DPHY was enabled to use
phy_mipi_dphy_get_default_config() which takes in the pixel clock,
bits-per-pixel, number of lanes and phy structure.  It applies a bunch
of math based on the info passed and fills in the structure, but that
function itself doesn't appear to be referencing phy code, so it's
likely safe.

I think this can be resolved by enabling GENERIC_PHY.  I just checked
linux-next and when I built the arm64 defconfig, it enables
GENERIC_PHY=3Dy, so I don't think this is an issue.  I also checked the
multi_v7_defconfig for ARM and it also sets GENERIC_PHY=3Dy for 32-bit
ARM people using some of the Exynos boards.

I don't know what version of Linux you're trying to build, but I can't
replicate your issue.

adam


>
> --
> Thank you!
> Aleksandr
