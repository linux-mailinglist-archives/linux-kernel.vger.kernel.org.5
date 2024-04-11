Return-Path: <linux-kernel+bounces-140106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CDD8A0B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3700128966B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F251448C7;
	Thu, 11 Apr 2024 08:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yAalkGHD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWN+60Ae"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1EC1411C8;
	Thu, 11 Apr 2024 08:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824831; cv=none; b=WJLk9KA1VgcIt6m22MNNNN/D3FrbepJS07hliXWUntyu15/5ysP8hVziaW9wGAFedHjuJnaoJAG6riexPJQSNf05JDkXXfE1bpvFwyfJQuQgCEWFBsi9I5ALmIjcSNboNI9Qzpjk5E/L4LgyvY137jn2nYde5Nem9aYFZv6KSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824831; c=relaxed/simple;
	bh=l1U2uyw5KZunZtipYulzUxi+GzehzrcAueEtq+XGCUE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sCR5c+GzQ/54bcTxHIHUIQiZuJbwaMzGCDJZrVKAK0qNsKEbgbp3amhjLu5OXql9tBYMdiVq6SMIKg1PnCfAjzuth2/KtGsqxJEP5xXKF/im/1eC2IfqtMJ4nvg3BTi4u9jzUf2npiu6Xv7sJURmglf8cHe4fu5rLtT6fGrmAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yAalkGHD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWN+60Ae; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 08:40:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712824822;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+B9eSipx42XBHLk1kpXJApTX+sTUtARYSjasOkJpPb8=;
	b=yAalkGHDyYhrveGxW/Zb9qE1PI9QbfamtAt75VsazPSCoj/PjqAJP1Zo6yTjAzCFN3JnUz
	bgsCLg9leirKTishsj+IvplfNfKuSpEoYHZrJWj2lHxZiHsre3QXgJNpEjPLD3y0FRxDf8
	KcDttQRWqFlaZ7V10JpML2/uUMTnWc4sZa/uR522ktAkkTWHpYnBL4EYJb0sNzHpKgUk0I
	+Xc38Z97jDOH9Yyi2KG6J88E6IXVhzmKgU2Xyv1ySJwjGqQSRr/ZEj2QqWVAyzHREuzxkB
	hVyAACNpda3B7vP45aw/IupyQjbAK56Sf3zzUKOpwFdgs5QtHClyKiKv1nKkhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712824822;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+B9eSipx42XBHLk1kpXJApTX+sTUtARYSjasOkJpPb8=;
	b=fWN+60Ae0hF9FsGWRG4QLJ5W3vJH3bJnd7QMrFICdyYY1X+ukB1CoRd89AavP6iv6EQi4w
	xRaC3TlZUiqG7BDg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Fix BHI handling of RRSBA
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <6f56f13da34a0834b69163467449be7f58f253dc.1712813475.git.jpoimboe@kernel.org>
References:
 <6f56f13da34a0834b69163467449be7f58f253dc.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171282482137.10875.9684446730020395583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1cea8a280dfd1016148a3820676f2f03e3f5b898
Gitweb:        https://git.kernel.org/tip/1cea8a280dfd1016148a3820676f2f03e3f5b898
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 22:40:47 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 10:30:33 +02:00

x86/bugs: Fix BHI handling of RRSBA

The ARCH_CAP_RRSBA check isn't correct: RRSBA may have already been
disabled by the Spectre v2 mitigation (or can otherwise be disabled by
the BHI mitigation itself if needed).  In that case retpolines are fine.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/6f56f13da34a0834b69163467449be7f58f253dc.1712813475.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/bugs.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1b0cfc1..08dfb94 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1538,20 +1538,25 @@ static enum spectre_v2_mitigation __init spectre_v2_select_retpoline(void)
 	return SPECTRE_V2_RETPOLINE;
 }
 
+static bool __ro_after_init rrsba_disabled;
+
 /* Disable in-kernel use of non-RSB RET predictors */
 static void __init spec_ctrl_disable_kernel_rrsba(void)
 {
-	u64 x86_arch_cap_msr;
+	if (rrsba_disabled)
+		return;
 
-	if (!boot_cpu_has(X86_FEATURE_RRSBA_CTRL))
+	if (!(x86_arch_cap_msr & ARCH_CAP_RRSBA)) {
+		rrsba_disabled = true;
 		return;
+	}
 
-	x86_arch_cap_msr = x86_read_arch_cap_msr();
+	if (!boot_cpu_has(X86_FEATURE_RRSBA_CTRL))
+		return;
 
-	if (x86_arch_cap_msr & ARCH_CAP_RRSBA) {
-		x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
-		update_spec_ctrl(x86_spec_ctrl_base);
-	}
+	x86_spec_ctrl_base |= SPEC_CTRL_RRSBA_DIS_S;
+	update_spec_ctrl(x86_spec_ctrl_base);
+	rrsba_disabled = true;
 }
 
 static void __init spectre_v2_determine_rsb_fill_type_at_vmexit(enum spectre_v2_mitigation mode)
@@ -1652,9 +1657,11 @@ static void __init bhi_select_mitigation(void)
 		return;
 
 	/* Retpoline mitigates against BHI unless the CPU has RRSBA behavior */
-	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE) &&
-	    !(x86_read_arch_cap_msr() & ARCH_CAP_RRSBA))
-		return;
+	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
+		spec_ctrl_disable_kernel_rrsba();
+		if (rrsba_disabled)
+			return;
+	}
 
 	if (spec_ctrl_bhi_dis())
 		return;
@@ -2809,8 +2816,7 @@ static const char *spectre_bhi_state(void)
 		return "; BHI: BHI_DIS_S";
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP))
 		return "; BHI: SW loop, KVM: SW loop";
-	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) &&
-		 !(x86_arch_cap_msr & ARCH_CAP_RRSBA))
+	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
 		return "; BHI: Retpoline";
 	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
 		return "; BHI: Syscall hardening, KVM: SW loop";

