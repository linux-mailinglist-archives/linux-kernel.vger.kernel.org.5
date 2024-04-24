Return-Path: <linux-kernel+bounces-157647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EA8B13FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B741F24081
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05852142E7D;
	Wed, 24 Apr 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XzOnwIwW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="08HiiVdH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4779F1BF37;
	Wed, 24 Apr 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989053; cv=none; b=cMhQjNBJ1/UTiTR6ELsKC7hPWyJR7pI3WgrVspVSPLDJtkY0gjVjSgRZJEHUriZ+mhblF/qgUQ9TJ9LybucBI0v8N9wb+zUb2NqxTNqn4kk0YDDYB6BdVU32P/u3wT+BHHbgSkmZWKEVYrtqtiCHJRNuE0p/jUxtrhLqU4VlM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989053; c=relaxed/simple;
	bh=w94XIBk0DaKqMjDZ0Eyy69eu2Ki6DxY5h6cahh+IEZw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pU+M8jtMSfY/jHEqqOq1tfmbSOaifSKu7iASJHrX8bxCWSU7MVGRLcye8VkQjSnNa74ut/PuKW3YzGPf35kmUSzzsWklQgTc6v/HvrbqE8Gp5jej3t2fUQPJlXzvPXnA1EtmPlcYKirfojBYRqeMsvkEYOCTK9gLova06wiN5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XzOnwIwW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=08HiiVdH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:04:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7n5OD7GVj5CfbcvRy5NQoNf4Xal09VkHc+GcS0pq+Qs=;
	b=XzOnwIwWzHZuEIqsxB6HBLWiHiSOWmnVd0D/JPOh2X+z6rMMXeBg1eFn/1iZnqk56ap1L/
	/HaY5FDD1mvMRtiyDVg2qrov3ZrHcZF/FuBmA8NBtKYWEgcr9V70wJiOO3vZ07KYltQSSx
	3E1NyU3jf/PNf62ZdM5c5HuaWoK+OI77jqTZf9tQdbrnfceuTS5RwoiezXHZazFAfh6vFu
	+DyXSc4/gkTyo0TD0VWTys7ZrJ7AMWW1+Wqt7HFb9ziut+3XgNt3oDJr8pMCwSBMUiDSdN
	42rA/fDLCYsOOKr9geRSI3SDKfXxCQAQ24FQX+blJSpJ6FLE+v8QShXGO7hX9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7n5OD7GVj5CfbcvRy5NQoNf4Xal09VkHc+GcS0pq+Qs=;
	b=08HiiVdH2lW4xB8spzUuN8zqhXaLwrYJZRYR/3W2w5KBoxxSTTO2wuNcJS0JUB7xgilBjg
	JEnjeq6Ez5aDMoCw==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Avoid explicit cpumask allocation
 on stack
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240416085454.3547175-4-dawei.li@shingroup.cn>
References: <20240416085454.3547175-4-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904698.10875.9923984308673388567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fcb8af4cbcd122e33ceeadd347b8866d32035af7
Gitweb:        https://git.kernel.org/tip/fcb8af4cbcd122e33ceeadd347b8866d32035af7
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Tue, 16 Apr 2024 16:54:50 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 21:23:49 +02:00

irqchip/gic-v3-its: Avoid explicit cpumask allocation on stack

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Remove cpumask var on stack and use cpumask_any_and() to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240416085454.3547175-4-dawei.li@shingroup.cn

---
 drivers/irqchip/irq-gic-v3-its.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fca888b..20f9542 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3826,9 +3826,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	struct cpumask common, *table_mask;
+	unsigned int from, cpu = nr_cpu_ids;
+	struct cpumask *table_mask;
 	unsigned long flags;
-	int from, cpu;
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3850,10 +3850,15 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * If we are offered another CPU in the same GICv4.1 ITS
 	 * affinity, pick this one. Otherwise, any CPU will do.
 	 */
-	if (table_mask && cpumask_and(&common, mask_val, table_mask))
-		cpu = cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
-	else
+	if (table_mask)
+		cpu = cpumask_any_and(mask_val, table_mask);
+	if (cpu < nr_cpu_ids) {
+		if (cpumask_test_cpu(from, mask_val) &&
+		    cpumask_test_cpu(from, table_mask))
+			cpu = from;
+	} else {
 		cpu = cpumask_first(mask_val);
+	}
 
 	if (from == cpu)
 		goto out;

