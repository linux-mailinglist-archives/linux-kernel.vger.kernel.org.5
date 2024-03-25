Return-Path: <linux-kernel+bounces-117498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B90888AC00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1CB1F60A97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58F414A4CC;
	Mon, 25 Mar 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UY4aw14Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JHv0ZCG0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D6137C4F;
	Mon, 25 Mar 2024 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385212; cv=none; b=ihEnud0P2gz/uGHEd/zhvFXwfmmbb6gtQqT0PN7ooFK87wNCpuYszLdZUmV+60ycr73cf0JW1eKwipccTJC+OiUC2rU+M9STl9wWuwv7bBy5DVatQJxoQrwQ1K4Zx9i2kFy/bp0HoVvhJWQgm5lyvWTX4iwvajXO5t8Ifg4W9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385212; c=relaxed/simple;
	bh=0QhVzJxytDxgU7CfbduqgfAfop9r/DO3RIIzXBDVJ44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GG16sOB2tyb+5YpDCJpLWh3ggg1Y6CDEICRTGTTv0zOpRfnkwtW1jZm6DQ7Mbo9XZP/0CnEGz+yuT/l0jn5KweADFHlNJb353RuQ71tW2e47zE1xCcxHnyYuRn4osK0bp6aklSz/AI5a1Jr1dx0eIV/lARgACuleVdXT/usJ+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UY4aw14Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JHv0ZCG0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 16:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711385208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2KP4hINrS5ByYrZBrZNCmqBsFY9rEJTSAAWb26jU48=;
	b=UY4aw14ZFq5IxsqNpcWiIFQho3sxizFjcyKOqQ9wQZep5/lHFYoXwm3XdXrQdeT5173F7F
	f1afHul3kpinoqH31ulRiaPP79syzBfdTP8Myszt3YkZOpb53uveaD69+Ce9U7O0t2dtm2
	lKvISDT7zWd92BPTBfebg78DxzMWB6Ljos1P2jHe9drJBdx9wkuiYGjkKJBVLLP5g4hLes
	dY4AWZo7Kr12tJd4HTJ1WEiVF/4jWL1CXittylrY1esALuJ6b0PUJHLvdUXZXMWVvSVph1
	0xRAYzUjf/vHavZ6q7X00L/qxlWrcxsMOPbjSYg1+7Gz/FSnO4JAsgwKgvFSdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711385208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y2KP4hINrS5ByYrZBrZNCmqBsFY9rEJTSAAWb26jU48=;
	b=JHv0ZCG0VxOdfclpHb+YSIb2jcFvPh2sRp86rUKo+eQObgIGZYt+a5u16VqvdbwAM8Xj2g
	5HXIePV9aTeZh5BA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/riscv-aplic: Add support for MSI-mode
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 bjorn@rivosinc.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240307140307.646078-8-apatel@ventanamicro.com>
References: <20240307140307.646078-8-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171138520759.10875.10067771216044491304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ca8df97fe6798afbe395fc4a8e23bac0c7fbd248
Gitweb:        https://git.kernel.org/tip/ca8df97fe6798afbe395fc4a8e23bac0c7f=
bd248
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 07 Mar 2024 19:33:05 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 17:38:29 +01:00

irqchip/riscv-aplic: Add support for MSI-mode

The RISC-V advanced platform-level interrupt controller (APLIC) has
two modes of operation: 1) Direct mode and 2) MSI mode.
(For more details, refer https://github.com/riscv/riscv-aia)

In APLIC MSI-mode, wired interrupts are forwared as message signaled
interrupts (MSIs) to CPUs via IMSIC.

Extend the existing APLIC irqchip driver to support MSI-mode for
RISC-V platforms having both wired interrupts and MSIs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240307140307.646078-8-apatel@ventanamicro.c=
om

---
 drivers/irqchip/Kconfig                |   6 +-
 drivers/irqchip/Makefile               |   1 +-
 drivers/irqchip/irq-riscv-aplic-main.c |   2 +-
 drivers/irqchip/irq-riscv-aplic-main.h |   8 +-
 drivers/irqchip/irq-riscv-aplic-msi.c  | 257 ++++++++++++++++++++++++-
 5 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-riscv-aplic-msi.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f672847..687d17e 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -545,6 +545,12 @@ config RISCV_APLIC
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
=20
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
index 5adbe7a..d9dc3d9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+=3D irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+=3D irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+=3D irq-riscv-intc.o
 obj-$(CONFIG_RISCV_APLIC)		+=3D irq-riscv-aplic-main.o irq-riscv-aplic-direc=
t.o
+obj-$(CONFIG_RISCV_APLIC_MSI)		+=3D irq-riscv-aplic-msi.o
 obj-$(CONFIG_RISCV_IMSIC)		+=3D irq-riscv-imsic-state.o irq-riscv-imsic-earl=
y.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+=3D irq-starfive-jh8100-intc.o
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-ris=
cv-aplic-main.c
index 160ff99..774a0c9 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.c
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -187,7 +187,7 @@ static int aplic_probe(struct platform_device *pdev)
 	if (is_of_node(dev->fwnode))
 		msi_mode =3D of_property_present(to_of_node(dev->fwnode), "msi-parent");
 	if (msi_mode)
-		rc =3D -ENODEV;
+		rc =3D aplic_msi_setup(dev, regs);
 	else
 		rc =3D aplic_direct_setup(dev, regs);
 	if (rc)
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-ris=
cv-aplic-main.h
index 4cfbadf..4393927 100644
--- a/drivers/irqchip/irq-riscv-aplic-main.h
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -40,5 +40,13 @@ int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u=
32 gsi_base,
 void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
 int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iom=
em *regs);
 int aplic_direct_setup(struct device *dev, void __iomem *regs);
