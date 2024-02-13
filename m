Return-Path: <linux-kernel+bounces-64307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4552B853CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB7628B129
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E287CF11;
	Tue, 13 Feb 2024 21:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AMrmpUiV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eGiuLV6Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC5684FC2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858368; cv=none; b=FdfiQN8dw3WN9Y2IilcwN1RAI/ICwnfCvs29suQyZqjuvmjhYJJlt3fKLXR8RIBLeJG7kuAzF4WwtCh4TGKEgSMSvFPWhgF55Y8W0oi1y4Mt2uyvmdkZG/1WeE1Sc2m9ZocobJj+vKNrQEjA5PpQJenZisZYeFO2QT/A2tP1blc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858368; c=relaxed/simple;
	bh=/gji1ltnd85K3RSSeO+xm2HSGttvW35bsHvRZmT3Yzs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=d4ixNdsP0fmYgkCTo/hzT3cU0rT+3BvavDrM3TzdoEoZDyagxcwsoB4pD3dEdQ2Btp+eCSIAJHf4mNIDtySAZUTBfHQEnfBvZnk+N421RucesgdDy93QS0G4tjV4QzWs7tH6PErXaoElWyiIn1Rnuo064tg5uj0ss4dR39YeT6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AMrmpUiV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eGiuLV6Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210252.681709880@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=C/JTSxodC/ubcWBLJsrbomU+eWq3u3+UpltNmhF7/sw=;
	b=AMrmpUiVYBRC6xPWK+9B9+ry+7nZ2eXH4opBdTZ/o/8Vtqi5o1cgMNr8QqF7LpuRXqhCWQ
	I67AU3k4OPVwylN/UKs5L+s0IOwva7uelIFZ4G/b1V6aCfMxlGd5F40xwAUKb2gcqjjXMn
	g4bWvAlSHLbYC1njQbrxrJN6rLiLULf+uWbzmBmHx9SlcvWH1pPsmI6K8+a30PBIfL9vui
	C7KOHMCnty0nnBf/HlOq+XgHA4PHZAWreej0PLcqbQI2UaV5Pn49K1lCu7wydKxyY/xB2g
	dJ2vavpRFXJAwBpEjAPaMQV8qpfsI3ACJUifPZqvVNPnqonE9NQFX2lBra1gPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=C/JTSxodC/ubcWBLJsrbomU+eWq3u3+UpltNmhF7/sw=;
	b=eGiuLV6ZSs/Vi90K3RP76sspvIqGx0AkPUB82ycC+rH2B1BlZJOdf+J35fbqLgphL5/9kw
	mk8tTbQhoXE0SdBQ==
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
Subject: [patch 21/30] x86/cpu/topology: Use topology bitmaps for sizing
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:06:03 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Now that all possible APIC IDs are tracked in the topology bitmaps, its
trivial to retrieve the real information from there.

This gets rid of the guesstimates for the maximal packages and dies per
package as the actual numbers can be determined before a single AP has been
brought up.

The number of SMT threads can now be determined correctly from the bitmaps
in all situations. Up to now a system which has SMT disabled in the BIOS
will still claim that it is SMT capable, because the lowest APIC ID bit is
reserved for that and CPUID leaf 0xb/0x1f still enumerates the SMT domain
accordingly. By calculating the bitmap weights of the SMT and the CORE
domain and setting them into relation the SMT disabled in BIOS situation
reports correctly that the system is not SMT capable.

It also handles the situation correctly when a hybrid systems boot CPU does
not have SMT as it takes the SMT capability of the APs fully into account.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Fix the SMT capabable calculation - Rui
---
 arch/x86/include/asm/smp.h            |    3 +--
 arch/x86/include/asm/topology.h       |   23 ++++++++++++-----------
 arch/x86/kernel/cpu/common.c          |    9 ++++++---
 arch/x86/kernel/cpu/debugfs.c         |    2 +-
 arch/x86/kernel/cpu/topology.c        |   20 +++++++++++++++++++-
 arch/x86/kernel/cpu/topology_common.c |   24 ------------------------
 arch/x86/kernel/smpboot.c             |   16 ----------------
 arch/x86/xen/smp.c                    |    2 --
 8 files changed, 39 insertions(+), 60 deletions(-)
