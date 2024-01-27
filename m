Return-Path: <linux-kernel+bounces-41292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0183EE77
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DA11F23300
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046D42E644;
	Sat, 27 Jan 2024 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Je69g4Hz"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F05F86C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372404; cv=none; b=lK4RTsqaoTvc1Kd+EvFnPbjWLpSVfnK+ekD5ZDIXNPtc4w0U0EAjWTYNW6Q9O3T6J16GqBQEYUoztPkkpk4/bQxyKMUc4gjRb7qWO95UfpWXiNnlBg4bg5yxtBsD6s434218hcoNXe138dAZCy/sF5ZFKYXO7wttK+iGoiiF0kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372404; c=relaxed/simple;
	bh=mSjUod2uSMzCcwZDV2dZ0nlxfgo0WWWBe+NchQHaT68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYzCbIKIzfexIqKytdrwpefjgGs9WB3XNe+lMwzmrHTSaIsyvm8O/4HvtOjcF9Zs7Zf94Bxingu7ai6ctsCoc0Cx21BDokJ1yWET1V3VRwOo8nhP+yCqBUzW/8smi9rl8MLvM92mgBOLLH9anCN/cxCos530vKiJNjYYZy0z9G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Je69g4Hz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7431e702dso10702145ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372401; x=1706977201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiPsyZi3DbWaCgxBSFgut5D+DPNt3J7NC6WPa3de4Ns=;
        b=Je69g4Hz9UsP42fzUa1nNNVMLcWRYzTaWNi+svh5csywU6jBqlICPfSCsna2NcsqUk
         zxNkNBFEq6JjGyzguqrILV+515O2h2XcBlF+nfsxhrJVhRHQlwqPtNfIFX8ufmEuFDVY
         rFgsPXDOwpZy4QNAZL96JpW1iEqRB5R+5RPSsDLkGu40RSTdNyH750uJDT0qiAx7wCge
         oOPqWGGIjgBLPgKCI7k1qT9HgZJi8fXm3s7sSMb9H7Cq6l+OZV+3S6WWJl1p9eOKKEKs
         0tMHkyWYSQBzQWVC2K46ZzPglRKpetRVMjsVkAiTQ0ShWuARis/VVEQatIFX+lQvG2TM
         /vuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372401; x=1706977201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiPsyZi3DbWaCgxBSFgut5D+DPNt3J7NC6WPa3de4Ns=;
        b=Lgq2eyhEeQGTe0LJDmMbOY1Px9eg8oh3UoHixFfW54d9Pjdo29OxxFIqV3xxAducu7
         TGIAFaHp5432VSzxZ3n5jZ+s928mgoibOsWNGOOkT8qGpu944QQ4JdJFMafhNtmlPTnJ
         17F3UcyfeQxBiCrAWy9gkWou+kv4ZvUxF3NMBp9eQn/2y5QTHR27sZfIlC8O1zivO9Ii
         yZKliHlU/LiMC5AKzy7DF8yFAVEwRA+106RetNS2ipZ0xW3vJ3Ua77K9dth9cUo+axQ9
         74evfyb6CLuyyaM8HDxz6MOZHaqKF91MDkrPCyw50v9JR89OqZrZH3xuGbvLZWmtOfIj
         NIDg==
X-Gm-Message-State: AOJu0YwXN5pvWLhnaKxzOlmOJFvsAGlnb0267caWhdmTnCL/4rRNaVk2
	A2DcpfSOgdhBMtVez/+/egSnfz088QiKEjat4a77pRpl3PTxlWPHFO++5PnxNuM=