+#ifdef CONFIG_RISCV_APLIC_MSI
+int aplic_msi_setup(struct device *dev, void __iomem *regs);
+#else
+static inline int aplic_msi_setup(struct device *dev, void __iomem *regs)
+{
+	return -ENODEV;
+}
+#endif
=20
 #endif
diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-risc=
v-aplic-msi.c
new file mode 100644
index 0000000..36cd04a
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-msi.c
@@ -0,0 +1,257 @@
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
+static void aplic_msi_irq_mask(struct irq_data *d)
+{
+	aplic_irq_mask(d);
+	irq_chip_mask_parent(d);
+}
+
+static void aplic_msi_irq_unmask(struct irq_data *d)
+{
+	irq_chip_unmask_parent(d);
+	aplic_irq_unmask(d);
+}
+
+static void aplic_msi_irq_eoi(struct irq_data *d)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+
+	/*
+	 * EOI handling is required only for level-triggered interrupts
+	 * when APLIC is in MSI mode.
+	 */
+
+	switch (irqd_get_trigger_type(d)) {
+	case IRQ_TYPE_LEVEL_LOW:
+	case IRQ_TYPE_LEVEL_HIGH:
+		/*
+		 * The section "4.9.2 Special consideration for level-sensitive interrupt
+		 * sources" of the RISC-V AIA specification says:
+		 *
+		 * A second option is for the interrupt service routine to write the
+		 * APLIC=E2=80=99s source identity number for the interrupt to the domain=
=E2=80=99s
+		 * setipnum register just before exiting. This will cause the interrupt=E2=
=80=99s
+		 * pending bit to be set to one again if the source is still asserting
+		 * an interrupt, but not if the source is not asserting an interrupt.
+		 */
+		writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);
+		break;
+	}
+}
+
+static void aplic_msi_write_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	unsigned int group_index, hart_index, guest_index, val;
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+	struct aplic_msicfg *mc =3D &priv->msicfg;
+	phys_addr_t tppn, tbppn, msg_addr;
+	void __iomem *target;
+
+	/* For zeroed MSI, simply write zero into the target register */
+	if (!msg->address_hi && !msg->address_lo && !msg->data) {
+		target =3D priv->regs + APLIC_TARGET_BASE;
+		target +=3D (d->hwirq - 1) * sizeof(u32);
+		writel(0, target);
+		return;
+	}
+
+	/* Sanity check on message data */
+	WARN_ON(msg->data > APLIC_TARGET_EIID_MASK);
+
+	/* Compute target MSI address */
+	msg_addr =3D (((u64)msg->address_hi) << 32) | msg->address_lo;
+	tppn =3D msg_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
+
+	/* Compute target HART Base PPN */
+	tbppn =3D tppn;
+	tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	tbppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
+	tbppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
+	WARN_ON(tbppn !=3D mc->base_ppn);
+
+	/* Compute target group and hart indexes */
+	group_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_HHX_SHIFT(mc->hhxs)) &
+		     APLIC_xMSICFGADDR_PPN_HHX_MASK(mc->hhxw);
+	hart_index =3D (tppn >> APLIC_xMSICFGADDR_PPN_LHX_SHIFT(mc->lhxs)) &
+		     APLIC_xMSICFGADDR_PPN_LHX_MASK(mc->lhxw);
+	hart_index |=3D (group_index << mc->lhxw);
+	WARN_ON(hart_index > APLIC_TARGET_HART_IDX_MASK);
+
+	/* Compute target guest index */
+	guest_index =3D tppn & APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	WARN_ON(guest_index > APLIC_TARGET_GUEST_IDX_MASK);
+
+	/* Update IRQ TARGET register */
+	target =3D priv->regs + APLIC_TARGET_BASE;
+	target +=3D (d->hwirq - 1) * sizeof(u32);
+	val =3D FIELD_PREP(APLIC_TARGET_HART_IDX, hart_index);
+	val |=3D FIELD_PREP(APLIC_TARGET_GUEST_IDX, guest_index);
+	val |=3D FIELD_PREP(APLIC_TARGET_EIID, msg->data);
+	writel(val, target);
+}
+
+static void aplic_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc =3D desc;
+	arg->hwirq =3D (u32)desc->data.icookie.value;
+}
+
+static int aplic_msi_translate(struct irq_domain *d, struct irq_fwspec *fwsp=
ec,
+			       unsigned long *hwirq, unsigned int *type)
+{
+	struct msi_domain_info *info =3D d->host_data;
+	struct aplic_priv *priv =3D info->data;
+
+	return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, type);
+}
+
+static const struct msi_domain_template aplic_msi_template =3D {
+	.chip =3D {
+		.name			=3D "APLIC-MSI",
+		.irq_mask		=3D aplic_msi_irq_mask,
+		.irq_unmask		=3D aplic_msi_irq_unmask,
+		.irq_set_type		=3D aplic_irq_set_type,
+		.irq_eoi		=3D aplic_msi_irq_eoi,
+#ifdef CONFIG_SMP
+		.irq_set_affinity	=3D irq_chip_set_affinity_parent,
+#endif
+		.irq_write_msi_msg	=3D aplic_msi_write_msg,
+		.flags			=3D IRQCHIP_SET_TYPE_MASKED |
+					  IRQCHIP_SKIP_SET_WAKE |
+					  IRQCHIP_MASK_ON_SUSPEND,
+	},
+
+	.ops =3D {
+		.set_desc		=3D aplic_msi_set_desc,
+		.msi_translate		=3D aplic_msi_translate,
+	},
+
+	.info =3D {
+		.bus_token		=3D DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			=3D MSI_FLAG_USE_DEV_FWNODE,
+		.handler		=3D handle_fasteoi_irq,
+		.handler_name		=3D "fasteoi",
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
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	rc =3D aplic_setup_priv(priv, dev, regs);
+	if (rc) {
+		dev_err(dev, "failed to create APLIC context\n");
+		return rc;
+	}
+	mc =3D &priv->msicfg;
+
+	/*
+	 * The APLIC outgoing MSI config registers assume target MSI
+	 * controller to be RISC-V AIA IMSIC controller.
+	 */
+	imsic_global =3D imsic_get_global_config();
+	if (!imsic_global) {
+		dev_err(dev, "IMSIC global config not found\n");
+		return -ENODEV;
+	}
+
+	/* Find number of guest index bits (LHXS) */
+	mc->lhxs =3D imsic_global->guest_index_bits;
+	if (APLIC_xMSICFGADDRH_LHXS_MASK < mc->lhxs) {
+		dev_err(dev, "IMSIC guest index bits big for APLIC LHXS\n");
+		return -EINVAL;
+	}
+
+	/* Find number of HART index bits (LHXW) */
+	mc->lhxw =3D imsic_global->hart_index_bits;
+	if (APLIC_xMSICFGADDRH_LHXW_MASK < mc->lhxw) {
+		dev_err(dev, "IMSIC hart index bits big for APLIC LHXW\n");
+		return -EINVAL;
+	}
+
+	/* Find number of group index bits (HHXW) */
+	mc->hhxw =3D imsic_global->group_index_bits;
+	if (APLIC_xMSICFGADDRH_HHXW_MASK < mc->hhxw) {
+		dev_err(dev, "IMSIC group index bits big for APLIC HHXW\n");
+		return -EINVAL;
+	}
+
+	/* Find first bit position of group index (HHXS) */
+	mc->hhxs =3D imsic_global->group_index_shift;
+	if (mc->hhxs < (2 * APLIC_xMSICFGADDR_PPN_SHIFT)) {
+		dev_err(dev, "IMSIC group index shift should be >=3D %d\n",
+			(2 * APLIC_xMSICFGADDR_PPN_SHIFT));
+		return -EINVAL;
+	}
+	mc->hhxs -=3D (2 * APLIC_xMSICFGADDR_PPN_SHIFT);
+	if (APLIC_xMSICFGADDRH_HHXS_MASK < mc->hhxs) {
+		dev_err(dev, "IMSIC group index shift big for APLIC HHXS\n");
+		return -EINVAL;
+	}
+
+	/* Compute PPN base */
+	mc->base_ppn =3D imsic_global->base_addr >> APLIC_xMSICFGADDR_PPN_SHIFT;
+	mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HART(mc->lhxs);
+	mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_LHX(mc->lhxw, mc->lhxs);
+	mc->base_ppn &=3D ~APLIC_xMSICFGADDR_PPN_HHX(mc->hhxw, mc->hhxs);
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
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic_msi_templ=
ate,
+					  priv->nr_irqs + 1, priv, priv)) {
+		dev_err(dev, "failed to create MSI irq domain\n");
+		return -ENOMEM;
+	}
+
+	/* Advertise the interrupt controller */
+	pa =3D priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
+	dev_info(dev, "%d interrupts forwared to MSI base %pa\n", priv->nr_irqs, &p=
a);
+
+	return 0;
+}

