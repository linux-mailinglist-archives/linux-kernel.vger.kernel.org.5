Return-Path: <linux-kernel+bounces-95684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11F0875140
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22F95B2717D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62B12EBD4;
	Thu,  7 Mar 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fzffflav"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B115112F5A7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709820220; cv=none; b=n5emJVKBvZf0n6oiENUOKX97z2shiMeBkCpaFclqfaNHXnjzJzForYx7kLD4ig9GGcxd6lbmhodxS+otg0jhd1ys8DW1HX6akrsIrjnGeXSIxtYixTyQs1x83bpD6DlV7xl+Cn9hJivpn0tr2RFfb/dMq00upy0F3vFFcEHL3TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709820220; c=relaxed/simple;
	bh=C9EKczNAFX+6Mc1JCsVPq0H3H5ZJEkOYL3PTY/VUSH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERs0uhbhYRE3MnACba23XULKYPZWfmBclgFLGDFQSBiLNH3TysYZsmKtGY3G6AGFj6FSYHU3vXLz2FxjIeNagHwmiphef6RIG+UZQLYrFlgRf4bfiI1yh1xF6q2VygUKVx1RGzi58ubZ50ub4RHCK/CabDtzmimFp99lCW8AMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fzffflav; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd10ae77d8so8051835ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709820218; x=1710425018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiqobbaTZGToIizH7YEjH5rrAclq8QumllxtxL7qHRY=;
        b=fzffflavSscKsIM1BRifORqwJqkV8aNyo35eY6ieyGaubIkN9w7Yjsa+7v19rCREBh
         n8knaKf9+sUkAabM/+hXLSI2cQH6JR5kZhSsPbl+C6cR05Kzh5tJ6jDFBDIypdeeYv0w
         73j+vKp21kGg5eZcv7UDDoyKZ10kPObt3BiYS+qvGpTLs2CKCnSQQwZaBoJAHRdcqxkH
         l7lJTuy6Lm12u5OBLPwjhHBFznaX96XlJh/jS79xTSZWmwtpmQ5tjrVXhbs+yUqNnGQ/
         nl/gAZwaJ9Mkpp+VJmAywFiHiy8jxKeQ3jyiklnnKzsUoU23mReGESDFxtoDepxl0zQP
         8PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709820218; x=1710425018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CiqobbaTZGToIizH7YEjH5rrAclq8QumllxtxL7qHRY=;
        b=pGHcCkG7wf4mxzFYT8nRb9oY+OqcmfjYRqsBlw10CCfUWFBfGDKbDwymKWpIF579fn
         r8eKGFs0TgifmPxfbvr9qN3uwdlX2Prm7l4rZlkpqOGn/ky7Z5NcSaISxVpJbDnT5dQG
         hW9cgZrT9sKqIV1vBoPZUUAfOLy0jArY6XqkS+YV6jKPpWVm/Yb6mAmGeG5hWEkK2uG7
         IuV9PqHnL60X49H5gDL30qAwcHaQGFQ46vvkJQdHyKAWts1xbrOvdyD6GMtNralCK1sj
         vbvmC6xyomxNfZTKe8XBgJpqh0qrHuKVcZMx903ocZ2LMHo11/sBYS5AS0CP4sY6O+26
         G07Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1YtQHTkR71nwjbTeK5CavGZaHRuTrpQW8841Oi8CZrKAMCOWnuyjnZERB0XOh7uzk6g2rZQa0sogWlm90c0uIGU1/k8VMQkigsXdo
X-Gm-Message-State: AOJu0YyO4lo59DyuGti9xDZmmrLQaDYrmyGSJbcrUfGPk0j8Uoflw6Rc
	7E7QC2oDudhWavZSfWPQ+R/CD4PgIixqbqYYkGqngxpDHoIL2vs/sRkO1KSg0TA=
X-Google-Smtp-Source: AGHT+IHW4m035NlTDyk9r9csSv4GlQ6fJ+YJ+amFlFaJmsuynrdQLjHIa5ggVqQfR7SmYET/DEWDKw==
X-Received: by 2002:a17:902:ecd1:b0:1dc:8c27:9a07 with SMTP id a17-20020a170902ecd100b001dc8c279a07mr9805559plh.31.1709820217708;
        Thu, 07 Mar 2024 06:03:37 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.79])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b001dd6174c651sm386228plk.149.2024.03.07.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 06:03:37 -0800 (PST)
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
Subject: [PATCH v16 3/9] irqchip/riscv-imsic: Add device MSI domain support for platform devices
Date: Thu,  7 Mar 2024 19:33:01 +0530
Message-Id: <20240307140307.646078-4-apatel@ventanamicro.com>
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

The Linux platform MSI support allows per-device MSI domains so add
a platform irqchip driver for RISC-V IMSIC which provides a base IRQ
domain with MSI parent support for platform device domains.

The IMSIC platform driver assumes that the IMSIC state is already
initialized by the IMSIC early driver.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/Makefile                   |   2 +-
 drivers/irqchip/irq-riscv-imsic-platform.c | 343 +++++++++++++++++++++
 drivers/irqchip/irq-riscv-imsic-state.h    |   1 +
 3 files changed, 345 insertions(+), 1 deletion(-)
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
index 000000000000..35291bf90d65
--- /dev/null
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -0,0 +1,343 @@
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
+		*out_msi_pa = local->msi_pa + (guest_index * IMSIC_MMIO_PAGE_SZ);
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
+	if (WARN_ON(!vec))
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
+	if (WARN_ON(!vec))
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
+	struct msi_msg msg = { };
+
+	imsic_irq_compose_vector_msg(vec, &msg);
+	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
+}
+
+static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
+				  bool force)
+{
+	struct imsic_vector *old_vec, *new_vec;
+	struct irq_data *pd = d->parent_data;
+
+	old_vec = irq_data_get_irq_chip_data(pd);
+	if (WARN_ON(!old_vec))
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
+	/* Multi-MSI is not supported yet. */
+	if (nr_irqs > 1)
+		return -EOPNOTSUPP;
+
+	vec = imsic_vector_alloc(virq, cpu_online_mask);
+	if (!vec)
+		return -ENOSPC;
+
+	irq_domain_set_info(domain, virq, virq, &imsic_irq_base_chip, vec,
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
+						    &imsic_base_domain_ops, imsic);
+	if (!imsic->base_domain) {
+		pr_err("%pfwP: failed to create IMSIC base domain\n", imsic->fwnode);
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
index 8ec9649d0d01..5ae2f69b035b 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -103,5 +103,6 @@ void imsic_vector_debug_show_summary(struct seq_file *m, int ind);
 void imsic_state_online(void);
 void imsic_state_offline(void);
 int imsic_setup_state(struct fwnode_handle *fwnode);
+int imsic_irqdomain_init(void);
 
 #endif
-- 
2.34.1


