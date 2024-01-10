Return-Path: <linux-kernel+bounces-21941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3640A8296F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6DA1F279DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E03FB06;
	Wed, 10 Jan 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jDj/QlC2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OEY4SS5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C73F8E6;
	Wed, 10 Jan 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQU4AoIpE47h+/6BR8vQhTT7YyjWb0gG2HZ6Ye8eBg8=;
	b=jDj/QlC2vhDr5inqxa9qWVgpzx5a50lgDEzL84WMvaqLqM0TD90niujlJohoQtLI2aq++c
	gq30kToUnm5RU/urecwqGooJ3gVmaA6mnjR9yoHbRRBRjRL9/6YkeTwS/1ee2SAtV0dgFk
	CzLN9lar8kpig52KEHRKhNN9wvRbjuHMGcuI6yHFC6+wofVgx6N1W0IGHKP62oG1R6nGoC
	Zz9i+YorOEm9DZ/rULEB65n9/q1CZJTwucrA5n3lB8dkPwW2fZo5ME+aQ9pfbQZ7BtNGfY
	ickuK7EavkRzy5C95ZwC7sENMLTO3OtLvgDOCWZonKM63skp7U8nOzmWh9KNfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQU4AoIpE47h+/6BR8vQhTT7YyjWb0gG2HZ6Ye8eBg8=;
	b=2OEY4SS59ggQZmJ4172VJOlHZZ8PgRQ+Y+fo3qtfCBMmtylI0XC0uQ3V9GtxHT5rfbKxXJ
	sF8gU7vRshTly4Cg==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/bugs: Rename CONFIG_RETHUNK => CONFIG_MITIGATION_RETHUNK
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-11-leitao@debian.org>
References: <20231121160740.1249350-11-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488138781.398.14001450538077237141.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     0911b8c52c4d68c57d02f172daa55a42bce703f0
Gitweb:        https://git.kernel.org/tip/0911b8c52c4d68c57d02f172daa55a42bce703f0
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:37 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:52:29 +01:00

x86/bugs: Rename CONFIG_RETHUNK              => CONFIG_MITIGATION_RETHUNK

Step 10/10 of the namespace unification of CPU mitigations related Kconfig options.

[ mingo: Added one more case. ]

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-11-leitao@debian.org
---
 arch/x86/Kconfig                               | 8 ++++----
 arch/x86/Makefile                              | 2 +-
 arch/x86/configs/i386_defconfig                | 2 +-
 arch/x86/include/asm/disabled-features.h       | 2 +-
 arch/x86/include/asm/linkage.h                 | 4 ++--
 arch/x86/include/asm/nospec-branch.h           | 4 ++--
 arch/x86/include/asm/static_call.h             | 2 +-
 arch/x86/kernel/alternative.c                  | 4 ++--
 arch/x86/kernel/static_call.c                  | 2 +-
 arch/x86/lib/retpoline.S                       | 4 ++--
 scripts/Makefile.lib                           | 2 +-
 tools/arch/x86/include/asm/disabled-features.h | 2 +-
 tools/objtool/check.c                          | 2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a2743b7..0a9fea3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2462,7 +2462,7 @@ config FINEIBT
 
 config HAVE_CALL_THUNKS
 	def_bool y
-	depends on CC_HAS_ENTRY_PADDING && RETHUNK && OBJTOOL
+	depends on CC_HAS_ENTRY_PADDING && MITIGATION_RETHUNK && OBJTOOL
 
 config CALL_THUNKS
 	def_bool n
@@ -2505,7 +2505,7 @@ config MITIGATION_RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-config RETHUNK
+config MITIGATION_RETHUNK
 	bool "Enable return-thunks"
 	depends on MITIGATION_RETPOLINE && CC_HAS_RETURN_THUNK
 	select OBJTOOL if HAVE_OBJTOOL
@@ -2518,7 +2518,7 @@ config RETHUNK
 
 config MITIGATION_UNRET_ENTRY
 	bool "Enable UNRET on kernel entry"
-	depends on CPU_SUP_AMD && RETHUNK && X86_64
+	depends on CPU_SUP_AMD && MITIGATION_RETHUNK && X86_64
 	default y
 	help
 	  Compile the kernel with support for the retbleed=unret mitigation.
@@ -2572,7 +2572,7 @@ config MITIGATION_IBRS_ENTRY
 
 config MITIGATION_SRSO
 	bool "Mitigate speculative RAS overflow on AMD"
-	depends on CPU_SUP_AMD && X86_64 && RETHUNK
+	depends on CPU_SUP_AMD && X86_64 && MITIGATION_RETHUNK
 	default y
 	help
 	  Enable the SRSO mitigation needed on AMD Zen1-4 machines.
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5ce8c30..ba046af 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -22,7 +22,7 @@ RETPOLINE_VDSO_CFLAGS	:= -mretpoline
 endif
 RETPOLINE_CFLAGS	+= $(call cc-option,-mindirect-branch-cs-prefix)
 
