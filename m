Return-Path: <linux-kernel+bounces-37524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2883B142
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5802872CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F67131E31;
	Wed, 24 Jan 2024 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2FzSXLks";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cxhsx3KW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134A13175C;
	Wed, 24 Jan 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121398; cv=none; b=rc5dU2mDuavS/D3Eoigz6At6EqIYmMpjSPHftXrMkR/Nt76olPpTg/CTwhskskVp+GLswDyqMbJRKYeKGezXSbCJzB43QyVDIJa7sAMFiVn2sFJma7o298f/EYGI0XW4wAAcRDGKxAAbiSKfeOBoH5G2BeOUcQVk9o2y/ybmdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121398; c=relaxed/simple;
	bh=S0060BCNkgD/6+5KStlu3aunKCqgkSKd/qKdUlSOX/U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V7FDPxuTJGbaHE9tAWQPhGjjRtSSpIdkhRBPTiYrHz4X+yw9qnGyYBt7jTcHtWqaqX7QZO1owb1yVMSRRDWnca7GlE4mLau4dZKksgvpYd4TXYGJ1WUN6Mz4xhJLRL4CDu1nEknmVhU6dynCiNaKwxCpZ+30j9XmIwrmErcH6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2FzSXLks; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cxhsx3KW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Jan 2024 18:36:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706121394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtsUkb213D4WAWpjwUUDVaqRdypDbLMljnco/bfd2E4=;
	b=2FzSXLksfYXEZpuMbcDv6kyvNVEkYHz4c6vK8RRvSR4s30d1EIGyb9DxYnl6mzBgUo0rXL
	6woFng9Y1ugn9TApSWi6mv0MKTH22UfA7jFdYW+QFbeRBxo4kTVaT4DOLN9KwszLK0Dxd0
	zuMc6Jw2eurVlFGWlnI2HKtEAjjSeqpeSKnDEDBfpRpyrxKnJuIkkg73CLsgcLAoBYDhoh
	Z1GGMpM+rHBocZKqYae037EiWWgTC6JAQXXZ1KnGWGoFl5Xhyh3blJXlCcBLU5u0+0UIOM
	qqj2l7ZGe0I0mEi/eLR5J+30vewHEL5VDu9RNf6iIBPXLydpo2MlyMwpKkTsmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706121394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WtsUkb213D4WAWpjwUUDVaqRdypDbLMljnco/bfd2E4=;
	b=Cxhsx3KWHmc+bQNDE7Kf3D/uzlMC6hb0ouRFtizBdzW4EWncSllzUZ1YZE5O6sYcOwvSfb
	fojz9u8gOVHv0GDw==
From: "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/entry] x86/entry: Avoid redundant CR3 write on paranoid returns
Cc: Lai Jiangshan <laijs@linux.alibaba.com>,
 Brendan Jackman <jackmanb@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240108113950.360438-1-jackmanb@google.com>
References: <20240108113950.360438-1-jackmanb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170612139384.398.13715690088153668463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     bb998361999e79bc87dae1ebe0f5bf317f632585
Gitweb:        https://git.kernel.org/tip/bb998361999e79bc87dae1ebe0f5bf317f632585
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Mon, 08 Jan 2024 11:39:50 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Jan 2024 13:57:59 +01:00

x86/entry: Avoid redundant CR3 write on paranoid returns

