Return-Path: <linux-kernel+bounces-117505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271E788AC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6172C5E29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EEF14D2A2;
	Mon, 25 Mar 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pC9Wzcdl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3i3141YU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3714A4D0;
	Mon, 25 Mar 2024 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385217; cv=none; b=L01JUrpJcoByblJlrED/L17YUyrHt4avVnYgjx3qNjtklKRdsnV4Yg7JGH7Cerz17PXRxVvldR6dUhQ9HT0rQdfiOHBXZlG7x7LzrXI0rwABfoIup35/DE0Ri5/U5Y1nU8LVD/2wBarF1xcv+NBYqJDFnwWOMI5MQDg4v+a4Gbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385217; c=relaxed/simple;
	bh=5JHy1NXsgqyWVcr1iYWVO8inKt9LaqHRX4NgPmuAOtc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gspmFL59wvU9tZaz1R+So1QwwbVwJa6qbH3IUm3DK4RQ0F5OHKQgZRwYWbqtwRqu4jpK8tFbY8ox9gA5LZDc8qF0FKyoxduSnz2WscTo3YCVGlfRTVMYQTKkvRI05Cr09umQTiejnqkfoglie4NQ4Iq+AKftOZTlUq+5cGDM5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pC9Wzcdl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3i3141YU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 16:46:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711385212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRZRt8tkdxiqx3TRm5besvOsCMdJIb85OQU0OPYF1TA=;
	b=pC9WzcdlUp1eP1u/gVQmx72uNbNInGbDJnXoc/2Md+Y9eriaD+lhC3u4vymNqfhAaVyciz
	p9UKTGva1RJYEiyzkNwmOJ0XDc0SQ4rKlW/hk2rOa3PgmApFDibNuJ/EjR25GQ7ZSU08Oa
	baUdllEPxWgikwUK03jg0FGN8QTgLGID6IgduZkqEpDrs/yGE2htZF8GNiptl4FnGD4lJs
	oI9sTu3nWliRqcB1uCH9fCifF1fMHR9Iqzgan6Rt+MlFUMkbc2AwkUGVmp3DDkMsX0VSEQ
	FsSqAFT8gvAbg3JejLKEikBOMQJyPNVq2IjEycBmBcrDqzf9kv1Lm6cesPgi2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711385212;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRZRt8tkdxiqx3TRm5besvOsCMdJIb85OQU0OPYF1TA=;
	b=3i3141YUW9LWCJHbqN0CJDI+g5STf/caggCv6SxboCkCvV0wFEf42vyWy2GVDgdZKXk6UK
	RvgjzqOduzgHCHAw==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip: Add RISC-V incoming MSI controller early driver
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 bjorn@rivosinc.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240307140307.646078-3-apatel@ventanamicro.com>
References: <20240307140307.646078-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171138521125.10875.17215796232935000909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     21a8f8a0eb35ceb21e2c9ddd87468bc3b5ac87c0
Gitweb:        https://git.kernel.org/tip/21a8f8a0eb35ceb21e2c9ddd87468bc3b5a=
c87c0
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Thu, 07 Mar 2024 19:33:00 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 25 Mar 2024 17:38:28 +01:00

irqchip: Add RISC-V incoming MSI controller early driver

