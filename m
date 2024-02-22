Return-Path: <linux-kernel+bounces-76245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8629685F4B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C8D1F21C30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E364F39AC5;
	Thu, 22 Feb 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="cgft7wIj"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381753F9CB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594868; cv=none; b=s4/tOpE8rJ+IsdGbYEINqAyAj6qfAvRiKe16z50j9pCnXJi+kCSQfjxkA0KMioRQZTK1BvgLOYsPWiwLdgZPcGkah0zLGDrJPVZUH4d7UHSJ5zKoT/9HvOPn3cuYRRIto4spMSroJuEzzu/LVJGIxTk+uCJqLfT/ko1F3WdTV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594868; c=relaxed/simple;
	bh=26jNMYp4k2F0BbsKmf5GqSIBzRR7vUDBRp6fHWtZoro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6I7KX5j9sQ4cpLEOA2VFnBHgCVE7uUqezLvqoO5o1RIU4fmLLUkrk5v8ID49fL8tz+T/0ylaNVouHELM00SqK2f9Y5hVpVx4wEfjVGjLdxGYc03k/MKnG6wSrRJtIHRTSUQkhYxwNQe7wHFtow2oQ/4pQQcjqOfka8RHw17wu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=cgft7wIj; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c02adddb8eso1232314b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708594865; x=1709199665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67myGQfWdG/NTMsWtbLvxenqOsS6MBirvNDOIPSERro=;
        b=cgft7wIj1FXUmOfPDLUkYSg3fYZIGA2Vt89OAnZeNie+KwRKZJtaB/1y3ezmTDmkOp
         ib9GEo1O26C8eMj8q0oGvFDEebpMCycKHXTz4Q1173uuA3mV78wDJLRAUl6VQ8dY3Bwe
         nO4gF1h9GfS0pqfFvn2R0d7JwM0y1f/kT57XJ7EV+CzZKPu4hhJomnXOUu2COZ0N2UPG
         KNF63V4LVp+qcKG2uPub3p8pN1p5Ar4y4AXJoN5scH+MvgHWLrmwPd+Dm3L4bhOhzT4B
         p4I42HEiHHMqyf1U+GRTrYIE3hDyzn+D6bRt7r3C1sizBbTymb9bbwEBnpvNCI52zDca
         mP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594865; x=1709199665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67myGQfWdG/NTMsWtbLvxenqOsS6MBirvNDOIPSERro=;
        b=lm5jlr3JivxwZ4BMK4ELVApBkKkberW22sJQLeJ/DfpzZJi2P0gwoqJgWLFQgklp7q
         X09/jX3mFiJMN0eNKdqY/po9kKbfq+wQFyznoPJd0YYxLVEwFqToT1ovjStexjnRGvvR
         Kyz46U4WvaNJzU2C12X3LOtB29AapgeK8yb7Lpi6WbF7SrSr8aY1Pg1x7EVi54JeCKJP
         kJ8c6N7UKOnoTwEsOj62tdTqxSRAJOZZYd6ur0WBqF140+SV6FHIlJSqdgLl8fqf7Ok4
         hTI+yij2Dzy666Bx3tZlz6ysXX/6nS2Q9+alAB6tyRpZel4LjKexizVhXf5DdSUv71JA
         ZKSg==
X-Forwarded-Encrypted: i=1; AJvYcCURI9eta4W9wSWn1t8dFI6jDM7sg3NmEn83+7jo6Kbp/3a4C1XytaaTUJwQp6rsd/XenpslozmPFqFsQZP2eg5RboI0TVi9YZto7bCZ
X-Gm-Message-State: AOJu0YycEQsxlbfAz6C/tGcOjGp98zIdJIjxfp8/LvsD+mwiQ2VLYKtj
	mEb+N4Z7sR/fVjks5sGbBTKGJ/EJvfKwS0Q9s1V3Kck0DLbX8Sy7069/hnO0lgo=
X-Google-Smtp-Source: AGHT+IEWljpjWcYNh6FWyteZzNizntERHCcdcGk1xA11bQ1Y2eMKvSMWtR4dupwFnRtiGSJXRVaPQw==
X-Received: by 2002:a05:6808:200a:b0:3c1:54c9:be7b with SMTP id q10-20020a056808200a00b003c154c9be7bmr14031502oiw.12.1708594865151;
        Thu, 22 Feb 2024 01:41:05 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n15-20020a05680803af00b003c17c2b8d09sm130699oie.31.2024.02.22.01.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:41:04 -0800 (PST)
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
Subject: [PATCH v14 06/18] irqchip/sifive-plic: Parse number of irqs and contexts early in plic_probe
Date: Thu, 22 Feb 2024 15:09:54 +0530
Message-Id: <20240222094006.1030709-7-apatel@ventanamicro.com>
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

The SiFive PLIC driver needs to know the number of irqs and contexts
to complete initialization. Parse these details early in plic_probe()
to avoid unnecessary memory allocations and register mappings if these
details are not available.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 43 ++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index f0df5d0cb76e..e6d23fde51ed 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -416,6 +416,34 @@ static const struct of_device_id plic_match[] = {
 	{}
 };
 
+static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
+					   u32 *nr_irqs, u32 *nr_contexts)
+{
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
+	rc = of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", nr_irqs);
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
 static int plic_parse_context_parent(struct platform_device *pdev, u32 context,
 				     u32 *parent_hwirq, int *parent_cpu)
 {
@@ -464,31 +492,26 @@ static int plic_probe(struct platform_device *pdev)
 			plic_quirks = (unsigned long)id->data;
 	}
 
+	error = plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_contexts);
+	if (error)
+		return error;
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
+	priv->nr_irqs = nr_irqs;
 
 	priv->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (WARN_ON(!priv->regs))
 		return -EIO;
 
-	of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_irqs);
-	if (WARN_ON(!nr_irqs))
-		return -EINVAL;
-
-	priv->nr_irqs = nr_irqs;
-
 	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
 		return -ENOMEM;
 
-	nr_contexts = of_irq_count(to_of_node(dev->fwnode));
-	if (WARN_ON(!nr_contexts))
-		return -EINVAL;
-
 	for (i = 0; i < nr_contexts; i++) {
 		error = plic_parse_context_parent(pdev, i, &parent_hwirq, &cpu);
 		if (error) {
-- 
2.34.1


