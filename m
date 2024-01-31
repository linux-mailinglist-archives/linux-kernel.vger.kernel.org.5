Return-Path: <linux-kernel+bounces-47120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 266C7844994
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE50B264ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025B39FC6;
	Wed, 31 Jan 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mg1HOa2S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bs8HIRoi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841E39AC9;
	Wed, 31 Jan 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735685; cv=none; b=jWaGXBIX3UNnc4/I7+8OUUdehCg9rv87Qg0UTVCGfWmOFQ3RSrzsjCfj4QPADCvZK5JT1wqU1/IdIQj/TDVENl18VKDBfN3NC3zv5wYogmkC0ikwdPBYKc9IkFdTz74QNqTb+R2Tbr3dheJWMtTIISyERaj2rf3CNLQ+wgj7sKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735685; c=relaxed/simple;
	bh=2kI0pp2ebvjx3Net6f5BaCa+zCRiOI0i3Dcvsje3BWQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gomutT10SUKKXgmXAZzPNpiOCjOnJBL+SYp9IUffO5BMFMvvqNifmBIWRpY8PqRTMgywaZmcUF2CmCZ19cNcMvhyTesYBZVOvl87bKtP/48BLtAQreKDuQ+1+jXA5JU8Pn1UGm/gO1Sp7UdNQIwMIgJXHl5IG3BhxsrgXGQPyho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mg1HOa2S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bs8HIRoi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8KOhM5Qjx/tbTGBUaxGTsl3zbsHtEdTk0xpND8kSrA=;
	b=mg1HOa2SRNthC+jc56+zq6XTZz6oh66RIhDbNOv7X+f5oPTW5Ec3LL738tWZQU+/TcuBAV
	UUeEfeDUvI3n0JtgkLYzLtyz9bWExdH9dtlwguzck3GVDEWER+ODHLlpVJK/I346vtIMRT
	WI+G6oybZB2ZSNjQoSFCMZDeeQIEh2DMjK/MaSfKh3ivk1vIhbycr/7k89HQ7JsK/sQUMW
	n8n/5D20ywxf9R9uFVQ/UcADMxM2jRaTvDUaJhOJnFrqhO1bpSA8BfiUudofLm9mLE9Bo5
	DRNvOqLSVmMlg46+c4UzP/dOrFB7rbhHYNcJlNQfZYZdww/ITogUqeYRj+LfHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8KOhM5Qjx/tbTGBUaxGTsl3zbsHtEdTk0xpND8kSrA=;
	b=bs8HIRoiwzPZX0/YF9BG/2ThgIhD6EBia5Yakt1teeAZ4U1gX4VPJCyE2WZL93Y+7kXsM5
	3hV70CDKrjiYqoBQ==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] KVM: VMX: Call fred_entry_from_kvm() for IRQ/NMI handling
Cc: Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Shan Kang <shan.kang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-33-xin3.li@intel.com>
References: <20231205105030.8698-33-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568079.398.1185799126657342768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     70d0fe5d0923abfb28c26e71171944f4801f9f38
Gitweb:        https://git.kernel.org/tip/70d0fe5d0923abfb28c26e71171944f4801f9f38
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:21 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:03:20 +01:00

KVM: VMX: Call fred_entry_from_kvm() for IRQ/NMI handling

When FRED is enabled, call fred_entry_from_kvm() to handle IRQ/NMI in
IRQ/NMI induced VM exits.

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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
 

