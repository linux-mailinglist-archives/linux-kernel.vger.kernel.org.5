Return-Path: <linux-kernel+bounces-72386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806AB85B2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B21E285F17
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0705A4E0;
	Tue, 20 Feb 2024 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hwH/sfUB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8275A4CA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409333; cv=none; b=eDPvaJaZrzB44AT+1X9BmQmTPKUcMKAPPrhdhq4yLr7y31MKjMCXZSBSdAUaZJ9zriZHuYa6Ex+5O28UWW1ThFxWXRvWxd0+d7VmARqq6iLriGeOddbV/bxTA3tXse66SGIDf/VQpe2hHwSd0B1qGzrENcWx7YN2Y5zGRfxro/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409333; c=relaxed/simple;
	bh=u7B7stPrsyv7xEjTWoT0Zohv770tWWkThUWydQp5VIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gJ3VHmjK/hJlp4uKmZiov2QM/aaDBoUc+116U88izTMzTJ62KmhtIRyirdU6YChJqS7uD5jz5a4Mqwk8wNe2baR0XPSOA2RBxMLcOIG086RW4l4YYWp4H81QObueOQF+r0w74KRGcSnnqStUqRqwc7Hqn0aji2gYOh347ejbm6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hwH/sfUB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e46e07ff07so851274b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708409331; x=1709014131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs4VAebDMfyI1oNsVq87rDpjxr3zcM8kduh+csoY48c=;
        b=hwH/sfUB/SYwMm61/fOqoFwJ0kvApUf6gdkkZSJ4rKNEaLzMAjg0UI5A97kKUCmVf4
         SePZjfmG28sDLV9pV+ecJ6jBUBv2eYLhKXQzXEKQxXWHnwaUT22NRH1WtR2xPjs2NrfR
         UKT9FeHoTyzcV1YHnAcPsbWYXBkBCkFqDywLOCsi8FnRfkpEiJTNnJHedXBdwrxPNoMj
         mJIzNUffx0gI1K+wxoSlbawOZTs/KP41dCdiymM9tqO+IeN8YYbnDVrDXKFxZ5CeS7kF
         AHPc6TY0BgkCEURBHyU3wuQnZYKLfyb++Q1Wj8SCl5R+d+sv9xGGeCoTChFO1dXw8m4L
         YyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409331; x=1709014131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs4VAebDMfyI1oNsVq87rDpjxr3zcM8kduh+csoY48c=;
        b=avlRGwNjIST7Xo4ASCzNmdoCfVZtAYR7M5aHRXKkEuDLRzOm2PebqiO7xL0lY292EM
         iwizWhCIUY3YS6wlH+t17cxaZmT+vQwyUxJA1SiDSxER9e3jbzwqXoqM2D2rkTVZxcux
         rx3D0OW5PsrzKg/mdxXUhCHFuuQ80wQ0bHr5kWF7Av0ZqoxOXclmmNdIZ+QFq6qfe73k
         lztHiLW6rHCjQ8r34g9HI6Iu1W70Ef7nstwGRxHBYr9OEtHH/1C7txgI4IjEEi0ecahH
         z4ncnUr9FnWD7Qrhn5GK0keAssQVaJFiMdvo28Sp1BKLf3Xa/Vx927ocymo2MIqYaTOE
         gZXA==
X-Forwarded-Encrypted: i=1; AJvYcCU27uyo+2mJKSCN3YbHF29bWuJ5sc91BFkXYFetT9i6dWIft4xGwVdDg9L4yrtT+xGQyBn9u5kSr+yUNQcTMskVSAvoE8X+7DCWXsd4
X-Gm-Message-State: AOJu0YwC+a7GiTvX6SwH5ygUmldaaKSUdstM8dFmKGDERfucNlag9Ov2
	BCyrXJT/oFNim+58nClO+OX6xTAQcJs5jPBy7Aw09/aWMD9RsZDIgr0+m8Qr2g4=
