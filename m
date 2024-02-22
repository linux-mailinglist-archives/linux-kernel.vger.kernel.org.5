Return-Path: <linux-kernel+bounces-76239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C1285F4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBDD3B26257
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9392E39864;
	Thu, 22 Feb 2024 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="SQPm5iZ+"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AFC39860
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594837; cv=none; b=MWD/KUVY011iVWnlA4GyC04QnfLJpLaMnEwAHVtjgcoAYZIqFCP1nFISJ1tnumQpWopnm3E95RFAFoktif+bVehr6MivxgEhvKLpRcjS5XSbz/X6ubLuRbbsUatVrYCp9eY8ZhB7yCUXm3H4dHdQb5rL/i0FMJp07LS8bkfwtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594837; c=relaxed/simple;
	bh=Q5hNK1uL67fWib7sBAnyczFj2k0R6t70W8bp0y8JGhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5sy8PQaeaekJMQXZpYG+pwWRkzUTRuWyh4VMQh7G1dUrzA+Xbid+T0PBjD+hlhEajnKZ1zrBGwUXU9wjTnQsM/sRBGKDXGGCqYrWGYzA29QllxzF2sRl7Qkgt2K+LwulAnRtijj/J8VIyMO45vYDTjO6SEDKYyvGxt0qGIa36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=SQPm5iZ+; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c0467b94c6so4763341b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708594835; x=1709199635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6AtwHVNk/A02rm2BNjvTDG/J53NTzs7XDtfqSpV9KE=;
        b=SQPm5iZ+mCojTRWK5QqyTRPhZuFVC9hSY/qzbj6+MvbIN5sj3eYjr1SYglVVjZHvbG
         ApAkv8LU6BN3iNou37OeMlG9KWLb156EBQN0RtAnTKi5r0uLAneF7pDkwyXRHgBgbKZq
         jVps8zIRCipo3oiyX9hYPH+vhg0OiXLTHUHEXvzg3k4kYR2kNyJw6QbnLSOD3ibenu/h
         dghsU04iYWj1j/tvB4IyN67kbUwj2Bha0eaK7Uz+bsT2QJUY0KCb2eYxpLRtatGN8HL2
         s7GMmvEh73DGCR+ivI9fVEqRhu30b07BJz7mWsDuMyl3tpTo+5RGtb0gAtX49xy5j4ZT
         3fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594835; x=1709199635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6AtwHVNk/A02rm2BNjvTDG/J53NTzs7XDtfqSpV9KE=;
        b=jHUgbuX4EALYtFTAqAWjiM5VgMfFVvla+nlzq1JkK2PYoDUHZDsz83DYNuzWCGkzgj
         pvlS0k9/fcRDm+5QQsoBD5eUay39387cfAIalV4Rm2w2fX79IfxTZra3E3+cQ+x9PieD
         kWx5LtSr2UgcLVQ6kBmeUhOi/ryIx4SkVwevxoxbLGmiNNPfgQwYrgdtMuJ/SRNlq3W0
         ESmvUAkf6KuHlNdEWG3pWy4n1z5Q2hciaNCb8InROH+5YxnN6jmnm5/OauyFOs5AhIiX
         uWVCjvdKUEsoKEkkuQ3BC3IlfnEEOoXx7UhAJlxGijF4hsqbbvU8z84pvVrD+fgPvL5k
         bhEA==
X-Forwarded-Encrypted: i=1; AJvYcCXXEPV8MQ4lsuUDsqIvq8U+06VcjxI4atdS+XX5dml3zHMPtKn+JXg0puqyOxqB9/KeQLP4I+9tNfHH69Hyk5ITsAy6udHcGozOM5Qa
X-Gm-Message-State: AOJu0YxmeJ98RJjXGbA+MEjFpb8EOwumHZvyhLpaMlXoO8QDbbiC9g/u
	cWqqdUWFYgC2PtbOcGY3UXiuNPRenwH1hBaKhfGcqtv20HNgud0wDUDtbZwktAw=
