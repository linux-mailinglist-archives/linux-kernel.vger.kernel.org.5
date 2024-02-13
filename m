Return-Path: <linux-kernel+bounces-64239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B5F853C98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5DB28594D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7909561672;
	Tue, 13 Feb 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L/Oqi+El";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ul8JJTHa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940261665
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858243; cv=none; b=QC+h7USnT4VAw05Py6bxj3S3K24NIZeHWczW+FJnKC+s4QPSsuylKCMqWFJTroxA/Ti8thTiGFiUBQbqD0h5Fs5pv/Ewo4dD8jGHT4Zyl5hXrzFku4Jok6vDBelSzlsllFQpBOFtKYjiZ7fHUDEnDt1IE7VKBfYzQ5EpOiLu/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858243; c=relaxed/simple;
	bh=LEGLmeGR7BceG3CySIyrD3+0iP6HzJS90b7Iybly928=;
	h=Message-ID:From:To:Cc:Subject:Date; b=IiC7Z1ZE9Wx6T7219VhxYc/0KXoS8mKyck0pQsuVXrr0YddUI3GgAVj0uAdAqnI3KzDMQxUQtZA9sry+ChVMbWEDsuAfZFZ1yfmEVcDTraWmVjkRF5xXPRWLs2MY3jXjoltQNdsHp5r+37DjW9YqzggMKqxyVj8N9v0A+hRxoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L/Oqi+El; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ul8JJTHa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153109.330805450@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=7YW/utTa8zFtLwTXGKG/1HXOz7BHo3EGslRnmCR1PGE=;
	b=L/Oqi+ElwLgHE8OgVkIyIG1Qyr4HjcRkFd3pYeRkFYD8RnNPK7S/t8xuqMzZ0SPZiKfopk
	pdQCTndbbjI+asSs8ZrkpCrrnx2g+9KjqJtfwN1Et5rfb40RfDdtRzVfVWeRFkSxXOdZuv
	FSERjzplSOXftZTkjDirIu/mH9ysEknlIGsGwhUxCjXgpA6n+jSv5vz5hirwho8TohO6gy
	wOWF6Uz5z5NQ4nIadgT6lrh6C0Nfz+i6LhnDiWMpGmjAXdUKTrTSg6XNixX7Mvg92wJrWK
	I1CABWHGWCMrsX1tY7570Dgc4OxSNDVs0Y1YVVc6IoJ08qea62F2twcdmeeqvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=7YW/utTa8zFtLwTXGKG/1HXOz7BHo3EGslRnmCR1PGE=;
	b=Ul8JJTHaDK1Zu0nBVzkmQXpatlAV2ISQ79kDkShNqcRrcFunBZBCtx2wN+81HNhFNtSOkp
	UwGo8PWKcB+BXBCg==
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
Subject: [patch V6 00/19] x86/cpu: Rework topology evaluation
Date: Tue, 13 Feb 2024 22:03:58 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up on V5 of this work:

  https://lore.kernel.org/all/20240117115752.863482697@linutronix.de

and contains only the not yet applied part which reworks the CPUID
parsing. This is also preparatory work for the general overhaul of APIC ID
enumeration and management.

Changes vs. V5:

  - Fix the AMD leaf 0x8000008 parsing
  - Update to generated CPUID leaf structures
  - Address review comments (coding style, comments, changelogs, boot_cpu_has())

This applies on Linus tree and is available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v6

Delta patch to V5 appended.

Thanks,

	tglx
---
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a45346ad552b..de1648ee2b9e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -705,12 +705,10 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
-extern u32 amd_get_nodes_per_socket(void);
 extern u32 amd_get_highest_perf(void);
 extern void amd_clear_divider(void);
 extern void amd_check_microcode(void);
 #else
-static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
 static inline void amd_clear_divider(void)		{ }
 static inline void amd_check_microcode(void)		{ }
