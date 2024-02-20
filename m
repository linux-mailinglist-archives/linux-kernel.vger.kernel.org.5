Return-Path: <linux-kernel+bounces-72159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8463785B02F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76CD1C225B9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F0C12E5B;
	Tue, 20 Feb 2024 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mCPUEp80";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r6+C/78m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2368465;
	Tue, 20 Feb 2024 01:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390929; cv=none; b=tUzB22hjvwLCP1BlJFp70eI2w2AifoIUsco4fRWmJrGOddMBHv3LL73gFFlwpyot8aaEN5uaxSQQgMDz8O0SGLFX9U1MM63enVCz21rpu05995sGZZo+oJc4g3DfPs63eQJGhYnfq5JhdYyvE1qLUrEL5CLn0+saxLuB/VMIGt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390929; c=relaxed/simple;
	bh=nmFRqokI3uNyzTKS+VUD0/4ACgZDgXDwdWyPGQVLfXg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kpN1WehwlSjdVrf/tKmQGaC7mvYkO2NJSOERZRYnzjVrbqqs1h3V/YhiZnVXM+us1isH/WLA0r/qfqCYQZmw3hLiLsHcsrTrOW53+D9uKIxeCS3QRaB23ey/rFWyNIsaa/XImJvg0PogUhhLMWKmXq0Jz5ytKsPlSGYPybNr1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mCPUEp80; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r6+C/78m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 01:02:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708390925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Qtzotdyhh5BYmI4EgnPhbEDmKfEaLL07NkNOMUC/9Hw=;
	b=mCPUEp80jeo6IMza0HIZAoGdX6+BHgM92UcPqIvoAebVSvv4eDs2Pj6B+HbvP1kGe75IFN
	S3/ju8z/FJE4o/Ow5LiB+b/wV3Vukm/CVDQPzdK0N6SZOBv9b0d9aSIvpBFxzebPm4wbBQ
	kz3FIqLM9FZ1RFai1Djq9W1hXPlNx6/CVGjIlb+fsfDSReQl2QA0kHY77+7sj/hwHeB8XW
	if+MApSe8fB/pZNA3YPBquJGjjE1FfDAOEMT8BtQKoYHBGKvSFKZzJOCEHlc3mCVLopiOx
	ycxUM2kAy+isSECL79pRGi4G5ZSgTAPTJjVbcOgVVh3QM6sIq3iTk2CNgQo1OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708390925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Qtzotdyhh5BYmI4EgnPhbEDmKfEaLL07NkNOMUC/9Hw=;
	b=r6+C/78mV9p5EMw9Ts3N3xAG0IPqM96fYtB1l2iQbGQefp4Y6Cd55OGcYIzmE75fSnzrxE
	FlBsxoXGMprDI3Cw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] KVM/VMX: Move VERW closer to VMentry for MDS mitigation
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170839092466.398.5378682060812783539.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     43fb862de8f628c5db5e96831c915b9aebf62d33
Gitweb:        https://git.kernel.org/tip/43fb862de8f628c5db5e96831c915b9aebf62d33
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Tue, 13 Feb 2024 18:22:56 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 19 Feb 2024 16:31:59 -08:00

KVM/VMX: Move VERW closer to VMentry for MDS mitigation

During VMentry VERW is executed to mitigate MDS. After VERW, any memory
access like register push onto stack may put host data in MDS affected
CPU buffers. A guest can then use MDS to sample host data.

Although likelihood of secrets surviving in registers at current VERW
callsite is less, but it can't be ruled out. Harden the MDS mitigation
by moving the VERW mitigation late in VMentry path.

Note that VERW for MMIO Stale Data mitigation is unchanged because of
the complexity of per-guest conditional VERW which is not easy to handle
that late in asm with no GPRs available. If the CPU is also affected by
MDS, VERW is unconditionally executed late in asm regardless of guest
having MMIO access.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-6-a6216d83edb7%40linux.intel.com
---
 arch/x86/kvm/vmx/vmenter.S |  3 +++
 arch/x86/kvm/vmx/vmx.c     | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index ef7cfba..2bfbf75 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -161,6 +161,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Load guest RAX.  This kills the @regs pointer! */
 	mov VCPU_RAX(%_ASM_AX), %_ASM_AX
 
+	/* Clobbers EFLAGS.ZF */
+	CLEAR_CPU_BUFFERS
+
 	/* Check EFLAGS.CF from the VMX_RUN_VMRESUME bit test above. */
 	jnc .Lvmlaunch
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index db8a5fe..88a4ff2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -388,7 +388,16 @@ static __always_inline void vmx_enable_fb_clear(struct vcpu_vmx *vmx)
 
 static void vmx_update_fb_clear_dis(struct kvm_vcpu *vcpu, struct vcpu_vmx *vmx)
 {
-	vmx->disable_fb_clear = (host_arch_capabilities & ARCH_CAP_FB_CLEAR_CTRL) &&
+	/*
+	 * Disable VERW's behavior of clearing CPU buffers for the guest if the
+	 * CPU isn't affected by MDS/TAA, and the host hasn't forcefully enabled
+	 * the mitigation. Disabling the clearing behavior provides a
+	 * performance boost for guests that aren't aware that manually clearing
+	 * CPU buffers is unnecessary, at the cost of MSR accesses on VM-Entry
+	 * and VM-Exit.
+	 */
+	vmx->disable_fb_clear = !cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF) &&
+				(host_arch_capabilities & ARCH_CAP_FB_CLEAR_CTRL) &&
 				!boot_cpu_has_bug(X86_BUG_MDS) &&
 				!boot_cpu_has_bug(X86_BUG_TAA);
 
@@ -7224,11 +7233,14 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 
 	guest_state_enter_irqoff();
 
-	/* L1D Flush includes CPU buffer clear to mitigate MDS */
+	/*
+	 * L1D Flush includes CPU buffer clear to mitigate MDS, but VERW
+	 * mitigation for MDS is done late in VMentry and is still
+	 * executed in spite of L1D Flush. This is because an extra VERW
+	 * should not matter much after the big hammer L1D Flush.
+	 */
 	if (static_branch_unlikely(&vmx_l1d_should_flush))
 		vmx_l1d_flush(vcpu);
-	else if (cpu_feature_enabled(X86_FEATURE_CLEAR_CPU_BUF))
-		mds_clear_cpu_buffers();
 	else if (static_branch_unlikely(&mmio_stale_data_clear) &&
 		 kvm_arch_has_assigned_device(vcpu->kvm))
 		mds_clear_cpu_buffers();

