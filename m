Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D71278E46A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbjHaBb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbjHaBbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:31:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAA7CC9;
        Wed, 30 Aug 2023 18:31:35 -0700 (PDT)
Date:   Thu, 31 Aug 2023 01:31:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693445492;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIEiuq+phcT6zT/bGbnOehllZbVW7EVkwnhzAdsV0Q8=;
        b=UB5URhmcSrmX4t1Wdkw6jnblfXNJquk575OWSr4VvAejqDu1ocP7Cof8QyFqkTETvkLBcY
        /9U+GCxCvrby4bjcW1FYITzrgbg9vvbmctoRUlTdwIY3DHUZPWDOfCYSwVYVYHBIVeRRqj
        LY/E8Cl8cN15xMW7q97AbisPQEkF5IZnmy4YOt24raSBeFo9cWEvnz8gsOOZobtex5OrY7
        DwpXVJxem6aSjMHHsoYV7RcCvT45B4l8dYAJiGhfMwcK6ib02Nryffug3a99O958Pbt9rT
        VcqSERGrujl3ZbWeJE2+9+n4E9lABcxBF36AeGSHxomgJJqiq/r2eUZMMEQTxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693445492;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIEiuq+phcT6zT/bGbnOehllZbVW7EVkwnhzAdsV0Q8=;
        b=HRjE5fKQUiBmZmG5qdX13fJTNVZKnSUozRNsPAXW1H0lcIJo2bpQQDzn30Xn/7lFwYab9q
        p/sNVisvvlySboAg==
From:   "tip-bot2 for Neil Armstrong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-oxnas-rps: Remove
 obsolete timer driver
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-3-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-3-fb6ab3dea87c@linaro.org>
MIME-Version: 1.0
Message-ID: <169344549224.27769.334689179583835411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     56f99cdc5b11a65a19410171b6a84c612778f0c9
Gitweb:        https://git.kernel.org/tip/56f99cdc5b11a65a19410171b6a84c612778f0c9
Author:        Neil Armstrong <neil.armstrong@linaro.org>
AuthorDate:    Fri, 30 Jun 2023 18:58:28 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 13 Jul 2023 14:46:17 +02:00

clocksource/drivers/timer-oxnas-rps: Remove obsolete timer driver

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX810 and OX820 timer.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230630-topic-oxnas-upstream-remove-v2-3-fb6ab3dea87c@linaro.org
---
 drivers/clocksource/Kconfig           |   7 +-
 drivers/clocksource/Makefile          |   1 +-
 drivers/clocksource/timer-oxnas-rps.c | 288 +-------------------------
 3 files changed, 296 deletions(-)
 delete mode 100644 drivers/clocksource/timer-oxnas-rps.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c4d671a..0ba0dc4 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -461,13 +461,6 @@ config VF_PIT_TIMER
 	help
 	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
 
-config OXNAS_RPS_TIMER
-	bool "Oxford Semiconductor OXNAS RPS Timers driver" if COMPILE_TEST
-	select TIMER_OF
-	select CLKSRC_MMIO
-	help
-	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
-
 config SYS_SUPPORTS_SH_CMT
 	bool
 
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5d93c9e..368c346 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_MTK_TIMER)		+= timer-mediatek.o
 obj-$(CONFIG_MTK_CPUX_TIMER)	+= timer-mediatek-cpux.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+= timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+= timer-ti-32k.o
-obj-$(CONFIG_OXNAS_RPS_TIMER)	+= timer-oxnas-rps.o
 obj-$(CONFIG_OWL_TIMER)		+= timer-owl.o
 obj-$(CONFIG_MILBEAUT_TIMER)	+= timer-milbeaut.o
 obj-$(CONFIG_SPRD_TIMER)	+= timer-sprd.o
diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
deleted file mode 100644
index d514b44..0000000
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ /dev/null
@@ -1,288 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * drivers/clocksource/timer-oxnas-rps.c
- *
- * Copyright (C) 2009 Oxford Semiconductor Ltd
- * Copyright (C) 2013 Ma Haijun <mahaijuns@gmail.com>
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
-
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/clockchips.h>
-#include <linux/sched_clock.h>
-
-/* TIMER1 used as tick
- * TIMER2 used as clocksource
- */
-
-/* Registers definitions */
-
-#define TIMER_LOAD_REG		0x0
-#define TIMER_CURR_REG		0x4
-#define TIMER_CTRL_REG		0x8
-#define TIMER_CLRINT_REG	0xC
-
-#define TIMER_BITS		24
-
-#define TIMER_MAX_VAL		(BIT(TIMER_BITS) - 1)
-
-#define TIMER_PERIODIC		BIT(6)
-#define TIMER_ENABLE		BIT(7)
-
-#define TIMER_DIV1		(0)
-#define TIMER_DIV16		(1 << 2)
-#define TIMER_DIV256		(2 << 2)
-
-#define TIMER1_REG_OFFSET	0
-#define TIMER2_REG_OFFSET	0x20
-
-/* Clockevent & Clocksource data */
-
-struct oxnas_rps_timer {
-	struct clock_event_device clkevent;
-	void __iomem *clksrc_base;
-	void __iomem *clkevt_base;
-	unsigned long timer_period;
-	unsigned int timer_prescaler;
-	struct clk *clk;
-	int irq;
-};
-
-static irqreturn_t oxnas_rps_timer_irq(int irq, void *dev_id)
-{
-	struct oxnas_rps_timer *rps = dev_id;
-
-	writel_relaxed(0, rps->clkevt_base + TIMER_CLRINT_REG);
-
-	rps->clkevent.event_handler(&rps->clkevent);
-
-	return IRQ_HANDLED;
-}
-
-static void oxnas_rps_timer_config(struct oxnas_rps_timer *rps,
-				   unsigned long period,
-				   unsigned int periodic)
-{
-	uint32_t cfg = rps->timer_prescaler;
-
-	if (period)
-		cfg |= TIMER_ENABLE;
-
-	if (periodic)
-		cfg |= TIMER_PERIODIC;
-
-	writel_relaxed(period, rps->clkevt_base + TIMER_LOAD_REG);
-	writel_relaxed(cfg, rps->clkevt_base + TIMER_CTRL_REG);
-}
-
-static int oxnas_rps_timer_shutdown(struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, 0, 0);
-
-	return 0;
-}
-
-static int oxnas_rps_timer_set_periodic(struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, rps->timer_period, 1);
-
-	return 0;
-}
-
-static int oxnas_rps_timer_set_oneshot(struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, rps->timer_period, 0);
-
-	return 0;
-}
-
-static int oxnas_rps_timer_next_event(unsigned long delta,
-				struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, delta, 0);
-
-	return 0;
-}
-
-static int __init oxnas_rps_clockevent_init(struct oxnas_rps_timer *rps)
-{
-	ulong clk_rate = clk_get_rate(rps->clk);
-	ulong timer_rate;
-
-	/* Start with prescaler 1 */
-	rps->timer_prescaler = TIMER_DIV1;
-	rps->timer_period = DIV_ROUND_UP(clk_rate, HZ);
-	timer_rate = clk_rate;
-
-	if (rps->timer_period > TIMER_MAX_VAL) {
-		rps->timer_prescaler = TIMER_DIV16;
-		timer_rate = clk_rate / 16;
-		rps->timer_period = DIV_ROUND_UP(timer_rate, HZ);
-	}
-	if (rps->timer_period > TIMER_MAX_VAL) {
-		rps->timer_prescaler = TIMER_DIV256;
-		timer_rate = clk_rate / 256;
-		rps->timer_period = DIV_ROUND_UP(timer_rate, HZ);
-	}
-
-	rps->clkevent.name = "oxnas-rps";
-	rps->clkevent.features = CLOCK_EVT_FEAT_PERIODIC |
-				 CLOCK_EVT_FEAT_ONESHOT |
-				 CLOCK_EVT_FEAT_DYNIRQ;
-	rps->clkevent.tick_resume = oxnas_rps_timer_shutdown;
-	rps->clkevent.set_state_shutdown = oxnas_rps_timer_shutdown;
-	rps->clkevent.set_state_periodic = oxnas_rps_timer_set_periodic;
-	rps->clkevent.set_state_oneshot = oxnas_rps_timer_set_oneshot;
-	rps->clkevent.set_next_event = oxnas_rps_timer_next_event;
-	rps->clkevent.rating = 200;
-	rps->clkevent.cpumask = cpu_possible_mask;
-	rps->clkevent.irq = rps->irq;
-	clockevents_config_and_register(&rps->clkevent,
-					timer_rate,
-					1,
-					TIMER_MAX_VAL);
-
-	pr_info("Registered clock event rate %luHz prescaler %x period %lu\n",
-			clk_rate,
-			rps->timer_prescaler,
-			rps->timer_period);
-
-	return 0;
-}
-
-/* Clocksource */
-
-static void __iomem *timer_sched_base;
-
-static u64 notrace oxnas_rps_read_sched_clock(void)
-{
-	return ~readl_relaxed(timer_sched_base);
-}
-
-static int __init oxnas_rps_clocksource_init(struct oxnas_rps_timer *rps)
-{
-	ulong clk_rate = clk_get_rate(rps->clk);
-	int ret;
-
-	/* use prescale 16 */
-	clk_rate = clk_rate / 16;
-
-	writel_relaxed(TIMER_MAX_VAL, rps->clksrc_base + TIMER_LOAD_REG);
-	writel_relaxed(TIMER_PERIODIC | TIMER_ENABLE | TIMER_DIV16,
-			rps->clksrc_base + TIMER_CTRL_REG);
-
-	timer_sched_base = rps->clksrc_base + TIMER_CURR_REG;
-	sched_clock_register(oxnas_rps_read_sched_clock,
-			     TIMER_BITS, clk_rate);
-	ret = clocksource_mmio_init(timer_sched_base,
-				    "oxnas_rps_clocksource_timer",
-				    clk_rate, 250, TIMER_BITS,
-				    clocksource_mmio_readl_down);
-	if (WARN_ON(ret)) {
-		pr_err("can't register clocksource\n");
-		return ret;
-	}
-
-	pr_info("Registered clocksource rate %luHz\n", clk_rate);
-
-	return 0;
-}
-
-static int __init oxnas_rps_timer_init(struct device_node *np)
-{
-	struct oxnas_rps_timer *rps;
-	void __iomem *base;
-	int ret;
-
-	rps = kzalloc(sizeof(*rps), GFP_KERNEL);
-	if (!rps)
-		return -ENOMEM;
-
-	rps->clk = of_clk_get(np, 0);
-	if (IS_ERR(rps->clk)) {
-		ret = PTR_ERR(rps->clk);
-		goto err_alloc;
-	}
-
-	ret = clk_prepare_enable(rps->clk);
-	if (ret)
-		goto err_clk;
-
-	base = of_iomap(np, 0);
-	if (!base) {
-		ret = -ENXIO;
-		goto err_clk_prepare;
-	}
-
-	rps->irq = irq_of_parse_and_map(np, 0);
-	if (!rps->irq) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
-
-	rps->clkevt_base = base + TIMER1_REG_OFFSET;
-	rps->clksrc_base = base + TIMER2_REG_OFFSET;
-
-	/* Disable timers */
-	writel_relaxed(0, rps->clkevt_base + TIMER_CTRL_REG);
-	writel_relaxed(0, rps->clksrc_base + TIMER_CTRL_REG);
-	writel_relaxed(0, rps->clkevt_base + TIMER_LOAD_REG);
-	writel_relaxed(0, rps->clksrc_base + TIMER_LOAD_REG);
-	writel_relaxed(0, rps->clkevt_base + TIMER_CLRINT_REG);
-	writel_relaxed(0, rps->clksrc_base + TIMER_CLRINT_REG);
-
-	ret = request_irq(rps->irq, oxnas_rps_timer_irq,
-			  IRQF_TIMER | IRQF_IRQPOLL,
-			  "rps-timer", rps);
-	if (ret)
-		goto err_iomap;
-
-	ret = oxnas_rps_clocksource_init(rps);
-	if (ret)
-		goto err_irqreq;
-
-	ret = oxnas_rps_clockevent_init(rps);
-	if (ret)
-		goto err_irqreq;
-
-	return 0;
-
-err_irqreq:
-	free_irq(rps->irq, rps);
-err_iomap:
-	iounmap(base);
-err_clk_prepare:
-	clk_disable_unprepare(rps->clk);
-err_clk:
-	clk_put(rps->clk);
-err_alloc:
-	kfree(rps);
-
-	return ret;
-}
-
-TIMER_OF_DECLARE(ox810se_rps,
-		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
-TIMER_OF_DECLARE(ox820_rps,
-		       "oxsemi,ox820-rps-timer", oxnas_rps_timer_init);
