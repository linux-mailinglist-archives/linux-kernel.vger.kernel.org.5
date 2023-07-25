Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CFF760DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjGYJAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjGYI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:59:59 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AA19126;
        Tue, 25 Jul 2023 01:59:53 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qODtS-0008Gr-00; Tue, 25 Jul 2023 10:59:46 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 018B8C01D2; Tue, 25 Jul 2023 10:47:03 +0200 (CEST)
Date:   Tue, 25 Jul 2023 10:47:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MIPS: loongson32: Remove regs-rtc.h
Message-ID: <ZL+MB6P2tSHvgPHw@alpha.franken.de>
References: <20230707111151.461373-1-keguang.zhang@gmail.com>
 <20230707111151.461373-3-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230707111151.461373-3-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 07:11:51PM +0800, Keguang Zhang wrote:
> Since commit 9fb23090658a ("rtc: Remove the
> Loongson-1 RTC driver"), no one is using regs-rtc.h.
> Therefore, remove this obsolete header file.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  .../include/asm/mach-loongson32/loongson1.h   |  1 -
>  .../include/asm/mach-loongson32/regs-rtc.h    | 19 -------------------
>  2 files changed, 20 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h
> 
> diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
> index bc27fcee3176..84f45461c832 100644
> --- a/arch/mips/include/asm/mach-loongson32/loongson1.h
> +++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
> @@ -46,6 +46,5 @@
>  #define LS1X_CLK_BASE			0x1fe78030
>  
>  #include <regs-mux.h>
> -#include <regs-rtc.h>
>  
>  #endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
> diff --git a/arch/mips/include/asm/mach-loongson32/regs-rtc.h b/arch/mips/include/asm/mach-loongson32/regs-rtc.h
> deleted file mode 100644
> index a3d096be1607..000000000000
> --- a/arch/mips/include/asm/mach-loongson32/regs-rtc.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
> - *
> - * Loongson 1 RTC timer Register Definitions.
> - */
> -
> -#ifndef __ASM_MACH_LOONGSON32_REGS_RTC_H
> -#define __ASM_MACH_LOONGSON32_REGS_RTC_H
> -
> -#define LS1X_RTC_REG(x) \
> -		((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + (x)))
> -
> -#define LS1X_RTC_CTRL	LS1X_RTC_REG(0x40)
> -
> -#define RTC_EXTCLK_OK	(BIT(5) | BIT(8))
> -#define RTC_EXTCLK_EN	BIT(8)
> -
> -#endif /* __ASM_MACH_LOONGSON32_REGS_RTC_H */
> -- 
> 2.39.2

I get these build error when this patch is applied:

linux/arch/mips/loongson32/common/platform.c: In function ‘ls1x_rtc_set_extclk’:
/local/tbogendoerfer/korg/linux/arch/mips/loongson32/common/platform.c:270:24: error: ‘LS1X_RTC_CTRL’ undeclared (first use in this function)
  u32 val = __raw_readl(LS1X_RTC_CTRL);
                        ^~~~~~~~~~~~~
linux/arch/mips/loongson32/common/platform.c:270:24: note: each undeclared identifier is reported only once for each function it appears in
/local/tbogendoerfer/korg/linux/arch/mips/loongson32/common/platform.c:272:14: error: ‘RTC_EXTCLK_OK’ undeclared (first use in this function)
  if (!(val & RTC_EXTCLK_OK))
              ^~~~~~~~~~~~~
linux/arch/mips/loongson32/common/platform.c:273:22: error: ‘RTC_EXTCLK_EN’ undeclared (first use in this function)
   __raw_writel(val | RTC_EXTCLK_EN, LS1X_RTC_CTRL);

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