-ifdef CONFIG_RETHUNK
+ifdef CONFIG_MITIGATION_RETHUNK
 RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
 RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
 endif
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 73abbbd..9180113 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -42,7 +42,7 @@ CONFIG_EFI_STUB=y
 CONFIG_HZ_1000=y
 CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
-# CONFIG_RETHUNK is not set
+# CONFIG_MITIGATION_RETHUNK is not set
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_TRACE_RTC=y
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 151f0d5..36d0c1e 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -57,7 +57,7 @@
 				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
 #endif
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 # define DISABLE_RETHUNK	0
 #else
 # define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index 09e2d02..dc31b13 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -40,7 +40,7 @@
 
 #ifdef __ASSEMBLY__
 
-#if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
+#if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
 #else /* CONFIG_MITIGATION_RETPOLINE */
 #ifdef CONFIG_MITIGATION_SLS
@@ -52,7 +52,7 @@
 
 #else /* __ASSEMBLY__ */
 
-#if defined(CONFIG_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
+#if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define ASM_RET	"jmp __x86_return_thunk\n\t"
 #else /* CONFIG_MITIGATION_RETPOLINE */
 #ifdef CONFIG_MITIGATION_SLS
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 94c7083..2c0679e 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -289,7 +289,7 @@
  * where we have a stack but before any RET instruction.
  */
 .macro __UNTRAIN_RET ibpb_feature, call_depth_insns
-#if defined(CONFIG_RETHUNK) || defined(CONFIG_MITIGATION_IBPB_ENTRY)
+#if defined(CONFIG_MITIGATION_RETHUNK) || defined(CONFIG_MITIGATION_IBPB_ENTRY)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
@@ -328,7 +328,7 @@ extern retpoline_thunk_t __x86_indirect_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_call_thunk_array[];
 extern retpoline_thunk_t __x86_indirect_jump_thunk_array[];
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 extern void __x86_return_thunk(void);
 #else
 static inline void __x86_return_thunk(void) {}
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 343b722..125c407 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -46,7 +46,7 @@
 #define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 #define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
 	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, "jmp __x86_return_thunk")
 #else
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f5442d0..df91abe 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -769,7 +769,7 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 	}
 }
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 
 /*
  * Rewrite the compiler generated return thunk tail-calls.
@@ -842,7 +842,7 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 }
 #else
 void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
-#endif /* CONFIG_RETHUNK */
+#endif /* CONFIG_MITIGATION_RETHUNK */
 
 #else /* !CONFIG_MITIGATION_RETPOLINE || !CONFIG_OBJTOOL */
 
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 77a9316..4eefaac 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -172,7 +172,7 @@ void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
 }
 EXPORT_SYMBOL_GPL(arch_static_call_transform);
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 /*
  * This is called by apply_returns() to fix up static call trampolines,
  * specifically ARCH_DEFINE_STATIC_CALL_NULL_TRAMP which is recorded as
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 67b52cb..0045153 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -127,7 +127,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 #undef GEN
 #endif
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 
 /*
  * Be careful here: that label cannot really be removed because in
@@ -386,4 +386,4 @@ SYM_CODE_START(__x86_return_thunk)
 SYM_CODE_END(__x86_return_thunk)
 EXPORT_SYMBOL(__x86_return_thunk)
 
-#endif /* CONFIG_RETHUNK */
+#endif /* CONFIG_MITIGATION_RETHUNK */
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b272ca6..c3f4cac 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -263,7 +263,7 @@ objtool-args-$(CONFIG_HAVE_OBJTOOL_NOP_MCOUNT)		+= --mnop
 endif
 objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
 objtool-args-$(CONFIG_MITIGATION_RETPOLINE)		+= --retpoline
-objtool-args-$(CONFIG_RETHUNK)				+= --rethunk
+objtool-args-$(CONFIG_MITIGATION_RETHUNK)		+= --rethunk
 objtool-args-$(CONFIG_MITIGATION_SLS)			+= --sls
 objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
 objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 151f0d5..36d0c1e 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -57,7 +57,7 @@
 				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
 #endif
 
-#ifdef CONFIG_RETHUNK
+#ifdef CONFIG_MITIGATION_RETHUNK
 # define DISABLE_RETHUNK	0
 #else
 # define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 84067f0..8440b7b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3980,7 +3980,7 @@ static int validate_retpoline(struct objtool_file *file)
 
 		if (insn->type == INSN_RETURN) {
 			if (opts.rethunk) {
-				WARN_INSN(insn, "'naked' return found in RETHUNK build");
+				WARN_INSN(insn, "'naked' return found in MITIGATION_RETHUNK build");
 			} else
 				continue;
 		} else {

