Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDBA76D726
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjHBStQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjHBStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:49:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E684A2119;
        Wed,  2 Aug 2023 11:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8283461AB9;
        Wed,  2 Aug 2023 18:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65648C433C9;
        Wed,  2 Aug 2023 18:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691002144;
        bh=xtJczoF3oh6jnECOQfv5q5gtrDFCSV0gElhOqcidnQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aam6PDRdIj5psmth78BjW/Ag2k5AkwnNuQXZnByBSg+GeEK0iGRz5eWkeyPBnW3yb
         SBcr0qJN81N5oQw0KqU7EEcZyozgDU6yj9mmtAdEi+sDX1BMfEw7xDjm0ItZjpmz2f
         Ag8ONG4bxkS99eOlW1YJAkA3T4tDezogXHxHwmHQ6qScY3jVLiwknNkUaO3z+D30Zs
         PwU9cVvqwzDICbOhCNp17cHJNuZOmrrfTmtz0rGEgmjXo92i1edy1/UHXa1uGiHGfs
         4V9Zz4OgpnJwttqIhqTAUrEv9XRYHpmG5JEWjl2D1CFnLuKpjsNbEugzkU2/cuGiHd
         q3Y1pU0nuPjJw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/4] sh: remove unused sh4-202 support
Date:   Wed,  2 Aug 2023 20:48:47 +0200
Message-Id: <20230802184849.1019466-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802184849.1019466-1-arnd@kernel.org>
References: <20230802184849.1019466-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This early prototype of the SH4 CPU was only used in
the "microdev" board that is now removed, so all of the
sh4-202 supoprt can also be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/Kconfig                        |   5 -
 arch/sh/kernel/cpu/sh4/Makefile        |   4 -
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c | 174 -------------------------
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c | 139 --------------------
 4 files changed, 322 deletions(-)
 delete mode 100644 arch/sh/kernel/cpu/sh4/clock-sh4-202.c
 delete mode 100644 arch/sh/kernel/cpu/sh4/setup-sh4-202.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d3df67f215ca5..d785329e57151 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -383,10 +383,6 @@ config CPU_SUBTYPE_SH7760
 	bool "Support SH7760 processor"
 	select CPU_SH4
 
-config CPU_SUBTYPE_SH4_202
-	bool "Support SH4-202 processor"
-	select CPU_SH4
-
 # SH-4A Processor Support
 
 config CPU_SUBTYPE_SH7723
@@ -517,7 +513,6 @@ config SH_PCLK_FREQ
 			      CPU_SUBTYPE_SH7263 || \
 			      CPU_SUBTYPE_MXG
 	default "60000000" if CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R
-	default "66000000" if CPU_SUBTYPE_SH4_202
 	default "50000000"
 	help
 	  This option is used to specify the peripheral clock frequency.
diff --git a/arch/sh/kernel/cpu/sh4/Makefile b/arch/sh/kernel/cpu/sh4/Makefile
index 00c16331e07e5..02e3ee16e15ce 100644
--- a/arch/sh/kernel/cpu/sh4/Makefile
+++ b/arch/sh/kernel/cpu/sh4/Makefile
@@ -23,15 +23,11 @@ obj-$(CONFIG_CPU_SUBTYPE_SH7091)	+= setup-sh7750.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7751)	+= setup-sh7750.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7751R)	+= setup-sh7750.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7760)	+= setup-sh7760.o
-obj-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= setup-sh4-202.o
 
 # Primary on-chip clocks (common)
 ifndef CONFIG_CPU_SH4A
 clock-$(CONFIG_CPU_SH4)			:= clock-sh4.o
 endif
 
-# Additional clocks by subtype
-clock-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= clock-sh4-202.o
-
 obj-y					+= $(clock-y)
 obj-$(CONFIG_PERF_EVENTS)		+= $(perf-y)
diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
deleted file mode 100644
index c1cdef763cb25..0000000000000
--- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ /dev/null
@@ -1,174 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * arch/sh/kernel/cpu/sh4/clock-sh4-202.c
- *
- * Additional SH4-202 support for the clock framework
- *
- *  Copyright (C) 2005  Paul Mundt
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/clkdev.h>
-#include <asm/clock.h>
-#include <asm/freq.h>
-
-#define CPG2_FRQCR3	0xfe0a0018
-
-static int frqcr3_divisors[] = { 1, 2, 3, 4, 6, 8, 16 };
-static int frqcr3_values[]   = { 0, 1, 2, 3, 4, 5, 6  };
-
-static unsigned long emi_clk_recalc(struct clk *clk)
-{
-	int idx = __raw_readl(CPG2_FRQCR3) & 0x0007;
-	return clk->parent->rate / frqcr3_divisors[idx];
-}
-
-static inline int frqcr3_lookup(struct clk *clk, unsigned long rate)
-{
-	int divisor = clk->parent->rate / rate;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(frqcr3_divisors); i++)
-		if (frqcr3_divisors[i] == divisor)
-			return frqcr3_values[i];
-
-	/* Safe fallback */
-	return 5;
-}
-
-static struct sh_clk_ops sh4202_emi_clk_ops = {
-	.recalc		= emi_clk_recalc,
-};
-
-static struct clk sh4202_emi_clk = {
-	.flags		= CLK_ENABLE_ON_INIT,
-	.ops		= &sh4202_emi_clk_ops,
-};
-
-static unsigned long femi_clk_recalc(struct clk *clk)
-{
-	int idx = (__raw_readl(CPG2_FRQCR3) >> 3) & 0x0007;
-	return clk->parent->rate / frqcr3_divisors[idx];
-}
-
-static struct sh_clk_ops sh4202_femi_clk_ops = {
-	.recalc		= femi_clk_recalc,
-};
-
-static struct clk sh4202_femi_clk = {
-	.flags		= CLK_ENABLE_ON_INIT,
-	.ops		= &sh4202_femi_clk_ops,
-};
-
-static void shoc_clk_init(struct clk *clk)
-{
-	int i;
-
-	/*
-	 * For some reason, the shoc_clk seems to be set to some really
-	 * insane value at boot (values outside of the allowable frequency
-	 * range for instance). We deal with this by scaling it back down
-	 * to something sensible just in case.
-	 *
-	 * Start scaling from the high end down until we find something
-	 * that passes rate verification..
-	 */
-	for (i = 0; i < ARRAY_SIZE(frqcr3_divisors); i++) {
-		int divisor = frqcr3_divisors[i];
-
-		if (clk->ops->set_rate(clk, clk->parent->rate / divisor) == 0)
-			break;
-	}
-
-	WARN_ON(i == ARRAY_SIZE(frqcr3_divisors));	/* Undefined clock */
-}
-
-static unsigned long shoc_clk_recalc(struct clk *clk)
-{
-	int idx = (__raw_readl(CPG2_FRQCR3) >> 6) & 0x0007;
-	return clk->parent->rate / frqcr3_divisors[idx];
-}
-
-static int shoc_clk_verify_rate(struct clk *clk, unsigned long rate)
-{
-	struct clk *bclk = clk_get(NULL, "bus_clk");
-	unsigned long bclk_rate = clk_get_rate(bclk);
-
-	clk_put(bclk);
-
-	if (rate > bclk_rate)
-		return 1;
-	if (rate > 66000000)
-		return 1;
-
-	return 0;
-}
-
-static int shoc_clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long frqcr3;
-	unsigned int tmp;
-
-	/* Make sure we have something sensible to switch to */
-	if (shoc_clk_verify_rate(clk, rate) != 0)
-		return -EINVAL;
-
-	tmp = frqcr3_lookup(clk, rate);
-
-	frqcr3 = __raw_readl(CPG2_FRQCR3);
-	frqcr3 &= ~(0x0007 << 6);
-	frqcr3 |= tmp << 6;
-	__raw_writel(frqcr3, CPG2_FRQCR3);
-
-	clk->rate = clk->parent->rate / frqcr3_divisors[tmp];
-
-	return 0;
-}
-
-static struct sh_clk_ops sh4202_shoc_clk_ops = {
-	.init		= shoc_clk_init,
-	.recalc		= shoc_clk_recalc,
-	.set_rate	= shoc_clk_set_rate,
-};
-
-static struct clk sh4202_shoc_clk = {
-	.flags		= CLK_ENABLE_ON_INIT,
-	.ops		= &sh4202_shoc_clk_ops,
-};
-
-static struct clk *sh4202_onchip_clocks[] = {
-	&sh4202_emi_clk,
-	&sh4202_femi_clk,
-	&sh4202_shoc_clk,
-};
-
-static struct clk_lookup lookups[] = {
-	/* main clocks */
-	CLKDEV_CON_ID("emi_clk", &sh4202_emi_clk),
-	CLKDEV_CON_ID("femi_clk", &sh4202_femi_clk),
-	CLKDEV_CON_ID("shoc_clk", &sh4202_shoc_clk),
-};
-
-int __init arch_clk_init(void)
-{
-	struct clk *clk;
-	int i, ret = 0;
-
-	cpg_clk_init();
-
-	clk = clk_get(NULL, "master_clk");
-	for (i = 0; i < ARRAY_SIZE(sh4202_onchip_clocks); i++) {
-		struct clk *clkp = sh4202_onchip_clocks[i];
-
-		clkp->parent = clk;
-		ret |= clk_register(clkp);
-	}
-
-	clk_put(clk);
-
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	return ret;
-}
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
deleted file mode 100644
index 363463e53d99c..0000000000000
--- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ /dev/null
@@ -1,139 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * SH4-202 Setup
- *
- *  Copyright (C) 2006  Paul Mundt
- *  Copyright (C) 2009  Magnus Damm
- */
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/serial.h>
-#include <linux/serial_sci.h>
-#include <linux/sh_timer.h>
-#include <linux/sh_intc.h>
-#include <linux/io.h>
-#include <asm/platform_early.h>
-
-static struct scif_platform_data scif0_platform_data = {
-	.scscr		= SCSCR_REIE,
-	.type		= PORT_SCIF,
-};
-
-static struct resource scif0_resources[] = {
-	DEFINE_RES_MEM(0xffe80000, 0x100),
-	DEFINE_RES_IRQ(evt2irq(0x700)),
-	DEFINE_RES_IRQ(evt2irq(0x720)),
-	DEFINE_RES_IRQ(evt2irq(0x760)),
-	DEFINE_RES_IRQ(evt2irq(0x740)),
-};
-
-static struct platform_device scif0_device = {
-	.name		= "sh-sci",
-	.id		= 0,
-	.resource	= scif0_resources,
-	.num_resources	= ARRAY_SIZE(scif0_resources),
-	.dev		= {
-		.platform_data	= &scif0_platform_data,
-	},
-};
-
-static struct sh_timer_platform_data tmu0_platform_data = {
-	.channels_mask = 7,
-};
-
-static struct resource tmu0_resources[] = {
-	DEFINE_RES_MEM(0xffd80000, 0x30),
-	DEFINE_RES_IRQ(evt2irq(0x400)),
-	DEFINE_RES_IRQ(evt2irq(0x420)),
-	DEFINE_RES_IRQ(evt2irq(0x440)),
-};
-
-static struct platform_device tmu0_device = {
-	.name		= "sh-tmu",
-	.id		= 0,
-	.dev = {
-		.platform_data	= &tmu0_platform_data,
-	},
-	.resource	= tmu0_resources,
-	.num_resources	= ARRAY_SIZE(tmu0_resources),
-};
-
-static struct platform_device *sh4202_devices[] __initdata = {
-	&scif0_device,
-	&tmu0_device,
-};
-
-static int __init sh4202_devices_setup(void)
-{
-	return platform_add_devices(sh4202_devices,
-				    ARRAY_SIZE(sh4202_devices));
-}
-arch_initcall(sh4202_devices_setup);
-
-static struct platform_device *sh4202_early_devices[] __initdata = {
-	&scif0_device,
-	&tmu0_device,
-};
-
-void __init plat_early_device_setup(void)
-{
-	sh_early_platform_add_devices(sh4202_early_devices,
-				   ARRAY_SIZE(sh4202_early_devices));
-}
-
-enum {
-	UNUSED = 0,
-
-	/* interrupt sources */
-	IRL0, IRL1, IRL2, IRL3, /* only IRLM mode supported */
-	HUDI, TMU0, TMU1, TMU2, RTC, SCIF, WDT,
-};
-
-static struct intc_vect vectors[] __initdata = {
-	INTC_VECT(HUDI, 0x600),
-	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
-	INTC_VECT(TMU2, 0x440), INTC_VECT(TMU2, 0x460),
-	INTC_VECT(RTC, 0x480), INTC_VECT(RTC, 0x4a0),
-	INTC_VECT(RTC, 0x4c0),
-	INTC_VECT(SCIF, 0x700), INTC_VECT(SCIF, 0x720),
-	INTC_VECT(SCIF, 0x740), INTC_VECT(SCIF, 0x760),
-	INTC_VECT(WDT, 0x560),
-};
-
-static struct intc_prio_reg prio_registers[] __initdata = {
-	{ 0xffd00004, 0, 16, 4, /* IPRA */ { TMU0, TMU1, TMU2, RTC } },
-	{ 0xffd00008, 0, 16, 4, /* IPRB */ { WDT, 0, 0, 0 } },
-	{ 0xffd0000c, 0, 16, 4, /* IPRC */ { 0, 0, SCIF, HUDI } },
-	{ 0xffd00010, 0, 16, 4, /* IPRD */ { IRL0, IRL1, IRL2, IRL3 } },
-};
-
-static DECLARE_INTC_DESC(intc_desc, "sh4-202", vectors, NULL,
-			 NULL, prio_registers, NULL);
-
-static struct intc_vect vectors_irlm[] __initdata = {
-	INTC_VECT(IRL0, 0x240), INTC_VECT(IRL1, 0x2a0),
-	INTC_VECT(IRL2, 0x300), INTC_VECT(IRL3, 0x360),
-};
-
-static DECLARE_INTC_DESC(intc_desc_irlm, "sh4-202_irlm", vectors_irlm, NULL,
-			 NULL, prio_registers, NULL);
-
-void __init plat_irq_setup(void)
-{
-	register_intc_controller(&intc_desc);
-}
-
-#define INTC_ICR	0xffd00000UL
-#define INTC_ICR_IRLM   (1<<7)
-
-void __init plat_irq_setup_pins(int mode)
-{
-	switch (mode) {
-	case IRQ_MODE_IRQ: /* individual interrupt mode for IRL3-0 */
-		__raw_writew(__raw_readw(INTC_ICR) | INTC_ICR_IRLM, INTC_ICR);
-		register_intc_controller(&intc_desc_irlm);
-		break;
-	default:
-		BUG();
-	}
-}
-- 
2.39.2

