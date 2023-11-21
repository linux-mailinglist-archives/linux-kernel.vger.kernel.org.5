Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD37F349A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjKURMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjKURM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:12:27 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34011D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:22 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-548d1f8b38bso3173663a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586740; x=1701191540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+29rFi7IZ4J3EvGGeVN0SYZV9YfXsGNpNAe1Tz2Ke1w=;
        b=g6aYA+ApU8U0YC/nGvApxHorw49i9u1WDhoGUFDpl3r9yHwvAD3le5V+bBCw37R8us
         rvkc5/TymbAmOT1Mqhi1mDhclust9gDxL25dEkRirhH/iB2kqBIGCyJ1gmzEkfBRyVI+
         9sK4Rmj2tH/W514E4xa9GBBAFIYSzrq22jiglHZIGKjIFxQqla5an+96H835iz//V5aM
         3dZBlR+BxYRhiXJCyZCbx6z47YdpGvBrkIq2IPN6E7I9+CeDkaByPrhbHCNZPFT0idFt
         xKrLrYXYAfxL/VJIIgTlxCiU7069gQMAxFIIME2rg/eZvdfztFjEUg4NIp6jf6WVWewK
         BJCw==
X-Gm-Message-State: AOJu0Yw+66nSvQFSycPEQqo/4DLDbNlmRSOkyhYrfsq1PBGJDBrv/1Gs
        A0bDXl5JWYroNbJQ0M4Di6E=
X-Google-Smtp-Source: AGHT+IHFQ53LNgQjNWGI7oe3mOYufW+6Ca9/Af72jgp8uVnll6GjFsQqbEiMCW9vBiV1clfN3JPDAg==
X-Received: by 2002:a17:906:11:b0:9cc:450c:b0d5 with SMTP id 17-20020a170906001100b009cc450cb0d5mr8260806eja.4.1700586740457;
        Tue, 21 Nov 2023 09:12:20 -0800 (PST)
Received: from localhost (fwdproxy-cln-116.fbsv.net. [2a03:2880:31ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id cm28-20020a170906f59c00b009fcb5fcfbe6sm3290557ejd.220.2023.11.21.09.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:12:20 -0800 (PST)
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
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Alexey Kardashevskiy <aik@amd.com>,
        Petr Pavlu <petr.pavlu@suse.com>, Song Liu <song@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v6 07/13] x86/bugs: Rename CPU_UNRET_ENTRY to MITIGATION_UNRET_ENTRY
Date:   Tue, 21 Nov 2023 08:07:34 -0800
Message-Id: <20231121160740.1249350-8-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>
References: <20231121160740.1249350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index fa246de60cdb..fa078d3655ff 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2519,7 +2519,7 @@ config RETHUNK
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
index a7eab05e5f29..8d38299cec83 100644
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
index 985984919d81..d7ee79b6756f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -517,7 +517,7 @@ INIT_PER_CPU(irq_stack_backing_store);
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
-#ifdef CONFIG_CPU_UNRET_ENTRY
+#ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index ff46f48a0cc4..0ad67ccadd4c 100644
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