X-Google-Smtp-Source: AGHT+IGC324iDXq2a+MgavgB0Rhy/n14G/njx4BDQch4aVcIijoKbQ8sMGSZZDuNjotjhvNbEjS9jQ==
X-Received: by 2002:a17:903:2289:b0:1dc:7b6:367 with SMTP id b9-20020a170903228900b001dc07b60367mr3233958plh.17.1708409331094;
        Mon, 19 Feb 2024 22:08:51 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001db4c89aea5sm5368114plt.158.2024.02.19.22.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:08:50 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v13 11/13] irqchip/riscv-aplic: Add support for MSI-mode
Date: Tue, 20 Feb 2024 11:37:16 +0530
Message-Id: <20240220060718.823229-12-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220060718.823229-1-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V advanced platform-level interrupt controller (APLIC) has
two modes of operation: 1) Direct mode and 2) MSI mode.
(For more details, refer https://github.com/riscv/riscv-aia)

In APLIC MSI-mode, wired interrupts are forwared as message signaled
interrupts (MSIs) to CPUs via IMSIC.

Extend the existing APLIC irqchip driver to support MSI-mode for
RISC-V platforms having both wired interrupts and MSIs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                |   6 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-riscv-aplic-main.c |   2 +-
 drivers/irqchip/irq-riscv-aplic-main.h |   8 +
 drivers/irqchip/irq-riscv-aplic-msi.c  | 263 +++++++++++++++++++++++++
 5 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index dbc8811d3764..806b5fccb3e8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -551,6 +551,12 @@ config RISCV_APLIC
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
 
+config RISCV_APLIC_MSI
+	bool
+	depends on RISCV_APLIC
+	select GENERIC_MSI_IRQ
+	default RISCV_APLIC
+
 config RISCV_IMSIC
 	bool
 	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 7f8289790ed8..47995fdb2c60 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
 obj-$(CONFIG_RISCV_APLIC)		+= irq-riscv-aplic-main.o irq-riscv-aplic-direct.o
+obj-$(CONFIG_RISCV_APLIC_MSI)		+= irq-riscv-aplic-msi.o
 obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
index e6617147daff..302f4ed7c075 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -187,7 +187,7 @@ static int aplic_probe(struct platform_device *pdev)
 	if (is_of_node(dev->fwnode))
 		msi_mode = of_property_present(to_of_node(dev->fwnode), "msi-parent");
 	if (msi_mode)
-		rc = -ENODEV;
+		rc = aplic_msi_setup(dev, regs);
 	else
 		rc = aplic_direct_setup(dev, regs);
 	if (rc)
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-riscv-aplic-main.h
index 4cfbadf37ddc..4393927d8c80 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.h
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -40,5 +40,13 @@ int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
 void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
 int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iomem *regs);
 int aplic_direct_setup(struct device *dev, void __iomem *regs);
