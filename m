Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3E97D0131
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346379AbjJSSM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346346AbjJSSMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:12:25 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19E9121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:12:23 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1332870966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697739142; x=1698343942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzUTZ2tVIcLFVmnHYkHPd+CZ+4cvt+7WkUIii7z93Do=;
        b=u3dkRZQKwvIunbH7GFtq5EvNFLy9ycDhM9+M0OJjTdb1IhdyEwAv85bQrtFbhyCpuN
         H8ZJZ4Lrc2uWK5EmfWlFORSNxgxrAhZo1X/cPpFZXy1atx0CVtxYxvDlWsSDxG/pR8fU
         nROURLL+WsJhMHDyVqMk+d28fh6JD4PCqroH4lMcxASqjjw0OtjvVkKgL3utjBGGs4fS
         YROmHvrFBEy6o4fzKAopUhjZA410CDTE2To0SrpLz8xMlSsu9X705dGDyZOGvL5VyzCl
         1dm75k6bUY3lax6GwK5BB4UwRbKedYH3oQa493tu6c5E+NGBQOPSzbc8L2p10MZX5UiF
         fj/w==
X-Gm-Message-State: AOJu0YyAqxaPExopZPL8a369g8j7HSb2o43c+oV4GsJpUcUhxAX8ni3h
        cEppB1KrTfljCcaPUQgBV50=
X-Google-Smtp-Source: AGHT+IHBA/9wkWMKmPNWkP1F2DqifJnqOHnwndMOD6AtTOI5m70bmuDz3vc44lW8x+4/svOXw9kGIg==
X-Received: by 2002:a17:906:6a1b:b0:9ae:5fe1:ef01 with SMTP id qw27-20020a1709066a1b00b009ae5fe1ef01mr2065867ejc.37.1697739142233;
        Thu, 19 Oct 2023 11:12:22 -0700 (PDT)
Received: from localhost (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id u13-20020a170906408d00b009932337747esm3922300ejj.86.2023.10.19.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:12:21 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v5 02/12] x86/bugs: Rename CPU_IBPB_ENTRY to MITIGATION_IBPB_ENTRY
Date:   Thu, 19 Oct 2023 11:11:48 -0700
Message-Id: <20231019181158.1982205-3-leitao@debian.org>
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

Rename the Kconfig entry from CPU_IBPB_ENTRY to MITIGATION_IBPB_ENTRY.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig                     |  2 +-
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/kernel/cpu/bugs.c           | 11 ++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d0a9f5a5c8a4..b8965bb7443b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2533,7 +2533,7 @@ config CALL_THUNKS_DEBUG
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

