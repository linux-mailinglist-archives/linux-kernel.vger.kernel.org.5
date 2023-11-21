Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC2F7F349C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjKURMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjKURMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:12:40 -0500
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6DDD5E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:30 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a02ba1f500fso102302566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586748; x=1701191548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dj1Fm2Z6ibOj2G6AWI6Ibd2txGpzCjio2XWTXOBhKHc=;
        b=dgOU+zphwEdIQN9Zruij3Lts3NzKrGJwL6Xya6o2EPs+/GqLQc6N1sxPV0sZPLOSFo
         PyzpjU6zABGdA4OWq4m/NoxMxBR+oc3Fhmpw2+WDd7W8TbGHR+EZH/oN5xkYzbaZsxLb
         7xlxKHfgPLQW02gVVMZ9TgZXfReDOcb2O5vp/nL00fNWg4onEcy4wsJQuJTHJNdzIzHF
         yOwixqYitdg/CWUYp1skiSPZR64x5HaxSW9EHU3uYDh76Mcl379spHT+ew/9lOkmkPW4
         s1Hol5LztfYJ+EtvM3MTJDq6T28q1AfX4kdmz55mDNj1Zr56OXFwNlgAaTyxBdZC3AdS
         acYQ==
X-Gm-Message-State: AOJu0YxBF67eCYSP+UlfY0iWkTvMI8XKp0WpcFc/1H8pHnpnGwH4Ax04
        MZZxyZZqwqyARf800exBcP7UEsbeWawYYCWe
X-Google-Smtp-Source: AGHT+IGYdVkcHyBFHDfu+sJtQw72uQKwkWjcCu5wDSloTgtO+6uEriUhqMqyAUKLDLUEbfilH291aw==
X-Received: by 2002:a17:906:1005:b0:9d3:e48f:30d3 with SMTP id 5-20020a170906100500b009d3e48f30d3mr8595051ejm.31.1700586748379;
        Tue, 21 Nov 2023 09:12:28 -0800 (PST)
Received: from localhost (fwdproxy-cln-120.fbsv.net. [2a03:2880:31ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id y5-20020a170906524500b009e6cedc8bf5sm5454082ejm.29.2023.11.21.09.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:12:28 -0800 (PST)
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
Cc:     leit@meta.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, Song Liu <song@kernel.org>
Subject: [PATCH v6 09/13] x86/bugs: Rename CPU_SRSO to MITIGATION_SRSO
Date:   Tue, 21 Nov 2023 08:07:36 -0800
Message-Id: <20231121160740.1249350-10-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>
References: <20231121160740.1249350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
index 392e94fded3d..30c2f880caf9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2573,7 +2573,7 @@ config MITIGATION_IBRS_ENTRY
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
index d7ee79b6756f..8d1143ab05b7 100644
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
@@ -521,7 +521,7 @@ INIT_PER_CPU(irq_stack_backing_store);
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
 
-#ifdef CONFIG_CPU_SRSO
+#ifdef CONFIG_MITIGATION_SRSO
 . = ASSERT((srso_safe_ret & 0x3f) == 0, "srso_safe_ret not cacheline-aligned");
 /*
  * GNU ld cannot do XOR until 2.41.
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 0ad67ccadd4c..67b52cbec648 100644
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

