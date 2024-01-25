Return-Path: <linux-kernel+bounces-39084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3AE83CABC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEF71F21507
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0FC13666F;
	Thu, 25 Jan 2024 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DB6gZpaF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8r4xDEi6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261811339BA;
	Thu, 25 Jan 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206888; cv=none; b=BiW/OMIerPlYEc/j5LjtKnIYHBKcyFaEYIG40juxM1Gz1BhnpuXyBFopWylMtgXzTTVQbPXnkr/3ziWMAEaqqR3Dv0QnsrXBN4/d3HGhfqZ7cM1QPl6GFhnYl79VCGPHpMt5BxmF18CtEfDBG85xpI8AphlUOwZH96yzxb7kVu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206888; c=relaxed/simple;
	bh=DTGg0oQnEsGMMJS2Yv0INqB56wI/aNOCoqNCNAlzcKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JSM9upWZXK9qhcfF1r4jnrDAFxzTI2hhZ9UM40ZgOey0NChMBlV8qIVV51i/P+liJSfZg3xFzeOqOD2GbEPY2AsApcYvpuBIL4RhcfO0ySIBlDCBIWNGxrGvt+9ORtNg2Xd4J/LeyXyUoRUJBL733nSx7WrJlW89qto9W/fAcZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DB6gZpaF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8r4xDEi6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FthTOXA9eejXL3xMmaYhS0l/niDguCOngnNTBeQ+r2w=;
	b=DB6gZpaFoGY4R9nRZyfw7d/qSx9PAqdjpMgOkr4edtxseBgWyIToZIyynp0MgYqo+JlIlC
	Sc0jGTAxfY4no14nGBIVP7XTF3TsYmHP/AuML3X24+a4VTLMtX/K2nSVJ2KxzP7aiv3WAT
	Pl3vA9gJccP7FE4D0mTYMGVbYssl8iYLg0Bq4ZmoGVkwlKbEQyFn5Esdj9hlShCCi1Walh
	e0Ausa4rWUw+WGJ63KzmGNb4ozxq37cyA5ZUkWsmv3g5Qi+srM5MNDjSpmpf8XPwhU9/IC
	OS3TqCnYuEhL6lH+3KJKV++KXDI1ZEfOcGz3AzUUSdaZ7Ee6aGp1ShdcUk5JFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206878;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FthTOXA9eejXL3xMmaYhS0l/niDguCOngnNTBeQ+r2w=;
	b=8r4xDEi66wLeBXDAI6yuDdd987jQtBxuUjDsKuEm41x57iFFAlyjBPypr36VbbAEnkYhXM
	KpbqMIkkdLFUdpBQ==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/entry: Add fred_entry_from_kvm() for VMX to
 handle IRQ/NMI
Cc: Sean Christopherson <seanjc@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Xin Li <xin3.li@intel.com>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-32-xin3.li@intel.com>
References: <20231205105030.8698-32-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620687731.398.5663831974471176573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     9a823c61c212a9f076abc4b95ca2cbc328fbed01
Gitweb:        https://git.kernel.org/tip/9a823c61c212a9f076abc4b95ca2cbc328fbed01
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:20 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:33 +01:00

x86/entry: Add fred_entry_from_kvm() for VMX to handle IRQ/NMI

In IRQ/NMI induced VM exits, KVM VMX needs to execute the respective
handlers, which requires the software to create a FRED stack frame,
and use it to invoke the handlers. Add fred_irq_entry_from_kvm() for
this job.

Export fred_entry_from_kvm() because VMX can be compiled as a module.

Suggested-by: Sean Christopherson <seanjc@google.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-32-xin3.li@intel.com

---
 arch/x86/entry/entry_64_fred.S | 77 +++++++++++++++++++++++++++++++++-
 arch/x86/entry/entry_fred.c    | 14 ++++++-
 arch/x86/include/asm/fred.h    | 18 ++++++++-
 3 files changed, 109 insertions(+)

diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index d1c2fc4..eedf98d 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -3,8 +3,11 @@
  * The actual FRED entry points.
  */
 
+#include <linux/export.h>
+
 #include <asm/asm.h>
 #include <asm/fred.h>
+#include <asm/segment.h>
 
 #include "calling.h"
 
