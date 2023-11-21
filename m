Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1907F349B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjKURMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjKURM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:12:27 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ACDD4F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:23 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a00a9c6f1e9so245422966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586742; x=1701191542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxW+vd4Gib/Bhd3cLzzpB/nRoSJ1TOI/3RxosIZWZPM=;
        b=dvTd33Ohgugo7MocB0PjfreHakXGAWdcbk4Opk4r1+0PFtsW1EkpxFDvfuRjpmH/pc
         NS+te2R/jGwM14P2VE6RB51RdQ+hfdVwpceEAFeRbzYANnbR7oI/LcfHJZuRsTt2z/S1
         dHuBSAMjyH7iGZisjIIZWCBC7TwWrc7G37qyNVNwrYP4DxBsVZOVOqmI5IxZTDwmO0RK
         F/tYwB8b+4MqzCbQb0vLbDeLnA6B08sG+/GOHMe1TYfv4Xs79Sx4dj2nep5a2VWjSaEe
         +/VYQcqQDqLmDQgFEcxGbMy7op7JV5Ei/bjyg/a5aO33wshFvdNzAtWs6iHx27i5MNFR
         iMtQ==
X-Gm-Message-State: AOJu0YwzsdmROf/b0XAabUT2WEVPSDoOtmKHKoWgIM/z7QmXRCaT10si
        L5LCSJ2dxeM3qjTLTSJDcgM=
X-Google-Smtp-Source: AGHT+IG7tTqEjzy5NiugPyROxP5yZX6da6kKtDgW0UPUhtIMTsP9ikUo8JfQfymDJryq3lwh3Q6EHg==
X-Received: by 2002:a17:906:ecef:b0:a03:9b32:d8a2 with SMTP id qt15-20020a170906ecef00b00a039b32d8a2mr337533ejb.60.1700586742023;
        Tue, 21 Nov 2023 09:12:22 -0800 (PST)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709061cc300b009a1a653770bsm5424753ejh.87.2023.11.21.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 09:12:21 -0800 (PST)
From:   Breno Leitao <leitao@debian.org>
To:     jpoimboe@kernel.org, mingo@redhat.com, tglx@linutronix.de,
        bp@alien8.de, Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     leit@meta.com, linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/13] x86/bugs: Rename CPU_IBRS_ENTRY to MITIGATION_IBRS_ENTRY
Date:   Tue, 21 Nov 2023 08:07:35 -0800
Message-Id: <20231121160740.1249350-9-leitao@debian.org>
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

Rename the Kconfig entry from CPU_IBRS_ENTRY to MITIGATION_IBRS_ENTRY.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/x86/Kconfig           | 2 +-
 arch/x86/entry/calling.h   | 4 ++--
 arch/x86/kernel/cpu/bugs.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa078d3655ff..392e94fded3d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2564,7 +2564,7 @@ config MITIGATION_IBPB_ENTRY
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

