Return-Path: <linux-kernel+bounces-72382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42985B2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D25B20AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AAF57872;
	Tue, 20 Feb 2024 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Fwz1N40W"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57E59B50
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409312; cv=none; b=uTvy/8ZQR7jFRSSesRrtQ6wQ/inFK6wMRseD1nJ1N/x9/MoyiQ6HM1pbbZhloP5WZXEI3+J5L2V1pAlK4sYsAI5b/glohCp9UaJQGny4IvU6tN7X7a0rjbze0ZIN4M50gwSsRi0M6D+P24ctt4uOo423RBG3kPcsva+fopCkMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409312; c=relaxed/simple;
	bh=YvNXZqrDaRGvnaoLeIru3Sh+vCb2n2jA/PNMOYQ5Z7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ABkkrYOHATug3xu/sxO0qTxS0jIIeDICM/yj+zW492DgH534FMKbdyQ1Kbu6rwVvTymnbk4MUE77EpOsV8yOUEdIHNVGS9q2unekmh3j2trd2KyNoQApJADqKNEfGRxEy3bufRDo949u8k0A24+UzMl13s8KYVXzGxAVVynFZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Fwz1N40W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dba6b9b060so24194435ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708409308; x=1709014108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEBbSt++pW2vEtrYFH67jHO1QQgmaVoXXCadjue8h4U=;
        b=Fwz1N40WfKtzWaKNxeNxLWgH5N3zULTUaYtBr0QGGOCbTUjBJxFbq0ATOVMZxD3/Xg
         1sEbZ+jxnQZ1IwSpmGvCoMuk0KowdmQPyxJxu+LHjDycmGEfJnb1wuRmkK296fLf3Uv5
         6Kq0qGRMXGZgLUH5kWVUd7ZabcC6r27+70KjOf0Y6pDZcJWCZIhqvFicx3y9WNHxP0mu
         YpH3eVgorIk6SS2vVB4vIbLWv0sAS7sTLgXms+ouSDMsDBtCc1sbUc35sOuwsX8OvVuS
         sWmaeZ001BBefWGRp6/EUWOTj49bg5t3f1uimsLmfh94HtBm7nGhJx//zKyxmpyNhvjL
         3n4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409308; x=1709014108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEBbSt++pW2vEtrYFH67jHO1QQgmaVoXXCadjue8h4U=;
        b=VKZRBBZ2VnXES7XWRtRVSOeQkXEWCZ7L5cTOSosmZkR9KM6WEY20Wy2G8ykBFOwSUZ
         dYUX7/lAh+7rUDfDu0Y69grBuZvBwg8XmbcwQTkSYrB3dIXBInBHWCwZoPAeslPlazJt
         T09yqywyRfdF+DLbz1/ejvo0N5aQZkrNF+PKA3cKfI8I0QIE4R+1AE8+B4zuhPeLO3Lo
         3y1I+NXOgWgjDEFcDsOuFtrPqX4fYj24CeX3BWIeisOvrdHHj7jzWdsmCJFnaVirCbte
         30NV4Q2RJJpIvFzs/ByzYlicZbK5rb4j49lD1DLeppvH7ngUnisRlScbnvplS93B4FFa
         LVbA==
X-Forwarded-Encrypted: i=1; AJvYcCWzmc7TRoNvllPO+zX6QJ5TfdhzptP4TMllQ61xShKil9rv5zVdrq70bwbKlEs8ctR2k4HZ6n+MToQKvmHao4Vz47UmonWepOBkfypI
X-Gm-Message-State: AOJu0YzTRZg6amGC2yuocDt0aSZAKPe6d1gj1WxUXxatLf7BWCWllsJo
	is1v6Smi2OtNAGaYFRVNBayj9IQE5EVOA8w2D9VYbHKnALg4ybRr48XbudxHaM8=
