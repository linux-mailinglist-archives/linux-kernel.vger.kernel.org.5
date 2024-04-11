Return-Path: <linux-kernel+bounces-140107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B258A0B81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798B71C2152D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B1144D3D;
	Thu, 11 Apr 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TFncOP/+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vUumCQ6w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B62F142620;
	Thu, 11 Apr 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824832; cv=none; b=XCqegBgNMtC13k6hcHmHprSukL/m/ko08G5trNj4SBSRCfOFgPcrChqC0XYtnoj4kzlHAPdqe1a+q023Tf+N/tBo/FdfOJ/tWt6+S3mZZt+u50GcbssOVwcJqBrS2PZQvqy95OeSr1eOAGzIkswGNjIHDD5pgr6fU9cE9f40tcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824832; c=relaxed/simple;
	bh=3OGkKacafqNdJe1Jnk9Z+YrnZtQCiT5gTKbInpC9/FM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cVig8W+VIf0RlgbODIVdc/D/pehk5ALVWi1LS6O/DDFB0moN9SeSBWSslS1UmNop77q8aVS7fIR3xRk+3BtKVjUPNQjYBl3zNDBk06DHIU16QEKbrTNUgVEZaGTI547uLJ0odCQXWfG9zthOrvFVFCcgjUqLPv/lOXZQFl28nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TFncOP/+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vUumCQ6w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 08:40:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712824823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZFLZdA3ZRzrFWOoV+XZeAgJc1do7CZbKxeKvVPx1jU=;
	b=TFncOP/+jyPQawR6CVTA/nReDqU/unc7XEvLKkTUIH3t1lPfpOI3GQja3aYK00ETl2WmcS
	YhzczvemwnD1VAj4iDJmFMXNv5rO0QoCmcq2c6gxD0pbYbMX6tKnxPCrGCgcFCjPbtbjiV
	uoDCyhzwEE4XLp37SbxcUPGkHoMrr+Hs6Ml7Yn5MiL657CAAcIreiVHxtuV3fkM/2rJkgi
	v1Jw6NNjgNFi4nYNO0blFIG0VRjKgtgYcX6BpE/bY/ky7BdvGuxDQtI4gCCRyDx1zCVEje
	2sTR33jNTPlaWKFuggIx70Kmruoh69tsspHI+o9aEf5PpeM8Lc4FCrrihVUQ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712824823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZFLZdA3ZRzrFWOoV+XZeAgJc1do7CZbKxeKvVPx1jU=;
	b=vUumCQ6wFLfg6EpUsbJgetS5U0BuVKXz3aI+YF3vxMUoXvHi3yYwU6L38pkFWJW9qIUmmv
	p+ji6WbaybTsKjCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Rename various 'ia32_cap' variables to
 'x86_arch_cap_msr'
Cc: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <9592a18a814368e75f8f4b9d74d3883aa4fd1eaf.1712813475.git.jpoimboe@kernel.org>
References:
 <9592a18a814368e75f8f4b9d74d3883aa4fd1eaf.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171282482211.10875.6670128650635691750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d0485730d2189ffe5d986d4e9e191f1e4d5ffd24
Gitweb:        https://git.kernel.org/tip/d0485730d2189ffe5d986d4e9e191f1e4d5ffd24
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 11 Apr 2024 09:25:36 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 10:30:33 +02:00

x86/bugs: Rename various 'ia32_cap' variables to 'x86_arch_cap_msr'

So we are using the 'ia32_cap' value in a number of places,
which got its name from MSR_IA32_ARCH_CAPABILITIES MSR register.

But there's very little 'IA32' about it - this isn't 32-bit only
code, nor does it originate from there, it's just a historic
quirk that many Intel MSR names are prefixed with IA32_.

This is already clear from the helper method around the MSR:
x86_read_arch_cap_msr(), which doesn't have the IA32 prefix.

