Return-Path: <linux-kernel+bounces-68795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3685807E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2771F22106
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064FB130ACB;
	Fri, 16 Feb 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g7Rf4+CF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m3/6FWSl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B506112FB07;
	Fri, 16 Feb 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096613; cv=none; b=kuUlJyozzFtsq7bNxz8oZupiOYGebpSyEUXljjaKgaUODCaqfqfD8V7XZBZcDvi/pze4oQdrbvHmAvKLy0NSHfVDxfSA6XNh/Q0mbFZgI2F3gsUNpVEzuBFB4w3LO8g/WdjuKip/Y2sUQ0b18aQ3iVFIVosZIXr7NLKo7k2x6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096613; c=relaxed/simple;
	bh=B6sWGGlQWgc1bxu2stRkSjneAOQ3+FJbadysUzYciR0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hGOZEOBCyr2UIw/N1Dp6xaZQpZcd8A+QwVBqBdA2TUJkL/WCrlhcGrukbBow9eJqbfX3gJZhDi+va5nPhTCgHOVwqqLlH+q9eQBhOpbUpfXSLAGYistLl2jXyEyCQVr4DguGxzmXP0y28drATb456WNvl9l6YnNm7RRJonR6UGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g7Rf4+CF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m3/6FWSl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgFLXdB4LTykjjcl7wrBSYESiNQA2waIClgJDu5U1F8=;
	b=g7Rf4+CFATJqjLAmjHC/WnnkYNMYrYpA3HXauQVcbfUBjJweI8TPs4CuTY/c+5Jqt6/DHH
	CRZBqsRh3NiOuasWwSNsUa+u6hDIG2ORIBFD2pNQxB1Zvi/LxCB/9eu/J6wkX3GRpL71NK
	chB/TxDbAxObq70j2zdx33yi5zF2oiMlq9iRsmKs12Wr+gRE9GPep2Uk9WhTfKUIe3AeWO
	nkMQ7O8B2qUnVL0Ck/ED4u4SA3SHEYNKcvGnv72Mkxcv8RUyeC0ZesXPyRCCswY6DUyslz
	3I4ugpesg0OTYdHXy19V3TF5PygtkBoZz2VG7gYV+eNgFbcqJtxyUESZtCBQhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096609;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgFLXdB4LTykjjcl7wrBSYESiNQA2waIClgJDu5U1F8=;
	b=m3/6FWSlIJYw+Si87nZ5sWSKH/fJ3Ksh2QCqaE3emgoUIZmvlcmdN0T7Bs6t9k3GmZo6gf
	zNJ6Q1QO5dL6NbDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu/topology: Use topology logical mapping mechanism
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.901865302@linutronix.de>
References: <20240213210252.901865302@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809660908.398.11429906301241807172.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     380414be78bf8dbe1c3ed98feb75e2579c4a1bae
Gitweb:        https://git.kernel.org/tip/380414be78bf8dbe1c3ed98feb75e2579c4a1bae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:44 +01:00

x86/cpu/topology: Use topology logical mapping mechanism

Replace the logical package and die management functionality and retrieve
the logical IDs from the topology bitmaps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.901865302@linutronix.de





---
 arch/x86/include/asm/topology.h       |  15 +--
 arch/x86/kernel/cpu/common.c          |  13 +---
 arch/x86/kernel/cpu/topology_common.c |   4 +-
 arch/x86/kernel/smpboot.c             | 111 +-------------------------
 4 files changed, 12 insertions(+), 131 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index bdd6a98..5ce06f3 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -172,6 +172,13 @@ static inline int topology_get_logical_id(u32 apicid, enum x86_topology_domains 
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
+
+static inline int topology_phys_to_logical_pkg(unsigned int pkg)
+{
+	return topology_get_logical_id(pkg << x86_topo_system.dom_shifts[TOPO_PKG_DOMAIN],
+				       TOPO_PKG_DOMAIN);
+}
+
 extern int __max_smt_threads;
 
 static inline int topology_max_smt_threads(void)
@@ -181,10 +188,6 @@ static inline int topology_max_smt_threads(void)
 
 #include <linux/cpu_smt.h>
 
-int topology_update_package_map(unsigned int apicid, unsigned int cpu);
-int topology_update_die_map(unsigned int dieid, unsigned int cpu);
-int topology_phys_to_logical_pkg(unsigned int pkg);
-
 extern unsigned int __amd_nodes_per_pkg;
 
 static inline unsigned int topology_amd_nodes_per_pkg(void)
@@ -205,10 +208,6 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
 }
 
 #else /* CONFIG_SMP */
