Return-Path: <linux-kernel+bounces-42525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246E88402A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18740B21C20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5CE57873;
	Mon, 29 Jan 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7zCIc8K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oR/7VUd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6757867;
	Mon, 29 Jan 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523409; cv=none; b=h1BcOdkplkPnzsnhRTsI/iyYTTvHaueUqhco5JVUoJftJ9HGK0Vha6cIrYj5BfwmcCuAFGH2W03q2f1qO7ZpVSe10iu5GQJNmqyMmIdMhpHpw/zxfkGMS/lIzn7jsGnvh6Wauj/7hyrVEE1uv1wgEZ6JPtZ+2UI/9zD3imCfPF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523409; c=relaxed/simple;
	bh=MMDGCwc+FSOicV5E+PeIAyDklNGTkpiv2XznQeMswrw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JxUGgptoqvjvrpbjZvNBnjCBVDwMFk9Tk7eRMzTmPHJndHHb4RUXL4n7FddpzAYbsmoBCwN4nMHblFTorrbT83xnrLi7dCr0xF1DRKuiznrVsZaj49+bQEiZQ20AkGLRm31dfKGAhYupnmTsTR03KjX/xISqCh60Qt75mq1N4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7zCIc8K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oR/7VUd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jan 2024 10:16:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706523405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k+lQZriCq0HWtXwAcVFYcKM+F9ivNEC2bp4CEGAbA4=;
	b=Q7zCIc8KWm1il92nA5SDg11i5odaPU3F9mNB15aE/XVHkl8k/1WXnnQYjjsie1FZnuNBp3
	sZ2A2hb6s9BDUygWMBXzGK5apr3p+SD+TkOwrMDAptQF6iu/8ej0gKuMq2L14hGOAuB+dU
	xAFCKsLkJcSW+6Fk7eTnm0oGH/PwFQq5dQitJIrmjwHGGVH/W7t83IvUv3WcJB4HB5v4Wp
	cRMwfK8ybRZu+eOWs608uftZp5BRriQrUHih7C93ZBgNCwgLyym38mtFHrtT1e1zfy8yIo
	gf9ckbtIImhbkK5fgoW0KIDIp5qiG3FqwcKHbs2W3W2TcWyKX8Ey+1vu/v2BGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706523405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k+lQZriCq0HWtXwAcVFYcKM+F9ivNEC2bp4CEGAbA4=;
	b=0oR/7VUdjSKLdHHxSYYISUIc4RIkG1L2JyaPTQXGbb+oUJOmLiuJqagz3MMouSpIf3GC/z
	gYWlExnGSWjytICA==
From: "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irq_sim: Shrink code by using
 <linux/cleanup.h> helpers
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240122124243.44002-5-brgl@bgdev.pl>
References: <20240122124243.44002-5-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170652340477.398.6421562413831650962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     aafd753555c0ecb9c7ce11ff14429a34c8c0a14b
Gitweb:        https://git.kernel.org/tip/aafd753555c0ecb9c7ce11ff14429a34c8c0a14b
Author:        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
AuthorDate:    Mon, 22 Jan 2024 13:42:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 29 Jan 2024 11:07:57 +01:00

genirq/irq_sim: Shrink code by using <linux/cleanup.h> helpers

Use the new __free() mechanism to remove all gotos and simplify the error
paths.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20240122124243.44002-5-brgl@bgdev.pl
---
 kernel/irq/irq_sim.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index b0d50b4..38d6ae6 100644
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
+	struct irq_sim_work_ctx *work_ctx __free(kfree) =
+				kmalloc(sizeof(*work_ctx), GFP_KERNEL);
 
-	work_ctx = kmalloc(sizeof(*work_ctx), GFP_KERNEL);
 	if (!work_ctx)
-		goto err_out;
+		return ERR_PTR(-ENOMEM);
 
-	work_ctx->pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
-	if (!work_ctx->pending)
-		goto err_free_work_ctx;
+	unsigned long *pending __free(bitmap) = bitmap_zalloc(num_irqs, GFP_KERNEL);
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
 

