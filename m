Return-Path: <linux-kernel+bounces-81593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A808677F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD331F25097
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB4129A92;
	Mon, 26 Feb 2024 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JnEm0v/t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4j/kqY8a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125F71C6B9;
	Mon, 26 Feb 2024 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708956807; cv=none; b=rLLY2tZkmKTbAjvR01a3taTTzJIhwLM4nZbK4zpa5LZCz43G/TRYav/3607y5FT8r7Ao3ulMh6Cd8FTtjkOCFHYnVRHHIfjsDrVvAI/BwWVOcxjeeUrKMPa40nLqrVC0seWO8DqH/f7mCxB+gYxSAFBH3Y26lIQUshsHIjmCW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708956807; c=relaxed/simple;
	bh=0gT0+K+2U6oGRBNU6uUxk0O6wqdUUXfbvrtxUEOR5Gg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g6PIEGJL1BoVIBPLS4ugGS4YAFxF3syI/3IeeKjStvFjOiYGpl7ozFuWEP0pL/JY/ff4UGLLGSfc3hqC91vTYBsxjvvjNtm0FRrx7x3rd6v04p32+VhjUceFZw4qJF2uT0eZUqATV5LqdwXdrJiLV+wwJG006p08VuOpZZEU7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JnEm0v/t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4j/kqY8a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Feb 2024 14:13:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708956802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbDCcc4g3NukmAqQQlkJl37rN63HXQoB5FC69t4Ev1Y=;
	b=JnEm0v/t8pcjnthCqsTiwIe/NviH+pzwsS8sXXiLBm4l2RvjUl7tN9ysD1yyO+x3r2fwl/
	9yRaRfeb4Jl7MaFL0OaNpxePzx9ecUW2I8AWmkMXewMpyNRRRT/BJzbQ8pT+9b8Xz7ikkW
	m1TUPzQ702+9h+ckA/wCjmTgTh2ZTuMIV3b38wpaYHY7OW4zpBaZJNyaZ7/obYCkR/jSvm
	0ktoooxFAEzT/I3Ke18JFMHUAM6MRGwLomMpVibkaSSFxH/Csx26rnzuyHSddZsu02Jjk2
	dZtNSS9FMCMR8IeseFgPvyHF+FIFbBw8OQgHsot4K6BCJ/IqqCV3qjJNik7rMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708956802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbDCcc4g3NukmAqQQlkJl37rN63HXQoB5FC69t4Ev1Y=;
	b=4j/kqY8aMQ9K9ImOrGVDElU+OWDFvFeUhTBSSX+6xHk0J1j89wikIky2ob1Wux00kozJ+A
	tnnVmYMGRiOq+TBA==
From: "tip-bot2 for Changhuang Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add StarFive external interrupt controller
Cc: Changhuang Liang <changhuang.liang@starfivetech.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240226055025.1669223-3-changhuang.liang@starfivetech.com>
References: <20240226055025.1669223-3-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170895680138.398.7473309048897714470.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e4e535036173addff38d6b295a231a553d1e0d3a
Gitweb:        https://git.kernel.org/tip/e4e535036173addff38d6b295a231a553d1e0d3a
Author:        Changhuang Liang <changhuang.liang@starfivetech.com>
AuthorDate:    Sun, 25 Feb 2024 21:50:25 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Feb 2024 15:09:18 +01:00

irqchip: Add StarFive external interrupt controller

Add StarFive external interrupt controller for JH8100 SoC.

Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/r/20240226055025.1669223-3-changhuang.liang@starfivetech.com

---
 MAINTAINERS                                |   6 +-
 drivers/irqchip/Kconfig                    |  11 +-
 drivers/irqchip/Makefile                   |   1 +-
 drivers/irqchip/irq-starfive-jh8100-intc.c | 207 ++++++++++++++++++++-
 4 files changed, 225 insertions(+)
 create mode 100644 drivers/irqchip/irq-starfive-jh8100-intc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052f..ef678f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20956,6 +20956,12 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
 
