Return-Path: <linux-kernel+bounces-117500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1FA88AC04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6666E1F3F286
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D931E14A615;
	Mon, 25 Mar 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Koc+gI4h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y0ITkhAf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CEA149E0F;
	Mon, 25 Mar 2024 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385213; cv=none; b=u70KpQaZBm2XAJpbVCnZZ1TJxtUNtbHxbHyKNXUSbIltdc7s85atDB52aklHfyEFC0/k4E/kpx/ZAP9w/pnC3ZA7uaZaGfDzAyE0Kt5wGcja2n5X+MYfkGlSSGWkKpoE49sD4KDDUfVBeAmMQMIJnfWmODFRLqm26dUwIZ6ZizM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385213; c=relaxed/simple;
	bh=26iu6AWvIJT8/jmpI+CsOEkwHBMWkPaKHjZxlnie0LY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nSO+o9JC1y/k/Tcum1/hD7nL94XM28FBLlpBsQuXZFCv2+dxZvEaAdx7r5Rfak2cXJTeW6mHHx4bkMTzR+lyoEMfOnQ8DUARRLWtPztw8CLLxu8dwWHahud2mNN91v0DGE0kgn8x1S6znNs1JGe6VOk8Fgha4CXzpwMlD8APXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Koc+gI4h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y0ITkhAf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 16:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711385209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaT+1i1bj/xIqrAwLiuvcueEKiU6T/H365h/G56esV0=;
	b=Koc+gI4h6Jt6C2EEH5Yzpur1fWWeK46b5NUb7cb+JwDULmcGKeFvQjobWSYu3r/1EUJERs
	zZTmYvniWJ5bKwZ1czITZ9JQnrADjuepeZY0s7G5wZdPQqTGmkj4DDiDXSN2j4m2CXmxqD
	vMDFd1tzHjzw+5YkiUDO9zPfSM000Dk2W8Teq5KEiBc4HcIiDoFRrY/AI21wP2Nk6EpjNC
	CnOnM+byfREQPAspKEU3PKGtQIEEf/u+NdDJ5AKtFa7gEGe6as/KylZJUZ2B+HIxkbFoFy
	ijTH1JP57cBBjX0R5Ex16bSM1SQ+yvWwBs7rOGg+n2w9yHX2DyyGzuaemc5y7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711385209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaT+1i1bj/xIqrAwLiuvcueEKiU6T/H365h/G56esV0=;
	b=Y0ITkhAfu+Ebg66QnnF95p+DAPIFBq9mxM0k3gr5dnWwQ9z+s0otgsg/iajOiSwjLPWmmT
	yhC5ISrTyJ1SvwCA==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip: Add RISC-V advanced PLIC driver for direct-mode
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 bjorn@rivosinc.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240307140307.646078-7-apatel@ventanamicro.com>
References: <20240307140307.646078-7-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171138520838.10875.8861299669032489404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2333df5ae51ead2188d07c99e841e159a664741e
Gitweb:        https://git.kernel.org/tip/2333df5ae51ead2188d07c99e841e159a66=
4741e
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 07 Mar 2024 19:33:04 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 17:38:29 +01:00

irqchip: Add RISC-V advanced PLIC driver for direct-mode

