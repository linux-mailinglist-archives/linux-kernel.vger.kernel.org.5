Return-Path: <linux-kernel+bounces-140105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A595D8A0B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94851C2278F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DCE1442FA;
	Thu, 11 Apr 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y92DZqPv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPZkbE/1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256513FD8C;
	Thu, 11 Apr 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824830; cv=none; b=ps6B4Zz6kwjQ6NtCEpRxi/9onP9n6eV6hDG7iUIEjtco7RFyPB9kVBGWMZrrnND4MuQQZlWzDoBil0IMmraOn0yf9foNT8fkYnLvcfwBlsGkaGfS1lQbTFnymMnvfXK31oTn60T9QxaGlogLBiC8zNpQu+iDpuKHcrNeZumbowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824830; c=relaxed/simple;
	bh=6ztzXLOMSdSjFwg/pwhagEJ7se4wiFLJeciQkXk8idU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GwQ1ddcvloV4ZEuHoCtjYPBSeKpD0EEgw9MrzdKrPNnGRqHFgXlgeSXR+pWO2J7tWd/L2cm02y3FMsI7eUPr0NTtvpaqdx948ZxU5AtJpe3IBRBEd26GOWqOXs9EupVMSbyaDqRrvNxwBHhFIi9//Y/eMADNRmM5HiiKAYWuBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y92DZqPv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPZkbE/1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 08:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712824820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QANrVq3DVGefTlFrqUoXDTrnAiDTrpceGyPGIVGm/Pk=;
	b=y92DZqPvpd/E2kOUnKc4ma2n8msIUKXEf+gduqQQZCQvAMG36W4+9/DjNYbwP3lb6xt8rZ
	Cn8EV8Y/whWcy18bTvX4ZhkBgN8LoEGulkoFibScxQJGPx5DixgrfUgtkbs3Jk4yYWojgM
	PtOfFtF7/+jP+6gr5lgnlHsdRb8eFW0Qsd+fxsq4A8E9Xj1kXf3perE1+/lth1OZAFxVfF
	w6Fb9aE/PNG9JD0Vuc45QVghR+7ai77hDoghPJdcQPOiA3a8VdznALqaef4cBNSFcZnXni
	PzpGGxcVwPlcR5r9+DMRHhPYvITFhV+XuG5IxgTarcZaZ1hNfRM6CWj56m3rXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712824820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QANrVq3DVGefTlFrqUoXDTrnAiDTrpceGyPGIVGm/Pk=;
	b=CPZkbE/1sTv573ap70IXkejOiRtdyjl60/y0BYXoh30Qi4SbWCti4lozmLfH66+0qDZsM9
	jDLNtG21PyJrTMCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Only harden syscalls when needed
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
References:
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171282481978.10875.11842078420317057256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     92dc47c57eac757c0987b0af0405d12192feff80
Gitweb:        https://git.kernel.org/tip/92dc47c57eac757c0987b0af0405d12192feff80
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 22:40:49 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 10:30:33 +02:00

x86/bugs: Only harden syscalls when needed

Syscall hardening (i.e., converting the syscall indirect branch to a
series of direct branches) may cause performance regressions in certain
scenarios.  Only use the syscall hardening when indirect branches are
considered unsafe.

Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org
---
 arch/x86/entry/common.c            | 30 ++++++++++++++++++++++++---
 arch/x86/entry/syscall_32.c        | 11 +----------
 arch/x86/entry/syscall_64.c        |  8 +-------
 arch/x86/entry/syscall_x32.c       |  7 +++++-
 arch/x86/include/asm/cpufeatures.h |  1 +-
 arch/x86/include/asm/syscall.h     |  8 ++++++-
 arch/x86/kernel/cpu/bugs.c         | 32 ++++++++++++++++++++++++++++-
 7 files changed, 74 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6de50b8..80d432d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -39,6 +39,28 @@
 
 #ifdef CONFIG_X86_64
 
