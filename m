Return-Path: <linux-kernel+bounces-35370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E33C838FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D0C28B936
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F6C67727;
	Tue, 23 Jan 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aEW3K2YA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="62mD8VSh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD8866B3C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015498; cv=none; b=CWIt7O5fah89WRkYL6cmGjnF/iqWoHXLq4dRXcpA9Vdhev4nbkxyn0OiJws1U3gleiRxIJ9Le0JMbZ6AdZh2OoKuX/Du/pvpb2/dnkiMCQPYHZZqR5aW2RnZUdRX+A6Wa9B2RMc0r9f9PUAXtFKRylvg2uLR0aUuOfchseMoeVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015498; c=relaxed/simple;
	bh=huGxQ3Ewzo2baC8rW+ihghAztBYkv0M3yYI9hmLu2ro=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HaBVVq0m6smz9JbSTc3aATXpRKFdTkMHexYbyUfYAqLWnmgFzrEBhnmmHU+fCyySmpdqBgtsHd96qUvVKpUbTaehv3SuqHys+EfRE0IlN2fHYfsgf6u4fHAJDAi705RdvyxOhDNGrsQXNBRLhfp+7CFzWUb87MCN2U0oucHscIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aEW3K2YA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=62mD8VSh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123650.084780415@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bfqHmBUeka7dQBa99Hi1JjEcqixFoWdCveZJ0DsGFw8=;
	b=aEW3K2YA0L5U6yZBdf7fH3Sikj4gnItzKDoUldMQ2W7IgjuVAmfyiRIUkYAlnOnosFBa6/
	qjPVcIZeiig0UgMOLVH5tfxD9zLcIlUPfD3IF6gz9drJKrLRgnf2Gsznyp942LWgb7nnVv
	u6Zpfois3phLSD+/tsgSY5CPOIdeYE7tfKAr5lo5vmOL4s/Ye6vb7zRk/CcnFLVCTWHQWv
	xey73WCdwnp3Jv+1MPiCcjBzRgAfJPs0TiSbVvBZa2Gc1CktcZJKLtZNpKSSUzhPQCuiut
	udG8xHM30bO7mtjq+GU+++EkDDhEV3PkKONb+deYKVaunCoQRpCHIuhqkMyzUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bfqHmBUeka7dQBa99Hi1JjEcqixFoWdCveZJ0DsGFw8=;
	b=62mD8VShiNiDuG+xMgN59PhRW3sDtLcRTNDnyW6Nszj1VwAJNcdP5mMD6qpwAEIFwoM8Z7
	ivWQaCEsOpu2J6Bg==
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
Subject: [patch v2 27/30] x86/cpu/topology: Rename smp_num_siblings
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:33 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

It's really a non-intuitive name. Rename it to __max_threads_per_core which
is obvious.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>



---
 arch/x86/include/asm/perf_event_p4.h |    4 ++--
 arch/x86/include/asm/smp.h           |    2 --
 arch/x86/include/asm/topology.h      |    1 +
 arch/x86/kernel/cpu/common.c         |    6 +++---
 arch/x86/kernel/cpu/debugfs.c        |    2 +-
 arch/x86/kernel/cpu/mce/inject.c     |    2 +-
 arch/x86/kernel/cpu/topology.c       |    6 +++---
 arch/x86/kernel/process.c            |    2 +-
 arch/x86/kernel/smpboot.c            |    2 +-
 9 files changed, 13 insertions(+), 14 deletions(-)
---
--- a/arch/x86/include/asm/perf_event_p4.h
+++ b/arch/x86/include/asm/perf_event_p4.h
@@ -181,7 +181,7 @@ static inline u64 p4_clear_ht_bit(u64 co
 static inline int p4_ht_active(void)
 {
 #ifdef CONFIG_SMP
-	return smp_num_siblings > 1;
+	return __max_threads_per_core > 1;
 #endif
 	return 0;
 }
@@ -189,7 +189,7 @@ static inline int p4_ht_active(void)
 static inline int p4_ht_thread(int cpu)
 {
 #ifdef CONFIG_SMP
-	if (smp_num_siblings == 2)
+	if (__max_threads_per_core == 2)
 		return cpu != cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));
 #endif
 	return 0;
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -8,8 +8,6 @@
 #include <asm/current.h>
 #include <asm/thread_info.h>
 
