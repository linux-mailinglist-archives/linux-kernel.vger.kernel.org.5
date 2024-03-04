Return-Path: <linux-kernel+bounces-91350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E42870FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9321F232FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880227FBC2;
	Mon,  4 Mar 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nws/+maB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QAIfG7VD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8607C088;
	Mon,  4 Mar 2024 22:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590146; cv=none; b=LVncbSisEh7d3vKVyb50HuBL6eGmh7z7vDy0oqdF4HCLO6NWKIjgPCgD21Ojs3+uRSKrNz5T/ysfUojU0JSwDgtKXx+H1Pj4VKyVVfTkDws4YEk0bORr3U4ntDF8scPf8OgnyhYmzhZoTqjIzs1klrcXDLDmzy/4+yPELT17Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590146; c=relaxed/simple;
	bh=mwsNsPTcJgw7POzePEJUeVe5RFPJzTbY68HUVK/5/RM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bkw+BbtRFB+bBdY6b/zwCsAvXBr1dUJdGecHtQcU381S+7Wf2ichvux7rL9s8Ixi2SsPYrv881y6+a6sa/iykbCDfrO5U8dJ8F5RyrFrK4LvUu8jxOCzs7bfJEsqt3xoa1nDpFX7WT8H9gE7y+sF/yuajzaNFtoGRGpHqtv7h6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nws/+maB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QAIfG7VD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Mar 2024 22:09:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709590143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWu+9cqz9ZEnowtnIH/Jg7f6Wor/MJjODVLpFskQ1HY=;
	b=Nws/+maBDofWmUE13jC35YIi98x5U/mBs9yCl216hzF/tj8j0l3bJhtY8K3OJEbXADPEGa
	fzuCB/y9ne+x8frtSOnWhA4szBrYv4Qpt0qL55PHVqMjIA/dYVO9mnTjewQ6c/WPHAf50K
	nGC2iu/w+3bM0Obcc5KkJWI9hB6Nyw5c9dvkwrTMha+5oWtHHtJR5Wxg9EOgfUKhIoMM89
	31NkXbvqV+ONWZDg4fhaMNsnu/0PF3z99gTgTHp/AkSNjymGlpVaESq2+GKs0ppAXi26MJ
	V8eK1+aY7zeBYLjp5ubb5ue+4sl4N8StHUBAVVMSdv7k2dj4269Zk0UmqvBcSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709590143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWu+9cqz9ZEnowtnIH/Jg7f6Wor/MJjODVLpFskQ1HY=;
	b=QAIfG7VD7ByJ454PfA5zHSBeZzICLoDzBskMZlMKhovvjsKTD3K0DqEXpk3simA0XNiv1M
	SfVAsAYlGZIbx1DA==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/startup_64: Simplify virtual switch on primary boot
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240227151907.387873-15-ardb+git@google.com>
References: <20240227151907.387873-15-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170959014248.398.2869486406537158618.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     828263957611c210da00c1820db73fac217135b6
Gitweb:        https://git.kernel.org/tip/828263957611c210da00c1820db73fac217135b6
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 27 Feb 2024 16:19:12 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 04 Mar 2024 18:12:20 +01:00

x86/startup_64: Simplify virtual switch on primary boot

The secondary startup code is used on the primary boot path as well, but
in this case, the initial part runs from a 1:1 mapping, until an
explicit cross-jump is made to the kernel virtual mapping of the same
code.

On the secondary boot path, this jump is pointless as the code already
executes from the mapping targeted by the jump. So combine this
cross-jump with the jump from startup_64() into the common boot path.
This simplifies the execution flow, and clearly separates code that runs
from a 1:1 mapping from code that runs from the kernel virtual mapping.

Note that this requires a page table switch, so hoist the CR3 assignment
into startup_64() as well. And since absolute symbol references will no
longer be permitted in .head.text once we enable the associated build
time checks, a RIP-relative memory operand is used in the JMP
instruction, referring to an absolute constant in the .init.rodata
section.

Given that the secondary startup code does not require a special
placement inside the executable, move it to the .text section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240227151907.387873-15-ardb+git@google.com
---
 arch/x86/kernel/head_64.S | 42 +++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index b8b7118..79f7c34 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -39,7 +39,6 @@ L4_START_KERNEL = l4_index(__START_KERNEL_map)
 
 L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
-	.text
 	__HEAD
 	.code64
 SYM_CODE_START_NOALIGN(startup_64)
@@ -126,9 +125,21 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	sev_verify_cbit
 #endif
 
-	jmp 1f
+	/*
+	 * Switch to early_top_pgt which still has the identity mappings
+	 * present.
+	 */
+	movq	%rax, %cr3
+
+	/* Branch to the common startup code at its kernel virtual address */
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*0f(%rip)
 SYM_CODE_END(startup_64)
 
+	__INITRODATA
+0:	.quad	common_startup_64
+
+	.text
 SYM_CODE_START(secondary_startup_64)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -174,8 +185,15 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	addq	sme_me_mask(%rip), %rax
 #endif
+	/*
+	 * Switch to the init_top_pgt here, away from the trampoline_pgd and
+	 * unmap the identity mapped ranges.
+	 */
+	movq	%rax, %cr3
 
-1:
+SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
+	UNWIND_HINT_END_OF_STACK
+	ANNOTATE_NOENDBR
 
 	/*
 	 * Create a mask of CR4 bits to preserve. Omit PGE in order to flush
@@ -205,29 +223,11 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	movq	%rcx, %cr4
 
 	/*
-	 * Switch to new page-table
-	 *
-	 * For the boot CPU this switches to early_top_pgt which still has the
-	 * identity mappings present. The secondary CPUs will switch to the
-	 * init_top_pgt here, away from the trampoline_pgd and unmap the
-	 * identity mapped ranges.
-	 */
-	movq	%rax, %cr3
-
-	/*
 	 * Set CR4.PGE to re-enable global translations.
 	 */
 	btsl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
 
-	/* Ensure I am executing from virtual addresses */
-	movq	$1f, %rax
-	ANNOTATE_RETPOLINE_SAFE
-	jmp	*%rax
-1:
-	UNWIND_HINT_END_OF_STACK
-	ANNOTATE_NOENDBR // above
-
 #ifdef CONFIG_SMP
 	/*
 	 * For parallel boot, the APIC ID is read from the APIC, and then