X-Google-Smtp-Source: AGHT+IF5cER56jgzLQXTXz2vEXvrIWcTxfQBqefqgH/lHMc+MznvOkqrIVS8ARXOvc90JVyaKNa9iA==
X-Received: by 2002:a17:903:22ca:b0:1db:d9b7:ac55 with SMTP id y10-20020a17090322ca00b001dbd9b7ac55mr9500370plg.27.1708409308065;
        Mon, 19 Feb 2024 22:08:28 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001db4c89aea5sm5368114plt.158.2024.02.19.22.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:08:27 -0800 (PST)
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
Subject: [PATCH v13 07/13] irqchip/riscv-imsic: Add device MSI domain support for platform devices
Date: Tue, 20 Feb 2024 11:37:12 +0530
Message-Id: <20240220060718.823229-8-apatel@ventanamicro.com>
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

The Linux platform MSI support allows per-device MSI domains so let
us add a platform irqchip driver for RISC-V IMSIC which provides a
base IRQ domain with MSI parent support for platform device domains.

This driver assumes that the IMSIC state is already initialized by
the IMSIC early driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Makefile                   |   2 +-
 drivers/irqchip/irq-riscv-imsic-platform.c | 346 +++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h    |   1 +
 3 files changed, 348 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-riscv-imsic-platform.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d714724387ce..abca445a3229 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -95,7 +95,7 @@ obj-$(CONFIG_QCOM_MPM)			+= irq-qcom-mpm.o
 obj-$(CONFIG_CSKY_MPINTC)		+= irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+= irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+= irq-riscv-intc.o
-obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o
+obj-$(CONFIG_RISCV_IMSIC)		+= irq-riscv-imsic-state.o irq-riscv-imsic-early.o irq-riscv-imsic-platform.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
 obj-$(CONFIG_IMX_IRQSTEER)		+= irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+= irq-imx-intmux.o
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
new file mode 100644
index 000000000000..7ee44c493dbc
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ * Copyright (C) 2022 Ventana Micro Systems Inc.
+ */
+
+#define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/bitmap.h>
+#include <linux/cpu.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+
+#include "irq-riscv-imsic-state.h"
+
+static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_index,
+				phys_addr_t *out_msi_pa)
+{
+	struct imsic_global_config *global;
+	struct imsic_local_config *local;
+
+	global = &imsic->global;
+	local = per_cpu_ptr(global->local, cpu);
+
+	if (BIT(global->guest_index_bits) <= guest_index)
+		return false;
+
+	if (out_msi_pa)
+		*out_msi_pa = local->msi_pa +
+			      (guest_index * IMSIC_MMIO_PAGE_SZ);
+
+	return true;
+}
+
+static void imsic_irq_mask(struct irq_data *d)
+{
+	imsic_vector_mask(irq_data_get_irq_chip_data(d));
+}
+
+static void imsic_irq_unmask(struct irq_data *d)
+{
+	imsic_vector_unmask(irq_data_get_irq_chip_data(d));
+}
+
+static int imsic_irq_retrigger(struct irq_data *d)
+{
+	struct imsic_vector *vec = irq_data_get_irq_chip_data(d);
+	struct imsic_local_config *local;
+
+	if (WARN_ON(vec == NULL))
+		return -ENOENT;
+
+	local = per_cpu_ptr(imsic->global.local, vec->cpu);
+	writel_relaxed(vec->local_id, local->msi_va);
+	return 0;
+}
+
+static void imsic_irq_compose_vector_msg(struct imsic_vector *vec, struct msi_msg *msg)
+{
+	phys_addr_t msi_addr;
+
+	if (WARN_ON(vec == NULL))
+		return;
+
+	if (WARN_ON(!imsic_cpu_page_phys(vec->cpu, 0, &msi_addr)))
+		return;
+
+	msg->address_hi = upper_32_bits(msi_addr);
+	msg->address_lo = lower_32_bits(msi_addr);
+	msg->data = vec->local_id;
+}
+
+static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	imsic_irq_compose_vector_msg(irq_data_get_irq_chip_data(d), msg);
+}
+
+#ifdef CONFIG_SMP
+static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *vec)
+{
+	struct msi_msg msg[2] = { [1] = { }, };
+
+	imsic_irq_compose_vector_msg(vec, msg);
+	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, msg);
+}
+
+static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+				  bool force)
+{
+	struct imsic_vector *old_vec, *new_vec;
+	struct irq_data *pd = d->parent_data;
+
+	old_vec = irq_data_get_irq_chip_data(pd);
+	if (WARN_ON(old_vec == NULL))
+		return -ENOENT;
+
+	/* If old vector cpu belongs to the target cpumask then do nothing */
+	if (cpumask_test_cpu(old_vec->cpu, mask_val))
+		return IRQ_SET_MASK_OK_DONE;
+
+	/* If move is already in-flight then return failure */
+	if (imsic_vector_get_move(old_vec))
+		return -EBUSY;
+
+	/* Get a new vector on the desired set of CPUs */
+	new_vec = imsic_vector_alloc(old_vec->hwirq, mask_val);
+	if (!new_vec)
+		return -ENOSPC;
+
+	/* Point device to the new vector */
+	imsic_msi_update_msg(d, new_vec);
+
+	/* Update irq descriptors with the new vector */
+	pd->chip_data = new_vec;
+
+	/* Update effective affinity of parent irq data */
+	irq_data_update_effective_affinity(pd, cpumask_of(new_vec->cpu));
+
+	/* Move state of the old vector to the new vector */
+	imsic_vector_move(old_vec, new_vec);
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+#endif
+
+static struct irq_chip imsic_irq_base_chip = {
+	.name			= "IMSIC",
+	.irq_mask		= imsic_irq_mask,
+	.irq_unmask		= imsic_irq_unmask,
+	.irq_retrigger		= imsic_irq_retrigger,
+	.irq_compose_msi_msg	= imsic_irq_compose_msg,
+	.flags			= IRQCHIP_SKIP_SET_WAKE |
+				  IRQCHIP_MASK_ON_SUSPEND,
+};
+
+static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs, void *args)
+{
+	struct imsic_vector *vec;
+
+	/* Legacy-MSI or multi-MSI not supported yet. */
+	if (nr_irqs > 1)
+		return -ENOTSUPP;
+
+	vec = imsic_vector_alloc(virq, cpu_online_mask);
+	if (!vec)
+		return -ENOSPC;
+
+	irq_domain_set_info(domain, virq, virq,
+			    &imsic_irq_base_chip, vec,
+			    handle_simple_irq, NULL, NULL);
+	irq_set_noprobe(virq);
+	irq_set_affinity(virq, cpu_online_mask);
+
+	return 0;
+}
+
+static void imsic_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				  unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+
+	imsic_vector_free(irq_data_get_irq_chip_data(d));
+	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
+}
+
+static int imsic_irq_domain_select(struct irq_domain *domain, struct irq_fwspec *fwspec,
+				   enum irq_domain_bus_token bus_token)
+{
+	const struct msi_parent_ops *ops = domain->msi_parent_ops;
+	u32 busmask = BIT(bus_token);
+
+	if (fwspec->fwnode != domain->fwnode || fwspec->param_count != 0)
+		return 0;
+
+	/* Handle pure domain searches */
+	if (bus_token == ops->bus_select_token)
+		return 1;
+
+	return !!(ops->bus_select_mask & busmask);
+}
+
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+static void imsic_irq_debug_show(struct seq_file *m, struct irq_domain *d,
+				 struct irq_data *irqd, int ind)
+{
+	if (!irqd) {
+		imsic_vector_debug_show_summary(m, ind);
+		return;
+	}
+
+	imsic_vector_debug_show(m, irq_data_get_irq_chip_data(irqd), ind);
+}
+#endif
+
+static const struct irq_domain_ops imsic_base_domain_ops = {
+	.alloc		= imsic_irq_domain_alloc,
+	.free		= imsic_irq_domain_free,
+	.select		= imsic_irq_domain_select,
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	.debug_show	= imsic_irq_debug_show,
+#endif
+};
+
+static bool imsic_init_dev_msi_info(struct device *dev,
+				    struct irq_domain *domain,
+				    struct irq_domain *real_parent,
+				    struct msi_domain_info *info)
+{
+	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
+
+	/* MSI parent domain specific settings */
+	switch (real_parent->bus_token) {
+	case DOMAIN_BUS_NEXUS:
+		if (WARN_ON_ONCE(domain != real_parent))
+			return false;
+#ifdef CONFIG_SMP
+		info->chip->irq_set_affinity = imsic_irq_set_affinity;
+#endif
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* Is the target supported? */
+	switch (info->bus_token) {
+	case DOMAIN_BUS_DEVICE_MSI:
+		/*
+		 * Per-device MSI should never have any MSI feature bits
+		 * set. It's sole purpose is to create a dumb interrupt
+		 * chip which has a device specific irq_write_msi_msg()
+		 * callback.
+		 */
+		if (WARN_ON_ONCE(info->flags))
+			return false;
+
+		/* Core managed MSI descriptors */
+		info->flags |= MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
+			       MSI_FLAG_FREE_MSI_DESCS;
+		break;
+	case DOMAIN_BUS_WIRED_TO_MSI:
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* Use hierarchial chip operations re-trigger */
+	info->chip->irq_retrigger = irq_chip_retrigger_hierarchy;
+
+	/*
+	 * Mask out the domain specific MSI feature flags which are not
+	 * supported by the real parent.
+	 */
+	info->flags &= pops->supported_flags;
+
+	/* Enforce the required flags */
+	info->flags |= pops->required_flags;
+
+	return true;
+}
+
+#define MATCH_PLATFORM_MSI		BIT(DOMAIN_BUS_PLATFORM_MSI)
+
+static const struct msi_parent_ops imsic_msi_parent_ops = {
+	.supported_flags	= MSI_GENERIC_FLAGS_MASK,
+	.required_flags		= MSI_FLAG_USE_DEF_DOM_OPS |
+				  MSI_FLAG_USE_DEF_CHIP_OPS,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PLATFORM_MSI,
+	.init_dev_msi_info	= imsic_init_dev_msi_info,
+};
+
+int imsic_irqdomain_init(void)
+{
+	struct imsic_global_config *global;
+
+	if (!imsic || !imsic->fwnode) {
+		pr_err("early driver not probed\n");
+		return -ENODEV;
+	}
+
+	if (imsic->base_domain) {
+		pr_err("%pfwP: irq domain already created\n", imsic->fwnode);
+		return -ENODEV;
+	}
+
+	/* Create Base IRQ domain */
+	imsic->base_domain = irq_domain_create_tree(imsic->fwnode,
+					&imsic_base_domain_ops, imsic);
+	if (!imsic->base_domain) {
+		pr_err("%pfwP: failed to create IMSIC base domain\n",
+			imsic->fwnode);
+		return -ENOMEM;
+	}
+	imsic->base_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	imsic->base_domain->msi_parent_ops = &imsic_msi_parent_ops;
+
+	irq_domain_update_bus_token(imsic->base_domain, DOMAIN_BUS_NEXUS);
+
+	global = &imsic->global;
+	pr_info("%pfwP:  hart-index-bits: %d,  guest-index-bits: %d\n",
+		imsic->fwnode, global->hart_index_bits, global->guest_index_bits);
+	pr_info("%pfwP: group-index-bits: %d, group-index-shift: %d\n",
+		imsic->fwnode, global->group_index_bits, global->group_index_shift);
+	pr_info("%pfwP: per-CPU IDs %d at base PPN %pa\n",
+		imsic->fwnode, global->nr_ids, &global->base_addr);
+	pr_info("%pfwP: total %d interrupts available\n",
+		imsic->fwnode, num_possible_cpus() * (global->nr_ids - 1));
+
+	return 0;
+}
+
+static int imsic_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	if (imsic && imsic->fwnode != dev->fwnode) {
+		dev_err(dev, "fwnode mismatch\n");
+		return -ENODEV;
+	}
+
+	return imsic_irqdomain_init();
+}
+
+static const struct of_device_id imsic_platform_match[] = {
+	{ .compatible = "riscv,imsics" },
+	{}
+};
+
+static struct platform_driver imsic_platform_driver = {
+	.driver = {
+		.name		= "riscv-imsic",
+		.of_match_table	= imsic_platform_match,
+	},
+	.probe = imsic_platform_probe,
+};
+builtin_platform_driver(imsic_platform_driver);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index f0c983db99eb..a01a70eff3af 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -94,5 +94,6 @@ void imsic_vector_debug_show_summary(struct seq_file *m, int ind);
 void imsic_state_online(void);
 void imsic_state_offline(void);
 int imsic_setup_state(struct fwnode_handle *fwnode);
+int imsic_irqdomain_init(void);
 
 #endif
-- 
2.34.1