The RISC-V advanced interrupt architecture (AIA) specification
defines a new MSI controller called incoming message signalled
interrupt controller (IMSIC) which manages MSI on per-HART (or
per-CPU) basis. It also supports IPIs as software injected MSIs.
(For more details refer https://github.com/riscv/riscv-aia)

Add an early irqchip driver for RISC-V IMSIC which sets up the
IMSIC state and provide IPIs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Link: https://lore.kernel.org/r/20240307140307.646078-3-apatel@ventanamicro.c=
om

---
 drivers/irqchip/Kconfig                 |   7 +-
 drivers/irqchip/Makefile                |   1 +-
 drivers/irqchip/irq-riscv-imsic-early.c | 201 +++++-
 drivers/irqchip/irq-riscv-imsic-state.c | 865 +++++++++++++++++++++++-
 drivers/irqchip/irq-riscv-imsic-state.h | 107 +++-
 include/linux/cpuhotplug.h              |   1 +-
 include/linux/irqchip/riscv-imsic.h     |  87 ++-
 7 files changed, 1269 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
 create mode 100644 include/linux/irqchip/riscv-imsic.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 72c07a1..8610810 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -540,6 +540,13 @@ config RISCV_INTC
 	depends on RISCV
 	select IRQ_DOMAIN_HIERARCHY
=20
+config RISCV_IMSIC
+	bool
+	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_MATRIX_ALLOCATOR
+	select GENERIC_MSI_IRQ
+
 config SIFIVE_PLIC
 	bool
 	depends on RISCV
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ec4a183..972aa9f 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+=3D irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+=3D irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+=3D irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+=3D irq-riscv-intc.o
+obj-$(CONFIG_RISCV_IMSIC)		+=3D irq-riscv-imsic-state.o irq-riscv-imsic-earl=
y.o
 obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
 obj-$(CONFIG_STARFIVE_JH8100_INTC)	+=3D irq-starfive-jh8100-intc.o
 obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-ri=
scv-imsic-early.c
new file mode 100644
index 0000000..886418e
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-imsic-state.h"
+
+static int imsic_parent_irq;
+
+#ifdef CONFIG_SMP
+static void imsic_ipi_send(unsigned int cpu)
+{
+	struct imsic_local_config *local =3D per_cpu_ptr(imsic->global.local, cpu);
+
+	writel_relaxed(IMSIC_IPI_ID, local->msi_va);
+}
+
+static void imsic_ipi_starting_cpu(void)
+{
+	/* Enable IPIs for current CPU. */
+	__imsic_id_set_enable(IMSIC_IPI_ID);
+}
+
+static void imsic_ipi_dying_cpu(void)
+{
+	/* Disable IPIs for current CPU. */
+	__imsic_id_clear_enable(IMSIC_IPI_ID);
+}
+
+static int __init imsic_ipi_domain_init(void)
+{
+	int virq;
+
+	/* Create IMSIC IPI multiplexing */
+	virq =3D ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
+	if (virq <=3D 0)
+		return virq < 0 ? virq : -ENOMEM;
+
+	/* Set vIRQ range */
+	riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
+
+	/* Announce that IMSIC is providing IPIs */
+	pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwnode, IMSIC_=
IPI_ID);
+
+	return 0;
+}
+#else
+static void imsic_ipi_starting_cpu(void) { }
+static void imsic_ipi_dying_cpu(void) { }
+static int __init imsic_ipi_domain_init(void) { return 0; }
+#endif
+
+/*
+ * To handle an interrupt, we read the TOPEI CSR and write zero in one
+ * instruction. If TOPEI CSR is non-zero then we translate TOPEI.ID to
+ * Linux interrupt number and let Linux IRQ subsystem handle it.
+ */
+static void imsic_handle_irq(struct irq_desc *desc)
+{
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	int err, cpu =3D smp_processor_id();
+	struct imsic_vector *vec;
+	unsigned long local_id;
+
+	chained_irq_enter(chip, desc);
+
+	while ((local_id =3D csr_swap(CSR_TOPEI, 0))) {
+		local_id >>=3D TOPEI_ID_SHIFT;
+
+		if (local_id =3D=3D IMSIC_IPI_ID) {
+			if (IS_ENABLED(CONFIG_SMP))
+				ipi_mux_process();
+			continue;
+		}
+
+		if (unlikely(!imsic->base_domain))
+			continue;
+
+		vec =3D imsic_vector_from_local_id(cpu, local_id);
+		if (!vec) {
+			pr_warn_ratelimited("vector not found for local ID 0x%lx\n", local_id);
+			continue;
+		}
+
+		err =3D generic_handle_domain_irq(imsic->base_domain, vec->hwirq);
+		if (unlikely(err))
+			pr_warn_ratelimited("hwirq 0x%x mapping not found\n", vec->hwirq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int imsic_starting_cpu(unsigned int cpu)
+{
+	/* Mark per-CPU IMSIC state as online */
+	imsic_state_online();
+
+	/* Enable per-CPU parent interrupt */
+	enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_parent_irq));
+
+	/* Setup IPIs */
+	imsic_ipi_starting_cpu();
+
+	/*
+	 * Interrupts identities might have been enabled/disabled while
+	 * this CPU was not running so sync-up local enable/disable state.
+	 */
+	imsic_local_sync_all();
+
+	/* Enable local interrupt delivery */
+	imsic_local_delivery(true);
+
+	return 0;
+}
+
+static int imsic_dying_cpu(unsigned int cpu)
+{
+	/* Cleanup IPIs */
+	imsic_ipi_dying_cpu();
+
+	/* Mark per-CPU IMSIC state as offline */
+	imsic_state_offline();
+
+	return 0;
+}
+
+static int __init imsic_early_probe(struct fwnode_handle *fwnode)
+{
+	struct irq_domain *domain;
+	int rc;
+
+	/* Find parent domain and register chained handler */
+	domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY=
);
+	if (!domain) {
+		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
+		return -ENOENT;
+	}
+	imsic_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
+	if (!imsic_parent_irq) {
+		pr_err("%pfwP: Failed to create INTC mapping\n", fwnode);
+		return -ENOENT;
+	}
+
+	/* Initialize IPI domain */
+	rc =3D imsic_ipi_domain_init();
+	if (rc) {
+		pr_err("%pfwP: Failed to initialize IPI domain\n", fwnode);
+		return rc;
+	}
+
+	/* Setup chained handler to the parent domain interrupt */
+	irq_set_chained_handler(imsic_parent_irq, imsic_handle_irq);
+
+	/*
+	 * Setup cpuhp state (must be done after setting imsic_parent_irq)
+	 *
+	 * Don't disable per-CPU IMSIC file when CPU goes offline
+	 * because this affects IPI and the masking/unmasking of
+	 * virtual IPIs is done via generic IPI-Mux
+	 */
+	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/riscv/imsic:s=
tarting",
+			  imsic_starting_cpu, imsic_dying_cpu);
+
+	return 0;
+}
+
+static int __init imsic_early_dt_init(struct device_node *node, struct devic=
e_node *parent)
+{
+	struct fwnode_handle *fwnode =3D &node->fwnode;
+	int rc;
+
+	/* Setup IMSIC state */
+	rc =3D imsic_setup_state(fwnode);
+	if (rc) {
+		pr_err("%pfwP: failed to setup state (error %d)\n", fwnode, rc);
+		return rc;
+	}
+
+	/* Do early setup of IPIs */
+	rc =3D imsic_early_probe(fwnode);
+	if (rc)
+		return rc;
+
+	/* Ensure that OF platform device gets probed */
+	of_node_clear_flag(node, OF_POPULATED);
+	return 0;
+}
+
+IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-ri=
scv-imsic-state.c
new file mode 100644
index 0000000..5479f87
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -0,0 +1,865 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/cpu.h>
+#include <linux/bitmap.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <asm/hwcap.h>
+
+#include "irq-riscv-imsic-state.h"
+
+#define IMSIC_DISABLE_EIDELIVERY		0
+#define IMSIC_ENABLE_EIDELIVERY			1
+#define IMSIC_DISABLE_EITHRESHOLD		1
+#define IMSIC_ENABLE_EITHRESHOLD		0
+
+static inline void imsic_csr_write(unsigned long reg, unsigned long val)
+{
+	csr_write(CSR_ISELECT, reg);
+	csr_write(CSR_IREG, val);
+}
+
+static inline unsigned long imsic_csr_read(unsigned long reg)
+{
+	csr_write(CSR_ISELECT, reg);
+	return csr_read(CSR_IREG);
+}
+
+static inline unsigned long imsic_csr_read_clear(unsigned long reg, unsigned=
 long val)