-extern unsigned int smp_num_siblings;
-
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_core_map);
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_die_map);
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -145,6 +145,7 @@ extern const struct cpumask *cpu_cluster
 
 extern unsigned int __max_dies_per_package;
 extern unsigned int __max_logical_packages;
+extern unsigned int __max_threads_per_core;
 
 static inline unsigned int topology_max_packages(void)
 {
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -72,8 +72,8 @@
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
-unsigned int smp_num_siblings __ro_after_init = 1;
-EXPORT_SYMBOL(smp_num_siblings);
+unsigned int __max_threads_per_core __ro_after_init = 1;
+EXPORT_SYMBOL(__max_threads_per_core);
 
 unsigned int __max_dies_per_package __ro_after_init = 1;
 EXPORT_SYMBOL(__max_dies_per_package);
@@ -2249,7 +2249,7 @@ void __init arch_cpu_finalize_init(void)
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
 	 */
-	cpu_smt_set_num_threads(smp_num_siblings, smp_num_siblings);
+	cpu_smt_set_num_threads(__max_threads_per_core, __max_threads_per_core);
 
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -30,7 +30,7 @@ static int cpu_debug_show(struct seq_fil
 	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
 	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
 	seq_printf(m, "max_dies_per_pkg:    %u\n", __max_dies_per_package);
-	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
+	seq_printf(m, "max_threads_per_core:%u\n", __max_threads_per_core);
 	return 0;
 }
 
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -433,7 +433,7 @@ static u32 get_nbc_for_node(int node_id)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 cores_per_node;
 
-	cores_per_node = (c->x86_max_cores * smp_num_siblings) / topology_amd_nodes_per_pkg();
+	cores_per_node = (c->x86_max_cores * __max_threads_per_core) / topology_amd_nodes_per_pkg();
 	return cores_per_node * node_id;
 }
 
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -76,7 +76,7 @@ bool arch_match_cpu_phys_id(int cpu, u64
 #ifdef CONFIG_SMP
 static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
-	if (!(apicid & (smp_num_siblings - 1)))
+	if (!(apicid & (__max_threads_per_core - 1)))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
 #else
@@ -417,8 +417,8 @@ void __init topology_init_possible_cpus(
 
 	cnta = domain_weight(TOPO_CORE_DOMAIN);
 	cntb = domain_weight(TOPO_SMT_DOMAIN);
-	smp_num_siblings = 1U << (get_count_order(cntb) - get_count_order(cnta));
-	pr_info("Max. threads per core: %3u\n", smp_num_siblings);
+	__max_threads_per_core = 1U << (get_count_order(cntb) - get_count_order(cnta));
+	pr_info("Max. threads per core: %3u\n", __max_threads_per_core);
 
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
 	if (topo_info.nr_rejected_cpus)
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -936,7 +936,7 @@ static __cpuidle void mwait_idle(void)
 void select_idle_routine(const struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
-	if (boot_option_idle_override == IDLE_POLL && smp_num_siblings > 1)
+	if (boot_option_idle_override == IDLE_POLL && __max_threads_per_core > 1)
 		pr_warn_once("WARNING: polling idle and HT enabled, performance may degrade\n");
 #endif
 	if (x86_idle_set() || boot_option_idle_override == IDLE_POLL)
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -563,7 +563,7 @@ static void __init build_sched_topology(
 
 void set_cpu_sibling_map(int cpu)
 {
-	bool has_smt = smp_num_siblings > 1;
+	bool has_smt = __max_threads_per_core > 1;
 	bool has_mp = has_smt || boot_cpu_data.x86_max_cores > 1;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct cpuinfo_x86 *o;


