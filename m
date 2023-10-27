Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51E37DA043
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346481AbjJ0SZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjJ0SYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:24:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D54D4E;
        Fri, 27 Oct 2023 11:23:12 -0700 (PDT)
Date:   Fri, 27 Oct 2023 18:23:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698430990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EtuwNvjYmrmKjIndQnel/Zqyos67i9d07g6BJTyNyx0=;
        b=OCzPgymhkFHsmA3WYP+Dxq/htZGO7yy+ZEtNco80tr4KEgXF2rMq/mi5edvk3XSO5y6+ab
        XbUYcwE5786tRExK9G0UcoCiLV63G4UCZsU+FYBfF7xHcIrF6670iQ5Eg4wdK+vYdoFiHf
        xwSP6af8dVEkrIbsRuH0TY9icC1OoGCsGALta3hinF5JbgHxqvdJSuOD4ExbPpydq/WhOn
        Of2+IlSbDXwSuIdrRd8xz7EL1ZchtXV1HBj4gZJhw/QqfjMW4nf6w0ntWXf1OG2tURNhkH
        mZ7k+DG/ZqGw6pxwcHaSP3drs3ePBIMknd1L9KFCwPIPnMSMJAnbiKfo9hSP6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698430990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EtuwNvjYmrmKjIndQnel/Zqyos67i9d07g6BJTyNyx0=;
        b=uYIFqa6QBL6GuKC1NdG01vv/RBad7O2ndjcKP/4aBmsfGCGt/QkQ9HF9ijLuYuC1VwAutW
        D6gzqMDuJLkDmxDg==
From:   "tip-bot2 for Nikita Shubin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource: ep93xx: Add driver for Cirrus Logic EP93xx
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230915-ep93xx-v4-12-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-12-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Message-ID: <169843098960.3135.14772167761061883486.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c28ca80ba3b531a79402d61046aef83272f86b08
Gitweb:        https://git.kernel.org/tip/c28ca80ba3b531a79402d61046aef83272f86b08
Author:        Nikita Shubin <nikita.shubin@maquefel.me>
AuthorDate:    Fri, 15 Sep 2023 11:10:54 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sun, 15 Oct 2023 23:36:36 +02:00

clocksource: ep93xx: Add driver for Cirrus Logic EP93xx

Rewrite EP93xx timer driver located in arch/arm/mach-ep93xx/timer-ep93xx.c
trying to do everything the device tree way:

- Make every IO-access relative to a base address and dynamic
  so we can do a dynamic ioremap and get going.
- Find register range and interrupt from the device tree.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230915-ep93xx-v4-12-a1d779dcec10@maquefel.me
---
 drivers/clocksource/Kconfig        |  11 ++-
 drivers/clocksource/Makefile       |   1 +-
 drivers/clocksource/timer-ep93xx.c | 190 ++++++++++++++++++++++++++++-
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/clocksource/timer-ep93xx.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0ba0dc4..34faa03 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -732,4 +732,15 @@ config GOLDFISH_TIMER
 	help
 	  Support for the timer/counter of goldfish-rtc
 
+config EP93XX_TIMER
+	bool "Cirrus Logic ep93xx timer driver" if COMPILE_TEST
+	depends on ARCH_EP93XX
+	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  Enables support for the Cirrus Logic timer block
+	  EP93XX.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 368c346..4bb856e 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_MSC313E_TIMER)		+= timer-msc313e.o
 obj-$(CONFIG_GOLDFISH_TIMER)		+= timer-goldfish.o
 obj-$(CONFIG_GXP_TIMER)			+= timer-gxp.o
 obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+= timer-loongson1-pwm.o