+STARFIVE JH8100 EXTERNAL INTERRUPT CONTROLLER DRIVER
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-intc.yaml
+F:	drivers/irqchip/irq-starfive-jh8100-intc.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0..72c07a1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -546,6 +546,17 @@ config SIFIVE_PLIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
+config STARFIVE_JH8100_INTC
+	bool "StarFive JH8100 External Interrupt Controller"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	default ARCH_STARFIVE
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  This enables support for the INTC chip found in StarFive JH8100
+	  SoC.
+
+	  If you don't know what to do here, say Y.
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945f..ec4a183 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
+obj-$(CONFIG_STARFIVE_JH8100_INTC)	+= irq-starfive-jh8100-intc.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+= irq-imx-mu-msi.o
diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq-starfive-jh8100-intc.c
new file mode 100644
index 0000000..0f58371
--- /dev/null
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 External Interrupt Controller driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ */
+
+#define pr_fmt(fmt) "irq-starfive-jh8100: " fmt
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define STARFIVE_INTC_SRC0_CLEAR	0x10
+#define STARFIVE_INTC_SRC0_MASK		0x14
+#define STARFIVE_INTC_SRC0_INT		0x1c
+
+#define STARFIVE_INTC_SRC_IRQ_NUM	32
+
+struct starfive_irq_chip {
+	void __iomem		*base;
+	struct irq_domain	*domain;
+	raw_spinlock_t		lock;
+};
+
+static void starfive_intc_bit_set(struct starfive_irq_chip *irqc,
+				  u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value = ioread32(irqc->base + reg);
+	value |= bit_mask;
+	iowrite32(value, irqc->base + reg);
+}
+
+static void starfive_intc_bit_clear(struct starfive_irq_chip *irqc,
+				    u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value = ioread32(irqc->base + reg);
+	value &= ~bit_mask;
+	iowrite32(value, irqc->base + reg);
+}
+
+static void starfive_intc_unmask(struct irq_data *d)
+{
+	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&irqc->lock);
+	starfive_intc_bit_clear(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq));
+	raw_spin_unlock(&irqc->lock);
+}
+
+static void starfive_intc_mask(struct irq_data *d)
+{
+	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&irqc->lock);
+	starfive_intc_bit_set(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq));
+	raw_spin_unlock(&irqc->lock);
+}
+
+static struct irq_chip intc_dev = {
+	.name		= "StarFive JH8100 INTC",
+	.irq_unmask	= starfive_intc_unmask,
+	.irq_mask	= starfive_intc_mask,
+};
+
+static int starfive_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_domain_set_info(d, irq, hwirq, &intc_dev, d->host_data,
+			    handle_level_irq, NULL, NULL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops starfive_intc_domain_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= starfive_intc_map,
+};
+
+static void starfive_intc_irq_handler(struct irq_desc *desc)
+{
+	struct starfive_irq_chip *irqc = irq_data_get_irq_handler_data(&desc->irq_data);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned long value;
+	int hwirq;
+
+	chained_irq_enter(chip, desc);
+
+	value = ioread32(irqc->base + STARFIVE_INTC_SRC0_INT);
+	while (value) {
+		hwirq = ffs(value) - 1;
+
+		generic_handle_domain_irq(irqc->domain, hwirq);
+
+		starfive_intc_bit_set(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq));
+		starfive_intc_bit_clear(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq));
+
+		__clear_bit(hwirq, &value);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int __init starfive_intc_init(struct device_node *intc,
+				     struct device_node *parent)
+{
+	struct starfive_irq_chip *irqc;
+	struct reset_control *rst;
+	struct clk *clk;
+	int parent_irq;
+	int ret;
+
+	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
+	if (!irqc)
+		return -ENOMEM;
+
+	irqc->base = of_iomap(intc, 0);
+	if (!irqc->base) {
+		pr_err("Unable to map registers\n");
+		ret = -ENXIO;
+		goto err_free;
+	}
+
+	rst = of_reset_control_get_exclusive(intc, NULL);
+	if (IS_ERR(rst)) {
+		pr_err("Unable to get reset control %pe\n", rst);
+		ret = PTR_ERR(rst);
+		goto err_unmap;
+	}
+
+	clk = of_clk_get(intc, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Unable to get clock %pe\n", clk);
+		ret = PTR_ERR(clk);
+		goto err_reset_put;
+	}
+
+	ret = reset_control_deassert(rst);
+	if (ret)
+		goto err_clk_put;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto err_reset_assert;
+
+	raw_spin_lock_init(&irqc->lock);
+
+	irqc->domain = irq_domain_add_linear(intc, STARFIVE_INTC_SRC_IRQ_NUM,
+					     &starfive_intc_domain_ops, irqc);
+	if (!irqc->domain) {
+		pr_err("Unable to create IRQ domain\n");
+		ret = -EINVAL;
+		goto err_clk_disable;
+	}
+
+	parent_irq = of_irq_get(intc, 0);
+	if (parent_irq < 0) {
+		pr_err("Failed to get main IRQ: %d\n", parent_irq);
+		ret = parent_irq;
+		goto err_remove_domain;
+	}
+
+	irq_set_chained_handler_and_data(parent_irq, starfive_intc_irq_handler,
+					 irqc);
+
+	pr_info("Interrupt controller register, nr_irqs %d\n",
+		STARFIVE_INTC_SRC_IRQ_NUM);
+
+	return 0;
+
+err_remove_domain:
+	irq_domain_remove(irqc->domain);
+err_clk_disable:
+	clk_disable_unprepare(clk);
+err_reset_assert:
+	reset_control_assert(rst);
+err_clk_put:
+	clk_put(clk);
+err_reset_put:
+	reset_control_put(rst);
+err_unmap:
+	iounmap(irqc->base);
+err_free:
+	kfree(irqc);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(starfive_intc)
+IRQCHIP_MATCH("starfive,jh8100-intc", starfive_intc_init)
+IRQCHIP_PLATFORM_DRIVER_END(starfive_intc)
+
+MODULE_DESCRIPTION("StarFive JH8100 External Interrupt Controller");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");

