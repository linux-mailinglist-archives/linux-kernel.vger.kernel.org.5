Return-Path: <linux-kernel+bounces-142478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CE58A2C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C62850E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FA654FB7;
	Fri, 12 Apr 2024 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mewgJTzI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DvPOFD6t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40AA53E1F;
	Fri, 12 Apr 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916760; cv=none; b=YAdgFC1T07epWa6PCvXtS25KDMIFEKikug85Pxqrz5+/I9NFxCkkcFcuzgRqmEnkDXARFx3SMfnZO20xsSfIXzu3qBnhULtC2v66VXbzRl8iJHSkuJypCUTURoID69qgjwGEvmlEpsgas0bTq3scXPN5JFOqMOGnwPRhfHTZsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916760; c=relaxed/simple;
	bh=AXn6OfiVZcQJBkCVrFjv3csLo1kHEdoRjh0/pq4Ec8E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UNke00w9a23y/GMUn7ujfo4QtSon+tWZFvcq56T1G4DIJVL74OnUOgDHPh5GROOSbnOCPagBO7xB4rRxg8wfMLzOguEL0awHCSdOPLjPnvE/Kf4frTGN9G8iHDalkLmriJATsZ997l3ynxbVa2dXMFoOLkotI2Rqcy+4NhZdQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mewgJTzI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DvPOFD6t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:12:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szM9OQOAYnHMa1ZdlykHs+UwSpO86QKZFkXCbd5+k7I=;
	b=mewgJTzIYVoG7P85Qg/fIotVs6EAzWB72XGjKFsfLRPC21iL6Om5gZdsnAp020D8+BeYzj
	Xr/9H2BJ2WLrJPTUntebhYLY3II/B+rdEo/9VsBCuYx4K3ZZt7nJ1Hx5HK8zVybWASuOvN
	/uq77BFu0MAFryXgxtXa8nmFl5Qs684iKyVuTtOtVQ30GIhq9n2By8ITO92U/zyY/+EhUV
	VsV/SXgl+mYg92BzspNb4R8C70xcPv0LF76cNhFWEA7OeuIvzJpmOwu/9KRigjiYNntINI
	dEA0pmjiqDbUdeKDTcbzwbXlvjAy0HezGp2YjmY1L69Hjszez1J98BZMCc0sbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=szM9OQOAYnHMa1ZdlykHs+UwSpO86QKZFkXCbd5+k7I=;
	b=DvPOFD6tZ0zhNZNQPbt12sSJ2+bCFw+LlBoJzp6xau6Cb+YjD8v9pFGAwEaXoTjdpoeCto
	gqjhEKGNb5aVVuCg==
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
Message-ID: <171291675652.10875.12814633963801698856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     36d4fe147c870f6d3f6602befd7ef44393a1c87a
Gitweb:        https://git.kernel.org/tip/36d4fe147c870f6d3f6602befd7ef44393a1c87a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 22:40:50 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 12:05:54 +02:00

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
index 9eeb60f..6af4780 100644
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
 
@@ -1673,9 +1668,6 @@ static void __init bhi_select_mitigation(void)
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
 
-	if (bhi_mitigation == BHI_MITIGATION_AUTO)
-		return;
-
 	/* Mitigate syscalls when the mitigation is forced =on */
 	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP);
 	pr_info("Spectre BHI mitigation: SW BHB clearing on syscall\n");

