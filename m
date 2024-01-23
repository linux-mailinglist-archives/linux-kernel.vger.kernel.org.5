Return-Path: <linux-kernel+bounces-35271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF72838EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085E2286427
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713655FDD2;
	Tue, 23 Jan 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sj94Vjye";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uaKjwzfC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAFC5FDAE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014425; cv=none; b=WGAHg+qJFCG2RLI0V8w+a60h+JRRkDYJS9Ut92tw4JPLl3yLvE/TOasyu6tsVZZVMKdDonZqaUZKwAtS60ckY4EaqDn8a1ASlRMk5ygzPZxuegc7FZUcpCv/XEUmAge91QwTgFWkY1XRyd0FoD6fefkS0kha56Cc/GmO40cOkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014425; c=relaxed/simple;
	bh=1VXTKAfmMMh+RRXXMri++S8vkPmoJBMJLVsfWN/Ll/Y=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=hV+GmWmhNBEdLcNWb+oNDumL3jkQrPVoK0xANjveFlJgO2F7U3QrDNHlIdjABf3MSNYuUNySAZbTprKEI3K1xzbzr6z6UkYlYx6sVvj2G989zsRFJIWxHTVAJ2j4fkXC/Q4IICl3UpNfWEAZhwyw95gIc7MiYYmDGAh9JJeVw48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sj94Vjye; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uaKjwzfC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115908.740438007@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BXhmme64X7IhYeDIe8j69nb31VkeJzia7wTrN7xIZqo=;
	b=sj94VjyeKWUE+Z51bro3gSQINOLbbX/5yyR+kFgstarJT69aaKnsEecGfCgOAGc+Zf55tT
	AwKMFjU9hctDR1kOzJ/989rB8006i7q7Q+5fX7xLSwta+/zMH/zp+Z3UkiZiJtz13e/wwf
	WYSmlz8zEvf3VcsRNT+LLXwAQwyW6lrdw/moDhoOs7syaWUprgHXEFwd3FOs2Uaq3glJmT
	8Ye9WhyOq4sDPWdXWzWSuQcTtSye6PJV+NDcjBJHsQ+tPSy2JtzJs99gP6R/o4L29h3aJ0
	Ho9meF/xVN8DtV+Em3VJw871vsr3ZDZ4y+9AbbEKCLDBa59OhQSXHRt+WdWjBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=BXhmme64X7IhYeDIe8j69nb31VkeJzia7wTrN7xIZqo=;
	b=uaKjwzfCqVuMmjZCIi536Y3ES6QNjBoj6WxN+i/h0wUjP+mQk5k4gsMRKTvdyoJmxwjlWQ
	nksXB/L/pAX9UaBQ==
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
Subject: [patch v5 07/19] x86/cpu: Use common topology code for Intel
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:40 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Intel CPUs use either topology leaf 0xb/0x1f evaluation or the legacy
SMP/HT evaluation based on CPUID leaf 0x1/0x4.

Move it over to the consolidated topology code and remove the random
topology hacks which are sprinkled into the Intel and the common code.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


---
 arch/x86/kernel/cpu/common.c          |   65 ----------------------------------
 arch/x86/kernel/cpu/cpu.h             |    4 --
 arch/x86/kernel/cpu/intel.c           |   25 -------------
 arch/x86/kernel/cpu/topology_common.c |    5 ++
 4 files changed, 4 insertions(+), 95 deletions(-)
---
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -792,19 +792,6 @@ static void get_model_name(struct cpuinf
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
@@ -866,54 +853,6 @@ static void cpu_detect_tlb(struct cpuinf
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
@@ -1898,10 +1837,6 @@ static void identify_cpu(struct cpuinfo_
 				c->x86, c->x86_model);
 	}
 
-#ifdef CONFIG_X86_64
-	detect_ht(c);
-#endif
-
 	x86_init_rdrand(c);
 	setup_pku(c);
 	setup_cet(c);
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -76,11 +76,7 @@ extern void init_intel_cacheinfo(struct
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_hygon_cacheinfo(struct cpuinfo_x86 *c);
 
-extern void detect_num_cpu_cores(struct cpuinfo_x86 *c);
-extern int detect_extended_topology_early(struct cpuinfo_x86 *c);
 extern int detect_extended_topology(struct cpuinfo_x86 *c);
-extern int detect_ht_early(struct cpuinfo_x86 *c);
-extern void detect_ht(struct cpuinfo_x86 *c);
 extern void check_null_seg_clears_base(struct cpuinfo_x86 *c);
 
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c);
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -315,13 +315,6 @@ static void early_init_intel(struct cpui
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
@@ -603,24 +596,6 @@ static void init_intel(struct cpuinfo_x8
 
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
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -71,7 +71,6 @@ bool topo_is_converted(struct cpuinfo_x8
 	/* Temporary until everything is converted over. */
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-	case X86_VENDOR_INTEL:
 	case X86_VENDOR_HYGON:
 		return false;
 	default:
@@ -136,6 +135,10 @@ static void parse_topology(struct topo_s
 	case X86_VENDOR_ZHAOXIN:
 		parse_legacy(tscan);
 		break;
+	case X86_VENDOR_INTEL:
+		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
+			parse_legacy(tscan);
+		break;
 	}
 }
 