X-Google-Smtp-Source: AGHT+IF8OgbTXViwpivkEQdHOkIi0+Npt3Tll1vfHu4pj3kF2ykzuXdajZKv4KF3NLZSSnHpD8JjgA==
X-Received: by 2002:a05:6808:169f:b0:3c1:33a1:5ab4 with SMTP id bb31-20020a056808169f00b003c133a15ab4mr25347876oib.23.1708594835238;
        Thu, 22 Feb 2024 01:40:35 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n15-20020a05680803af00b003c17c2b8d09sm130699oie.31.2024.02.22.01.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:40:34 -0800 (PST)
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
Subject: [PATCH v14 02/18] irqchip/sifive-plic: Use dev_xyz() in-place of pr_xyz()
Date: Thu, 22 Feb 2024 15:09:50 +0530
Message-Id: <20240222094006.1030709-3-apatel@ventanamicro.com>
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

Use dev_info(), dev_warn(), and dev_err() in-place of pr_info(),
pr_warn(), and pr_err().

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 drivers/irqchip/irq-sifive-plic.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 7400a07fc479..3d7a61c35572 100644
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
@@ -372,8 +371,8 @@ static void plic_handle_irq(struct irq_desc *desc)
 		int err = generic_handle_domain_irq(handler->priv->irqdomain,
 						    hwirq);
 		if (unlikely(err))
-			pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
-					hwirq);
+			dev_warn_ratelimited(handler->priv->dev,
+					     "can't find mapping for hwirq %lu\n", hwirq);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -401,7 +400,7 @@ static int plic_starting_cpu(unsigned int cpu)
 		enable_percpu_irq(plic_parent_irq,
 				  irq_get_trigger_type(plic_parent_irq));
 	else
-		pr_warn("cpu%d: parent irq not available\n", cpu);
+		dev_warn(handler->priv->dev, "cpu%d: parent irq not available\n", cpu);
 	plic_set_threshold(handler, PLIC_ENABLE_THRESHOLD);
 
 	return 0;
@@ -477,7 +476,7 @@ static int plic_probe(struct platform_device *pdev)
 		unsigned long hartid;
 
 		if (of_irq_parse_one(to_of_node(dev->fwnode), i, &parent)) {
-			pr_err("failed to parse parent for context %d.\n", i);
+			dev_err(dev, "failed to parse parent for context %d.\n", i);
 			continue;
 		}
 
@@ -500,13 +499,13 @@ static int plic_probe(struct platform_device *pdev)
 
 		error = riscv_of_parent_hartid(parent.np, &hartid);
 		if (error < 0) {
-			pr_warn("failed to parse hart ID for context %d.\n", i);
+			dev_warn(dev, "failed to parse hart ID for context %d.\n", i);
 			continue;
 		}
 
 		cpu = riscv_hartid_to_cpuid(hartid);
 		if (cpu < 0) {
-			pr_warn("Invalid cpuid for context %d\n", i);
+			dev_warn(dev, "Invalid cpuid for context %d\n", i);
 			continue;
 		}
 
@@ -525,7 +524,7 @@ static int plic_probe(struct platform_device *pdev)
 		 */
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		if (handler->present) {
-			pr_warn("handler already present for context %d.\n", i);
+			dev_warn(dev, "handler already present for context %d.\n", i);
 			plic_set_threshold(handler, PLIC_DISABLE_THRESHOLD);
 			goto done;
 		}
@@ -575,8 +574,8 @@ static int plic_probe(struct platform_device *pdev)
 		}
 	}
 
-	pr_info("%pOFP: mapped %d interrupts with %d handlers for %d contexts.\n",
-		to_of_node(dev->fwnode), nr_irqs, nr_handlers, nr_contexts);
+	dev_info(dev, "mapped %d interrupts with %d handlers for %d contexts.\n",
+		 nr_irqs, nr_handlers, nr_contexts);
 	return 0;
 
 out_free_enable_reg:
-- 
2.34.1


