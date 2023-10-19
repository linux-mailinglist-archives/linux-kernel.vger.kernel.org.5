Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B07D01D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbjJSShc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjJSSh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:37:27 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860BA18D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:20 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so2367510a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740639; x=1698345439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkoW5aQMoYpr1B6dX9DBsDIJXLRfmJm42oJji+E7lfc=;
        b=N/zvqnKYWPT6hhX1sOlKfRabMBJVh0z8pLvjfntHrsnpzLL+DquQQmxgMSZiE0YCA5
         p8Mj24uZmjri617k3CEde8P1dTk8j0qQsKXNFXrApDfDWT42JSHrDI6bT6XtHu76CVdi
         GANLGFlM36aotG8mAJJuO2o0PeeiFWwsbqJkZUu+yWa3fL42T9WlkJmukebd/KwQRiDU
         rmE56xcTsxgu8R4nVRaAYMNrZ3Ms0u6w0l/ZwDEek4Mrr3wOMG/UqQUKuOpufP8HcFhh
         qIIPcTjA6PpVxB0uYmMbuY+e5v8sHNog+BnORpcfD66jExYAB4sHy6JWi4D9b8wjgt/X
         V6fg==
X-Gm-Message-State: AOJu0YzmcnIG4epP9cqZSOJo5TypIw/aEcOZ3LlH+ongFStGpLwUySjp
        4g9pRgYhH2gi9taqoHsa5Co=
X-Google-Smtp-Source: AGHT+IGZOnsQhJVuyPDMimbttYyYi4HGjt5UNBosM+BByJ70RMmM0ysu7XDhc7WiF/KMLTwGC5bVkA==
X-Received: by 2002:a17:907:c205:b0:9ae:50ec:bd81 with SMTP id ti5-20020a170907c20500b009ae50ecbd81mr2258719ejc.21.1697740638313;
        Thu, 19 Oct 2023 11:37:18 -0700 (PDT)
Received: from localhost (fwdproxy-cln-004.fbsv.net. [2a03:2880:31ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id c21-20020a50d655000000b00537963f692esm81680edj.0.2023.10.19.11.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:37:17 -0700 (PDT)
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
Cc:     leit@meta.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Alexey Kardashevskiy <aik@amd.com>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v5 07/12] x86/bugs: Rename CPU_UNRET_ENTRY to MITIGATION_UNRET_ENTRY
Date:   Thu, 19 Oct 2023 11:11:53 -0700
Message-Id: <20231019181158.1982205-8-leitao@debian.org>
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

Rename the Kconfig entry from CPU_UNRET_ENTRY to MITIGATION_UNRET_ENTRY.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
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
index 9dd2fb555973..0e4c0c5c4818 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2495,7 +2495,7 @@ config RETHUNK
 	  Requires a compiler with -mfunction-return=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-config CPU_UNRET_ENTRY
+config MITIGATION_UNRET_ENTRY
 	bool "Enable UNRET on kernel entry"
 	depends on CPU_SUP_AMD && RETHUNK && X86_64
 	default y
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 24e4010c33b6..151f0d50e7e0 100644
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
index cab7c937c71b..e25e98f012a3 100644
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
index a8e042a685ba..0cf52efc7617 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -943,7 +943,7 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 
 void init_spectral_chicken(struct cpuinfo_x86 *c)
 {
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 	u64 value;
 
 	/*
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index fc46fd6447f9..2580368c32d1 100644
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
@@ -1021,7 +1021,7 @@ static void __init retbleed_select_mitigation(void)
 	case RETBLEED_CMD_AUTO:
 		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
+			if (IS_ENABLED(CONFIG_MITIGATION_UNRET_ENTRY))
 				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
 			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
 				 boot_cpu_has(X86_FEATURE_IBPB))
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 68654303c98e..f5ee96a7bdd6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -514,7 +514,7 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 910fd231b7d2..03a065ef57ae 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -221,7 +221,7 @@ SYM_CODE_END(srso_return_thunk)
 #define JMP_SRSO_ALIAS_UNTRAIN_RET "ud2"
 #endif /* CONFIG_CPU_SRSO */
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 
 /*
  * Some generic notes on the untraining sequences:
@@ -303,11 +303,11 @@ SYM_CODE_END(retbleed_return_thunk)
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
@@ -316,7 +316,7 @@ SYM_FUNC_START(entry_untrain_ret)
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
 
-#endif /* CONFIG_CPU_UNRET_ENTRY || CONFIG_CPU_SRSO */
+#endif /* CONFIG_MITIGATION_UNRET_ENTRY || CONFIG_CPU_SRSO */
 
 #ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 33212e93f4a6..d030671a4c49 100644
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
index 25b3b587d37c..6277dbd730bb 100644
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
index d05158d8fe5f..4b816f55c634 100644
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
-- 
2.34.1

