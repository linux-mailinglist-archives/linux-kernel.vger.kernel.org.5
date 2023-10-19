Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50027D01B3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346212AbjJSSfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjJSSfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:35:23 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89D0BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:35:20 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso4395066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740519; x=1698345319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsnS4a36dsfrPKrQ6qYn/NJN9B6BlESMsP3eWITabwo=;
        b=WL6irb24fMopcMnyXyzl3E/n9NOpyi7IjS9sOQIGUrsyYZSDZurRR8hkJQsZgop6fc
         QxNSCDpwB4D7gPcl9gbclnNlP1DQfB4qLIyLMhnMcgVGKxKMEeoPNTd7tjgY3vPVVe9Q
         Vl2jRKFNB1/7e1kZmXP7vX1vb1Ewa4MNmpuIj3QIFLm3UjsxR/I18XxmWY9wFv0w+R+/
         zSfPUaft+ZFFd888QclH09RMCf23uprnvLQI+1UdUhJvtJO7hvglNEQ+AJQg5AEizqxp
         jGJ+eGsx7/6iWtzpGX0qccDIqNrz/bXe19lLr/qC4ODNbkoEKKqEBMzcEGObRk4GP3hT
         JeHw==
X-Gm-Message-State: AOJu0YzW8AFQkahBbSafAZ9eTVyV2FXCegYcow4woUNwIQLTRdGkrYti
        bysYNDom4jk/sMxLH6srRE4=
X-Google-Smtp-Source: AGHT+IHgpjjnpEoPBWb7hVMLNDJeLnKj6FdfWLTKJ0qUNAp6i+aMEnoi+nW/9iPpTQsPwBa09plvSg==
X-Received: by 2002:a17:907:318c:b0:9a1:c447:3c62 with SMTP id xe12-20020a170907318c00b009a1c4473c62mr2580445ejb.49.1697740518711;
        Thu, 19 Oct 2023 11:35:18 -0700 (PDT)
Received: from localhost (fwdproxy-cln-013.fbsv.net. [2a03:2880:31ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id qk2-20020a170906d9c200b009b97aa5a3aesm26052ejb.34.2023.10.19.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:35:18 -0700 (PDT)
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
Cc:     leit@meta.com, Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Kim Phillips <kim.phillips@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Kai Huang <kai.huang@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Brian Gerst <brgerst@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v5 03/12] x86/bugs: Rename CALL_DEPTH_TRACKING to MITIGATION_CALL_DEPTH_TRACKING
Date:   Thu, 19 Oct 2023 11:11:49 -0700
Message-Id: <20231019181158.1982205-4-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019181158.1982205-1-leitao@debian.org>
References: <20231019181158.1982205-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Rename the Kconfig entry from CALL_DEPTH_TRACKING to
MITIGATION_CALL_DEPTH_TRACKING.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
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
index b8965bb7443b..4d64519311c4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2502,7 +2502,7 @@ config CPU_UNRET_ENTRY
 	help
 	  Compile the kernel with support for the retbleed=unret mitigation.
 
-config CALL_DEPTH_TRACKING
+config MITIGATION_CALL_DEPTH_TRACKING
 	bool "Mitigate RSB underflow with call depth tracking"
 	depends on CPU_SUP_INTEL && HAVE_CALL_THUNKS
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
@@ -2522,7 +2522,7 @@ config CALL_DEPTH_TRACKING
 
 config CALL_THUNKS_DEBUG
 	bool "Enable call thunks and call depth tracking debugging"
-	depends on CALL_DEPTH_TRACKING
+	depends on MITIGATION_CALL_DEPTH_TRACKING
 	select FUNCTION_ALIGNMENT_32B
 	default n
 	help
diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index a1168e7b69e5..d4ff517cfbd1 100644
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
index 702d93fdd10e..c1d3a5795618 100644
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
index 0676b077207c..64d9f0e87419 100644
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
index 6913b372ccf7..a98020bf31bb 100644
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
index 1de4791091ca..b906ed4f3091 100644
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
index db813113e637..910fd231b7d2 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -71,7 +71,7 @@ SYM_CODE_END(__x86_indirect_thunk_array)
 #include <asm/GEN-for-each-reg.h>
 #undef GEN
 
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 .macro CALL_THUNK reg
 	.align RETPOLINE_THUNK_SIZE
 
@@ -318,7 +318,7 @@ __EXPORT_THUNK(entry_untrain_ret)
 
 #endif /* CONFIG_CPU_UNRET_ENTRY || CONFIG_CPU_SRSO */
 
-#ifdef CONFIG_CALL_DEPTH_TRACKING
+#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
 
 	.align 64
 SYM_FUNC_START(call_depth_return_thunk)
@@ -350,7 +350,7 @@ SYM_FUNC_START(call_depth_return_thunk)
 	int3
 SYM_FUNC_END(call_depth_return_thunk)
 
-#endif /* CONFIG_CALL_DEPTH_TRACKING */
+#endif /* CONFIG_MITIGATION_CALL_DEPTH_TRACKING */
 
 /*
  * This function name is magical and is used by -mfunction-return=thunk-extern
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 68d0134bdbf9..cc44c95c49cc 100644
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
index fafe9be7a6f4..3d61b2432991 100644
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
-- 
2.34.1