+obj-$(CONFIG_EP93XX_TIMER)		+= timer-ep93xx.o
diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-ep93xx.c
new file mode 100644
index 0000000..bc0ca6e
--- /dev/null
+++ b/drivers/clocksource/timer-ep93xx.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cirrus Logic EP93xx timer driver.
+ * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * Based on a rewrite of arch/arm/mach-ep93xx/timer.c:
+ */
+
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#include <asm/mach/time.h>
+
+/*************************************************************************
+ * Timer handling for EP93xx
+ *************************************************************************
+ * The ep93xx has four internal timers.  Timers 1, 2 (both 16 bit) and
+ * 3 (32 bit) count down at 508 kHz, are self-reloading, and can generate
+ * an interrupt on underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,
+ * is free-running, and can't generate interrupts.
+ *
+ * The 508 kHz timers are ideal for use for the timer interrupt, as the
+ * most common values of HZ divide 508 kHz nicely.  We pick the 32 bit
+ * timer (timer 3) to get as long sleep intervals as possible when using
+ * CONFIG_NO_HZ.
+ *
+ * The higher clock rate of timer 4 makes it a better choice than the
+ * other timers for use as clock source and for sched_clock(), providing
+ * a stable 40 bit time base.
+ *************************************************************************
+ */
+
+#define EP93XX_TIMER1_LOAD		0x00
+#define EP93XX_TIMER1_VALUE		0x04
+#define EP93XX_TIMER1_CONTROL		0x08
+#define EP93XX_TIMER123_CONTROL_ENABLE	BIT(7)
+#define EP93XX_TIMER123_CONTROL_MODE	BIT(6)
+#define EP93XX_TIMER123_CONTROL_CLKSEL	BIT(3)
+#define EP93XX_TIMER1_CLEAR		0x0c
+#define EP93XX_TIMER2_LOAD		0x20
+#define EP93XX_TIMER2_VALUE		0x24
+#define EP93XX_TIMER2_CONTROL		0x28
+#define EP93XX_TIMER2_CLEAR		0x2c
+/*
+ * This read-only register contains the low word of the time stamp debug timer
+ * ( Timer4). When this register is read, the high byte of the Timer4 counter is
+ * saved in the Timer4ValueHigh register.
+ */
+#define EP93XX_TIMER4_VALUE_LOW		0x60
+#define EP93XX_TIMER4_VALUE_HIGH	0x64
+#define EP93XX_TIMER4_VALUE_HIGH_ENABLE	BIT(8)
+#define EP93XX_TIMER3_LOAD		0x80
+#define EP93XX_TIMER3_VALUE		0x84
+#define EP93XX_TIMER3_CONTROL		0x88
+#define EP93XX_TIMER3_CLEAR		0x8c
+
+#define EP93XX_TIMER123_RATE		508469
+#define EP93XX_TIMER4_RATE		983040
+
+struct ep93xx_tcu {
+	void __iomem *base;
+};
+
+static struct ep93xx_tcu *ep93xx_tcu;
+
+static u64 ep93xx_clocksource_read(struct clocksource *c)
+{
+	struct ep93xx_tcu *tcu = ep93xx_tcu;
+
+	return lo_hi_readq(tcu->base + EP93XX_TIMER4_VALUE_LOW) & GENMASK_ULL(39, 0);
+}
+
+static u64 notrace ep93xx_read_sched_clock(void)
+{
+	return ep93xx_clocksource_read(NULL);
+}
+
+static int ep93xx_clkevt_set_next_event(unsigned long next,
+					struct clock_event_device *evt)
+{
+	struct ep93xx_tcu *tcu = ep93xx_tcu;
+	/* Default mode: periodic, off, 508 kHz */
+	u32 tmode = EP93XX_TIMER123_CONTROL_MODE |
+	EP93XX_TIMER123_CONTROL_CLKSEL;
+
+	/* Clear timer */
+	writel(tmode, tcu->base + EP93XX_TIMER3_CONTROL);
+
+	/* Set next event */
+	writel(next, tcu->base + EP93XX_TIMER3_LOAD);
+	writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
+	       tcu->base + EP93XX_TIMER3_CONTROL);
+	return 0;
+}
+
+static int ep93xx_clkevt_shutdown(struct clock_event_device *evt)
+{
+	struct ep93xx_tcu *tcu = ep93xx_tcu;
+	/* Disable timer */
+	writel(0, tcu->base + EP93XX_TIMER3_CONTROL);
+
+	return 0;
+}
+
+static struct clock_event_device ep93xx_clockevent = {
+	.name			= "timer1",
+	.features		= CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	= ep93xx_clkevt_shutdown,
+	.set_state_oneshot	= ep93xx_clkevt_shutdown,
+	.tick_resume		= ep93xx_clkevt_shutdown,
+	.set_next_event		= ep93xx_clkevt_set_next_event,
+	.rating			= 300,
+};
+
+static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
+{
+	struct ep93xx_tcu *tcu = ep93xx_tcu;
+	struct clock_event_device *evt = dev_id;
+
+	/* Writing any value clears the timer interrupt */
+	writel(1, tcu->base + EP93XX_TIMER3_CLEAR);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init ep93xx_timer_of_init(struct device_node *np)
+{
+	int irq;
+	unsigned long flags = IRQF_TIMER | IRQF_IRQPOLL;
+	struct ep93xx_tcu *tcu;
+	int ret;
+
+	tcu = kzalloc(sizeof(*tcu), GFP_KERNEL);
+	if (!tcu)
+		return -ENOMEM;
+
+	tcu->base = of_iomap(np, 0);
+	if (!tcu->base) {
+		pr_err("Can't remap registers\n");
+		ret = -ENXIO;
+		goto out_free;
+	}
+
+	ep93xx_tcu = tcu;
+
+	irq = irq_of_parse_and_map(np, 0);
+	if (irq == 0)
+		irq = -EINVAL;
+	if (irq < 0) {
+		pr_err("EP93XX Timer Can't parse IRQ %d", irq);
+		goto out_free;
+	}
+
+	/* Enable and register clocksource and sched_clock on timer 4 */
+	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
+	       tcu->base + EP93XX_TIMER4_VALUE_HIGH);
+	clocksource_mmio_init(NULL, "timer4",
+				EP93XX_TIMER4_RATE, 200, 40,
+				ep93xx_clocksource_read);
+	sched_clock_register(ep93xx_read_sched_clock, 40,
+			     EP93XX_TIMER4_RATE);
+
+	/* Set up clockevent on timer 3 */
+	if (request_irq(irq, ep93xx_timer_interrupt, flags, "ep93xx timer",
+		&ep93xx_clockevent))
+		pr_err("Failed to request irq %d (ep93xx timer)\n", irq);
+
+	clockevents_config_and_register(&ep93xx_clockevent,
+				EP93XX_TIMER123_RATE,
+				1,
+				UINT_MAX);
+
+	return 0;
+
+out_free:
+	kfree(tcu);
+	return ret;
+}
+TIMER_OF_DECLARE(ep93xx_timer, "cirrus,ep9301-timer", ep93xx_timer_of_init);
