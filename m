Return-Path: <linux-kernel+bounces-35276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BB0838EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18FB71F21119
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38918604BF;
	Tue, 23 Jan 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D9YClnhu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uV86SOWc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EB60262
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014433; cv=none; b=BQ9Tu6wiTqc2FNK7K0j6svRWpDo5foj70rFFb9ilScxNwJ4WDInXrJfemUecpVq9n2VODMvUQhctzfGyuzmZvpvFM039UAoiGahqaXJxzyq1kinE4zPtBiOn3ctZE8wmq9yxMgsXeXPX/hi9R9P+K9OjCS5ds57hcP+I0w9pONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014433; c=relaxed/simple;
	bh=JYHySPxDxbbQ1dAyZE9gW4hdS/x411phGfCs/lBQi7A=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jp/VLf5SAGbwkJMG8AebeizrjTNVeNKaV0lPpDEZd+NKRWnLU6EXNcQMl/Ez5Klo9wYylctE4rey/UNM14TbeOos/Cpa0ip8LNXVaAca6i4ekrubgRfkg8aFnFpSZv/eHPgqvGQK3YzuiuGbvHIkiFx9RzqsnC7kGNFJgTlrZ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D9YClnhu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uV86SOWc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115909.076756744@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FUb7TfZsW/Y7E45ham8xFseu7lZDcdhrgEftbSxG8OU=;
	b=D9YClnhuu/15t5cbj1i8r0S8f7DiIWvj18M4ubqOyBgb7+pAG/RkqSncCVCnqeIZye+9o2
	VcTalxQE2MIqHi33uEfBd2AQF9zC9e1fO1/XFc2QCrA4NI3CeQiW+L/7GD9UQ/Xmb3fSoB
	tI+w7VTpA2MjcfwN18rCU6Lc9ldeZbWlGMlsMgDec8HKIMPRVWYa+uVJS+NW3wxOvg2MN/
	gBByKbRV3mprc1dnnGuUuHwekuaR1utYpfbv+ZCDGzjPeg0DxvPhMGqN2fi9Hf0Fm5qFpq
	nBNjsKNaH0bCR0jd1hcRFDAi3XbAOP7cmWerrx5TEv3liyiz/ZunpziamKF/Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FUb7TfZsW/Y7E45ham8xFseu7lZDcdhrgEftbSxG8OU=;
	b=uV86SOWc0DlEqela4+4iWBd7FBmqFYhzugfgzDnYLYcDSZqTA3ZOaZG/LaJdRnUzJ3KKA9
	286NFWQxYE++bNCQ==
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
Subject: [patch v5 12/19] x86/cpu: Use common topology code for HYGON
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:48 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Switch it over to use the consolidated topology evaluation and remove the
temporary safe guards which are not longer needed.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


---
 arch/x86/kernel/cpu/common.c          |    5 -
 arch/x86/kernel/cpu/cpu.h             |    1 
 arch/x86/kernel/cpu/hygon.c           |  129 ----------------------------------
 arch/x86/kernel/cpu/topology.h        |    1 
 arch/x86/kernel/cpu/topology_common.c |   22 +----
 5 files changed, 4 insertions(+), 154 deletions(-)
