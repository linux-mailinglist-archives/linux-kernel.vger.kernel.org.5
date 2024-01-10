Return-Path: <linux-kernel+bounces-21946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32748296FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C7B1C20F35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0729844382;
	Wed, 10 Jan 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEP5K/sS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEVpSj9x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442723FB35;
	Wed, 10 Jan 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8q6g0FaX2X6WLNLdw9mvvcYs8QxGdhMHHn9K9XVi3Q=;
	b=WEP5K/sSQCMw5jSMKymfcrV0wNNhCSH+RKD8itJBZbWjcn7y19U4leCsJQKNoFWxyYbUe0
	jIaeGPRoOQXjI1oNYGJTw5cT8ImwU6/Uw7gcGPGkOBKnQ31RGDd0qJ9AdVzMcMF8XjM9Ba
	yM/tMSImo6/25xRNKmpVoHPKrMHOzwwXBkwXxdk/hspisgdcpXIy5tD6qW/y4/6gWOOxX6
	zCgzjRiNdU3TLJnC8kXyVCyk785DlHV/D7VleqcolUgZkwcG2XMZ2zlDOg2ieTiYMu0j4A
	NO/njgv0dS1mHAN+17e02NCTX6XwqHJ713+WgY8tS8zWu5GoFswpbEZt0uPWPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8q6g0FaX2X6WLNLdw9mvvcYs8QxGdhMHHn9K9XVi3Q=;
	b=SEVpSj9xhBp6oZ8c7jUprrbGFW0rng7GUpeC2p0NjiW+lMG7hKKldc5onkwOncTJQ3n5Vx
	QyzQufL8JDNnGZDw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Rename CONFIG_RETPOLINE =>
 CONFIG_MITIGATION_RETPOLINE
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>, Ariel Miculas <amiculas@cisco.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-6-leitao@debian.org>
References: <20231121160740.1249350-6-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488139199.398.253211256384920898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     aefb2f2e619b6c334bcb31de830aa00ba0b11129
Gitweb:        https://git.kernel.org/tip/aefb2f2e619b6c334bcb31de830aa00ba0b11129
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:32 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:52:28 +01:00

x86/bugs: Rename CONFIG_RETPOLINE            => CONFIG_MITIGATION_RETPOLINE

Step 5/10 of the namespace unification of CPU mitigations related Kconfig options.

[ mingo: Converted a few more uses in comments/messages as well. ]

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ariel Miculas <amiculas@cisco.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-6-leitao@debian.org
---
 Documentation/admin-guide/hw-vuln/spectre.rst   | 8 ++++----
 Documentation/admin-guide/kernel-parameters.txt | 4 ++--
 arch/x86/Kconfig                                | 6 +++---
 arch/x86/Makefile                               | 4 ++--
 arch/x86/entry/vdso/Makefile                    | 4 ++--
 arch/x86/include/asm/disabled-features.h        | 2 +-
 arch/x86/include/asm/linkage.h                  | 8 ++++----
 arch/x86/include/asm/nospec-branch.h            | 8 ++++----
 arch/x86/kernel/alternative.c                   | 6 +++---
 arch/x86/kernel/cpu/bugs.c                      | 6 +++---
 arch/x86/kernel/ftrace.c                        | 2 +-
 arch/x86/kernel/kprobes/opt.c                   | 2 +-
 arch/x86/kernel/vmlinux.lds.S                   | 4 ++--
 arch/x86/kvm/mmu/mmu.c                          | 2 +-
 arch/x86/kvm/mmu/mmu_internal.h                 | 2 +-
 arch/x86/kvm/svm/svm.c                          | 2 +-
 arch/x86/kvm/svm/vmenter.S                      | 4 ++--
 arch/x86/kvm/vmx/vmx.c                          | 2 +-
 arch/x86/lib/Makefile                           | 2 +-
 arch/x86/net/bpf_jit_comp.c                     | 2 +-
 arch/x86/net/bpf_jit_comp32.c                   | 2 +-
 arch/x86/purgatory/Makefile                     | 2 +-
 include/linux/compiler-gcc.h                    | 2 +-
 include/linux/indirect_call_wrapper.h           | 2 +-
 include/linux/module.h                          | 2 +-
 include/net/netfilter/nf_tables_core.h          | 2 +-
 include/net/tc_wrapper.h                        | 2 +-
 kernel/trace/ring_buffer.c                      | 2 +-
 net/netfilter/Makefile                          | 2 +-
 net/netfilter/nf_tables_core.c                  | 6 +++---
 net/netfilter/nft_ct.c                          | 4 ++--
 net/netfilter/nft_lookup.c                      | 2 +-
 net/sched/sch_api.c                             | 2 +-
 scripts/Makefile.lib                            | 2 +-
 scripts/generate_rust_target.rs                 | 2 +-
 scripts/mod/modpost.c                           | 2 +-
 tools/arch/x86/include/asm/disabled-features.h  | 2 +-
 tools/objtool/arch/x86/special.c                | 2 +-
 tools/objtool/check.c                           | 2 +-
 39 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 32a8893..cce768a 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -473,8 +473,8 @@ Spectre variant 2
    -mindirect-branch=thunk-extern -mindirect-branch-register options.
    If the kernel is compiled with a Clang compiler, the compiler needs
    to support -mretpoline-external-thunk option.  The kernel config
