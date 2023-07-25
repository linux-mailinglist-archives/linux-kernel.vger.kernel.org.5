Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CEF761063
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbjGYKPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGYKPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:15:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC70810F9;
        Tue, 25 Jul 2023 03:15:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so515598a12.1;
        Tue, 25 Jul 2023 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690280124; x=1690884924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stZvY5U9wSZTs5ds6eBy5fhaT/Xhl9PttBLPwX46gHo=;
        b=Zd+TfiK6QjysIfwcqshz3riRH9eDjKMkLVQHalEsW7A2lCezdTeTYsuDR+b8W5TV3j
         trncykuABFsnq/ZL/wATBQpxI4491zYNzFHyfLjWDkDizPL5yi8tU+oXV2wOqbYlXamp
         iyvVvum4XpoXIEopgV3qp1W6kGCLfzh3LsRNJjGCxUlfLKQp7LRAeEZenadG0aJpnWdu
         fCDR7hRde0HP4B+WIu9MLqDVm+N8e48S4Q386V4nJP56nbv2kNXGxoiABKui2fptjkZU
         b2hatoO91JCcF9Ou+6QOWGdLPSdIICbqjXTrSaw/7/K75BzuThXlDayMuzcaHtQkCtk6
         TlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690280124; x=1690884924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stZvY5U9wSZTs5ds6eBy5fhaT/Xhl9PttBLPwX46gHo=;
        b=QfdxZKFQ1imazxfBeNHpis+IpwGM5tiWK7dUCWYIdOTO08J5lcSKoLDolyaohTrSXy
         Idu8h5eF8QTRnrgXfAUP7I8Yz/CDxZZrqjpzam+SKC4wNz9EYxctI/r85Boz7lTJFQgw
         GVfEyKQvhwhb08PHpZWYJKLoN5/s2LVfOJAWlR1J5ThHgaud21oECdqI5UoYdebR6moI
         D8jjFV9IxV+vNc/5a+Dv9WYsLizmvA2B/F9AhQ8LALU1FEXQ6JQQvtDCtvkx3V6tLbd3
         iyibiiHS0TZpGLq2FbzftcciPn5mQIZc8qIPO9m+1MrLnhmA3BkLbquMAT7wXXU8TprJ
         +g0Q==
X-Gm-Message-State: ABy/qLYMGL2WeexvJWFy9t2tDFd3VihJOFI6qJ0HWsjMOq46Gkzxn5iZ
        gnr0kXHzGknuVZJKoZuO4lYUr+Q1qisTmlaAEhg=
X-Google-Smtp-Source: APBJJlEGc8Qqtx3M3xk7xfxVMkEIUKq+V578qF8fgJcopnKeKZwBb2Kzhr090da4HCcP1DY4c4v4cpT332l5IKkyo18=
X-Received: by 2002:a05:6402:104b:b0:521:985d:7314 with SMTP id
 e11-20020a056402104b00b00521985d7314mr2215492edu.18.1690280123484; Tue, 25
 Jul 2023 03:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230707111151.461373-1-keguang.zhang@gmail.com>
 <20230707111151.461373-3-keguang.zhang@gmail.com> <ZL+MB6P2tSHvgPHw@alpha.franken.de>
In-Reply-To: <ZL+MB6P2tSHvgPHw@alpha.franken.de>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Tue, 25 Jul 2023 18:15:07 +0800
Message-ID: <CAJhJPsUV_f_t-faHY-4Jay9AJO848UMVhtxgFh_AuvQnurpnRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: loongson32: Remove regs-rtc.h
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 4:59=E2=80=AFPM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Fri, Jul 07, 2023 at 07:11:51PM +0800, Keguang Zhang wrote:
> > Since commit 9fb23090658a ("rtc: Remove the
> > Loongson-1 RTC driver"), no one is using regs-rtc.h.
> > Therefore, remove this obsolete header file.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  .../include/asm/mach-loongson32/loongson1.h   |  1 -
> >  .../include/asm/mach-loongson32/regs-rtc.h    | 19 -------------------
> >  2 files changed, 20 deletions(-)
> >  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h
> >
> > diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/m=
ips/include/asm/mach-loongson32/loongson1.h
> > index bc27fcee3176..84f45461c832 100644
> > --- a/arch/mips/include/asm/mach-loongson32/loongson1.h
> > +++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
> > @@ -46,6 +46,5 @@
> >  #define LS1X_CLK_BASE                        0x1fe78030
> >
> >  #include <regs-mux.h>
> > -#include <regs-rtc.h>
> >
> >  #endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
> > diff --git a/arch/mips/include/asm/mach-loongson32/regs-rtc.h b/arch/mi=
ps/include/asm/mach-loongson32/regs-rtc.h
> > deleted file mode 100644
> > index a3d096be1607..000000000000
> > --- a/arch/mips/include/asm/mach-loongson32/regs-rtc.h
> > +++ /dev/null
> > @@ -1,19 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0-or-later */
> > -/*
> > - * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
> > - *
> > - * Loongson 1 RTC timer Register Definitions.
> > - */
> > -
> > -#ifndef __ASM_MACH_LOONGSON32_REGS_RTC_H
> > -#define __ASM_MACH_LOONGSON32_REGS_RTC_H
> > -
> > -#define LS1X_RTC_REG(x) \
> > -             ((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + (x)))
> > -
> > -#define LS1X_RTC_CTRL        LS1X_RTC_REG(0x40)
> > -
> > -#define RTC_EXTCLK_OK        (BIT(5) | BIT(8))
> > -#define RTC_EXTCLK_EN        BIT(8)
> > -
> > -#endif /* __ASM_MACH_LOONGSON32_REGS_RTC_H */
> > --
> > 2.39.2
>
> I get these build error when this patch is applied:
>
> linux/arch/mips/loongson32/common/platform.c: In function =E2=80=98ls1x_r=
tc_set_extclk=E2=80=99:
> /local/tbogendoerfer/korg/linux/arch/mips/loongson32/common/platform.c:27=
0:24: error: =E2=80=98LS1X_RTC_CTRL=E2=80=99 undeclared (first use in this =
function)
>   u32 val =3D __raw_readl(LS1X_RTC_CTRL);
>                         ^~~~~~~~~~~~~
> linux/arch/mips/loongson32/common/platform.c:270:24: note: each undeclare=
d identifier is reported only once for each function it appears in
> /local/tbogendoerfer/korg/linux/arch/mips/loongson32/common/platform.c:27=
2:14: error: =E2=80=98RTC_EXTCLK_OK=E2=80=99 undeclared (first use in this =
function)
>   if (!(val & RTC_EXTCLK_OK))
>               ^~~~~~~~~~~~~
> linux/arch/mips/loongson32/common/platform.c:273:22: error: =E2=80=98RTC_=
EXTCLK_EN=E2=80=99 undeclared (first use in this function)
>    __raw_writel(val | RTC_EXTCLK_EN, LS1X_RTC_CTRL);
>
> Thomas.
>

Sorry! I will send v2 to fix this ASAP.

> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]



--=20
Best regards,

Keguang Zhang
