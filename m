Return-Path: <linux-kernel+bounces-47122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C084499B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006801F22148
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197943A1CB;
	Wed, 31 Jan 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ox6XWPw8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5I6JyKQd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823439AF9;
	Wed, 31 Jan 2024 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735687; cv=none; b=FvQUdphsFCJp7GSpQaQTteIKjwTEJGvdn4xc1C1fHC3SRjxE22mIe1rtU8+7kdPsjsJrmKEAwPthitJD0xJG4z+HEa4OMOKim4PxBC+SPtSFcl2sgoiBcrWt3EDhJJDY8Jt0HU+/tsoR+6stykr3dEs2fy7lEGKMjAqShZ+MRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735687; c=relaxed/simple;
	bh=xVExGHuj1N8ZfmoGpd06cXvmqgfu9wl03sf2Z9kgbOs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YsycBlbjiz48a2amG1XnUAnXy25ETzZ7wZGKdk4CFM8I8PJ47/fIAdBhBHajw9KUPRZQXTyRBdoLne/jayiXqYuhy8wKZMw8atRsxS453Z0YKC09Jlqf4nW14Nc1NRgKGsF9BvWxOX7O0RbH81Kttn9KSvCciKnX8g1Wm5L7MeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ox6XWPw8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5I6JyKQd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66CW6xX1ZQQ79gZlcKmONZg6/Zt/FcK04Don7ZD0Bbk=;
	b=ox6XWPw8h8WFZuphVluWx7Dg3rJXG2CcJWjv+xyAC1cwJFL/uwo9QUnAXvqcnTsmXMhEw0
	Qn+e8U0hT9jSwTPLYm7SdJ12EYmu2XbjRXB6DcNbrE1qetcPotREljkEUZuEj4jnA74jG1
	7tClFoIwTcHOz2OejyHzWwUyUVDgfe0eEt9mA+rs/6E75wOz2yQKVQqQjYd+lSwESAyHfY
	15jqXKTHPDohbep55aFW1DeBZJHjef/ggj4E0iXN3xUH3HK7gW4UyB3fPRlTwrA1Q5tY+S
	ZSOz1HRpHqyYKfhZfDzWknUYLoUF7YPJeAmWHnaHzxWoHKkUeRg4AaCMbAq1xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=66CW6xX1ZQQ79gZlcKmONZg6/Zt/FcK04Don7ZD0Bbk=;
	b=5I6JyKQdM7xaT64pXoWaLrv6XDfYAQNDJZZs/jYkE2+HRK9bcO0JJZCmndsI810pnqIhI8
	ZIZlzyYxX2S6KIAA==
From: "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/entry/calling: Allow PUSH_AND_CLEAR_REGS being
 used beyond actual entry code
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-31-xin3.li@intel.com>
References: <20231205105030.8698-31-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568200.398.15470962496876345856.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     2333f3c473c1562633cd17ac2eb743c29c3b2d9d
Gitweb:        https://git.kernel.org/tip/2333f3c473c1562633cd17ac2eb743c29c3b2d9d
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 05 Dec 2023 02:50:19 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:03:09 +01:00

x86/entry/calling: Allow PUSH_AND_CLEAR_REGS being used beyond actual entry code

PUSH_AND_CLEAR_REGS could be used besides actual entry code; in that case
%rbp shouldn't be cleared (otherwise the frame pointer is destroyed) and
UNWIND_HINT shouldn't be added.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-31-xin3.li@intel.com
---
 arch/x86/entry/calling.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9f1d947..3ff925b 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -65,7 +65,7 @@ For 32-bit we have the following conventions - kernel is built with
  * for assembly code:
  */
 
-.macro PUSH_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
+.macro PUSH_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 unwind_hint=1
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -87,14 +87,17 @@ For 32-bit we have the following conventions - kernel is built with
 	pushq	%r13		/* pt_regs->r13 */
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
+
+	.if \unwind_hint
 	UNWIND_HINT_REGS
+	.endif
 
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
 	.endif
 .endm
 
-.macro CLEAR_REGS
+.macro CLEAR_REGS clear_bp=1
 	/*
 	 * Sanitize registers of values that a speculation attack might
 	 * otherwise want to exploit. The lower registers are likely clobbered
@@ -109,7 +112,9 @@ For 32-bit we have the following conventions - kernel is built with
 	xorl	%r10d, %r10d	/* nospec r10 */
 	xorl	%r11d, %r11d	/* nospec r11 */
 	xorl	%ebx,  %ebx	/* nospec rbx */
+	.if \clear_bp
 	xorl	%ebp,  %ebp	/* nospec rbp */
+	.endif
 	xorl	%r12d, %r12d	/* nospec r12 */
 	xorl	%r13d, %r13d	/* nospec r13 */
 	xorl	%r14d, %r14d	/* nospec r14 */
@@ -117,9 +122,9 @@ For 32-bit we have the following conventions - kernel is built with
 
 .endm
 
-.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0
-	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret
-	CLEAR_REGS
+.macro PUSH_AND_CLEAR_REGS rdx=%rdx rcx=%rcx rax=%rax save_ret=0 clear_bp=1 unwind_hint=1
+	PUSH_REGS rdx=\rdx, rcx=\rcx, rax=\rax, save_ret=\save_ret unwind_hint=\unwind_hint
+	CLEAR_REGS clear_bp=\clear_bp
 .endm
 
 .macro POP_REGS pop_rdi=1