-   CONFIG_RETPOLINE needs to be turned on, and the CPU needs to run with
-   the latest updated microcode.
+   CONFIG_MITIGATION_RETPOLINE needs to be turned on, and the CPU needs
+   to run with the latest updated microcode.
 
    On Intel Skylake-era systems the mitigation covers most, but not all,
    cases. See :ref:`[3] <spec_ref3>` for more details.
@@ -609,8 +609,8 @@ kernel command line.
 		Selecting 'on' will, and 'auto' may, choose a
 		mitigation method at run time according to the
 		CPU, the available microcode, the setting of the
-		CONFIG_RETPOLINE configuration option, and the
-		compiler with which the kernel was built.
+		CONFIG_MITIGATION_RETPOLINE configuration option,
+		and the compiler with which the kernel was built.
 
 		Selecting 'on' will also enable the mitigation
 		against user space to user space task attacks.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e0891ac..d93f403 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6007,8 +6007,8 @@
 			Selecting 'on' will, and 'auto' may, choose a
 			mitigation method at run time according to the
 			CPU, the available microcode, the setting of the
-			CONFIG_RETPOLINE configuration option, and the
-			compiler with which the kernel was built.
+			CONFIG_MITIGATION_RETPOLINE configuration option,
+			and the compiler with which the kernel was built.
 
 			Selecting 'on' will also enable the mitigation
 			against user space to user space task attacks.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a1c0470..2a3ebd6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2457,7 +2457,7 @@ config CALL_PADDING
 
 config FINEIBT
 	def_bool y
-	depends on X86_KERNEL_IBT && CFI_CLANG && RETPOLINE
+	depends on X86_KERNEL_IBT && CFI_CLANG && MITIGATION_RETPOLINE
 	select CALL_PADDING
 
 config HAVE_CALL_THUNKS
@@ -2495,7 +2495,7 @@ config MITIGATION_PAGE_TABLE_ISOLATION
 
 	  See Documentation/arch/x86/pti.rst for more details.
 
-config RETPOLINE
+config MITIGATION_RETPOLINE
 	bool "Avoid speculative indirect branches in kernel"
 	select OBJTOOL if HAVE_OBJTOOL
 	default y
@@ -2507,7 +2507,7 @@ config RETPOLINE
 
 config RETHUNK
 	bool "Enable return-thunks"
-	depends on RETPOLINE && CC_HAS_RETURN_THUNK
+	depends on MITIGATION_RETPOLINE && CC_HAS_RETURN_THUNK
 	select OBJTOOL if HAVE_OBJTOOL
 	default y if X86_64
 	help
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de..b8d23ed 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -192,7 +192,7 @@ KBUILD_CFLAGS += -Wno-sign-compare
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 
 # Avoid indirect branches in kernel to deal with Spectre
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_MITIGATION_RETPOLINE
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
   # Additionally, avoid generating expensive indirect jumps which
   # are subject to retpolines for small number of switch cases.
@@ -301,7 +301,7 @@ vdso-install-$(CONFIG_IA32_EMULATION)	+= arch/x86/entry/vdso/vdso32.so.dbg
 
 archprepare: checkbin
 checkbin:
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_MITIGATION_RETPOLINE
 ifeq ($(RETPOLINE_CFLAGS),)
 	@echo "You are building kernel with non-retpoline compiler." >&2
 	@echo "Please update your compiler." >&2
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index b1b8dd1..c4df99a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -87,7 +87,7 @@ CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        -fno-omit-frame-pointer -foptimize-sibling-calls \
        -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_MITIGATION_RETPOLINE
 ifneq ($(RETPOLINE_VDSO_CFLAGS),)
   CFL += $(RETPOLINE_VDSO_CFLAGS)
 endif