+{
+	csr_write(CSR_ISELECT, reg);
+	return csr_read_clear(CSR_IREG, val);
+}
+
+static inline void imsic_csr_set(unsigned long reg, unsigned long val)
+{
+	csr_write(CSR_ISELECT, reg);
+	csr_set(CSR_IREG, val);
+}
+
+static inline void imsic_csr_clear(unsigned long reg, unsigned long val)
+{
+	csr_write(CSR_ISELECT, reg);
+	csr_clear(CSR_IREG, val);
+}
+
+struct imsic_priv *imsic;
+
+const struct imsic_global_config *imsic_get_global_config(void)
+{
+	return imsic ? &imsic->global : NULL;
+}
+EXPORT_SYMBOL_GPL(imsic_get_global_config);
+
+static bool __imsic_eix_read_clear(unsigned long id, bool pend)
+{
+	unsigned long isel, imask;
+
+	isel =3D id / BITS_PER_LONG;
+	isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
+	isel +=3D pend ? IMSIC_EIP0 : IMSIC_EIE0;
+	imask =3D BIT(id & (__riscv_xlen - 1));
+
+	return !!(imsic_csr_read_clear(isel, imask) & imask);
+}
+
+static inline bool __imsic_id_read_clear_enabled(unsigned long id)
+{
+	return __imsic_eix_read_clear(id, false);
+}
+
+static inline bool __imsic_id_read_clear_pending(unsigned long id)
+{
+	return __imsic_eix_read_clear(id, true);
+}
+
+void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pe=
nd, bool val)
+{
+	unsigned long id =3D base_id, last_id =3D base_id + num_id;
+	unsigned long i, isel, ireg;
+
+	while (id < last_id) {
+		isel =3D id / BITS_PER_LONG;
+		isel *=3D BITS_PER_LONG / IMSIC_EIPx_BITS;
+		isel +=3D pend ? IMSIC_EIP0 : IMSIC_EIE0;
+
+		/*
+		 * Prepare the ID mask to be programmed in the
+		 * IMSIC EIEx and EIPx registers. These registers
+		 * are XLEN-wide and we must not touch IDs which
+		 * are < base_id and >=3D (base_id + num_id).
+		 */
+		ireg =3D 0;
+		for (i =3D id & (__riscv_xlen - 1); id < last_id && i < __riscv_xlen; i++)=
 {
+			ireg |=3D BIT(i);
+			id++;
+		}
+
+		/*
+		 * The IMSIC EIEx and EIPx registers are indirectly
+		 * accessed via using ISELECT and IREG CSRs so we
+		 * need to access these CSRs without getting preempted.
+		 *
+		 * All existing users of this function call this
+		 * function with local IRQs disabled so we don't
+		 * need to do anything special here.
+		 */
+		if (val)
+			imsic_csr_set(isel, ireg);
+		else
+			imsic_csr_clear(isel, ireg);
+	}
+}
+
+static void __imsic_local_sync(struct imsic_local_priv *lpriv)
+{
+	struct imsic_local_config *mlocal;
+	struct imsic_vector *vec, *mvec;
+	int i;
+
+	lockdep_assert_held(&lpriv->lock);
+
+	for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1) {
+		if (!i || i =3D=3D IMSIC_IPI_ID)
+			goto skip;
+		vec =3D &lpriv->vectors[i];
+
+		if (READ_ONCE(vec->enable))
+			__imsic_id_set_enable(i);
+		else
+			__imsic_id_clear_enable(i);
+
+		/*
+		 * If the ID was being moved to a new ID on some other CPU
+		 * then we can get a MSI during the movement so check the
+		 * ID pending bit and re-trigger the new ID on other CPU
+		 * using MMIO write.
+		 */
+		mvec =3D READ_ONCE(vec->move);
+		WRITE_ONCE(vec->move, NULL);
+		if (mvec && mvec !=3D vec) {
+			if (__imsic_id_read_clear_pending(i)) {
+				mlocal =3D per_cpu_ptr(imsic->global.local, mvec->cpu);
+				writel_relaxed(mvec->local_id, mlocal->msi_va);
+			}
+
+			imsic_vector_free(&lpriv->vectors[i]);
+		}
+
+skip:
+		bitmap_clear(lpriv->dirty_bitmap, i, 1);
+	}
+}
+
+void imsic_local_sync_all(void)
+{
+	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+	bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
+	__imsic_local_sync(lpriv);
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+}
+
+void imsic_local_delivery(bool enable)
+{
+	if (enable) {
+		imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_ENABLE_EITHRESHOLD);
+		imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_ENABLE_EIDELIVERY);
+		return;
+	}
+
+	imsic_csr_write(IMSIC_EIDELIVERY, IMSIC_DISABLE_EIDELIVERY);
+	imsic_csr_write(IMSIC_EITHRESHOLD, IMSIC_DISABLE_EITHRESHOLD);
+}
+
+#ifdef CONFIG_SMP
+static void imsic_local_timer_callback(struct timer_list *timer)
+{
+	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+	__imsic_local_sync(lpriv);
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+}
+
+static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int=
 cpu)