+/*
+ * Do either a direct or an indirect call, depending on whether indirect calls
+ * are considered safe.
+ */
+#define __do_syscall(table, func_direct, nr, regs)			\
+({									\
+	unsigned long __rax, __rdi, __rsi;				\
+									\
+	asm_inline volatile(						\
+		ALTERNATIVE("call " __stringify(func_direct) "\n\t",	\
+			    ANNOTATE_RETPOLINE_SAFE			\
+			    "call *%[func_ptr]\n\t",			\
+			    X86_FEATURE_INDIRECT_SAFE)			\
+		: "=D" (__rdi), "=S" (__rsi), "=a" (__rax),		\
+		  ASM_CALL_CONSTRAINT					\
+		: "0" (regs), "1" (nr), [func_ptr] "r" (table[nr])	\
+		: "rdx", "rcx", "r8", "r9", "r10", "r11",		\
+		  "cc", "memory");					\
+									\
+	__rax;								\
+})
+
 static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 {
 	/*
@@ -49,7 +71,7 @@ static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
 
 	if (likely(unr < NR_syscalls)) {
 		unr = array_index_nospec(unr, NR_syscalls);
-		regs->ax = x64_sys_call(regs, unr);
+		regs->ax = __do_syscall(sys_call_table, x64_sys_call, unr, regs);
 		return true;
 	}
 	return false;
@@ -66,7 +88,7 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 
 	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
 		xnr = array_index_nospec(xnr, X32_NR_syscalls);
-		regs->ax = x32_sys_call(regs, xnr);
+		regs->ax = __do_syscall(x32_sys_call_table, x32_sys_call, xnr, regs);
 		return true;
 	}
 	return false;
@@ -147,6 +169,8 @@ static int ia32_emulation_override_cmdline(char *arg)
 	return kstrtobool(arg, &__ia32_enabled);
 }
 early_param("ia32_emulation", ia32_emulation_override_cmdline);
+#else
+#define __do_syscall(table, func_direct, nr, regs) table[nr](regs)
 #endif
 
 /*
@@ -162,7 +186,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 
 	if (likely(unr < IA32_NR_syscalls)) {
 		unr = array_index_nospec(unr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call(regs, unr);
+		regs->ax = __do_syscall(ia32_sys_call_table, ia32_sys_call, unr, regs);
 	} else if (nr != -1) {
 		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index c2235ba..9185870 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -14,25 +14,16 @@
 #endif
 
 #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
-
 #include <asm/syscalls_32.h>
 #undef __SYSCALL
 
-/*
- * The sys_call_table[] is no longer used for system calls, but
- * kernel/trace/trace_syscalls.c still wants to know the system
- * call address.
- */
-#ifdef CONFIG_X86_32
 #define __SYSCALL(nr, sym) __ia32_##sym,
-const sys_call_ptr_t sys_call_table[] = {
+__visible const sys_call_ptr_t ia32_sys_call_table[] = {
 #include <asm/syscalls_32.h>
 };
 #undef __SYSCALL
-#endif
 
 #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
-
 long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 33b3f09..c368048 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -11,19 +11,13 @@
 #include <asm/syscalls_64.h>
 #undef __SYSCALL
 
-/*
- * The sys_call_table[] is no longer used for system calls, but
- * kernel/trace/trace_syscalls.c still wants to know the system
- * call address.
- */
 #define __SYSCALL(nr, sym) __x64_##sym,
-const sys_call_ptr_t sys_call_table[] = {
+asmlinkage const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
 };
 #undef __SYSCALL
 
 #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
-
 long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 03de4a9..89a7172 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -11,8 +11,13 @@
 #include <asm/syscalls_x32.h>
 #undef __SYSCALL
 
-#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
+#define __SYSCALL(nr, sym) __x64_##sym,
+asmlinkage const sys_call_ptr_t x32_sys_call_table[] = {
+#include <asm/syscalls_x32.h>
+};
+#undef __SYSCALL
 
+#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
 long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c74343..7c87fe8 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -470,6 +470,7 @@
 #define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_INDIRECT_SAFE	(21*32+ 4) /* "" Indirect branches aren't vulnerable to Spectre v2 */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 2fc7bc3..dfb5952 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -16,14 +16,20 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
-/* This is used purely for kernel/trace/trace_syscalls.c */
 typedef long (*sys_call_ptr_t)(const struct pt_regs *);
 extern const sys_call_ptr_t sys_call_table[];
 
+#if defined(CONFIG_X86_32)
+#define ia32_sys_call_table sys_call_table
+#else
 /*
  * These may not exist, but still put the prototypes in so we
  * can use IS_ENABLED().
  */
+extern const sys_call_ptr_t ia32_sys_call_table[];
+extern const sys_call_ptr_t x32_sys_call_table[];
+#endif
+
 extern long ia32_sys_call(const struct pt_regs *, unsigned int nr);
 extern long x32_sys_call(const struct pt_regs *, unsigned int nr);
 extern long x64_sys_call(const struct pt_regs *, unsigned int nr);
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 9eeb60f..b4ec0f0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1669,6 +1669,15 @@ static void __init bhi_select_mitigation(void)
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
+	/*
+	 * There's no hardware mitigation in place, so mark indirect branches
+	 * as unsafe.
+	 *
+	 * One could argue the SW loop makes indirect branches safe again, but
+	 * Linus prefers it this way.
+	 */
+	setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
+
 	/* Mitigate KVM by default */
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
@@ -1687,6 +1696,21 @@ static void __init spectre_v2_select_mitigation(void)
 	enum spectre_v2_mitigation mode = SPECTRE_V2_NONE;
 
 	/*
+	 * X86_FEATURE_INDIRECT_SAFE indicates whether indirect calls can be
+	 * considered safe.  That means either:
+	 *
+	 *   - the CPU isn't vulnerable to Spectre v2 or its variants;
+	 *
+	 *   - a hardware mitigation is in place (e.g., IBRS, BHI_DIS_S); or
+	 *
+	 *   - the user turned off mitigations altogether.
+	 *
+	 * Assume innocence until proven guilty: set the cap bit now, then
+	 * clear it later if/when needed.
+	 */
+	setup_force_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
+
+	/*
 	 * If the CPU is not affected and the command line mode is NONE or AUTO
 	 * then nothing to do.
 	 */
@@ -1720,6 +1744,7 @@ static void __init spectre_v2_select_mitigation(void)
 
 	case SPECTRE_V2_CMD_RETPOLINE_LFENCE:
 		pr_err(SPECTRE_V2_LFENCE_MSG);
+		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
 		mode = SPECTRE_V2_LFENCE;
 		break;
 
@@ -1772,11 +1797,16 @@ static void __init spectre_v2_select_mitigation(void)
 		break;
 
 	case SPECTRE_V2_LFENCE:
+		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
+		fallthrough;
 	case SPECTRE_V2_EIBRS_LFENCE:
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE_LFENCE);
-		fallthrough;
+		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
+		break;
 
 	case SPECTRE_V2_RETPOLINE:
+		setup_clear_cpu_cap(X86_FEATURE_INDIRECT_SAFE);
+		fallthrough;
 	case SPECTRE_V2_EIBRS_RETPOLINE:
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 		break;

