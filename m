Return-Path: <linux-kernel+bounces-78058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F338C860E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BC92820F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC805CDF5;
	Fri, 23 Feb 2024 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UR8WfvVY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+q0laJN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595205D499;
	Fri, 23 Feb 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681448; cv=none; b=br9MngGsj2YIOVfQFZf4UaSy2/SEd3Ehs0cLMwqiSU7hfkrMYUcN0nlTQBUaeAJPHXn02MuVb8rCvOWQtMTwhKxJhKIASmrnBTGvs3oFX4oHA1b8RgSz3zgJ9EkqskOc4/6oYYkj8guSfK2KuMc9YFKucIzE5tYIgS1yDJyyTtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681448; c=relaxed/simple;
	bh=Q/KdpPKZGWLn98aFJ1C6JiQKqGww6+246E9jDXaWI0I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fC6cayDJqiEWFyXk0P31y7XjBVLZ//WV2oAaZUlM7gJac4t5Vl6/DHMF6IGDPcIH+YuqdCP0wpo4/s9ZI8+I/I0rUnmOtKQkgjEYWeKDKQW/B8cLVJS3aCLmwdH0B5VJj4XQxQSMGuUfGTaSfvphhHY2iA30SnGOhz8HfKAzXW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UR8WfvVY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+q0laJN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBjzg11JDVrOJVRVCE6HiUrlesIYA1FvWWvNt34+m9A=;
	b=UR8WfvVYAIEits6F7k8EhPY9BVieOkQ7nwHDZvQ5YDWzwN1x4imT3HhAzBDATMAiBWCLqC
	Hnheg5WGipmja4ulrvFWWrK/oMwdrOiHjMUDvurhH3ctSivCxUUeTTkUFl2+EAIybS8U19
	1u3E4N743SI5HRA9cp60dhRpE83Q/iaAb2JdXgPJWj9sOlzaPw4cLcIcndwNCgucE28ASd
	JWbFFgp1FrujnVcD9FPaPU9ybcx/Lgd90aT2xBhGM7wALeJ02AX0eK/IYTYixAbvW8OUas
	XUyYTm8WiW64H2EzNW4VgJsTVCI1IrkZoyuNuzn8O2fKXZMp1obC85zPtz9eTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBjzg11JDVrOJVRVCE6HiUrlesIYA1FvWWvNt34+m9A=;
	b=q+q0laJN6u8ZqiOH576f/oQO3KdKzNvbW17nf2t/cfG+RjdyiB1Y5Wd4MxQfZPOK8o8A97
	/dv2fUhAsjZRuECA==
From: "tip-bot2 for Yu Chien Peter Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/riscv-intc: Introduce Andes hart-level
 interrupt controller
Cc: Yu Chien Peter Lin <peterlin@andestech.com>,
 Thomas Gleixner <tglx@linutronix.de>, Randolph <randolph@andestech.com>,
 Anup Patel <anup@brainfault.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240222083946.3977135-4-peterlin@andestech.com>
References: <20240222083946.3977135-4-peterlin@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143940.398.4368252629359538109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     f4cc33e78ba8624a79ba8dea98ce5c85aa9ca33c
Gitweb:        https://git.kernel.org/tip/f4cc33e78ba8624a79ba8dea98ce5c85aa9ca33c
Author:        Yu Chien Peter Lin <peterlin@andestech.com>
AuthorDate:    Thu, 22 Feb 2024 16:39:39 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 09:57:42 +01:00

irqchip/riscv-intc: Introduce Andes hart-level interrupt controller

Add support for the Andes hart-level interrupt controller. This
controller provides interrupt mask/unmask functions to access the
custom register (SLIE) where the non-standard S-mode local interrupt
enable bits are located. The base of custom interrupt number is set
to 256.

To share the riscv_intc_domain_map() with the generic RISC-V INTC and
ACPI, add a chip parameter to riscv_intc_init_common(), so it can be
passed to the irq_domain_set_info() as a private data.

Andes hart-level interrupt controller requires the "andestech,cpu-intc"
compatible string to be present in interrupt-controller of cpu node to
enable the use of custom local interrupt source.
e.g.,

  cpu0: cpu@0 {
      compatible = "andestech,ax45mp", "riscv";
      ...
      cpu0-intc: interrupt-controller {
          #interrupt-cells = <0x01>;
          compatible = "andestech,cpu-intc", "riscv,cpu-intc";
          interrupt-controller;
      };
  };

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Randolph <randolph@andestech.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20240222083946.3977135-4-peterlin@andestech.com

---
 drivers/irqchip/irq-riscv-intc.c | 58 +++++++++++++++++++++++++++----
 include/linux/soc/andes/irq.h    | 18 ++++++++++-
 2 files changed, 69 insertions(+), 7 deletions(-)
 create mode 100644 include/linux/soc/andes/irq.h

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 684875c..0cd6b48 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/soc/andes/irq.h>
 
 static struct irq_domain *intc_domain;
 static unsigned int riscv_intc_nr_irqs __ro_after_init = BITS_PER_LONG;
