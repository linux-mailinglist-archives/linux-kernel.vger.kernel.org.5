Return-Path: <linux-kernel+bounces-68854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B398580FE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9112840DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A79115350B;
	Fri, 16 Feb 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MtO/3l1W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wQAMJEvN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F008412F58D;
	Fri, 16 Feb 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096657; cv=none; b=blE7SYTxgfaWUBVRgSE+kVy4gvsz9sBHOps9JqK7LmdO05O303qvnWTscfC7mNJusifzAigG6pYkZK0x8GkDgUXkSA9Lr/4Ph3PAkcdMdiNK9lLPL+mmpTAVq6Kz3zhOFa9EL9B9ML/HR9EDU38ReEc5/i/OCmKcZXC4Xou5gxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096657; c=relaxed/simple;
	bh=jnqSJHfslrhBICGWzcvHFv6dAd+zriQJlUn1mRadoO4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fF5FVkpDH3Cavnq6UQiqCNz4jEmIgTC4j+upG/Ple+WsQ1D6xL3n5/xj0uKoupomJ6VFiTp3RzPQQ5IW9BIjwivJtLy5NMMWvGjtlzL+lcU3SjDu5bdVL/9HYRdQveruA9S9UBNMPKerBmtlREm2+2FOPdLtTmwCifedElW3wME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MtO/3l1W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wQAMJEvN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuZXgZgQMOpdkqba2wH7n65otQ5gnBTZw1k2QEi7uTE=;
	b=MtO/3l1WuaruZh855tsQAJ3ITvi8rsf8J29ROckYZIbN4pjLYcbKz/A8ATnTM100hFGOj5
	ODFCiAHNIV/Jsr2tD3r9Ym0fKajUTonIL6easktJj0usZ4g7x7bjmz+M0EtqrUsC+kIDtJ
	VuN0lg8BJ+DYX7JvrSIMutHg4eE16ygxWjVXwUEBiq53pPpJFSsaHiiOCh03sa1J5joR3b
	PVf6oZFZd/1WuCquFd6yeaUNH3WydRGKo02IvHAri3G6KNAAYwB8DDPmhcx3fQQ7ADDEHp
	C1/JKiGMcMDTfHEFhUGof3Y9WiXQLhkyhytn3a3ezxbw6uktAWa32B5US3Wx8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuZXgZgQMOpdkqba2wH7n65otQ5gnBTZw1k2QEi7uTE=;
	b=wQAMJEvNqYKYzzUb381gObhnaRpU/Sba7eii+FakTdrRkzlP0ZuuxuXYYR/EwgOfcFthEn
	w9QryW6RbNvnWcBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Use common topology code for Intel
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153624.893644349@linutronix.de>
References: <20240212153624.893644349@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809665247.398.8018173860044927428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     22d63660c35eb751c63a709bf901a64c1726592a
Gitweb:        https://git.kernel.org/tip/22d63660c35eb751c63a709bf901a64c1726592a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:37 +01:00

x86/cpu: Use common topology code for Intel

Intel CPUs use either topology leaf 0xb/0x1f evaluation or the legacy
SMP/HT evaluation based on CPUID leaf 0x1/0x4.

Move it over to the consolidated topology code and remove the random
topology hacks which are sprinkled into the Intel and the common code.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153624.893644349@linutronix.de

---
 arch/x86/kernel/cpu/common.c          | 65 +--------------------------
 arch/x86/kernel/cpu/cpu.h             |  4 +--
 arch/x86/kernel/cpu/intel.c           | 25 +----------
 arch/x86/kernel/cpu/topology.c        | 22 +---------
 arch/x86/kernel/cpu/topology_common.c |  5 +-
 5 files changed, 4 insertions(+), 117 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 5d7911f..f83dd86 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -793,19 +793,6 @@ static void get_model_name(struct cpuinfo_x86 *c)
 	*(s + 1) = '\0';
 }
 
-void detect_num_cpu_cores(struct cpuinfo_x86 *c)
-{
-	unsigned int eax, ebx, ecx, edx;
-
-	c->x86_max_cores = 1;
-	if (!IS_ENABLED(CONFIG_SMP) || c->cpuid_level < 4)
-		return;
-
-	cpuid_count(4, 0, &eax, &ebx, &ecx, &edx);
-	if (eax & 0x1f)
-		c->x86_max_cores = (eax >> 26) + 1;
-}
-
 void cpu_detect_cache_sizes(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, ebx, ecx, edx, l2size;
@@ -867,54 +854,6 @@ static void cpu_detect_tlb(struct cpuinfo_x86 *c)
 		tlb_lld_4m[ENTRIES], tlb_lld_1g[ENTRIES]);
 }
 