diff --git a/arch/x86/kernel/cpu/topology.h b/arch/x86/kernel/cpu/topology.h
index 0d1ebb3a56e7..2a3c838b6044 100644
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -7,10 +7,10 @@ struct topo_scan {
 	unsigned int		dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int		dom_ncpus[TOPO_MAX_DOMAIN];
 
-	// Legacy CPUID[1]:EBX[23:16] number of logical processors
+	/* Legacy CPUID[1]:EBX[23:16] number of logical processors */
 	unsigned int		ebx1_nproc_shift;
 
-	// AMD specific node ID which cannot be mapped into APIC space.
+	/* AMD specific node ID which cannot be mapped into APIC space. */
 	u16			amd_nodes_per_pkg;
 	u16			amd_node_id;
 };
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 9e149673ea82..1a8b3ad493af 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -10,11 +10,12 @@
 static bool parse_8000_0008(struct topo_scan *tscan)
 {
 	struct {
-		u32	ncores		:  8,
-			__rsvd0		:  4,
-			apicidsize	:  4,
-			perftscsize	:  2,
-			__rsvd1		: 14;
+		// ecx
+		u32	cpu_nthreads		:  8, // Number of physical threads - 1
+						:  4, // Reserved
+			apicid_coreid_len	:  4, // Number of thread core ID bits (shift) in APIC ID
+			perf_tsc_len		:  2, // Performance time-stamp counter size
+						: 14; // Reserved
 	} ecx;
 	unsigned int sft;
 
@@ -23,12 +24,12 @@ static bool parse_8000_0008(struct topo_scan *tscan)
 
 	cpuid_leaf_reg(0x80000008, CPUID_ECX, &ecx);
 
-	/* If the APIC ID size is 0, then get the shift value from ecx.ncores */
-	sft = ecx.apicidsize;
+	/* If the thread bits are 0, then get the shift value from ecx.cpu_nthreads */
+	sft = ecx.apicid_coreid_len;
 	if (!sft)
-		sft = get_count_order(ecx.ncores + 1);
+		sft = get_count_order(ecx.cpu_nthreads + 1);
 
-	topology_set_dom(tscan, TOPO_CORE_DOMAIN, sft, ecx.ncores + 1);
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, sft, ecx.cpu_nthreads + 1);
 	return true;
 }
 
@@ -51,17 +52,17 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
 {
 	struct {
 		// eax
-		u32	x2apic_id	: 32;
+		u32	ext_apic_id		: 32; // Extended APIC ID
 		// ebx
-		u32	cuid		:  8,
-			threads_per_cu	:  8,
-			__rsvd0		: 16;
+		u32	core_id			:  8, // Unique per-socket logical core unit ID
+			core_nthreads		:  8, // #Threads per core (zero-based)
+						: 16; // Reserved
 		// ecx
-		u32	nodeid		:  8,
-			nodes_per_pkg	:  3,
-			__rsvd1		: 21;
+		u32	node_id			:  8, // Node (die) ID of invoking logical CPU
+			nnodes_per_socket	:  3, // #nodes in invoking logical CPU's package/socket
+						: 21; // Reserved
 		// edx
-		u32	__rsvd2		: 32;
+		u32				: 32; // Reserved
 	} leaf;
 
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
@@ -69,27 +70,27 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
 
 	cpuid_leaf(0x8000001e, &leaf);
 
-	tscan->c->topo.initial_apicid = leaf.x2apic_id;
+	tscan->c->topo.initial_apicid = leaf.ext_apic_id;
 
 	/*
 	 * If leaf 0xb is available, then SMT shift is set already. If not
-	 * take it from ecx.threads_per_cu and use topo_update_dom() -
+	 * take it from ecx.threads_per_core and use topo_update_dom() -
 	 * topology_set_dom() would propagate and overwrite the already
 	 * propagated CORE level.
 	 */
 	if (!has_0xb) {
-		unsigned int nthreads = leaf.threads_per_cu + 1;
+		unsigned int nthreads = leaf.core_nthreads + 1;
 
 		topology_update_dom(tscan, TOPO_SMT_DOMAIN, get_count_order(nthreads), nthreads);
 	}
 
-	store_node(tscan, leaf.nodes_per_pkg + 1, leaf.nodeid);
+	store_node(tscan, leaf.nnodes_per_socket + 1, leaf.node_id);
 
 	if (tscan->c->x86_vendor == X86_VENDOR_AMD) {
 		if (tscan->c->x86 == 0x15)
-			tscan->c->topo.cu_id = leaf.cuid;
+			tscan->c->topo.cu_id = leaf.core_id;
 
-		cacheinfo_amd_init_llc_id(tscan->c, leaf.nodeid);
+		cacheinfo_amd_init_llc_id(tscan->c, leaf.node_id);
 	} else {
 		/*
 		 * Package ID is ApicId[6..] on certain Hygon CPUs. See
@@ -143,7 +144,7 @@ static void parse_topology_amd(struct topo_scan *tscan)
 	 * try to get SMT and CORE shift from leaf 0xb first, then
 	 * try to get the CORE shift from leaf 0x8000_0008.
 	 */
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT))
+	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
 		has_0xb = cpu_parse_topology_ext(tscan);
 
 	if (!has_0xb && !parse_8000_0008(tscan))
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 5ff862db5a3a..afea34d59598 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -26,7 +26,7 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 	}
 }
 
