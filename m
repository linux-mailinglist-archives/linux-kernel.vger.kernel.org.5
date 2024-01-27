Return-Path: <linux-kernel+bounces-41288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147F883EE6F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80CADB22896
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02AB5B206;
	Sat, 27 Jan 2024 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LWm2Q63m"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9535A7B3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372379; cv=none; b=NIVxs4WhwtsCrVrBnGRRoJsKI02Vn3/8JmHJFv7dlgua/QyjpjpGuxBoQOpNQDiwb+Qbuw8CWIe4Qs+FlHpct3TWb/zFGW/KrKIWvYjvR2cfN3xuMZg146OFjUGVA/B+TrmNY5XdJ0wqMjGtF8Bd+J1AudvezCijImtwjkGkJ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372379; c=relaxed/simple;
	bh=054Kw1zMvhuntHhVDOfQjC8pnXXrzJIcmYMyW4UTh1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OH7ywFh9KYzfi9DfbPhz6AJtpq6qa/aWf0qr3ZCUQVLQjwdUq+IZtnoQufR9eY0TZaqJM0SVGVQm0fcSwgy+u3qA97n/AqipM++o0YOp57BokmOcxpI75x2Z3LNvU37ogxt7cQ7iZjPQ/JgK/OKbrQS2GGWMSSAlf6czmez0j5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LWm2Q63m; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7232dcb3eso7445525ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372377; x=1706977177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1xL9ry/qVc8LB9ADTXQzYyB8xKqzcFMAT7WOD9fcwk=;
        b=LWm2Q63mSA5LIb+7kmFLu468UFMuuY2/p5koDcTZha1Rkza/Mg2jrmx6/9XnuAmFlA
         UvOID7MVM3VKeB9M6phuCuY8IVrUwgS/Uao0LjHbtospBpjSkXxS4qCa4JfbwVQIJ1ej
         SQ334nGy5Beqyv/VGMIumbl7WvTLYQVl3vo27BQ/jI7Glv7/MrHLMMHKfKPy/1uh6ZB5
         Ty7oni2TIlc4f3jS/Bnv/pagT0wvEXt2d9M8CUCkXRx5vRgydwgoGlsZj7ybETgpd+Gj
         jmQDTcmdpXmmMulsOvmV4BixaKLmM1djbzbnIihV4eG40w1PIQEKZ6iwXMk0xzNaJ3iD
         eixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372377; x=1706977177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1xL9ry/qVc8LB9ADTXQzYyB8xKqzcFMAT7WOD9fcwk=;
        b=oA1mX+jU5r4+4Je/Xiejt7HD/UR1ISegE52OXkZX4WjVmov+41ekovz/RG5HbAuE0H
         dIE/AUSiRpGpso8REbH0x+zn43BSdaPG+vu78iMQ/zcRPXujoBrYktRNxjAEOiQs9ica
         Z5IUK/f5tuwMAiAUJ3a4TG/dw3jsQsliAOczX1nQwIFhDO+LXtzxZCQHWCIEY+5MLx8i
         i5ntWmDFItq2PR3WOeqiANal1DTYe4iwWBZh+P5HBbgRakX88QkgTkqzgNYMWZ6pthMD
         5XX7EUxRd+cuTz6acRYxJnE6TiPjvHmonPzh3/CGcNdQzt7YJSGoEMnYrHm86yhuiTn8
         0bwA==
X-Gm-Message-State: AOJu0Yx4YUePJd1KwfTgFJhTOz/eBzBZNMMsUcUu9GUa3lo/hrLFBTDC
	pY7DHd8t+Qp6XIeuN134We9RUfML7NENTvPPcyaPIpKsU62XhUMuyc9+cfM0a78=
X-Google-Smtp-Source: AGHT+IEMWXt+Y4URhBDkND6zfNqg0/Y0a26dQg2vgJg0Z84j9HjHmkZ6K35iu16z8PJOmL/WkxhfsQ==
X-Received: by 2002:a17:902:8690:b0:1d7:c24:42f0 with SMTP id g16-20020a170902869000b001d70c2442f0mr889761plo.57.1706372377219;
        Sat, 27 Jan 2024 08:19:37 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:19:36 -0800 (PST)
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
Subject: [PATCH v12 14/25] irqchip/sifive-plic: Convert PLIC driver into a platform driver
Date: Sat, 27 Jan 2024 21:47:42 +0530
Message-Id: <20240127161753.114685-15-apatel@ventanamicro.com>
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

The PLIC driver does not require very early initialization so let
us convert it into a platform driver.

As part of the conversion, the PLIC probing undergoes the following
changes:
1. Use dev_info(), dev_err() and dev_warn() instead of pr_info(),
   pr_err() and pr_warn()
2. Use devm_xyz() APIs wherever applicable
3. PLIC is now probed after CPUs are brought-up so we have to
   setup cpuhp state after context handler of all online CPUs
   are initialized otherwise we see crash on multi-socket systems

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 239 ++++++++++++++++++------------
 1 file changed, 148 insertions(+), 91 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b7bc4fd9517..c8f8a8cdcce1 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 SiFive
  * Copyright (C) 2018 Christoph Hellwig
  */
