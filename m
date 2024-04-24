Return-Path: <linux-kernel+bounces-157645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC878B13FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02430B28038
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A02142906;
	Wed, 24 Apr 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fdyQvQmO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MQ7D0okN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477FA13B59F;
	Wed, 24 Apr 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989053; cv=none; b=Jw7KLOmpBCRyKcPQ1AQbpuZq5DENFPVIeIc6L0ruZ+kt7eZW50vN8hdx2zW2t1vhIiDSlsrJUNxHO0eX91BEOVHmBXstXRYSq25XTkM5eCRM4weuqnXuohhFcRLXvv99iGXEtYmA0Oetvvgzwr5Rd0zoY6whzZ06ZPjWWKG+OPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989053; c=relaxed/simple;
	bh=jaehCSztcHNjKhgtfNjWT9eHwGYTbqH2cjuXZIKBa/U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hyom6OCcXM+Ffn5SpuQNsWs/fUiyRdk41DyQvYmApQi35mkPhVc7Ba/e1CWrpAfhh2RH6SzDKYW/87bNum16RkhXRkBy2VicIh2dpqPv1FRLn4VWCul1S/hEcZITk9PAGQyZ45Cmx/0OiaXcmZZ6vk7O6mSGHVtxmm8tuBCCZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fdyQvQmO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MQ7D0okN; arc=none smtp.client-ip=193.142.43.55
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
	bh=nYQyn7SIedmMHOvSIIeDgv4vy3exAvl2uI8mvCBEwEo=;
	b=fdyQvQmOHha+PkNSv9Yh85D8bQNLjn8dZmrDZ3/PbOoHa2h0mhmIM/Ah81qVzg7QWkk3zY
	Hd5sBXXpbpf3IcSxlFaCiFeZ4I0RSCcMsSJ1R3/3b96ayCrrrHk7eWqGCm82WkF8wKP1ze
	8JAw58gfJ91V8+f6+0FaHaMLZzScdwC8G5p/AfRB7oDemWqv8vLW2fEpP+usz7N8C46plL
	2G/jrI2QZslJF1ApBqnr+Lh8yVhH+k3ptl9wCB7cBxHrpZepDBTfmjcYLbXyPz6tat84z/
	LZznh+y5qs/Nxf5XUYUg0B8o9TZEgDHqLlnY1WtWOvk9FvJ0D3RLFrG5w1Fdvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYQyn7SIedmMHOvSIIeDgv4vy3exAvl2uI8mvCBEwEo=;
	b=MQ7D0okNdUxJii2Ky8FzxK+PWGWCGqbEcyoGQbVyD7mwG0DeXjj22UljqS3yDF/ooll83d
	S3JdkxbssjgcUqDQ==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/loongson-eiointc: Avoid explicit cpumask
 allocation on stack
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240416085454.3547175-5-dawei.li@shingroup.cn>
References: <20240416085454.3547175-5-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904674.10875.3869298524351572016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2bc32db5a262cc34753cb4208b2d3043d1cd81ae
Gitweb:        https://git.kernel.org/tip/2bc32db5a262cc34753cb4208b2d3043d1cd81ae
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Tue, 16 Apr 2024 16:54:51 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 21:23:49 +02:00

irqchip/loongson-eiointc: Avoid explicit cpumask allocation on stack

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/r/20240416085454.3547175-5-dawei.li@shingroup.cn

---
 drivers/irqchip/irq-loongson-eiointc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index 4f5e6d2..c7ddebf 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -93,19 +93,15 @@ static int eiointc_set_irq_affinity(struct irq_data *d, const struct cpumask *af
 	unsigned int cpu;
 	unsigned long flags;
 	uint32_t vector, regaddr;
-	struct cpumask intersect_affinity;
 	struct eiointc_priv *priv = d->domain->host_data;
 
 	raw_spin_lock_irqsave(&affinity_lock, flags);
 
-	cpumask_and(&intersect_affinity, affinity, cpu_online_mask);
-	cpumask_and(&intersect_affinity, &intersect_affinity, &priv->cpuspan_map);
-
-	if (cpumask_empty(&intersect_affinity)) {
+	cpu = cpumask_first_and_and(&priv->cpuspan_map, affinity, cpu_online_mask);
+	if (cpu >= nr_cpu_ids) {
 		raw_spin_unlock_irqrestore(&affinity_lock, flags);
 		return -EINVAL;
 	}
-	cpu = cpumask_first(&intersect_affinity);
 
 	vector = d->hwirq;
 	regaddr = EIOINTC_REG_ENABLE + ((vector >> 5) << 2);

