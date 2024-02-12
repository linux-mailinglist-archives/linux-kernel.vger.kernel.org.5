Return-Path: <linux-kernel+bounces-62185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C80851CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768881C2228D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392E43FE44;
	Mon, 12 Feb 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nCWYFnE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wal9GZwL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF70418658;
	Mon, 12 Feb 2024 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707762750; cv=none; b=tIQeRPf2U5sxg7//GXiqCCVdLi/ffZ/d5i2RD7G0lD/Ju6bSDd+pyud/eGI3RQYZikcUJ4VP45s6TNUscTZJmGs2pmww0MvFclS+HBTzjEoFb6MQFNT+5Oq0CCDnwPRoFvD0FbqUIKfwwsoJqNGRqS34SHpFMPDckCLYqBjEcXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707762750; c=relaxed/simple;
	bh=yPkH3hOzgZLrY6lJrlZMx8Gh7Q26Rh5ZLHjFNrPwcC0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=C4q80m775XGmVXiY9gytWfxgMl87b0thCoxkZEyoibBteqV9cGEY4Ocq0whoxiG4dZR8R+0yYrQEbPhJqsueaP8wzF7PTKNZIYelgiryWw42hQuWt5Lak6oYOoxLV5IcbGOhcs7ABOCY9Uc1Mg0GE7d7hEXzo7ErrN7Ubio0PJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3nCWYFnE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wal9GZwL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Feb 2024 18:32:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707762746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZYHpy+obrltc3uNCIQFHHG/TJ4ylG62vxjIjKDv0+7c=;
	b=3nCWYFnEj4ECw9B+cweR1xfRATYQJu5RlI4PoFbApmF73SsAIuzk+2AJKfvevq2hYn2m5v
	CGmAgPesmji33O3Su4rGAfxIVmZg03mQvDrkDtsFQkhUWnBxNNPx6aTA/VzJpBi4Cwmi9h
	142+iezwo1vUbir9Q/7e0Q9fzKRsCUr8/NQ//Qdu5UCe++F9EdoNsCgkc95VlPb1gBPJkc
	X6f4f88wPKeDklkKbZtSnlC0xiLLtM2pLX05YIX7ev0nVx4EanHHusWAz3EH5cHojDeAjQ
	m8Q0R2fnMPxwWX5tvBjCm3BYs3fyD4eP6OH9Fc/WxwX/yQk027tpoatJkaWgbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707762746;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZYHpy+obrltc3uNCIQFHHG/TJ4ylG62vxjIjKDv0+7c=;
	b=wal9GZwLTFVHptExbhkoErcgAEgrWOzruf9sc9kud9c8zIMFN5COdcszooWoLaLMtGAsiz
	K3WDNEUH109apmAw==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select
 VMRESUME vs. VMLAUNCH
Cc: Sean Christopherson <seanjc@google.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170776274619.398.641202461394579378.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e1920bd6fa76385fbfaf27f5460b60ad1d4c1b9b
Gitweb:        https://git.kernel.org/tip/e1920bd6fa76385fbfaf27f5460b60ad1d4c1b9b
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Sun, 04 Feb 2024 23:20:06 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 12 Feb 2024 10:25:22 -08:00

KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

Use EFLAGS.CF instead of EFLAGS.ZF to track whether to use VMRESUME versus
VMLAUNCH.  Freeing up EFLAGS.ZF will allow doing VERW, which clobbers ZF,
for MDS mitigations as late as possible without needing to duplicate VERW
for both paths.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/all/20240204-delay-verw-v7-5-59be2d704cb2%40linux.intel.com
---
 arch/x86/kvm/vmx/run_flags.h | 7 +++++--
 arch/x86/kvm/vmx/vmenter.S   | 6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/run_flags.h b/arch/x86/kvm/vmx/run_flags.h
index edc3f16..6a9bfdf 100644
--- a/arch/x86/kvm/vmx/run_flags.h
+++ b/arch/x86/kvm/vmx/run_flags.h
@@ -2,7 +2,10 @@
 #ifndef __KVM_X86_VMX_RUN_FLAGS_H
 #define __KVM_X86_VMX_RUN_FLAGS_H
 
-#define VMX_RUN_VMRESUME	(1 << 0)
-#define VMX_RUN_SAVE_SPEC_CTRL	(1 << 1)
+#define VMX_RUN_VMRESUME_SHIFT		0
+#define VMX_RUN_SAVE_SPEC_CTRL_SHIFT	1
+
+#define VMX_RUN_VMRESUME		BIT(VMX_RUN_VMRESUME_SHIFT)
+#define VMX_RUN_SAVE_SPEC_CTRL		BIT(VMX_RUN_SAVE_SPEC_CTRL_SHIFT)
 
 #endif /* __KVM_X86_VMX_RUN_FLAGS_H */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 906ecd0..ef7cfba 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -139,7 +139,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	mov (%_ASM_SP), %_ASM_AX
 
 	/* Check if vmlaunch or vmresume is needed */
-	test $VMX_RUN_VMRESUME, %ebx
+	bt   $VMX_RUN_VMRESUME_SHIFT, %ebx
 
 	/* Load guest registers.  Don't clobber flags. */
 	mov VCPU_RCX(%_ASM_AX), %_ASM_CX
@@ -161,8 +161,8 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Load guest RAX.  This kills the @regs pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
-	/* Check EFLAGS.ZF from 'test VMX_RUN_VMRESUME' above */
-	jz .Lvmlaunch
+	/* Check EFLAGS.CF from the VMX_RUN_VMRESUME bit test above. */
+	jnc .Lvmlaunch
 
 	/*
 	 * After a successful VMRESUME/VMLAUNCH, control flow "magically"