@@ -164,7 +164,7 @@ KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
 KBUILD_CFLAGS_32 += -DDISABLE_BRANCH_PROFILING
 
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_MITIGATION_RETPOLINE
 ifneq ($(RETPOLINE_VDSO_CFLAGS),)
   KBUILD_CFLAGS_32 += $(RETPOLINE_VDSO_CFLAGS)
 endif
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index fb604ec..24e4010 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -50,7 +50,7 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 # define DISABLE_RETPOLINE	0
 #else
 # define DISABLE_RETPOLINE	((1 << (X86_FEATURE_RETPOLINE & 31)) | \
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 571fe4d..c516520 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -42,25 +42,25 @@
 
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
-#else /* CONFIG_RETPOLINE */
+#else /* CONFIG_MITIGATION_RETPOLINE */
 #ifdef CONFIG_SLS
 #define RET	ret; int3
 #else
 #define RET	ret
 #endif
-#endif /* CONFIG_RETPOLINE */
+#endif /* CONFIG_MITIGATION_RETPOLINE */
 
 #else /* __ASSEMBLY__ */
 
 #if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define ASM_RET	"jmp __x86_return_thunk\n\t"
-#else /* CONFIG_RETPOLINE */
+#else /* CONFIG_MITIGATION_RETPOLINE */
 #ifdef CONFIG_SLS
 #define ASM_RET	"ret; int3\n\t"
 #else
 #define ASM_RET	"ret\n\t"
 #endif
-#endif /* CONFIG_RETPOLINE */
+#endif /* CONFIG_MITIGATION_RETPOLINE */
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 5981023..32680cb 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -241,7 +241,7 @@
  * instruction irrespective of kCFI.
  */
 .macro JMP_NOSPEC reg:req
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	__CS_PREFIX \reg
 	jmp	__x86_indirect_thunk_\reg
 #else
@@ -251,7 +251,7 @@
 .endm
 
 .macro CALL_NOSPEC reg:req
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	__CS_PREFIX \reg
 	call	__x86_indirect_thunk_\reg
 #else
@@ -378,7 +378,7 @@ static inline void call_depth_return_thunk(void) {}
 
 #endif /* CONFIG_MITIGATION_CALL_DEPTH_TRACKING */
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 
 #define GEN(reg) \
 	extern retpoline_thunk_t __x86_indirect_thunk_ ## reg;
@@ -399,7 +399,7 @@ static inline void call_depth_return_thunk(void) {}
 
 /*
  * Inline asm uses the %V modifier which is only in newer GCC
- * which is ensured when CONFIG_RETPOLINE is defined.
+ * which is ensured when CONFIG_MITIGATION_RETPOLINE is defined.
  */
 # define CALL_NOSPEC						\
 	ALTERNATIVE_2(						\
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 55e205b..08c182f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -544,7 +544,7 @@ static inline bool is_jcc32(struct insn *insn)
 	return insn->opcode.bytes[0] == 0x0f && (insn->opcode.bytes[1] & 0xf0) == 0x80;
 }
 
-#if defined(CONFIG_RETPOLINE) && defined(CONFIG_OBJTOOL)
+#if defined(CONFIG_MITIGATION_RETPOLINE) && defined(CONFIG_OBJTOOL)
 
 /*
  * CALL/JMP *%\reg
@@ -844,12 +844,12 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 #endif /* CONFIG_RETHUNK */
 
-#else /* !CONFIG_RETPOLINE || !CONFIG_OBJTOOL */
+#else /* !CONFIG_MITIGATION_RETPOLINE || !CONFIG_OBJTOOL */
 
 void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
 void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
-#endif /* CONFIG_RETPOLINE && CONFIG_OBJTOOL */
+#endif /* CONFIG_MITIGATION_RETPOLINE && CONFIG_OBJTOOL */
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b906ed4..fc46fd6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1103,7 +1103,7 @@ static enum spectre_v2_user_mitigation spectre_v2_user_stibp __ro_after_init =
 static enum spectre_v2_user_mitigation spectre_v2_user_ibpb __ro_after_init =
 	SPECTRE_V2_USER_NONE;
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 static bool spectre_v2_bad_module;
 
 bool retpoline_module_ok(bool has_retpoline)
@@ -1416,7 +1416,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 	     cmd == SPECTRE_V2_CMD_RETPOLINE_GENERIC ||
 	     cmd == SPECTRE_V2_CMD_EIBRS_LFENCE ||
 	     cmd == SPECTRE_V2_CMD_EIBRS_RETPOLINE) &&
