Return-Path: <linux-kernel+bounces-39101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5B983CAE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 709F91C2414C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CABC13BE9B;
	Thu, 25 Jan 2024 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Ej8uxga";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YoPlqJgR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5C133991;
	Thu, 25 Jan 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206896; cv=none; b=JPPwIdcIlfO7b3XzGCniEamECEnZxuqrjoNj5610FNXAYiV/JAbkLLYNm9ImE3UoN2OR2ile6DzT7kb36XwLI2Mnr2nyzk8A0Ss1IbTyuHbxhIRkQ6VBEIwOU3M6Q23GV0TuVgGU14eLTWpjQc9jPcSedXyEWesI5csn8rLFJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206896; c=relaxed/simple;
	bh=9X0Aq3W6O7Pi+0blhrQZ0IJmb0xnB1kZVFqLsMDPLiw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RRUgh9hxf64zfTOxBkQLSh2X8c7YFIQHPwA70KGPFdwwjymqS9b96jRETPfdwMkD6TzMP0cODR0CVReMbY8Vc16zJswtIq943x2jUeFSHrjrPOXtYd6DOQNI9b4CQyFaQUDEcrv9TFx3fI7Mf3r0AJ+rySje9CTBcdjNtynEczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Ej8uxga; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YoPlqJgR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsXu5E0CT5+zxfOy0Nq1HEh/6NfCuhsdxc8qTj9ugmI=;
	b=0Ej8uxgahhb/bCoegk0xGm+AkitkJG9s3x/3PkU4k3eGLGhGcrJk75I03QUEw1aOF65WO8
	UqRRsebYYt6MxwUvUEW/VDS1KWzP5FCpNBJ61rSCb4ef/6enxx9GIFaMTxyCF/9pcopwQw
	YuNQ2ksveWTkECQA1nZfmpX9nIQiRlhkV2PkKHKoJsur4BqtnXF+NcardnfPiDXV82LGyn
	oToixld65PcPpnIiRjd79GGt4RRtzrTo9cFjPRd5l2b+MMKfBsVCMDrKQBnzGlpSRJSTtd
	ks3pRPJ2206GSsHWXTGmMhmBhRv8q6pqk6B8Gkf4sAA6V0WuGb9wAKuiCaaVgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206892;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JsXu5E0CT5+zxfOy0Nq1HEh/6NfCuhsdxc8qTj9ugmI=;
	b=YoPlqJgRqD5G2K2kIjTZAwX6lGm/7ByEc38KiVf3jeRFBhjBpeGZEhUINWj6UkBha53xCp
	OJZXMBpPmcFOpKDA==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/ptrace: Add FRED additional information to the
 pt_regs structure
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Shan Kang <shan.kang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-15-xin3.li@intel.com>
References: <20231205105030.8698-15-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620689138.398.4877184218031207702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     078f58767cfea21dc9a153cc9e463e6ce481d87c
Gitweb:        https://git.kernel.org/tip/078f58767cfea21dc9a153cc9e463e6ce481d87c
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:03 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:31 +01:00

x86/ptrace: Add FRED additional information to the pt_regs structure

FRED defines additional information in the upper 48 bits of cs/ss
fields. Therefore add the information definitions into the pt_regs
structure.

Specifically introduce a new structure fred_ss to denote the FRED flags
above SS selector, which avoids FRED_SSX_ macros and makes the code
simpler and easier to read.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Originally-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-15-xin3.li@intel.com

---
 arch/x86/include/asm/ptrace.h | 66 +++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index b268cd2..5a83fbd 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -56,6 +56,50 @@ struct pt_regs {
 
 #else /* __i386__ */
 
+struct fred_cs {
+		/* CS selector */
+	u64	cs	: 16,
+		/* Stack level at event time */
+		sl	:  2,
+		/* IBT in WAIT_FOR_ENDBRANCH state */
+		wfe	:  1,
+			: 45;
+};
+
+struct fred_ss {
+		/* SS selector */
+	u64	ss	: 16,
+		/* STI state */
+		sti	:  1,
+		/* Set if syscall, sysenter or INT n */
+		swevent	:  1,
+		/* Event is NMI type */
+		nmi	:  1,
+			: 13,
+		/* Event vector */
+		vector	:  8,
+			:  8,
+		/* Event type */
+		type	:  4,
+			:  4,
+		/* Event was incident to enclave execution */
+		enclave	:  1,
+		/* CPU was in long mode */
+		lm	:  1,
+		/*
+		 * Nested exception during FRED delivery, not set
+		 * for #DF.
+		 */
+		nested	:  1,
+			:  1,
+		/*
+		 * The length of the instruction causing the event.
+		 * Only set for INTO, INT1, INT3, INT n, SYSCALL
+		 * and SYSENTER.  0 otherwise.
+		 */
+		insnlen	:  4;
+};
+
 struct pt_regs {
 	/*
 	 * C ABI says these regs are callee-preserved. They aren't saved on
@@ -85,6 +129,12 @@ struct pt_regs {
 	 * - the syscall number (syscall, sysenter, int80)
 	 * - error_code stored by the CPU on traps and exceptions
 	 * - the interrupt number for device interrupts
+	 *
+	 * A FRED stack frame starts here:
+	 *   1) It _always_ includes an error code;
+	 *
+	 *   2) The return frame for ERET[US] starts here, but
+	 *      the content of orig_ax is ignored.
 	 */
 	unsigned long orig_ax;
 
@@ -92,24 +142,30 @@ struct pt_regs {
 	unsigned long ip;
 
 	union {
-		/* The full 64-bit data slot containing CS */
-		u64		csx;
 		/* CS selector */
 		u16		cs;
+		/* The extended 64-bit data slot containing CS */
+		u64		csx;
+		/* The FRED CS extension */
+		struct fred_cs	fred_cs;
 	};
 
 	unsigned long flags;
 	unsigned long sp;
 
 	union {
-		/* The full 64-bit data slot containing SS */
-		u64		ssx;
 		/* SS selector */
 		u16		ss;
+		/* The extended 64-bit data slot containing SS */
+		u64		ssx;
+		/* The FRED SS extension */
+		struct fred_ss	fred_ss;
 	};
 
 	/*
-	 * Top of stack on IDT systems.
+	 * Top of stack on IDT systems, while FRED systems have extra fields
+	 * defined above for storing exception related information, e.g. CR2 or
+	 * DR6.
 	 */
 };
 

