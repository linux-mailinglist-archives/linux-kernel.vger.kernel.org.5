Return-Path: <linux-kernel+bounces-21947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E98296FA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFB1287476
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C14122B;
	Wed, 10 Jan 2024 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wjqDON/F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WJ/ZSFGB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398CF3EA81;
	Wed, 10 Jan 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmjPMlCY6mggEjSp9omIeR7FhGZo4f4pa/mJqNQY2dQ=;
	b=wjqDON/FqSE64xqVZTYR2DemmyeODIBcH72y3zwBGZaxR6/9mu5oZnimuBpsoaYKLPz0s4
	ml8FuL4T0ZPflzXzDYv7E59ljyUEHdTLqDf4kb6RHPrEHDw1rGWJqaAw2DrlxAxScPCM+l
	f72o+AYEWqHd1qV7vg6R+niiK+5GxEBHj5YMjNmsykfPlAnEfMifJUXnbZKslozXfhf1Pl
	qVLtqA9+rrGhG7pYawIwLNqaOI5e3qaDmDi6JTzJ86icn5UgfEUA3sdCbFMZmmD8RjEF0O
	j97pI3+kTmyU/ohSMONVqQTm5vlvEdq3GP9ZF1RwxJLC16K8KxXYePITCZcEUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmjPMlCY6mggEjSp9omIeR7FhGZo4f4pa/mJqNQY2dQ=;
	b=WJ/ZSFGB4DQAsX9X++K7dFSmErjX0F+OdKhUcPN/V31HS8TluVpixRqjkS4PYnnme8SSoe
	bxdJZUfZzID+5EDQ==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Rename CONFIG_CALL_DEPTH_TRACKING =>
 CONFIG_MITIGATION_CALL_DEPTH_TRACKING
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-4-leitao@debian.org>
References: <20231121160740.1249350-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488139368.398.16441127805317367292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     5fa31af31e726c7f5a8f84800153054ca499338a
Gitweb:        https://git.kernel.org/tip/5fa31af31e726c7f5a8f84800153054ca499338a
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:30 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:52:28 +01:00

x86/bugs: Rename CONFIG_CALL_DEPTH_TRACKING  => CONFIG_MITIGATION_CALL_DEPTH_TRACKING

Step 3/10 of the namespace unification of CPU mitigations related Kconfig options.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-4-leitao@debian.org
---
 arch/x86/Kconfig                               |  4 ++--
 arch/x86/include/asm/current.h                 |  2 +-
 arch/x86/include/asm/disabled-features.h       |  2 +-
 arch/x86/include/asm/nospec-branch.h           | 10 +++++-----
 arch/x86/kernel/asm-offsets.c                  |  2 +-
 arch/x86/kernel/cpu/bugs.c                     |  6 +++---
 arch/x86/lib/retpoline.S                       |  6 +++---
 scripts/Makefile.lib                           |  2 +-
 tools/arch/x86/include/asm/disabled-features.h |  2 +-
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c4e04b6..b4a703d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2523,7 +2523,7 @@ config CPU_UNRET_ENTRY
 	help
 	  Compile the kernel with support for the retbleed=unret mitigation.
 
-config CALL_DEPTH_TRACKING
+config MITIGATION_CALL_DEPTH_TRACKING
 	bool "Mitigate RSB underflow with call depth tracking"
 	depends on CPU_SUP_INTEL && HAVE_CALL_THUNKS
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
@@ -2543,7 +2543,7 @@ config CALL_DEPTH_TRACKING
 
 config CALL_THUNKS_DEBUG
 	bool "Enable call thunks and call depth tracking debugging"
