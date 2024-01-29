Return-Path: <linux-kernel+bounces-42459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1355D840198
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5592284356
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D758213;
	Mon, 29 Jan 2024 09:28:17 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C855C05;
	Mon, 29 Jan 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520495; cv=none; b=uq1cpye09faea5qfYytAlWL8GHUcsI69GvOjjM1jhR1VcGbgPzUzjoFlWvS5HuA+hkj0jt9waPCbPi/nvzaInrYVFs2QizERdhFVzDD4hBsdFdjQFiK4CqngBQjGIdV3wJ7d3hfKiLasrZUFDAuiddliQsqmGNzvdapa+XTO+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520495; c=relaxed/simple;
	bh=2xgZbYlwwY29qdQ3POaWj9fCekHsXRXCoTpyW+prVB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNG4+vf2KcRrp7G+M8xDE25YCF/FTzNwzCeZfV4yIPDskqYL6ozAbYAGKwfMYbQlOHA2k+9DhbS8qNLdBtzUaO2WkcIOvyjV+2Q52zdxNcw7ohhFCpq20gQX95jbb5xpEo8fsBSmcXIvCeWaLQL85lizr86/igUx4Ai4TyoKLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 40T9QEcR080087;
	Mon, 29 Jan 2024 17:26:14 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Jan 2024
 17:26:11 +0800
From: Yu Chien Peter Lin <peterlin@andestech.com>
To: <acme@kernel.org>, <adrian.hunter@intel.com>, <ajones@ventanamicro.com>,
        <alexander.shishkin@linux.intel.com>, <andre.przywara@arm.com>,
        <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <conor+dt@kernel.org>,
        <conor.dooley@microchip.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>, <jolsa@kernel.org>,
        <jszhang@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <locus84@andestech.com>,
        <magnus.damm@gmail.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <n.shubin@yadro.com>, <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        <will@kernel.org>, <inochiama@outlook.com>, <unicorn_wang@outlook.com>,
        <wefu@redhat.com>
CC: Randolph <randolph@andestech.com>
Subject: [PATCH v8 03/10] irqchip/riscv-intc: Introduce Andes hart-level interrupt controller
Date: Mon, 29 Jan 2024 17:25:46 +0800
Message-ID: <20240129092553.2058043-4-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129092553.2058043-1-peterlin@andestech.com>
References: <20240129092553.2058043-1-peterlin@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 40T9QEcR080087

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
Reviewed-by: Randolph <randolph@andestech.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
Changes v1 -> v2:
  - New patch
Changes v2 -> v3:
  - Return -ENXIO if no valid compatible INTC found
  - Allow falling back to generic RISC-V INTC
Changes v3 -> v4: (Suggested by Thomas [1])
  - Add comment to andes irq chip function
  - Refine code flow to share with generic RISC-V INTC and ACPI
  - Move Andes specific definitions to include/linux/soc/andes/irq.h
Changes v4 -> v5: (Suggested by Thomas)
  - Fix commit message
  - Subtract ANDES_SLI_CAUSE_BASE from d->hwirq to calculate the value of mask
  - Do not set chip_data to the chip itself with irq_domain_set_info()
  - Follow reverse fir tree order variable declarations
Changes v5 -> v6:
  - To follow the naming on datasheet, rename ANDES_RV_IRQ_PMU to ANDES_RV_IRQ_PMOVI
  - Initialize the riscv_intc_* global variables for Andes INTC (Suggested by Anup)
  - Use BITS_PER_LONG to compute the bit mask of SIE/SLIE as they are 64-bit registers (32-bit for RV32)
Changes v6 -> v7:
  - No change
Changes v7 -> v8:
  - Include Reviewed-by tags from Anup

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20231019135723.3657156-1-peterlin@andestech.com/
---
 drivers/irqchip/irq-riscv-intc.c | 66 +++++++++++++++++++++++++++-----
 include/linux/soc/andes/irq.h    | 18 +++++++++
 2 files changed, 74 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/soc/andes/irq.h

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index b13a16b164c9..7064857f1f1d 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/smp.h>
+#include <linux/soc/andes/irq.h>
 
 static struct irq_domain *intc_domain;
 static unsigned int riscv_intc_nr_irqs __ro_after_init;
@@ -49,6 +50,31 @@ static void riscv_intc_irq_unmask(struct irq_data *d)
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
@@ -72,12 +98,21 @@ static struct irq_chip riscv_intc_chip = {
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
@@ -123,11 +158,12 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
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
+	struct irq_chip *chip;
 	unsigned long hartid;
+	int rc;
 
 	rc = riscv_of_parent_hartid(node, &hartid);
 	if (rc < 0) {
@@ -178,14 +215,23 @@ static int __init riscv_intc_init(struct device_node *node,
 		return 0;
 	}
 
-	riscv_intc_nr_irqs = BITS_PER_LONG;
-	riscv_intc_custom_base = riscv_intc_nr_irqs;
-	riscv_intc_custom_nr_irqs = 0;
+	if (of_device_is_compatible(node, "andestech,cpu-intc")) {
+		riscv_intc_nr_irqs = BITS_PER_LONG;
+		riscv_intc_custom_base = ANDES_SLI_CAUSE_BASE;
+		riscv_intc_custom_nr_irqs = ANDES_RV_IRQ_LAST;
+		chip = &andes_intc_chip;
+	} else {
+		riscv_intc_nr_irqs = BITS_PER_LONG;
+		riscv_intc_custom_base = riscv_intc_nr_irqs;
+		riscv_intc_custom_nr_irqs = 0;
+		chip = &riscv_intc_chip;
+	}
 
-	return riscv_intc_init_common(of_node_to_fwnode(node));
+	return riscv_intc_init_common(of_node_to_fwnode(node), chip);
 }
 
 IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
+IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_intc_init);
 
 #ifdef CONFIG_ACPI
 
@@ -212,7 +258,7 @@ static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
 		return -ENOMEM;
 	}
 
-	return riscv_intc_init_common(fn);
+	return riscv_intc_init_common(fn, &riscv_intc_chip);
 }
 
 IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
diff --git a/include/linux/soc/andes/irq.h b/include/linux/soc/andes/irq.h
new file mode 100644
index 000000000000..edc3182d6e66
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
-- 
2.34.1