@@ -54,3 +57,77 @@ SYM_CODE_START_NOALIGN(asm_fred_entrypoint_kernel)
 	FRED_EXIT
 	ERETS
 SYM_CODE_END(asm_fred_entrypoint_kernel)
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+SYM_FUNC_START(asm_fred_entry_from_kvm)
+	push %rbp
+	mov %rsp, %rbp
+
+	UNWIND_HINT_SAVE
+
+	/*
+	 * Both IRQ and NMI from VMX can be handled on current task stack
+	 * because there is no need to protect from reentrancy and the call
+	 * stack leading to this helper is effectively constant and shallow
+	 * (relatively speaking). Do the same when FRED is active, i.e., no
+	 * need to check current stack level for a stack switch.
+	 *
+	 * Emulate the FRED-defined redzone and stack alignment.
+	 */
+	sub $(FRED_CONFIG_REDZONE_AMOUNT << 6), %rsp
+	and $FRED_STACK_FRAME_RSP_MASK, %rsp
+
+	/*
+	 * Start to push a FRED stack frame, which is always 64 bytes:
+	 *
+	 * +--------+-----------------+
+	 * | Bytes  | Usage           |
+	 * +--------+-----------------+
+	 * | 63:56  | Reserved        |
+	 * | 55:48  | Event Data      |
+	 * | 47:40  | SS + Event Info |
+	 * | 39:32  | RSP             |
+	 * | 31:24  | RFLAGS          |
+	 * | 23:16  | CS + Aux Info   |
+	 * |  15:8  | RIP             |
+	 * |   7:0  | Error Code      |
+	 * +--------+-----------------+
+	 */
+	push $0				/* Reserved, must be 0 */
+	push $0				/* Event data, 0 for IRQ/NMI */
+	push %rdi			/* fred_ss handed in by the caller */
+	push %rbp
+	pushf
+	mov $__KERNEL_CS, %rax
+	push %rax
+
+	/*
+	 * Unlike the IDT event delivery, FRED _always_ pushes an error code
+	 * after pushing the return RIP, thus the CALL instruction CANNOT be
+	 * used here to push the return RIP, otherwise there is no chance to
+	 * push an error code before invoking the IRQ/NMI handler.
+	 *
+	 * Use LEA to get the return RIP and push it, then push an error code.
+	 */
+	lea 1f(%rip), %rax
+	push %rax				/* Return RIP */
+	push $0					/* Error code, 0 for IRQ/NMI */
+
+	PUSH_AND_CLEAR_REGS clear_bp=0 unwind_hint=0
+	movq %rsp, %rdi				/* %rdi -> pt_regs */
+	call __fred_entry_from_kvm		/* Call the C entry point */
+	POP_REGS
+	ERETS
+1:
+	/*
+	 * Objtool doesn't understand what ERETS does, this hint tells it that
+	 * yes, we'll reach here and with what stack state. A save/restore pair
+	 * isn't strictly needed, but it's the simplest form.
+	 */
+	UNWIND_HINT_RESTORE
+	pop %rbp
+	RET
+
+SYM_FUNC_END(asm_fred_entry_from_kvm)
+EXPORT_SYMBOL_GPL(asm_fred_entry_from_kvm);
+#endif
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index ed2146d..76aefe0 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -255,3 +255,17 @@ __visible noinstr void fred_entry_from_kernel(struct pt_regs *regs)
 
 	return fred_bad_type(regs, error_code);
 }
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+__visible noinstr void __fred_entry_from_kvm(struct pt_regs *regs)
+{
+	switch (regs->fred_ss.type) {
+	case EVENT_TYPE_EXTINT:
+		return fred_extint(regs);
+	case EVENT_TYPE_NMI:
+		return fred_exc_nmi(regs);
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+#endif
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 16a64ff..2fa9f34 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -9,6 +9,7 @@
 #include <linux/const.h>
 
 #include <asm/asm.h>
+#include <asm/trapnr.h>
 
 /*
  * FRED event return instruction opcodes for ERET{S,U}; supported in
@@ -62,12 +63,29 @@ static __always_inline unsigned long fred_event_data(struct pt_regs *regs)
 
 void asm_fred_entrypoint_user(void);
 void asm_fred_entrypoint_kernel(void);
+void asm_fred_entry_from_kvm(struct fred_ss);
 
 __visible void fred_entry_from_user(struct pt_regs *regs);
 __visible void fred_entry_from_kernel(struct pt_regs *regs);
+__visible void __fred_entry_from_kvm(struct pt_regs *regs);
+
+/* Can be called from noinstr code, thus __always_inline */
+static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector)
+{
+	struct fred_ss ss = {
+		.ss     =__KERNEL_DS,
+		.type   = type,
+		.vector = vector,
+		.nmi    = type == EVENT_TYPE_NMI,
+		.lm     = 1,
+	};
+
+	asm_fred_entry_from_kvm(ss);
+}
 
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { return 0; }
+static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
 #endif /* CONFIG_X86_FRED */
 #endif /* !__ASSEMBLY__ */
 

