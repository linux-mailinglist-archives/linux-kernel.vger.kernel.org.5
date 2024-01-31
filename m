Return-Path: <linux-kernel+bounces-45912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE48437C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8194F1F286BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E97F472;
	Wed, 31 Jan 2024 07:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r/Mb1OIo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b4qDEqgl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF707B3CF;
	Wed, 31 Jan 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685689; cv=none; b=cicmCcfNECAjk68w1y/XymZJ0sIC1s3mvDHh56I7Lvemlbyryc4S0BHuoltJfWIP0lSOUtrGule8Cy6bs7yaJx1sN+tfa7WKHaDwvbwimOo6Fp02fmerc4/O78HcWLzpB4JFg7PTrun/gJs/S79oY5A/srDjnTpNwPOys5McPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685689; c=relaxed/simple;
	bh=jUPIQl6gpRBz3QvX634TRS7tFgHooONeIw0QG3yv9eQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q7VnFg44PvCQajU1BPpHVWSZoMg+WPzzcKsrDwGWQgg8dyn/LubFTXip279KeOmX4BsomUEcI5tRsjOil9Ox+QgGvnx7NN7bxae+CWfZ0ILm1qq1b/n3TdJT6GW4NS9HaeB+6O8VGh/ckD8qLv0PxDYT76DXM2TB9hnwNSYUZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r/Mb1OIo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b4qDEqgl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 07:21:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706685685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Csy9ZE7kkyRi7vc6GraT1soDlWVn6IYMmm//Zsvuow=;
	b=r/Mb1OIonHsIYMc+OJh/LPXNc5mhtu+1zr1Ld2nBd/bpk1EnMPvS8zqg/PH5LEVw59l6x4
	29EFuhQzgnkHNQfnSrlsUYcgs9UvCwF+bPd/+Ek2SMkKHjWX/SaxBvtrD6QohrN450NPeY
	n+l4w7FYcAcH7zn4neMRYnhbGpBtp/BRIwv2U4H/9P3z71FL2tmXMJm1aoTBay9wV0u/R6
	gU9rKrLm1HjVe8wkXVC1AYtEVhOxPmZ4LdTzLE5LOo8ZIVnMr/7IAkRe8/M6hQxciaRpCg
	hDyBBVkzCvGM9EAUxS1oTl3h30nVmb1FdypS08Kpuzwag984JwqgzxK/s9FYvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706685685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Csy9ZE7kkyRi7vc6GraT1soDlWVn6IYMmm//Zsvuow=;
	b=b4qDEqglnxmVSUA1q4lZ5WQy6k182bxZt9mKJvSue09SK+HQGq6kRLfZqD14HCqEx+OaA5
	H2AKQ2bPc+nHyrCw==
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
Message-ID: <170668568429.398.15938527220341283566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     c125443456e97f7bcc87cc7ba1346c2b92c4db94
Gitweb:        https://git.kernel.org/tip/c125443456e97f7bcc87cc7ba1346c2b92c4db94
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:03 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jan 2024 18:20:34 +01:00

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
 

