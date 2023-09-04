Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2293791285
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbjIDHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjIDHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:47:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496A8FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:46:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693813611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tp+GVGIgixSr0fsM82lFy9BO0P9EkyRfUCvw/2GbXy4=;
        b=hwLOz1FaBinSlz85WjuVPkFHrbex2ByuGj3EXtaZKLELj8OKi1V0L/mcQTFq1lQIonX+tb
        RKRx75hanx+ocKJRRBNH+sn1EwTA3dlZ1iYmcZkXS5darYCKrWqYH82hb0mfgEgIqP/olx
        RO98dejx73jKdrG4KnkpNqpwisS50/XkEdOlDeM5dBLuZenzB4/dhCCzphzfQjwghpCHAq
        62ekJp2pn4xT+0JaxcrqR36vGwKFBgb6KoYi1AxACNeO5X9cnPpkyO+unJtNmmZNIqNQJt
        oY/ErTWNbFOD6p+gfPdGGjl236iMRerl0OXuC3zJXayGqcfnymVswyGjkH6xAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693813611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tp+GVGIgixSr0fsM82lFy9BO0P9EkyRfUCvw/2GbXy4=;
        b=kmEJob/qWDgQPmmCrZ8ZQAi+0QgN/6BEsktCu5VnaLkEB1eLa1bzUQzvMDIaKhgqm1tO36
        YyEgBDTGRhWpTJDw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.6-rc1
Message-ID: <169381359147.1522629.3831235635630258619.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon,  4 Sep 2023 09:46:50 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023=
-09-04-v2

up to:  5146e1f589cc: Merge tag 'timers-v6.6-rc1' of https://git.linaro.org/p=
eople/daniel.lezcano/linux into timers/core


Updates for clocksource/clockevent drivers:

  - Remove the OXNAS driver instead of adding a new one!

  - A set of boring fixes, cleanups and improvements


Thanks,

	tglx

------------------>
Mans Rullgard (3):
      clocksource/drivers/sun5i: Remove duplication of code and data
      clocksource/drivers/sun5i: Remove pointless struct
      clocksource/drivers/sun5i: Convert to platform device driver

Neil Armstrong (2):
      clocksource/drivers/timer-oxnas-rps: Remove obsolete timer driver
      dt-bindings: timer: oxsemi,rps-timer: remove obsolete bindings

Rob Herring (1):
      clocksource: Explicitly include correct DT includes

Tom Rix (1):
      clocksource/drivers/loongson1: Set variable ls1x_timer_lock storage-cla=
ss-specifier to static

Walter Chang (1):
      clocksource/drivers/arm_arch_timer: Disable timer before programming CV=
AL


 .../devicetree/bindings/timer/oxsemi,rps-timer.txt |  17 --
 drivers/clocksource/Kconfig                        |   7 -
 drivers/clocksource/Makefile                       |   1 -
 drivers/clocksource/arm_arch_timer.c               |   7 +
 drivers/clocksource/bcm2835_timer.c                |   2 +-
 drivers/clocksource/nomadik-mtu.c                  |   2 +-
 drivers/clocksource/sh_cmt.c                       |   1 -
 drivers/clocksource/timer-cadence-ttc.c            |   1 +
 drivers/clocksource/timer-gxp.c                    |   1 +
 drivers/clocksource/timer-integrator-ap.c          |   2 +-
 drivers/clocksource/timer-loongson1-pwm.c          |   2 +-
 drivers/clocksource/timer-oxnas-rps.c              | 288 -------------------=
--
 drivers/clocksource/timer-sun5i.c                  | 288 +++++++++----------=
--
 drivers/clocksource/timer-tegra186.c               |   1 -
 drivers/clocksource/timer-ti-dm.c                  |   1 -
 15 files changed, 136 insertions(+), 485 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/oxsemi,rps-timer.=
txt
 delete mode 100644 drivers/clocksource/timer-oxnas-rps.c

