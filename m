Return-Path: <linux-kernel+bounces-68799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A8858087
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A222A1F214BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96716132C04;
	Fri, 16 Feb 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PYGjqzHI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHezxx1N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1EE130ACC;
	Fri, 16 Feb 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096617; cv=none; b=BB1JZ2VXxLBBUfWrrjuPg+p75YqzCq1xXgt+UWfgbKEVkZdhp/0n0thyOX5zA0Nxz6Ke1RHtAGayAz/Co/lIU5TRyduEmBKocQ70aHzYvCiIJgMqy8Ry+nQXiUuHBNKtmyxpt/nNGVtSp5GmnjpoIWlw0CGBDaZmfJW1i1jHAsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096617; c=relaxed/simple;
	bh=1c5hT4fBKSoANsCYlOu9xaG/na8kCzGK6QRtm0piWNA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nwT2KnBH3QfkbtIaiXgZLTdguaQe4uMlVos8rFCRaHx7+rfh8UTG0sX748gHMhqg9g5pR9RkKAeZayj4EiyQYeSN3Aa7aWO+4I4ljhtLM17PrnAt3KHYg2+1iw0i4sGlsVoI47KgsQCuOT8CYE6OyB4ycJDinOzzk8Q6Codf2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PYGjqzHI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHezxx1N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ram1BQLces8ccj3rOEtZ1/S6JnRizAsepkEnpTUclmE=;
	b=PYGjqzHIcs/J49HXXKXknFvFtHKIX4uJRn2KYz2SVo8Uz2yiNF0ATWUFKx1gWGcn9OtQT8
	c3c66y8rtIqkmPupH4nGIqEIcfCrbSwCMbwVnvBICrbs448WhtqVTt0V2YMrOb6+fSbLdS
	3pWV0jmxNH4Aa0C3BobzEAB5aGk44ENNyjv6cb3o03Sx6MUCibUIZP0xpynpX9RVrykIVt
	BDK2VgJctZwRSHCjkjV/irmRO0Au4/DX88uZcNomfgjMEX/8bv6ARyBlvrwyF/TefuCQ1h
	x71CMjP2pAWqrzWT73xZOgzaMDXK2OLC7+zzDEFojDZNREdT+sKXn4EvSGVbYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ram1BQLces8ccj3rOEtZ1/S6JnRizAsepkEnpTUclmE=;
	b=YHezxx1NU7/8x5HD8VQH0EANVwxDSLx1L4d6OezId9saUfKLbwre2thRBsQI6SjmSxPxyb
	2RiXw4ykzcWMvtDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Use topology bitmaps for sizing
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.681709880@linutronix.de>
References: <20240213210252.681709880@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661242.398.10126317582436561573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     090610ba704a66d7a58919be3bad195f24499ecb
Gitweb:        https://git.kernel.org/tip/090610ba704a66d7a58919be3bad195f24499ecb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:44 +01:00

x86/cpu/topology: Use topology bitmaps for sizing

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
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.681709880@linutronix.de

---
 arch/x86/include/asm/smp.h            |  3 +--
 arch/x86/include/asm/topology.h       | 23 ++++++++++++-----------
 arch/x86/kernel/cpu/common.c          |  9 ++++++---
 arch/x86/kernel/cpu/debugfs.c         |  2 +-
 arch/x86/kernel/cpu/topology.c        | 20 +++++++++++++++++++-
 arch/x86/kernel/cpu/topology_common.c | 24 ------------------------
 arch/x86/kernel/smpboot.c             | 16 ----------------
 arch/x86/xen/smp.c                    |  2 --
 8 files changed, 39 insertions(+), 60 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index f1510d6..5318470 100644
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
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 3e11a5a..94ef1a6 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -143,7 +143,18 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
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
@@ -152,14 +163,6 @@ extern unsigned int __max_die_per_package;
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
@@ -193,13 +196,11 @@ static inline bool topology_is_primary_thread(unsigned int cpu)
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b221e14..4babe3c 100644
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
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 86de544..543efc4 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -29,7 +29,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "amd_node_id:         %u\n", c->topo.amd_node_id);
 	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
 	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
-	seq_printf(m, "max_die_per_pkg:     %u\n", __max_die_per_package);
+	seq_printf(m, "max_dies_per_pkg:    %u\n", __max_dies_per_package);
 	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 07124da..630ebe5 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -348,8 +348,8 @@ void __init topology_init_possible_cpus(void)
 {
 	unsigned int assigned = topo_info.nr_assigned_cpus;
 	unsigned int disabled = topo_info.nr_disabled_cpus;
+	unsigned int cnta, cntb, cpu, allowed = 1;
 	unsigned int total = assigned + disabled;
-	unsigned int cpu, allowed = 1;
 	u32 apicid;
 
 	if (!restrict_to_up()) {
@@ -372,6 +372,24 @@ void __init topology_init_possible_cpus(void)
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
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index b0b68c8..0276978 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -196,16 +196,6 @@ void cpu_parse_topology(struct cpuinfo_x86 *c)
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
@@ -232,20 +222,6 @@ void __init cpu_init_topology(struct cpuinfo_x86 *c)
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
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 7f85f17..93470eb 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -139,8 +139,6 @@ static DEFINE_PER_CPU_READ_MOSTLY(struct logical_maps, logical_maps) = {
 	.phys_die_id	= U32_MAX,
 };
 
-unsigned int __max_logical_packages __read_mostly;
-EXPORT_SYMBOL(__max_logical_packages);
 static unsigned int logical_packages __read_mostly;
 static unsigned int logical_die __read_mostly;
 
@@ -1267,24 +1265,10 @@ void __init native_smp_prepare_boot_cpu(void)
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
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 4b0d6ff..114b362 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -123,8 +123,6 @@ void __init xen_smp_cpus_done(unsigned int max_cpus)
 {
 	if (xen_hvm_domain())
 		native_smp_cpus_done(max_cpus);
-	else
-		calculate_max_logical_packages();
 }
 
 void xen_smp_send_reschedule(int cpu)

