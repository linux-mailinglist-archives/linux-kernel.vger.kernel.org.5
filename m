Return-Path: <linux-kernel+bounces-140103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B558A0B78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A9B1F23BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591751422DB;
	Thu, 11 Apr 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLYziSQD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Ubnzp8k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A522E13D258;
	Thu, 11 Apr 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824829; cv=none; b=pSF9L8bq0e97Kxj/6OU1CZOXPrcertBK13aQq2KRcSiB4mEtYjo4eIWU16Dmr+nGiGGxYpKNFjtnUaKsKpDh4cM0hfp0F1Ud8bY7Pqmr+tUav4fTie5lf034JcvJ8Ma3Bli9YMYvqCiWVRGZhhLPE7EMG/EAJu7A+2+M661ensQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824829; c=relaxed/simple;
	bh=CpA8HDZqXXQ38fRd4vjOjms0WE737KK96vUWC9UtX9w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iHtqhtrBq+bXsgnV8SxRGjGIGsgADw8z3pQA0vKVcTMOVd2u14mZWTvMK6NT0kmsbhsDIvE5KWcCkcyq4QmE0m+hEAChirBv49OPQeoYqx+R1bSIs3/NwyeD8qHlbekVnqspZ5Hn24nrWlTv8zsooDX73rlxkkSefg3N1JYqc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aLYziSQD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Ubnzp8k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 08:40:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712824819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OIrgyGKdkz4FkXLmqF5I6KkItnIymqiD+4amwsXRYM=;
	b=aLYziSQD2y3X/UyhKVEH1tnotTks9aTQEvGPJGojlljzBxNTENkCw5UYVy2avuT/i2z3W/
	hZO2/i/gIr6tBzcHbUz5vsyFEOmd33Q2FeYd4BzCVffx+8NgRULNzU39kDAFDcOPKXk9HQ
	WcTcUgJbasjfgBONS1S3VbP2panW0h00q/XEBi2HO3NfDZqNxArfQLTy+DRgLvbfCUwKWj
	jopWL1U0S+Qq8Mjp8rN/Xy/LXYIXKvj3BznlkapHYZa4K07lsG8qJs4OuJMeO/vsHkIlxB
	un/DY2tPsQoP0+LyttjDmcCjFtpBy6BU7c6zvFYpPtJ3RKya3wn5qWZwjNbZIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712824819;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OIrgyGKdkz4FkXLmqF5I6KkItnIymqiD+4amwsXRYM=;
	b=6Ubnzp8kl8i5BmnMOa26R+FKk0pJTkO6BCWyBpwJI96I35+TweMcvwncXruiziPpTP5k+t
	FYdkY2SjhyiaVfBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and
 spectre_bhi=auto
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Sean Christopherson <seanjc@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <412e9dc87971b622bbbaf64740ebc1f140bff343.1712813475.git.jpoimboe@kernel.org>
References:
 <412e9dc87971b622bbbaf64740ebc1f140bff343.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171282481898.10875.12090429528204914432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     215bca01a67300ea884ce9302eaed53bcd1d996d
Gitweb:        https://git.kernel.org/tip/215bca01a67300ea884ce9302eaed53bcd1d996d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 22:40:50 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 10:30:34 +02:00

x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto

Unlike most other mitigations' "auto" options, spectre_bhi=auto only
mitigates newer systems, which is confusing and not particularly useful.

Remove it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/412e9dc87971b622bbbaf64740ebc1f140bff343.1712813475.git.jpoimboe@kernel.org
---
 Documentation/admin-guide/hw-vuln/spectre.rst   |  4 ----
 Documentation/admin-guide/kernel-parameters.txt |  3 ---
 arch/x86/Kconfig                                |  5 -----
 arch/x86/kernel/cpu/bugs.c                      | 10 +---------
 4 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 5a39acf..25a04cd 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -669,10 +669,6 @@ kernel command line.
 			needed.
 		off
 			Disable the mitigation.
-		auto
-			Enable the HW mitigation if needed, but
-			*don't* enable the SW mitigation except for KVM.
-			The system may be vulnerable.
 
 For spectre_v2_user see Documentation/admin-guide/kernel-parameters.txt
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a3874cc..902ecd9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6072,9 +6072,6 @@
 			on   - (default) Enable the HW or SW mitigation
 			       as needed.
 			off  - Disable the mitigation.
-			auto - Enable the HW mitigation if needed, but
-			       *don't* enable the SW mitigation except
-			       for KVM.  The system may be vulnerable.
 
 	spectre_v2=	[X86,EARLY] Control mitigation of Spectre variant 2
 			(indirect branch speculation) vulnerability.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 10a6251..b63b676 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2651,11 +2651,6 @@ config SPECTRE_BHI_OFF
 	bool "off"
 	help
 	  Equivalent to setting spectre_bhi=off command line parameter.
-config SPECTRE_BHI_AUTO
-	bool "auto"
-	depends on BROKEN
-	help
-	  Equivalent to setting spectre_bhi=auto command line parameter.
 
 endchoice
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b4ec0f0..0494787 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1625,13 +1625,10 @@ static bool __init spec_ctrl_bhi_dis(void)
 enum bhi_mitigations {
 	BHI_MITIGATION_OFF,
 	BHI_MITIGATION_ON,
-	BHI_MITIGATION_AUTO,
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_SPECTRE_BHI_ON)  ? BHI_MITIGATION_ON  :
-	IS_ENABLED(CONFIG_SPECTRE_BHI_OFF) ? BHI_MITIGATION_OFF :
-					     BHI_MITIGATION_AUTO;
+	IS_ENABLED(CONFIG_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {
@@ -1642,8 +1639,6 @@ static int __init spectre_bhi_parse_cmdline(char *str)
 		bhi_mitigation = BHI_MITIGATION_OFF;
 	else if (!strcmp(str, "on"))
 		bhi_mitigation = BHI_MITIGATION_ON;
-	else if (!strcmp(str, "auto"))
-		bhi_mitigation = BHI_MITIGATION_AUTO;
 	else
 		pr_err("Ignoring unknown spectre_bhi option (%s)", str);
 
@@ -1682,9 +1677,6 @@ static void __init bhi_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		return;
-
 	/* Mitigate syscalls when the mitigation is forced =on */
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");

