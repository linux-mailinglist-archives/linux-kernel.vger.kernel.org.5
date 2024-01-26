Return-Path: <linux-kernel+bounces-39945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FE583D7B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BB51C2E378
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E4A6BB5D;
	Fri, 26 Jan 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vtwIJfrR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SsMjlvWF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56CD6A340;
	Fri, 26 Jan 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261961; cv=none; b=uQ/GioFzYstJVa61Yo8eXcIt3G+G26dfrUm1upGAxT+0tZ6NABOlKF7VkiVgDyUA8UGBToCcfQFPbnJczoqnXlsdO60BfzyTUgkMlRpZxDUf21FzfnXUelcW+BofTS66ie6ptMtgt8WXcZsy67YAbYcvwgn7RNAXW+Ej6S1idw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261961; c=relaxed/simple;
	bh=8/nGVc25hEsrpaBi3vcfC0ze3rFc+5uJq/40Iyl91Xg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JBbpsZ8GbaXll/AO6vj6s02KEngTf98YaI/ievdoMtdIIbm3aCb50G74UKtOaovKLx2ZsrmswcSKB02iugqcErToHK7RBm6ddKdU2cjXIipti42BdA7gbZnR2NA5Y2sy0tedo747U96ENIDGJsv3q6YayUc/vIQEqMACFmFbAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vtwIJfrR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SsMjlvWF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jan 2024 09:39:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706261952;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kptBAk4WpxQXuqRz6AFSlDXWJzh5Pf1EtgT7ZTLVJY=;
	b=vtwIJfrRDWFMvNnG76AyALe2O9fv0z5oPDVBCUavXX+cvvCFS8MxOQVHjBI43TH4qmJsd9
	2oScwKTDMDsobsWiRV2r1/nvfwyRhIHDXJfKGpXl6Fi/poHg0DcE7Fa8+mxe78pmxKYNu2
	qNWENxgZKQG8mn3NA9sJ4/zErPa8SX4NVTGS7xW4zJ8iCcOljwr3zcMHUifObYtAKrDTkq
	l/iwQiDeBcF9LqMtKcZa46m1/NfyFMc0dBNEC/Q3ZH+6X3htG8A+RhGB3JYS03Ar5/mSbm
	xHiwGoFzNJZOg3ra0PpOi9AcV8FaFBNkO+wQ63eonHC5P7WM1tOm7BZcAkSIUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706261952;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/kptBAk4WpxQXuqRz6AFSlDXWJzh5Pf1EtgT7ZTLVJY=;
	b=SsMjlvWFAIHic/Vbg1uBsR0+hgBQcTAiIlLX2TuCFW4UG8P8ypARN89MBIjY1DGZ0ggBKR
	0RRV+uwsn3YzdvCg==
From: "tip-bot2 for Linus Torvalds" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Get rid of conditional IF flag handling in page
 fault path
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Uros Bizjak <ubizjak@gmail.com>,
 Sean Christopherson <seanjc@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240125173457.1281880-1-torvalds@linux-foundation.org>
References: <20240125173457.1281880-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170626195136.398.16499632195121642580.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     8f588afe6256c50b3d1f8a671828fc4aab421c05
Gitweb:        https://git.kernel.org/tip/8f588afe6256c50b3d1f8a671828fc4aab421c05
Author:        Linus Torvalds <torvalds@linux-foundation.org>
AuthorDate:    Thu, 25 Jan 2024 09:34:57 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 26 Jan 2024 10:27:54 +01:00

x86/mm: Get rid of conditional IF flag handling in page fault path

We had this nonsensical code that would happily handle kernel page
faults with interrupts disabled, which makes no sense at all.

It turns out that this is legacy code that _used_ to make sense, back
when we enabled IRQs as early as possible, and we used to have this code
sequence essentially immediately after reading the faulting address from
the %cr2 register.

Back then, we could have kernel page faults to populate the vmalloc area
with interrupts disabled, and they would need to stay disabled for that
case.

However, the code in question has been moved down in the page fault
handling, and is now in the "handle faults in user addresses" section,
and apparently nobody ever noticed that it no longer makes sense to
handle these page faults with interrupts conditionally disabled.

So replace the conditional IRQ enable:

        if (regs->flags & X86_EFLAGS_IF)
                local_irq_enable();

with an unconditional one, and add a temporary WARN_ON_ONCE() if some
codepath actually does do page faults with interrupts disabled (without
also doing a pagefault_disable(), of course).

NOTE! We used to allow user space to disable interrupts with iopl(3).
That is no longer true since commits:

 a24ca9976843 ("x86/iopl: Remove legacy IOPL option")
 b968e84b509d ("x86/iopl: Fake iopl(3) CLI/STI usage")

so the WARN_ON_ONCE() is valid for both the kernel and user situation.

For some of the history relevant to this code, see particularly commit
8c914cb704a1 ("x86_64: actively synchronize vmalloc area when
registering certain callbacks"), which moved this below the vmalloc fault
handling.

Now that the user_mode() check is irrelevant, we can also move the
FAULT_FLAG_USER flag setting down to where the other flag settings are
done.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20240125173457.1281880-1-torvalds@linux-foundation.org
---
 arch/x86/mm/fault.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 679b09c..150e002 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1302,21 +1302,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 	}
 
-	/*
-	 * It's safe to allow irq's after cr2 has been saved and the
-	 * vmalloc fault has been handled.
-	 *
-	 * User-mode registers count as a user access even for any
-	 * potential system fault or CPU buglet:
-	 */
-	if (user_mode(regs)) {
-		local_irq_enable();
-		flags |= FAULT_FLAG_USER;
-	} else {
-		if (regs->flags & X86_EFLAGS_IF)
-			local_irq_enable();
+	/* Legacy check - remove this after verifying that it doesn't trigger */
+	if (WARN_ON_ONCE(!(regs->flags & X86_EFLAGS_IF))) {
+		bad_area_nosemaphore(regs, error_code, address);
+		return;
 	}
 
+	local_irq_enable();
+
 	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 
 	/*
@@ -1332,6 +1325,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (error_code & X86_PF_INSTR)
 		flags |= FAULT_FLAG_INSTRUCTION;
 
+	/*
+	 * We set FAULT_FLAG_USER based on the register state, not
+	 * based on X86_PF_USER. User space accesses that cause
+	 * system page faults are still user accesses.
+	 */
+	if (user_mode(regs))
+		flags |= FAULT_FLAG_USER;
+
 #ifdef CONFIG_X86_64
 	/*
 	 * Faults in the vsyscall page might need emulation.  The