diff --git a/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt b/D=
ocumentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
deleted file mode 100644
index d191612539e8..000000000000
--- a/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family RPS Timer
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-Required properties:
-- compatible: Should be "oxsemi,ox810se-rps-timer" or "oxsemi,ox820-rps-time=
r"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : The interrupts of the two timers
-- clocks : The phandle of the timer clock source
-
-example:
-
-timer0: timer@200 {
-	compatible =3D "oxsemi,ox810se-rps-timer";
-	reg =3D <0x200 0x40>;
-	clocks =3D <&rpsclk>;
-	interrupts =3D <4 5>;
-};
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c4d671a5a13d..0ba0dc4ecf06 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -461,13 +461,6 @@ config VF_PIT_TIMER
 	help
 	  Support for Periodic Interrupt Timer on Freescale Vybrid Family SoCs.
=20
-config OXNAS_RPS_TIMER
-	bool "Oxford Semiconductor OXNAS RPS Timers driver" if COMPILE_TEST
-	select TIMER_OF
-	select CLKSRC_MMIO
-	help
-	  This enables support for the Oxford Semiconductor OXNAS RPS timers.
-
 config SYS_SUPPORTS_SH_CMT
 	bool
=20
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 5d93c9e3fc55..368c3461dab8 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -54,7 +54,6 @@ obj-$(CONFIG_MTK_TIMER)		+=3D timer-mediatek.o
 obj-$(CONFIG_MTK_CPUX_TIMER)	+=3D timer-mediatek-cpux.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+=3D timer-pistachio.o
 obj-$(CONFIG_CLKSRC_TI_32K)	+=3D timer-ti-32k.o