So rename 'ia32_cap' to 'x86_arch_cap_msr' to be consistent with
its role and with the naming of the helper function.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/9592a18a814368e75f8f4b9d74d3883aa4fd1eaf.1712813475.git.jpoimboe@kernel.org
---
 arch/x86/kernel/apic/apic.c  |  6 ++--
 arch/x86/kernel/cpu/bugs.c   | 30 +++++++++++-----------
 arch/x86/kernel/cpu/common.c | 48 +++++++++++++++++------------------
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index a42d8a6..c342c4a 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1687,11 +1687,11 @@ static int x2apic_state;
 
 static bool x2apic_hw_locked(void)
 {
-	u64 ia32_cap;
+	u64 x86_arch_cap_msr;
 	u64 msr;
 
-	ia32_cap = x86_read_arch_cap_msr();
-	if (ia32_cap & ARCH_CAP_XAPIC_DISABLE) {
+	x86_arch_cap_msr = x86_read_arch_cap_msr();
+	if (x86_arch_cap_msr & ARCH_CAP_XAPIC_DISABLE) {
 		rdmsrl(MSR_IA32_XAPIC_DISABLE_STATUS, msr);
 		return (msr & LEGACY_XAPIC_DISABLED);
 	}
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ff59fa8..1b0cfc1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -61,7 +61,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
-static u64 __ro_after_init ia32_cap;
+static u64 __ro_after_init x86_arch_cap_msr;
 
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
@@ -146,7 +146,7 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
-	ia32_cap = x86_read_arch_cap_msr();
+	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
@@ -343,8 +343,8 @@ static void __init taa_select_mitigation(void)
 	 * On MDS_NO=1 CPUs if ARCH_CAP_TSX_CTRL_MSR is not set, microcode
 	 * update is required.
 	 */
-	if ( (ia32_cap & ARCH_CAP_MDS_NO) &&
-	    !(ia32_cap & ARCH_CAP_TSX_CTRL_MSR))
+	if ( (x86_arch_cap_msr & ARCH_CAP_MDS_NO) &&
+	    !(x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR))
 		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
 
 	/*
@@ -434,7 +434,7 @@ static void __init mmio_select_mitigation(void)
 	 * be propagated to uncore buffers, clearing the Fill buffers on idle
 	 * is required irrespective of SMT state.
 	 */
-	if (!(ia32_cap & ARCH_CAP_FBSDP_NO))
+	if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
 		static_branch_enable(&mds_idle_clear);
 
 	/*
@@ -444,10 +444,10 @@ static void __init mmio_select_mitigation(void)
 	 * FB_CLEAR or by the presence of both MD_CLEAR and L1D_FLUSH on MDS
 	 * affected systems.
 	 */
-	if ((ia32_cap & ARCH_CAP_FB_CLEAR) ||
+	if ((x86_arch_cap_msr & ARCH_CAP_FB_CLEAR) ||
 	    (boot_cpu_has(X86_FEATURE_MD_CLEAR) &&
 	     boot_cpu_has(X86_FEATURE_FLUSH_L1D) &&
-	     !(ia32_cap & ARCH_CAP_MDS_NO)))
+	     !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)))
 		mmio_mitigation = MMIO_MITIGATION_VERW;
 	else
 		mmio_mitigation = MMIO_MITIGATION_UCODE_NEEDED;
@@ -505,7 +505,7 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
@@ -664,7 +664,7 @@ static void __init srbds_select_mitigation(void)
 	 * are only exposed to SRBDS when TSX is enabled or when CPU is affected
 	 * by Processor MMIO Stale Data vulnerability.
 	 */