-static inline int
-topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
-static inline int
-topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4babe3c..58f9cc7 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1719,18 +1719,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void update_package_map(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int cpu = smp_processor_id();
-
-	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
-	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
-#else
-	c->topo.logical_pkg_id = 0;
-#endif
-}
-
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -1915,7 +1903,6 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	update_package_map(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
 	if (boot_cpu_has_bug(X86_BUG_GDS))
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 0276978..c21a387 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -10,6 +10,7 @@
 #include "cpu.h"
 
 struct x86_topology_system x86_topo_system __ro_after_init;
+EXPORT_SYMBOL_GPL(x86_topo_system);
 
 unsigned int __amd_nodes_per_pkg __ro_after_init;
 EXPORT_SYMBOL_GPL(__amd_nodes_per_pkg);
@@ -147,6 +148,9 @@ static void topo_set_ids(struct topo_scan *tscan)
 	c->topo.pkg_id = topo_shift_apicid(apicid, TOPO_PKG_DOMAIN);
 	c->topo.die_id = topo_shift_apicid(apicid, TOPO_DIE_DOMAIN);
 
+	c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
+	c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+
 	/* Package relative core ID */
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 93470eb..9ade685 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -125,23 +125,6 @@ struct mwait_cpu_dead {
  */
 static DEFINE_PER_CPU_ALIGNED(struct mwait_cpu_dead, mwait_cpu_dead);
 
-/* Logical package management. */
-struct logical_maps {
-	u32	phys_pkg_id;
-	u32	phys_die_id;
-	u32	logical_pkg_id;
-	u32	logical_die_id;
-};
-
-/* Temporary workaround until the full topology mechanics is in place */
-static DEFINE_PER_CPU_READ_MOSTLY(struct logical_maps, logical_maps) = {
-	.phys_pkg_id	= U32_MAX,
-	.phys_die_id	= U32_MAX,
-};
-
-static unsigned int logical_packages __read_mostly;
-static unsigned int logical_die __read_mostly;
-
 /* Maximum number of SMT threads on any online core */
 int __read_mostly __max_smt_threads = 1;
 
@@ -334,103 +317,11 @@ static void notrace start_secondary(void *unused)
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
 
-/**
- * topology_phys_to_logical_pkg - Map a physical package id to a logical
- * @phys_pkg:	The physical package id to map
- *
- * Returns logical package id or -1 if not found
- */
-int topology_phys_to_logical_pkg(unsigned int phys_pkg)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		if (per_cpu(logical_maps.phys_pkg_id, cpu) == phys_pkg)
-			return per_cpu(logical_maps.logical_pkg_id, cpu);
-	}
-	return -1;
-}
-EXPORT_SYMBOL(topology_phys_to_logical_pkg);
-
-/**
- * topology_phys_to_logical_die - Map a physical die id to logical
- * @die_id:	The physical die id to map
- * @cur_cpu:	The CPU for which the mapping is done
- *
- * Returns logical die id or -1 if not found
- */
-static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cpu)
-{
-	int cpu, proc_id = cpu_data(cur_cpu).topo.pkg_id;
-
-	for_each_possible_cpu(cpu) {
-		if (per_cpu(logical_maps.phys_pkg_id, cpu) == proc_id &&
-		    per_cpu(logical_maps.phys_die_id, cpu) == die_id)
-			return per_cpu(logical_maps.logical_die_id, cpu);
-	}
-	return -1;
-}
-
-/**
- * topology_update_package_map - Update the physical to logical package map
- * @pkg:	The physical package id as retrieved via CPUID
- * @cpu:	The cpu for which this is updated
- */
-int topology_update_package_map(unsigned int pkg, unsigned int cpu)
-{
-	int new;
-
-	/* Already available somewhere? */
-	new = topology_phys_to_logical_pkg(pkg);
-	if (new >= 0)
-		goto found;
-
-	new = logical_packages++;
-	if (new != pkg) {
-		pr_info("CPU %u Converting physical %u to logical package %u\n",
-			cpu, pkg, new);
-	}
-found:
-	per_cpu(logical_maps.phys_pkg_id, cpu) = pkg;
-	per_cpu(logical_maps.logical_pkg_id, cpu) = new;
-	cpu_data(cpu).topo.logical_pkg_id = new;
-	return 0;
-}
-/**
- * topology_update_die_map - Update the physical to logical die map
- * @die:	The die id as retrieved via CPUID
- * @cpu:	The cpu for which this is updated
- */
-int topology_update_die_map(unsigned int die, unsigned int cpu)
-{
-	int new;
-
-	/* Already available somewhere? */
-	new = topology_phys_to_logical_die(die, cpu);
-	if (new >= 0)
-		goto found;
-
-	new = logical_die++;
-	if (new != die) {
-		pr_info("CPU %u Converting physical %u to logical die %u\n",
-			cpu, die, new);
-	}
-found:
-	per_cpu(logical_maps.phys_die_id, cpu) = die;
-	per_cpu(logical_maps.logical_die_id, cpu) = new;
-	cpu_data(cpu).topo.logical_die_id = new;
-	return 0;
-}
-
 static void __init smp_store_boot_cpu_info(void)
 {
-	int id = 0; /* CPU 0 */
-	struct cpuinfo_x86 *c = &cpu_data(id);
+	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	*c = boot_cpu_data;
-	c->cpu_index = id;
-	topology_update_package_map(c->topo.pkg_id, id);
-	topology_update_die_map(c->topo.die_id, id);
 	c->initialized = true;
 }
 

