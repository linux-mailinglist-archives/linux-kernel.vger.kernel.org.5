Return-Path: <linux-kernel+bounces-95683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2587513E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DF1B2709A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B94812F5A1;
	Thu,  7 Mar 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hKRk58S5"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820812F5A5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820216; cv=none; b=T76HkwFqlX60Qh1XRCf5C5O7Y98nNAvAhZ4hUL9oogXv9Zhrk0GYUPHQkYcBKCZd0LZY8GQdHdZQZ1UB6/4Y512KytQLUu8k4/QmlmBZXgfP5P6V/90kUcCFq537YH8MERwk5xyCHK6StOhT/ITLz+e81H5OjwTTd0iDIla0enU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820216; c=relaxed/simple;
	bh=WdExVs2uYtyX7km8oNf0Deoz1ErkAkj1DHd8gzkJZT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTXUy84VRK6Z1z3ZOsa45O+g5i/jgOsxscuEpmQs9cAwF1DvQUVC8AExA4Dqxshu/fKBTs+s1i4AjV3exNv2JhT8vPLwX1Bs4QkFygByNufpfitxAMCEFTJCFDpmcIWlEaxr9PlNtK+kLUY28QN1S5ftHaRWR7Dvlk5O0EfjvjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=hKRk58S5; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dc3b4b9b62so7363235ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709820213; x=1710425013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXHA4RX8bVZ+yxebqpTN2yBo2CBmKIjgEFj/RVC4xFI=;
        b=hKRk58S5l9zuXC6xJTUYPOp5p/UxR1ZBhdHFx9wmgc3h7HnePxQsuWL5mMfUY0V6Kl
         7Z3nlwJMCH3g7ADxVkhdAlHZghJmN4pO5znXUe4KvDh8q7JR1ad1S7RuGlbyGdR1HxJP
         LDyBTQC87VEMHTb1BFhywf/DgG8cZorY+6H9LCWPoL8e1JYGwYzytQBYUfAib9CFsb3p
         94Sw1POvHiXLtzeZRJUPbhvgPtuSXnogsN0feIxdLV/Y99/vsTDGIewN4IqYw0bxIe0n
         qW7blJLI/bo32Q2EiEcIrO2inSsCw0/In3geEcj0+1Dq4yMjGTZFDMLLqLus8HF9Ty0R
         z1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820213; x=1710425013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXHA4RX8bVZ+yxebqpTN2yBo2CBmKIjgEFj/RVC4xFI=;
        b=Qq10EQhl2WawULnvRBQdybCsgGayeqIPv3XR3uHgt3GcLf2oUfV70OU/9NkN++dHZw
         LghJbgLEMNjaQjVsHuWwPJBfTS3ne5pCokWG/Io4PbRmWHAxUfrMCYFH9/iZIF+AR2Pi
         CqudKBE6aD68d+UyaTIXd8Ep0pIH5hM6M37dmA0K/Y6y/zkVqA2komigo4QoR5GKnr4A
         UTil88KO7vqMObyIwaQWKjWn0G1FrDmcbhFyzfzRuMNHwXbDmioYkUqi8AFH+cjOFJ87
         PdJ0v4617nj7XjFhMHcXyOsMwBxaQrWGWWit+4XAxwU0I9i8Z2EfVYbzR0h3KjMQhhVP
         Rdzg==
X-Forwarded-Encrypted: i=1; AJvYcCX/QVm3UOG3j1epK+BF91HLcVwkMt2QdCcA1e+HT3NhvDqc32laU1dRv0aDzPm2Lj9ZM5zQV5LPKaiR6gDVFzCReBFzEBapr0BI9Z06
X-Gm-Message-State: AOJu0Yxz8Wbhn9Xz4sNk5EFoF9F9l3v9NkqWg/N1AFV3fnx49hpP/GNj
	MzjQrndvwuCLhQB5aji2InCxEDf2S5n45VzuRmAC4tO3xCaCl4RG3P3GPF0cklQ=
