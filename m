Return-Path: <linux-kernel+bounces-39089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 321AC83CAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59841F264F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E7137C4D;
	Thu, 25 Jan 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZyGmv9j1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3nySu6z2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9571350CA;
	Thu, 25 Jan 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206891; cv=none; b=qILuI6ugZNtrFvznc+X+dOnM8BiiLtlrpm0SOc1FqSsr81ERkAwoLef5iEfheJPJW1bd42iVkls1hWKktka4VrGtIoNe/jPgdR9gtlXOK0sTYGzeut//088G5f2UoGBSn89EvBFzh3mDkGWe3hxtPjRbLnd6m2aWF0SpKtOpPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206891; c=relaxed/simple;
	bh=TnBXz3BERngDMNsMnoxzwwOzRkh9Xb+PUW9JuiiUXnc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SME90ctOSO/iVs/Tv6xzEK59XhXx3YjG2CXi6oFQgIJ7dN9RcwqMVTMNrHfPspbQ22RNuRNQYFB7nw3dlxaVgTO0kBussRoUxWSnV8BFqc5x9c7kDMvxRk2OWBTtnN7R3yC6rRTflhuxyCpSOr0WuHbJppj7jZGMcTRbjH3eZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZyGmv9j1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3nySu6z2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiTRbHaeiPe98aptRpNTgfQ7tum3imb+XW7jO9Mt20Q=;
	b=ZyGmv9j1ltyoqdPkm94wIAByESmJyAKeeFjbc2s0LOxvqWgfpzAt8Onqx96w39JDe1xacO
	m8MdMRMEvqfGBwtA9qUeb0LWn4vUw1l32EHba2PqHvDwBFSjgbmbDpwcRWTWaeLv61kfnU
	43uO5Rh8Nwpr9ZxH2PDCFnTmHSb1ihy97Cj//ui7C+jQZ8L4d5W7TGW73zTACm/v3De2Ai
	2iY/2qbvY7VIK6I96zDB6XXp4JSvEQLzrYso/fBVOSt7GtIs9Ahs+vgoMJ/GcYFnfxdvrd
	tt5AV42nBtsTk+Ehd+9solW0q4aPpOE55VZ6rUfMP3qISwV5ZS2r5DGeA4Lk8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206877;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NiTRbHaeiPe98aptRpNTgfQ7tum3imb+XW7jO9Mt20Q=;
	b=3nySu6z2foVR2aOkMdSgmrnRJjy2KEqvHij7mV3l5JOZuMc5GTWRlfocqW97blnoGBgUEM
	hNEOwURXoY+Kr4Ag==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] KVM: VMX: Call fred_entry_from_kvm() for IRQ/NMI handling
Cc: Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Shan Kang <shan.kang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-33-xin3.li@intel.com>
References: <20231205105030.8698-33-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620687645.398.11656973671106352681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     e03c54464b62a1e043df045cc428c30cf08ec236
Gitweb:        https://git.kernel.org/tip/e03c54464b62a1e043df045cc428c30cf08ec236
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:21 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:33 +01:00

KVM: VMX: Call fred_entry_from_kvm() for IRQ/NMI handling

When FRED is enabled, call fred_entry_from_kvm() to handle IRQ/NMI in
IRQ/NMI induced VM exits.

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20231205105030.8698-33-xin3.li@intel.com

---
 arch/x86/kvm/vmx/vmx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e262bc2..cce92f7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -38,6 +38,7 @@
 #include <asm/desc.h>
 #include <asm/fpu/api.h>
 #include <asm/fpu/xstate.h>
+#include <asm/fred.h>
 #include <asm/idtentry.h>
 #include <asm/io.h>
 #include <asm/irq_remapping.h>
@@ -6960,14 +6961,16 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu)
 {
 	u32 intr_info = vmx_get_intr_info(vcpu);
 	unsigned int vector = intr_info & INTR_INFO_VECTOR_MASK;
-	gate_desc *desc = (gate_desc *)host_idt_base + vector;
 
 	if (KVM_BUG(!is_external_intr(intr_info), vcpu->kvm,
 	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
 		return;
 
 	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-	vmx_do_interrupt_irqoff(gate_offset(desc));
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
+	else
+		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
 	kvm_after_interrupt(vcpu);
 
 	vcpu->arch.at_instruction_boundary = true;
@@ -7260,7 +7263,10 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	if ((u16)vmx->exit_reason.basic == EXIT_REASON_EXCEPTION_NMI &&
 	    is_nmi(vmx_get_intr_info(vcpu))) {
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-		vmx_do_nmi_irqoff();
+		if (cpu_feature_enabled(X86_FEATURE_FRED))
+			fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
+		else
+			vmx_do_nmi_irqoff();
 		kvm_after_interrupt(vcpu);
 	}
 