-	    !IS_ENABLED(CONFIG_RETPOLINE)) {
+	    !IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
 		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
 		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
@@ -1470,7 +1470,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 
 static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 {
-	if (!IS_ENABLED(CONFIG_RETPOLINE)) {
+	if (!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)) {
 		pr_err("Kernel not compiled with retpoline; no mitigation available!");
 		return SPECTRE_V2_NONE;
 	}
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 12df54f..93bc52d 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -307,7 +307,7 @@ union ftrace_op_code_union {
 	} __attribute__((packed));
 };
 
-#define RET_SIZE		(IS_ENABLED(CONFIG_RETPOLINE) ? 5 : 1 + IS_ENABLED(CONFIG_SLS))
+#define RET_SIZE	(IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) ? 5 : 1 + IS_ENABLED(CONFIG_SLS))
 
 static unsigned long
 create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 517821b..36d6809 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -324,7 +324,7 @@ static int can_optimize(unsigned long paddr)
 		 * However, the kernel built with retpolines or IBT has jump
 		 * tables disabled so the check can be skipped altogether.
 		 */
-		if (!IS_ENABLED(CONFIG_RETPOLINE) &&
+		if (!IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) &&
 		    !IS_ENABLED(CONFIG_X86_KERNEL_IBT) &&
 		    insn_is_indirect_jump(&insn))
 			return 0;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index a349dbf..bb2ec03 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -132,7 +132,7 @@ SECTIONS
 		LOCK_TEXT
 		KPROBES_TEXT
 		SOFTIRQENTRY_TEXT
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 		*(.text..__x86.indirect_thunk)
 		*(.text..__x86.return_thunk)
 #endif
@@ -267,7 +267,7 @@ SECTIONS
 	}
 #endif
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	/*
 	 * List of instructions that call/jmp/jcc to retpoline thunks
 	 * __x86_indirect_thunk_*(). These instructions can be patched along
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0b1f991..6fdc1cf 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -263,7 +263,7 @@ static unsigned long get_guest_cr3(struct kvm_vcpu *vcpu)
 static inline unsigned long kvm_mmu_get_guest_pgd(struct kvm_vcpu *vcpu,
 						  struct kvm_mmu *mmu)
 {
-	if (IS_ENABLED(CONFIG_RETPOLINE) && mmu->get_guest_pgd == get_guest_cr3)
+	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && mmu->get_guest_pgd == get_guest_cr3)
 		return kvm_read_cr3(vcpu);
 
 	return mmu->get_guest_pgd(vcpu);
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index decc1f1..bf73a12 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -312,7 +312,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (!prefetch)
 		vcpu->stat.pf_taken++;
 
-	if (IS_ENABLED(CONFIG_RETPOLINE) && fault.is_tdp)
+	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && fault.is_tdp)
 		r = kvm_tdp_page_fault(vcpu, &fault);
 	else
 		r = vcpu->arch.mmu->page_fault(vcpu, &fault);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 7fb5142..b2751b9 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3455,7 +3455,7 @@ int svm_invoke_exit_handler(struct kvm_vcpu *vcpu, u64 exit_code)
 	if (!svm_check_exit_valid(exit_code))
 		return svm_handle_invalid_exit(vcpu, exit_code);
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	if (exit_code == SVM_EXIT_MSR)
 		return msr_interception(vcpu);
 	else if (exit_code == SVM_EXIT_VINTR)
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index ef2ebab..b9e0883 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -207,7 +207,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 7:	vmload %_ASM_AX
 8:
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
 	FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
 #endif
@@ -344,7 +344,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	/* Pop @svm to RDI, guest registers have been saved already. */
 	pop %_ASM_DI
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
 	FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
 #endif
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e0f86f1..4e1003b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6544,7 +6544,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 
 	if (exit_reason.basic >= kvm_vmx_max_exit_handlers)
 		goto unexpected_vmexit;
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	if (exit_reason.basic == EXIT_REASON_MSR_WRITE)
 		return kvm_emulate_wrmsr(vcpu);
 	else if (exit_reason.basic == EXIT_REASON_PREEMPTION_TIMER)
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index ea3a28e..72cc9c9 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -49,7 +49,7 @@ lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc.o copy_mc_64.o
 lib-$(CONFIG_INSTRUCTION_DECODER) += insn.o inat.o insn-eval.o
 lib-$(CONFIG_RANDOMIZE_BASE) += kaslr.o
 lib-$(CONFIG_FUNCTION_ERROR_INJECTION)	+= error-inject.o