X-Google-Smtp-Source: AGHT+IE0XCjV/3yYYMwoBQmzAlChW46lfbzke86yVwL9rnm1nDjpke41TpZzvJXHeqAoskq+Q5NECg==
X-Received: by 2002:a17:903:244e:b0:1db:dd24:9962 with SMTP id l14-20020a170903244e00b001dbdd249962mr2176820pls.21.1709820212327;
        Thu, 07 Mar 2024 06:03:32 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.79])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b001dd6174c651sm386228plk.149.2024.03.07.06.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:03:31 -0800 (PST)
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
Subject: [PATCH v16 2/9] irqchip: Add RISC-V incoming MSI controller early driver
Date: Thu,  7 Mar 2024 19:33:00 +0530
Message-Id: <20240307140307.646078-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307140307.646078-1-apatel@ventanamicro.com>
References: <20240307140307.646078-1-apatel@ventanamicro.com>
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

Add an early irqchip driver for RISC-V IMSIC which sets up the
IMSIC state and provide IPIs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Kconfig                 |   7 +
 drivers/irqchip/Makefile                |   1 +
 drivers/irqchip/irq-riscv-imsic-early.c | 201 ++++++
 drivers/irqchip/irq-riscv-imsic-state.c | 865 ++++++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h | 107 +++
 include/linux/cpuhotplug.h              |   1 +
 include/linux/irqchip/riscv-imsic.h     |  87 +++
 7 files changed, 1269 insertions(+)
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
index 000000000000..886418ec06cb
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
+	struct imsic_local_config *local = per_cpu_ptr(imsic->global.local, cpu);
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
+	virq = ipi_mux_create(IMSIC_NR_IPI, imsic_ipi_send);
+	if (virq <= 0)
+		return virq < 0 ? virq : -ENOMEM;
+
+	/* Set vIRQ range */
+	riscv_ipi_set_virq_range(virq, IMSIC_NR_IPI, true);
+
+	/* Announce that IMSIC is providing IPIs */
+	pr_info("%pfwP: providing IPIs using interrupt %d\n", imsic->fwnode, IMSIC_IPI_ID);
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
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int err, cpu = smp_processor_id();
+	struct imsic_vector *vec;
+	unsigned long local_id;
+
+	chained_irq_enter(chip, desc);
+
+	while ((local_id = csr_swap(CSR_TOPEI, 0))) {
+		local_id >>= TOPEI_ID_SHIFT;
+
+		if (local_id == IMSIC_IPI_ID) {
+			if (IS_ENABLED(CONFIG_SMP))
+				ipi_mux_process();
+			continue;
+		}
+
+		if (unlikely(!imsic->base_domain))
+			continue;
+
+		vec = imsic_vector_from_local_id(cpu, local_id);
+		if (!vec) {
+			pr_warn_ratelimited("vector not found for local ID 0x%lx\n", local_id);
+			continue;
+		}
+
+		err = generic_handle_domain_irq(imsic->base_domain, vec->hwirq);
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
+	domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_ANY);
+	if (!domain) {
+		pr_err("%pfwP: Failed to find INTC domain\n", fwnode);
+		return -ENOENT;
+	}
+	imsic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
+	if (!imsic_parent_irq) {
+		pr_err("%pfwP: Failed to create INTC mapping\n", fwnode);
+		return -ENOENT;
+	}
+
+	/* Initialize IPI domain */
+	rc = imsic_ipi_domain_init();
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
+	cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/riscv/imsic:starting",
+			  imsic_starting_cpu, imsic_dying_cpu);
+
+	return 0;
+}
+
+static int __init imsic_early_dt_init(struct device_node *node, struct device_node *parent)
+{
+	struct fwnode_handle *fwnode = &node->fwnode;
+	int rc;
+
+	/* Setup IMSIC state */
+	rc = imsic_setup_state(fwnode);
+	if (rc) {
+		pr_err("%pfwP: failed to setup state (error %d)\n", fwnode, rc);
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
+
+IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
new file mode 100644
index 000000000000..5479f872e62b
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
+static inline unsigned long imsic_csr_read_clear(unsigned long reg, unsigned long val)
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
+	isel = id / BITS_PER_LONG;
+	isel *= BITS_PER_LONG / IMSIC_EIPx_BITS;
+	isel += pend ? IMSIC_EIP0 : IMSIC_EIE0;
+	imask = BIT(id & (__riscv_xlen - 1));
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
+void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend, bool val)
+{
+	unsigned long id = base_id, last_id = base_id + num_id;
+	unsigned long i, isel, ireg;
+
+	while (id < last_id) {
+		isel = id / BITS_PER_LONG;
+		isel *= BITS_PER_LONG / IMSIC_EIPx_BITS;
+		isel += pend ? IMSIC_EIP0 : IMSIC_EIE0;
+
+		/*
+		 * Prepare the ID mask to be programmed in the
+		 * IMSIC EIEx and EIPx registers. These registers
+		 * are XLEN-wide and we must not touch IDs which
+		 * are < base_id and >= (base_id + num_id).
+		 */
+		ireg = 0;
+		for (i = id & (__riscv_xlen - 1); id < last_id && i < __riscv_xlen; i++) {
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
+static void __imsic_local_sync(struct imsic_local_priv *lpriv)
+{
+	struct imsic_local_config *mlocal;
+	struct imsic_vector *vec, *mvec;
+	int i;
+
+	lockdep_assert_held(&lpriv->lock);
+
+	for_each_set_bit(i, lpriv->dirty_bitmap, imsic->global.nr_ids + 1) {
+		if (!i || i == IMSIC_IPI_ID)
+			goto skip;
+		vec = &lpriv->vectors[i];
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
+		mvec = READ_ONCE(vec->move);
+		WRITE_ONCE(vec->move, NULL);
+		if (mvec && mvec != vec) {
+			if (__imsic_id_read_clear_pending(i)) {
+				mlocal = per_cpu_ptr(imsic->global.local, mvec->cpu);
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
+	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
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
+	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+	__imsic_local_sync(lpriv);
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+}
+
+static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu)
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
+		if (cpu == smp_processor_id()) {
+			__imsic_local_sync(lpriv);
+			return;
+		}
+
+		if (!timer_pending(&lpriv->timer)) {
+			lpriv->timer.expires = jiffies + 1;
+			add_timer_on(&lpriv->timer, cpu);
+		}
+	}
+}
+#else
+static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu)
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
+	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] != vec))
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
+	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] != vec))
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
+static bool imsic_vector_move_update(struct imsic_local_priv *lpriv, struct imsic_vector *vec,
+				     bool new_enable, struct imsic_vector *new_move)
+{
+	unsigned long flags;
+	bool enabled;
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+
+	/* Update enable and move details */
+	enabled = READ_ONCE(vec->enable);
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
+void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec)
+{
+	struct imsic_local_priv *old_lpriv, *new_lpriv;
+	bool enabled;
+
+	if (WARN_ON_ONCE(old_vec->cpu == new_vec->cpu))
+		return;
+
+	old_lpriv = per_cpu_ptr(imsic->lpriv, old_vec->cpu);
+	if (WARN_ON_ONCE(&old_lpriv->vectors[old_vec->local_id] != old_vec))
+		return;
+
+	new_lpriv = per_cpu_ptr(imsic->lpriv, new_vec->cpu);
+	if (WARN_ON_ONCE(&new_lpriv->vectors[new_vec->local_id] != new_vec))
+		return;
+
+	/*
+	 * Move and re-trigger the new vector based on the pending
+	 * state of the old vector because we might get a device
+	 * interrupt on the old vector while device was being moved
+	 * to the new vector.
+	 */
+	enabled = imsic_vector_move_update(old_lpriv, old_vec, false, new_vec);
+	imsic_vector_move_update(new_lpriv, new_vec, enabled, new_vec);
+}
+
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, int ind)
+{
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *mvec;
+	bool is_enabled;
+
+	lpriv = per_cpu_ptr(imsic->lpriv, vec->cpu);
+	if (WARN_ON_ONCE(&lpriv->vectors[vec->local_id] != vec))
+		return;
+
+	is_enabled = imsic_vector_isenabled(vec);
+	mvec = imsic_vector_get_move(vec);
+
+	seq_printf(m, "%*starget_cpu      : %5u\n", ind, "", vec->cpu);
+	seq_printf(m, "%*starget_local_id : %5u\n", ind, "", vec->local_id);
+	seq_printf(m, "%*sis_reserved     : %5u\n", ind, "",
+		   (vec->local_id <= IMSIC_IPI_ID) ? 1 : 0);
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
+struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int local_id)
+{
+	struct imsic_local_priv *lpriv = per_cpu_ptr(imsic->lpriv, cpu);
+
+	if (!lpriv || imsic->global.nr_ids < local_id)
+		return NULL;
+
+	return &lpriv->vectors[local_id];
+}
+
+struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask *mask)
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
+	vec->enable = false;
+	vec->move = NULL;
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
+	struct imsic_local_priv *lpriv;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		lpriv = per_cpu_ptr(imsic->lpriv, cpu);
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
+	struct imsic_global_config *global = &imsic->global;
+	struct imsic_local_priv *lpriv;
+	struct imsic_vector *vec;
+	int cpu, i;
+
+	/* Allocate per-CPU private state */
+	imsic->lpriv = alloc_percpu(typeof(*imsic->lpriv));
+	if (!imsic->lpriv)
+		return -ENOMEM;
+
+	/* Setup per-CPU private state */
+	for_each_possible_cpu(cpu) {
+		lpriv = per_cpu_ptr(imsic->lpriv, cpu);
+
+		raw_spin_lock_init(&lpriv->lock);
+
+		/* Allocate dirty bitmap */
+		lpriv->dirty_bitmap = bitmap_zalloc(global->nr_ids + 1, GFP_KERNEL);
+		if (!lpriv->dirty_bitmap)
+			goto fail_local_cleanup;
+
+#ifdef CONFIG_SMP
+		/* Setup lazy timer for synchronization */
+		timer_setup(&lpriv->timer, imsic_local_timer_callback, TIMER_PINNED);
+#endif
+
+		/* Allocate vector array */
+		lpriv->vectors = kcalloc(global->nr_ids + 1, sizeof(*lpriv->vectors),
+					 GFP_KERNEL);
+		if (!lpriv->vectors)
+			goto fail_local_cleanup;
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
+	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
+
+	raw_spin_lock_irqsave(&lpriv->lock, flags);
+	WARN_ON_ONCE(try_to_del_timer_sync(&lpriv->timer) < 0);
+	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
+#endif
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
+	while (!imsic_get_parent_hartid(fwnode, *nr_parent_irqs, &hartid))
+		(*nr_parent_irqs)++;
+	if (!*nr_parent_irqs) {
+		pr_err("%pfwP: no parent irqs available\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Find number of guest index bits in MSI address */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,guest-index-bits",
+				  &global->guest_index_bits);
+	if (rc)
+		global->guest_index_bits = 0;
+
+	/* Find number of HART index bits */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,hart-index-bits",
+				  &global->hart_index_bits);
+	if (rc) {
+		/* Assume default value */
+		global->hart_index_bits = __fls(*nr_parent_irqs);
+		if (BIT(global->hart_index_bits) < *nr_parent_irqs)
+			global->hart_index_bits++;
+	}
+
+	/* Find number of group index bits */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-bits",
+				  &global->group_index_bits);
+	if (rc)
+		global->group_index_bits = 0;
+
+	/*
+	 * Find first bit position of group index.
+	 * If not specified assumed the default APLIC-IMSIC configuration.
+	 */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,group-index-shift",
+				  &global->group_index_shift);
+	if (rc)
+		global->group_index_shift = IMSIC_MMIO_PAGE_SHIFT * 2;
+
+	/* Find number of interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
+				  &global->nr_ids);
+	if (rc) {
+		pr_err("%pfwP: number of interrupt identities not found\n", fwnode);
+		return rc;
+	}
+
+	/* Find number of guest interrupt identities */
+	rc = of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-ids",
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
+	if (global->nr_ids < IMSIC_MIN_ID ||
+	    global->nr_ids >= IMSIC_MAX_ID ||
+	    (global->nr_ids & IMSIC_MIN_ID) != IMSIC_MIN_ID) {
+		pr_err("%pfwP: invalid number of interrupt identities\n", fwnode);
+		return -EINVAL;
+	}
+
+	/* Sanity check number of guest interrupt identities */
+	if (global->nr_guest_ids < IMSIC_MIN_ID ||
+	    global->nr_guest_ids >= IMSIC_MAX_ID ||
+	    (global->nr_guest_ids & IMSIC_MIN_ID) != IMSIC_MIN_ID) {
+		pr_err("%pfwP: invalid number of guest interrupt identities\n", fwnode);
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
+	u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers = 0;
+	struct imsic_global_config *global;
+	struct imsic_local_config *local;
+	void __iomem **mmios_va = NULL;
+	struct resource *mmios = NULL;
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
+	imsic = kzalloc(sizeof(*imsic), GFP_KERNEL);
+	if (!imsic)
+		return -ENOMEM;
+	imsic->fwnode = fwnode;
+	global = &imsic->global;
+
+	global->local = alloc_percpu(typeof(*global->local));
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
+			pr_err("%pfwP: unable to parse MMIO regset %d\n", fwnode, i);
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
+			pr_err("%pfwP: address mismatch for regset %d\n", fwnode, i);
+			goto out_iounmap;
+		}
+
+		mmios_va[i] = ioremap(mmios[i].start, resource_size(&mmios[i]));
+		if (!mmios_va[i]) {
+			rc = -EIO;
+			pr_err("%pfwP: unable to map MMIO regset %d\n", fwnode, i);
+			goto out_iounmap;
+		}
+	}
+
+	/* Initialize local (or per-CPU )state */
+	rc = imsic_local_init();
+	if (rc) {
+		pr_err("%pfwP: failed to initialize local state\n",
+		       fwnode);
+		goto out_iounmap;
+	}
+
+	/* Configure handlers for target CPUs */
+	for (i = 0; i < nr_parent_irqs; i++) {
+		rc = imsic_get_parent_hartid(fwnode, i, &hartid);
+		if (rc) {
+			pr_warn("%pfwP: hart ID for parent irq%d not found\n", fwnode, i);
+			continue;
+		}
+
+		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("%pfwP: invalid cpuid for parent irq%d\n", fwnode, i);
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
+			pr_warn("%pfwP: MMIO not found for parent irq%d\n", fwnode, i);
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
index 000000000000..8ec9649d0d01
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
+void __imsic_eix_update(unsigned long base_id, unsigned long num_id, bool pend, bool val);
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
+static inline struct imsic_vector *imsic_vector_get_move(struct imsic_vector *vec)
+{
+	return READ_ONCE(vec->move);
+}
+
+void imsic_vector_move(struct imsic_vector *old_vec, struct imsic_vector *new_vec);
+
+struct imsic_vector *imsic_vector_from_local_id(unsigned int cpu, unsigned int local_id);
+
+struct imsic_vector *imsic_vector_alloc(unsigned int hwirq, const struct cpumask *mask);
+void imsic_vector_free(struct imsic_vector *vector);
+
+void imsic_vector_debug_show(struct seq_file *m, struct imsic_vector *vec, int ind);
+void imsic_vector_debug_show_summary(struct seq_file *m, int ind);
+
+void imsic_state_online(void);
+void imsic_state_offline(void);
+int imsic_setup_state(struct fwnode_handle *fwnode);
+
+#endif
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 172d0a743e5d..39d36183d9fc 100644
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
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
new file mode 100644
index 000000000000..faf0b800b1b0
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
-- 
2.34.1