---

--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -8,7 +8,7 @@
 #include <asm/current.h>
 #include <asm/thread_info.h>
 
-extern int smp_num_siblings;
+extern unsigned int smp_num_siblings;
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
@@ -109,7 +109,6 @@ void cpu_disable_common(void);
 void native_smp_prepare_boot_cpu(void);
 void smp_prepare_cpus_common(void);
 void native_smp_prepare_cpus(unsigned int max_cpus);
-void calculate_max_logical_packages(void);
 void native_smp_cpus_done(unsigned int max_cpus);
 int common_cpu_up(unsigned int cpunum, struct task_struct *tidle);
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle);
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -143,7 +143,18 @@ extern const struct cpumask *cpu_cluster
 
 #define topology_amd_node_id(cpu)		(cpu_data(cpu).topo.amd_node_id)
 
-extern unsigned int __max_die_per_package;
+extern unsigned int __max_dies_per_package;
+extern unsigned int __max_logical_packages;
+
+static inline unsigned int topology_max_packages(void)
+{
+	return __max_logical_packages;
+}
+
+static inline unsigned int topology_max_die_per_package(void)
+{
+	return __max_dies_per_package;
+}
 
 #ifdef CONFIG_SMP
 #define topology_cluster_id(cpu)		(cpu_data(cpu).topo.l2c_id)
@@ -152,14 +163,6 @@ extern unsigned int __max_die_per_packag
 #define topology_core_cpumask(cpu)		(per_cpu(cpu_core_map, cpu))
 #define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
 
-extern unsigned int __max_logical_packages;
-#define topology_max_packages()			(__max_logical_packages)
-
-static inline int topology_max_die_per_package(void)
-{
-	return __max_die_per_package;
-}
-
 extern int __max_smt_threads;
 
 static inline int topology_max_smt_threads(void)
@@ -193,13 +196,11 @@ static inline bool topology_is_primary_t
 }
 
 #else /* CONFIG_SMP */
