Return-Path: <linux-kernel+bounces-21948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5666F8296FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACD51F21D73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4F14176C;
	Wed, 10 Jan 2024 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p2uvqbW8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZQLX3qb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D8F405F2;
	Wed, 10 Jan 2024 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYxbHtuid2EZTa/ckkcgbQp+CgiOVEhAFcrS49OWqlU=;
	b=p2uvqbW8qCjxhzR1aTsX+QE8H4mnASP2vsz2CBAzQJMtroMf6qdxkjUkcWZKAbRtCCFjcz
	gwJQj+wdINnlNbHmGhD9joyfRyNJb7/5qsMnYV35wCXgQS3oXG0dhFn3K5T8tEOHO/ixVA
	5Ow0vTkm2chsGflJoM0tXn/u8A+wk1T219w7L6iWBJzGBGc4nd8wdxZZ7Km2TDzYTFqMnM
	6GIHazVAE98xZ6wxiLWaHEp6zwPDcBRyOnPsUIdXkSEWbsb4mpbI6EFa6XufsjR8Pcfh2Q
	Ah5+bgQj7yAUn34JkwiPiGKOH9zfBCHEKhEoF+7AJ1gOGEdyDpLORI4gBcN9+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYxbHtuid2EZTa/ckkcgbQp+CgiOVEhAFcrS49OWqlU=;
	b=zZQLX3qb/6UV9N3a3SE6b+fG7wQs33eTUB/ma0vvJ8Pf4tqxznhsyMtY5TF0gBkAD2yHVP
	Z/jpmo6qf7EUKMCg==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Rename CONFIG_CPU_IBPB_ENTRY =>
 CONFIG_MITIGATION_IBPB_ENTRY
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-3-leitao@debian.org>
References: <20231121160740.1249350-3-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488139448.398.13871271510194564443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     e0b8fcfa3cfac171d589ad6085a00c584d571f08
Gitweb:        https://git.kernel.org/tip/e0b8fcfa3cfac171d589ad6085a00c584d571f08
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:29 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:52:28 +01:00

x86/bugs: Rename CONFIG_CPU_IBPB_ENTRY       => CONFIG_MITIGATION_IBPB_ENTRY

Step 2/10 of the namespace unification of CPU mitigations related Kconfig options.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-3-leitao@debian.org
---
 arch/x86/Kconfig                     |  2 +-
 arch/x86/include/asm/nospec-branch.h |  2 +-
 arch/x86/kernel/cpu/bugs.c           | 11 ++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1dba33a..c4e04b6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2554,7 +2554,7 @@ config CALL_THUNKS_DEBUG
 	  Only enable this when you are debugging call thunks as this
 	  creates a noticeable runtime overhead. If unsure say N.
 
-config CPU_IBPB_ENTRY
+config MITIGATION_IBPB_ENTRY
 	bool "Enable IBPB on kernel entry"
 	depends on CPU_SUP_AMD && X86_64
 	default y
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 262e655..7341fd9 100644
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
index 3c7e27b..1de4791 100644
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
@@ -1023,7 +1023,8 @@ do_cmd_auto:
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
 

