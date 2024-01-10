Return-Path: <linux-kernel+bounces-21942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D71CB8296F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7C8285BDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA053FB20;
	Wed, 10 Jan 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P7miL0Wl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qlFwx6Pm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E173F8EE;
	Wed, 10 Jan 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JId4SGEGz5ch0TnskMoRNJewoUsPUVGadpg6PGO/KzY=;
	b=P7miL0WldKYLbcA5WHjWnyJcZ3+7C3HK3PFHhV/R13lRZAXqhmIDWfOyIL4vWB1ILBg0qj
	hbBu1hxrn4deVIXG8NxMClu6B0CoSOrGExUVcojTAgbUStBYFrE5dTa/ZCkuyHry3k+8yS
	OZjaX4l8yX8kReNnFxB+7HPkahdigctdH0uVe9eIw772DlQSN/3DqP3c/onazhPr56WPmk
	y6zqeu5ECLn5e4VJTxXZkyfrdVQo6ZzndLj4BVYJzsG63Ln9Nhp7WKbF5uZvnu1Sdu8kQf
	mMXmsjvOPQpd6lMKDBd+iXjlF0vYFL2OyWSNnS5bN30L5vpsFzp6O4vnhwV23g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JId4SGEGz5ch0TnskMoRNJewoUsPUVGadpg6PGO/KzY=;
	b=qlFwx6Pm0Xs041MbpQ4o764BMZ65treUoJlIdaxjhlTkoi8wXXseAfl5gEJLqQ9WcgQ3ui
	xhia1/mT63671fBw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Rename CONFIG_CPU_IBRS_ENTRY =>
 CONFIG_MITIGATION_IBRS_ENTRY
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-9-leitao@debian.org>
References: <20231121160740.1249350-9-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488138945.398.3983840684873331469.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     1da8d2172ce5175118929363fe568e41f24ad3d6
Gitweb:        https://git.kernel.org/tip/1da8d2172ce5175118929363fe568e41f24ad3d6
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:35 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:52:29 +01:00

x86/bugs: Rename CONFIG_CPU_IBRS_ENTRY       => CONFIG_MITIGATION_IBRS_ENTRY

Step 8/10 of the namespace unification of CPU mitigations related Kconfig options.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-9-leitao@debian.org
---
 arch/x86/Kconfig           | 2 +-
 arch/x86/entry/calling.h   | 4 ++--
 arch/x86/kernel/cpu/bugs.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 77b8769..60d38df 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2561,7 +2561,7 @@ config MITIGATION_IBPB_ENTRY
 	help
 	  Compile the kernel with support for the retbleed=ibpb mitigation.
 
-config CPU_IBRS_ENTRY
+config MITIGATION_IBRS_ENTRY
 	bool "Enable IBRS on kernel entry"
 	depends on CPU_SUP_INTEL && X86_64
 	default y
diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 7ac2d6f..39e069b 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -303,7 +303,7 @@ For 32-bit we have the following conventions - kernel is built with
  * Assumes x86_spec_ctrl_{base,current} to have SPEC_CTRL_IBRS set.
  */
 .macro IBRS_ENTER save_reg
-#ifdef CONFIG_CPU_IBRS_ENTRY
+#ifdef CONFIG_MITIGATION_IBRS_ENTRY
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_KERNEL_IBRS
 	movl	$MSR_IA32_SPEC_CTRL, %ecx
 
@@ -332,7 +332,7 @@ For 32-bit we have the following conventions - kernel is built with
  * regs. Must be called after the last RET.
  */
 .macro IBRS_EXIT save_reg
-#ifdef CONFIG_CPU_IBRS_ENTRY
+#ifdef CONFIG_MITIGATION_IBRS_ENTRY
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_KERNEL_IBRS
 	movl	$MSR_IA32_SPEC_CTRL, %ecx
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2580368..e11bacb 100644
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