-obj-$(CONFIG_OXNAS_RPS_TIMER)	+=3D timer-oxnas-rps.o
 obj-$(CONFIG_OWL_TIMER)		+=3D timer-owl.o
 obj-$(CONFIG_MILBEAUT_TIMER)	+=3D timer-milbeaut.o
 obj-$(CONFIG_SPRD_TIMER)	+=3D timer-sprd.o
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_a=
rch_timer.c
index e09d4427f604..f6c5f8916e59 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -774,6 +774,13 @@ static __always_inline void set_next_event_mem(const int=
 access, unsigned long e
 	u64 cnt;
=20
 	ctrl =3D arch_timer_reg_read(access, ARCH_TIMER_REG_CTRL, clk);
+
+	/* Timer must be disabled before programming CVAL */
+	if (ctrl & ARCH_TIMER_CTRL_ENABLE) {
+		ctrl &=3D ~ARCH_TIMER_CTRL_ENABLE;
+		arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
+	}
+
 	ctrl |=3D ARCH_TIMER_CTRL_ENABLE;
 	ctrl &=3D ~ARCH_TIMER_CTRL_IT_MASK;
=20
diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm283=
5_timer.c
index 1592650b2c92..319c0c780a15 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -10,9 +10,9 @@
 #include <linux/irqreturn.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sched_clock.h>
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-=
mtu.c
index 1cf3304652d6..53d0159cc6be 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -10,9 +10,9 @@
 #include <linux/io.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index e81c588d9afe..26919556ef5f 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -18,7 +18,6 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/ti=
mer-cadence-ttc.c
index 0d52e28fea4d..32daaac9b132 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -13,6 +13,7 @@
 #include <linux/clocksource.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sched_clock.h>
 #include <linux/module.h>
diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
index fe4fa8d7b3f1..57aa2e2cce53 100644
--- a/drivers/clocksource/timer-gxp.c
+++ b/drivers/clocksource/timer-gxp.c
@@ -8,6 +8,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/sched_clock.h>
=20
 #define TIMER0_FREQ	1000000
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/=
timer-integrator-ap.c
index b0fcbaac58b0..a4c700b11dc0 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -7,9 +7,9 @@
=20
 #include <linux/clk.h>
 #include <linux/clocksource.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/sched_clock.h>
diff --git a/drivers/clocksource/timer-loongson1-pwm.c b/drivers/clocksource/=
timer-loongson1-pwm.c
index 6335fee03017..244d66835508 100644
--- a/drivers/clocksource/timer-loongson1-pwm.c
+++ b/drivers/clocksource/timer-loongson1-pwm.c
@@ -28,7 +28,7 @@
=20
 #define CNTR_WIDTH		24
=20
-DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
+static DEFINE_RAW_SPINLOCK(ls1x_timer_lock);
=20
 struct ls1x_clocksource {
 	void __iomem *reg_base;
diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/time=
r-oxnas-rps.c
deleted file mode 100644
index d514b44e67dd..000000000000
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
-	struct oxnas_rps_timer *rps =3D dev_id;
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
-	uint32_t cfg =3D rps->timer_prescaler;
-
-	if (period)
-		cfg |=3D TIMER_ENABLE;
-
-	if (periodic)
-		cfg |=3D TIMER_PERIODIC;
-
-	writel_relaxed(period, rps->clkevt_base + TIMER_LOAD_REG);
-	writel_relaxed(cfg, rps->clkevt_base + TIMER_CTRL_REG);
-}
-
-static int oxnas_rps_timer_shutdown(struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =3D
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, 0, 0);
-
-	return 0;
-}
-
-static int oxnas_rps_timer_set_periodic(struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =3D
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, rps->timer_period, 1);
-
-	return 0;
-}
-
-static int oxnas_rps_timer_set_oneshot(struct clock_event_device *evt)
-{
-	struct oxnas_rps_timer *rps =3D
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
-	struct oxnas_rps_timer *rps =3D
-		container_of(evt, struct oxnas_rps_timer, clkevent);
-
-	oxnas_rps_timer_config(rps, delta, 0);
-
-	return 0;
-}
-
-static int __init oxnas_rps_clockevent_init(struct oxnas_rps_timer *rps)
-{
-	ulong clk_rate =3D clk_get_rate(rps->clk);
-	ulong timer_rate;
-
-	/* Start with prescaler 1 */
-	rps->timer_prescaler =3D TIMER_DIV1;
-	rps->timer_period =3D DIV_ROUND_UP(clk_rate, HZ);
-	timer_rate =3D clk_rate;
-
-	if (rps->timer_period > TIMER_MAX_VAL) {
-		rps->timer_prescaler =3D TIMER_DIV16;
-		timer_rate =3D clk_rate / 16;
-		rps->timer_period =3D DIV_ROUND_UP(timer_rate, HZ);
-	}
-	if (rps->timer_period > TIMER_MAX_VAL) {
-		rps->timer_prescaler =3D TIMER_DIV256;
-		timer_rate =3D clk_rate / 256;
-		rps->timer_period =3D DIV_ROUND_UP(timer_rate, HZ);
-	}
-
-	rps->clkevent.name =3D "oxnas-rps";
-	rps->clkevent.features =3D CLOCK_EVT_FEAT_PERIODIC |
-				 CLOCK_EVT_FEAT_ONESHOT |
-				 CLOCK_EVT_FEAT_DYNIRQ;
-	rps->clkevent.tick_resume =3D oxnas_rps_timer_shutdown;
-	rps->clkevent.set_state_shutdown =3D oxnas_rps_timer_shutdown;
-	rps->clkevent.set_state_periodic =3D oxnas_rps_timer_set_periodic;
-	rps->clkevent.set_state_oneshot =3D oxnas_rps_timer_set_oneshot;
-	rps->clkevent.set_next_event =3D oxnas_rps_timer_next_event;
-	rps->clkevent.rating =3D 200;
-	rps->clkevent.cpumask =3D cpu_possible_mask;
-	rps->clkevent.irq =3D rps->irq;
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
-	ulong clk_rate =3D clk_get_rate(rps->clk);
-	int ret;
-
-	/* use prescale 16 */
-	clk_rate =3D clk_rate / 16;
-
-	writel_relaxed(TIMER_MAX_VAL, rps->clksrc_base + TIMER_LOAD_REG);
-	writel_relaxed(TIMER_PERIODIC | TIMER_ENABLE | TIMER_DIV16,
-			rps->clksrc_base + TIMER_CTRL_REG);
-
-	timer_sched_base =3D rps->clksrc_base + TIMER_CURR_REG;
-	sched_clock_register(oxnas_rps_read_sched_clock,
-			     TIMER_BITS, clk_rate);
-	ret =3D clocksource_mmio_init(timer_sched_base,
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
-	rps =3D kzalloc(sizeof(*rps), GFP_KERNEL);
-	if (!rps)
-		return -ENOMEM;
-
-	rps->clk =3D of_clk_get(np, 0);
-	if (IS_ERR(rps->clk)) {
-		ret =3D PTR_ERR(rps->clk);
-		goto err_alloc;
-	}
-
-	ret =3D clk_prepare_enable(rps->clk);
-	if (ret)
-		goto err_clk;
-
-	base =3D of_iomap(np, 0);
-	if (!base) {
-		ret =3D -ENXIO;
-		goto err_clk_prepare;
-	}
-
-	rps->irq =3D irq_of_parse_and_map(np, 0);
-	if (!rps->irq) {
-		ret =3D -EINVAL;
-		goto err_iomap;
-	}
-
-	rps->clkevt_base =3D base + TIMER1_REG_OFFSET;
-	rps->clksrc_base =3D base + TIMER2_REG_OFFSET;
-
-	/* Disable timers */
-	writel_relaxed(0, rps->clkevt_base + TIMER_CTRL_REG);
-	writel_relaxed(0, rps->clksrc_base + TIMER_CTRL_REG);
-	writel_relaxed(0, rps->clkevt_base + TIMER_LOAD_REG);
-	writel_relaxed(0, rps->clksrc_base + TIMER_LOAD_REG);
-	writel_relaxed(0, rps->clkevt_base + TIMER_CLRINT_REG);
-	writel_relaxed(0, rps->clksrc_base + TIMER_CLRINT_REG);
-
-	ret =3D request_irq(rps->irq, oxnas_rps_timer_irq,
-			  IRQF_TIMER | IRQF_IRQPOLL,
-			  "rps-timer", rps);
-	if (ret)
-		goto err_iomap;
-
-	ret =3D oxnas_rps_clocksource_init(rps);
-	if (ret)
-		goto err_irqreq;
-
-	ret =3D oxnas_rps_clockevent_init(rps);
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
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-su=
n5i.c
index 7d5fa9069906..69fee3540d37 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -16,9 +16,7 @@
 #include <linux/irqreturn.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
+#include <linux/platform_device.h>
=20
 #define TIMER_IRQ_EN_REG		0x00
 #define TIMER_IRQ_EN(val)			BIT(val)
@@ -40,26 +38,16 @@ struct sun5i_timer {
 	struct clk		*clk;
 	struct notifier_block	clk_rate_cb;
 	u32			ticks_per_jiffy;
-};
-
-#define to_sun5i_timer(x) \
-	container_of(x, struct sun5i_timer, clk_rate_cb)
-
-struct sun5i_timer_clksrc {
-	struct sun5i_timer	timer;
 	struct clocksource	clksrc;
-};
-
-#define to_sun5i_timer_clksrc(x) \
-	container_of(x, struct sun5i_timer_clksrc, clksrc)
-
-struct sun5i_timer_clkevt {
-	struct sun5i_timer		timer;
 	struct clock_event_device	clkevt;
 };
=20
-#define to_sun5i_timer_clkevt(x) \
-	container_of(x, struct sun5i_timer_clkevt, clkevt)
+#define nb_to_sun5i_timer(x) \
+	container_of(x, struct sun5i_timer, clk_rate_cb)
+#define clksrc_to_sun5i_timer(x) \
+	container_of(x, struct sun5i_timer, clksrc)
+#define clkevt_to_sun5i_timer(x) \
+	container_of(x, struct sun5i_timer, clkevt)
=20
 /*
  * When we disable a timer, we need to wait at least for 2 cycles of
@@ -67,30 +55,30 @@ struct sun5i_timer_clkevt {
  * that is already setup and runs at the same frequency than the other
  * timers, and we never will be disabled.
  */
-static void sun5i_clkevt_sync(struct sun5i_timer_clkevt *ce)
+static void sun5i_clkevt_sync(struct sun5i_timer *ce)
 {
-	u32 old =3D readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1));
+	u32 old =3D readl(ce->base + TIMER_CNTVAL_LO_REG(1));
=20
-	while ((old - readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1))) < TIMER_SYNC_=
TICKS)
+	while ((old - readl(ce->base + TIMER_CNTVAL_LO_REG(1))) < TIMER_SYNC_TICKS)
 		cpu_relax();
 }
