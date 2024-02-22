Return-Path: <linux-kernel+bounces-76238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7193485F4A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9EE5B24F59
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D913538DF9;
	Thu, 22 Feb 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Gu05hNNv"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C538DF7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594830; cv=none; b=NWywveYxvzueb4/oGnCNIwznxUKlEc/56JCTa3b92akfs3Cb4JsqryAXwZ19lZGFF/qjsp3E/GPch6V7g8KLOB6ocdFBT1ZgSKfhgUzHUlhHG+N9nlizqq/c08mWDYdL4SFQE4Xetej2Ce3AlAGeazDZI8XqXUK2F/JO4aXYJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594830; c=relaxed/simple;
	bh=FhbX0iKbLIW9zcepQYg95qq1xg1IXzBgvsoL/T/yoJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=odcfR4sKbQ9hEKIPND2iPKw9A8hVZJYR97SLPT7L66+PNZyRFo2WoVIyt/0mJwOBgPqZLtDDYnocZ/RQOxcxUwaySRzHx3z1emFh4NQ9pRaD8xX684YP5G5B8kYsLjhnJq7onN4HfaSB5XEYLiFzeSc6xWlQ7sG98npSj2A/bLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Gu05hNNv; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c167d33fcbso715838b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708594827; x=1709199627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dj3oCufc6Z60lUZder73d11F5tDZT/lvQFSoe6lWEM=;
        b=Gu05hNNvpZHQlAxpjczdnBGOwwG5rhgAZ6iDcINaAHam+WaNvrTInHSA4D54gzbZGs
         zxUAFVk4cX7rfAzpYhhTOzFlRuQJm2huaUyEK+YLBLOhFIP9SIidv93X5ys+hwSLKgX9
         0PONENjZG3Bf/4WAhrSqgVitn2GmOjOkgJyE4kPFZfoZ4wwn69SJ2Ohzq4Rszs0xmThs
         liHECw6VYjaN+k3yxZBTXXk7JYsTL4uoGA0Ys5EuUS4Qy/yFNQsjTK/aL8PyZ5IIf9ah
         sUgHknbVOAfKWs4lVzqoXX1sjP26sP0oZuVqgnbTUFrKP8k2Q6r0Ig99n1v28uNry1/9
         YXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594827; x=1709199627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dj3oCufc6Z60lUZder73d11F5tDZT/lvQFSoe6lWEM=;
        b=nasd4BCs9aRhYG5cyWSMzwnmRK+/1FjtxSbsU9ngLypg71T/X5UzARcntipbdGSpGX
         kO/xjH4Gue8z5lP5bmzruJUpWrnW+vvf3O+fVEPfJzGizpEwWSpg20fKgVKm7YNa8MwB
         Wan3mmuf2PhKFg6K1gF3XFT/j7DuHL0zvzzx/deO40SPn0DPo0VBq0wbazk+GTJU+I7x
         gGXSS9x4o0hleMqYUAaJKpjnrSf1y2soExzC0tWBmire4Sma6/kIbc1soYwM9YUB5379
         LAN1C29ToAzWHriOKYVVdvs7DipVtoaZy0QhDac9K82YNr/hPkpFJ2oSKGV4mPX2nQZ4
         QSRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvzgRb/iCq+aHLNr1Mlh2MqpW/TNy0EY+eYSnibrSWEByEYi+EuPg2TG8jDYjPQta3hwUgUGxhxvyMit0iKP9Vz272srSZR9K7WkU7
X-Gm-Message-State: AOJu0Yx4x8gQOmpYxlRIwUVFDp7TpS9wdy0JExFDmYFNZXsObenTJC7W
	QfdFAhmlf5WcBfoRV8iJUol78g9yYQS35Uz6cofPy9I8bUYrsa1dEpAWJHIQcw0=
X-Google-Smtp-Source: AGHT+IEMC2Gw2U+K/I31BOQ/0tYUUFoyA89BnpD5eMsdYUC2+krc9XmYMDpjTMmB/wdmAL6h17iVfw==
X-Received: by 2002:a54:4898:0:b0:3be:d897:2880 with SMTP id r24-20020a544898000000b003bed8972880mr19161618oic.52.1708594827392;
        Thu, 22 Feb 2024 01:40:27 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n15-20020a05680803af00b003c17c2b8d09sm130699oie.31.2024.02.22.01.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:40:27 -0800 (PST)
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
Subject: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a platform driver
Date: Thu, 22 Feb 2024 15:09:49 +0530
Message-Id: <20240222094006.1030709-2-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222094006.1030709-1-apatel@ventanamicro.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PLIC driver does not require very early initialization so convert
it into a platform driver.

