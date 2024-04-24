Return-Path: <linux-kernel+bounces-157648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B71D8B1403
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6D11C22F8F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66C1144D3A;
	Wed, 24 Apr 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ppMoE3nE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sLyg5o9F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D928142E8A;
	Wed, 24 Apr 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989055; cv=none; b=Bk+VFyg5pFV8HSm1bl6goodNDNT+aART0ubUisWH2etY/wwzA1vcOdJh4ZEFSKXInXXKHe9MyGebCZAob9mSZBIEbrYvcNDBNz4Gq+0zrLvYlHQ5qet+isN0qTNZCvSKgA9Iyk45CJFWVKSIFAAWo/B8/X7cqJVb+sWSUU3PJpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989055; c=relaxed/simple;
	bh=qPqVNK7uWAmguOkWW+7sc6hrSU3AGtvOyIB9h2WeGAY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HaeovEY25kZRecOvZJXE4hQUAfLh8MGyrp9s29nagbDGW+Ewi2GcU7CaVnUSDl/VVld2i5MjKkrZVJCqaG8JhmCi5gBTorM8IrGzB2QX3dwZV9ooYUsdkZHhupjwkRUMxVUjIq8giZCvvTidwm20A7vmmsO85SY41ZDM+oh4TUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ppMoE3nE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sLyg5o9F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5z4tFy3QCHZzwedTlQsNI/nutDSDWzD6FrlbXGLPYo=;
	b=ppMoE3nEecgT7BHoDjA8O41+F/4OIzwV7PpJHK4e0WGfLdoHXyHs8En2xhICi0RacZdHby
	/2pUhAPSn4RO4O4nyJiZzj4Zu3ve3XHTR+/v8wL+j0IPVFwESEzVeIioPs6d6EHp6BpIw6
	3zMIC+Wg3xkrZE502FePPjoxDYPaKPbXoa0srt8MkXzXC4YdjYDRkFeF2ryjDHydw3055Z
	LV1V6v0VfNQN+cVB9rw1i9mT2SlDjADjL5D4GZiUqtYmBbWI2071Jw2QY9saCgDnIz36fP
	XDlswjTpEH+mZ511MfHGAleOhu66wSQzT/2BYi80E28Wx+b/3Nu4FYaqNP0hRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5z4tFy3QCHZzwedTlQsNI/nutDSDWzD6FrlbXGLPYo=;
	b=sLyg5o9F76swgbTgiZP3exQvmSgbvGSs76/S0zt9ATW4SedySvv/335Tsc7JcHAO0r/ZqC
	DgPQXPAJJwqeynDQ==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-bcm6345-l1: Avoid explicit cpumask
 allocation on stack
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240416085454.3547175-3-dawei.li@shingroup.cn>
References: <20240416085454.3547175-3-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904724.10875.2678089770204346248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6a9a52f74e3b82ff3f5398810c1b23ad497e2df5
Gitweb:        https://git.kernel.org/tip/6a9a52f74e3b82ff3f5398810c1b23ad497e2df5
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Tue, 16 Apr 2024 16:54:49 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 21:23:49 +02:00

irqchip/irq-bcm6345-l1: Avoid explicit cpumask allocation on stack

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240416085454.3547175-3-dawei.li@shingroup.cn

---
 drivers/irqchip/irq-bcm6345-l1.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index eb02d20..90daa27 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -192,14 +192,10 @@ static int bcm6345_l1_set_affinity(struct irq_data *d,
 	u32 mask = BIT(d->hwirq % IRQS_PER_WORD);
 	unsigned int old_cpu = cpu_for_irq(intc, d);
 	unsigned int new_cpu;
-	struct cpumask valid;
 	unsigned long flags;
 	bool enabled;
 
-	if (!cpumask_and(&valid, &intc->cpumask, dest))
-		return -EINVAL;
-
-	new_cpu = cpumask_any_and(&valid, cpu_online_mask);
+	new_cpu = cpumask_first_and_and(&intc->cpumask, dest, cpu_online_mask);
 	if (new_cpu >= nr_cpu_ids)
 		return -EINVAL;
 