-int detect_ht_early(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	u32 eax, ebx, ecx, edx;
-
-	if (!cpu_has(c, X86_FEATURE_HT))
-		return -1;
-
-	if (cpu_has(c, X86_FEATURE_CMP_LEGACY))
-		return -1;
-
-	if (cpu_has(c, X86_FEATURE_XTOPOLOGY))
-		return -1;
-
-	cpuid(1, &eax, &ebx, &ecx, &edx);
-
-	smp_num_siblings = (ebx & 0xff0000) >> 16;
-	if (smp_num_siblings == 1)
-		pr_info_once("CPU0: Hyper-Threading is disabled\n");
-#endif
-	return 0;
-}
-
-void detect_ht(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	int index_msb, core_bits;
-
-	if (topo_is_converted(c))
-		return;
-
-	if (detect_ht_early(c) < 0)
-		return;
-
-	index_msb = get_count_order(smp_num_siblings);
-	c->topo.pkg_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb);
-
-	smp_num_siblings = smp_num_siblings / c->x86_max_cores;
-
-	index_msb = get_count_order(smp_num_siblings);
-
-	core_bits = get_count_order(c->x86_max_cores);
-
-	c->topo.core_id = apic->phys_pkg_id(c->topo.initial_apicid, index_msb) &
-		((1 << core_bits) - 1);
-#endif
-}
-
 static void get_cpu_vendor(struct cpuinfo_x86 *c)
 {
 	char *v = c->x86_vendor_id;
@@ -1899,10 +1838,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 				c->x86, c->x86_model);
 	}
 
-#ifdef CONFIG_X86_64
-	detect_ht(c);
-#endif
-
 	x86_init_rdrand(c);
 	setup_pku(c);
 	setup_cet(c);
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 2a446ec..5a790f1 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -76,11 +76,7 @@ extern void init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
 
-extern void detect_num_cpu_cores(struct cpuinfo_x86 *c);
-extern int detect_extended_topology_early(struct cpuinfo_x86 *c);
 extern int detect_extended_topology(struct cpuinfo_x86 *c);
-extern int detect_ht_early(struct cpuinfo_x86 *c);
-extern void detect_ht(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a927a8f..1bb37a6 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -315,13 +315,6 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	}
 
 	check_memory_type_self_snoop_errata(c);
-
-	/*
-	 * Get the number of SMT siblings early from the extended topology
-	 * leaf, if available. Otherwise try the legacy SMT detection.
-	 */
-	if (detect_extended_topology_early(c) < 0)
-		detect_ht_early(c);
 }
 
 static void bsp_init_intel(struct cpuinfo_x86 *c)
@@ -603,24 +596,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	intel_workarounds(c);
 
-	/*
-	 * Detect the extended topology information if available. This
-	 * will reinitialise the initial_apicid which will be used
-	 * in init_intel_cacheinfo()
-	 */
-	detect_extended_topology(c);
-
-	if (!cpu_has(c, X86_FEATURE_XTOPOLOGY)) {
-		/*
-		 * let's use the legacy cpuid vector 0x1 and 0x4 for topology
-		 * detection.
-		 */
-		detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-		detect_ht(c);
-#endif
-	}
-
 	init_intel_cacheinfo(c);
 
 	if (c->cpuid_level > 9) {
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 208e17a..2b68f26 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -59,28 +59,6 @@ static int detect_extended_topology_leaf(struct cpuinfo_x86 *c)
 }
 #endif
 
-int detect_extended_topology_early(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int eax, ebx, ecx, edx;
-	int leaf;
-
-	leaf = detect_extended_topology_leaf(c);
-	if (leaf < 0)
-		return -1;
-
-	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
-
-	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
-	/*
-	 * initial apic id, which also represents 32-bit extended x2apic id.
-	 */
-	c->topo.initial_apicid = edx;
-	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
-#endif
-	return 0;
-}
-
 /*
  * Check for extended topology enumeration cpuid leaf, and if it
  * exists, use it for populating initial_apicid and cpu topology
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index bcaaeec..ef99499 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -71,7 +71,6 @@ bool topo_is_converted(struct cpuinfo_x86 *c)
 	/* Temporary until everything is converted over. */
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-	case X86_VENDOR_INTEL:
 	case X86_VENDOR_HYGON:
 		return false;
 	default:
@@ -136,6 +135,10 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	case X86_VENDOR_ZHAOXIN:
 		parse_legacy(tscan);
 		break;
+	case X86_VENDOR_INTEL:
+		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
+			parse_legacy(tscan);
+		break;
 	}
 }
 

