Return-Path: <linux-kernel+bounces-76243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D330E85F4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895DB286FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A00738FB2;
	Thu, 22 Feb 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Iycc+lu/"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9703DBB2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594860; cv=none; b=XxGPnLkgZyIKODUu0GahtoAiRhQ7T3NdyUgODYVRnAP0R3tPn1iOrPfwbqC/z1TIjySaPX/abOtkcghvCqpwkgqJFOzA9eH+hf4fJgmPtJi3N9HADaLtWZXlr1HOJlTD1wLnk3XUTigu2W0VlMnHaWdPJpQNte/73rIMASvI4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594860; c=relaxed/simple;
	bh=5JhlBHycZ1Wh2E+iDGy85qHLESfV/FDgjX3+cjidhTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAruFTQGfgWJG48Bp7COmIhJflgggiim7PiRd1pFIV595/UeYTV5j3iOiR7UZi6svtVIqTz8EV+k4irj4aA7+OLpiUPOeeBoa0MwDhkZ9DoV4s7ydQStkbp9722bGZWuCnUFKBuQviBND1UWcVCwhLqn83Dz86XAtbJ4Lnysiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Iycc+lu/; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c03b92998eso5662851b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708594858; x=1709199658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDM6EjBjzZEX6uCYOZJ5gyfkm0OuYc/6ObrJgVAlOzc=;
        b=Iycc+lu/adIgV6JGRgylSgD8w4ZlGTxBzy9tbHifb1NXdfZtUaV7KFI3wXEq+2HxCd
         c0iuVlaZEZ3efOSumUq81VW2sJeWHa+WVdYEYz2QIXSV16+/F6nu8Kx97GDA5o9CN2pN
         Fj3GEAoypmxvY9Qzn7Qh0t6kDEVE+D98HOToaSILDKcBDiQWqoyLi1z1kKcWGIu6hR3h
         oGkwLSfAJudWbZ6Vw9pJOP2I+oXUpgAn78tbRqiItblKtYjC8gW6ny6ofaruemyV72Dk
         Hha3YV2/O7PBv6gCDSv82gNEosEbQb5XQarwVZgZ4KFNdKze6b9Lnt2GV0puba9Oj78q
         w+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594858; x=1709199658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDM6EjBjzZEX6uCYOZJ5gyfkm0OuYc/6ObrJgVAlOzc=;
        b=CR6sFh2uOyYpjYzcrV+xTLXRNOcxpclukIusn/Zce7i+1wOedIkGbZ6qcggcvdHhk2
         VxTlJF2MDoj9hSbSY853LumMN/llztU5aTSEDq2vpUElzuWASUIy/bonN7jDx9PO9oj/
         Cmia3YHA+KrPAx2A5Rt6g6Gafw3H2P7ZzTNYA79v2xQmdr0+payuNtqFWaftrX1Fr3PM
         vrau07yr+WOMq5VQIiZShotNYZ3fEAoT9ma3xRKfl58p5oM3C62X26xOZOWYOv7LAaTy
         mio7Ru5kUfYwTEtEiGZSDivdLeECiXsjzZ+v0fIol7x/jEkyb1j2RcEKwdihy202GfKV
         aUNA==
X-Forwarded-Encrypted: i=1; AJvYcCUxkeg5sEp0r1uNLmZkR1LYzI81Gu+ZIgEEFq3YVwNjoYyb/5BXkhYmTtNxJ5D/6BPfyLxqvUj3qEr+6VLjbQ19MH7RSDS3WbqtgFH3
X-Gm-Message-State: AOJu0YyYS95OEeb6ClG9Bd4t3+FMki/RuMKBEO23WAfvT/L3gTohHJhW
	OabErHENFimLbX0l6c4pFUf5lVnQObIZiUfG0Cr1OORUpK+UxxG8343szRI8d4Q=
X-Google-Smtp-Source: AGHT+IGT29HtRoxTfhVvish182aY0aMpJ/2Uit/NlU+Lw0THPvmpBIMgrKBSZWm+oKAJD2qN/cmTKA==
X-Received: by 2002:a05:6808:1291:b0:3c1:377a:4641 with SMTP id a17-20020a056808129100b003c1377a4641mr28333878oiw.24.1708594857974;
        Thu, 22 Feb 2024 01:40:57 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n15-20020a05680803af00b003c17c2b8d09sm130699oie.31.2024.02.22.01.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:40:57 -0800 (PST)
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
Subject: [PATCH v14 05/18] irqchip/sifive-plic: Cleanup PLIC contexts upon irqdomain creation failure
Date: Thu, 22 Feb 2024 15:09:53 +0530
Message-Id: <20240222094006.1030709-6-apatel@ventanamicro.com>
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