---
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1779,11 +1779,6 @@ static void identify_cpu(struct cpuinfo_
 	/* Clear/Set all flags overridden by options, after probe */
 	apply_forced_caps(c);
 
-#ifdef CONFIG_X86_64
-	if (!topo_is_converted(c))
-		c->topo.apicid = apic->phys_pkg_id(c->topo.initial_apicid, 0);
-#endif
-
 	/*
 	 * Set default APIC and TSC_DEADLINE MSR fencing flag. AMD and
 	 * Hygon will clear it in ->c_init() below.
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -76,7 +76,6 @@ extern void init_intel_cacheinfo(struct
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
 
-extern int detect_extended_topology(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u16 die_id);
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -18,14 +18,6 @@
 
 #include "cpu.h"
 
-#define APICID_SOCKET_ID_BIT 6
-
-/*
- * nodes_per_socket: Stores the number of nodes per socket.
- * Refer to CPUID Fn8000_001E_ECX Node Identifiers[10:8]
- */
-static u32 nodes_per_socket = 1;
-
 #ifdef CONFIG_NUMA
 /*
  * To workaround broken NUMA config.  Read the comment in
@@ -49,80 +41,6 @@ static int nearby_node(int apicid)
 }
 #endif
 
-static void hygon_get_topology_early(struct cpuinfo_x86 *c)
-{
-	if (cpu_has(c, X86_FEATURE_TOPOEXT))
-		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
-}
-
-/*
- * Fixup core topology information for
- * (1) Hygon multi-node processors
- *     Assumption: Number of cores in each internal node is the same.
- * (2) Hygon processors supporting compute units
- */
-static void hygon_get_topology(struct cpuinfo_x86 *c)
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
-		c->topo.core_id = ebx & 0xff;
-
-		if (smp_num_siblings > 1)
-			c->x86_max_cores /= smp_num_siblings;
-
-		/*
-		 * In case leaf B is available, use it to derive
-		 * topology information.
-		 */
-		err = detect_extended_topology(c);
-		if (!err)
-			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
-
-		/*
-		 * Socket ID is ApicId[6] for the processors with model <= 0x3
-		 * when running on host.
-		 */
-		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR) && c->x86_model <= 0x3)
-			c->topo.pkg_id = c->topo.apicid >> APICID_SOCKET_ID_BIT;
-
-		cacheinfo_hygon_init_llc_id(c);
-	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
-		u64 value;
-
-		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		c->topo.die_id = value & 7;
-		c->topo.llc_id = c->topo.die_id;
-	} else
-		return;
-
-	if (nodes_per_socket > 1)
-		set_cpu_cap(c, X86_FEATURE_AMD_DCM);
-}
-
-/*
- * On Hygon setup the lower bits of the APIC id distinguish the cores.
- * Assumes number of cores is a power of two.
- */
-static void hygon_detect_cmp(struct cpuinfo_x86 *c)
-{
-	unsigned int bits;
-
-	bits = c->x86_coreid_bits;
-	/* Low order bits define the core id (index of core in socket) */
-	c->topo.core_id = c->topo.initial_apicid & ((1 << bits)-1);
-	/* Convert the initial APIC ID into the socket ID */
-	c->topo.pkg_id = c->topo.initial_apicid >> bits;
-	/* Use package ID also for last level cache */
-	c->topo.llc_id = c->topo.die_id = c->topo.pkg_id;
-}
-
 static void srat_detect_node(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_NUMA
@@ -173,32 +91,6 @@ static void srat_detect_node(struct cpui
 #endif
 }
 
-static void early_init_hygon_mc(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	unsigned int bits, ecx;
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
 static void bsp_init_hygon(struct cpuinfo_x86 *c)
 {
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC)) {
@@ -212,18 +104,6 @@ static void bsp_init_hygon(struct cpuinf
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
 	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD)) {
 		/*
@@ -242,8 +122,6 @@ static void early_init_hygon(struct cpui
 {
 	u32 dummy;
 
-	early_init_hygon_mc(c);
-
 	set_cpu_cap(c, X86_FEATURE_K8);
 
 	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
@@ -284,8 +162,6 @@ static void early_init_hygon(struct cpui
 	 * we can set it unconditionally.
 	 */
 	set_cpu_cap(c, X86_FEATURE_VMMCALL);
-
-	hygon_get_topology_early(c);
 }
 
 static void init_hygon(struct cpuinfo_x86 *c)
@@ -302,9 +178,6 @@ static void init_hygon(struct cpuinfo_x8
 
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 
-	/* get apicid instead of initial apic id from cpuid */
-	c->topo.apicid = read_apic_id();
-
 	/*
 	 * XXX someone from Hygon needs to confirm this DTRT
 	 *
@@ -316,8 +189,6 @@ static void init_hygon(struct cpuinfo_x8
 
 	cpu_detect_cache_sizes(c);
 
-	hygon_detect_cmp(c);
-	hygon_get_topology(c);
 	srat_detect_node(c);
 
 	init_hygon_cacheinfo(c);
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -15,7 +15,6 @@ struct topo_scan {
 	u16			amd_node_id;
 };
 
-bool topo_is_converted(struct cpuinfo_x86 *c);
 void cpu_init_topology(struct cpuinfo_x86 *c);
 void cpu_parse_topology(struct cpuinfo_x86 *c);
 void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -68,18 +68,6 @@ static void parse_legacy(struct topo_sca
 	topology_set_dom(tscan, TOPO_CORE_DOMAIN, core_shift, cores);
 }
 
-bool topo_is_converted(struct cpuinfo_x86 *c)
-{
-	/* Temporary until everything is converted over. */
-	switch (boot_cpu_data.x86_vendor) {
-	case X86_VENDOR_HYGON:
-		return false;
-	default:
-		/* Let all UP systems use the below */
-		return true;
-	}
-}
-
 static bool fake_topology(struct topo_scan *tscan)
 {
 	/*
@@ -144,6 +132,10 @@ static void parse_topology(struct topo_s
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
 		break;
+	case X86_VENDOR_HYGON:
+		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))
+			cpu_parse_topology_amd(tscan);
+		break;
 	}
 }
 
@@ -187,9 +179,6 @@ void cpu_parse_topology(struct cpuinfo_x
 
 	parse_topology(&tscan, false);
 
-	if (!topo_is_converted(c))
-		return;
-
 	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++) {
 		if (tscan.dom_shifts[dom] == x86_topo_system.dom_shifts[dom])
 			continue;
@@ -218,9 +207,6 @@ void __init cpu_init_topology(struct cpu
 
 	parse_topology(&tscan, true);
 
-	if (!topo_is_converted(c))
-		return;
-
 	/* Copy the shift values and calculate the unit sizes. */
 	memcpy(x86_topo_system.dom_shifts, tscan.dom_shifts, sizeof(x86_topo_system.dom_shifts));
 


