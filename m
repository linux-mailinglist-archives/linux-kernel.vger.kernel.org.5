Return-Path: <linux-kernel+bounces-157646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DB88B13FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7919F1C21569
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D0142916;
	Wed, 24 Apr 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wz9XJv0W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KXdqFMSE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784013BC19;
	Wed, 24 Apr 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713989053; cv=none; b=Nvs5DSBytXS8g4X7e42pkNqqASsWFJemiN6A+q7Tivo6SKWVozvtYia3usxCEJuhVmQLuPenvTDcynPtvhi3jvamYEECk2AWCsy1hTN+AoqhCd3LqgiMx1dFbJoQxJC3yCEfu5prrVjkmuWLmi02opeuHROTfCi28ueItse7+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713989053; c=relaxed/simple;
	bh=MyUmZ5+g3ZI0Q0bbtPqiW4ngPJcdMwtlwYP70W2Nbu8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OEvJyfpkldJfeCY2IEXID1UMXAN6qifeBoiLeQoklEMbSRHAj20DtRD+7j5w/9iMaHjKUhN0QOndKj+JIoYQPWCiNmHLezcqcqAzX5ChJrh4RXPX673h8kKg3stjOOyg0s4aYL4PNxKbuWu9RfSf53NlNOmljz7j7dDg/TUhcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wz9XJv0W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KXdqFMSE; arc=none smtp.client-ip=193.142.43.55
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
	bh=Njnox9y9KOk7ouot/auJpS7aOevCMlQLBzCeqpyhSyE=;
	b=Wz9XJv0WsgPb3IFCYGu12mb1dXOi94auJgv0RPDZbvBzfWIicjGqTerNpTpy2KVR9To+0l
	abfwMGnvjXWF8dkYQ9UAAXOJ1eP2bVQTArpajslQcFXuyfMIEYzq7KJTqB5AAFaK4CjEOA
	e9ZpPHWJCnjjHHLEXyKtFzB4bBcwAJT3KaTE+VKYohQVZ3P5pviorYRbUlcG3S/4Ocppg+
	yL19uzLVmxTRaizwHr0halOyjcgSXnibW7ih9+ntRl7PlNFgJIShKqoPReDrzjXDc977Sv
	sVY1GcdaCZgPWoQln/l6IVa/CKWHNMF1Ece6cUj3gjp+m5FiHO2DIyQPkuSLnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713989046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Njnox9y9KOk7ouot/auJpS7aOevCMlQLBzCeqpyhSyE=;
	b=KXdqFMSEeybeWRPsGeziOqK2b7ZSmaxLw/1s650EkSKl8tcWo5on0Rkmui8nyEfxgSletc
	UHKzHBaiG3mGqVCQ==
From: "tip-bot2 for Dawei Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/riscv-aplic-direct: Avoid explicit cpumask
 allocation on stack
Cc: Dawei Li <dawei.li@shingroup.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Anup Patel <anup@brainfault.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240416085454.3547175-6-dawei.li@shingroup.cn>
References: <20240416085454.3547175-6-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171398904657.10875.14129317895055784192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5d650d1eba876717888a0951ed873ef0f1d8cf61
Gitweb:        https://git.kernel.org/tip/5d650d1eba876717888a0951ed873ef0f1d8cf61
Author:        Dawei Li <dawei.li@shingroup.cn>
AuthorDate:    Tue, 16 Apr 2024 16:54:52 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Apr 2024 21:23:49 +02:00

irqchip/riscv-aplic-direct: Avoid explicit cpumask allocation on stack

In general it's preferable to avoid placing cpumasks on the stack, as
for large values of NR_CPUS these can consume significant amounts of
stack space and make stack overflows more likely.

Use cpumask_first_and_and() to avoid the need for a temporary cpumask on
the stack.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/r/20240416085454.3547175-6-dawei.li@shingroup.cn

---
 drivers/irqchip/irq-riscv-aplic-direct.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/irq-riscv-aplic-direct.c
index 06bace9..4a3ffe8 100644
--- a/drivers/irqchip/irq-riscv-aplic-direct.c
+++ b/drivers/irqchip/irq-riscv-aplic-direct.c
@@ -54,15 +54,12 @@ static int aplic_direct_set_affinity(struct irq_data *d, const struct cpumask *m
 	struct aplic_direct *direct = container_of(priv, struct aplic_direct, priv);
 	struct aplic_idc *idc;
 	unsigned int cpu, val;
-	struct cpumask amask;
 	void __iomem *target;
 
-	cpumask_and(&amask, &direct->lmask, mask_val);
-
 	if (force)
-		cpu = cpumask_first(&amask);
+		cpu = cpumask_first_and(&direct->lmask, mask_val);
 	else
-		cpu = cpumask_any_and(&amask, cpu_online_mask);
+		cpu = cpumask_first_and_and(&direct->lmask, mask_val, cpu_online_mask);
 
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;

