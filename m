Return-Path: <linux-kernel+bounces-157644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4668B13F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AD4282A02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA5413E025;
	Wed, 24 Apr 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jnQEwoIe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3UdcIIgP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B313BC20;
	Wed, 24 Apr 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989052; cv=none; b=CIrqapA84q0wHmDi4nz4PFwS38XnggdiFmBxWDa30T/8K+H4Jho8KGP6AAkLn4wKwRi0pH5TV+yZLWUNHCQCU8NWF2e7CWyYInSsDKg6AMC7cphZSZBioz34IEfOdLiVH2S3XRbO++FeYAP/pnLvgV1rXE3be+IAoeJGugn6W5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989052; c=relaxed/simple;
	bh=Y+50pLO9gSVvKo0SVPwbqBjeSYsKbBuia1NSTbVTtNE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kIGCoWgLwRcEZDXYCDx2SqBRwUBzwWfaTkYgDGJn8bh72wvpBXAplFAuh+7O5Dlv/VkRGKGgA7Cs+oa4oVhBCmnMSdQGhPHtGeH70d1LWYCprkL9uONU6HLPtwczwcTiCedSNiPhMUnL0+Xfy37t2qJtQ4aTrfLqiIv02jT9Avo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jnQEwoIe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3UdcIIgP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Apr 2024 20:04:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713989046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyBoIwCatk7eJWipketyX2A/lcj4OLW5PJwS5SCGa10=;
	b=jnQEwoIe/Ck77E0VwqPN6VbaP5hWSl4btGVXPnn3421epgfrTPE63x+37prH8sIyvJqLBv
	Qpx/BUDjGO2usg/NCBTnh7wocFYWqzKJsarwoC+NJS72nU3/ZZoocvPyW8DxyTQn2Zkeua
	9dBvAWo8se7kTqMw2HKzYJpFWf9pEQG6Yq3TUnb5wUXaYWAXU8eqn6KrpE25wOVUBcDMi8
	G2Vj4TK+Af1qEV+wB77bv78CfuZNi/N703pI4bzr/kzFb97il/+GRllHQNa2yPeQewaNJ6
	03vrNaE0CnoE25A1RY+Jwinf7Gbq0WS82BiUDt9TfseIP11DEcGN735Y0WKYEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyBoIwCatk7eJWipketyX2A/lcj4OLW5PJwS5SCGa10=;
	b=3UdcIIgP8tBUTGUCFM1wJb1wQBafqvjyrp+x7vc0bVwqiRK5KZEUHSVOogyZJ6ZmdR+mFn
	dJwfNE6irKzW8TDQ==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/sifive-plic: Avoid explicit cpumask
 allocation on stack
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Anup Patel <anup@brainfault.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240416085454.3547175-7-dawei.li@shingroup.cn>
References: <20240416085454.3547175-7-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904640.10875.11548457486987058733.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a7fb69ffd7ce438a259b2f9fbcebc62f5caf2d4f
Gitweb:        https://git.kernel.org/tip/a7fb69ffd7ce438a259b2f9fbcebc62f5caf2d4f
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Tue, 16 Apr 2024 16:54:53 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 21:23:49 +02:00

irqchip/sifive-plic: Avoid explicit cpumask allocation on stack

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20240416085454.3547175-7-dawei.li@shingroup.cn

---
 drivers/irqchip/irq-sifive-plic.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index f3d4cb9..8fb183c 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -164,15 +164,12 @@ static int plic_set_affinity(struct irq_data *d,
 			     const struct cpumask *mask_val, bool force)
 {
 	unsigned int cpu;
-	struct cpumask amask;
 	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
-	cpumask_and(&amask, &priv->lmask, mask_val);
-
 	if (force)
-		cpu = cpumask_first(&amask);
+		cpu = cpumask_first_and(&priv->lmask, mask_val);
 	else
-		cpu = cpumask_any_and(&amask, cpu_online_mask);
+		cpu = cpumask_first_and_and(&priv->lmask, mask_val, cpu_online_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;

