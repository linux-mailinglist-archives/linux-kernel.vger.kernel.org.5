Return-Path: <linux-kernel+bounces-35277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D094D838EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829631F2164F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EB5F546;
	Tue, 23 Jan 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MPgHBCAW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="29fejpEh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01325604BB
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014435; cv=none; b=FhD5iUfK3WeOMQu9F9MqPwQfHQ8XcwbG8BTul8zyqQpRKkGL1DVApkfskYBWhX4JDIo8hRuFLijtw3A8HJOrbvg6IfUzsaCT59pyM81kot5L0X45zqxM14zr46TIpjmqDgz3eQHjCAbqw1fw1gUEgj0aU8f93+Jmsnm0wHc8pkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014435; c=relaxed/simple;
	bh=cwuXnq3/bfsRA6gd3Cmv/vE1KIT+6qbbvUHp22hvsww=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=NneJhQIwGzHWvquKOCqUv2Ij+jZtbrCipEjl96HRedqvcaYG5eRSdrE/HX3jYmXNbCOe8y2Anw6CXZDhG+ZUcddo10VH2LYAPkhLI0Vb7DNbG88tChRGxIQYm/gDqCJDQwncQueC7WQ1Ib5MLSxiFYJ2KcIYZWK8StoQg+7Fyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MPgHBCAW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=29fejpEh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115909.142089057@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bGJfOwxea2Kzkpm6jN0bfhkDx1w055b9eqyYHBC+Rt4=;
	b=MPgHBCAWenhjltLbt1mj9/hPj+TgPDdNbAxfp9bJ8FdqNit6f4OxPc3OGCwecsuKGIGC9y
	WdQU8Kjut+4GDL4dDeZuppgtVQQzAf4QreWTv1w+vFk847ISie/0DSZPFvKc8lX/1Aeek2
	llSrdEYy+q2fQPwk1h3F5emnDbmphf7qmYEOQCqnjiEwKUDf2D7Dd8W1urf1p8e4i9OeCK
	uwqCZddcDu6qWk/59VsWhu+B2zxZoQlpWlhHpbk8y/5973AMBEYjINXXuoUUoeVmFiwi64
	fOnHijzgSRgVC+GZtK3A2RIpJQN5HYdZANzb05hl5M6qz92sxN5QzPgIM51JXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bGJfOwxea2Kzkpm6jN0bfhkDx1w055b9eqyYHBC+Rt4=;
	b=29fejpEhesOhnZ9wsgFnV8n2wT9d0ZivSWRM+k+OoJ5+/5LJ16C0dris2zqBjFf2y2j6u9
	aFWlilt48t33naAA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v5 13/19] x86/mm/numa: Use core domain size on AMD
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:50 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

cpuinfo::topo::x86_coreid_bits is about to be phased out. Use the core
domain size from the topology information.

Add a comment why the early MPTABLE parsing is required and decrapify the
loop which sets the APIC ID to node map.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


---
 arch/x86/include/asm/topology.h |    5 +++++
 arch/x86/mm/amdtopology.c       |   35 ++++++++++++++++-------------------
 2 files changed, 21 insertions(+), 19 deletions(-)
---
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -121,6 +121,11 @@ struct x86_topology_system {
 
 extern struct x86_topology_system x86_topo_system;
 
+static inline unsigned int topology_get_domain_size(enum x86_topology_domains dom)
+{
+	return x86_topo_system.dom_size[dom];
+}
+
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -54,13 +54,11 @@ static __init int find_northbridge(void)
 
 int __init amd_numa_init(void)
 {
-	u64 start = PFN_PHYS(0);
+	unsigned int numnodes, cores, apicid;
+	u64 prevbase, start = PFN_PHYS(0);
 	u64 end = PFN_PHYS(max_pfn);
-	unsigned numnodes;
-	u64 prevbase;
-	int i, j, nb;
 	u32 nodeid, reg;
-	unsigned int bits, cores, apicid_base;
+	int i, j, nb;
 
 	if (!early_pci_allowed())
 		return -EINVAL;
@@ -158,26 +156,25 @@ int __init amd_numa_init(void)
 		return -ENOENT;
 
 	/*
-	 * We seem to have valid NUMA configuration.  Map apicids to nodes
-	 * using the coreid bits from early_identify_cpu.
+	 * We seem to have valid NUMA configuration. Map apicids to nodes
+	 * using the size of the core domain in the APIC space.
 	 */
-	bits = boot_cpu_data.x86_coreid_bits;
-	cores = 1 << bits;
-	apicid_base = 0;
+	cores = topology_get_domain_size(TOPO_CORE_DOMAIN);
 
 	/*
-	 * get boot-time SMP configuration:
+	 * Scan MPTABLE to map the local APIC and ensure that the boot CPU
+	 * APIC ID is valid. This is required because on pre ACPI/SRAT
+	 * systems IO-APICs are mapped before the boot CPU.
 	 */
 	early_get_smp_config();
 
-	if (boot_cpu_physical_apicid > 0) {
-		pr_info("BSP APIC ID: %02x\n", boot_cpu_physical_apicid);
-		apicid_base = boot_cpu_physical_apicid;
+	apicid = boot_cpu_physical_apicid;
+	if (apicid > 0)
+		pr_info("BSP APIC ID: %02x\n", apicid);
+
+	for_each_node_mask(i, numa_nodes_parsed) {
+		for (j = 0; j < cores; j++, apicid++)
+			set_apicid_to_node(apicid, i);
 	}
-
-	for_each_node_mask(i, numa_nodes_parsed)
-		for (j = apicid_base; j < cores + apicid_base; j++)
-			set_apicid_to_node((i << bits) + j, i);
-
 	return 0;
 }