-lib-$(CONFIG_RETPOLINE) += retpoline.o
+lib-$(CONFIG_MITIGATION_RETPOLINE) += retpoline.o
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 obj-y += iomem.o
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 144a583..ad1396b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -469,7 +469,7 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 			emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
 	} else {
 		EMIT2(0xFF, 0xE0 + reg);	/* jmp *%\reg */
-		if (IS_ENABLED(CONFIG_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
+		if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
 			EMIT1(0xCC);		/* int3 */
 	}
 
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index b18ce19..c10083a 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -1273,7 +1273,7 @@ static int emit_jmp_edx(u8 **pprog, u8 *ip)
 	u8 *prog = *pprog;
 	int cnt = 0;
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	EMIT1_off32(0xE9, (u8 *)__x86_indirect_thunk_edx - (ip + 5));
 #else
 	EMIT2(0xFF, 0xE2);
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 08aa0f2..bc31863 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -61,7 +61,7 @@ ifdef CONFIG_STACKPROTECTOR_STRONG
 PURGATORY_CFLAGS_REMOVE		+= -fstack-protector-strong
 endif
 
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_MITIGATION_RETPOLINE
 PURGATORY_CFLAGS_REMOVE		+= $(RETPOLINE_CFLAGS)
 endif
 
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 2ceba3f..d24f290 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -35,7 +35,7 @@
 	(typeof(ptr)) (__ptr + (off));					\
 })
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
diff --git a/include/linux/indirect_call_wrapper.h b/include/linux/indirect_call_wrapper.h
index c1c76a7..fe050da 100644
--- a/include/linux/indirect_call_wrapper.h
+++ b/include/linux/indirect_call_wrapper.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_INDIRECT_CALL_WRAPPER_H
 #define _LINUX_INDIRECT_CALL_WRAPPER_H
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 
 /*
  * INDIRECT_CALL_$NR - wrapper for indirect calls with $NR known builtin
diff --git a/include/linux/module.h b/include/linux/module.h
index 9cd0009..087b369 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -885,7 +885,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 extern bool retpoline_module_ok(bool has_retpoline);
 #else
 static inline bool retpoline_module_ok(bool has_retpoline)
diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 780a5f6..ff27cb2 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -93,7 +93,7 @@ extern const struct nft_set_type nft_set_bitmap_type;
 extern const struct nft_set_type nft_set_pipapo_type;
 extern const struct nft_set_type nft_set_pipapo_avx2_type;
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 		      const u32 *key, const struct nft_set_ext **ext);
 bool nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
diff --git a/include/net/tc_wrapper.h b/include/net/tc_wrapper.h
index a6d481b..a13ba03 100644
--- a/include/net/tc_wrapper.h
+++ b/include/net/tc_wrapper.h
@@ -4,7 +4,7 @@
 
 #include <net/pkt_cls.h>
 
-#if IS_ENABLED(CONFIG_RETPOLINE)
+#if IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)
 
 #include <linux/cpufeature.h>
 #include <linux/static_key.h>
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9286f88..9cb6933 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1156,7 +1156,7 @@ static inline u64 rb_time_stamp(struct trace_buffer *buffer)
 	u64 ts;
 
 	/* Skip retpolines :-( */
-	if (IS_ENABLED(CONFIG_RETPOLINE) && likely(buffer->clock == trace_clock_local))
+	if (IS_ENABLED(CONFIG_MITIGATION_RETPOLINE) && likely(buffer->clock == trace_clock_local))
 		ts = trace_clock_local();
 	else
 		ts = buffer->clock();
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index d4958e7..614815a 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -101,7 +101,7 @@ endif
 endif
 
 ifdef CONFIG_NFT_CT
-ifdef CONFIG_RETPOLINE
+ifdef CONFIG_MITIGATION_RETPOLINE
 nf_tables-objs += nft_ct_fast.o
 endif
 endif
diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index c3e6353..a48d5f0 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -21,7 +21,7 @@
 #include <net/netfilter/nf_log.h>
 #include <net/netfilter/nft_meta.h>
 
-#if defined(CONFIG_RETPOLINE) && defined(CONFIG_X86)
+#if defined(CONFIG_MITIGATION_RETPOLINE) && defined(CONFIG_X86)
 
 static struct static_key_false nf_tables_skip_direct_calls;
 