-	depends on CALL_DEPTH_TRACKING
+	depends on MITIGATION_CALL_DEPTH_TRACKING
 	select FUNCTION_ALIGNMENT_32B
 	default n
 	help
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index a1168e7..d4ff517 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -17,7 +17,7 @@ struct pcpu_hot {
 			struct task_struct	*current_task;
 			int			preempt_count;
 			int			cpu_number;
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 			u64			call_depth;
 #endif
 			unsigned long		top_of_stack;
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 702d93f..c1d3a57 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -69,7 +69,7 @@
 # define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
 #endif
 
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 # define DISABLE_CALL_DEPTH_TRACKING	0
 #else
 # define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 7341fd9..5981023 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -73,7 +73,7 @@
 # define CALL_THUNKS_DEBUG_INC_CTXSW
 #endif
 
-#if defined(CONFIG_CALL_DEPTH_TRACKING) && !defined(COMPILE_OFFSETS)
+#if defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING) && !defined(COMPILE_OFFSETS)
 
 #include <asm/asm-offsets.h>
 
@@ -309,7 +309,7 @@
 
 
 .macro CALL_DEPTH_ACCOUNT
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 	ALTERNATIVE "",							\
 		    __stringify(ASM_INCREMENT_CALL_DEPTH), X86_FEATURE_CALL_DEPTH
 #endif
@@ -357,7 +357,7 @@ extern void entry_ibpb(void);
 
 extern void (*x86_return_thunk)(void);
 
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 extern void call_depth_return_thunk(void);
 
 #define CALL_DEPTH_ACCOUNT					\
@@ -371,12 +371,12 @@ DECLARE_PER_CPU(u64, __x86_ret_count);
 DECLARE_PER_CPU(u64, __x86_stuffs_count);
 DECLARE_PER_CPU(u64, __x86_ctxsw_count);
 #endif
-#else /* !CONFIG_CALL_DEPTH_TRACKING */
+#else /* !CONFIG_MITIGATION_CALL_DEPTH_TRACKING */
 
 static inline void call_depth_return_thunk(void) {}
 #define CALL_DEPTH_ACCOUNT ""
 
-#endif /* CONFIG_CALL_DEPTH_TRACKING */
+#endif /* CONFIG_MITIGATION_CALL_DEPTH_TRACKING */
 
 #ifdef CONFIG_RETPOLINE
 
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 6913b37..a98020b 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -109,7 +109,7 @@ static void __used common(void)
 	OFFSET(TSS_sp2, tss_struct, x86_tss.sp2);
 	OFFSET(X86_top_of_stack, pcpu_hot, top_of_stack);
 	OFFSET(X86_current_task, pcpu_hot, current_task);
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 	OFFSET(X86_call_depth, pcpu_hot, call_depth);
 #endif
 #if IS_ENABLED(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64)
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1de4791..b906ed4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1003,15 +1003,15 @@ static void __init retbleed_select_mitigation(void)
 		break;
 
 	case RETBLEED_CMD_STUFF:
-		if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING) &&
+		if (IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING) &&
 		    spectre_v2_enabled == SPECTRE_V2_RETPOLINE) {
 			retbleed_mitigation = RETBLEED_MITIGATION_STUFF;
 
 		} else {
-			if (IS_ENABLED(CONFIG_CALL_DEPTH_TRACKING))
+			if (IS_ENABLED(CONFIG_MITIGATION_CALL_DEPTH_TRACKING))
 				pr_err("WARNING: retbleed=stuff depends on spectre_v2=retpoline\n");
 			else
-				pr_err("WARNING: kernel not compiled with CALL_DEPTH_TRACKING.\n");
+				pr_err("WARNING: kernel not compiled with MITIGATION_CALL_DEPTH_TRACKING.\n");
 
 			goto do_cmd_auto;
 		}
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 7b25898..ff46f48 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -71,7 +71,7 @@ SYM_CODE_END(__x86_indirect_thunk_array)
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 .macro CALL_THUNK reg
 	.align RETPOLINE_THUNK_SIZE
 
@@ -327,7 +327,7 @@ __EXPORT_THUNK(entry_untrain_ret)
 
 #endif /* CONFIG_CPU_UNRET_ENTRY || CONFIG_CPU_SRSO */
 
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 
 	.align 64
 SYM_FUNC_START(call_depth_return_thunk)
@@ -359,7 +359,7 @@ SYM_FUNC_START(call_depth_return_thunk)
 	int3
 SYM_FUNC_END(call_depth_return_thunk)
 
-#endif /* CONFIG_CALL_DEPTH_TRACKING */
+#endif /* CONFIG_MITIGATION_CALL_DEPTH_TRACKING */
 
 /*
  * This function name is magical and is used by -mfunction-return=thunk-extern
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1a965fe..ee233ef 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -254,7 +254,7 @@ objtool := $(objtree)/tools/objtool/objtool
 
 objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
-objtool-args-$(CONFIG_CALL_DEPTH_TRACKING)		+= --hacks=skylake
+objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --hacks=skylake
 objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
 objtool-args-$(CONFIG_FINEIBT)				+= --cfi
 objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 702d93f..c1d3a57 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -69,7 +69,7 @@
 # define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
 #endif
 
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 # define DISABLE_CALL_DEPTH_TRACKING	0
 #else
 # define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))

