Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35ECC7D759A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343899AbjJYU0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjJYU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:26:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39481721
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:25:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so121591b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265542; x=1698870342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGPt9IKGXmO6OfBeavundfuVbu/hSGKOkv1OmRAdM8o=;
        b=E7XU7fL58LCyl4k1ESC88sMVYFgaKl3d0MxfS5xtAKUBa5nUVgTFxhVwJ8S7lWgKan
         gLt+n0igYucXQjaRlBnyq8CEiFekXjWLZjMUjXKLQ/GO54sswcuhiHxKu5dmQc3znTi9
         faqCb33aR9Z6KysYnfH+x0aIKs4Yz/aNvTJ3c29WTnwu8Q9X6lJOdar16QXq1z09KZ07
         aHb5WjY3KbWfWRDlmq0+e6epbFWMz0Z2rUuQHTDhFor2zirrbqtl+RuZnwaX9RUosUYM
         OAICg27fm/k5PWJC/8O74fNp3zKpNmoZPQHEcbCZvUKbOd0Gx+R31b4oo3yIcvFF1zQX
         23qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265542; x=1698870342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGPt9IKGXmO6OfBeavundfuVbu/hSGKOkv1OmRAdM8o=;
        b=IYXHrdtmZ+33c3+SzOXBAdnE0p7Pygl+r2AIOlpgElWroLfTXsp/R1MoGOgtsnmxv3
         VjpmFklwhuJfVST5zBN287FJiBFfgDLS+IbDcakk81lNHMB2oND6DB3ZRyGX+/f0s8jy
         q8/pFhHKgefkkZPqspMfbUvH9bamrPNBQb0DMxH+H5eOB5U6O/fYCxTNBVx2dpT6oNt+
         vlChmq84xs9N3XoTh/fHVilfPel4R7hcMMTEMovh8zwRtIJPtgM/sIk4POVO3DrRgSS5
         +aSEyHCPy8GoANcJ6nhEdfKhrU6w92fUSXUs4wvNSROwu5nc54GTNzmBhdNcREvlSxcN
         2ggA==
X-Gm-Message-State: AOJu0YyRbtkjVG8SVQPSQQ/I+rRgK5+gRxUUNDMiuQFgVMg9K9dsD8Vu
        6qqIm5pu2chZe/SqYQ/8jC2hQQ==
X-Google-Smtp-Source: AGHT+IHyxEDXk7Cbo1rkfq0iJxaRlkX5x7Oxvtrq3Y+QMpN8R866Z7ErWJXgR1xSj+LP6kAjPFug7Q==
X-Received: by 2002:a05:6a00:1788:b0:68f:ecb9:5fde with SMTP id s8-20020a056a00178800b0068fecb95fdemr16406181pfg.34.1698265541960;
        Wed, 25 Oct 2023 13:25:41 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:25:41 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 16/21] irqchip: irq-sifive-plic: Add ACPI support
Date:   Thu, 26 Oct 2023 01:53:39 +0530
Message-Id: <20231025202344.581132-17-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025202344.581132-1-sunilvl@ventanamicro.com>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support in PLIC driver. In ACPI, IO devices use Global System
Interrupts (GSI) which is a flat space split across multiple PLICs. So,
the driver also need to provide the mapping from GSI to correct PLIC.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 arch/riscv/include/asm/irq.h      |   6 ++
 drivers/irqchip/irq-sifive-plic.c | 113 +++++++++++++++++++++++++-----
 2 files changed, 101 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
index 00eb8b0333c2..eff442766c87 100644
--- a/arch/riscv/include/asm/irq.h
+++ b/arch/riscv/include/asm/irq.h
@@ -28,6 +28,12 @@ struct fwnode_handle *aplic_get_gsi_domain_id(u32 gsi);
 static inline struct fwnode_handle *aplic_get_gsi_domain_id(u32 gsi) { return NULL; }
 #endif
 
+#ifdef CONFIG_SIFIVE_PLIC
+struct fwnode_handle *plic_get_gsi_domain_id(u32 gsi);
+#else
+static inline struct fwnode_handle *plic_get_gsi_domain_id(u32 gsi) { return NULL; }
+#endif
+
 int __init acpi_get_intc_index_hartid(u32 index, unsigned long *hartid);
 int acpi_get_ext_intc_parent_hartid(u8 id, u32 idx, unsigned long *hartid);
 void acpi_get_plic_nr_contexts(u8 id, int *nr_contexts);
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index c8f8a8cdcce1..9c61084a74eb 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -70,6 +71,8 @@ struct plic_priv {
 	unsigned long plic_quirks;
 	unsigned int nr_irqs;
 	unsigned long *prio_save;
+	u32 gsi_base;
+	int id;
 };
 
 struct plic_handler {
@@ -316,6 +319,10 @@ static int plic_irq_domain_translate(struct irq_domain *d,
 {
 	struct plic_priv *priv = d->host_data;
 
+	/* For DT, gsi_base is always zero. */
+	if (fwspec->param[0] >= priv->gsi_base)
+		fwspec->param[0] = fwspec->param[0] - priv->gsi_base;
+
 	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
 		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
 
@@ -417,17 +424,31 @@ static const struct of_device_id plic_match[] = {
 };
 
 static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
-					   u32 *nr_irqs, u32 *nr_contexts)
+					   u32 *nr_irqs, u32 *nr_contexts,
+					   u32 *gsi_base, u32 *id)
 {
 	struct device *dev = &pdev->dev;
+	struct acpi_madt_plic *plic;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		plic = *(struct acpi_madt_plic **)dev_get_platdata(dev);
+		if (!plic) {
+			dev_err(dev, "PLIC platform data is NULL!\n");
+			return -EINVAL;
+		}
+
+		*nr_irqs = plic->num_irqs;
+		acpi_get_plic_nr_contexts(plic->id, nr_contexts);
+		if (WARN_ON(!*nr_contexts)) {
+			dev_err(dev, "no PLIC context available\n");
+			return -EINVAL;
+		}
+
+		*gsi_base = plic->gsi_base;
+		*id = plic->id;
+		return 0;
+	}
 
 	rc = of_property_read_u32(to_of_node(dev->fwnode),
 				  "riscv,ndev", nr_irqs);
@@ -442,23 +463,28 @@ static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	*gsi_base = 0;
+	*id = 0;
+
 	return 0;
 }
 
 static int plic_parse_context_parent_hwirq(struct platform_device *pdev,
-					   u32 context, u32 *parent_hwirq,
+					   u32 context, u32 id, u32 *parent_hwirq,
 					   unsigned long *parent_hartid)
 {
 	struct device *dev = &pdev->dev;
 	struct of_phandle_args parent;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(dev->fwnode))