+{
+	lockdep_assert_held(&lpriv->lock);
+
+	/*
+	 * The spinlock acquire/release semantics ensure that changes
+	 * to vector enable, vector move and dirty bitmap are visible
+	 * to the target CPU.
+	 */
+
+	/*
+	 * We schedule a timer on the target CPU if the target CPU is not
+	 * same as the current CPU. An offline CPU will unconditionally
+	 * synchronize IDs through imsic_starting_cpu() when the
+	 * CPU is brought up.
+	 */
+	if (cpu_online(cpu)) {
+		if (cpu =3D=3D smp_processor_id()) {
+			__imsic_local_sync(lpriv);
+			return;
+		}
+
+		if (!timer_pending(&lpriv->timer)) {
+			lpriv->timer.expires =3D jiffies + 1;
+			add_timer_on(&lpriv->timer, cpu);
+		}
+	}
+}
+#else
+static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int=
 cpu)
+{
+	lockdep_assert_held(&lpriv->lock);
+	__imsic_local_sync(lpriv);
+}
+#endif
+
+void imsic_vector_mask(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+
+	lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
+		return;
+
+	/*
+	 * This function is called through Linux irq subsystem with
+	 * irqs disabled so no need to save/restore irq flags.
+	 */
+
+	raw_spin_lock(&lpriv->lock);
+
+	WRITE_ONCE(vec->enable, false);
+	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
+	__imsic_remote_sync(lpriv, vec->cpu);
+
+	raw_spin_unlock(&lpriv->lock);
+}
+
+void imsic_vector_unmask(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+
+	lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
+		return;
+
+	/*
+	 * This function is called through Linux irq subsystem with
+	 * irqs disabled so no need to save/restore irq flags.
+	 */
+
+	raw_spin_lock(&lpriv->lock);
+
+	WRITE_ONCE(vec->enable, true);
+	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
+	__imsic_remote_sync(lpriv, vec->cpu);
+
+	raw_spin_unlock(&lpriv->lock);
+}
+
+static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct =
imsic_vector *vec,
+				     bool new_enable, struct imsic_vector *new_move)
+{
+	unsigned long flags;
+	bool enabled;
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+
+	/* Update enable and move details */
+	enabled =3D READ_ONCE(vec->enable);
+	WRITE_ONCE(vec->enable, new_enable);
+	WRITE_ONCE(vec->move, new_move);
+
+	/* Mark the vector as dirty and synchronize */
+	bitmap_set(lpriv->dirty_bitmap, vec->local_id, 1);
+	__imsic_remote_sync(lpriv, vec->cpu);
+
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+
+	return enabled;
+}
+
+void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *ne=
w_vec)
+{
+	struct imsic_local_priv *old_lpriv, *new_lpriv;
+	bool enabled;
+
+	if (WARN_ON_ONCE(old_vec->cpu =3D=3D new_vec->cpu))
+		return;
+
+	old_lpriv =3D per_cpu_ptr(imsic->lpriv, old_vec->cpu);
+	if (WARN_ON_ONCE(&old_lpriv->vectors[old_vec->local_id] !=3D old_vec))
+		return;
+
+	new_lpriv =3D per_cpu_ptr(imsic->lpriv, new_vec->cpu);
+	if (WARN_ON_ONCE(&new_lpriv->vectors[new_vec->local_id] !=3D new_vec))
+		return;
+
+	/*
+	 * Move and re-trigger the new vector based on the pending
+	 * state of the old vector because we might get a device
+	 * interrupt on the old vector while device was being moved
+	 * to the new vector.
+	 */
+	enabled =3D imsic_vector_move_update(old_lpriv, old_vec, false, new_vec);
+	imsic_vector_move_update(new_lpriv, new_vec, enabled, new_vec);
+}
+
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, i=
nt ind)
+{
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *mvec;
+	bool is_enabled;
+
+	lpriv =3D per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] !=3D vec))
+		return;
+
+	is_enabled =3D imsic_vector_isenabled(vec);
+	mvec =3D imsic_vector_get_move(vec);
+
+	seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
+	seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_id);
+	seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
+		   (vec->local_id <=3D IMSIC_IPI_ID) ? 1 : 0);
+	seq_printf(m, "%*sis_enabled      : %5u\n", ind, "", is_enabled ? 1 : 0);
+	seq_printf(m, "%*sis_move_pending : %5u\n", ind, "", mvec ? 1 : 0);
+	if (mvec) {
+		seq_printf(m, "%*smove_cpu        : %5u\n", ind, "", mvec->cpu);
+		seq_printf(m, "%*smove_local_id   : %5u\n", ind, "", mvec->local_id);
+	}
+}
+
+void imsic_vector_debug_show_summary(struct seq_file *m, int ind)
+{
+	irq_matrix_debug_show(m, imsic->matrix, ind);
+}
+#endif
+
+struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned i=
nt local_id)
+{
+	struct imsic_local_priv *lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
+
+	if (!lpriv || imsic->global.nr_ids < local_id)
+		return NULL;
+
+	return &lpriv->vectors[local_id];
+}
+
+struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpu=
mask *mask)
+{
+	struct imsic_vector *vec =3D NULL;
+	struct imsic_local_priv *lpriv;
+	unsigned long flags;
+	unsigned int cpu;
+	int local_id;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	local_id =3D irq_matrix_alloc(imsic->matrix, mask, false, &cpu);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+	if (local_id < 0)
+		return NULL;
+
+	lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
+	vec =3D &lpriv->vectors[local_id];
+	vec->hwirq =3D hwirq;
+	vec->enable =3D false;
+	vec->move =3D NULL;
+
+	return vec;
+}
+
+void imsic_vector_free(struct imsic_vector *vec)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	vec->hwirq =3D UINT_MAX;
+	irq_matrix_free(imsic->matrix, vec->cpu, vec->local_id, false);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+}
+
+static void __init imsic_local_cleanup(void)
+{
+	struct imsic_local_priv *lpriv;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
+
+		bitmap_free(lpriv->dirty_bitmap);
+		kfree(lpriv->vectors);
+	}
+
+	free_percpu(imsic->lpriv);
+}
+
+static int __init imsic_local_init(void)
+{
+	struct imsic_global_config *global =3D &imsic->global;
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *vec;
+	int cpu, i;
+
+	/* Allocate per-CPU private state */
+	imsic->lpriv =3D alloc_percpu(typeof(*imsic->lpriv));
+	if (!imsic->lpriv)
+		return -ENOMEM;
+
+	/* Setup per-CPU private state */
+	for_each_possible_cpu(cpu) {
+		lpriv =3D per_cpu_ptr(imsic->lpriv, cpu);
+
+		raw_spin_lock_init(&lpriv->lock);
+
+		/* Allocate dirty bitmap */
+		lpriv->dirty_bitmap =3D bitmap_zalloc(global->nr_ids + 1, GFP_KERNEL);
+		if (!lpriv->dirty_bitmap)
+			goto fail_local_cleanup;
+
+#ifdef CONFIG_SMP
+		/* Setup lazy timer for synchronization */
+		timer_setup(&lpriv->timer, imsic_local_timer_callback, TIMER_PINNED);
+#endif
+
+		/* Allocate vector array */
+		lpriv->vectors =3D kcalloc(global->nr_ids + 1, sizeof(*lpriv->vectors),
+					 GFP_KERNEL);
+		if (!lpriv->vectors)
+			goto fail_local_cleanup;
+
+		/* Setup vector array */
+		for (i =3D 0; i <=3D global->nr_ids; i++) {
+			vec =3D &lpriv->vectors[i];
+			vec->cpu =3D cpu;
+			vec->local_id =3D i;
+			vec->hwirq =3D UINT_MAX;
+		}
+	}
+
+	return 0;
+
+fail_local_cleanup:
+	imsic_local_cleanup();
+	return -ENOMEM;
+}
+
+void imsic_state_online(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	irq_matrix_online(imsic->matrix);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+}
+
+void imsic_state_offline(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	irq_matrix_offline(imsic->matrix);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+
+#ifdef CONFIG_SMP
+	struct imsic_local_priv *lpriv =3D this_cpu_ptr(imsic->lpriv);
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+	WARN_ON_ONCE(try_to_del_timer_sync(&lpriv->timer) < 0);
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+#endif
+}
+
+static int __init imsic_matrix_init(void)
+{
+	struct imsic_global_config *global =3D &imsic->global;
+
+	raw_spin_lock_init(&imsic->matrix_lock);
+	imsic->matrix =3D irq_alloc_matrix(global->nr_ids + 1,
+					 0, global->nr_ids + 1);
+	if (!imsic->matrix)
+		return -ENOMEM;
+
+	/* Reserve ID#0 because it is special and never implemented */
+	irq_matrix_assign_system(imsic->matrix, 0, false);
+
+	/* Reserve IPI ID because it is special and used internally */
+	irq_matrix_assign_system(imsic->matrix, IMSIC_IPI_ID, false);
+
+	return 0;
+}
+
+static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
+					  u32 index, unsigned long *hartid)
+{
+	struct of_phandle_args parent;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	rc =3D of_irq_parse_one(to_of_node(fwnode), index, &parent);
+	if (rc)
+		return rc;
+
+	/*
+	 * Skip interrupts other than external interrupts for
+	 * current privilege level.
+	 */
+	if (parent.args[0] !=3D RV_IRQ_EXT)
+		return -EINVAL;
+
+	return riscv_of_parent_hartid(parent.np, hartid);
+}
+
+static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
+					  u32 index, struct resource *res)
+{
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	return of_address_to_resource(to_of_node(fwnode), index, res);
+}
+
+static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
+				     struct imsic_global_config *global,
+				     u32 *nr_parent_irqs,
+				     u32 *nr_mmios)
+{
+	unsigned long hartid;
+	struct resource res;
+	int rc;
+	u32 i;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	*nr_parent_irqs =3D 0;
+	*nr_mmios =3D 0;
+
+	/* Find number of parent interrupts */
+	while (!imsic_get_parent_hartid(fwnode, *nr_parent_irqs, &hartid))
+		(*nr_parent_irqs)++;
+	if (!*nr_parent_irqs) {
+		pr_err("%pfwP: no parent irqs available\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Find number of guest index bits in MSI address */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,guest-index-bits",
+				  &global->guest_index_bits);
+	if (rc)
+		global->guest_index_bits =3D 0;
+
+	/* Find number of HART index bits */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,hart-index-bits",
+				  &global->hart_index_bits);
+	if (rc) {
+		/* Assume default value */
+		global->hart_index_bits =3D __fls(*nr_parent_irqs);
+		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
+			global->hart_index_bits++;
+	}
+
+	/* Find number of group index bits */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-index-bits",
+				  &global->group_index_bits);
+	if (rc)
+		global->group_index_bits =3D 0;
+
+	/*
+	 * Find first bit position of group index.
+	 * If not specified assumed the default APLIC-IMSIC configuration.
+	 */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
+				  &global->group_index_shift);
+	if (rc)
+		global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2;
+
+	/* Find number of interrupt identities */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
+				  &global->nr_ids);
+	if (rc) {
+		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
+		return rc;
+	}
+
+	/* Find number of guest interrupt identities */
+	rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
+				  &global->nr_guest_ids);
+	if (rc)
+		global->nr_guest_ids =3D global->nr_ids;
+
+	/* Sanity check guest index bits */
+	i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
+	if (i < global->guest_index_bits) {
+		pr_err("%pfwP: guest index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check HART index bits */
+	i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT - global->guest_index_bits;
+	if (i < global->hart_index_bits) {
+		pr_err("%pfwP: HART index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check group index bits */
+	i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
+	    global->guest_index_bits - global->hart_index_bits;
+	if (i < global->group_index_bits) {
+		pr_err("%pfwP: group index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check group index shift */
+	i =3D global->group_index_bits + global->group_index_shift - 1;
+	if (i >=3D BITS_PER_LONG) {
+		pr_err("%pfwP: group index shift too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check number of interrupt identities */
+	if (global->nr_ids < IMSIC_MIN_ID ||
+	    global->nr_ids >=3D IMSIC_MAX_ID ||
+	    (global->nr_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID) {
+		pr_err("%pfwP: invalid number of interrupt identities\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check number of guest interrupt identities */
+	if (global->nr_guest_ids < IMSIC_MIN_ID ||
+	    global->nr_guest_ids >=3D IMSIC_MAX_ID ||
+	    (global->nr_guest_ids & IMSIC_MIN_ID) !=3D IMSIC_MIN_ID) {
+		pr_err("%pfwP: invalid number of guest interrupt identities\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Compute base address */
+	rc =3D imsic_get_mmio_resource(fwnode, 0, &res);
+	if (rc) {
+		pr_err("%pfwP: first MMIO resource not found\n", fwnode);
+		return -EINVAL;
+	}
+	global->base_addr =3D res.start;
+	global->base_addr &=3D ~(BIT(global->guest_index_bits +
+				   global->hart_index_bits +
+				   IMSIC_MMIO_PAGE_SHIFT) - 1);
+	global->base_addr &=3D ~((BIT(global->group_index_bits) - 1) <<
+			       global->group_index_shift);
+
+	/* Find number of MMIO register sets */
+	while (!imsic_get_mmio_resource(fwnode, *nr_mmios, &res))
+		(*nr_mmios)++;
+
+	return 0;
+}
+
+int __init imsic_setup_state(struct fwnode_handle *fwnode)
+{
+	u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers =3D 0;
+	struct imsic_global_config *global;
+	struct imsic_local_config *local;
+	void __iomem **mmios_va =3D NULL;
+	struct resource *mmios =3D NULL;
+	unsigned long reloff, hartid;
+	phys_addr_t base_addr;
+	int rc, cpu;
+
+	/*
+	 * Only one IMSIC instance allowed in a platform for clean
+	 * implementation of SMP IRQ affinity and per-CPU IPIs.
+	 *
+	 * This means on a multi-socket (or multi-die) platform we
+	 * will have multiple MMIO regions for one IMSIC instance.
+	 */
+	if (imsic) {
+		pr_err("%pfwP: already initialized hence ignoring\n", fwnode);
+		return -EALREADY;
+	}
+
+	if (!riscv_isa_extension_available(NULL, SxAIA)) {
+		pr_err("%pfwP: AIA support not available\n", fwnode);
+		return -ENODEV;
+	}
+
+	imsic =3D kzalloc(sizeof(*imsic), GFP_KERNEL);
+	if (!imsic)
+		return -ENOMEM;
+	imsic->fwnode =3D fwnode;
+	global =3D &imsic->global;
+
+	global->local =3D alloc_percpu(typeof(*global->local));
+	if (!global->local) {
+		rc =3D -ENOMEM;
+		goto out_free_priv;
+	}
+
+	/* Parse IMSIC fwnode */
+	rc =3D imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios);
+	if (rc)
+		goto out_free_local;
+
+	/* Allocate MMIO resource array */
+	mmios =3D kcalloc(nr_mmios, sizeof(*mmios), GFP_KERNEL);
+	if (!mmios) {
+		rc =3D -ENOMEM;
+		goto out_free_local;
+	}
+
+	/* Allocate MMIO virtual address array */
+	mmios_va =3D kcalloc(nr_mmios, sizeof(*mmios_va), GFP_KERNEL);
+	if (!mmios_va) {
+		rc =3D -ENOMEM;
+		goto out_iounmap;
+	}
+
+	/* Parse and map MMIO register sets */
+	for (i =3D 0; i < nr_mmios; i++) {
+		rc =3D imsic_get_mmio_resource(fwnode, i, &mmios[i]);
+		if (rc) {
+			pr_err("%pfwP: unable to parse MMIO regset %d\n", fwnode, i);
+			goto out_iounmap;
+		}
+
+		base_addr =3D mmios[i].start;
+		base_addr &=3D ~(BIT(global->guest_index_bits +
+				   global->hart_index_bits +
+				   IMSIC_MMIO_PAGE_SHIFT) - 1);
+		base_addr &=3D ~((BIT(global->group_index_bits) - 1) <<
+			       global->group_index_shift);
+		if (base_addr !=3D global->base_addr) {
+			rc =3D -EINVAL;
+			pr_err("%pfwP: address mismatch for regset %d\n", fwnode, i);
+			goto out_iounmap;
+		}
+
+		mmios_va[i] =3D ioremap(mmios[i].start, resource_size(&mmios[i]));
+		if (!mmios_va[i]) {
+			rc =3D -EIO;
+			pr_err("%pfwP: unable to map MMIO regset %d\n", fwnode, i);
+			goto out_iounmap;
+		}
+	}
+
+	/* Initialize local (or per-CPU )state */
+	rc =3D imsic_local_init();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize local state\n",
+		       fwnode);
+		goto out_iounmap;
+	}
+
+	/* Configure handlers for target CPUs */
+	for (i =3D 0; i < nr_parent_irqs; i++) {
+		rc =3D imsic_get_parent_hartid(fwnode, i, &hartid);
+		if (rc) {
+			pr_warn("%pfwP: hart ID for parent irq%d not found\n", fwnode, i);
+			continue;
+		}
+
+		cpu =3D riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("%pfwP: invalid cpuid for parent irq%d\n", fwnode, i);
+			continue;
+		}
+
+		/* Find MMIO location of MSI page */
+		index =3D nr_mmios;
+		reloff =3D i * BIT(global->guest_index_bits) *
+			 IMSIC_MMIO_PAGE_SZ;
+		for (j =3D 0; nr_mmios; j++) {
+			if (reloff < resource_size(&mmios[j])) {
+				index =3D j;
+				break;
+			}
+
+			/*
+			 * MMIO region size may not be aligned to
+			 * BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ
+			 * if holes are present.
+			 */
+			reloff -=3D ALIGN(resource_size(&mmios[j]),
+			BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ);
+		}
+		if (index >=3D nr_mmios) {
+			pr_warn("%pfwP: MMIO not found for parent irq%d\n", fwnode, i);
+			continue;
+		}
+
+		local =3D per_cpu_ptr(global->local, cpu);
+		local->msi_pa =3D mmios[index].start + reloff;
+		local->msi_va =3D mmios_va[index] + reloff;
+
+		nr_handlers++;
+	}
+
+	/* If no CPU handlers found then can't take interrupts */
+	if (!nr_handlers) {
+		pr_err("%pfwP: No CPU handlers found\n", fwnode);
+		rc =3D -ENODEV;
+		goto out_local_cleanup;
+	}
+
+	/* Initialize matrix allocator */
+	rc =3D imsic_matrix_init();
+	if (rc) {
+		pr_err("%pfwP: failed to create matrix allocator\n", fwnode);
+		goto out_local_cleanup;
+	}
+
+	/* We don't need MMIO arrays anymore so let's free-up */
+	kfree(mmios_va);
+	kfree(mmios);
+
+	return 0;
+
+out_local_cleanup:
+	imsic_local_cleanup();
+out_iounmap:
+	for (i =3D 0; i < nr_mmios; i++) {
+		if (mmios_va[i])
+			iounmap(mmios_va[i]);
+	}
+	kfree(mmios_va);
+	kfree(mmios);
+out_free_local:
+	free_percpu(imsic->global.local);
+out_free_priv:
+	kfree(imsic);
+	imsic =3D NULL;
+	return rc;
+}
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-ri=
scv-imsic-state.h
new file mode 100644
index 0000000..8ec9649
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#ifndef _IRQ_RISCV_IMSIC_STATE_H
+#define _IRQ_RISCV_IMSIC_STATE_H
+
+#include <linux/irqchip/riscv-imsic.h>
+#include <linux/irqdomain.h>
+#include <linux/fwnode.h>
+#include <linux/timer.h>
+
+#define IMSIC_IPI_ID				1
+#define IMSIC_NR_IPI				8
+
+struct imsic_vector {
+	/* Fixed details of the vector */
+	unsigned int				cpu;
+	unsigned int				local_id;
+	/* Details saved by driver in the vector */
+	unsigned int				hwirq;
+	/* Details accessed using local lock held */
+	bool					enable;
+	struct imsic_vector			*move;
+};
+
+struct imsic_local_priv {
+	/* Local lock to protect vector enable/move variables and dirty bitmap */
+	raw_spinlock_t				lock;
+
+	/* Local dirty bitmap for synchronization */
+	unsigned long				*dirty_bitmap;
+
+#ifdef CONFIG_SMP
+	/* Local timer for synchronization */
+	struct timer_list			timer;
+#endif
+
+	/* Local vector table */
+	struct imsic_vector			*vectors;
+};
+
+struct imsic_priv {
+	/* Device details */
+	struct fwnode_handle			*fwnode;
+
+	/* Global configuration common for all HARTs */
+	struct imsic_global_config		global;
+
+	/* Per-CPU state */
+	struct imsic_local_priv __percpu	*lpriv;
+
+	/* State of IRQ matrix allocator */
+	raw_spinlock_t				matrix_lock;
+	struct irq_matrix			*matrix;
+
+	/* IRQ domains (created by platform driver) */
+	struct irq_domain			*base_domain;
+};
+
+extern struct imsic_priv *imsic;
+
+void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pe=
nd, bool val);
+
+static inline void __imsic_id_set_enable(unsigned long id)
+{
+	__imsic_eix_update(id, 1, false, true);
+}
+
+static inline void __imsic_id_clear_enable(unsigned long id)
+{
+	__imsic_eix_update(id, 1, false, false);
+}
+
+void imsic_local_sync_all(void);
+void imsic_local_delivery(bool enable);
+
+void imsic_vector_mask(struct imsic_vector *vec);
+void imsic_vector_unmask(struct imsic_vector *vec);
+
+static inline bool imsic_vector_isenabled(struct imsic_vector *vec)
+{
+	return READ_ONCE(vec->enable);
+}
+
+static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector=
 *vec)
+{
+	return READ_ONCE(vec->move);
+}
+
+void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *ne=
w_vec);
+
+struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned i=
nt local_id);
+
+struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpu=
mask *mask);
+void imsic_vector_free(struct imsic_vector *vector);
+
+void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, i=
nt ind);
+void imsic_vector_debug_show_summary(struct seq_file *m, int ind);
+
+void imsic_state_online(void);
+void imsic_state_offline(void);
+int imsic_setup_state(struct fwnode_handle *fwnode);
+
+#endif
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 35e78dd..7a5785f 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -146,6 +146,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_MIPS_GIC_STARTING,
 	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+	CPUHP_AP_IRQ_RISCV_IMSIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/risc=
v-imsic.h
new file mode 100644
index 0000000..faf0b80
--- /dev/null
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+#ifndef __LINUX_IRQCHIP_RISCV_IMSIC_H
+#define __LINUX_IRQCHIP_RISCV_IMSIC_H
+
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <asm/csr.h>
+
+#define IMSIC_MMIO_PAGE_SHIFT		12
+#define IMSIC_MMIO_PAGE_SZ		BIT(IMSIC_MMIO_PAGE_SHIFT)
+#define IMSIC_MMIO_PAGE_LE		0x00
+#define IMSIC_MMIO_PAGE_BE		0x04
+
+#define IMSIC_MIN_ID			63
+#define IMSIC_MAX_ID			2048
+
+#define IMSIC_EIDELIVERY		0x70
+
+#define IMSIC_EITHRESHOLD		0x72
+
+#define IMSIC_EIP0			0x80
+#define IMSIC_EIP63			0xbf
+#define IMSIC_EIPx_BITS			32
+
+#define IMSIC_EIE0			0xc0
+#define IMSIC_EIE63			0xff
+#define IMSIC_EIEx_BITS			32
+
+#define IMSIC_FIRST			IMSIC_EIDELIVERY
+#define IMSIC_LAST			IMSIC_EIE63
+
+#define IMSIC_MMIO_SETIPNUM_LE		0x00
+#define IMSIC_MMIO_SETIPNUM_BE		0x04
+
+struct imsic_local_config {
+	phys_addr_t				msi_pa;
+	void __iomem				*msi_va;
+};
+
+struct imsic_global_config {
+	/*
+	 * MSI Target Address Scheme
+	 *
+	 * XLEN-1                                                12     0
+	 * |                                                     |     |
+	 * -------------------------------------------------------------
+	 * |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
+	 * -------------------------------------------------------------
+	 */
+
+	/* Bits representing Guest index, HART index, and Group index */
+	u32					guest_index_bits;
+	u32					hart_index_bits;
+	u32					group_index_bits;
+	u32					group_index_shift;
+
+	/* Global base address matching all target MSI addresses */
+	phys_addr_t				base_addr;
+
+	/* Number of interrupt identities */
+	u32					nr_ids;
+
+	/* Number of guest interrupt identities */
+	u32					nr_guest_ids;
+
+	/* Per-CPU IMSIC addresses */
+	struct imsic_local_config __percpu	*local;
+};
+
+#ifdef CONFIG_RISCV_IMSIC
+
+const struct imsic_global_config *imsic_get_global_config(void);
+
+#else
+
+static inline const struct imsic_global_config *imsic_get_global_config(void)
+{
+	return NULL;
+}
+
+#endif
+
+#endif