+#ifdef CONFIG_RISCV_APLIC_MSI
+int aplic_msi_setup(struct device *dev, void __iomem *regs);
+#else
+static inline int aplic_msi_setup(struct device *dev, void __iomem *regs)
+{
+	return -ENODEV;
+}
+#endif
 
 #endif
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-riscv-aplic-msi.c
new file mode 100644
index 000000000000..b2a25e011bb2
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/riscv-aplic.h>
+#include <linux/irqchip/riscv-imsic.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-aplic-main.h"
+
+static void aplic_msi_irq_unmask(struct irq_data *d)
+{
+	aplic_irq_unmask(d);
+	irq_chip_unmask_parent(d);
+}
+
+static void aplic_msi_irq_mask(struct irq_data *d)
+{
+	irq_chip_mask_parent(d);
+	aplic_irq_mask(d);
+}
+
+static void aplic_msi_irq_eoi(struct irq_data *d)
+{
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+	u32 reg_off, reg_mask;
+
+	/*
+	 * EOI handling is required only for level-triggered interrupts
+	 * when APLIC is in MSI mode.
+	 */
+
+	reg_off = APLIC_CLRIP_BASE + ((d->hwirq / APLIC_IRQBITS_PER_REG) * 4);
+	reg_mask = BIT(d->hwirq % APLIC_IRQBITS_PER_REG);
+	switch (irqd_get_trigger_type(d)) {
+	case IRQ_TYPE_LEVEL_LOW:
+		/*
+		 * If the rectified input value of the source is still low
+		 * then set the interrupt pending bit so that interrupt is
+		 * re-triggered via MSI.
+		 */
+		if (!(readl(priv->regs + reg_off) & reg_mask))
+			writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		/*
+		 * If the rectified input value of the source is still high
+		 * then set the interrupt pending bit so that interrupt is
+		 * re-triggered via MSI.
+		 */
+		if (readl(priv->regs + reg_off) & reg_mask)
+			writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
+		break;
+	}
+}
+
+static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	unsigned int group_index, hart_index, guest_index, val;
+	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
+	struct aplic_msicfg *mc = &priv->msicfg;
+	phys_addr_t tppn, tbppn, msg_addr;
+	void __iomem *target;
+
+	/* For zeroed MSI, simply write zero into the target register */
+	if (!msg->address_hi && !msg->address_lo && !msg->data) {
+		target = priv->regs + APLIC_TARGET_BASE;
+		target += (d->hwirq - 1) * sizeof(u32);
+		writel(0, target);
+		return;
+	}
+
+	/* Sanity check on message data */
+	WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
+
+	/* Compute target MSI address */
+	msg_addr = (((u64)msg->address_hi) << 32) | msg->address_lo;
+	tppn = msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
+
+	/* Compute target HART Base PPN */
+	tbppn = tppn;
+	tbppn &= ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	tbppn &= ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
+	tbppn &= ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
+	WARN_ON(tbppn != mc->base_ppn);
+
+	/* Compute target group and hart indexes */
+	group_index = (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hhxs)) &
+		     APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
+	hart_index = (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhxs)) &
+		     APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
+	hart_index |= (group_index << mc->lhxw);
+	WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
+
+	/* Compute target guest index */
+	guest_index = tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
+
+	/* Update IRQ TARGET register */
+	target = priv->regs + APLIC_TARGET_BASE;
+	target += (d->hwirq - 1) * sizeof(u32);
+	val = FIELD_PREP(APLIC_TARGET_HART_IDX, hart_index);
+	val |= FIELD_PREP(APLIC_TARGET_GUEST_IDX, guest_index);
+	val |= FIELD_PREP(APLIC_TARGET_EIID, msg->data);
+	writel(val, target);
+}
+
+static void aplic_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = (u32)desc->data.icookie.value;
+}
+
+static int aplic_msi_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
+			       unsigned long *hwirq, unsigned int *type)
+{
+	struct msi_domain_info *info = d->host_data;
+	struct aplic_priv *priv = info->data;
+
+	return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, type);
+}
+
+static const struct msi_domain_template aplic_msi_template = {
+	.chip = {
+		.name			= "APLIC-MSI",
+		.irq_mask		= aplic_msi_irq_mask,
+		.irq_unmask		= aplic_msi_irq_unmask,
+		.irq_set_type		= aplic_irq_set_type,
+		.irq_eoi		= aplic_msi_irq_eoi,
+#ifdef CONFIG_SMP
+		.irq_set_affinity	= irq_chip_set_affinity_parent,
+#endif
+		.irq_write_msi_msg	= aplic_msi_write_msg,
+		.flags			= IRQCHIP_SET_TYPE_MASKED |
+					  IRQCHIP_SKIP_SET_WAKE |
+					  IRQCHIP_MASK_ON_SUSPEND,
+	},
+
+	.ops = {
+		.set_desc		= aplic_msi_set_desc,
+		.msi_translate		= aplic_msi_translate,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			= MSI_FLAG_USE_DEV_FWNODE,
+		.handler		= handle_fasteoi_irq,
+	},
+};
+
+int aplic_msi_setup(struct device *dev, void __iomem *regs)
+{
+	const struct imsic_global_config *imsic_global;
+	struct aplic_priv *priv;
+	struct aplic_msicfg *mc;
+	phys_addr_t pa;
+	int rc;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	rc = aplic_setup_priv(priv, dev, regs);
+	if (rc) {
+		dev_err(dev, "failed to create APLIC context\n");
+		return rc;
+	}
+	mc = &priv->msicfg;
+
+	/*
+	 * The APLIC outgoing MSI config registers assume target MSI
+	 * controller to be RISC-V AIA IMSIC controller.
+	 */
+	imsic_global = imsic_get_global_config();
+	if (!imsic_global) {
+		dev_err(dev, "IMSIC global config not found\n");
+		return -ENODEV;
+	}
+
+	/* Find number of guest index bits (LHXS) */
+	mc->lhxs = imsic_global->guest_index_bits;
+	if (APLIC_xMSICFGADDRH_LHXS_MASK < mc->lhxs) {
+		dev_err(dev, "IMSIC guest index bits big for APLIC LHXS\n");
+		return -EINVAL;
+	}
+
+	/* Find number of HART index bits (LHXW) */
+	mc->lhxw = imsic_global->hart_index_bits;
+	if (APLIC_xMSICFGADDRH_LHXW_MASK < mc->lhxw) {
+		dev_err(dev, "IMSIC hart index bits big for APLIC LHXW\n");
+		return -EINVAL;
+	}
+
+	/* Find number of group index bits (HHXW) */
+	mc->hhxw = imsic_global->group_index_bits;
+	if (APLIC_xMSICFGADDRH_HHXW_MASK < mc->hhxw) {
+		dev_err(dev, "IMSIC group index bits big for APLIC HHXW\n");
+		return -EINVAL;
+	}
+
+	/* Find first bit position of group index (HHXS) */
+	mc->hhxs = imsic_global->group_index_shift;
+	if (mc->hhxs < (2 * APLIC_xMSICFGADDR_PPN_SHIFT)) {
+		dev_err(dev, "IMSIC group index shift should be >= %d\n",
+			(2 * APLIC_xMSICFGADDR_PPN_SHIFT));
+		return -EINVAL;
+	}
+	mc->hhxs -= (2 * APLIC_xMSICFGADDR_PPN_SHIFT);
+	if (APLIC_xMSICFGADDRH_HHXS_MASK < mc->hhxs) {
+		dev_err(dev, "IMSIC group index shift big for APLIC HHXS\n");
+		return -EINVAL;
+	}
+
+	/* Compute PPN base */
+	mc->base_ppn = imsic_global->base_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
+	mc->base_ppn &= ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	mc->base_ppn &= ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
+	mc->base_ppn &= ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
+
+	/* Setup global config and interrupt delivery */
+	aplic_init_hw_global(priv, true);
+
+	/* Set the APLIC device MSI domain if not available */
+	if (!dev_get_msi_domain(dev)) {
+		/*
+		 * The device MSI domain for OF devices is only set at the
+		 * time of populating/creating OF device. If the device MSI
+		 * domain is discovered later after the OF device is created
+		 * then we need to set it explicitly before using any platform
+		 * MSI functions.
+		 *
+		 * In case of APLIC device, the parent MSI domain is always
+		 * IMSIC and the IMSIC MSI domains are created later through
+		 * the platform driver probing so we set it explicitly here.
+		 */
+		if (is_of_node(dev->fwnode))
+			of_msi_configure(dev, to_of_node(dev->fwnode));
+	}
+
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_template,
+					  priv->nr_irqs + 1, priv, priv)) {
+		dev_err(dev, "failed to create MSI irq domain\n");
+		return -ENOMEM;
+	}
+
+	/* Advertise the interrupt controller */
+	pa = priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
+	dev_info(dev, "%d interrupts forwared to MSI base %pa\n", priv->nr_irqs, &pa);
+
+	return 0;
+}
-- 
2.34.1


