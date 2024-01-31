Return-Path: <linux-kernel+bounces-46959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848448446EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69761C22842
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599912FF8F;
	Wed, 31 Jan 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="azAuT+Vs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JUa4BKfQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1C12FF6F;
	Wed, 31 Jan 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724892; cv=none; b=SFDZ1Z7+Fpn09w7jm5u7pmy7OqcIs86qGLSydGoPMYtqO3nC/PKZlN4T0KKyA/m5Xo/EIuqwed/kwnJ+qv+dgZPC93YGzvbe/CdCvpLmCbbyxl2sbbFtSHHDEDRpXf9fFufJjJQElkDmnYzD+eQqAobUK7rS7t0EO06BWALv1sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724892; c=relaxed/simple;
	bh=Kxm3b0Tq6I4GCPKFx8UHEBf5T8K/P8TVsl4iccrNuAI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XJKhv9H4niBrW6Ui0ZZ3LDY3pp7q1Lh/kEO5ZIwgnPp6Y7XcvLNAwJm4ypBwIR2hAdp+MEQ2RGresz7CcCwC/OtTFYn2zGRfe9TWC1VQOY0jQOOHwVyrmZb7PE7hG7yirJna21YIPohwK1mgkQQPtkDBwlWEpDgCuQiFZJ/vLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=azAuT+Vs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JUa4BKfQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 18:14:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706724889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MypSRSwvNNFQNgU+xvq2l6bkUXCa3/+75PcoXD4s/ug=;
	b=azAuT+VsJtnhRefVqZ08Jc1iaWy6xNLpzIu5H1FAjBFuj9FaUx1OhwS34gx6ro1JKb94No
	xyYOGuCTjgEhaTGO+DMYkTi8CBiVc4n1sOFQTV8zTiDTgMEl41RHOVfzDuROkP9+csSHjL
	DIMF8elBPC7cSe3EYiHQqulR/8jGlxOj7cpGoTNQ3ACgYaSieZhifmOd57RBnL4wNh2QjU
	m5QZKqZqTPUlW1KrsiFGO0xbnuf8sf41faIDI18jN5UC+Ktw+Tn/PD3tu+kpdC2cvAsbtB
	a2va+iKf35IH+hoLzBf0FGptLQuI/H8My1bYirdOlas+qM2UWx3Zh4GFXdMRnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706724889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MypSRSwvNNFQNgU+xvq2l6bkUXCa3/+75PcoXD4s/ug=;
	b=JUa4BKfQZ8SVSp6FSPZl0PnOvFM7oTimTjw9GZ0oWzBD8ADPI1HSeVgdRYF5fnxhv/qagv
	vgDPlN6P/aSwCPBg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/startup_64: Drop long return to initial_code pointer
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240129180502.4069817-24-ardb+git@google.com>
References: <20240129180502.4069817-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170672488825.398.2902692058954576766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     15675706241887ed7fdad9e91f4bf977b9896d0f
Gitweb:        https://git.kernel.org/tip/15675706241887ed7fdad9e91f4bf977b9896d0f
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 29 Jan 2024 19:05:06 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 18:31:21 +01:00

x86/startup_64: Drop long return to initial_code pointer

Since

  866b556efa12 ("x86/head/64: Install startup GDT")

the primary startup sequence sets the code segment register (CS) to
__KERNEL_CS before calling into the startup code shared between primary
and secondary boot.

This means a simple indirect call is sufficient here.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240129180502.4069817-24-ardb+git@google.com
---
 arch/x86/kernel/head_64.S | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d4918d0..bfbac50 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -428,39 +428,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	%r15, %rdi
 
 .Ljump_to_C_code:
-	/*
-	 * Jump to run C code and to be on a real kernel address.
-	 * Since we are running on identity-mapped space we have to jump
-	 * to the full 64bit address, this is only possible as indirect
-	 * jump.  In addition we need to ensure %cs is set so we make this
-	 * a far return.
-	 *
-	 * Note: do not change to far jump indirect with 64bit offset.
-	 *
-	 * AMD does not support far jump indirect with 64bit offset.
-	 * AMD64 Architecture Programmer's Manual, Volume 3: states only
-	 *	JMP FAR mem16:16 FF /5 Far jump indirect,
-	 *		with the target specified by a far pointer in memory.
-	 *	JMP FAR mem16:32 FF /5 Far jump indirect,
-	 *		with the target specified by a far pointer in memory.
-	 *
-	 * Intel64 does support 64bit offset.
-	 * Software Developer Manual Vol 2: states:
-	 *	FF /5 JMP m16:16 Jump far, absolute indirect,
-	 *		address given in m16:16
-	 *	FF /5 JMP m16:32 Jump far, absolute indirect,
-	 *		address given in m16:32.
-	 *	REX.W + FF /5 JMP m16:64 Jump far, absolute indirect,
-	 *		address given in m16:64.
-	 */
-	pushq	$.Lafter_lret	# put return address on stack for unwinder
 	xorl	%ebp, %ebp	# clear frame pointer
-	movq	initial_code(%rip), %rax
-	pushq	$__KERNEL_CS	# set correct cs
-	pushq	%rax		# target address in negative space
-	lretq
-.Lafter_lret:
-	ANNOTATE_NOENDBR
+	ANNOTATE_RETPOLINE_SAFE
+	callq	*initial_code(%rip)
+	ud2
 SYM_CODE_END(secondary_startup_64)
 
 #include "verify_cpu.S"

