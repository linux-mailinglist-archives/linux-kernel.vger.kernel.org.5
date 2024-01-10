Return-Path: <linux-kernel+bounces-21943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226478296F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86CE01F27941
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C677D3FE31;
	Wed, 10 Jan 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ee6EG124";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6TTgN2vV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7053F8F0;
	Wed, 10 Jan 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avD0hFI5IDODXOuzjPvbSAN4tgIsN8vG5JRG1BIckxA=;
	b=Ee6EG124udTMPOcJ7A1QVZxWxiPZjC2ytKymleVZtdH9Us2qfdCRog920k3W9vkReIQAf+
	MV3CW3kWVO2wxCR7uROJcdWbBGFwB8iV4KJQ6r00F8f6IbV/2XjQ5pvscSProcKSp3SMmy
	WYz2PoHxOEvIYy68qo+4yc+tNVZ6rYk4iNhk5PGMluDzc41J6kkaX81IGNl8VBbzkSXgci
	vuSYLd44J6iKHkyomqV3/Mj4s81ZgDEA4ZKN3nYCKu88k8hvYUHy0UqIYPEzwEfOJTCgW2
	ftbxcorZaOCgxhyM89xTJAS8qdZuXwOUMbCX72C/UK8cloVB7s/qoxxFbYIcyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avD0hFI5IDODXOuzjPvbSAN4tgIsN8vG5JRG1BIckxA=;
	b=6TTgN2vVH5b1qng8LPhawSGUFOJadOBEy5clmc6CwtiG7mB7/Y73rNo/gCKvbm7dHsh/qT
	QfxWApz0/xrr5GBQ==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Rename CONFIG_CPU_UNRET_ENTRY =>
 CONFIG_MITIGATION_UNRET_ENTRY
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-8-leitao@debian.org>
References: <20231121160740.1249350-8-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488139025.398.2728999211386077984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     ac61d43983a4fe8e3ee600eee44c40868c14340a
Gitweb:        https://git.kernel.org/tip/ac61d43983a4fe8e3ee600eee44c40868c14340a
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:34 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:52:28 +01:00

x86/bugs: Rename CONFIG_CPU_UNRET_ENTRY      => CONFIG_MITIGATION_UNRET_ENTRY

Step 7/10 of the namespace unification of CPU mitigations related Kconfig options.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-8-leitao@debian.org
---
 arch/x86/Kconfig                               |  2 +-
 arch/x86/include/asm/disabled-features.h       |  2 +-
 arch/x86/include/asm/nospec-branch.h           |  6 +++---
 arch/x86/kernel/cpu/amd.c                      |  2 +-
 arch/x86/kernel/cpu/bugs.c                     |  6 +++---
 arch/x86/kernel/vmlinux.lds.S                  |  2 +-
 arch/x86/lib/retpoline.S                       | 10 +++++-----
 include/linux/objtool.h                        |  2 +-
 scripts/Makefile.vmlinux_o                     |  2 +-
 tools/arch/x86/include/asm/disabled-features.h |  2 +-
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba45465..77b8769 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2516,7 +2516,7 @@ config RETHUNK
 	  Requires a compiler with -mfunction-return=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-config CPU_UNRET_ENTRY
+config MITIGATION_UNRET_ENTRY
 	bool "Enable UNRET on kernel entry"
 	depends on CPU_SUP_AMD && RETHUNK && X86_64
 	default y
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 24e4010..151f0d5 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -63,7 +63,7 @@
 # define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
 #endif
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 # define DISABLE_UNRET		0
 #else
 # define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 32680cb..9747869 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -212,7 +212,7 @@
  */
 .macro VALIDATE_UNRET_END
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
-	(defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
+	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
 	ANNOTATE_RETPOLINE_SAFE
 	nop
 #endif
@@ -271,7 +271,7 @@
 .Lskip_rsb_\@:
 .endm
 
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
+#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
 #define CALL_UNTRAIN_RET	"call entry_untrain_ret"
 #else
 #define CALL_UNTRAIN_RET	""
@@ -334,7 +334,7 @@ extern void __x86_return_thunk(void);
 static inline void __x86_return_thunk(void) {}
 #endif
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 extern void retbleed_return_thunk(void);
 #else
 static inline void retbleed_return_thunk(void) {}
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 9f42d1c..6c7db2e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -928,7 +928,7 @@ static void fix_erratum_1386(struct cpuinfo_x86 *c)
 
 void init_spectral_chicken(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 	u64 value;
 
 	/*
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fc46fd6..2580368 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -982,10 +982,10 @@ static void __init retbleed_select_mitigation(void)
 		return;
 
 	case RETBLEED_CMD_UNRET:
-		if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY)) {
+		if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY)) {
 			retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
 		} else {
-			pr_err("WARNING: kernel not compiled with CPU_UNRET_ENTRY.\n");
+			pr_err("WARNING: kernel not compiled with MITIGATION_UNRET_ENTRY.\n");
 			goto do_cmd_auto;
 		}
 		break;
@@ -1021,7 +1021,7 @@ do_cmd_auto:
 	case RETBLEED_CMD_AUTO:
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
+			if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
 				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
 			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
 				 boot_cpu_has(X86_FEATURE_IBPB))
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bb2ec03..9c5cca5 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -504,7 +504,7 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index ff46f48..0ad67cc 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -230,7 +230,7 @@ SYM_CODE_END(srso_return_thunk)
 #define JMP_SRSO_ALIAS_UNTRAIN_RET "ud2"
 #endif /* CONFIG_CPU_SRSO */
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 
 /*
  * Some generic notes on the untraining sequences:
@@ -312,11 +312,11 @@ SYM_CODE_END(retbleed_return_thunk)
 SYM_FUNC_END(retbleed_untrain_ret)
 
 #define JMP_RETBLEED_UNTRAIN_RET "jmp retbleed_untrain_ret"
-#else /* !CONFIG_CPU_UNRET_ENTRY */
+#else /* !CONFIG_MITIGATION_UNRET_ENTRY */
 #define JMP_RETBLEED_UNTRAIN_RET "ud2"
-#endif /* CONFIG_CPU_UNRET_ENTRY */
+#endif /* CONFIG_MITIGATION_UNRET_ENTRY */
 
-#if defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
+#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
 
 SYM_FUNC_START(entry_untrain_ret)
 	ALTERNATIVE_2 JMP_RETBLEED_UNTRAIN_RET,				\
@@ -325,7 +325,7 @@ SYM_FUNC_START(entry_untrain_ret)
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
-#endif /* CONFIG_CPU_UNRET_ENTRY || CONFIG_CPU_SRSO */
+#endif /* CONFIG_MITIGATION_UNRET_ENTRY || CONFIG_CPU_SRSO */
 
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 33212e9..d030671 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -131,7 +131,7 @@
  */
 .macro VALIDATE_UNRET_BEGIN
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
-	(defined(CONFIG_CPU_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
+	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
 .Lhere_\@:
 	.pushsection .discard.validate_unret
 	.long	.Lhere_\@ - .
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 25b3b58..6277dbd 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -38,7 +38,7 @@ objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
 vmlinux-objtool-args-$(delay-objtool)			+= $(objtool-args-y)
 vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
-							   $(if $(or $(CONFIG_CPU_UNRET_ENTRY),$(CONFIG_CPU_SRSO)), --unret)
+							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_CPU_SRSO)), --unret)
 
 objtool-args = $(vmlinux-objtool-args-y) --link
 
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 24e4010..151f0d5 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -63,7 +63,7 @@
 # define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
 #endif
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 # define DISABLE_UNRET		0
 #else
 # define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))

