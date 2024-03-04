Return-Path: <linux-kernel+bounces-91353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A96870FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D11AB274C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523558062D;
	Mon,  4 Mar 2024 22:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdOTehSn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KA70iocv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16E97FBC5;
	Mon,  4 Mar 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590149; cv=none; b=mEj1/OuQZocQX6lkJ0TkRl43k4UzLB4siMrnO+DQ4WKFKnVMx9Uh4uOVto3bPdSt1EFbmGp8L1VpuzJ2W1HM0UZuXAK/R1cJQosy9CpZhtKFInOUDi1+ROpSDMRXim044UxjO16Yf6fctqBPK2gtqzjX/2QiNEgKuY4Z4e0mjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590149; c=relaxed/simple;
	bh=xCyVbzs6uHQlqTa82S68d5ETNsdVmItgKMc6XoV8gYI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bm27zzanm0lKzF77IyG8UThljpxKzc7+AJcRgzmi5J9EMaxFzrISW/7Zgw9Ye1E7z9KVu2ZU4LdTIYvvWEqJcWx0lI9Mao03AkuXtUB6AVsnhkcqLTYSsYn7h1YR0ari6rTl4vh1IYE8TfNOwYUuQwHd5E+m2bCTAKSLzbTv0hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kdOTehSn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KA70iocv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 22:09:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709590146;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1C4wtYgWSShlzUjRgY4KbuT32FTRtIl2ExRgRhq5Sig=;
	b=kdOTehSnf/oZYNPE9jZ/vBTJTgYVQfxgLEAOaUO4Igrf0Cv1wiYLNdbgs2eGqM+RYdZrA3
	GNFJt5iaT6lo4vVyhfsgEqCZ72v4gsmkEvasgphbkbLXJ8uZ7GNH3X8VVd1VLrHxvLIdbt
	oi5X768QmUTlUNRg+0+j1+BQuttuXd642rU9BdAYboXTg7cdA5WYhudY3cH0BGRJI9YEaQ
	8WBCDfWnN87X7aetNYJfincZuMEzTQ2JlZhAs+Uxi0v2kzPOixU3sckAhJyRdSXQ7YerXD
	Ul9ylvGPB/gPlY4kDXnVyIGDkOQ1k7ilCPUpgTvTg9GUUgeSpvVJmcyRJzSJ5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709590146;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1C4wtYgWSShlzUjRgY4KbuT32FTRtIl2ExRgRhq5Sig=;
	b=KA70iocvCpyZQHJOHxGGg2io4x59T9DQ+H4eDnrgn9+wCaQgOe6bEvEqiX9hIHhD70Kb3h
	/uT/tIk9HGr9A5Dg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/startup_64: Simplify CR4 handling in startup code
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240227151907.387873-12-ardb+git@google.com>
References: <20240227151907.387873-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170959014519.398.9871521957540564245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     dada8587068c820ba5e5d09b9c32d8bc28c4dbe6
Gitweb:        https://git.kernel.org/tip/dada8587068c820ba5e5d09b9c32d8bc28c4dbe6
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 27 Feb 2024 16:19:09 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 04 Mar 2024 18:11:34 +01:00

x86/startup_64: Simplify CR4 handling in startup code

When paging is enabled, the CR4.PAE and CR4.LA57 control bits cannot be
changed, and so they can simply be preserved rather than reason about
whether or not they need to be set. CR4.MCE should be preserved unless
the kernel was built without CONFIG_X86_MCE, in which case it must be
cleared.

CR4.PSE should be set explicitly, regardless of whether or not it was
set before.

CR4.PGE is set explicitly, and then cleared and set again after
programming CR3 in order to flush TLB entries based on global
translations. This makes the first assignment redundant, and can
therefore be omitted. So clear PGE by omitting it from the preserve
mask, and set it again explicitly after switching to the new page
tables.

  [ bp: Document the exact operation of CR4.PGE ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240227151907.387873-12-ardb+git@google.com
---
 arch/x86/kernel/head_64.S | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 86136a7..54207e7 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -185,6 +185,16 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	addq	$(init_top_pgt - __START_KERNEL_map), %rax
 1:
 
+	/*
+	 * Create a mask of CR4 bits to preserve. Omit PGE in order to flush
+	 * global 1:1 translations from the TLBs.
+	 *
+	 * From the SDM:
+	 * "If CR4.PGE is changing from 0 to 1, there were no global TLB
+	 *  entries before the execution; if CR4.PGE is changing from 1 to 0,
+	 *  there will be no global TLB entries after the execution."
+	 */
+	movl	$(X86_CR4_PAE | X86_CR4_LA57), %edx
 #ifdef CONFIG_X86_MCE
 	/*
 	 * Preserve CR4.MCE if the kernel will enable #MC support.
@@ -193,20 +203,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * configured will crash the system regardless of the CR4.MCE value set
 	 * here.
 	 */
-	movq	%cr4, %rcx
-	andl	$X86_CR4_MCE, %ecx
-#else
-	movl	$0, %ecx
+	orl	$X86_CR4_MCE, %edx
 #endif
+	movq	%cr4, %rcx
+	andl	%edx, %ecx
 
-	/* Enable PAE mode, PSE, PGE and LA57 */
-	orl	$(X86_CR4_PAE | X86_CR4_PSE | X86_CR4_PGE), %ecx
-#ifdef CONFIG_X86_5LEVEL
-	testb	$1, __pgtable_l5_enabled(%rip)
-	jz	1f
-	orl	$X86_CR4_LA57, %ecx
-1:
-#endif
+	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */
+	btsl	$X86_CR4_PSE_BIT, %ecx
 	movq	%rcx, %cr4
 
 	/* Setup early boot stage 4-/5-level pagetables. */
@@ -223,14 +226,10 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	%rax, %cr3
 
 	/*
-	 * Do a global TLB flush after the CR3 switch to make sure the TLB
-	 * entries from the identity mapping are flushed.
+	 * Set CR4.PGE to re-enable global translations.
 	 */
-	movq	%cr4, %rcx
-	movq	%rcx, %rax
-	xorq	$X86_CR4_PGE, %rcx
+	btsl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
-	movq	%rax, %cr4
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax

