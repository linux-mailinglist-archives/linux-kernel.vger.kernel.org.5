Return-Path: <linux-kernel+bounces-35368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B064838FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394D11C214C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026FA65BDF;
	Tue, 23 Jan 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vsLYsE/w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/HTN2I7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD95EE99
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015495; cv=none; b=UFJo5QrZkPqOSbAu115qgx4Kn8bcvJd1l0BmQAf1RN1r8nUQ4IdZcwUo5SY90SnX0YEasstQ/VB2ZzwEp4ekenQcvW6LtOuh8A4GZ0/qD12BwXGo9ERZTVW7Z0dXEgqI5Jak9GzPgXFUDSwffKd+uEhPoXXLzTyriJXhltzqd+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015495; c=relaxed/simple;
	bh=sdtYh6r2Z14DafjN7D+MaaZ8HLvRpnQtBgmsu94D0eQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KaTvApj7vkMKal3kxpmoHXJLKZbU/yb40XqUezAVxVYNFy+wziJOMIa+lcgQNSjnub8HUKmNualiUgR6NcTbq+ZGcubrDD0YtIU5/pa3LQD7NJGNLFwisStr1pV+lEOupLyfa43bEQOvsOSzXJvkwwYl0wp7BPumiOabkf99zzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vsLYsE/w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/HTN2I7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123649.971809766@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=l/8jC0XhRJ5zXpi1b6/tT+0MXsWhYQZ2bLtSZA+rv0E=;
	b=vsLYsE/wr+gnASvhYILxAnL1PDkW36TGAFxEEm4excXqGPauQmrdiwWIlAbr915INb/1w4
	5lylWOXbZWeIg2+Zem8AVV03kXFHEtZQpapAtDJCUQDIG0N/ZKowUHDJUWpeI8/PQfbrP7
	DggdN57qOoCSfzMwNFPUDkOHyg+v/Yx3AesUP3Lxa6oTKwG/Tamw4CKfogDIpdOhBOauSB
	NBvoum9NWJYgCSJzxXhGNQEqaOeGgEgTDHlU1OyQyB2um9A302owqHlDwHAVFmREAB9/ZQ
	UZaaASJ/+z3Jh5Wo0SoTwasP6CGfqX/o3nSjhLbGEf8HTAFphjZmtmPkN6Wk7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=l/8jC0XhRJ5zXpi1b6/tT+0MXsWhYQZ2bLtSZA+rv0E=;
	b=Q/HTN2I7emFiPUaTVJoFnbFqF+O7ITtcGhsprEkBMWPjeEobQhvYHHyoH6OTbMccGkaeJ8
	xDkYWoOa/xJ9+rCg==
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
Subject: [patch v2 25/30] x86/cpu/topology: Use topology logical mapping
 mechanism
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:30 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Replace the logical package and die management functionality and retrieve
the logical IDs from the topology bitmaps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>



---
 arch/x86/include/asm/topology.h       |   15 ++--
 arch/x86/kernel/cpu/common.c          |   13 ---
 arch/x86/kernel/cpu/topology_common.c |    4 +
 arch/x86/kernel/smpboot.c             |  111 ----------------------------------
 4 files changed, 12 insertions(+), 131 deletions(-)
---
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -172,6 +172,13 @@ static inline int topology_get_logical_i
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
@@ -181,10 +188,6 @@ static inline int topology_max_smt_threa
 
 #include <linux/cpu_smt.h>
 
-int topology_update_package_map(unsigned int apicid, unsigned int cpu);
-int topology_update_die_map(unsigned int dieid, unsigned int cpu);
-int topology_phys_to_logical_pkg(unsigned int pkg);
-
 extern unsigned int __amd_nodes_per_pkg;
 
 static inline unsigned int topology_amd_nodes_per_pkg(void)
@@ -205,10 +208,6 @@ static inline bool topology_is_primary_t
 }
 
 #else /* CONFIG_SMP */
-static inline int
-topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
-static inline int
-topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1718,18 +1718,6 @@ static void generic_identify(struct cpui
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
@@ -1913,7 +1901,6 @@ void identify_secondary_cpu(struct cpuin
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	update_package_map(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
 	if (boot_cpu_has_bug(X86_BUG_GDS))
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -10,6 +10,7 @@
 #include "cpu.h"
 
 struct x86_topology_system x86_topo_system __ro_after_init;
+EXPORT_SYMBOL_GPL(x86_topo_system);
 
 unsigned int __amd_nodes_per_pkg __ro_after_init;
 EXPORT_SYMBOL_GPL(__amd_nodes_per_pkg);
@@ -147,6 +148,9 @@ static void topo_set_ids(struct topo_sca
 	c->topo.pkg_id = topo_shift_apicid(apicid, TOPO_PKG_DOMAIN);
 	c->topo.die_id = topo_shift_apicid(apicid, TOPO_DIE_DOMAIN);
 
+	c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
+	c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+
 	/* Package relative core ID */
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
 		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
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
 
@@ -334,103 +317,11 @@ static void notrace start_secondary(void
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
 


