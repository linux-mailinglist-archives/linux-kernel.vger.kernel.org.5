Return-Path: <linux-kernel+bounces-21940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8848296EF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0AC2817A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB93FB15;
	Wed, 10 Jan 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zl9JQuE+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HyGjmC4G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618873F8E3;
	Wed, 10 Jan 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nkFx8AYqJrNjQRiDKDdFKbzEbKQ8jt9NlNicsib4kE=;
	b=zl9JQuE+t9fNAwFBOxGaFAGBq6fLwhh/8plPZ6m42rk9hLh/G5a02iO7tXPdHHd7ONgZRv
	94/1Bm9QquGFM8pzi4mjw+EWarpIou9c5IQnUGmmgDvOwl7buYAE2htLI1qQAapsenGxzN
	Obil1KZX9P2nu4/M6gZGNoixMNSNCTbJoCCSthRo5govd07gAHcfC+wmdkmhN3Zy4hYvWj
	eO0FWv7ZM2YSacYYW7AO63+iMp1T1dLWcKwnXGnj/ptkh8YVYLLGmm+U3WwufJv4Z4oEsz
	+5q5CA6CElDIDNDBDA15GaaA83BSA8ejQQu74i2/OgNQjN5j3VUKS7CIlQg6Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+nkFx8AYqJrNjQRiDKDdFKbzEbKQ8jt9NlNicsib4kE=;
	b=HyGjmC4GDGQcZBMzIWuvmBHKv1rGungRAPQDEp/JEDbj9CmwT2+Qg4r7UJbsALKRrJcC/+
	jK6v9B0wkqhp7ZDQ==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/bugs: Rename CONFIG_CPU_SRSO => CONFIG_MITIGATION_SRSO
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-10-leitao@debian.org>
References: <20231121160740.1249350-10-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488138869.398.6885922208313393779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     a033eec9a06ce25388e71fa1e888792a718b9c17
Gitweb:        https://git.kernel.org/tip/a033eec9a06ce25388e71fa1e888792a718b9c17
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:36 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:52:29 +01:00

x86/bugs: Rename CONFIG_CPU_SRSO             => CONFIG_MITIGATION_SRSO

Step 9/10 of the namespace unification of CPU mitigations related Kconfig options.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-10-leitao@debian.org
---
 arch/x86/Kconfig                     |  2 +-
 arch/x86/include/asm/nospec-branch.h |  6 +++---
 arch/x86/kernel/cpu/bugs.c           |  8 ++++----
 arch/x86/kernel/vmlinux.lds.S        |  4 ++--
 arch/x86/lib/retpoline.S             | 10 +++++-----
 include/linux/objtool.h              |  2 +-
 scripts/Makefile.vmlinux_o           |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 60d38df..a2743b7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2570,7 +2570,7 @@ config MITIGATION_IBRS_ENTRY
 	  This mitigates both spectre_v2 and retbleed at great cost to
 	  performance.
 
-config CPU_SRSO
+config MITIGATION_SRSO
 	bool "Mitigate speculative RAS overflow on AMD"
 	depends on CPU_SUP_AMD && X86_64 && RETHUNK
 	default y
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 9747869..94c7083 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -212,7 +212,7 @@
  */
 .macro VALIDATE_UNRET_END
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
-	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
+	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO))
 	ANNOTATE_RETPOLINE_SAFE
 	nop
 #endif
@@ -271,7 +271,7 @@
 .Lskip_rsb_\@:
 .endm
 
-#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
+#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO)
 #define CALL_UNTRAIN_RET	"call entry_untrain_ret"
 #else
 #define CALL_UNTRAIN_RET	""
@@ -340,7 +340,7 @@ extern void retbleed_return_thunk(void);
 static inline void retbleed_return_thunk(void) {}
 #endif
 
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_MITIGATION_SRSO
 extern void srso_return_thunk(void);
 extern void srso_alias_return_thunk(void);
 #else
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e11bacb..f277541 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2458,7 +2458,7 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_SAFE_RET:
-		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
+		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
 			/*
 			 * Enable the return thunk for generated code
 			 * like ftrace, static_call, etc.
@@ -2478,7 +2478,7 @@ static void __init srso_select_mitigation(void)
 			else
 				srso_mitigation = SRSO_MITIGATION_SAFE_RET_UCODE_NEEDED;
 		} else {
-			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
+			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
 		}
 		break;
 
@@ -2494,13 +2494,13 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_IBPB_ON_VMEXIT:
-		if (IS_ENABLED(CONFIG_CPU_SRSO)) {
+		if (IS_ENABLED(CONFIG_MITIGATION_SRSO)) {
 			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
 			}
 		} else {
-			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");
+			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
                 }
 		break;
 	}
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9c5cca5..6716fcc 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -142,7 +142,7 @@ SECTIONS
 		*(.text..__x86.rethunk_untrain)
 		ENTRY_TEXT
 
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_MITIGATION_SRSO
 		/*
 		 * See the comment above srso_alias_untrain_ret()'s
 		 * definition.
@@ -508,7 +508,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
 
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_MITIGATION_SRSO
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 /*
  * GNU ld cannot do XOR until 2.41.
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 0ad67cc..67b52cb 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -138,7 +138,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
  */
 	.section .text..__x86.return_thunk
 
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_MITIGATION_SRSO
 
 /*
  * srso_alias_untrain_ret() and srso_alias_safe_ret() are placed at
@@ -225,10 +225,10 @@ SYM_CODE_END(srso_return_thunk)
 
 #define JMP_SRSO_UNTRAIN_RET "jmp srso_untrain_ret"
 #define JMP_SRSO_ALIAS_UNTRAIN_RET "jmp srso_alias_untrain_ret"
-#else /* !CONFIG_CPU_SRSO */
+#else /* !CONFIG_MITIGATION_SRSO */
 #define JMP_SRSO_UNTRAIN_RET "ud2"
 #define JMP_SRSO_ALIAS_UNTRAIN_RET "ud2"
-#endif /* CONFIG_CPU_SRSO */
+#endif /* CONFIG_MITIGATION_SRSO */
 
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
 
@@ -316,7 +316,7 @@ SYM_FUNC_END(retbleed_untrain_ret)
 #define JMP_RETBLEED_UNTRAIN_RET "ud2"
 #endif /* CONFIG_MITIGATION_UNRET_ENTRY */
 
-#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
+#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO)
 
 SYM_FUNC_START(entry_untrain_ret)
 	ALTERNATIVE_2 JMP_RETBLEED_UNTRAIN_RET,				\
@@ -325,7 +325,7 @@ SYM_FUNC_START(entry_untrain_ret)
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
-#endif /* CONFIG_MITIGATION_UNRET_ENTRY || CONFIG_CPU_SRSO */
+#endif /* CONFIG_MITIGATION_UNRET_ENTRY || CONFIG_MITIGATION_SRSO */
 
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index d030671..b3b8d3d 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -131,7 +131,7 @@
  */
 .macro VALIDATE_UNRET_BEGIN
 #if defined(CONFIG_NOINSTR_VALIDATION) && \
-	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO))
+	(defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO))
 .Lhere_\@:
 	.pushsection .discard.validate_unret
 	.long	.Lhere_\@ - .
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 6277dbd..6de2979 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -38,7 +38,7 @@ objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
 vmlinux-objtool-args-$(delay-objtool)			+= $(objtool-args-y)
 vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
-							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_CPU_SRSO)), --unret)
+							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
 
 objtool-args = $(vmlinux-objtool-args-y) --link
 