The CR3 restore happens in:

  1. #NMI return.
  2. paranoid_exit() (i.e. #MCE, #VC, #DB and #DF return)

Contrary to the implication in commit 21e94459110252 ("x86/mm: Optimize
RESTORE_CR3"), the kernel never modifies CR3 in any of these exceptions,
except for switching from user to kernel pagetables under PTI. That
means that most of the time when returning from an exception that
interrupted the kernel no CR3 restore is necessary. Writing CR3 is
expensive on some machines.

Most of the time because the interrupt might have come during kernel entry
before the user to kernel CR3 switch or the during exit after the kernel to
user switch. In the former case skipping the restore would be correct, but
definitely not for the latter.

So check the saved CR3 value and restore it only, if it is a user CR3.

Give the macro a new name to clarify its usage, and remove a comment that
was describing the original behaviour along with the not longer needed jump
label.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240108113950.360438-1-jackmanb@google.com

[Rewrote commit message; responded to review comments]
Change-Id: I6e56978c4753fb943a7897ff101f519514fa0827
---
 arch/x86/entry/calling.h  | 26 ++++++++++----------------
 arch/x86/entry/entry_64.S |  7 +++----
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9f1d947..92dca4a 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -239,17 +239,19 @@ For 32-bit we have the following conventions - kernel is built with
 .Ldone_\@:
 .endm
 
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+/* Restore CR3 from a kernel context. May restore a user CR3 value. */
+.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
 	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
 
-	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
-
 	/*
-	 * KERNEL pages can always resume with NOFLUSH as we do
-	 * explicit flushes.
+	 * If CR3 contained the kernel page tables at the paranoid exception
+	 * entry, then there is nothing to restore as CR3 is not modified while
+	 * handling the exception.
 	 */
 	bt	$PTI_USER_PGTABLE_BIT, \save_reg
-	jnc	.Lnoflush_\@
+	jnc	.Lend_\@
+
+	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
 
 	/*
 	 * Check if there's a pending flush for the user ASID we're
@@ -257,20 +259,12 @@ For 32-bit we have the following conventions - kernel is built with
 	 */
 	movq	\save_reg, \scratch_reg
 	andq	$(0x7FF), \scratch_reg
-	bt	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jnc	.Lnoflush_\@
-
 	btr	\scratch_reg, THIS_CPU_user_pcid_flush_mask
-	jmp	.Lwrcr3_\@
+	jc	.Lwrcr3_\@
 
-.Lnoflush_\@:
 	SET_NOFLUSH_BIT \save_reg
 
 .Lwrcr3_\@:
-	/*
-	 * The CR3 write could be avoided when not changing its value,
-	 * but would require a CR3 read *and* a scratch register.
-	 */
 	movq	\save_reg, %cr3
 .Lend_\@:
 .endm
@@ -285,7 +279,7 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 .macro SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg:req save_reg:req
 .endm
-.macro RESTORE_CR3 scratch_reg:req save_reg:req
+.macro PARANOID_RESTORE_CR3 scratch_reg:req save_reg:req
 .endm
 
 #endif
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c40f89a..aedd169 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -968,14 +968,14 @@ SYM_CODE_START_LOCAL(paranoid_exit)
 	IBRS_EXIT save_reg=%r15
 
 	/*
-	 * The order of operations is important. RESTORE_CR3 requires
+	 * The order of operations is important. PARANOID_RESTORE_CR3 requires
 	 * kernel GSBASE.
 	 *
 	 * NB to anyone to try to optimize this code: this code does
 	 * not execute at all for exceptions from user mode. Those
 	 * exceptions go through error_return instead.
 	 */
-	RESTORE_CR3	scratch_reg=%rax save_reg=%r14
+	PARANOID_RESTORE_CR3 scratch_reg=%rax save_reg=%r14
 
 	/* Handle the three GSBASE cases */
 	ALTERNATIVE "jmp .Lparanoid_exit_checkgs", "", X86_FEATURE_FSGSBASE
@@ -1404,8 +1404,7 @@ end_repeat_nmi:
 	/* Always restore stashed SPEC_CTRL value (see paranoid_entry) */
 	IBRS_EXIT save_reg=%r15
 
-	/* Always restore stashed CR3 value (see paranoid_entry) */
-	RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
+	PARANOID_RESTORE_CR3 scratch_reg=%r15 save_reg=%r14
 
 	/*
 	 * The above invocation of paranoid_entry stored the GSBASE