-	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
+	if ((x86_arch_cap_msr & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
 	    !boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
 	else if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
@@ -807,7 +807,7 @@ static void __init gds_select_mitigation(void)
 	/* Will verify below that mitigation _can_ be disabled */
 
 	/* No microcode */
-	if (!(ia32_cap & ARCH_CAP_GDS_CTRL)) {
+	if (!(x86_arch_cap_msr & ARCH_CAP_GDS_CTRL)) {
 		if (gds_mitigation == GDS_MITIGATION_FORCE) {
 			/*
 			 * This only needs to be done on the boot CPU so do it
@@ -1541,14 +1541,14 @@ static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 /* Disable in-kernel use of non-RSB RET predictors */
 static void __init spec_ctrl_disable_kernel_rrsba(void)
 {
-	u64 ia32_cap;
+	u64 x86_arch_cap_msr;
 
 	if (!boot_cpu_has(X86_FEATURE_RRSBA_CTRL))
 		return;
 
-	ia32_cap = x86_read_arch_cap_msr();
+	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
-	if (ia32_cap & ARCH_CAP_RRSBA) {
+	if (x86_arch_cap_msr & ARCH_CAP_RRSBA) {
 		x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
 		update_spec_ctrl(x86_spec_ctrl_base);
 	}
@@ -1916,7 +1916,7 @@ static void update_mds_branch_idle(void)
 	if (sched_smt_active()) {
 		static_branch_enable(&mds_idle_clear);
 	} else if (mmio_mitigation == MMIO_MITIGATION_OFF ||
-		   (ia32_cap & ARCH_CAP_FBSDP_NO)) {
+		   (x86_arch_cap_msr & ARCH_CAP_FBSDP_NO)) {
 		static_branch_disable(&mds_idle_clear);
 	}
 }
@@ -2810,7 +2810,7 @@ static const char *spectre_bhi_state(void)
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
 	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !(ia32_cap & ARCH_CAP_RRSBA))
+		 !(x86_arch_cap_msr & ARCH_CAP_RRSBA))
 		return "; BHI: Retpoline";
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Syscall hardening, KVM: SW loop";
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 754d918..605c26c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1284,25 +1284,25 @@ static bool __init cpu_matches(const struct x86_cpu_id *table, unsigned long whi
 
 u64 x86_read_arch_cap_msr(void)
 {
-	u64 ia32_cap = 0;
+	u64 x86_arch_cap_msr = 0;
 
 	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, x86_arch_cap_msr);
 
-	return ia32_cap;
+	return x86_arch_cap_msr;
 }
 
-static bool arch_cap_mmio_immune(u64 ia32_cap)
+static bool arch_cap_mmio_immune(u64 x86_arch_cap_msr)
 {
-	return (ia32_cap & ARCH_CAP_FBSDP_NO &&
-		ia32_cap & ARCH_CAP_PSDP_NO &&
-		ia32_cap & ARCH_CAP_SBDR_SSDP_NO);
+	return (x86_arch_cap_msr & ARCH_CAP_FBSDP_NO &&
+		x86_arch_cap_msr & ARCH_CAP_PSDP_NO &&
+		x86_arch_cap_msr & ARCH_CAP_SBDR_SSDP_NO);
 }
 
-static bool __init vulnerable_to_rfds(u64 ia32_cap)
+static bool __init vulnerable_to_rfds(u64 x86_arch_cap_msr)
 {
 	/* The "immunity" bit trumps everything else: */
-	if (ia32_cap & ARCH_CAP_RFDS_NO)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_NO)
 		return false;
 
 	/*
@@ -1310,7 +1310,7 @@ static bool __init vulnerable_to_rfds(u64 ia32_cap)
 	 * indicate that mitigation is needed because guest is running on a
 	 * vulnerable hardware or may migrate to such hardware:
 	 */
-	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
+	if (x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR)
 		return true;
 
 	/* Only consult the blacklist when there is no enumeration: */
@@ -1319,11 +1319,11 @@ static bool __init vulnerable_to_rfds(u64 ia32_cap)
 
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
-	u64 ia32_cap = x86_read_arch_cap_msr();
+	u64 x86_arch_cap_msr = x86_read_arch_cap_msr();
 
 	/* Set ITLB_MULTIHIT bug if cpu is not in the whitelist and not mitigated */
 	if (!cpu_matches(cpu_vuln_whitelist, NO_ITLB_MULTIHIT) &&
-	    !(ia32_cap & ARCH_CAP_PSCHANGE_MC_NO))
+	    !(x86_arch_cap_msr & ARCH_CAP_PSCHANGE_MC_NO))
 		setup_force_cpu_bug(X86_BUG_ITLB_MULTIHIT);
 
 	if (cpu_matches(cpu_vuln_whitelist, NO_SPECULATION))
@@ -1335,7 +1335,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_SSB) &&
-	    !(ia32_cap & ARCH_CAP_SSB_NO) &&
+	    !(x86_arch_cap_msr & ARCH_CAP_SSB_NO) &&
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
@@ -1346,17 +1346,17 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * Don't use AutoIBRS when SNP is enabled because it degrades host
 	 * userspace indirect branch performance.
 	 */
-	if ((ia32_cap & ARCH_CAP_IBRS_ALL) ||
+	if ((x86_arch_cap_msr & ARCH_CAP_IBRS_ALL) ||
 	    (cpu_has(c, X86_FEATURE_AUTOIBRS) &&
 	     !cpu_feature_enabled(X86_FEATURE_SEV_SNP))) {
 		setup_force_cpu_cap(X86_FEATURE_IBRS_ENHANCED);
 		if (!cpu_matches(cpu_vuln_whitelist, NO_EIBRS_PBRSB) &&
-		    !(ia32_cap & ARCH_CAP_PBRSB_NO))
+		    !(x86_arch_cap_msr & ARCH_CAP_PBRSB_NO))
 			setup_force_cpu_bug(X86_BUG_EIBRS_PBRSB);
 	}
 
 	if (!cpu_matches(cpu_vuln_whitelist, NO_MDS) &&
-	    !(ia32_cap & ARCH_CAP_MDS_NO)) {
+	    !(x86_arch_cap_msr & ARCH_CAP_MDS_NO)) {
 		setup_force_cpu_bug(X86_BUG_MDS);
 		if (cpu_matches(cpu_vuln_whitelist, MSBDS_ONLY))
 			setup_force_cpu_bug(X86_BUG_MSBDS_ONLY);
@@ -1375,9 +1375,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * TSX_CTRL check alone is not sufficient for cases when the microcode
 	 * update is not present or running as guest that don't get TSX_CTRL.
 	 */
-	if (!(ia32_cap & ARCH_CAP_TAA_NO) &&
+	if (!(x86_arch_cap_msr & ARCH_CAP_TAA_NO) &&
 	    (cpu_has(c, X86_FEATURE_RTM) ||
-	     (ia32_cap & ARCH_CAP_TSX_CTRL_MSR)))
+	     (x86_arch_cap_msr & ARCH_CAP_TSX_CTRL_MSR)))
 		setup_force_cpu_bug(X86_BUG_TAA);
 
 	/*
@@ -1403,7 +1403,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * Set X86_BUG_MMIO_UNKNOWN for CPUs that are neither in the blacklist,
 	 * nor in the whitelist and also don't enumerate MSR ARCH_CAP MMIO bits.
 	 */
-	if (!arch_cap_mmio_immune(ia32_cap)) {
+	if (!arch_cap_mmio_immune(x86_arch_cap_msr)) {
 		if (cpu_matches(cpu_vuln_blacklist, MMIO))
 			setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
 		else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
@@ -1411,7 +1411,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	}
 
 	if (!cpu_has(c, X86_FEATURE_BTC_NO)) {
-		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (ia32_cap & ARCH_CAP_RSBA))
+		if (cpu_matches(cpu_vuln_blacklist, RETBLEED) || (x86_arch_cap_msr & ARCH_CAP_RSBA))
 			setup_force_cpu_bug(X86_BUG_RETBLEED);
 	}
 
@@ -1429,15 +1429,15 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * disabling AVX2. The only way to do this in HW is to clear XCR0[2],
 	 * which means that AVX will be disabled.
 	 */
-	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(ia32_cap & ARCH_CAP_GDS_NO) &&
+	if (cpu_matches(cpu_vuln_blacklist, GDS) && !(x86_arch_cap_msr & ARCH_CAP_GDS_NO) &&
 	    boot_cpu_has(X86_FEATURE_AVX))
 		setup_force_cpu_bug(X86_BUG_GDS);
 
-	if (vulnerable_to_rfds(ia32_cap))
+	if (vulnerable_to_rfds(x86_arch_cap_msr))
 		setup_force_cpu_bug(X86_BUG_RFDS);
 
 	/* When virtualized, eIBRS could be hidden, assume vulnerable */
-	if (!(ia32_cap & ARCH_CAP_BHI_NO) &&
+	if (!(x86_arch_cap_msr & ARCH_CAP_BHI_NO) &&
 	    !cpu_matches(cpu_vuln_whitelist, NO_BHI) &&
 	    (boot_cpu_has(X86_FEATURE_IBRS_ENHANCED) ||
 	     boot_cpu_has(X86_FEATURE_HYPERVISOR)))
@@ -1447,7 +1447,7 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		return;
 
 	/* Rogue Data Cache Load? No! */
-	if (ia32_cap & ARCH_CAP_RDCL_NO)
+	if (x86_arch_cap_msr & ARCH_CAP_RDCL_NO)
 		return;
 
 	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);