X-Google-Smtp-Source: AGHT+IGjnr3o36edmbPxqAXA3kXPuUgWcTSPSDezQNApBIgh668+zOJeKE33JMyRFWrt7OPqPkNwSQ==
X-Received: by 2002:a17:902:c641:b0:1d7:6bac:5f13 with SMTP id s1-20020a170902c64100b001d76bac5f13mr746938pls.27.1706372401127;
        Sat, 27 Jan 2024 08:20:01 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:20:00 -0800 (PST)
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
Subject: [PATCH v12 18/25] irqchip: Add RISC-V incoming MSI controller early driver
Date: Sat, 27 Jan 2024 21:47:46 +0530
Message-Id: <20240127161753.114685-19-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240127161753.114685-1-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RISC-V advanced interrupt architecture (AIA) specification
defines a new MSI controller called incoming message signalled
interrupt controller (IMSIC) which manages MSI on per-HART (or
per-CPU) basis. It also supports IPIs as software injected MSIs.
(For more details refer https://github.com/riscv/riscv-aia)

Let us add an early irqchip driver for RISC-V IMSIC which sets
up the IMSIC state and provide IPIs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                 |   7 +
 drivers/irqchip/Makefile                |   1 +
 drivers/irqchip/irq-riscv-imsic-early.c | 241 +++++++
 drivers/irqchip/irq-riscv-imsic-state.c | 887 ++++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h | 105 +++
 include/linux/irqchip/riscv-imsic.h     |  87 +++
 6 files changed, 1328 insertions(+)
 create mode 100644 drivers/irqchip/irq-riscv-imsic-early.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.c
 create mode 100644 drivers/irqchip/irq-riscv-imsic-state.h
 create mode 100644 include/linux/irqchip/riscv-imsic.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0f3d45..85f86e31c996 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -546,6 +546,13 @@ config SIFIVE_PLIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
+config RISCV_IMSIC
+	bool
+	depends on RISCV
+	select IRQ_DOMAIN_HIERARCHY
+	select GENERIC_IRQ_MATRIX_ALLOCATOR
+	select GENERIC_MSI_IRQ
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa..d714724387ce 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
+obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
new file mode 100644
index 000000000000..3557e32a713c
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -0,0 +1,241 @@
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
+static irqreturn_t imsic_local_sync_handler(int irq, void *data)
+{
+	imsic_local_sync();
+	return IRQ_HANDLED;
+}
+
+static void imsic_ipi_send(unsigned int cpu)
+{
+	struct imsic_local_config *local =
+				per_cpu_ptr(imsic->global.local, cpu);
+
+	writel_relaxed(IMSIC_IPI_ID, local->msi_va);
+}
+
+static void imsic_ipi_starting_cpu(void)
+{
+	/* Enable IPIs for current CPU. */
+	__imsic_id_set_enable(IMSIC_IPI_ID);
+
+	/* Enable virtual IPI used for IMSIC ID synchronization */
+	enable_percpu_irq(imsic->ipi_virq, 0);
+}
+
+static void imsic_ipi_dying_cpu(void)
+{
+	/*
+	 * Disable virtual IPI used for IMSIC ID synchronization so
+	 * that we don't receive ID synchronization requests.
+	 */
+	disable_percpu_irq(imsic->ipi_virq);
+}
+
+static int __init imsic_ipi_domain_init(void)
+{
+	int virq;
+
+	/* Create IMSIC IPI multiplexing */
+	virq = ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
+	if (virq <= 0)
+		return (virq < 0) ? virq : -ENOMEM;
+	imsic->ipi_virq = virq;
+
+	/* First vIRQ is used for IMSIC ID synchronization */
+	virq = request_percpu_irq(imsic->ipi_virq, imsic_local_sync_handler,
+				  "riscv-imsic-lsync", imsic->global.local);
+	if (virq)
+		return virq;
+	irq_set_status_flags(imsic->ipi_virq, IRQ_HIDDEN);
+	imsic->ipi_lsync_desc = irq_to_desc(imsic->ipi_virq);
+
+	/* Set vIRQ range */
+	riscv_ipi_set_virq_range(imsic->ipi_virq + 1, IMSIC_NR_IPI - 1, true);
+
+	/* Announce that IMSIC is providing IPIs */
+	pr_info("%pfwP: providing IPIs using interrupt %d\n",
+		imsic->fwnode, IMSIC_IPI_ID);
+
+	return 0;
+}
+#else
+static void imsic_ipi_starting_cpu(void)
+{
+}
+
+static void imsic_ipi_dying_cpu(void)
+{
+}
+
+static int __init imsic_ipi_domain_init(void)
+{
+	return 0;
+}
+#endif
+
+/*
+ * To handle an interrupt, we read the TOPEI CSR and write zero in one
+ * instruction. If TOPEI CSR is non-zero then we translate TOPEI.ID to
+ * Linux interrupt number and let Linux IRQ subsystem handle it.
+ */
+static void imsic_handle_irq(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int err, cpu = smp_processor_id();
+	struct imsic_vector *vec;
+	unsigned long local_id;
+
+	chained_irq_enter(chip, desc);
+
+	while ((local_id = csr_swap(CSR_TOPEI, 0))) {
+		local_id = local_id >> TOPEI_ID_SHIFT;
+
+		if (local_id == IMSIC_IPI_ID) {
+#ifdef CONFIG_SMP
+			ipi_mux_process();
+#endif
+			continue;
+		}
+
+		if (unlikely(!imsic->base_domain))
+			continue;
+
+		vec = imsic_vector_from_local_id(cpu, local_id);
+		if (!vec) {
+			pr_warn_ratelimited(
+				"vector not found for local ID 0x%lx\n",
+				local_id);
+			continue;
+		}
+
+		err = generic_handle_domain_irq(imsic->base_domain,
+						vec->hwirq);
+		if (unlikely(err))
+			pr_warn_ratelimited(
+				"hwirq 0x%x mapping not found\n",
+				vec->hwirq);
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
+	enable_percpu_irq(imsic_parent_irq,
+			  irq_get_trigger_type(imsic_parent_irq));
+
+	/* Setup IPIs */
+	imsic_ipi_starting_cpu();
+
+	/*
+	 * Interrupts identities might have been enabled/disabled while
+	 * this CPU was not running so sync-up local enable/disable state.
+	 */
+	imsic_local_sync();
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
+	int rc;
+	struct irq_domain *domain;
+
+	/* Find parent domain and register chained handler */
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+					  DOMAIN_BUS_ANY);
+	if (!domain) {
+		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
+		return -ENOENT;
+	}
+	imsic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+	if (!imsic_parent_irq) {
+		pr_err("%pfwP: Failed to create INTC mapping\n", fwnode);
+		return -ENOENT;
+	}
+	irq_set_chained_handler(imsic_parent_irq, imsic_handle_irq);
+
+	/* Initialize IPI domain */
+	rc = imsic_ipi_domain_init();
+	if (rc) {
+		pr_err("%pfwP: Failed to initialize IPI domain\n", fwnode);
+		return rc;
+	}
+
+	/*
+	 * Setup cpuhp state (must be done after setting imsic_parent_irq)
+	 *
+	 * Don't disable per-CPU IMSIC file when CPU goes offline
+	 * because this affects IPI and the masking/unmasking of
+	 * virtual IPIs is done via generic IPI-Mux
+	 */
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			  "irqchip/riscv/imsic:starting",
+			  imsic_starting_cpu, imsic_dying_cpu);
+
+	return 0;
+}
+
+static int __init imsic_early_dt_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	int rc;
+	struct fwnode_handle *fwnode = &node->fwnode;
+
+	/* Setup IMSIC state */
+	rc = imsic_setup_state(fwnode);
+	if (rc) {
+		pr_err("%pfwP: failed to setup state (error %d)\n",
+			fwnode, rc);
+		return rc;
+	}
+
+	/* Do early setup of IPIs */
+	rc = imsic_early_probe(fwnode);
+	if (rc)
+		return rc;
+
+	/* Ensure that OF platform device gets probed */
+	of_node_clear_flag(node, OF_POPULATED);
+	return 0;
+}
+IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
new file mode 100644
index 000000000000..66389a6e558f
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -0,0 +1,887 @@
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
+#define imsic_csr_write(__c, __v)		\
+do {						\
+	csr_write(CSR_ISELECT, __c);		\
+	csr_write(CSR_IREG, __v);		\
+} while (0)
+
+#define imsic_csr_read(__c)			\
+({						\
+	unsigned long __v;			\
+	csr_write(CSR_ISELECT, __c);		\
+	__v = csr_read(CSR_IREG);		\
+	__v;					\
+})
+
+#define imsic_csr_read_clear(__c, __v)		\
+({						\
+	unsigned long __r;			\
+	csr_write(CSR_ISELECT, __c);		\
+	__r = csr_read_clear(CSR_IREG, __v);	\
+	__r;					\
+})
+
+#define imsic_csr_set(__c, __v)			\
+do {						\
+	csr_write(CSR_ISELECT, __c);		\
+	csr_set(CSR_IREG, __v);			\
+} while (0)
+
+#define imsic_csr_clear(__c, __v)		\
+do {						\
+	csr_write(CSR_ISELECT, __c);		\
+	csr_clear(CSR_IREG, __v);		\
+} while (0)
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
+	isel = id / BITS_PER_LONG;
+	isel *= BITS_PER_LONG / IMSIC_EIPx_BITS;
+	isel += pend ? IMSIC_EIP0 : IMSIC_EIE0;
+	imask = BIT(id & (__riscv_xlen - 1));
+
+	return (imsic_csr_read_clear(isel, imask) & imask) ? true : false;
+}
+
+#define __imsic_id_read_clear_enabled(__id)		\
+	__imsic_eix_read_clear((__id), false)
+#define __imsic_id_read_clear_pending(__id)		\
+	__imsic_eix_read_clear((__id), true)
+
+void __imsic_eix_update(unsigned long base_id,
+			unsigned long num_id, bool pend, bool val)
+{
+	unsigned long i, isel, ireg;
+	unsigned long id = base_id, last_id = base_id + num_id;
+
+	while (id < last_id) {
+		isel = id / BITS_PER_LONG;
+		isel *= BITS_PER_LONG / IMSIC_EIPx_BITS;
+		isel += (pend) ? IMSIC_EIP0 : IMSIC_EIE0;
+
+		ireg = 0;
+		for (i = id & (__riscv_xlen - 1);
+		     (id < last_id) && (i < __riscv_xlen); i++) {
+			ireg |= BIT(i);
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
+void imsic_local_sync(void)
+{
+	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
+	struct imsic_local_config *mlocal;
+	struct imsic_vector *mvec;
+	unsigned long flags;
+	int i;
+
+	raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
+	for (i = 1; i <= imsic->global.nr_ids; i++) {
+		if (i == IMSIC_IPI_ID)
+			continue;
+
+		if (test_bit(i, lpriv->ids_enabled_bitmap))
+			__imsic_id_set_enable(i);
+		else
+			__imsic_id_clear_enable(i);
+
+		mvec = lpriv->ids_move[i];
+		lpriv->ids_move[i] = NULL;
+		if (mvec) {
+			if (__imsic_id_read_clear_pending(i)) {
+				mlocal = per_cpu_ptr(imsic->global.local,
+						     mvec->cpu);
+				writel_relaxed(mvec->local_id, mlocal->msi_va);
+			}
+
+			imsic_vector_free(&lpriv->vectors[i]);
+		}
+
+	}
+	raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
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
+static void imsic_remote_sync(unsigned int cpu)
+{
+	/*
+	 * We simply inject ID synchronization IPI to a target CPU
+	 * if it is not same as the current CPU. The ipi_send_mask()
+	 * implementation of IPI mux will inject ID synchronization
+	 * IPI only for CPUs that have enabled it so offline CPUs
+	 * won't receive IPI. An offline CPU will unconditionally
+	 * synchronize IDs through imsic_starting_cpu() when the
+	 * CPU is brought up.
+	 */
+	if (cpu_online(cpu)) {
+		if (cpu != smp_processor_id())
+			__ipi_send_mask(imsic->ipi_lsync_desc, cpumask_of(cpu));
+		else
+			imsic_local_sync();
+	}
+}
+#else
+static inline void imsic_remote_sync(unsigned int cpu)
+{
+	imsic_local_sync();
+}
+#endif
+
+void imsic_vector_mask(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+	unsigned long flags;
+
+	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON(&lpriv->vectors[vec->local_id] != vec))
+		return;
+
+	raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
+	bitmap_clear(lpriv->ids_enabled_bitmap, vec->local_id, 1);
+	raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
+
+	imsic_remote_sync(vec->cpu);
+}
+
+void imsic_vector_unmask(struct imsic_vector *vec)
+{
+	struct imsic_local_priv *lpriv;
+	unsigned long flags;
+
+	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON(&lpriv->vectors[vec->local_id] != vec))
+		return;
+
+	raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
+	bitmap_set(lpriv->ids_enabled_bitmap, vec->local_id, 1);
+	raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
+
+	imsic_remote_sync(vec->cpu);
+}
+
+void imsic_vector_move(struct imsic_vector *old_vec,
+			struct imsic_vector *new_vec)
+{
+	struct imsic_local_priv *old_lpriv, *new_lpriv;
+	unsigned long flags, flags1;
+
+	if (WARN_ON(old_vec->cpu == new_vec->cpu))
+		return;
+
+	old_lpriv = per_cpu_ptr(imsic->lpriv, old_vec->cpu);
+	if (WARN_ON(&old_lpriv->vectors[old_vec->local_id] != old_vec))
+		return;
+
+	new_lpriv = per_cpu_ptr(imsic->lpriv, new_vec->cpu);
+	if (WARN_ON(&new_lpriv->vectors[new_vec->local_id] != new_vec))
+		return;
+
+	raw_spin_lock_irqsave(&old_lpriv->ids_lock, flags);
+	raw_spin_lock_irqsave(&new_lpriv->ids_lock, flags1);
+
+	/* Unmask the new vector entry */
+	if (test_bit(old_vec->local_id, old_lpriv->ids_enabled_bitmap))
+		bitmap_set(new_lpriv->ids_enabled_bitmap,
+			   new_vec->local_id, 1);
+
+	/* Mask the old vector entry */
+	bitmap_clear(old_lpriv->ids_enabled_bitmap, old_vec->local_id, 1);
+
+	/*
+	 * Move and re-trigger the new vector based on the pending
+	 * state of the old vector because we might get a device
+	 * interrupt on the old vector while device was being moved
+	 * to the new vector.
+	 */
+	old_lpriv->ids_move[old_vec->local_id] = new_vec;
+
+	raw_spin_unlock_irqrestore(&new_lpriv->ids_lock, flags1);
+	raw_spin_unlock_irqrestore(&old_lpriv->ids_lock, flags);
+
+	imsic_remote_sync(old_vec->cpu);
+	imsic_remote_sync(new_vec->cpu);
+}
+
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+void imsic_vector_debug_show(struct seq_file *m,
+			     struct imsic_vector *vec, int ind)
+{
+	unsigned int mcpu = 0, mlocal_id = 0;
+	struct imsic_local_priv *lpriv;
+	bool move_in_progress = false;
+	struct imsic_vector *mvec;
+	bool is_enabled = false;
+	unsigned long flags;
+
+	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON(&lpriv->vectors[vec->local_id] != vec))
+		return;
+
+	raw_spin_lock_irqsave(&lpriv->ids_lock, flags);
+	if (test_bit(vec->local_id, lpriv->ids_enabled_bitmap))
+		is_enabled = true;
+	mvec = lpriv->ids_move[vec->local_id];
+	if (mvec) {
+		move_in_progress = true;
+		mcpu = mvec->cpu;
+		mlocal_id = mvec->local_id;
+	}
+	raw_spin_unlock_irqrestore(&lpriv->ids_lock, flags);
+
+	seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
+	seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_id);
+	seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
+		   (vec->local_id <= IMSIC_IPI_ID) ? 1 : 0);
+	seq_printf(m, "%*sis_enabled      : %5u\n", ind, "",
+		   (is_enabled) ? 1 : 0);
+	seq_printf(m, "%*sis_move_pending : %5u\n", ind, "",
+		   (move_in_progress) ? 1 : 0);
+	if (move_in_progress) {
+		seq_printf(m, "%*smove_cpu        : %5u\n", ind, "", mcpu);
+		seq_printf(m, "%*smove_local_id   : %5u\n", ind, "", mlocal_id);
+	}
+}
+
+void imsic_vector_debug_show_summary(struct seq_file *m, int ind)
+{
+	irq_matrix_debug_show(m, imsic->matrix, ind);
+}
+#endif
+
+struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu,
+						unsigned int local_id)
+{
+	struct imsic_local_priv *lpriv = per_cpu_ptr(imsic->lpriv, cpu);
+
+	if (!lpriv || imsic->global.nr_ids < local_id)
+		return NULL;
+
+	return &lpriv->vectors[local_id];
+}
+
+struct imsic_vector *imsic_vector_alloc(unsigned int hwirq,
+					const struct cpumask *mask)
+{
+	struct imsic_vector *vec = NULL;
+	struct imsic_local_priv *lpriv;
+	unsigned long flags;
+	unsigned int cpu;
+	int local_id;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	local_id = irq_matrix_alloc(imsic->matrix, mask, false, &cpu);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+	if (local_id < 0)
+		return NULL;
+
+	lpriv = per_cpu_ptr(imsic->lpriv, cpu);
+	vec = &lpriv->vectors[local_id];
+	vec->hwirq = hwirq;
+
+	return vec;
+}
+
+void imsic_vector_free(struct imsic_vector *vec)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->matrix_lock, flags);
+	vec->hwirq = UINT_MAX;
+	irq_matrix_free(imsic->matrix, vec->cpu, vec->local_id, false);
+	raw_spin_unlock_irqrestore(&imsic->matrix_lock, flags);
+}
+
+static void __init imsic_local_cleanup(void)
+{
+	int cpu;
+	struct imsic_local_priv *lpriv;
+
+	for_each_possible_cpu(cpu) {
+		lpriv = per_cpu_ptr(imsic->lpriv, cpu);
+
+		bitmap_free(lpriv->ids_enabled_bitmap);
+		kfree(lpriv->ids_move);
+		kfree(lpriv->vectors);
+	}
+
+	free_percpu(imsic->lpriv);
+}
+
+static int __init imsic_local_init(void)
+{
+	struct imsic_global_config *global = &imsic->global;
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *vec;
+	int cpu, i;
+
+	/* Allocate per-CPU private state */
+	imsic->lpriv = alloc_percpu(typeof(*(imsic->lpriv)));
+	if (!imsic->lpriv)
+		return -ENOMEM;
+
+	/* Setup per-CPU private state */
+	for_each_possible_cpu(cpu) {
+		lpriv = per_cpu_ptr(imsic->lpriv, cpu);
+
+		raw_spin_lock_init(&lpriv->ids_lock);
+
+		/* Allocate enabled bitmap */
+		lpriv->ids_enabled_bitmap = bitmap_zalloc(global->nr_ids + 1,
+							  GFP_KERNEL);
+		if (!lpriv->ids_enabled_bitmap) {
+			imsic_local_cleanup();
+			return -ENOMEM;
+		}
+
+		/* Allocate move array */
+		lpriv->ids_move = kcalloc(global->nr_ids + 1,
+					sizeof(*lpriv->ids_move), GFP_KERNEL);
+		if (!lpriv->ids_move) {
+			imsic_local_cleanup();
+			return -ENOMEM;
+		}
+
+		/* Allocate vector array */
+		lpriv->vectors = kcalloc(global->nr_ids + 1,
+					 sizeof(*lpriv->vectors), GFP_KERNEL);
+		if (!lpriv->vectors) {
+			imsic_local_cleanup();
+			return -ENOMEM;
+		}
+
+		/* Setup vector array */
+		for (i = 0; i <= global->nr_ids; i++) {
+			vec = &lpriv->vectors[i];
+			vec->cpu = cpu;
+			vec->local_id = i;
+			vec->hwirq = UINT_MAX;
+		}
+	}
+
+	return 0;
+}
+
+int imsic_hwirq_alloc(void)
+{
+	int ret;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->hwirqs_lock, flags);
+	ret = bitmap_find_free_region(imsic->hwirqs_used_bitmap,
+				      imsic->nr_hwirqs, 0);
+	raw_spin_unlock_irqrestore(&imsic->hwirqs_lock, flags);
+
+	return ret;
+}
+
+void imsic_hwirq_free(unsigned int hwirq)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&imsic->hwirqs_lock, flags);
+	bitmap_release_region(imsic->hwirqs_used_bitmap, hwirq, 0);
+	raw_spin_unlock_irqrestore(&imsic->hwirqs_lock, flags);
+}
+
+static int __init imsic_hwirqs_init(void)
+{
+	struct imsic_global_config *global = &imsic->global;
+
+	imsic->nr_hwirqs = num_possible_cpus() * (global->nr_ids - 1);
+
+	raw_spin_lock_init(&imsic->hwirqs_lock);
+
+	imsic->hwirqs_used_bitmap = bitmap_zalloc(imsic->nr_hwirqs,
+						  GFP_KERNEL);
+	if (!imsic->hwirqs_used_bitmap)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void __init imsic_hwirqs_cleanup(void)
+{
+	bitmap_free(imsic->hwirqs_used_bitmap);
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
+}
+
+static int __init imsic_matrix_init(void)
+{
+	struct imsic_global_config *global = &imsic->global;
+
+	raw_spin_lock_init(&imsic->matrix_lock);
+	imsic->matrix = irq_alloc_matrix(global->nr_ids + 1,
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
+	int rc;
+	struct of_phandle_args parent;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(fwnode))
+		return -EINVAL;
+
+	rc = of_irq_parse_one(to_of_node(fwnode), index, &parent);
+	if (rc)
+		return rc;
+
+	/*
+	 * Skip interrupts other than external interrupts for
+	 * current privilege level.
+	 */
+	if (parent.args[0] != RV_IRQ_EXT)
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
+	*nr_parent_irqs = 0;
+	*nr_mmios = 0;
+
+	/* Find number of parent interrupts */
+	*nr_parent_irqs = 0;
+	while (!imsic_get_parent_hartid(fwnode, *nr_parent_irqs, &hartid))
+		(*nr_parent_irqs)++;
+	if (!(*nr_parent_irqs)) {
+		pr_err("%pfwP: no parent irqs available\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Find number of guest index bits in MSI address */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,guest-index-bits",
+				  &global->guest_index_bits);
+	if (rc)
+		global->guest_index_bits = 0;
+
+	/* Find number of HART index bits */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,hart-index-bits",
+				  &global->hart_index_bits);
+	if (rc) {
+		/* Assume default value */
+		global->hart_index_bits = __fls(*nr_parent_irqs);
+		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
+			global->hart_index_bits++;
+	}
+
+	/* Find number of group index bits */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,group-index-bits",
+				  &global->group_index_bits);
+	if (rc)
+		global->group_index_bits = 0;
+
+	/*
+	 * Find first bit position of group index.
+	 * If not specified assumed the default APLIC-IMSIC configuration.
+	 */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,group-index-shift",
+				  &global->group_index_shift);
+	if (rc)
+		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
+
+	/* Find number of interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,num-ids",
+				  &global->nr_ids);
+	if (rc) {
+		pr_err("%pfwP: number of interrupt identities not found\n",
+			fwnode);
+		return rc;
+	}
+
+	/* Find number of guest interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode),
+				  "riscv,num-guest-ids",
+				  &global->nr_guest_ids);
+	if (rc)
+		global->nr_guest_ids = global->nr_ids;
+
+	/* Sanity check guest index bits */
+	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
+	if (i < global->guest_index_bits) {
+		pr_err("%pfwP: guest index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check HART index bits */
+	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT - global->guest_index_bits;
+	if (i < global->hart_index_bits) {
+		pr_err("%pfwP: HART index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check group index bits */
+	i = BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT -
+	    global->guest_index_bits - global->hart_index_bits;
+	if (i < global->group_index_bits) {
+		pr_err("%pfwP: group index bits too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check group index shift */
+	i = global->group_index_bits + global->group_index_shift - 1;
+	if (i >= BITS_PER_LONG) {
+		pr_err("%pfwP: group index shift too big\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check number of interrupt identities */
+	if ((global->nr_ids < IMSIC_MIN_ID) ||
+	    (global->nr_ids >= IMSIC_MAX_ID) ||
+	    ((global->nr_ids & IMSIC_MIN_ID) != IMSIC_MIN_ID)) {
+		pr_err("%pfwP: invalid number of interrupt identities\n",
+			fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check number of guest interrupt identities */
+	if ((global->nr_guest_ids < IMSIC_MIN_ID) ||
+	    (global->nr_guest_ids >= IMSIC_MAX_ID) ||
+	    ((global->nr_guest_ids & IMSIC_MIN_ID) != IMSIC_MIN_ID)) {
+		pr_err("%pfwP: invalid number of guest interrupt identities\n",
+			fwnode);
+		return -EINVAL;
+	}
+
+	/* Compute base address */
+	rc = imsic_get_mmio_resource(fwnode, 0, &res);
+	if (rc) {
+		pr_err("%pfwP: first MMIO resource not found\n", fwnode);
+		return -EINVAL;
+	}
+	global->base_addr = res.start;
+	global->base_addr &= ~(BIT(global->guest_index_bits +
+				   global->hart_index_bits +
+				   IMSIC_MMIO_PAGE_SHIFT) - 1);
+	global->base_addr &= ~((BIT(global->group_index_bits) - 1) <<
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
+	int rc, cpu;
+	phys_addr_t base_addr;
+	void __iomem **mmios_va = NULL;
+	struct resource *mmios = NULL;
+	struct imsic_local_config *local;
+	struct imsic_global_config *global;
+	unsigned long reloff, hartid;
+	u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers = 0;
+
+	/*
+	 * Only one IMSIC instance allowed in a platform for clean
+	 * implementation of SMP IRQ affinity and per-CPU IPIs.
+	 *
+	 * This means on a multi-socket (or multi-die) platform we
+	 * will have multiple MMIO regions for one IMSIC instance.
+	 */
+	if (imsic) {
+		pr_err("%pfwP: already initialized hence ignoring\n",
+			fwnode);
+		return -EALREADY;
+	}
+
+	if (!riscv_isa_extension_available(NULL, SxAIA)) {
+		pr_err("%pfwP: AIA support not available\n", fwnode);
+		return -ENODEV;
+	}
+
+	imsic = kzalloc(sizeof(*imsic), GFP_KERNEL);
+	if (!imsic)
+		return -ENOMEM;
+	imsic->fwnode = fwnode;
+	global = &imsic->global;
+
+	global->local = alloc_percpu(typeof(*(global->local)));
+	if (!global->local) {
+		rc = -ENOMEM;
+		goto out_free_priv;
+	}
+
+	/* Parse IMSIC fwnode */
+	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios);
+	if (rc)
+		goto out_free_local;
+
+	/* Allocate MMIO resource array */
+	mmios = kcalloc(nr_mmios, sizeof(*mmios), GFP_KERNEL);
+	if (!mmios) {
+		rc = -ENOMEM;
+		goto out_free_local;
+	}
+
+	/* Allocate MMIO virtual address array */
+	mmios_va = kcalloc(nr_mmios, sizeof(*mmios_va), GFP_KERNEL);
+	if (!mmios_va) {
+		rc = -ENOMEM;
+		goto out_iounmap;
+	}
+
+	/* Parse and map MMIO register sets */
+	for (i = 0; i < nr_mmios; i++) {
+		rc = imsic_get_mmio_resource(fwnode, i, &mmios[i]);
+		if (rc) {
+			pr_err("%pfwP: unable to parse MMIO regset %d\n",
+				fwnode, i);
+			goto out_iounmap;
+		}
+
+		base_addr = mmios[i].start;
+		base_addr &= ~(BIT(global->guest_index_bits +
+				   global->hart_index_bits +
+				   IMSIC_MMIO_PAGE_SHIFT) - 1);
+		base_addr &= ~((BIT(global->group_index_bits) - 1) <<
+			       global->group_index_shift);
+		if (base_addr != global->base_addr) {
+			rc = -EINVAL;
+			pr_err("%pfwP: address mismatch for regset %d\n",
+				fwnode, i);
+			goto out_iounmap;
+		}
+
+		mmios_va[i] = ioremap(mmios[i].start, resource_size(&mmios[i]));
+		if (!mmios_va[i]) {
+			rc = -EIO;
+			pr_err("%pfwP: unable to map MMIO regset %d\n",
+				fwnode, i);
+			goto out_iounmap;
+		}
+	}
+
+	/* Initialize HW interrupt numbers */
+	rc = imsic_hwirqs_init();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize HW interrupts numbers\n",
+		       fwnode);
+		goto out_iounmap;
+	}
+
+	/* Initialize local (or per-CPU )state */
+	rc = imsic_local_init();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize local state\n",
+		       fwnode);
+		goto out_hwirqs_cleanup;
+	}
+
+	/* Configure handlers for target CPUs */
+	for (i = 0; i < nr_parent_irqs; i++) {
+		rc = imsic_get_parent_hartid(fwnode, i, &hartid);
+		if (rc) {
+			pr_warn("%pfwP: hart ID for parent irq%d not found\n",
+				fwnode, i);
+			continue;
+		}
+
+		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("%pfwP: invalid cpuid for parent irq%d\n",
+				fwnode, i);
+			continue;
+		}
+
+		/* Find MMIO location of MSI page */
+		index = nr_mmios;
+		reloff = i * BIT(global->guest_index_bits) *
+			 IMSIC_MMIO_PAGE_SZ;
+		for (j = 0; nr_mmios; j++) {
+			if (reloff < resource_size(&mmios[j])) {
+				index = j;
+				break;
+			}
+
+			/*
+			 * MMIO region size may not be aligned to
+			 * BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ
+			 * if holes are present.
+			 */
+			reloff -= ALIGN(resource_size(&mmios[j]),
+			BIT(global->guest_index_bits) * IMSIC_MMIO_PAGE_SZ);
+		}
+		if (index >= nr_mmios) {
+			pr_warn("%pfwP: MMIO not found for parent irq%d\n",
+				fwnode, i);
+			continue;
+		}
+
+		local = per_cpu_ptr(global->local, cpu);
+		local->msi_pa = mmios[index].start + reloff;
+		local->msi_va = mmios_va[index] + reloff;
+
+		nr_handlers++;
+	}
+
+	/* If no CPU handlers found then can't take interrupts */
+	if (!nr_handlers) {
+		pr_err("%pfwP: No CPU handlers found\n", fwnode);
+		rc = -ENODEV;
+		goto out_local_cleanup;
+	}
+
+	/* Initialize matrix allocator */
+	rc = imsic_matrix_init();
+	if (rc) {
+		pr_err("%pfwP: failed to create matrix allocator\n",
+		       fwnode);
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
+out_hwirqs_cleanup:
+	imsic_hwirqs_cleanup();
+out_iounmap:
+	for (i = 0; i < nr_mmios; i++) {
+		if (mmios_va[i])
+			iounmap(mmios_va[i]);
+	}
+	kfree(mmios_va);
+	kfree(mmios);
+out_free_local:
+	free_percpu(imsic->global.local);
+out_free_priv:
+	kfree(imsic);
+	imsic = NULL;
+	return rc;
+}
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
new file mode 100644
index 000000000000..de83b649221c
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -0,0 +1,105 @@
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
+
+/*
+ * The IMSIC driver uses 1 IPI for ID synchronization and
+ * arch/riscv/kernel/smp.c require 6 IPIs so we fix the
+ * total number of IPIs to 8.
+ */
+#define IMSIC_IPI_ID				1
+#define IMSIC_NR_IPI				8
+
+struct imsic_vector {
+	/* Fixed details of the vector */
+	unsigned int cpu;
+	unsigned int local_id;
+	/* Details saved by driver in the vector */
+	unsigned int hwirq;
+};
+
+struct imsic_local_priv {
+	/* Local state of interrupt identities */
+	raw_spinlock_t ids_lock;
+	unsigned long *ids_enabled_bitmap;
+	struct imsic_vector **ids_move;
+
+	/* Local vector table */
+	struct imsic_vector *vectors;
+};
+
+struct imsic_priv {
+	/* Device details */
+	struct fwnode_handle *fwnode;
+
+	/* Global configuration common for all HARTs */
+	struct imsic_global_config global;
+
+	/* Dummy HW interrupt numbers */
+	unsigned int nr_hwirqs;
+	raw_spinlock_t hwirqs_lock;
+	unsigned long *hwirqs_used_bitmap;
+
+	/* Per-CPU state */
+	struct imsic_local_priv __percpu *lpriv;
+
+	/* State of IRQ matrix allocator */
+	raw_spinlock_t matrix_lock;
+	struct irq_matrix *matrix;
+
+	/* IPI interrupt identity and synchronization */
+	int ipi_virq;
+	struct irq_desc *ipi_lsync_desc;
+
+	/* IRQ domains (created by platform driver) */
+	struct irq_domain *base_domain;
+	struct irq_domain *plat_domain;
+};
+
+extern struct imsic_priv *imsic;
+
+void __imsic_eix_update(unsigned long base_id,
+			unsigned long num_id, bool pend, bool val);
+
+#define __imsic_id_set_enable(__id)		\
+	__imsic_eix_update((__id), 1, false, true)
+#define __imsic_id_clear_enable(__id)	\
+	__imsic_eix_update((__id), 1, false, false)
+
+void imsic_local_sync(void);
+void imsic_local_delivery(bool enable);
+
+void imsic_vector_mask(struct imsic_vector *vec);
+void imsic_vector_unmask(struct imsic_vector *vec);
+void imsic_vector_move(struct imsic_vector *old_vec,
+			struct imsic_vector *new_vec);
+
+struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu,
+						unsigned int local_id);
+
+struct imsic_vector *imsic_vector_alloc(unsigned int hwirq,
+					const struct cpumask *mask);
+void imsic_vector_free(struct imsic_vector *vector);
+
+void imsic_vector_debug_show(struct seq_file *m,
+			     struct imsic_vector *vec, int ind);
+
+void imsic_vector_debug_show_summary(struct seq_file *m, int ind);
+
+int imsic_hwirq_alloc(void);
+void imsic_hwirq_free(unsigned int hwirq);
+
+void imsic_state_online(void);
+void imsic_state_offline(void);
+int imsic_setup_state(struct fwnode_handle *fwnode);
+
+#endif
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
new file mode 100644
index 000000000000..cbb7bcd0e4dd
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
+	phys_addr_t msi_pa;
+	void __iomem *msi_va;
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
+	u32 guest_index_bits;
+	u32 hart_index_bits;
+	u32 group_index_bits;
+	u32 group_index_shift;
+
+	/* Global base address matching all target MSI addresses */
+	phys_addr_t base_addr;
+
+	/* Number of interrupt identities */
+	u32 nr_ids;
+
+	/* Number of guest interrupt identities */
+	u32 nr_guest_ids;
+
+	/* Per-CPU IMSIC addresses */
+	struct imsic_local_config __percpu *local;
+};
+
+#ifdef CONFIG_RISCV_IMSIC
+
+extern const struct imsic_global_config *imsic_get_global_config(void);
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
-- 
2.34.1


