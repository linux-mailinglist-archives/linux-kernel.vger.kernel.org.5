Return-Path: <linux-kernel+bounces-63357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9B852E20
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E1C282EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764624B54;
	Tue, 13 Feb 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4TqKEk3C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JrIAE2bT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8C249E8;
	Tue, 13 Feb 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820726; cv=none; b=U5P9aRTAS/k6tJMbW32NFz8qx1nMC0IkeDlTPh/F5D4LmxycfCrP3rmZPWgM1BKpU8NhyqAHRq4tRvglTv8SqVYcSFEj169pX+4jXm66LCoZJqRKS4L72ToLaEGB91OuXOr9cTkMpRvWWZHCe81H3US9J9ZghR+CMWtf4+QAW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820726; c=relaxed/simple;
	bh=w1V92yhJ7znW5mCLg9cJb/2PDW8YuAua0bO8eBGqGoE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aUDiFVK50WiOzFapZPjwbarxqxuByJHtauj3zWnJr3gkqsrdGVrqcTa1jAbnBQuDArKevaFSdnR2xCl6u+esHR52RWO3mE9D3foUzqaur0L52Ybz6c0fYNvn3Hr4Rgdrqi/tHuaktaXzjOAOUYUAus0XC2UculZwhkSpkDi3HAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4TqKEk3C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JrIAE2bT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Feb 2024 10:38:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707820723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0Y8LXuXM+2quXl6GjfVoen1w/ZUhO5D8VOBXlYzfXc=;
	b=4TqKEk3CzHdi5cGbHGNfpMgWHKs0/J7t8ttDMHNvHJAh2Dk6oqmDJVMlR6z/uvB5n9Z+Jx
	+ZytB+2ZCcq0kNyZOMf6V8zSPfmlZh+YE8nzLz40G2wCVj1oKxtJlCCPDQbQo8tNHtqde0
	ilT6zwu0AS8JbpnnUZmITruYtukdPnyPbsDvHiJtmu1aMqfBZrwol4Eku0LfSwZITZCAnl
	vcijPP4N4f2XIr5lz9yFDFPwYhhEf+P2GeNFfPEh6I1CL7oz4yQpi01UUV74JWL2bZnkJ+
	EAtIpB0QQYjnqHjjEwduU3ttKfOPyKDPrDN+oJs/TcMLThiJBterTHgbFsxcmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707820723;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i0Y8LXuXM+2quXl6GjfVoen1w/ZUhO5D8VOBXlYzfXc=;
	b=JrIAE2bTwKYGzr9MGVPvm4L9co2hzupV5jlLbTy1D6Q3VT1kv407Rvs6NTmvh1XSFtV8Sa
	vtjZc8Nn2HxjlVBA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update
Cc: Kunkun Jiang <jiangkunkun@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213101206.2137483-4-maz@kernel.org>
References: <20240213101206.2137483-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170782072242.398.18224261385789305537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     af9acbfc2c4b72c378d0b9a2ee023ed01055d3e2
Gitweb:        https://git.kernel.org/tip/af9acbfc2c4b72c378d0b9a2ee023ed01055d3e2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 Feb 2024 10:12:06 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Feb 2024 11:29:52 +01:00

irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

When updating the affinity of a VPE, the VMOVP command is currently skipped
if the two CPUs are part of the same VPE affinity.

But this is wrong, as the doorbell corresponding to this VPE is still
delivered on the 'old' CPU, which screws up the balancing.  Furthermore,
offlining that 'old' CPU results in doorbell interrupts generated for this
VPE being discarded.

The harsh reality is that VMOVP cannot be elided when a set_affinity()
request occurs. It needs to be obeyed, and if an optimisation is to be
made, it is at the point where the affinity change request is made (such as
in KVM).

Drop the VMOVP elision altogether, and only use the vpe_table_mask
to try and stay within the same ITS affinity group if at all possible.

Fixes: dd3f050a216e (irqchip/gic-v4.1: Implement the v4.1 flavour of VMOVP)
Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240213101206.2137483-4-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 250b456..53abd47 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3826,8 +3826,9 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	int from, cpu = cpumask_first(mask_val);
+	struct cpumask common, *table_mask;
 	unsigned long flags;
+	int from, cpu;
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
@@ -3843,19 +3844,22 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * taken on any vLPI handling path that evaluates vpe->col_idx.
 	 */
 	from = vpe_to_cpuid_lock(vpe, &flags);
-	if (from == cpu)
-		goto out;
-
-	vpe->col_idx = cpu;
+	table_mask = gic_data_rdist_cpu(from)->vpe_table_mask;
 
 	/*
-	 * GICv4.1 allows us to skip VMOVP if moving to a cpu whose RD
-	 * is sharing its VPE table with the current one.
+	 * If we are offered another CPU in the same GICv4.1 ITS
+	 * affinity, pick this one. Otherwise, any CPU will do.
 	 */
-	if (gic_data_rdist_cpu(cpu)->vpe_table_mask &&
-	    cpumask_test_cpu(from, gic_data_rdist_cpu(cpu)->vpe_table_mask))
+	if (table_mask && cpumask_and(&common, mask_val, table_mask))
+		cpu = cpumask_test_cpu(from, &common) ? from : cpumask_first(&common);
+	else
+		cpu = cpumask_first(mask_val);
+
+	if (from == cpu)
 		goto out;
 
+	vpe->col_idx = cpu;
+
 	its_send_vmovp(vpe);
 	its_vpe_db_proxy_move(vpe, from, cpu);
 