=20
-static void sun5i_clkevt_time_stop(struct sun5i_timer_clkevt *ce, u8 timer)
+static void sun5i_clkevt_time_stop(struct sun5i_timer *ce, u8 timer)
 {
-	u32 val =3D readl(ce->timer.base + TIMER_CTL_REG(timer));
-	writel(val & ~TIMER_CTL_ENABLE, ce->timer.base + TIMER_CTL_REG(timer));
+	u32 val =3D readl(ce->base + TIMER_CTL_REG(timer));
+	writel(val & ~TIMER_CTL_ENABLE, ce->base + TIMER_CTL_REG(timer));
=20
 	sun5i_clkevt_sync(ce);
 }
=20
-static void sun5i_clkevt_time_setup(struct sun5i_timer_clkevt *ce, u8 timer,=
 u32 delay)
+static void sun5i_clkevt_time_setup(struct sun5i_timer *ce, u8 timer, u32 de=
lay)
 {
-	writel(delay, ce->timer.base + TIMER_INTVAL_LO_REG(timer));
+	writel(delay, ce->base + TIMER_INTVAL_LO_REG(timer));
 }
=20
-static void sun5i_clkevt_time_start(struct sun5i_timer_clkevt *ce, u8 timer,=
 bool periodic)
+static void sun5i_clkevt_time_start(struct sun5i_timer *ce, u8 timer, bool p=
eriodic)
 {
-	u32 val =3D readl(ce->timer.base + TIMER_CTL_REG(timer));
+	u32 val =3D readl(ce->base + TIMER_CTL_REG(timer));
=20
 	if (periodic)
 		val &=3D ~TIMER_CTL_ONESHOT;
@@ -98,12 +86,12 @@ static void sun5i_clkevt_time_start(struct sun5i_timer_cl=
kevt *ce, u8 timer, boo
 		val |=3D TIMER_CTL_ONESHOT;
=20
 	writel(val | TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
-	       ce->timer.base + TIMER_CTL_REG(timer));
+	       ce->base + TIMER_CTL_REG(timer));
 }
