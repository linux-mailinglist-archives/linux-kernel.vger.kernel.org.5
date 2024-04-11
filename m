Return-Path: <linux-kernel+bounces-140108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2A8A0B80
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F19A1F23E79
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F31A144D2D;
	Thu, 11 Apr 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuSSNlOp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+V9+VtfE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01E142902;
	Thu, 11 Apr 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824832; cv=none; b=K8RgA11K95oJKwAPGTImAkNSzcmjWS4qvwhcFn1KGJzb0H6EKyBB75FPYjkbg2gr8RsHKluQXSqU7FiD8T1QOPoJA7vP6ZU/51Qd8p74Nxjxj97r0BP5ocox9doIFHF4unlnl4njHUcEBXLqOB8OZ4zzEqj9Du6SvpQf/FGlr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824832; c=relaxed/simple;
	bh=CBQUfP/uYzplIuFFeF17qpaANzmufuOl/I1FAWUEC+o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I/3+vCTJEgsmrjImcGfxQ7vMnLmDsFoKpyiNEbesMgJ2QpUuYohxwvgZVky563B63H3S4SqmrWJgYo/F62U6TQXJ0vuEg3UxG8vUTso4jlMW/CylPvuqYpfImiIkr/6fuSJR0P+g3l/ddZ4nHrUcFPaoBgKNBQWaMaQe/vlgifY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QuSSNlOp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+V9+VtfE; arc=none smtp.client-ip=193.142.43.55
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
	bh=fxa+WhHL7X9w88LCkA3WuYFysX1pM0f1GBrTSu6M5DU=;
	b=QuSSNlOpC0KvlsLTiP7lOYaqH/qZxmQPxOD727bw1wQ+GuhYmDpLYzBD9YfqdMZc78SjwQ
	INqa6SX/0OsP7FGv+7v9CsfNai5xyQwIyDPkUS2xdCK3Ai8hVL9hGywm4+uVTQPSBUd0ks
	VJtWUHrD/QxCEDxAfhfXsybz7tvcbupsYSwmElT8ckJJWhMwmFipOQLo90ynyb/mwHy7i5
	2PNK1p4g+hrtP85SeSMyGGsLIfDeqxYvxIcfERbSxMS/eB4XC4Shq4Ch5uY3BnKQ+CU6CR
	NTSgRzGWQxSt5x5RN/unMLb4MRXZwcz4Q0/3fXvK66yaXMA19n2pyj7Dtf8EJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712824823;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxa+WhHL7X9w88LCkA3WuYFysX1pM0f1GBrTSu6M5DU=;
	b=+V9+VtfE2xRTr5SLx2ZG2UVHLz/I+oGQY20jKzke83+qfkVrF4WNZX+P+cMfj+F9pLQ/wa
	X9UB1ZGtR6nAUaAA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <171282482285.10875.9205013042321475431.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     cb2db5bb04d7f778fbc1a1ea2507aab436f1bff3
Gitweb:        https://git.kernel.org/tip/cb2db5bb04d7f778fbc1a1ea2507aab436f1bff3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 22:40:46 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 10:30:33 +02:00

x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES

There's no need to keep reading MSR_IA32_ARCH_CAPABILITIES over and
over.  It's even read in the BHI sysfs function which is a big no-no.
Just read it once and cache it.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/9592a18a814368e75f8f4b9d74d3883aa4fd1eaf.1712813475.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 27f5004..ff59fa8 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -61,6 +61,8 @@ EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);
 
+static u64 __ro_after_init ia32_cap;
+
 static DEFINE_MUTEX(spec_ctrl_mutex);
 
 void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
@@ -144,6 +146,8 @@ void __init cpu_select_mitigations(void)
 		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
 	}
 
+	ia32_cap = x86_read_arch_cap_msr();
+
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
@@ -301,8 +305,6 @@ static const char * const taa_strings[] = {
 
 static void __init taa_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_TAA)) {
 		taa_mitigation = TAA_MITIGATION_OFF;
 		return;
@@ -341,7 +343,6 @@ static void __init taa_select_mitigation(void)
 	 * On MDS_NO=1 CPUs if ARCH_CAP_TSX_CTRL_MSR is not set, microcode
 	 * update is required.
 	 */
-	ia32_cap = x86_read_arch_cap_msr();
 	if ( (ia32_cap & ARCH_CAP_MDS_NO) &&
 	    !(ia32_cap & ARCH_CAP_TSX_CTRL_MSR))
 		taa_mitigation = TAA_MITIGATION_UCODE_NEEDED;
@@ -401,8 +402,6 @@ static const char * const mmio_strings[] = {
 
 static void __init mmio_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
 	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
 	     cpu_mitigations_off()) {
@@ -413,8 +412,6 @@ static void __init mmio_select_mitigation(void)
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return;
 
-	ia32_cap = x86_read_arch_cap_msr();
-
 	/*
 	 * Enable CPU buffer clear mitigation for host and VMM, if also affected
 	 * by MDS or TAA. Otherwise, enable mitigation for VMM only.
@@ -508,7 +505,7 @@ static void __init rfds_select_mitigation(void)
 	if (rfds_mitigation == RFDS_MITIGATION_OFF)
 		return;
 
-	if (x86_read_arch_cap_msr() & ARCH_CAP_RFDS_CLEAR)
+	if (ia32_cap & ARCH_CAP_RFDS_CLEAR)
 		setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
 	else
 		rfds_mitigation = RFDS_MITIGATION_UCODE_NEEDED;
@@ -659,8 +656,6 @@ void update_srbds_msr(void)
 
 static void __init srbds_select_mitigation(void)
 {
-	u64 ia32_cap;
-
 	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
 		return;
 
@@ -669,7 +664,6 @@ static void __init srbds_select_mitigation(void)
 	 * are only exposed to SRBDS when TSX is enabled or when CPU is affected
 	 * by Processor MMIO Stale Data vulnerability.
 	 */
-	ia32_cap = x86_read_arch_cap_msr();
 	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM) &&
 	    !boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
@@ -813,7 +807,7 @@ static void __init gds_select_mitigation(void)
 	/* Will verify below that mitigation _can_ be disabled */
 
 	/* No microcode */
-	if (!(x86_read_arch_cap_msr() & ARCH_CAP_GDS_CTRL)) {
+	if (!(ia32_cap & ARCH_CAP_GDS_CTRL)) {
 		if (gds_mitigation == GDS_MITIGATION_FORCE) {
 			/*
 			 * This only needs to be done on the boot CPU so do it
@@ -1908,8 +1902,6 @@ static void update_indir_branch_cond(void)
 /* Update the static key controlling the MDS CPU buffer clear in idle */
 static void update_mds_branch_idle(void)
 {
-	u64 ia32_cap = x86_read_arch_cap_msr();
-
 	/*
 	 * Enable the idle clearing if SMT is active on CPUs which are
 	 * affected only by MSBDS and not any other MDS variant.
@@ -2818,7 +2810,7 @@ static const char *spectre_bhi_state(void)
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
 	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !(x86_read_arch_cap_msr() & ARCH_CAP_RRSBA))
+		 !(ia32_cap & ARCH_CAP_RRSBA))
 		return "; BHI: Retpoline";
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Syscall hardening, KVM: SW loop";