The SiFive PLIC contexts should not be left dangling if irqdomain creation
fails because plic_starting_cpu() can crash accessing unmapped registers.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 73 ++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 615498071b6e..f0df5d0cb76e 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -416,17 +416,45 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
+static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
+				     u32 *parent_hwirq, int *parent_cpu)
+{
+	struct device *dev = &pdev->dev;
+	struct of_phandle_args parent;
+	unsigned long hartid;
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
+	rc = riscv_of_parent_hartid(parent.np, &hartid);
+	if (rc)
+		return rc;
+
+	*parent_hwirq = parent.args[0];
+	*parent_cpu = riscv_hartid_to_cpuid(hartid);
+	return 0;
+}
+
 static int plic_probe(struct platform_device *pdev)
 {
-	int error = 0, nr_contexts, nr_handlers = 0, i;
+	int error = 0, nr_contexts, nr_handlers = 0, cpu, i;
 	struct device *dev = &pdev->dev;
 	unsigned long plic_quirks = 0;
 	struct plic_handler *handler;
+	u32 nr_irqs, parent_hwirq;
 	struct irq_domain *domain;
 	struct plic_priv *priv;
+	irq_hw_number_t hwirq;
 	bool cpuhp_setup;
-	unsigned int cpu;
-	u32 nr_irqs;
 
 	if (is_of_node(dev->fwnode)) {
 		const struct of_device_id *id;
@@ -462,13 +490,9 @@ static int plic_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	for (i = 0; i < nr_contexts; i++) {
-		struct of_phandle_args parent;
-		irq_hw_number_t hwirq;
-		int cpu;
-		unsigned long hartid;
-
-		if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)) {
-			dev_err(dev, "failed to parse parent for context %d.\n", i);
+		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
+		if (error) {
+			dev_warn(dev, "hwirq for context%d not found\n", i);
 			continue;
 		}
 
@@ -476,7 +500,7 @@ static int plic_probe(struct platform_device *pdev)
 		 * Skip contexts other than external interrupts for our
 		 * privilege level.
 		 */
-		if (parent.args[0] != RV_IRQ_EXT) {
+		if (parent_hwirq != RV_IRQ_EXT) {
 			/* Disable S-mode enable bits if running in M-mode. */
 			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
 				void __iomem *enable_base = priv->regs +
@@ -489,13 +513,6 @@ static int plic_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		error = riscv_of_parent_hartid(parent.np, &hartid);
-		if (error < 0) {
-			dev_warn(dev, "failed to parse hart ID for context %d.\n", i);
-			continue;
-		}
-
-		cpu = riscv_hartid_to_cpuid(hartid);
 		if (cpu < 0) {
 			dev_warn(dev, "Invalid cpuid for context %d\n", i);
 			continue;
@@ -534,7 +551,7 @@ static int plic_probe(struct platform_device *pdev)
 		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
 						    sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
-			return -ENOMEM;
+			goto fail_cleanup_contexts;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -547,7 +564,7 @@ static int plic_probe(struct platform_device *pdev)
 	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
 						&plic_irqdomain_ops, priv);
 	if (WARN_ON(!priv->irqdomain))
-		return -ENOMEM;
+		goto fail_cleanup_contexts;
 
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
@@ -575,6 +592,22 @@ static int plic_probe(struct platform_device *pdev)
 	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
 		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
+
+fail_cleanup_contexts:
+	for (i = 0; i < nr_contexts; i++) {
+		if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu))
+			continue;
+		if (parent_hwirq != RV_IRQ_EXT || cpu < 0)
+			continue;
+
+		handler = per_cpu_ptr(&plic_handlers, cpu);
+		handler->present = false;
+		handler->hart_base = NULL;
+		handler->enable_base = NULL;
+		handler->enable_save = NULL;
+		handler->priv = NULL;
+	}
+	return -ENOMEM;
 }
 
 static struct platform_driver plic_driver = {
-- 
2.34.1


