Return-Path: <linux-kernel+bounces-137927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B989E9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40F628269C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A537A219E2;
	Wed, 10 Apr 2024 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aiZHLZwB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zWQ/9tnq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C51802E;
	Wed, 10 Apr 2024 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726595; cv=none; b=Qm6yX/x7ZS2txE7SZHVfuMQgALNhXiWFT6zcvnOmzmh4Y0fau1ZJga9Ryj3ewewSNAkRRKzviigLPVy/71+6W4k9alE44rJC/Sa4CrpwmYiQasznlcGlP1G4yf0rra0vhZRayBhIxEa8bNB1u14bkghDdQIMIulaVjqiONKXUy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726595; c=relaxed/simple;
	bh=RBsTPuS6+g9xkjyLWTioNwh5KpQTdvWxjWVvdRBEpYw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RO+PB37y1w19jUSjfUUAHhF0oYj7Pe49UxmMT/FpG5IUS1S0Rkv2COQV7hyuiLkYzUGWaJ4F/R/XTlPT9DDaE/iGYLynZq3/yuthq99cGR+RsRQ9gKPqPdNuGPu2h3OLOdvGErx81BL6nxMmlOiA+1oA9r6I8ugIuDlo/vmpq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aiZHLZwB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zWQ/9tnq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 05:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712726591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG9GU9+Y+f+5cit3gq+cVQE/UEiPsYlSo8HDgKDDlJk=;
	b=aiZHLZwBa1aMYjeG7K1+1lUPty9jZGhLrUZ008cgtD+m6uR0KrDSul8fej7OaAmkinMbCv
	f950w3SNR5AJGtm/ukqh+XaQ/w7D8ZCracULUHQ4k8uAGPd2TU6ysrlw+YhmlAETtCMhH+
	BbEcT5HryVaL68SnitegUjbbuWjMIzkFyXGkG71wDwn130Z2Tf5TxGK+r2y5YcVu5NMMa3
	qBs725LGHFMhFkUS/ldA86xwdRN37LISQhxN4y6I/7+3TU5WhFdMOIOXXjpEubKe8mQJK2
	HsQw/0nQ/KS0iKLS09BM+8bCj+k6zoMSh4AdTeeb/rIfSirbYs5k1CewLu7vfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712726591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uG9GU9+Y+f+5cit3gq+cVQE/UEiPsYlSo8HDgKDDlJk=;
	b=zWQ/9tnqeUhWF36JTHqeBMn5aTixj6dJopDuWlDPruMoFJOTVpeeRmxJHeD/ahcvG50U3F
	MZN5XQ3GMagYFODQ==
From: "tip-bot2 for Li RongQing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Take NUMA node into account when allocating
 per-CPU cpumasks
Cc: Li RongQing <lirongqing@baidu.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240410030114.6201-1-lirongqing@baidu.com>
References: <20240410030114.6201-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171272659069.10875.14275567183040175048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e0a9ac192fd62322b932c6018db60217b3ad866d
Gitweb:        https://git.kernel.org/tip/e0a9ac192fd62322b932c6018db60217b3ad866d
Author:        Li RongQing <lirongqing@baidu.com>
AuthorDate:    Wed, 10 Apr 2024 11:01:14 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 06:55:31 +02:00

x86/cpu: Take NUMA node into account when allocating per-CPU cpumasks

per-CPU cpumasks are dominantly accessed from their own local CPUs,
so allocate them node-local to improve performance.

[ mingo: Rewrote the changelog. ]

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240410030114.6201-1-lirongqing@baidu.com
---
 arch/x86/kernel/apic/x2apic_cluster.c |  3 ++-
 arch/x86/kernel/smpboot.c             | 13 +++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 567dbd2..afbb885 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -183,7 +183,8 @@ static int x2apic_prepare_cpu(unsigned int cpu)
 
 	if (alloc_clustermask(cpu, cluster, cpu_to_node(cpu)) < 0)
 		return -ENOMEM;
-	if (!zalloc_cpumask_var(&per_cpu(ipi_mask, cpu), GFP_KERNEL))
+	if (!zalloc_cpumask_var_node(&per_cpu(ipi_mask, cpu), GFP_KERNEL,
+				cpu_to_node(cpu)))
 		return -ENOMEM;
 	return 0;
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 76bb650..536dad1 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1033,7 +1033,7 @@ static __init void disable_smp(void)
 
 void __init smp_prepare_cpus_common(void)
 {
-	unsigned int i;
+	unsigned int i, n;
 
 	/* Mark all except the boot CPU as hotpluggable */
 	for_each_possible_cpu(i) {
@@ -1042,11 +1042,12 @@ void __init smp_prepare_cpus_common(void)
 	}
 
 	for_each_possible_cpu(i) {
-		zalloc_cpumask_var(&per_cpu(cpu_sibling_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_core_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_die_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL);
-		zalloc_cpumask_var(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL);
+		n = cpu_to_node(i);
+		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map, i), GFP_KERNEL, n);
+		zalloc_cpumask_var_node(&per_cpu(cpu_core_map, i), GFP_KERNEL, n);
+		zalloc_cpumask_var_node(&per_cpu(cpu_die_map, i), GFP_KERNEL, n);
+		zalloc_cpumask_var_node(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL, n);
+		zalloc_cpumask_var_node(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL, n);
 	}
 
 	set_cpu_sibling_map(0);

