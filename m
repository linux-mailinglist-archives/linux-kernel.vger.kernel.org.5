Return-Path: <linux-kernel+bounces-142477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236158A2C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2FFE283415
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5D15490A;
	Fri, 12 Apr 2024 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I7h+sgbh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cgGXM6yI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D4A53815;
	Fri, 12 Apr 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916759; cv=none; b=bPpB3W6wP2gOgkcyJNUP75DEOTy1pgnxs6DW2esM61Z8hp2GcZo2V+tLx1n8fAruEgba4VBlyOWwIMsYLCzEz68zReoP/CU//QcZLTB+pksYe33boMVQj2Xd0gOpq3DMbTMaypFhXloV+PLsrnANbRpDjBqLXEr9RAyp+P9/+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916759; c=relaxed/simple;
	bh=Q/WS+K9aXmw1LA3gzfx9ZqQpIOxLMzdG0Yyf9z6Z4Uc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eZS+ByuxFCU9kmC42ed7zBoTFG91X2YFlZmpvmBBwGc7aPAFUJF5gkPppkgSv79OHYQNONQRlsxrs3UCb0CfQ4aBvhBVC7ANL+E580jMCljPjkJaGuT37N5+43L8abXuZtYiYcx6re6cR9X1Q/xRALhgO4+DjuIlflF101GKZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I7h+sgbh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cgGXM6yI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:12:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1ZhOjBG69h/ZFDWY4obHWw+rbdkPZF2Y1nce3jEpjs=;
	b=I7h+sgbhgphOBMzMYXKM0xf5cCjYKt1sI/578WvYD4+MX0ROgDB5hv5NJ4Io4UAwziisYc
	w80muu/xLz6TkB2HTSeT+sysc7loC1m3cHeHshJxY0+XnkaT8Ylt1vq6YePa04xlDAae/a
	ixAYopOtNIFAKHo4gU+teSkYpvZObvDxsgcvMLNvNqHE7nsfsrrDSAY+Una0PshzeBGp28
	WBc3gpTc3Eo8piO1D6YUArfBbGXjbmyLbDNqtcyG61Cr+fgX0zSt3kf1itekJaL6S4Muk7
	JCdhYsSEmZ1JxhmvmhIUOlBN+iDSA3Ia/rjuzf6wCRR7BaBUl15QnhRRNrvHYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1ZhOjBG69h/ZFDWY4obHWw+rbdkPZF2Y1nce3jEpjs=;
	b=cgGXM6yIs3fUxCFqsPGC0+FloKZo0NcKV6QEh2ymrY4DjtJ0Jo93rPhZoZvOj+gX68IPyO
	Tn8EM8QBPoygwCDw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with
 CONFIG_MITIGATION_SPECTRE_BHI
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Sean Christopherson <seanjc@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org>
References:
 <3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291675574.10875.17291021895435000233.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     4f511739c54b549061993b53fc0380f48dfca23b
Gitweb:        https://git.kernel.org/tip/4f511739c54b549061993b53fc0380f48dfca23b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 22:40:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 12:05:54 +02:00

x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with CONFIG_MITIGATION_SPECTRE_BHI

For consistency with the other CONFIG_MITIGATION_* options, replace the
CONFIG_SPECTRE_BHI_{ON,OFF} options with a single
CONFIG_MITIGATION_SPECTRE_BHI option.

[ mingo: Fix ]

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/3833812ea63e7fdbe36bf8b932e63f70d18e2a2a.1712813475.git.jpoimboe@kernel.org
---
 arch/x86/Kconfig           | 17 +++--------------
 arch/x86/kernel/cpu/bugs.c |  2 +-
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b63b676..4474bf3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2633,27 +2633,16 @@ config MITIGATION_RFDS
 	  stored in floating point, vector and integer registers.
 	  See also <file:Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst>
 
-choice
-	prompt "Clear branch history"
+config MITIGATION_SPECTRE_BHI
+	bool "Mitigate Spectre-BHB (Branch History Injection)"
 	depends on CPU_SUP_INTEL
-	default SPECTRE_BHI_ON
+	default y
 	help
 	  Enable BHI mitigations. BHI attacks are a form of Spectre V2 attacks
 	  where the branch history buffer is poisoned to speculatively steer
 	  indirect branches.
 	  See <file:Documentation/admin-guide/hw-vuln/spectre.rst>
 
-config SPECTRE_BHI_ON
-	bool "on"
-	help
-	  Equivalent to setting spectre_bhi=on command line parameter.
-config SPECTRE_BHI_OFF
-	bool "off"
-	help
-	  Equivalent to setting spectre_bhi=off command line parameter.
-
-endchoice
-
 endif
 
 config ARCH_HAS_ADD_PAGES
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6af4780..ca295b0 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1628,7 +1628,7 @@ enum bhi_mitigations {
 };
 
 static enum bhi_mitigations bhi_mitigation __ro_after_init =
-	IS_ENABLED(CONFIG_SPECTRE_BHI_ON) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
+	IS_ENABLED(CONFIG_MITIGATION_SPECTRE_BHI) ? BHI_MITIGATION_ON : BHI_MITIGATION_OFF;
 
 static int __init spectre_bhi_parse_cmdline(char *str)
 {

