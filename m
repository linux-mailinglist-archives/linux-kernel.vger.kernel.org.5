Return-Path: <linux-kernel+bounces-68850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4498580F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49B82823F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E8F152DED;
	Fri, 16 Feb 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFD0pqJ9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7Y/CYdg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EEE14AD09;
	Fri, 16 Feb 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096654; cv=none; b=lCjajM73nvmh8pHJyPUO6D43/+BONEQuPL7/vjQRR3JELKGHZabhYs7AE4Ufjsis42ds0pPKZ75OtsUjsU2L4hTyneA4kNFsT1W/gHIoxEYP5IW6PXqBVXckus8iMBdvvD+tzJ+Zuo2kLxUSlfCq0ndjY2QuFjAnZvg2Z+AzjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096654; c=relaxed/simple;
	bh=E58xVfPvdQr7VaG7TQWfM1Rs4wtXj/DxlMk2og1cDzA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EbKz//gO3bQqfEP572VyIHQjqCSh7/BSmlkC3OR6p6RMYIuD0kFdBCT7oRjwFchjLGstI5Et4jC3IoziiH0ab4axkpEv02JUQDjH8U9lDss2xhjCT62J4QWYIP0Z9NtBfa2ncYt0UXIBH9BKPyg4v9v29XEUleSUgL/4OCIFQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFD0pqJ9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7Y/CYdg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOhC/54VzclbaZSTJZp/YSL+UpEFnVQ50brKf25OAGs=;
	b=PFD0pqJ9S3hxDTVDS5OAo2lz2ZtxAakl4pv+xC7e1uKBM2Pu3CNGYFI3ksAUC7tEfW4Dj7
	Kn0JtDbEuzFh0H39Pwt2QKIZA7Y2Kgi53QhWo0dK+SrU+W9+lpOHn25Ttom1L9yWBxJRIC
	4mhPo2uuFpJW7KtzaUtqmTd2kx9Rnj5D/56VL3wrcCLKZ32W16GXDTuNOlaHTHuvPxlKjb
	5sVnaYpSYv/d9R1/NXK6AfujMSel+jz+YryIBf09kX5KKOrPYLaxvWldGt06R1nPGQlLiv
	TQLSHBzZ5faCf+1XZw7IqpWr5do28GqTlywdI0xQcuz8OosWpbSOz2Sof91fwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOhC/54VzclbaZSTJZp/YSL+UpEFnVQ50brKf25OAGs=;
	b=t7Y/CYdg/0SC91B5F5tjxswzjtW1Pal9UdLcctNIE13BLuedm+a9DjdpOj3qi5ttyHjSbb
	cMuYL2jykkgcdODA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Use common topology code for AMD
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153625.145745053@linutronix.de>
References: <20240212153625.145745053@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664983.398.16511991779716353329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     c749ce393b8fe9db5ed894411f06eafa88f0e13a
Gitweb:        https://git.kernel.org/tip/c749ce393b8fe9db5ed894411f06eafa88f0e13a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:38 +01:00

x86/cpu: Use common topology code for AMD

Switch it over to the new topology evaluation mechanism and remove the
random bits and pieces which are sprinkled all over the place.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153625.145745053@linutronix.de

---
 arch/x86/include/asm/processor.h      |   2 +-
 arch/x86/kernel/cpu/amd.c             | 146 +-------------------------
 arch/x86/kernel/cpu/mce/inject.c      |   3 +-
 arch/x86/kernel/cpu/topology_common.c |   5 +-
 4 files changed, 5 insertions(+), 151 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 26a6001..4fbeffd 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -707,12 +707,10 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
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
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a6b5820..c82069e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -27,13 +27,6 @@
 
 #include "cpu.h"
 
-/*
- * nodes_per_socket: Stores the number of nodes per socket.
- * Refer to Fam15h Models 00-0fh BKDG - CPUID Fn8000_001E_ECX
- * Node Identifiers[10:8]
- */
-static u32 nodes_per_socket = 1;
-
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] = { 0 };
@@ -300,97 +293,6 @@ static int nearby_node(int apicid)
 }
 #endif
 
