Return-Path: <linux-kernel+bounces-68793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C73858079
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C791F22BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8274212FF60;
	Fri, 16 Feb 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X277VlUu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXjxToFi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB012F597;
	Fri, 16 Feb 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096612; cv=none; b=C3ugR98DkLKHH/fT9D62J1yp/GeWFGEKzHZ9eOl9icb7kKqL53IiiESeix8AXM1XqzeypGSG/XvA3XsjAJm6wDCxiB38Ui6zkYY1f+dyxLD4zys0TaE19H8OJvDI/E++rqnWOBBdFKB20c1uz/A20H/QaFtHqWCs4ruqfg5ucBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096612; c=relaxed/simple;
	bh=4KdG1Y8DNrBn3fOMd71zm51Q4hWGIMNsM3t9YD2iGYM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O4dZoyebXxSYvCEtpOXX3mJUJLmNe7+GfjGTYbk6PYSYDUJkBu43sS62yE46qKXjnl2vd82lB+DhmyQF/2EJ7YInOYrnG3kJIXzfu10fS2OB0H7yVhiN6/OVZg5IgSbeqpuRmMQucQpCtiUHLF74SQufdIE5oFwY6X417IPr38E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X277VlUu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXjxToFi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHhfm1rR51hsc4xosPAGa4eETXSqty/nCTucvdN83do=;
	b=X277VlUufDKDQsYuZn4j7uptyPrVxzujBN/jUcAvtNXvfyb1REV4vaF/bygfTFZyp/C+vQ
	kzHCZ+JMl07FMRLt54lbod8bHuGWxYOLyRVNC0aUVdCYlyuvjbhr+KmSh+2DzpmM+h0HBT
	2Ex5KuOY8BdPz4mCjfqpfG3NZDLJC4MKlGMPg3Ag7/qVBP2nErIqyqqGX/hotAZ9WbHv3J
	nZXVQWiQpI8bv3jO2mNTUWZaBTK6K8sD9y8vx6/Gb4EStQ72Uwzd3MuE/HV1eqDpse6/KN
	6S1dx4ullbA3j+IVm+5CmnBpqcFNi9DaQJmkRG5N6jfzplAXG+IMI1qZ3huNwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHhfm1rR51hsc4xosPAGa4eETXSqty/nCTucvdN83do=;
	b=OXjxToFieNxsq11ZqefnGaTW8IupJdQVeAl+/P3LoCv5CQLtGsHwrjgvam21r8mJY9/pBv
	3GV6kmoLrDmMisDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Rename smp_num_siblings
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210253.011307973@linutronix.de>
References: <20240213210253.011307973@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809660736.398.12725424821441311151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     8078f4d6102f9370b3b7436d25717735d21f5c09
Gitweb:        https://git.kernel.org/tip/8078f4d6102f9370b3b7436d25717735d21f5c09
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:45 +01:00

x86/cpu/topology: Rename smp_num_siblings

It's really a non-intuitive name. Rename it to __max_threads_per_core which
is obvious.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210253.011307973@linutronix.de





---
 arch/x86/include/asm/perf_event_p4.h | 4 ++--
 arch/x86/include/asm/smp.h           | 2 --
 arch/x86/include/asm/topology.h      | 1 +
 arch/x86/kernel/cpu/common.c         | 6 +++---
 arch/x86/kernel/cpu/debugfs.c        | 2 +-
 arch/x86/kernel/cpu/mce/inject.c     | 2 +-
 arch/x86/kernel/cpu/topology.c       | 6 +++---
 arch/x86/kernel/process.c            | 2 +-
 arch/x86/kernel/smpboot.c            | 2 +-
 9 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/perf_event_p4.h b/arch/x86/include/asm/perf_event_p4.h
index 94de1a0..d65e338 100644
--- a/arch/x86/include/asm/perf_event_p4.h
+++ b/arch/x86/include/asm/perf_event_p4.h
@@ -181,7 +181,7 @@ static inline u64 p4_clear_ht_bit(u64 config)
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
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 5318470..54d6d71 100644
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
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 5ce06f3..f9eb7a7 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -145,6 +145,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
 extern unsigned int __max_dies_per_package;
 extern unsigned int __max_logical_packages;
+extern unsigned int __max_threads_per_core;
 
 static inline unsigned int topology_max_packages(void)
 {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 58f9cc7..cb22cb8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -73,8 +73,8 @@
 u32 elf_hwcap2 __read_mostly;
 
 /* Number of siblings per CPU package */
-unsigned int smp_num_siblings __ro_after_init = 1;
-EXPORT_SYMBOL(smp_num_siblings);
+unsigned int __max_threads_per_core __ro_after_init = 1;
+EXPORT_SYMBOL(__max_threads_per_core);
 
 unsigned int __max_dies_per_package __ro_after_init = 1;
 EXPORT_SYMBOL(__max_dies_per_package);
@@ -2251,7 +2251,7 @@ void __init arch_cpu_finalize_init(void)
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
 	 */
-	cpu_smt_set_num_threads(smp_num_siblings, smp_num_siblings);
+	cpu_smt_set_num_threads(__max_threads_per_core, __max_threads_per_core);
 
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 543efc4..f40f3ee 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -30,7 +30,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "amd_nodes_per_pkg:   %u\n", topology_amd_nodes_per_pkg());
 	seq_printf(m, "max_cores:           %u\n", c->x86_max_cores);
 	seq_printf(m, "max_dies_per_pkg:    %u\n", __max_dies_per_package);
-	seq_printf(m, "smp_num_siblings:    %u\n", smp_num_siblings);
+	seq_printf(m, "max_threads_per_core:%u\n", __max_threads_per_core);
 	return 0;
 }
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 2b29045..1e32788 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -433,7 +433,7 @@ static u32 get_nbc_for_node(int node_id)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 cores_per_node;
 
-	cores_per_node = (c->x86_max_cores * smp_num_siblings) / topology_amd_nodes_per_pkg();
+	cores_per_node = (c->x86_max_cores * __max_threads_per_core) / topology_amd_nodes_per_pkg();
 	return cores_per_node * node_id;
 }
 
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 7db9df5..b078fac 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -76,7 +76,7 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 #ifdef CONFIG_SMP
 static void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid)
 {
-	if (!(apicid & (smp_num_siblings - 1)))
+	if (!(apicid & (__max_threads_per_core - 1)))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
 #else
@@ -429,8 +429,8 @@ void __init topology_init_possible_cpus(void)
 	 * Can't use order delta here as order(cnta) can be equal
 	 * order(cntb) even if cnta != cntb.
 	 */
-	smp_num_siblings = DIV_ROUND_UP(cntb, cnta);
-	pr_info("Max. threads per core: %3u\n", smp_num_siblings);
+	__max_threads_per_core = DIV_ROUND_UP(cntb, cnta);
+	pr_info("Max. threads per core: %3u\n", __max_threads_per_core);
 
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
 	if (topo_info.nr_rejected_cpus)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade..6121c2b 100644
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
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9ade685..35c272c 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -563,7 +563,7 @@ static void __init build_sched_topology(void)
 
 void set_cpu_sibling_map(int cpu)
 {
-	bool has_smt = smp_num_siblings > 1;
+	bool has_smt = __max_threads_per_core > 1;
 	bool has_mp = has_smt || boot_cpu_data.x86_max_cores > 1;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct cpuinfo_x86 *o;

