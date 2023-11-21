Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032647F3486
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjKURKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbjKURJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:09:53 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8C18C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:09:46 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9e1021dbd28so792350866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586585; x=1701191385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb5pruwD0lN80zFFAFYgyDjyeIbD6ainengTDoc+mpo=;
        b=C4fgmwxarcuNdFLWhNy9Kh8Ve536zoxN861QDtyHaG6CIwOF8Az/l/BB2CWZSO2rFN
         rRdt4XwWHHqTRce3GrGZiB4MkgvzK0xsX9xcuafsV/iqfGXlr6Gz2zGFaPE0SsXZs874
         oj+XRGvAEl03bV6uRWOW59oc1VvyolpfOrYRSrWjS9bUrb80J6tM++8dG1HKAg81tYFC
         cEXllkXHiaCNGSIhmvmp0x6ENMRtb4fH5gnZRrgKubb7SO4uZv756cC18leWjkPSXwvV
         tljdfwaITNs345kgVB6pLPD3b3v2cY+oNnj2DQAgwlLOvYGc1C0JwfjmxoQ2raNQNXuQ
         pyKw==
X-Gm-Message-State: AOJu0YwxwNQtyoP5KMoha87Kng1ww7HDco6eJhIkkJYZTHFDafjiRBge
        R6kK/V4JFzlme0QyV/1RHmw=
X-Google-Smtp-Source: AGHT+IGthVwG5RsIqNWl0Rkfzkit9BG18v/d+ZBbfMjqFxIw/E+T0Jdukhpp13XqGXEXuY2iZhx46w==
X-Received: by 2002:a17:906:73cc:b0:a01:c0c6:1413 with SMTP id n12-20020a17090673cc00b00a01c0c61413mr1965482ejl.12.1700586585040;
        Tue, 21 Nov 2023 09:09:45 -0800 (PST)
Received: from localhost (fwdproxy-cln-023.fbsv.net. [2a03:2880:31ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id lv9-20020a170906bc8900b009fd4cb4aa61sm3145910ejb.199.2023.11.21.09.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:09:44 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/13] x86/bugs: Rename CPU_IBPB_ENTRY to MITIGATION_IBPB_ENTRY
Date:   Tue, 21 Nov 2023 08:07:29 -0800
Message-Id: <20231121160740.1249350-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121160740.1249350-1-leitao@debian.org>
References: <20231121160740.1249350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

Rename the Kconfig entry from CPU_IBPB_ENTRY to MITIGATION_IBPB_ENTRY.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig                     |  2 +-
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/kernel/cpu/bugs.c           | 11 ++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ddf0d8bc6db9..2e16ab138a1c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2557,7 +2557,7 @@ config CALL_THUNKS_DEBUG
 	  Only enable this when you are debugging call thunks as this
 	  creates a noticeable runtime overhead. If unsure say N.
 
-config CPU_IBPB_ENTRY
+config MITIGATION_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
 	depends on CPU_SUP_AMD && X86_64
 	default y
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f93e9b96927a..0676b077207c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -289,7 +289,7 @@
  * where we have a stack but before any RET instruction.
  */
 .macro __UNTRAIN_RET ibpb_feature, call_depth_insns
-#if defined(CONFIG_RETHUNK) || defined(CONFIG_CPU_IBPB_ENTRY)
+#if defined(CONFIG_RETHUNK) || defined(CONFIG_MITIGATION_IBPB_ENTRY)
 	VALIDATE_UNRET_END
 	ALTERNATIVE_3 "",						\
 		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3c7e27b58f0e..1de4791091ca 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -994,10 +994,10 @@ static void __init retbleed_select_mitigation(void)
 		if (!boot_cpu_has(X86_FEATURE_IBPB)) {
 			pr_err("WARNING: CPU does not support IBPB.\n");
 			goto do_cmd_auto;
-		} else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
+		} else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
 		} else {
-			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
+			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
 			goto do_cmd_auto;
 		}
 		break;
@@ -1023,7 +1023,8 @@ static void __init retbleed_select_mitigation(void)
 		    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
 			if (IS_ENABLED(CONFIG_CPU_UNRET_ENTRY))
 				retbleed_mitigation = RETBLEED_MITIGATION_UNRET;
-			else if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY) && boot_cpu_has(X86_FEATURE_IBPB))
+			else if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY) &&
+				 boot_cpu_has(X86_FEATURE_IBPB))
 				retbleed_mitigation = RETBLEED_MITIGATION_IBPB;
 		}
 
@@ -2482,13 +2483,13 @@ static void __init srso_select_mitigation(void)
 		break;
 
 	case SRSO_CMD_IBPB:
-		if (IS_ENABLED(CONFIG_CPU_IBPB_ENTRY)) {
+		if (IS_ENABLED(CONFIG_MITIGATION_IBPB_ENTRY)) {
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
 			}
 		} else {
-			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");
+			pr_err("WARNING: kernel not compiled with MITIGATION_IBPB_ENTRY.\n");
 		}
 		break;
 
-- 
2.34.1