-/*
- * Fix up topo::core_id for pre-F17h systems to be in the
- * [0 .. cores_per_node - 1] range. Not really needed but
- * kept so as not to break existing setups.
- */
-static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
-{
-	u32 cus_per_node;
-
-	if (c->x86 >= 0x17)
-		return;
-
-	cus_per_node = c->x86_max_cores / nodes_per_socket;
-	c->topo.core_id %= cus_per_node;
-}
-
-/*
- * Fixup core topology information for
- * (1) AMD multi-node processors
- *     Assumption: Number of cores in each internal node is the same.
- * (2) AMD processors supporting compute units
- */
-static void amd_get_topology(struct cpuinfo_x86 *c)
-{
-	/* get information required for multi-node processors */
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		int err;
-		u32 eax, ebx, ecx, edx;
-
-		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
-
-		c->topo.die_id  = ecx & 0xff;
-
-		if (c->x86 == 0x15)
-			c->topo.cu_id = ebx & 0xff;
-
-		if (c->x86 >= 0x17) {
-			c->topo.core_id = ebx & 0xff;
-
-			if (smp_num_siblings > 1)
-				c->x86_max_cores /= smp_num_siblings;
-		}
-
-		/*
-		 * In case leaf B is available, use it to derive
-		 * topology information.
-		 */
-		err = detect_extended_topology(c);
-		if (!err)
-			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
-
-		cacheinfo_amd_init_llc_id(c, c->topo.die_id);
-
-	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->topo.die_id = value & 7;
-		c->topo.llc_id = c->topo.die_id;
-	} else
-		return;
-
-	if (nodes_per_socket > 1) {
-		set_cpu_cap(c, X86_FEATURE_AMD_DCM);
-		legacy_fixup_core_id(c);
-	}
-}
-
-/*
- * On a AMD dual core setup the lower bits of the APIC id distinguish the cores.
- * Assumes number of cores is a power of two.
- */
-static void amd_detect_cmp(struct cpuinfo_x86 *c)
-{
-	unsigned bits;
-
-	bits = c->x86_coreid_bits;
-	/* Low order bits define the core id (index of core in socket) */
-	c->topo.core_id = c->topo.initial_apicid & ((1 << bits)-1);
-	/* Convert the initial APIC ID into the socket ID */
-	c->topo.pkg_id = c->topo.initial_apicid >> bits;
-	/* use socket ID also for last level cache */
-	c->topo.llc_id = c->topo.die_id = c->topo.pkg_id;
-}
-
-u32 amd_get_nodes_per_socket(void)
-{
-	return nodes_per_socket;
-}
-EXPORT_SYMBOL_GPL(amd_get_nodes_per_socket);
-
 static void srat_detect_node(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_NUMA
@@ -442,32 +344,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void early_init_amd_mc(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned bits, ecx;
-
-	/* Multi core CPU? */
-	if (c->extended_cpuid_level < 0x80000008)
-		return;
-
-	ecx = cpuid_ecx(0x80000008);
-
-	c->x86_max_cores = (ecx & 0xff) + 1;
-
-	/* CPU telling us the core id bits shift? */
-	bits = (ecx >> 12) & 0xF;
-
-	/* Otherwise recompute */
-	if (bits == 0) {
-		while ((1 << bits) < c->x86_max_cores)
-			bits++;
-	}
-
-	c->x86_coreid_bits = bits;
-#endif
-}
-
 static void bsp_init_amd(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
@@ -500,18 +376,6 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_MWAITX))
 		use_mwaitx_delay();
 
-	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		u32 ecx;
-
-		ecx = cpuid_ecx(0x8000001e);
-		__max_die_per_package = nodes_per_socket = ((ecx >> 8) & 7) + 1;
-	} else if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		__max_die_per_package = nodes_per_socket = ((value >> 3) & 7) + 1;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
 	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD) &&
 	    c->x86 >= 0x15 && c->x86 <= 0x17) {
@@ -649,8 +513,6 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	u64 value;
 	u32 dummy;
 
-	early_init_amd_mc(c);
-
 	if (c->x86 >= 0xf)
 		set_cpu_cap(c, X86_FEATURE_K8);
 
@@ -730,9 +592,6 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 		}
 	}
 
-	if (cpu_has(c, X86_FEATURE_TOPOEXT))
-		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
 		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
@@ -1076,9 +935,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_FSRM))
 		set_cpu_cap(c, X86_FEATURE_FSRS);
 
-	/* get apicid instead of initial apic id from cpuid */
-	c->topo.apicid = read_apic_id();
-
 	/* K6s reports MCEs but don't actually have all the MSRs */
 	if (c->x86 < 6)
 		clear_cpu_cap(c, X86_FEATURE_MCE);
@@ -1114,8 +970,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	cpu_detect_cache_sizes(c);
 
-	amd_detect_cmp(c);
-	amd_get_topology(c);
 	srat_detect_node(c);
 
 	init_amd_cacheinfo(c);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 308c5b5..2b29045 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -433,8 +433,7 @@ static u32 get_nbc_for_node(int node_id)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 cores_per_node;
 
-	cores_per_node = (c->x86_max_cores * smp_num_siblings) / amd_get_nodes_per_socket();
-
+	cores_per_node = (c->x86_max_cores * smp_num_siblings) / topology_amd_nodes_per_pkg();
 	return cores_per_node * node_id;
 }
 
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index e1d1a7b..3c69229 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -72,7 +72,6 @@ bool topo_is_converted(struct cpuinfo_x86 *c)
 {
 	/* Temporary until everything is converted over. */
 	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_AMD:
 	case X86_VENDOR_HYGON:
 		return false;
 	default:
@@ -133,6 +132,10 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
 
 	switch (c->x86_vendor) {
+	case X86_VENDOR_AMD:
+		if (IS_ENABLED(CONFIG_CPU_SUP_AMD))
+			cpu_parse_topology_amd(tscan);
+		break;
 	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_ZHAOXIN:
 		parse_legacy(tscan);

