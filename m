Return-Path: <linux-kernel+bounces-140104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 596C08A0B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF4EB20B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221B143C4F;
	Thu, 11 Apr 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAs1SN2l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CKa4QZNc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72525A32;
	Thu, 11 Apr 2024 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824830; cv=none; b=fOoqKSkX6rCal2rxRzAtVroWxv9gJyihQukzLBo8JmAnNpFgLUIvNxG/f/DWI/qM9utaLG7hr3wFj50BXasOb4ltxNGiut5qawpzr/rJcHHD8bGcfgARb1+RtG1spjzZQMJdpYjxSQQuWRbU550fV/AQDWq4a3WXui96tmFmcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824830; c=relaxed/simple;
	bh=9SB/yhqXyhvyHCaKIY9CH3Z3zO3Dd+A5vL2i0sKTOCA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r9Am+foaA6sU0I3FOXmdSCscR+68lniYgnQaF/eG8CGOmMv6L3BNE/DUfnPtrpnFuqyGqwFJG/xYFXFcRESNHSqUb6gWQgt68EhScuD9p/Zn6+BnB2SSZymveMboyHYH5OqxRVBc4/aifq/CNUKUNB/JAG0INDBMEWnbg3A3w+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAs1SN2l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CKa4QZNc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Apr 2024 08:40:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712824821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAurd2+Y6lQur3oxoMWVh57CbsrekTTX/o24SxAOO8Y=;
	b=SAs1SN2lX+ojS7DWRhlnNSNozCiH6zikzQNrKs5SM4V5OY4o9WfdKrEttbJ+G9XK02XOjz
	dYjMF7yhV77mRkGEv7owqWReM0szuinYD6l0Y2fvUTrgRSlclexm9OHfORxqhkwXZohQoX
	ho4eBbqatG51Bgv0v0JCgeV2JNOatjdf3vCBhOFc9MP4mu/C/I4LwLZ2kMQxUWCt2X3F2h
	AVjxDAkGJaDujQM7dtKw/Xu5kdyVI8YgA9Y7y1zKAAD5ay33tgyDr88sL+QN8+upGw9Ohm
	cpFEwiqwc8kIgCwxftXqo92YCmfmcU1190nhOAmmu11R9BRwGf02btjsmGE7xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712824821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAurd2+Y6lQur3oxoMWVh57CbsrekTTX/o24SxAOO8Y=;
	b=CKa4QZNcy9IKJKBJReAu2Io+SoWouiiRsWokKPE230trP75szzUVsYftfbNuo3KOzigVBN
	Nx+1y2jPEvC6Y/CQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Clarify that syscall hardening isn't a
 BHI mitigation
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <b5951dae3fdee7f1520d5136a27be3bdfe95f88b.1712813475.git.jpoimboe@kernel.org>
References:
 <b5951dae3fdee7f1520d5136a27be3bdfe95f88b.1712813475.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171282482058.10875.1352246687357623520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5f882f3b0a8bf0788d5a0ee44b1191de5319bb8a
Gitweb:        https://git.kernel.org/tip/5f882f3b0a8bf0788d5a0ee44b1191de5319bb8a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 10 Apr 2024 22:40:48 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 11 Apr 2024 10:30:33 +02:00

x86/bugs: Clarify that syscall hardening isn't a BHI mitigation

While syscall hardening helps prevent some BHI attacks, there's still
other low-hanging fruit remaining.  Don't classify it as a mitigation
and make it clear that the system may still be vulnerable if it doesn't
have a HW or SW mitigation enabled.

Fixes: ec9404e40e8f ("x86/bhi: Add BHI mitigation knob")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/b5951dae3fdee7f1520d5136a27be3bdfe95f88b.1712813475.git.jpoimboe@kernel.org
---
 Documentation/admin-guide/hw-vuln/spectre.rst   | 11 +++++------
 Documentation/admin-guide/kernel-parameters.txt |  3 +--
 arch/x86/kernel/cpu/bugs.c                      |  6 +++---
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 3cf18e4..5a39acf 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -441,10 +441,10 @@ The possible values in this file are:
    - System is protected by BHI_DIS_S
  * - BHI: SW loop, KVM SW loop
    - System is protected by software clearing sequence
- * - BHI: Syscall hardening
-   - Syscalls are hardened against BHI
- * - BHI: Syscall hardening, KVM: SW loop
-   - System is protected from userspace attacks by syscall hardening; KVM is protected by software clearing sequence
+ * - BHI: Vulnerable
+   - System is vulnerable to BHI
+ * - BHI: Vulnerable, KVM: SW loop
+   - System is vulnerable; KVM is protected by software clearing sequence
 
 Full mitigation might require a microcode update from the CPU
 vendor. When the necessary microcode is not available, the kernel will
@@ -661,8 +661,7 @@ kernel command line.
 	spectre_bhi=
 
 		[X86] Control mitigation of Branch History Injection
-		(BHI) vulnerability. Syscalls are hardened against BHI
-		regardless of this setting. This setting affects the deployment
+		(BHI) vulnerability.  This setting affects the deployment
 		of the HW BHI control and the SW BHB clearing sequence.
 
 		on
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a029ad6..a3874cc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6065,8 +6065,7 @@
 			See Documentation/admin-guide/laptops/sonypi.rst
 
 	spectre_bhi=	[X86] Control mitigation of Branch History Injection
-			(BHI) vulnerability. Syscalls are hardened against BHI
-			reglardless of this setting. This setting affects the
+			(BHI) vulnerability.  This setting affects the
 			deployment of the HW BHI control and the SW BHB
 			clearing sequence.
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 08dfb94..9eeb60f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2818,10 +2818,10 @@ static const char *spectre_bhi_state(void)
 		return "; BHI: SW loop, KVM: SW loop";
 	else if (boot_cpu_has(X86_FEATURE_RETPOLINE) && rrsba_disabled)
 		return "; BHI: Retpoline";
-	else if  (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
-		return "; BHI: Syscall hardening, KVM: SW loop";
+	else if (boot_cpu_has(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT))
+		return "; BHI: Vulnerable, KVM: SW loop";
 
-	return "; BHI: Vulnerable (Syscall hardening enabled)";
+	return "; BHI: Vulnerable";
 }
 
 static ssize_t spectre_v2_show_state(char *buf)

