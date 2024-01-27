Return-Path: <linux-kernel+bounces-41286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE4483EE6B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6088D1C20A01
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111252F61;
	Sat, 27 Jan 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="e41GROJr"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547D48790
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372368; cv=none; b=grU732f53wqHBQprHKtPhq268A3ifID0yZuwaflwVMuKjeUAYrOTMBtlkjpZXQj2F3DFeFzF+NK7As0vi3kQ9TJFcclZVgtHf9C9IPrbD2lR+wIy7NuUn0OQxHJ9dmFz+l6rIh41zzdW6etY99uLhfpfa2pBBX4FEJB5PF63qPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372368; c=relaxed/simple;
	bh=T3dXW581jZ06BKj8dm+t015SP9YB2Ce67L9Tnar7yYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D/c2+KXamW7zfx+/QXvAaaF3Gnf0NQovsnhAYqsQ4VqxJJ8r2j1rUsg+5SkZZHKWkXp/Aab0quGLZR7Z7N7qJgl73xWTvsfTKPmkQ3XOHD9BD8l8KgL26LSvPYI+BTh9XS+P9UBoa7p48e0f68zPMpCt/IHfqbr8Yblm1Fjtiik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=e41GROJr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29080973530so1345785a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 08:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1706372366; x=1706977166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4yC/aDtV6KBGHtbSqNeK69fWufSyNkr8dJJVArWQoc=;
        b=e41GROJrZubuDqaitcptE80UwunbKIbRLvTdfNa7UfXgq+RqaDNLoI3cXRr6uLE63S
         s8pPPXSGeB8d6XkjxMgTP9U8QuZD6PCDdc4Vjs6Fndv6utQe2FTnTvuO2t51E689fx2z
         8cb3X+90XZoCVqFGMeIZREhLLDDFGZwBZknXXDcNItjDYVLC5vm6Lds1AfWt7owltC5b
         COUMkYwj9RUtNyBesU++xUHS5f/+T5fvD1GVmy7Y3hDMqmA9VhxFuonAM2sdLNu4G0PV
         70AR4stra1EFRAX+azmY0Z5QSgCKBHtmQEoPkdfYh2oVJ5Uqy5OJvq82ahTpeGYbPZAc
         1T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372366; x=1706977166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4yC/aDtV6KBGHtbSqNeK69fWufSyNkr8dJJVArWQoc=;
        b=X3Q2WIwmkcoykizMzYBXkB64d+LY92+kbPZ7F/VzNUlSLK0RiDwci6qRBnmhWTnnGr
         vcRRSZ8J1CHs4vXZwjz4c0U7hvJPlQvq6bF3qYHP0UpOkzuHZHubolQhc8h2javOAFD4
         PMk48Lx9oMFBgYxJ22tMqu9lX4GQl/vwfgah0D2uyHbNpyWn8QQ8vvq82N8V0l6pzgDj
         Ctrr9FSgawX2VAs37BV/nIjmSxdsfxEBld9Uw6xlU/x1JgdjTmYURDCbP2zMBNAoCIz1
         jbSV4hF+OxJA5pfgOW8rQNy9MS/xFACgwUarkPXHSCf28yW0pSVEjMtnyjq63zI+gh7R
         RHzg==
X-Gm-Message-State: AOJu0YzQelQ5vLMj8RlM7/mjsMck+o0Ae9YcZoOeQ0opy2atEMel7r6p
	ncjXATvyK/ILvUgamCM2LhiznO5S5urDTMl6YJVZ1UDOLtSFth21kgaexlAEOrc=
X-Google-Smtp-Source: AGHT+IEdn8vgLUGX2eDHAqn3V+MPuHc8ggNPbo8L4egywusYdrINzdqDh00M1BqTAPj6pqFfggQNNg==
X-Received: by 2002:a17:90a:8981:b0:28c:f504:12a with SMTP id v1-20020a17090a898100b0028cf504012amr1237917pjn.24.1706372366213;
        Sat, 27 Jan 2024 08:19:26 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.86.17])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090ac24b00b00290f8c708d0sm5091620pjx.57.2024.01.27.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:19:25 -0800 (PST)
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
Subject: [PATCH v12 12/25] genirq/irqdomain: Reroute device MSI create_mapping
Date: Sat, 27 Jan 2024 21:47:40 +0530
Message-Id: <20240127161753.114685-13-apatel@ventanamicro.com>
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

From: Thomas Gleixner <tglx@linutronix.de>

Reroute interrupt allocation in irq_create_fwspec_mapping() if the domain
is a MSI device domain. This is required to convert the support for wire
to MSI bridges to per device MSI domains.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 kernel/irq/irqdomain.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8fee37918195..aeb41655d6de 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -29,6 +29,7 @@ static int irq_domain_alloc_irqs_locked(struct irq_domain *domain, int irq_base,
 					unsigned int nr_irqs, int node, void *arg,
 					bool realloc, const struct irq_affinity_desc *affinity);
 static void irq_domain_check_hierarchy(struct irq_domain *domain);
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq);
 
 struct irqchip_fwid {
 	struct fwnode_handle	fwnode;
@@ -858,8 +859,13 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	}
 
 	if (irq_domain_is_hierarchy(domain)) {
-		virq = irq_domain_alloc_irqs_locked(domain, -1, 1, NUMA_NO_NODE,
-						    fwspec, false, NULL);
+		if (irq_domain_is_msi_device(domain)) {
+			mutex_unlock(&domain->root->mutex);
+			virq = msi_device_domain_alloc_wired(domain, hwirq, type);
+			mutex_lock(&domain->root->mutex);
+		} else
+			virq = irq_domain_alloc_irqs_locked(domain, -1, 1, NUMA_NO_NODE,
+							    fwspec, false, NULL);
 		if (virq <= 0) {
 			virq = 0;
 			goto out;
@@ -914,7 +920,7 @@ void irq_dispose_mapping(unsigned int virq)
 		return;
 
 	if (irq_domain_is_hierarchy(domain)) {
-		irq_domain_free_irqs(virq, 1);
+		irq_domain_free_one_irq(domain, virq);
 	} else {
 		irq_domain_disassociate(domain, virq);
 		irq_free_desc(virq);
@@ -1755,6 +1761,14 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs)
 	irq_free_descs(virq, nr_irqs);
 }
 
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq)
+{
+	if (irq_domain_is_msi_device(domain))
+		msi_device_domain_free_wired(domain, virq);
+	else
+		irq_domain_free_irqs(virq, 1);
+}
+
 /**
  * irq_domain_alloc_irqs_parent - Allocate interrupts from parent domain
  * @domain:	Domain below which interrupts must be allocated
@@ -1907,9 +1921,9 @@ static int irq_domain_alloc_irqs_locked(struct irq_domain *domain, int irq_base,
 	return -EINVAL;
 }
 
-static void irq_domain_check_hierarchy(struct irq_domain *domain)
-{
-}
+static void irq_domain_check_hierarchy(struct irq_domain *domain) { }
+static void irq_domain_free_one_irq(struct irq_domain *domain, unsigned int virq) { }
+
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
-- 
2.34.1


