Return-Path: <linux-kernel+bounces-40102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5840B83DA58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB411F25E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF271B7F7;
	Fri, 26 Jan 2024 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I8tRvKpc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yMoVsEeE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E11B7E1;
	Fri, 26 Jan 2024 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273621; cv=none; b=UY9sdOScZ3fsAmjcFVxZ62qpNdEcpe2eVIKM3a7M1TBJGL7JDesLlEKcCxdVuYofvcVATxQTmBb5MU3M/dlB7+zfbsQc1m4W9hIUE+1Duk45Otwn9qLGAPhoTzB9TdBqWnzGKH8+LnrsGNRKqBa6Qmu/tV6iha49h6T2I3OWU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273621; c=relaxed/simple;
	bh=iWrPdyaty4Qhj3iNIhG/aBV7WxECmUEMFOQ4WgUrXkI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WH1UNf6KTNXSz4Z2Mc9A3/PKMH8MCT1+tXdi8sqL5mje9v8jCH/cd4GJgf4CNbyPD0xA62JIXL5z9oU8sjvArg7+KLQA62vTG/d2ZS/+rB3Ez5wXRKzjG40GfbSt7bOdhQlXkxzxfkLkqYg5iQzp2HrlqmjU0crohw27lAYzlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I8tRvKpc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yMoVsEeE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jan 2024 12:53:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706273617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imNQGpxCfZzxXKHa8c0ZjGv5PSBz4kBsS94bs6102ZY=;
	b=I8tRvKpcA/HG6rl48lTS2e0LIlTiJRRaV6+t0T723nkyrC93YQJRd5tI8R/5B3ibGKHctB
	xobxpkHaM5pQrHrDTAylIuoefhR7tAk74J+Yd42BT3lXGa5nECfMwDVHt3yPCQZqfhKqte
	pCaTLE0tvgbcvPmT8FKpgm3+j6ztf41ukPd7mQtr6/5aUulNYIy5SiMiZ4ts7iB/ktExuv
	0RA8umgOPWUtPRaW5DscFLsgXi9EBdAUHBKrklIru9iORVWCY8RwLUlA/ZNSmyqcJRFKtM
	p+PT1iaqe8Mndup19cyfJe6cnR+4rIMmvy5oPzCAgiSpb9r/+nJKBafN8Fn82A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706273617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imNQGpxCfZzxXKHa8c0ZjGv5PSBz4kBsS94bs6102ZY=;
	b=yMoVsEeEMd0WwSWlfhlePUnpEoBYLv/+XpdR0Gz4ibdbKwKBq+Dcb1AzwtVLUhrWo97Ikb
	cnQlsmIYVOMvjwAw==
From: "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irq_sim: Shrink code by using cleanup helpers
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240122124243.44002-5-brgl@bgdev.pl>
References: <20240122124243.44002-5-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170627361652.398.12825437185563577604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     590610d72a790458431cbbebc71ee24521533b5e
Gitweb:        https://git.kernel.org/tip/590610d72a790458431cbbebc71ee24521533b5e
Author:        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
AuthorDate:    Mon, 22 Jan 2024 13:42:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Jan 2024 13:44:48 +01:00

genirq/irq_sim: Shrink code by using cleanup helpers

Use the new __free() mechanism to remove all gotos and simplify the error
paths.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240122124243.44002-5-brgl@bgdev.pl

---
 kernel/irq/irq_sim.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index b0d50b4..fe8fd30 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
 
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
@@ -163,33 +164,27 @@ static const struct irq_domain_ops irq_sim_domain_ops = {
 struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 					 unsigned int num_irqs)
 {
-	struct irq_sim_work_ctx *work_ctx;
+	struct irq_sim_work_ctx *work_ctx __free(kfree) = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
+	unsigned long *pending;
 
-	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
 	if (!work_ctx)
-		goto err_out;
+		return ERR_PTR(-ENOMEM);
 
-	work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
-	if (!work_ctx->pending)
-		goto err_free_work_ctx;
+	pending = __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
+	if (!pending)
+		return ERR_PTR(-ENOMEM);
 
 	work_ctx->domain = irq_domain_create_linear(fwnode, num_irqs,
 						    &irq_sim_domain_ops,
 						    work_ctx);
 	if (!work_ctx->domain)
-		goto err_free_bitmap;
+		return ERR_PTR(-ENOMEM);
 
 	work_ctx->irq_count = num_irqs;
 	work_ctx->work = IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
+	work_ctx->pending = no_free_ptr(pending);
 
-	return work_ctx->domain;
-
-err_free_bitmap:
-	bitmap_free(work_ctx->pending);
-err_free_work_ctx:
-	kfree(work_ctx);
-err_out:
-	return ERR_PTR(-ENOMEM);
+	return no_free_ptr(work_ctx)->domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_sim);
 

