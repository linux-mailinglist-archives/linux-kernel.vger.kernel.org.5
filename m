Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3907D01DA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbjJSShe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjJSSh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:37:28 -0400
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A0FBE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:23 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so10484176e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 11:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740641; x=1698345441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tdae9eZ6qccJdF0xGoTmxbAj070PFYdjsCv8qfK3SD8=;
        b=t0npU7F9K78ZJQ8rVQu08M3XW0WkAYXpSeKN8yCuURmvj6oecg3d6DVHSQjKoF8UHu
         Wn5TqevRL9vhR6wMI3ydB+1XgBgrw7JQZJhxKXoW6eBw82fRVAc7+w559MuGEc+teU/O
         BfMHXHQ26HyJA8UbcitB5W81cZroP+OmVhz3eKHbff6133SprSkmEm77WofvZ6d3v5XN
         ke7lErT5Q3dMsI11hPT+DIBnH2/lQuW+hQo4SkA23rBAUszyYG7aq8Hgcxwh/0v+Fod7
         mOXpujxDb8HUO9zlDfbyKvzkDUL9btUQ+JGF3SQuuB8CPtAutlU9y2qg/2iR2ywGwkoD
         V+6g==
X-Gm-Message-State: AOJu0Yx2zUVz8aQ5nMeDWPzfwOJGPTy/o+d5N/T0fddWIQLKf41AOsxE
        O8uvCeklb4wC3oEiOpr7vCY=
X-Google-Smtp-Source: AGHT+IF5zteU2gYurAm3uoewqM5ZRAaG5X9F//7ikJUtqpyEniJ5r1l7zuTcRVbqlIf6dAF8u6G/wg==
X-Received: by 2002:a05:6512:479:b0:503:1bb0:a658 with SMTP id x25-20020a056512047900b005031bb0a658mr1938796lfd.32.1697740640921;
        Thu, 19 Oct 2023 11:37:20 -0700 (PDT)
Received: from localhost (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id bx14-20020a0564020b4e00b0052ff9bae873sm66588edb.5.2023.10.19.11.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:37:20 -0700 (PDT)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH v5 08/12] x86/bugs: Rename CPU_IBRS_ENTRY to MITIGATION_IBRS_ENTRY
Date:   Thu, 19 Oct 2023 11:11:54 -0700
Message-Id: <20231019181158.1982205-9-leitao@debian.org>
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

Rename the Kconfig entry from CPU_IBRS_ENTRY to MITIGATION_IBRS_ENTRY.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 2 +-
 arch/x86/entry/calling.h   | 4 ++--
 arch/x86/kernel/cpu/bugs.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0e4c0c5c4818..c53d2034a5ab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2540,7 +2540,7 @@ config MITIGATION_IBPB_ENTRY
 	help
 	  Compile the kernel with support for the retbleed=ibpb mitigation.
 
-config CPU_IBRS_ENTRY
+config MITIGATION_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
 	depends on CPU_SUP_INTEL && X86_64
 	default y
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index ace89d5c1ddd..2afdff42c107 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -297,7 +297,7 @@ For 32-bit we have the following conventions - kernel is built with
  * Assumes x86_spec_ctrl_{base,current} to have SPEC_CTRL_IBRS set.
  */
 .macro IBRS_ENTER save_reg
-#ifdef CONFIG_CPU_IBRS_ENTRY
+#ifdef CONFIG_MITIGATION_IBRS_ENTRY
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_KERNEL_IBRS
 	movl	$MSR_IA32_SPEC_CTRL, %ecx
 
@@ -326,7 +326,7 @@ For 32-bit we have the following conventions - kernel is built with
  * regs. Must be called after the last RET.
  */
 .macro IBRS_EXIT save_reg
-#ifdef CONFIG_CPU_IBRS_ENTRY
+#ifdef CONFIG_MITIGATION_IBRS_ENTRY
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_KERNEL_IBRS
 	movl	$MSR_IA32_SPEC_CTRL, %ecx
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2580368c32d1..e11bacbd8f39 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1439,7 +1439,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		return SPECTRE_V2_CMD_AUTO;
 	}
 
-	if (cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_CPU_IBRS_ENTRY)) {
+	if (cmd == SPECTRE_V2_CMD_IBRS && !IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY)) {
 		pr_err("%s selected but not compiled in. Switching to AUTO select\n",
 		       mitigation_options[i].option);
 		return SPECTRE_V2_CMD_AUTO;
@@ -1565,7 +1565,7 @@ static void __init spectre_v2_select_mitigation(void)
 			break;
 		}
 
-		if (IS_ENABLED(CONFIG_CPU_IBRS_ENTRY) &&
+		if (IS_ENABLED(CONFIG_MITIGATION_IBRS_ENTRY) &&
 		    boot_cpu_has_bug(X86_BUG_RETBLEED) &&
 		    retbleed_cmd != RETBLEED_CMD_OFF &&
 		    retbleed_cmd != RETBLEED_CMD_STUFF &&
-- 
2.34.1