-#define pr_fmt(fmt) "plic: " fmt
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -64,6 +63,7 @@
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
 
 struct plic_priv {
+	struct device *dev;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -85,7 +85,6 @@ struct plic_handler {
 	struct plic_priv	*priv;
 };
 static int plic_parent_irq __ro_after_init;
-static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
 static int plic_irq_set_type(struct irq_data *d, unsigned int type);
@@ -371,7 +370,8 @@ static void plic_handle_irq(struct irq_desc *desc)
 		int err = generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
 		if (unlikely(err))
-			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
+			dev_warn_ratelimited(handler->priv->dev,
+					"can't find mapping for hwirq %lu\n",
 					hwirq);
 	}
 
@@ -406,57 +406,126 @@ static int plic_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init __plic_init(struct device_node *node,
-			      struct device_node *parent,
-			      unsigned long plic_quirks)
+static const struct of_device_id plic_match[] = {
+	{ .compatible = "sifive,plic-1.0.0" },
+	{ .compatible = "riscv,plic0" },
+	{ .compatible = "andestech,nceplic100",
+	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible = "thead,c900-plic",
+	  .data = (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{}
+};
+
+static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
+					   u32 *nr_irqs, u32 *nr_contexts)
 {
-	int error = 0, nr_contexts, nr_handlers = 0, i;
-	u32 nr_irqs;
-	struct plic_priv *priv;
+	struct device *dev = &pdev->dev;
+	int rc;
+
+	/*
+	 * Currently, only OF fwnode is supported so extend this
+	 * function for ACPI support.
+	 */
+	if (!is_of_node(dev->fwnode))
+		return -EINVAL;
+
+	rc = of_property_read_u32(to_of_node(dev->fwnode),
+				  "riscv,ndev", nr_irqs);
+	if (rc) {
+		dev_err(dev, "riscv,ndev property not available\n");
+		return rc;
+	}
+
+	*nr_contexts = of_irq_count(to_of_node(dev->fwnode));
+	if (WARN_ON(!(*nr_contexts))) {
+		dev_err(dev, "no PLIC context available\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int plic_parse_context_parent_hwirq(struct platform_device *pdev,
+					   u32 context, u32 *parent_hwirq,
+					   unsigned long *parent_hartid)
+{
+	struct device *dev = &pdev->dev;
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
+	rc = of_irq_parse_one(to_of_node(dev->fwnode), context, &parent);
+	if (rc)
+		return rc;
+
+	rc = riscv_of_parent_hartid(parent.np, parent_hartid);
+	if (rc)
+		return rc;
+
+	*parent_hwirq = parent.args[0];
+	return 0;
+}
+
+static int plic_probe(struct platform_device *pdev)
+{
+	int rc, nr_contexts, nr_handlers = 0, i, cpu;
+	unsigned long plic_quirks = 0, hartid;
+	struct device *dev = &pdev->dev;
 	struct plic_handler *handler;
-	unsigned int cpu;
+	u32 nr_irqs, parent_hwirq;
+	struct irq_domain *domain;
+	struct plic_priv *priv;
+	irq_hw_number_t hwirq;
+	struct resource *res;
+	bool cpuhp_setup;
+
+	if (is_of_node(dev->fwnode)) {
+		const struct of_device_id *id;
+
+		id = of_match_node(plic_match, to_of_node(dev->fwnode));
+		if (id)
+			plic_quirks = (unsigned long)id->data;
+	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-
+	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 
-	priv->regs = of_iomap(node, 0);
-	if (WARN_ON(!priv->regs)) {
-		error = -EIO;
-		goto out_free_priv;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get MMIO resource\n");
+		return -EINVAL;
+	}
+	priv->regs = devm_ioremap(dev, res->start, resource_size(res));
+	if (!priv->regs) {
+		dev_err(dev, "failed map MMIO registers\n");
+		return -EIO;
 	}
 
-	error = -EINVAL;
-	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
-	if (WARN_ON(!nr_irqs))
-		goto out_iounmap;
-
+	rc = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	if (rc) {
+		dev_err(dev, "failed to parse irqs and contexts\n");
+		return rc;
+	}
 	priv->nr_irqs = nr_irqs;
 
-	priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
+	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
-		goto out_free_priority_reg;
-
-	nr_contexts = of_irq_count(node);
-	if (WARN_ON(!nr_contexts))
-		goto out_free_priority_reg;
-
-	error = -ENOMEM;
-	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, priv);
-	if (WARN_ON(!priv->irqdomain))
-		goto out_free_priority_reg;
+		return -ENOMEM;
 
 	for (i = 0; i < nr_contexts; i++) {
-		struct of_phandle_args parent;
-		irq_hw_number_t hwirq;
-		int cpu;
-		unsigned long hartid;
-
-		if (of_irq_parse_one(node, i, &parent)) {
-			pr_err("failed to parse parent for context %d.\n", i);
+		rc = plic_parse_context_parent_hwirq(pdev, i,
+						     &parent_hwirq, &hartid);
+		if (rc) {
+			dev_warn(dev, "hwirq for context%d not found\n", i);
 			continue;
 		}
 
@@ -464,7 +533,7 @@ static int __init __plic_init(struct device_node *node,
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
 		 */
-		if (parent.args[0] != RV_IRQ_EXT) {
+		if (parent_hwirq != RV_IRQ_EXT) {
 			/* Disable S-mode enable bits if running in M-mode. */
 			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
 				void __iomem *enable_base = priv->regs +
@@ -477,21 +546,17 @@ static int __init __plic_init(struct device_node *node,
 			continue;
 		}
 
-		error = riscv_of_parent_hartid(parent.np, &hartid);
-		if (error < 0) {
-			pr_warn("failed to parse hart ID for context %d.\n", i);
-			continue;
-		}
-
 		cpu = riscv_hartid_to_cpuid(hartid);
 		if (cpu < 0) {
-			pr_warn("Invalid cpuid for context %d\n", i);
+			dev_warn(dev, "Invalid cpuid for context %d\n", i);
 			continue;
 		}
 
 		/* Find parent domain and register chained handler */
-		if (!plic_parent_irq && irq_find_host(parent.np)) {
-			plic_parent_irq = irq_of_parse_and_map(node, i);
+		domain = irq_find_matching_fwnode(riscv_get_intc_hwnode(),
+						  DOMAIN_BUS_ANY);
+		if (!plic_parent_irq && domain) {
+			plic_parent_irq = irq_create_mapping(domain, RV_IRQ_EXT);
 			if (plic_parent_irq)
 				irq_set_chained_handler(plic_parent_irq,
 							plic_handle_irq);
@@ -504,7 +569,7 @@ static int __init __plic_init(struct device_node *node,
 		 */
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
-			pr_warn("handler already present for context %d.\n", i);
+			dev_warn(dev, "handler already present for context%d.\n", i);
 			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
@@ -518,10 +583,13 @@ static int __init __plic_init(struct device_node *node,
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
-		handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
-						sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save =  devm_kcalloc(dev,
+						DIV_ROUND_UP(nr_irqs, 32),
+						sizeof(*handler->enable_save),
+						GFP_KERNEL);
 		if (!handler->enable_save)
-			goto out_free_enable_reg;
+			return -ENOMEM;
+
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -531,52 +599,41 @@ static int __init __plic_init(struct device_node *node,
 		nr_handlers++;
 	}
 
+	priv->irqdomain = irq_domain_create_linear(dev->fwnode, nr_irqs + 1,
+						   &plic_irqdomain_ops, priv);
+	if (WARN_ON(!priv->irqdomain))
+		return -ENOMEM;
+
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
-	 * and register syscore operations only when context handler
-	 * for current/boot CPU is present.
+	 * and register syscore operations only after context handlers
+	 * of all online CPUs are initialized.
 	 */
-	handler = this_cpu_ptr(&plic_handlers);
-	if (handler->present && !plic_cpuhp_setup_done) {
+	cpuhp_setup = true;
+	for_each_online_cpu(cpu) {
+		handler = per_cpu_ptr(&plic_handlers, cpu);
+		if (!handler->present) {
+			cpuhp_setup = false;
+			break;
+		}
+	}
+	if (cpuhp_setup) {
 		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 				  "irqchip/sifive/plic:starting",
 				  plic_starting_cpu, plic_dying_cpu);
 		register_syscore_ops(&plic_irq_syscore_ops);
-		plic_cpuhp_setup_done = true;
 	}
 
-	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
-		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
+	dev_info(dev, "mapped %d interrupts with %d handlers for"
+		" %d contexts.\n", nr_irqs, nr_handlers, nr_contexts);
 	return 0;
-
-out_free_enable_reg:
-	for_each_cpu(cpu, cpu_present_mask) {
-		handler = per_cpu_ptr(&plic_handlers, cpu);
-		kfree(handler->enable_save);
-	}
-out_free_priority_reg:
-	kfree(priv->prio_save);
-out_iounmap:
-	iounmap(priv->regs);
-out_free_priv:
-	kfree(priv);
-	return error;
 }
 
-static int __init plic_init(struct device_node *node,
-			    struct device_node *parent)
-{
-	return __plic_init(node, parent, 0);
-}
-
-IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
-IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
-
-static int __init plic_edge_init(struct device_node *node,
-				 struct device_node *parent)
-{
-	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
-}
-
-IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
-IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
+static struct platform_driver plic_driver = {
+	.driver = {
+		.name		= "riscv-plic",
+		.of_match_table	= plic_match,
+	},
+	.probe = plic_probe,
+};
+builtin_platform_driver(plic_driver);
-- 
2.34.1