After conversion, the PLIC driver is probed after CPUs are brought-up
so setup cpuhp state after context handler of all online CPUs are
initialized otherwise PLIC driver crashes for platforms with multiple
PLIC instances.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 101 ++++++++++++++++++------------
 1 file changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 5b7bc4fd9517..7400a07fc479 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -64,6 +64,7 @@
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
 
 struct plic_priv {
+	struct device *dev;
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
@@ -406,30 +407,50 @@ static int plic_starting_cpu(unsigned int cpu)
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
+static int plic_probe(struct platform_device *pdev)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
-	u32 nr_irqs;
-	struct plic_priv *priv;
+	struct device *dev = &pdev->dev;
+	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
+	struct plic_priv *priv;
+	bool cpuhp_setup;
 	unsigned int cpu;
+	u32 nr_irqs;
+
+	if (is_of_node(dev->fwnode)) {
+		const struct of_device_id *id;
+
+		id = of_match_node(plic_match, to_of_node(dev->fwnode));
+		if (id)
+			plic_quirks = (unsigned long)id->data;
+	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 
-	priv->regs = of_iomap(node, 0);
+	priv->regs = of_iomap(to_of_node(dev->fwnode), 0);
 	if (WARN_ON(!priv->regs)) {
 		error = -EIO;
 		goto out_free_priv;
 	}
 
 	error = -EINVAL;
-	of_property_read_u32(node, "riscv,ndev", &nr_irqs);
+	of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_irqs);
 	if (WARN_ON(!nr_irqs))
 		goto out_iounmap;
 
@@ -439,13 +460,13 @@ static int __init __plic_init(struct device_node *node,
 	if (!priv->prio_save)
 		goto out_free_priority_reg;
 
-	nr_contexts = of_irq_count(node);
+	nr_contexts = of_irq_count(to_of_node(dev->fwnode));
 	if (WARN_ON(!nr_contexts))
 		goto out_free_priority_reg;
 
 	error = -ENOMEM;
-	priv->irqdomain = irq_domain_add_linear(node, nr_irqs + 1,
-			&plic_irqdomain_ops, priv);
+	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
+						&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
 		goto out_free_priority_reg;
 
@@ -455,7 +476,7 @@ static int __init __plic_init(struct device_node *node,
 		int cpu;
 		unsigned long hartid;
 
-		if (of_irq_parse_one(node, i, &parent)) {
+		if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)) {
 			pr_err("failed to parse parent for context %d.\n", i);
 			continue;
 		}
@@ -491,7 +512,7 @@ static int __init __plic_init(struct device_node *node,
 
 		/* Find parent domain and register chained handler */
 		if (!plic_parent_irq && irq_find_host(parent.np)) {
-			plic_parent_irq = irq_of_parse_and_map(node, i);
+			plic_parent_irq = irq_of_parse_and_map(to_of_node(dev->fwnode), i);
 			if (plic_parent_irq)
 				irq_set_chained_handler(plic_parent_irq,
 							plic_handle_irq);
@@ -533,20 +554,29 @@ static int __init __plic_init(struct device_node *node,
 
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
-	 * and register syscore operations only when context handler
-	 * for current/boot CPU is present.
+	 * and register syscore operations only once after context
+	 * handlers of all online CPUs are initialized.
 	 */
-	handler = this_cpu_ptr(&plic_handlers);
-	if (handler->present && !plic_cpuhp_setup_done) {
-		cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
-				  "irqchip/sifive/plic:starting",
-				  plic_starting_cpu, plic_dying_cpu);
-		register_syscore_ops(&plic_irq_syscore_ops);
-		plic_cpuhp_setup_done = true;
+	if (!plic_cpuhp_setup_done) {
+		cpuhp_setup = true;
+		for_each_online_cpu(cpu) {
+			handler = per_cpu_ptr(&plic_handlers, cpu);
+			if (!handler->present) {
+				cpuhp_setup = false;
+				break;
+			}
+		}
+		if (cpuhp_setup) {
+			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+					  "irqchip/sifive/plic:starting",
+					  plic_starting_cpu, plic_dying_cpu);
+			register_syscore_ops(&plic_irq_syscore_ops);
+			plic_cpuhp_setup_done = true;
+		}
 	}
 
-	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
-		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
+	pr_info("%pOFP: mapped %d interrupts with %d handlers for %d contexts.\n",
+		to_of_node(dev->fwnode), nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 out_free_enable_reg:
@@ -563,20 +593,11 @@ static int __init __plic_init(struct device_node *node,
 	return error;
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