-#define topology_max_packages()			(1)
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
 static inline int
 topology_update_die_map(unsigned int dieid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
-static inline int topology_max_die_per_package(void) { return 1; }
 static inline int topology_max_smt_threads(void) { return 1; }
 static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 static inline unsigned int topology_amd_nodes_per_pkg(void) { return 0; };
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -73,11 +73,14 @@
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
-int smp_num_siblings = 1;
+unsigned int smp_num_siblings __ro_after_init = 1;
 EXPORT_SYMBOL(smp_num_siblings);
 
-unsigned int __max_die_per_package __read_mostly = 1;
-EXPORT_SYMBOL(__max_die_per_package);
+unsigned int __max_dies_per_package __ro_after_init = 1;
+EXPORT_SYMBOL(__max_dies_per_package);
+
+unsigned int __max_logical_packages __ro_after_init = 1;
+EXPORT_SYMBOL(__max_logical_packages);
 
 static struct ppin_info {
 	int	feature;
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -29,7 +29,7 @@ static int cpu_debug_show(struct seq_fil
 	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
 	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
 	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
-	seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
+	seq_printf(m, "max_dies_per_pkg:    %u\n", __max_dies_per_package);
 	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
 	return 0;
 }
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -348,8 +348,8 @@ void __init topology_init_possible_cpus(
 {
 	unsigned int assigned = topo_info.nr_assigned_cpus;
 	unsigned int disabled = topo_info.nr_disabled_cpus;
+	unsigned int cnta, cntb, cpu, allowed = 1;
 	unsigned int total = assigned + disabled;
-	unsigned int cpu, allowed = 1;
 	u32 apicid;
 
 	if (!restrict_to_up()) {
@@ -372,6 +372,24 @@ void __init topology_init_possible_cpus(
 	total_cpus = allowed;
 	set_nr_cpu_ids(allowed);
 
+	cnta = domain_weight(TOPO_PKG_DOMAIN);
+	cntb = domain_weight(TOPO_DIE_DOMAIN);
+	__max_logical_packages = cnta;
+	__max_dies_per_package = 1U << (get_count_order(cntb) - get_count_order(cnta));
+
+	pr_info("Max. logical packages: %3u\n", cnta);
+	pr_info("Max. logical dies:     %3u\n", cntb);
+	pr_info("Max. dies per package: %3u\n", __max_dies_per_package);
+
+	cnta = domain_weight(TOPO_CORE_DOMAIN);
+	cntb = domain_weight(TOPO_SMT_DOMAIN);
+	/*
+	 * Can't use order delta here as order(cnta) can be equal
+	 * order(cntb) even if cnta != cntb.
+	 */
+	smp_num_siblings = DIV_ROUND_UP(cntb, cnta);
+	pr_info("Max. threads per core: %3u\n", smp_num_siblings);
+
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
 	if (topo_info.nr_rejected_cpus)
 		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -196,16 +196,6 @@ void cpu_parse_topology(struct cpuinfo_x
 		       tscan.dom_shifts[dom], x86_topo_system.dom_shifts[dom]);
 	}
 
-	/* Bug compatible with the existing parsers */
-	if (tscan.dom_ncpus[TOPO_SMT_DOMAIN] > smp_num_siblings) {
-		if (system_state == SYSTEM_BOOTING) {
-			pr_warn_once("CPU%d: SMT detected and enabled late\n", cpu);
-			smp_num_siblings = tscan.dom_ncpus[TOPO_SMT_DOMAIN];
-		} else {
-			pr_warn_once("CPU%d: SMT detected after init. Too late!\n", cpu);
-		}
-	}
-
 	topo_set_ids(&tscan);
 	topo_set_max_cores(&tscan);
 }
@@ -232,20 +222,6 @@ void __init cpu_init_topology(struct cpu
 	topo_set_max_cores(&tscan);
 
 	/*
-	 * Bug compatible with the existing code. If the boot CPU does not
-	 * have SMT this ends up with one sibling. This needs way deeper
-	 * changes further down the road to get it right during early boot.
-	 */
-	smp_num_siblings = tscan.dom_ncpus[TOPO_SMT_DOMAIN];
-
-	/*
-	 * Neither it's clear whether there are as many dies as the APIC
-	 * space indicating die level is. But assume that the actual number
-	 * of CPUs gives a proper indication for now to stay bug compatible.
-	 */
-	__max_die_per_package = tscan.dom_ncpus[TOPO_DIE_DOMAIN] /
-		tscan.dom_ncpus[TOPO_DIE_DOMAIN - 1];
-	/*
 	 * AMD systems have Nodes per package which cannot be mapped to
 	 * APIC ID.
 	 */
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -139,8 +139,6 @@ static DEFINE_PER_CPU_READ_MOSTLY(struct
 	.phys_die_id	= U32_MAX,
 };
 
-unsigned int __max_logical_packages __read_mostly;
-EXPORT_SYMBOL(__max_logical_packages);
 static unsigned int logical_packages __read_mostly;
 static unsigned int logical_die __read_mostly;
 
@@ -1267,24 +1265,10 @@ void __init native_smp_prepare_boot_cpu(
 	native_pv_lock_init();
 }
 
-void __init calculate_max_logical_packages(void)
-{
-	int ncpus;
-
-	/*
-	 * Today neither Intel nor AMD support heterogeneous systems so
-	 * extrapolate the boot cpu's data to all packages.
-	 */
-	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
-	__max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
-	pr_info("Max logical packages: %u\n", __max_logical_packages);
-}
-
 void __init native_smp_cpus_done(unsigned int max_cpus)
 {
 	pr_debug("Boot done\n");
 
-	calculate_max_logical_packages();
 	build_sched_topology();
 	nmi_selftest();
 	impress_friends();
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -123,8 +123,6 @@ void __init xen_smp_cpus_done(unsigned i
 {
 	if (xen_hvm_domain())
 		native_smp_cpus_done(max_cpus);
-	else
-		calculate_max_logical_packages();
 }
 
 void xen_smp_send_reschedule(int cpu)


