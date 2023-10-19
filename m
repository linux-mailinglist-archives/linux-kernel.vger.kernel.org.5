Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B2F7D01DD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346536AbjJSShp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346525AbjJSShh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:37:37 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4F18A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:34 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-507bd64814fso4768148e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740653; x=1698345453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWc/Czxi9t2Z7zlNMCk/LxlIkgK5svsdNAgzUTiKjts=;
        b=tjPb0qtATh4zACDu9bBOXHNnYukEbXDjd9O2LiUJdPpJHFj1baE/RvYKsneg8VkQyZ
         Hx3P0exqEqNuiOpDqs2KPs/Uw0z+2T+H6jXd7/CkMfqxDWD1SPZWauMjMDuGLkMIP5wU
         zO8SEwGjYOvEKxT7zWt12vh1v+BpkypDRiLD43q79HReWEXAiHyJ4heGAEbz/4KF2j4y
         vx9i/bcsf8z0XN9kvYU7LkcKPR0fb58XirlKY9hv6T/SwxI9zuHdAuDPyNWGdqBwKybL
         +wDZcq7QygeWH3m9ogqE4UPqZyoPlc/z9ZmL2gkjZePjSaOdEh5xxF4JozpbH0wPRXJy
         W5ew==
X-Gm-Message-State: AOJu0Yw+CpvA4U/yW52nb4Fn628cSTgb4F5bKEEYgKHj5waKJ6qqkoyg
        y/GksJioUckY6PytWfBxWDM=
X-Google-Smtp-Source: AGHT+IHs6t66gbAClEYrvuNxg3lTOk4qzOwhMX217+nh2fjkHcNIBjepArkgipE3q+XaaayxYtsp0g==
X-Received: by 2002:a05:6512:32ac:b0:502:f2a8:d391 with SMTP id q12-20020a05651232ac00b00502f2a8d391mr2099674lfe.45.1697740652898;
        Thu, 19 Oct 2023 11:37:32 -0700 (PDT)
Received: from localhost (fwdproxy-cln-003.fbsv.net. [2a03:2880:31ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id s24-20020a50ab18000000b0053de19620b9sm67412edc.2.2023.10.19.11.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:37:32 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     leit@meta.com, Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v5 09/12] x86/bugs: Rename CPU_SRSO to MITIGATION_SRSO
Date:   Thu, 19 Oct 2023 11:11:55 -0700
Message-Id: <20231019181158.1982205-10-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019181158.1982205-1-leitao@debian.org>
References: <20231019181158.1982205-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU mitigations config entries are inconsistent, and names are hard to
related. There are concrete benefits for both users and developers of
having all the mitigation config options living in the same config
namespace.

The mitigation options should have consistency and start with
MITIGATION.

Rename the Kconfig entry from CPU_SRSO to MITIGATION_SRSO.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
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
index c53d2034a5ab..97004db07e38 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2549,7 +2549,7 @@ config MITIGATION_IBRS_ENTRY
 	  This mitigates both spectre_v2 and retbleed at great cost to
 	  performance.
 
-config CPU_SRSO
+config MITIGATION_SRSO
 	bool "Mitigate speculative RAS overflow on AMD"
 	depends on CPU_SUP_AMD && X86_64 && RETHUNK
 	default y
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index e25e98f012a3..9ea93a298a43 100644
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
index e11bacbd8f39..f2775417bda2 100644
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
index f5ee96a7bdd6..f54a4cf01a43 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -139,7 +139,7 @@ SECTIONS
 		*(.text..__x86.rethunk_untrain)
 		ENTRY_TEXT
 
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_MITIGATION_SRSO
 		/*
 		 * See the comment above srso_alias_untrain_ret()'s
 		 * definition.
@@ -518,7 +518,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
 
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_MITIGATION_SRSO
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 /*
  * GNU ld cannot do XOR until 2.41.
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 03a065ef57ae..7834bde8afd1 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -129,7 +129,7 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
 
 #ifdef CONFIG_RETHUNK
 
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_MITIGATION_SRSO
 
 /*
  * srso_alias_untrain_ret() and srso_alias_safe_ret() are placed at
@@ -216,10 +216,10 @@ SYM_CODE_END(srso_return_thunk)
 
 #define JMP_SRSO_UNTRAIN_RET "jmp srso_untrain_ret"
 #define JMP_SRSO_ALIAS_UNTRAIN_RET "jmp srso_alias_untrain_ret"
-#else /* !CONFIG_CPU_SRSO */
+#else /* !CONFIG_MITIGATION_SRSO */
 #define JMP_SRSO_UNTRAIN_RET "ud2"
 #define JMP_SRSO_ALIAS_UNTRAIN_RET "ud2"
-#endif /* CONFIG_CPU_SRSO */
+#endif /* CONFIG_MITIGATION_SRSO */
 
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
 
@@ -307,7 +307,7 @@ SYM_FUNC_END(retbleed_untrain_ret)
 #define JMP_RETBLEED_UNTRAIN_RET "ud2"
 #endif /* CONFIG_MITIGATION_UNRET_ENTRY */
 
-#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_CPU_SRSO)
+#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO)
 
 SYM_FUNC_START(entry_untrain_ret)
 	ALTERNATIVE_2 JMP_RETBLEED_UNTRAIN_RET,				\
@@ -316,7 +316,7 @@ SYM_FUNC_START(entry_untrain_ret)
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
-#endif /* CONFIG_MITIGATION_UNRET_ENTRY || CONFIG_CPU_SRSO */
+#endif /* CONFIG_MITIGATION_UNRET_ENTRY || CONFIG_MITIGATION_SRSO */
 
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index d030671a4c49..b3b8d3dab52d 100644
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
index 6277dbd730bb..6de297916ce6 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -38,7 +38,7 @@ objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
 vmlinux-objtool-args-$(delay-objtool)			+= $(objtool-args-y)
 vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
-							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_CPU_SRSO)), --unret)
+							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)
 
 objtool-args = $(vmlinux-objtool-args-y) --link
 
-- 
2.34.1

