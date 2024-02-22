Return-Path: <linux-kernel+bounces-76240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B744C85F4A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFD61C243BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1473986D;
	Thu, 22 Feb 2024 09:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OQ/Hvd7l"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781CB38380
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594844; cv=none; b=aYiJbT9VkqFDeFrCw1asjf5S3xpn67dAxmH1s1P+vXwNyxmyUVq/DliR2qtXJf/rqimSoeghg8bNb4CMSjKncJP4VbYUXWXxpHf5FqfrhPAxwYw/gbmyS7MmROELVQ2iKn8v8swmm40cIVzl/sLy6jgCz1LoO3sNEWT+9TKkQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594844; c=relaxed/simple;
	bh=FXoCaba3gtvEALwRNM4h4nFnfI8O68CksmTNcI5rPr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrEoDzCNzWQJm8NrItdnbz37WONefWhQfPNnvaA5ev8q+b1slIIADrQ9ZUpT0mNNeXnWNrd2mgZxchK7ublakaMP/l5Kwh0StOSdPRcLOb2UbOJRgOkgj1r5ZQA4+uffPoAQab+6F+0wXSRXFLQbk4aOmt8XWWhpIkPDmIWdMgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OQ/Hvd7l; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a0269b0537so205713eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708594842; x=1709199642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mzp7gOUhADSPQHe9BbGbbZnz24qrFAsUkCIt0RA8CU=;
        b=OQ/Hvd7ljcbfo4JzytYMqCSjMifsUiCanXJBxAx3RUvHCW6m9Cb21beTQmWbiRQCnw
         PlbiMM3YsHW3d45h/huZ756KuTiZwtH3YMpMDINdqoIXnb+BPeXALCIUuZr75g/4fLT6
         bDlj4J1KDL1HFN5mgrYBJ7xXT9abGjj/yZgDcZIw7eSjtGi21TsYwxKTziLWpuru/FMI
         aXf5OQBoJTixritfqIVrQlzIaciWwj/MU5iLtokgtWzE0aoUeAOH1qR6pkzDZV232Fan
         ln8NzU7IGl5rUnLx6EeIUPm5+kE4RQn2xKZRQe/EkjeEEl/StW8TzExBsEVrY9wv722H
         8JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594842; x=1709199642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Mzp7gOUhADSPQHe9BbGbbZnz24qrFAsUkCIt0RA8CU=;
        b=dTgXqRkApXfpnKByWT2AJxLYvZ0D20zfENLOT6W0ivCsGtKpKbScs6N6ClquT6lJTz
         D+lRcXnuXr+OMXN62O4Dk7fihZ09OBNvS3yKrvs7wYbEw3QiNd8EMFxivti84NM7HDXn
         8yBCd/QMxkfETJGU2H3cykrkM17UrAJGxUZEcRyG9MKRjGApLWsMsZjbNkIcFXVjALaV
         bFpz0zjetjb5IE+A6nj7H+VB8w/yJGdrqfP5LY0dnJ0SToiy1mrrj8LgjcDKlf786oEs
         bq8QlQ7C5jSzi8sVj7YPm4wV2rrtSaER+e4PMyJL1cLWq5xZU1EWifGMzun68/c1/dkT
         EQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsEYGYWhd0M+sim90R8Yv35YQgCsnW5nn+vMImhBszU2zrah0yy9kj2VRyyZTXtTFa07xi10ohjMpokbRCZvFJqQi+V5J2s9mKjPHU
X-Gm-Message-State: AOJu0YyzBxwpsP5nqVwsOvsj7uSweyRNShwrKARkwpfinG1ofrIk6z1c
	Uq9kJiPl6fKEO42xUNDA+NrUYcc599IDv7kU7ZI64qbeEthu3c+GGAwHoL10pJ0P9dmceK4S9Ux
	cafc=
X-Google-Smtp-Source: AGHT+IFzj7gpBHsAbfHA1HB2Ahj3EaOotj58ypEPbvRRGrv+4AcOMimIZzwgpDeKvAl20quCShvtNQ==
X-Received: by 2002:a05:6871:4e43:b0:21e:9dbd:ce3b with SMTP id uj3-20020a0568714e4300b0021e9dbdce3bmr938781oab.6.1708594842413;
        Thu, 22 Feb 2024 01:40:42 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n15-20020a05680803af00b003c17c2b8d09sm130699oie.31.2024.02.22.01.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:40:42 -0800 (PST)
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
Subject: [PATCH v14 03/18] irqchip/sifive-plic: Use devm_xyz() for managed allocation
Date: Thu, 22 Feb 2024 15:09:51 +0530
Message-Id: <20240222094006.1030709-4-apatel@ventanamicro.com>
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

Use devm_xyz() for allocations and mappings managed by the
Linux device driver framework.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 49 ++++++++++---------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 3d7a61c35572..558ae63795d9 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -435,39 +435,30 @@ static int plic_probe(struct platform_device *pdev)
 			plic_quirks = (unsigned long)id->data;
 	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
 	priv->plic_quirks = plic_quirks;
 
-	priv->regs = of_iomap(to_of_node(dev->fwnode), 0);
-	if (WARN_ON(!priv->regs)) {
-		error = -EIO;
-		goto out_free_priv;
-	}
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (WARN_ON(!priv->regs))
+		return -EIO;
 
-	error = -EINVAL;
 	of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev", &nr_irqs);
 	if (WARN_ON(!nr_irqs))
-		goto out_iounmap;
+		return -EINVAL;
 
 	priv->nr_irqs = nr_irqs;
 
-	priv->prio_save = bitmap_alloc(nr_irqs, GFP_KERNEL);
+	priv->prio_save = devm_bitmap_zalloc(dev, nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
-		goto out_free_priority_reg;
+		return -ENOMEM;
 
 	nr_contexts = of_irq_count(to_of_node(dev->fwnode));
 	if (WARN_ON(!nr_contexts))
-		goto out_free_priority_reg;
-
-	error = -ENOMEM;
-	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
-						&plic_irqdomain_ops, priv);
-	if (WARN_ON(!priv->irqdomain))
-		goto out_free_priority_reg;
+		return -EINVAL;
 
 	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
@@ -538,10 +529,10 @@ static int plic_probe(struct platform_device *pdev)
 			i * CONTEXT_ENABLE_SIZE;
 		handler->priv = priv;
 
-		handler->enable_save =  kcalloc(DIV_ROUND_UP(nr_irqs, 32),
-						sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save = devm_kcalloc(dev, DIV_ROUND_UP(nr_irqs, 32),
+						    sizeof(*handler->enable_save), GFP_KERNEL);
 		if (!handler->enable_save)
-			goto out_free_enable_reg;
+			return -ENOMEM;
 done:
 		for (hwirq = 1; hwirq <= nr_irqs; hwirq++) {
 			plic_toggle(handler, hwirq, 0);
@@ -551,6 +542,11 @@ static int plic_probe(struct platform_device *pdev)
 		nr_handlers++;
 	}
 
+	priv->irqdomain = irq_domain_add_linear(to_of_node(dev->fwnode), nr_irqs + 1,
+						&plic_irqdomain_ops, priv);
+	if (WARN_ON(!priv->irqdomain))
+		return -ENOMEM;
+
 	/*
 	 * We can have multiple PLIC instances so setup cpuhp state
 	 * and register syscore operations only once after context
@@ -577,19 +573,6 @@ static int plic_probe(struct platform_device *pdev)
 	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
 		 nr_irqs, nr_handlers, nr_contexts);
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
 
 static struct platform_driver plic_driver = {
-- 
2.34.1