@@ -48,6 +49,31 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
 	csr_set(CSR_IE, BIT(d->hwirq));
 }
 
+static void andes_intc_irq_mask(struct irq_data *d)
+{
+	/*
+	 * Andes specific S-mode local interrupt causes (hwirq)
+	 * are defined as (256 + n) and controlled by n-th bit
+	 * of SLIE.
+	 */
+	unsigned int mask = BIT(d->hwirq % BITS_PER_LONG);
+
+	if (d->hwirq < ANDES_SLI_CAUSE_BASE)
+		csr_clear(CSR_IE, mask);
+	else
+		csr_clear(ANDES_CSR_SLIE, mask);
+}
+
+static void andes_intc_irq_unmask(struct irq_data *d)
+{
+	unsigned int mask = BIT(d->hwirq % BITS_PER_LONG);
+
+	if (d->hwirq < ANDES_SLI_CAUSE_BASE)
+		csr_set(CSR_IE, mask);
+	else
+		csr_set(ANDES_CSR_SLIE, mask);
+}
+
 static void riscv_intc_irq_eoi(struct irq_data *d)
 {
 	/*
@@ -71,12 +97,21 @@ static struct irq_chip riscv_intc_chip = {
 	.irq_eoi = riscv_intc_irq_eoi,
 };
 
+static struct irq_chip andes_intc_chip = {
+	.name		= "RISC-V INTC",
+	.irq_mask	= andes_intc_irq_mask,
+	.irq_unmask	= andes_intc_irq_unmask,
+	.irq_eoi	= riscv_intc_irq_eoi,
+};
+
 static int riscv_intc_domain_map(struct irq_domain *d, unsigned int irq,
 				 irq_hw_number_t hwirq)
 {
+	struct irq_chip *chip = d->host_data;
+
 	irq_set_percpu_devid(irq);
-	irq_domain_set_info(d, irq, hwirq, &riscv_intc_chip, d->host_data,
-			    handle_percpu_devid_irq, NULL, NULL);
+	irq_domain_set_info(d, irq, hwirq, chip, NULL, handle_percpu_devid_irq,
+			    NULL, NULL);
 
 	return 0;
 }
@@ -122,11 +157,12 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
 	return intc_domain->fwnode;
 }
 
-static int __init riscv_intc_init_common(struct fwnode_handle *fn)
+static int __init riscv_intc_init_common(struct fwnode_handle *fn,
+					 struct irq_chip *chip)
 {
 	int rc;
 
-	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops, NULL);
+	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops, chip);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
 		return -ENXIO;
@@ -152,8 +188,9 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	int rc;
+	struct irq_chip *chip = &riscv_intc_chip;
 	unsigned long hartid;
+	int rc;
 
 	rc = riscv_of_parent_hartid(node, &hartid);
 	if (rc < 0) {
@@ -178,10 +215,17 @@ static int __init riscv_intc_init(struct device_node *node,
 		return 0;
 	}
 
-	return riscv_intc_init_common(of_node_to_fwnode(node));
+	if (of_device_is_compatible(node, "andestech,cpu-intc")) {
+		riscv_intc_custom_base = ANDES_SLI_CAUSE_BASE;
+		riscv_intc_custom_nr_irqs = ANDES_RV_IRQ_LAST;
+		chip = &andes_intc_chip;
+	}
+
+	return riscv_intc_init_common(of_node_to_fwnode(node), chip);
 }
 
 IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
+IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
 
 #ifdef CONFIG_ACPI
 
@@ -208,7 +252,7 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	}
 
-	return riscv_intc_init_common(fn);
+	return riscv_intc_init_common(fn, &riscv_intc_chip);
 }
 
 IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
diff --git a/include/linux/soc/andes/irq.h b/include/linux/soc/andes/irq.h
new file mode 100644
index 0000000..edc3182
--- /dev/null
+++ b/include/linux/soc/andes/irq.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 Andes Technology Corporation
+ */
+#ifndef __ANDES_IRQ_H
+#define __ANDES_IRQ_H
+
+/* Andes PMU irq number */
+#define ANDES_RV_IRQ_PMOVI		18
+#define ANDES_RV_IRQ_LAST		ANDES_RV_IRQ_PMOVI
+#define ANDES_SLI_CAUSE_BASE		256
+
+/* Andes PMU related registers */
+#define ANDES_CSR_SLIE			0x9c4
+#define ANDES_CSR_SLIP			0x9c5
+#define ANDES_CSR_SCOUNTEROF		0x9d4
+
+#endif /* __ANDES_IRQ_H */