@@ -207,7 +207,7 @@ static void expr_call_ops_eval(const struct nft_expr *expr,
 			       struct nft_regs *regs,
 			       struct nft_pktinfo *pkt)
 {
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 	unsigned long e;
 
 	if (nf_skip_indirect_calls())
@@ -236,7 +236,7 @@ static void expr_call_ops_eval(const struct nft_expr *expr,
 	X(e, nft_objref_map_eval);
 #undef  X
 indirect_call:
-#endif /* CONFIG_RETPOLINE */
+#endif /* CONFIG_MITIGATION_RETPOLINE */
 	expr->ops->eval(expr, regs, pkt);
 }
 
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 86bb9d7..d3e66bc 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -751,7 +751,7 @@ static bool nft_ct_set_reduce(struct nft_regs_track *track,
 	return false;
 }
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 static const struct nft_expr_ops nft_ct_get_fast_ops = {
 	.type		= &nft_ct_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_ct)),
@@ -796,7 +796,7 @@ nft_ct_select_ops(const struct nft_ctx *ctx,
 		return ERR_PTR(-EINVAL);
 
 	if (tb[NFTA_CT_DREG]) {
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 		u32 k = ntohl(nla_get_be32(tb[NFTA_CT_KEY]));
 
 		switch (k) {
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 870e5b1..a0055f5 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -24,7 +24,7 @@ struct nft_lookup {
 	struct nft_set_binding		binding;
 };
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 bool nft_set_do_lookup(const struct net *net, const struct nft_set *set,
 		       const u32 *key, const struct nft_set_ext **ext)
 {
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e9eaf63..d577c9e 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2353,7 +2353,7 @@ static struct pernet_operations psched_net_ops = {
 	.exit = psched_net_exit,
 };
 
-#if IS_ENABLED(CONFIG_RETPOLINE)
+#if IS_ENABLED(CONFIG_MITIGATION_RETPOLINE)
 DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
 #endif
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index ee233ef..615f261 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -262,7 +262,7 @@ ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
 objtool-args-$(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT)		+= --mnop
 endif
 objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
-objtool-args-$(CONFIG_RETPOLINE)			+= --retpoline
+objtool-args-$(CONFIG_MITIGATION_RETPOLINE)		+= --retpoline
 objtool-args-$(CONFIG_RETHUNK)				+= --rethunk
 objtool-args-$(CONFIG_SLS)				+= --sls
 objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 3c6cbe2..eaf5246 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -155,7 +155,7 @@ fn main() {
             "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128",
         );
         let mut features = "-3dnow,-3dnowa,-mmx,+soft-float".to_string();
-        if cfg.has("RETPOLINE") {
+        if cfg.has("MITIGATION_RETPOLINE") {
             features += ",+retpoline-external-thunk";
         }
         ts.push("features", features);
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cb6406f..72fead5 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1843,7 +1843,7 @@ static void add_header(struct buffer *b, struct module *mod)
 
 	buf_printf(b,
 		   "\n"
-		   "#ifdef CONFIG_RETPOLINE\n"
+		   "#ifdef CONFIG_MITIGATION_RETPOLINE\n"
 		   "MODULE_INFO(retpoline, \"Y\");\n"
 		   "#endif\n");
 
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index fb604ec..24e4010 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -50,7 +50,7 @@
 # define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
 #endif
 
-#ifdef CONFIG_RETPOLINE
+#ifdef CONFIG_MITIGATION_RETPOLINE
 # define DISABLE_RETPOLINE	0
 #else
 # define DISABLE_RETPOLINE	((1 << (X86_FEATURE_RETPOLINE & 31)) | \
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 29e9495..4134d27 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -83,7 +83,7 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
  *    TODO: Once we have DWARF CFI and smarter instruction decoding logic,
  *    ensure the same register is used in the mov and jump instructions.
  *
- *    NOTE: RETPOLINE made it harder still to decode dynamic jumps.
+ *    NOTE: MITIGATION_RETPOLINE made it harder still to decode dynamic jumps.
  */
 struct reloc *arch_find_switch_table(struct objtool_file *file,
 				    struct instruction *insn)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 548ec3c..84067f0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3984,7 +3984,7 @@ static int validate_retpoline(struct objtool_file *file)
 			} else
 				continue;
 		} else {
-			WARN_INSN(insn, "indirect %s found in RETPOLINE build",
+			WARN_INSN(insn, "indirect %s found in MITIGATION_RETPOLINE build",
 				  insn->type == INSN_JUMP_DYNAMIC ? "jump" : "call");
 		}
 