-static unsigned int parse_num_cores(struct cpuinfo_x86 *c)
+static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
 {
 	struct {
 		u32	cache_type	:  5,
@@ -49,7 +49,7 @@ static void parse_legacy(struct topo_scan *tscan)
 	unsigned int cores, core_shift, smt_shift = 0;
 	struct cpuinfo_x86 *c = tscan->c;
 
-	cores = parse_num_cores(c);
+	cores = parse_num_cores_legacy(c);
 	core_shift = get_count_order(cores);
 
 	if (cpu_has(c, X86_FEATURE_HT)) {
@@ -97,7 +97,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	c->topo = topo_defaults;
 
 	if (fake_topology(tscan))
-	    return;
+		return;
 
 	/* Preset Initial APIC ID from CPUID leaf 1 */
 	cpuid_leaf_reg(1, CPUID_EBX, &ebx);
diff --git a/arch/x86/kernel/cpu/topology_ext.c b/arch/x86/kernel/cpu/topology_ext.c
index b9b37296d9cd..e477228cd5b2 100644
--- a/arch/x86/kernel/cpu/topology_ext.c
+++ b/arch/x86/kernel/cpu/topology_ext.c
@@ -110,7 +110,7 @@ static bool parse_topology_leaf(struct topo_scan *tscan, u32 leaf)
 	if (!tscan->dom_shifts[TOPO_SMT_DOMAIN] && tscan->dom_ncpus[TOPO_SMT_DOMAIN] > 1) {
 		unsigned int sft = get_count_order(tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
 
-		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf 0 has shift level 0 but %u CPUs\n",
+		pr_warn_once(FW_BUG "CPUID leaf 0x%x subleaf 0 has shift level 0 but %u CPUs. Fixing it up.\n",
 			     leaf, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
 		topology_update_dom(tscan, TOPO_SMT_DOMAIN, sft, tscan->dom_ncpus[TOPO_SMT_DOMAIN]);
 	}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 2634f8f82867..9cdb056c37b5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -513,7 +513,7 @@ static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 	if (c->topo.pkg_id != o->topo.pkg_id || c->topo.die_id != o->topo.die_id)
 		return false;
 
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT) && topology_amd_nodes_per_pkg() > 1)
+	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT) && topology_amd_nodes_per_pkg() > 1)
 		return c->topo.amd_node_id == o->topo.amd_node_id;
 
 	return true;