The RISC-V advanced interrupt architecture (AIA) specification defines
advanced platform-level interrupt controller (APLIC) which has two modes
of operation: 1) Direct mode and 2) MSI mode.
(For more details, refer https://github.com/riscv/riscv-aia)

In APLIC direct-mode, wired interrupts are forwared to CPUs (or HARTs)
as a local external interrupt.

Add a platform irqchip driver for the RISC-V APLIC direct-mode to
support RISC-V platforms having only wired interrupts.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240307140307.646078-7-apatel@ventanamicro.c=
om

---
 drivers/irqchip/Kconfig                  |   5 +-
 drivers/irqchip/Makefile                 |   1 +-
 drivers/irqchip/irq-riscv-aplic-direct.c | 326 ++++++++++++++++++++++-
 drivers/irqchip/irq-riscv-aplic-main.c   | 211 ++++++++++++++-
 drivers/irqchip/irq-riscv-aplic-main.h   |  44 +++-
 include/linux/irqchip/riscv-aplic.h      | 145 ++++++++++-
 6 files changed, 732 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-aplic-direct.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.c
 create mode 100644 drivers/irqchip/irq-riscv-aplic-main.h
 create mode 100644 include/linux/irqchip/riscv-aplic.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 8f6ce41..f672847 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -540,6 +540,11 @@ config RISCV_INTC
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
=20
+config RISCV_APLIC
+	bool
+	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
+
 config RISCV_IMSIC
 	bool
 	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index c139098..5adbe7a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+=3D irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+=3D irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+=3D irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+=3D irq-riscv-intc.o
+obj-$(CONFIG_RISCV_APLIC)		+=3D irq-riscv-aplic-main.o irq-riscv-aplic-direc=
t.o
 obj-$(CONFIG_RISCV_IMSIC)		+=3D irq-riscv-imsic-state.o irq-riscv-imsic-earl=
y.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+=3D irq-starfive-jh8100-intc.o
diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-r=
iscv-aplic-direct.c
new file mode 100644
index 0000000..06bace9
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -0,0 +1,326 @@
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
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/riscv-aplic.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/printk.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-aplic-main.h"
+
+#define APLIC_DISABLE_IDELIVERY		0
+#define APLIC_ENABLE_IDELIVERY		1
+#define APLIC_DISABLE_ITHRESHOLD	1
+#define APLIC_ENABLE_ITHRESHOLD		0
+
+struct aplic_direct {
+	struct aplic_priv	priv;
+	struct irq_domain	*irqdomain;
+	struct cpumask		lmask;
+};
+
+struct aplic_idc {
+	unsigned int		hart_index;
+	void __iomem		*regs;
+	struct aplic_direct	*direct;
+};
+
+static unsigned int aplic_direct_parent_irq;
+static DEFINE_PER_CPU(struct aplic_idc, aplic_idcs);
+
+static void aplic_direct_irq_eoi(struct irq_data *d)
+{
+	/*
+	 * The fasteoi_handler requires irq_eoi() callback hence
+	 * provide a dummy handler.
+	 */
+}
+
+#ifdef CONFIG_SMP
+static int aplic_direct_set_affinity(struct irq_data *d, const struct cpumas=
k *mask_val,
+				     bool force)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+	struct aplic_direct *direct =3D container_of(priv, struct aplic_direct, pri=
v);
+	struct aplic_idc *idc;
+	unsigned int cpu, val;
+	struct cpumask amask;
+	void __iomem *target;
+
+	cpumask_and(&amask, &direct->lmask, mask_val);
+
+	if (force)
+		cpu =3D cpumask_first(&amask);
+	else
+		cpu =3D cpumask_any_and(&amask, cpu_online_mask);
+
+	if (cpu >=3D nr_cpu_ids)
+		return -EINVAL;
+
+	idc =3D per_cpu_ptr(&aplic_idcs, cpu);
+	target =3D priv->regs + APLIC_TARGET_BASE + (d->hwirq - 1) * sizeof(u32);
+	val =3D FIELD_PREP(APLIC_TARGET_HART_IDX, idc->hart_index);
+	val |=3D FIELD_PREP(APLIC_TARGET_IPRIO, APLIC_DEFAULT_PRIORITY);
+	writel(val, target);
+
+	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
+static struct irq_chip aplic_direct_chip =3D {
+	.name		=3D "APLIC-DIRECT",
+	.irq_mask	=3D aplic_irq_mask,
+	.irq_unmask	=3D aplic_irq_unmask,
+	.irq_set_type	=3D aplic_irq_set_type,
+	.irq_eoi	=3D aplic_direct_irq_eoi,
+#ifdef CONFIG_SMP
+	.irq_set_affinity =3D aplic_direct_set_affinity,
+#endif
+	.flags		=3D IRQCHIP_SET_TYPE_MASKED |
+			  IRQCHIP_SKIP_SET_WAKE |
+			  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int aplic_direct_irqdomain_translate(struct irq_domain *d, struct irq=
_fwspec *fwspec,
+					    unsigned long *hwirq, unsigned int *type)
+{
+	struct aplic_priv *priv =3D d->host_data;
+
+	return aplic_irqdomain_translate(fwspec, priv->gsi_base, hwirq, type);
+}
+
+static int aplic_direct_irqdomain_alloc(struct irq_domain *domain, unsigned =
int virq,
+					unsigned int nr_irqs, void *arg)
+{
+	struct aplic_priv *priv =3D domain->host_data;
+	struct aplic_direct *direct =3D container_of(priv, struct aplic_direct, pri=
v);
+	struct irq_fwspec *fwspec =3D arg;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int i, ret;
+
+	ret =3D aplic_irqdomain_translate(fwspec, priv->gsi_base, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i =3D 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i, &aplic_direct_chip,
+				    priv, handle_fasteoi_irq, NULL, NULL);
+		irq_set_affinity(virq + i, &direct->lmask);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops aplic_direct_irqdomain_ops =3D {
+	.translate	=3D aplic_direct_irqdomain_translate,
+	.alloc		=3D aplic_direct_irqdomain_alloc,
+	.free		=3D irq_domain_free_irqs_top,
+};
+
+/*
+ * To handle an APLIC direct interrupts, we just read the CLAIMI register
+ * which will return highest priority pending interrupt and clear the
+ * pending bit of the interrupt. This process is repeated until CLAIMI
+ * register return zero value.
+ */
+static void aplic_direct_handle_irq(struct irq_desc *desc)
+{
+	struct aplic_idc *idc =3D this_cpu_ptr(&aplic_idcs);
+	struct irq_domain *irqdomain =3D idc->direct->irqdomain;
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	irq_hw_number_t hw_irq;
+	int irq;
+
+	chained_irq_enter(chip, desc);
+
+	while ((hw_irq =3D readl(idc->regs + APLIC_IDC_CLAIMI))) {
+		hw_irq =3D hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
+		irq =3D irq_find_mapping(irqdomain, hw_irq);
+
+		if (unlikely(irq <=3D 0)) {
+			dev_warn_ratelimited(idc->direct->priv.dev,
+					     "hw_irq %lu mapping not found\n", hw_irq);
+		} else {
+			generic_handle_irq(irq);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void aplic_idc_set_delivery(struct aplic_idc *idc, bool en)
+{
+	u32 de =3D (en) ? APLIC_ENABLE_IDELIVERY : APLIC_DISABLE_IDELIVERY;
+	u32 th =3D (en) ? APLIC_ENABLE_ITHRESHOLD : APLIC_DISABLE_ITHRESHOLD;
+
+	/* Priority must be less than threshold for interrupt triggering */
+	writel(th, idc->regs + APLIC_IDC_ITHRESHOLD);
+
+	/* Delivery must be set to 1 for interrupt triggering */
+	writel(de, idc->regs + APLIC_IDC_IDELIVERY);
+}
+
+static int aplic_direct_dying_cpu(unsigned int cpu)
+{
+	if (aplic_direct_parent_irq)
+		disable_percpu_irq(aplic_direct_parent_irq);
+
+	return 0;
+}
+
+static int aplic_direct_starting_cpu(unsigned int cpu)
+{
+	if (aplic_direct_parent_irq) {
+		enable_percpu_irq(aplic_direct_parent_irq,
+				  irq_get_trigger_type(aplic_direct_parent_irq));
+	}
+
+	return 0;
+}
+
+static int aplic_direct_parse_parent_hwirq(struct device *dev, u32 index,
+					   u32 *parent_hwirq, unsigned long *parent_hartid)
+{
+	struct of_phandle_args parent;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
+
+	rc =3D of_irq_parse_one(to_of_node(dev->fwnode), index, &parent);
+	if (rc)
+		return rc;
+
+	rc =3D riscv_of_parent_hartid(parent.np, parent_hartid);
+	if (rc)
+		return rc;
+
+	*parent_hwirq =3D parent.args[0];
+	return 0;
+}
+
+int aplic_direct_setup(struct device *dev, void __iomem *regs)
+{
+	int i, j, rc, cpu, current_cpu, setup_count =3D 0;
+	struct aplic_direct *direct;
+	struct irq_domain *domain;
+	struct aplic_priv *priv;
+	struct aplic_idc *idc;
+	unsigned long hartid;
+	u32 v, hwirq;
+
+	direct =3D devm_kzalloc(dev, sizeof(*direct), GFP_KERNEL);
+	if (!direct)
+		return -ENOMEM;
+	priv =3D &direct->priv;
+
+	rc =3D aplic_setup_priv(priv, dev, regs);
+	if (rc) {
+		dev_err(dev, "failed to create APLIC context\n");
+		return rc;
+	}
+
+	/* Setup per-CPU IDC and target CPU mask */
+	current_cpu =3D get_cpu();
+	for (i =3D 0; i < priv->nr_idcs; i++) {
+		rc =3D aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &hartid);
+		if (rc) {
+			dev_warn(dev, "parent irq for IDC%d not found\n", i);
+			continue;
+		}
+
+		/*
+		 * Skip interrupts other than external interrupts for
+		 * current privilege level.
+		 */
+		if (hwirq !=3D RV_IRQ_EXT)
+			continue;
+
+		cpu =3D riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			dev_warn(dev, "invalid cpuid for IDC%d\n", i);
+			continue;
+		}
+
+		cpumask_set_cpu(cpu, &direct->lmask);
+
+		idc =3D per_cpu_ptr(&aplic_idcs, cpu);
+		idc->hart_index =3D i;
+		idc->regs =3D priv->regs + APLIC_IDC_BASE + i * APLIC_IDC_SIZE;
+		idc->direct =3D direct;
+
+		aplic_idc_set_delivery(idc, true);
+
+		/*
+		 * Boot cpu might not have APLIC hart_index =3D 0 so check
+		 * and update target registers of all interrupts.
+		 */
+		if (cpu =3D=3D current_cpu && idc->hart_index) {
+			v =3D FIELD_PREP(APLIC_TARGET_HART_IDX, idc->hart_index);
+			v |=3D FIELD_PREP(APLIC_TARGET_IPRIO, APLIC_DEFAULT_PRIORITY);
+			for (j =3D 1; j <=3D priv->nr_irqs; j++)
+				writel(v, priv->regs + APLIC_TARGET_BASE + (j - 1) * sizeof(u32));
+		}
+
+		setup_count++;
+	}
+	put_cpu();
+
+	/* Find parent domain and register chained handler */
+	domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!aplic_direct_parent_irq && domain) {
+		aplic_direct_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
+		if (aplic_direct_parent_irq) {
+			irq_set_chained_handler(aplic_direct_parent_irq,
+						aplic_direct_handle_irq);
+
+			/*
+			 * Setup CPUHP notifier to enable parent
+			 * interrupt on all CPUs
+			 */
+			cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+					  "irqchip/riscv/aplic:starting",
+					  aplic_direct_starting_cpu,
+					  aplic_direct_dying_cpu);
+		}
+	}
+
+	/* Fail if we were not able to setup IDC for any CPU */
+	if (!setup_count)
+		return -ENODEV;
+
+	/* Setup global config and interrupt delivery */
+	aplic_init_hw_global(priv, false);
+
+	/* Create irq domain instance for the APLIC */
+	direct->irqdomain =3D irq_domain_create_linear(dev->fwnode, priv->nr_irqs +=
 1,
+						     &aplic_direct_irqdomain_ops, priv);
+	if (!direct->irqdomain) {
+		dev_err(dev, "failed to create direct irq domain\n");
+		return -ENOMEM;
+	}
+
+	/* Advertise the interrupt controller */
+	dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
+		 priv->nr_irqs, priv->nr_idcs);
+
+	return 0;
+}
diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-ris=
cv-aplic-main.c
new file mode 100644
index 0000000..160ff99
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-main.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/irqchip/riscv-aplic.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+
+#include "irq-riscv-aplic-main.h"
+
+void aplic_irq_unmask(struct irq_data *d)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+
+	writel(d->hwirq, priv->regs + APLIC_SETIENUM);
+}
+
+void aplic_irq_mask(struct irq_data *d)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+
+	writel(d->hwirq, priv->regs + APLIC_CLRIENUM);
+}
+
+int aplic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
+	void __iomem *sourcecfg;
+	u32 val =3D 0;
+
+	switch (type) {
+	case IRQ_TYPE_NONE:
+		val =3D APLIC_SOURCECFG_SM_INACTIVE;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		val =3D APLIC_SOURCECFG_SM_LEVEL_LOW;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		val =3D APLIC_SOURCECFG_SM_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		val =3D APLIC_SOURCECFG_SM_EDGE_FALL;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		val =3D APLIC_SOURCECFG_SM_EDGE_RISE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sourcecfg =3D priv->regs + APLIC_SOURCECFG_BASE;
+	sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
+	writel(val, sourcecfg);
+
+	return 0;
+}
+
+int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
+			      unsigned long *hwirq, unsigned int *type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+	if (WARN_ON(!fwspec->param[0]))
+		return -EINVAL;
+
+	/* For DT, gsi_base is always zero. */
+	*hwirq =3D fwspec->param[0] - gsi_base;
+	*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+
+	WARN_ON(*type =3D=3D IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
+{
+	u32 val;
+#ifdef CONFIG_RISCV_M_MODE
+	u32 valh;
+
+	if (msi_mode) {
+		val =3D lower_32_bits(priv->msicfg.base_ppn);
+		valh =3D FIELD_PREP(APLIC_xMSICFGADDRH_BAPPN, upper_32_bits(priv->msicfg.b=
ase_ppn));
+		valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_LHXW, priv->msicfg.lhxw);
+		valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_HHXW, priv->msicfg.hhxw);
+		valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_LHXS, priv->msicfg.lhxs);
+		valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msicfg.hhxs);
+		writel(val, priv->regs + APLIC_xMSICFGADDR);
+		writel(valh, priv->regs + APLIC_xMSICFGADDRH);
+	}
+#endif
+
+	/* Setup APLIC domaincfg register */
+	val =3D readl(priv->regs + APLIC_DOMAINCFG);
+	val |=3D APLIC_DOMAINCFG_IE;
+	if (msi_mode)
+		val |=3D APLIC_DOMAINCFG_DM;
+	writel(val, priv->regs + APLIC_DOMAINCFG);
+	if (readl(priv->regs + APLIC_DOMAINCFG) !=3D val)
+		dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n", val);
+}
+
+static void aplic_init_hw_irqs(struct aplic_priv *priv)
+{
+	int i;
+
+	/* Disable all interrupts */
+	for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32)
+		writel(-1U, priv->regs + APLIC_CLRIE_BASE + (i / 32) * sizeof(u32));
+
+	/* Set interrupt type and default priority for all interrupts */
+	for (i =3D 1; i <=3D priv->nr_irqs; i++) {
+		writel(0, priv->regs + APLIC_SOURCECFG_BASE + (i - 1) * sizeof(u32));
+		writel(APLIC_DEFAULT_PRIORITY,
+		       priv->regs + APLIC_TARGET_BASE + (i - 1) * sizeof(u32));
+	}
+
+	/* Clear APLIC domaincfg */
+	writel(0, priv->regs + APLIC_DOMAINCFG);
+}
+
+int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iom=
em *regs)
+{
+	struct of_phandle_args parent;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
+
+	/* Save device pointer and register base */
+	priv->dev =3D dev;
+	priv->regs =3D regs;
+
+	/* Find out number of interrupt sources */
+	rc =3D of_property_read_u32(to_of_node(dev->fwnode), "riscv,num-sources",
+				  &priv->nr_irqs);
+	if (rc) {
+		dev_err(dev, "failed to get number of interrupt sources\n");
+		return rc;
+	}
+
+	/*
+	 * Find out number of IDCs based on parent interrupts
+	 *
+	 * If "msi-parent" property is present then we ignore the
+	 * APLIC IDCs which forces the APLIC driver to use MSI mode.
+	 */
+	if (!of_property_present(to_of_node(dev->fwnode), "msi-parent")) {
+		while (!of_irq_parse_one(to_of_node(dev->fwnode), priv->nr_idcs, &parent))
+			priv->nr_idcs++;
+	}
+
+	/* Setup initial state APLIC interrupts */
+	aplic_init_hw_irqs(priv);
+
+	return 0;
+}
+
+static int aplic_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	bool msi_mode =3D false;
+	void __iomem *regs;
+	int rc;
+
+	/* Map the MMIO registers */
+	regs =3D devm_platform_ioremap_resource(pdev, 0);
+	if (!regs) {
+		dev_err(dev, "failed map MMIO registers\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * If msi-parent property is present then setup APLIC MSI
+	 * mode otherwise setup APLIC direct mode.
+	 */
+	if (is_of_node(dev->fwnode))
+		msi_mode =3D of_property_present(to_of_node(dev->fwnode), "msi-parent");
+	if (msi_mode)
+		rc =3D -ENODEV;
+	else
+		rc =3D aplic_direct_setup(dev, regs);
+	if (rc)
+		dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mode ? "MSI" : "dir=
ect");
+
+	return rc;
+}
+
+static const struct of_device_id aplic_match[] =3D {
+	{ .compatible =3D "riscv,aplic" },
+	{}
+};
+
+static struct platform_driver aplic_driver =3D {
+	.driver =3D {
+		.name		=3D "riscv-aplic",
+		.of_match_table	=3D aplic_match,
+	},
+	.probe =3D aplic_probe,
+};
+builtin_platform_driver(aplic_driver);
diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq-ris=
cv-aplic-main.h
new file mode 100644
index 0000000..4cfbadf
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-aplic-main.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#ifndef _IRQ_RISCV_APLIC_MAIN_H
+#define _IRQ_RISCV_APLIC_MAIN_H
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/fwnode.h>
+
+#define APLIC_DEFAULT_PRIORITY		1
+
+struct aplic_msicfg {
+	phys_addr_t		base_ppn;
+	u32			hhxs;
+	u32			hhxw;
+	u32			lhxs;
+	u32			lhxw;
+};
+
+struct aplic_priv {
+	struct device		*dev;
+	u32			gsi_base;
+	u32			nr_irqs;
+	u32			nr_idcs;
+	void __iomem		*regs;
+	struct aplic_msicfg	msicfg;
+};
+
+void aplic_irq_unmask(struct irq_data *d);
+void aplic_irq_mask(struct irq_data *d);
+int aplic_irq_set_type(struct irq_data *d, unsigned int type);
+int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
+			      unsigned long *hwirq, unsigned int *type);
+void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
+int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void __iom=
em *regs);
+int aplic_direct_setup(struct device *dev, void __iomem *regs);
+
+#endif
diff --git a/include/linux/irqchip/riscv-aplic.h b/include/linux/irqchip/risc=
v-aplic.h
new file mode 100644
index 0000000..ec8f7df
--- /dev/null
+++ b/include/linux/irqchip/riscv-aplic.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+#ifndef __LINUX_IRQCHIP_RISCV_APLIC_H
+#define __LINUX_IRQCHIP_RISCV_APLIC_H
+
+#include <linux/bitops.h>
+
+#define APLIC_MAX_IDC			BIT(14)
+#define APLIC_MAX_SOURCE		1024
+
+#define APLIC_DOMAINCFG			0x0000
+#define APLIC_DOMAINCFG_RDONLY		0x80000000
+#define APLIC_DOMAINCFG_IE		BIT(8)
+#define APLIC_DOMAINCFG_DM		BIT(2)
+#define APLIC_DOMAINCFG_BE		BIT(0)
+
+#define APLIC_SOURCECFG_BASE		0x0004
+#define APLIC_SOURCECFG_D		BIT(10)
+#define APLIC_SOURCECFG_CHILDIDX_MASK	0x000003ff
+#define APLIC_SOURCECFG_SM_MASK	0x00000007
+#define APLIC_SOURCECFG_SM_INACTIVE	0x0
+#define APLIC_SOURCECFG_SM_DETACH	0x1
+#define APLIC_SOURCECFG_SM_EDGE_RISE	0x4
+#define APLIC_SOURCECFG_SM_EDGE_FALL	0x5
+#define APLIC_SOURCECFG_SM_LEVEL_HIGH	0x6
+#define APLIC_SOURCECFG_SM_LEVEL_LOW	0x7
+
+#define APLIC_MMSICFGADDR		0x1bc0
+#define APLIC_MMSICFGADDRH		0x1bc4
+#define APLIC_SMSICFGADDR		0x1bc8
+#define APLIC_SMSICFGADDRH		0x1bcc
+
+#ifdef CONFIG_RISCV_M_MODE
+#define APLIC_xMSICFGADDR		APLIC_MMSICFGADDR
+#define APLIC_xMSICFGADDRH		APLIC_MMSICFGADDRH
+#else
+#define APLIC_xMSICFGADDR		APLIC_SMSICFGADDR
+#define APLIC_xMSICFGADDRH		APLIC_SMSICFGADDRH
+#endif
+
+#define APLIC_xMSICFGADDRH_L		BIT(31)
+#define APLIC_xMSICFGADDRH_HHXS_MASK	0x1f
+#define APLIC_xMSICFGADDRH_HHXS_SHIFT	24
+#define APLIC_xMSICFGADDRH_HHXS		(APLIC_xMSICFGADDRH_HHXS_MASK << \
+					 APLIC_xMSICFGADDRH_HHXS_SHIFT)
+#define APLIC_xMSICFGADDRH_LHXS_MASK	0x7
+#define APLIC_xMSICFGADDRH_LHXS_SHIFT	20
+#define APLIC_xMSICFGADDRH_LHXS		(APLIC_xMSICFGADDRH_LHXS_MASK << \
+					 APLIC_xMSICFGADDRH_LHXS_SHIFT)
+#define APLIC_xMSICFGADDRH_HHXW_MASK	0x7
+#define APLIC_xMSICFGADDRH_HHXW_SHIFT	16
+#define APLIC_xMSICFGADDRH_HHXW		(APLIC_xMSICFGADDRH_HHXW_MASK << \
+					 APLIC_xMSICFGADDRH_HHXW_SHIFT)
+#define APLIC_xMSICFGADDRH_LHXW_MASK	0xf
+#define APLIC_xMSICFGADDRH_LHXW_SHIFT	12
+#define APLIC_xMSICFGADDRH_LHXW		(APLIC_xMSICFGADDRH_LHXW_MASK << \
+					 APLIC_xMSICFGADDRH_LHXW_SHIFT)
+#define APLIC_xMSICFGADDRH_BAPPN_MASK	0xfff
+#define APLIC_xMSICFGADDRH_BAPPN_SHIFT	0
+#define APLIC_xMSICFGADDRH_BAPPN	(APLIC_xMSICFGADDRH_BAPPN_MASK << \
+					 APLIC_xMSICFGADDRH_BAPPN_SHIFT)
+
+#define APLIC_xMSICFGADDR_PPN_SHIFT	12
+
+#define APLIC_xMSICFGADDR_PPN_HART(__lhxs) \
+	(BIT(__lhxs) - 1)
+
+#define APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) \
+	(BIT(__lhxw) - 1)
+#define APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs) \
+	((__lhxs))
+#define APLIC_xMSICFGADDR_PPN_LHX(__lhxw, __lhxs) \
+	(APLIC_xMSICFGADDR_PPN_LHX_MASK(__lhxw) << \
+	 APLIC_xMSICFGADDR_PPN_LHX_SHIFT(__lhxs))
+
+#define APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) \
+	(BIT(__hhxw) - 1)
+#define APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs) \
+	((__hhxs) + APLIC_xMSICFGADDR_PPN_SHIFT)
+#define APLIC_xMSICFGADDR_PPN_HHX(__hhxw, __hhxs) \
+	(APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
+	 APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
+
+#define APLIC_IRQBITS_PER_REG		32
+
+#define APLIC_SETIP_BASE		0x1c00
+#define APLIC_SETIPNUM			0x1cdc
+
+#define APLIC_CLRIP_BASE		0x1d00
+#define APLIC_CLRIPNUM			0x1ddc
+
+#define APLIC_SETIE_BASE		0x1e00
+#define APLIC_SETIENUM			0x1edc
+
+#define APLIC_CLRIE_BASE		0x1f00
+#define APLIC_CLRIENUM			0x1fdc
+
+#define APLIC_SETIPNUM_LE		0x2000
+#define APLIC_SETIPNUM_BE		0x2004
+
+#define APLIC_GENMSI			0x3000
+
+#define APLIC_TARGET_BASE		0x3004
+#define APLIC_TARGET_HART_IDX_SHIFT	18
+#define APLIC_TARGET_HART_IDX_MASK	0x3fff
+#define APLIC_TARGET_HART_IDX		(APLIC_TARGET_HART_IDX_MASK << \
+					 APLIC_TARGET_HART_IDX_SHIFT)
+#define APLIC_TARGET_GUEST_IDX_SHIFT	12
+#define APLIC_TARGET_GUEST_IDX_MASK	0x3f
+#define APLIC_TARGET_GUEST_IDX		(APLIC_TARGET_GUEST_IDX_MASK << \
+					 APLIC_TARGET_GUEST_IDX_SHIFT)
+#define APLIC_TARGET_IPRIO_SHIFT	0
+#define APLIC_TARGET_IPRIO_MASK		0xff
+#define APLIC_TARGET_IPRIO		(APLIC_TARGET_IPRIO_MASK << \
+					 APLIC_TARGET_IPRIO_SHIFT)
+#define APLIC_TARGET_EIID_SHIFT		0
+#define APLIC_TARGET_EIID_MASK		0x7ff
+#define APLIC_TARGET_EIID		(APLIC_TARGET_EIID_MASK << \
+					 APLIC_TARGET_EIID_SHIFT)
+
+#define APLIC_IDC_BASE			0x4000
+#define APLIC_IDC_SIZE			32
+
+#define APLIC_IDC_IDELIVERY		0x00
+
+#define APLIC_IDC_IFORCE		0x04
+
+#define APLIC_IDC_ITHRESHOLD		0x08
+
+#define APLIC_IDC_TOPI			0x18
+#define APLIC_IDC_TOPI_ID_SHIFT		16
+#define APLIC_IDC_TOPI_ID_MASK		0x3ff
+#define APLIC_IDC_TOPI_ID		(APLIC_IDC_TOPI_ID_MASK << \
+					 APLIC_IDC_TOPI_ID_SHIFT)
+#define APLIC_IDC_TOPI_PRIO_SHIFT	0
+#define APLIC_IDC_TOPI_PRIO_MASK	0xff
+#define APLIC_IDC_TOPI_PRIO		(APLIC_IDC_TOPI_PRIO_MASK << \
+					 APLIC_IDC_TOPI_PRIO_SHIFT)
+
+#define APLIC_IDC_CLAIMI		0x1c
+
+#endif