-		return -EINVAL;
+	if (!is_of_node(dev->fwnode)) {
+		rc = acpi_get_ext_intc_parent_hartid(id, context, parent_hartid);
+		if (rc)
+			return rc;
+
+		*parent_hwirq = RV_IRQ_EXT;
+		return 0;
+	}
 
 	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
 	if (rc)
@@ -472,6 +498,32 @@ static int plic_parse_context_parent_hwirq(struct platform_device *pdev,
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+
+LIST_HEAD(plic_list);
+struct plic_priv_list {
+	struct plic_priv *priv;
+	struct list_head list;
+};
+
+struct fwnode_handle *plic_get_gsi_domain_id(u32 gsi)
+{
+	struct plic_priv_list *plic_element;
+	struct list_head *i, *tmp;
+
+	/* Find the PLIC that manages this GSI. */
+	list_for_each_safe(i, tmp, &plic_list) {
+		plic_element = list_entry(i, struct plic_priv_list, list);
+		if (gsi >= plic_element->priv->gsi_base &&
+		    gsi <= (plic_element->priv->gsi_base + plic_element->priv->nr_irqs))
+			return plic_element->priv->dev->fwnode;
+	}
+
+	return NULL;
+}
+
+#endif
+
 static int plic_probe(struct platform_device *pdev)
 {
 	int rc, nr_contexts, nr_handlers = 0, i, cpu;
@@ -483,7 +535,9 @@ static int plic_probe(struct platform_device *pdev)
 	struct plic_priv *priv;
 	irq_hw_number_t hwirq;
 	struct resource *res;
+	int id, context_id;
 	bool cpuhp_setup;
+	u32 gsi_base;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -510,19 +564,21 @@ static int plic_probe(struct platform_device *pdev)
 		return -EIO;
 	}
 
-	rc = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	rc = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts, &gsi_base, &id);
 	if (rc) {
 		dev_err(dev, "failed to parse irqs and contexts\n");
 		return rc;
 	}
 	priv->nr_irqs = nr_irqs;
+	priv->gsi_base = gsi_base;
+	priv->id = id;
 
 	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
 		return -ENOMEM;
 
 	for (i = 0; i < nr_contexts; i++) {
-		rc = plic_parse_context_parent_hwirq(pdev, i,
+		rc = plic_parse_context_parent_hwirq(pdev, i, priv->id,
 						     &parent_hwirq, &hartid);
 		if (rc) {
 			dev_warn(dev, "hwirq for context%d not found\n", i);
@@ -574,13 +630,23 @@ static int plic_probe(struct platform_device *pdev)
 			goto done;
 		}
 
+		if (is_of_node(dev->fwnode)) {
+			context_id = i;
+		} else {
+			rc = acpi_get_plic_context(priv->id, i, &context_id);
+			if (rc) {
+				dev_warn(dev, "invalid context id for context%d\n", i);
+				continue;
+			}
+		}
+
 		cpumask_set_cpu(cpu, &priv->lmask);
 		handler->present = true;
 		handler->hart_base = priv->regs + CONTEXT_BASE +
-			i * CONTEXT_SIZE;
+			context_id * CONTEXT_SIZE;
 		raw_spin_lock_init(&handler->enable_lock);
 		handler->enable_base = priv->regs + CONTEXT_ENABLE_BASE +
-			i * CONTEXT_ENABLE_SIZE;
+			context_id * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
 		handler->enable_save =  devm_kcalloc(dev,
@@ -624,6 +690,17 @@ static int plic_probe(struct platform_device *pdev)
 		register_syscore_ops(&plic_irq_syscore_ops);
 	}
 
+#ifdef CONFIG_ACPI
+	struct plic_priv_list *plic_element;
+
+	plic_element = devm_kzalloc(dev, sizeof(*plic_element), GFP_KERNEL);
+	if (!plic_element)
+		return -ENOMEM;
+
+	plic_element->priv = priv;
+	list_add_tail(&plic_element->list, &plic_list);
+#endif
+
 	dev_info(dev, "mapped %d interrupts with %d handlers for"
 		" %d contexts.\n", nr_irqs, nr_handlers, nr_contexts);
 	return 0;
-- 
2.39.2