=20
 static int sun5i_clkevt_shutdown(struct clock_event_device *clkevt)
 {
-	struct sun5i_timer_clkevt *ce =3D to_sun5i_timer_clkevt(clkevt);
+	struct sun5i_timer *ce =3D clkevt_to_sun5i_timer(clkevt);
=20
 	sun5i_clkevt_time_stop(ce, 0);
 	return 0;
@@ -111,7 +99,7 @@ static int sun5i_clkevt_shutdown(struct clock_event_device=
 *clkevt)
=20
 static int sun5i_clkevt_set_oneshot(struct clock_event_device *clkevt)
 {
-	struct sun5i_timer_clkevt *ce =3D to_sun5i_timer_clkevt(clkevt);
+	struct sun5i_timer *ce =3D clkevt_to_sun5i_timer(clkevt);
=20
 	sun5i_clkevt_time_stop(ce, 0);
 	sun5i_clkevt_time_start(ce, 0, false);
@@ -120,10 +108,10 @@ static int sun5i_clkevt_set_oneshot(struct clock_event_=
device *clkevt)
=20
 static int sun5i_clkevt_set_periodic(struct clock_event_device *clkevt)
 {
-	struct sun5i_timer_clkevt *ce =3D to_sun5i_timer_clkevt(clkevt);
+	struct sun5i_timer *ce =3D clkevt_to_sun5i_timer(clkevt);
=20
 	sun5i_clkevt_time_stop(ce, 0);
-	sun5i_clkevt_time_setup(ce, 0, ce->timer.ticks_per_jiffy);
+	sun5i_clkevt_time_setup(ce, 0, ce->ticks_per_jiffy);
 	sun5i_clkevt_time_start(ce, 0, true);
 	return 0;
 }
@@ -131,7 +119,7 @@ static int sun5i_clkevt_set_periodic(struct clock_event_d=
evice *clkevt)
 static int sun5i_clkevt_next_event(unsigned long evt,
 				   struct clock_event_device *clkevt)
 {
-	struct sun5i_timer_clkevt *ce =3D to_sun5i_timer_clkevt(clkevt);
+	struct sun5i_timer *ce =3D clkevt_to_sun5i_timer(clkevt);
=20
 	sun5i_clkevt_time_stop(ce, 0);
 	sun5i_clkevt_time_setup(ce, 0, evt - TIMER_SYNC_TICKS);
@@ -142,9 +130,9 @@ static int sun5i_clkevt_next_event(unsigned long evt,
=20
 static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
 {
-	struct sun5i_timer_clkevt *ce =3D dev_id;
+	struct sun5i_timer *ce =3D dev_id;
=20
-	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
+	writel(0x1, ce->base + TIMER_IRQ_ST_REG);
 	ce->clkevt.event_handler(&ce->clkevt);
=20
 	return IRQ_HANDLED;
@@ -152,17 +140,16 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void =
*dev_id)
=20
 static u64 sun5i_clksrc_read(struct clocksource *clksrc)
 {
-	struct sun5i_timer_clksrc *cs =3D to_sun5i_timer_clksrc(clksrc);
+	struct sun5i_timer *cs =3D clksrc_to_sun5i_timer(clksrc);
=20
-	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
+	return ~readl(cs->base + TIMER_CNTVAL_LO_REG(1));
 }
=20
-static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
-				unsigned long event, void *data)
+static int sun5i_rate_cb(struct notifier_block *nb,
+			 unsigned long event, void *data)
 {
 	struct clk_notifier_data *ndata =3D data;
-	struct sun5i_timer *timer =3D to_sun5i_timer(nb);
-	struct sun5i_timer_clksrc *cs =3D container_of(timer, struct sun5i_timer_cl=
ksrc, timer);
+	struct sun5i_timer *cs =3D nb_to_sun5i_timer(nb);
=20
 	switch (event) {
 	case PRE_RATE_CHANGE:
@@ -171,6 +158,8 @@ static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
=20
 	case POST_RATE_CHANGE:
 		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
+		clockevents_update_freq(&cs->clkevt, ndata->new_rate);
+		cs->ticks_per_jiffy =3D DIV_ROUND_UP(ndata->new_rate, HZ);
 		break;
=20
 	default:
@@ -180,47 +169,18 @@ static int sun5i_rate_cb_clksrc(struct notifier_block *=
nb,
 	return NOTIFY_DONE;
 }
=20
-static int __init sun5i_setup_clocksource(struct device_node *node,
-					  void __iomem *base,
-					  struct clk *clk, int irq)
+static int sun5i_setup_clocksource(struct platform_device *pdev,
+				   unsigned long rate)
 {
-	struct sun5i_timer_clksrc *cs;
-	unsigned long rate;
+	struct sun5i_timer *cs =3D platform_get_drvdata(pdev);
+	void __iomem *base =3D cs->base;
 	int ret;
=20
-	cs =3D kzalloc(sizeof(*cs), GFP_KERNEL);
-	if (!cs)
-		return -ENOMEM;
-
-	ret =3D clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Couldn't enable parent clock\n");
-		goto err_free;
-	}
-
-	rate =3D clk_get_rate(clk);
-	if (!rate) {
-		pr_err("Couldn't get parent clock rate\n");
-		ret =3D -EINVAL;
-		goto err_disable_clk;
-	}
-
-	cs->timer.base =3D base;
-	cs->timer.clk =3D clk;
-	cs->timer.clk_rate_cb.notifier_call =3D sun5i_rate_cb_clksrc;
-	cs->timer.clk_rate_cb.next =3D NULL;
-
-	ret =3D clk_notifier_register(clk, &cs->timer.clk_rate_cb);
-	if (ret) {
-		pr_err("Unable to register clock notifier.\n");
-		goto err_disable_clk;
-	}
-
 	writel(~0, base + TIMER_INTVAL_LO_REG(1));
 	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
 	       base + TIMER_CTL_REG(1));
=20
-	cs->clksrc.name =3D node->name;
+	cs->clksrc.name =3D pdev->dev.of_node->name;
 	cs->clksrc.rating =3D 340;
 	cs->clksrc.read =3D sun5i_clksrc_read;
 	cs->clksrc.mask =3D CLOCKSOURCE_MASK(32);
@@ -228,74 +188,23 @@ static int __init sun5i_setup_clocksource(struct device=
_node *node,
=20
 	ret =3D clocksource_register_hz(&cs->clksrc, rate);
 	if (ret) {
-		pr_err("Couldn't register clock source.\n");
-		goto err_remove_notifier;
+		dev_err(&pdev->dev, "Couldn't register clock source.\n");
+		return ret;
 	}
=20
 	return 0;
-
-err_remove_notifier:
-	clk_notifier_unregister(clk, &cs->timer.clk_rate_cb);
-err_disable_clk:
-	clk_disable_unprepare(clk);
-err_free:
-	kfree(cs);
-	return ret;
 }
=20
-static int sun5i_rate_cb_clkevt(struct notifier_block *nb,
-				unsigned long event, void *data)
+static int sun5i_setup_clockevent(struct platform_device *pdev,
+				  unsigned long rate, int irq)
 {
-	struct clk_notifier_data *ndata =3D data;
-	struct sun5i_timer *timer =3D to_sun5i_timer(nb);
-	struct sun5i_timer_clkevt *ce =3D container_of(timer, struct sun5i_timer_cl=
kevt, timer);
-
-	if (event =3D=3D POST_RATE_CHANGE) {
-		clockevents_update_freq(&ce->clkevt, ndata->new_rate);
-		ce->timer.ticks_per_jiffy =3D DIV_ROUND_UP(ndata->new_rate, HZ);
-	}
-
-	return NOTIFY_DONE;
-}
-
-static int __init sun5i_setup_clockevent(struct device_node *node, void __io=
mem *base,
-					 struct clk *clk, int irq)
-{
-	struct sun5i_timer_clkevt *ce;
-	unsigned long rate;
+	struct device *dev =3D &pdev->dev;
+	struct sun5i_timer *ce =3D platform_get_drvdata(pdev);
+	void __iomem *base =3D ce->base;
 	int ret;
 	u32 val;
=20
-	ce =3D kzalloc(sizeof(*ce), GFP_KERNEL);
-	if (!ce)
-		return -ENOMEM;
-
-	ret =3D clk_prepare_enable(clk);
-	if (ret) {
-		pr_err("Couldn't enable parent clock\n");
-		goto err_free;
-	}
-
-	rate =3D clk_get_rate(clk);
-	if (!rate) {
-		pr_err("Couldn't get parent clock rate\n");
-		ret =3D -EINVAL;
-		goto err_disable_clk;
-	}
-
-	ce->timer.base =3D base;
-	ce->timer.ticks_per_jiffy =3D DIV_ROUND_UP(rate, HZ);
-	ce->timer.clk =3D clk;
-	ce->timer.clk_rate_cb.notifier_call =3D sun5i_rate_cb_clkevt;
-	ce->timer.clk_rate_cb.next =3D NULL;
-
-	ret =3D clk_notifier_register(clk, &ce->timer.clk_rate_cb);
-	if (ret) {
-		pr_err("Unable to register clock notifier.\n");
-		goto err_disable_clk;
-	}
-
-	ce->clkevt.name =3D node->name;
+	ce->clkevt.name =3D dev->of_node->name;
 	ce->clkevt.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
 	ce->clkevt.set_next_event =3D sun5i_clkevt_next_event;
 	ce->clkevt.set_state_shutdown =3D sun5i_clkevt_shutdown;
@@ -313,60 +222,109 @@ static int __init sun5i_setup_clockevent(struct device=
_node *node, void __iomem
 	clockevents_config_and_register(&ce->clkevt, rate,
 					TIMER_SYNC_TICKS, 0xffffffff);
=20
-	ret =3D request_irq(irq, sun5i_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
-			  "sun5i_timer0", ce);
+	ret =3D devm_request_irq(dev, irq, sun5i_timer_interrupt,
+			       IRQF_TIMER | IRQF_IRQPOLL,
+			       "sun5i_timer0", ce);
 	if (ret) {
-		pr_err("Unable to register interrupt\n");
-		goto err_remove_notifier;
+		dev_err(dev, "Unable to register interrupt\n");
+		return ret;
 	}
=20
 	return 0;
-
-err_remove_notifier:
-	clk_notifier_unregister(clk, &ce->timer.clk_rate_cb);
-err_disable_clk:
-	clk_disable_unprepare(clk);
-err_free:
-	kfree(ce);
-	return ret;
 }
=20
-static int __init sun5i_timer_init(struct device_node *node)
+static int sun5i_timer_probe(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
+	struct sun5i_timer *st;
 	struct reset_control *rstc;
 	void __iomem *timer_base;
 	struct clk *clk;
+	unsigned long rate;
 	int irq, ret;
=20
-	timer_base =3D of_io_request_and_map(node, 0, of_node_full_name(node));
+	st =3D devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, st);
+
+	timer_base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer_base)) {
-		pr_err("Can't map registers\n");
+		dev_err(dev, "Can't map registers\n");
 		return PTR_ERR(timer_base);
 	}
=20
-	irq =3D irq_of_parse_and_map(node, 0);
-	if (irq <=3D 0) {
-		pr_err("Can't parse IRQ\n");
-		return -EINVAL;
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(dev, "Can't get IRQ\n");
+		return irq;
 	}
=20
-	clk =3D of_clk_get(node, 0);
+	clk =3D devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
-		pr_err("Can't get timer clock\n");
+		dev_err(dev, "Can't get timer clock\n");
 		return PTR_ERR(clk);
 	}
=20
-	rstc =3D of_reset_control_get(node, NULL);
-	if (!IS_ERR(rstc))
+	rate =3D clk_get_rate(clk);
+	if (!rate) {
+		dev_err(dev, "Couldn't get parent clock rate\n");
+		return -EINVAL;
+	}
+
+	st->base =3D timer_base;
+	st->ticks_per_jiffy =3D DIV_ROUND_UP(rate, HZ);
+	st->clk =3D clk;
+	st->clk_rate_cb.notifier_call =3D sun5i_rate_cb;
+	st->clk_rate_cb.next =3D NULL;
+
+	ret =3D devm_clk_notifier_register(dev, clk, &st->clk_rate_cb);
+	if (ret) {
+		dev_err(dev, "Unable to register clock notifier.\n");
+		return ret;
+	}
+
+	rstc =3D devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (rstc)
 		reset_control_deassert(rstc);
=20
-	ret =3D sun5i_setup_clocksource(node, timer_base, clk, irq);
+	ret =3D sun5i_setup_clocksource(pdev, rate);
 	if (ret)
 		return ret;
=20
-	return sun5i_setup_clockevent(node, timer_base, clk, irq);
+	ret =3D sun5i_setup_clockevent(pdev, rate, irq);
+	if (ret)
+		goto err_unreg_clocksource;
+
+	return 0;
+
+err_unreg_clocksource:
+	clocksource_unregister(&st->clksrc);
+	return ret;
 }
-TIMER_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
-			   sun5i_timer_init);
-TIMER_OF_DECLARE(sun7i_a20, "allwinner,sun7i-a20-hstimer",
-			   sun5i_timer_init);
+
+static void sun5i_timer_remove(struct platform_device *pdev)
+{
+	struct sun5i_timer *st =3D platform_get_drvdata(pdev);
+
+	clocksource_unregister(&st->clksrc);
+}
+
+static const struct of_device_id sun5i_timer_of_match[] =3D {
+	{ .compatible =3D "allwinner,sun5i-a13-hstimer" },
+	{ .compatible =3D "allwinner,sun7i-a20-hstimer" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sun5i_timer_of_match);
+
+static struct platform_driver sun5i_timer_driver =3D {
+	.probe		=3D sun5i_timer_probe,
+	.remove_new	=3D sun5i_timer_remove,
+	.driver	=3D {
+		.name	=3D "sun5i-timer",
+		.of_match_table =3D sun5i_timer_of_match,
+		.suppress_bind_attrs =3D true,
+	},
+};
+module_platform_driver(sun5i_timer_driver);
diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer=
-tegra186.c
index 83d08591ea0a..304537dadf2c 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -8,7 +8,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/watchdog.h>
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index 349236a7ba5f..09ab29cb7f64 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -27,7 +27,6 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/dmtimer-omap.h>
=20

