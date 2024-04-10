Return-Path: <linux-kernel+bounces-137926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C017689E9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E69B227D6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E095220309;
	Wed, 10 Apr 2024 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nPSoOKlS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X6b2q5ha"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A38168DC;
	Wed, 10 Apr 2024 05:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712726594; cv=none; b=RM7hSsSQ2wXQJczGlkhQTyYC025YKC2HfIvFmdqdUfiC90RrzVpuPbn8+bJr/MEAbNOFoWp6HUsFrQz9RnlbCML+a26mZuXpU6dL0e1FU5kGmCZ4LrKVCpChpwZfGIlJ65eBKzPmSJ9W+69bnr1ScdHfqDGnYWiT8A9Jim+kW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712726594; c=relaxed/simple;
	bh=7WSNNJs7UyJbths+Isy28tlrWPS4bjdTksBrpY3Fyo8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sW0xLRzYSbW4reeRoApcMP69zgqaELR5h+Fe0o3WKWkcm6I2+i7lnwwFF+ydd9I/gi3CzXQN731IyQDgV8KN255vxx6GhgOdIs9WL/BGgGG6CrC3tj7UkWoaS3yeMLJkyVEPRamK+Jjex4JfnvQZ9R8piJfDa/oHKtoQeBMlJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nPSoOKlS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X6b2q5ha; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 05:23:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712726590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j3DJxnKQpZ6uYxT75l5TYFJqwFWV3Gg/e+kg/xTKbKM=;
	b=nPSoOKlSvD2HJi6A41/D7nVxbm5Fo2zBM2DuKn+rb9deH1J2YCGbdrBfKlxvB5Y8FNiPiK
	zjYrRgLGgAhqrPzw8BtXYnFCXkJmc+dCq10k5ZNBfYT+qpYXPk91+ivo2EabIjXVEHESd5
	n7W6IRAbBhhGXJAOs1hdzQhwDVAi/dyvNRo+exkLpSyW+L6/6j9iQwXxICt7HKpDoH6JTQ
	czDjH/dzRY0tkfI6HlPikWHPVT5B7q1gReE7pos27bIza+Jdvl1HLSJuE/7gUnH/dmsXeO
	g+CPbIu+a5kYYCB9B2tvst2RtnM7MHZcwsy/Lu11xiJx4yCHkg8glV8GZR2gHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712726590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=j3DJxnKQpZ6uYxT75l5TYFJqwFWV3Gg/e+kg/xTKbKM=;
	b=X6b2q5hawNMlneFiT+aZfqnr+BNL5IccP7zH0wctetgQpw1IFEjMfrpPcaLmnrQnJf3SiG
	c8nEqOWjc4h1xrDQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Improve readability of per-CPU cpumask
 initialization code
Cc:
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171272658996.10875.10321970678195678587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     dbbe13a6f66b228a2867844ad4dd108576134775
Gitweb:        https://git.kernel.org/tip/dbbe13a6f66b228a2867844ad4dd108576134775
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 06:59:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Apr 2024 07:02:33 +02:00

x86/cpu: Improve readability of per-CPU cpumask initialization code

In smp_prepare_cpus_common() and x2apic_prepare_cpu():

 - use 'cpu' instead of 'i'
 - use 'node' instead of 'n'
 - use vertical alignment to improve readability
 - better structure basic blocks
 - reduce col80 checkpatch damage

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/apic/x2apic_cluster.c |  8 +++++---
 arch/x86/kernel/smpboot.c             | 23 ++++++++++++-----------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index afbb885..7db8321 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -178,14 +178,16 @@ static int x2apic_prepare_cpu(unsigned int cpu)
 	u32 phys_apicid = apic->cpu_present_to_apicid(cpu);
 	u32 cluster = apic_cluster(phys_apicid);
 	u32 logical_apicid = (cluster << 16) | (1 << (phys_apicid & 0xf));
+	int node = cpu_to_node(cpu);
 
 	x86_cpu_to_logical_apicid[cpu] = logical_apicid;
 
-	if (alloc_clustermask(cpu, cluster, cpu_to_node(cpu)) < 0)
+	if (alloc_clustermask(cpu, cluster, node) < 0)
 		return -ENOMEM;
-	if (!zalloc_cpumask_var_node(&per_cpu(ipi_mask, cpu), GFP_KERNEL,
-				cpu_to_node(cpu)))
+
+	if (!zalloc_cpumask_var_node(&per_cpu(ipi_mask, cpu), GFP_KERNEL, node))
 		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 536dad1..a581095 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1033,21 +1033,22 @@ static __init void disable_smp(void)
 
 void __init smp_prepare_cpus_common(void)
 {
-	unsigned int i, n;
+	unsigned int cpu, node;
 
 	/* Mark all except the boot CPU as hotpluggable */
-	for_each_possible_cpu(i) {
-		if (i)
-			per_cpu(cpu_info.cpu_index, i) = nr_cpu_ids;
+	for_each_possible_cpu(cpu) {
+		if (cpu)
+			per_cpu(cpu_info.cpu_index, cpu) = nr_cpu_ids;
 	}
 
-	for_each_possible_cpu(i) {
-		n = cpu_to_node(i);
-		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map, i), GFP_KERNEL, n);
-		zalloc_cpumask_var_node(&per_cpu(cpu_core_map, i), GFP_KERNEL, n);
-		zalloc_cpumask_var_node(&per_cpu(cpu_die_map, i), GFP_KERNEL, n);
-		zalloc_cpumask_var_node(&per_cpu(cpu_llc_shared_map, i), GFP_KERNEL, n);
-		zalloc_cpumask_var_node(&per_cpu(cpu_l2c_shared_map, i), GFP_KERNEL, n);
+	for_each_possible_cpu(cpu) {
+		node = cpu_to_node(cpu);
+
+		zalloc_cpumask_var_node(&per_cpu(cpu_sibling_map,    cpu), GFP_KERNEL, node);
+		zalloc_cpumask_var_node(&per_cpu(cpu_core_map,       cpu), GFP_KERNEL, node);
+		zalloc_cpumask_var_node(&per_cpu(cpu_die_map,        cpu), GFP_KERNEL, node);
+		zalloc_cpumask_var_node(&per_cpu(cpu_llc_shared_map, cpu), GFP_KERNEL, node);
+		zalloc_cpumask_var_node(&per_cpu(cpu_l2c_shared_map, cpu), GFP_KERNEL, node);
 	}
 
 	set_cpu_sibling_map(0);

