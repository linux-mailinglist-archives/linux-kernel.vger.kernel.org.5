Return-Path: <linux-kernel+bounces-78753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D47861859
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F0C0B26EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E38129A8E;
	Fri, 23 Feb 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKSYtuJ2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dbXUCI0R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E773E12839B;
	Fri, 23 Feb 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706787; cv=none; b=b+UZN+FAuBhRlaUYElOo925Aiu3piU9cIX1U7rxWEPMFXHBEtnF2dc5wSDNJBDsewNvl3ZVVgDj3+P2MKE7foLJ5xeF7iE2dFbHGjZHpvx2UDeMYat+BeZ/V7klZfh+Dql6fRDI5ozjc2q7FBPJTVSBgoEIEQG1Y6tSZpn+2J+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706787; c=relaxed/simple;
	bh=/BSuq4/86RjZ2LGVk3j8gdEPLDTykbNGwxB1TAs82K0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=PJcr3GUwlnWcjDu6avt0XdYbIQiwvDC+lilvbX24cDyuiAFGl/xFm/j3s52lKE/HYKzzGRaMOgjFJ3WOrfdxn7kK2bLYifT/4L/HTplnFN7xe1RqAGg2ZdmjjHC9VgRC+UiYplG8nC3nWO7YZx6yNRhz2Ttc95AgiWLXUy3g/2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKSYtuJ2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dbXUCI0R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 16:46:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708706784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gYbe1yDtXUyQ0sodWy4NQ+yO4YkaKvVupNCaCp2iDBo=;
	b=uKSYtuJ2wmHKc2fmU8RjR9p4AoeCxT7GkJk+VpoO7Uz9X6p0AAsfJbflyI4uFeHu8AIQPe
	/ZBpfu/OWSK3yS4FJqXlSk5bsLvgcx/ce77ihm7YvmYatp//1+HBJH1n5FjaD3CzLiXTmg
	I/Wdt4roq+BwW1XsEMIeJSdkUjd+lbIfirY97t6oe6bB2DAzWhtNaBFYoL3Pw/yIobfI8r
	aeHRl1jPu9GK6ejbKU6ZUiN3tOReQDNSI1xzX1O7YqMK4sYVctLoixzKqXsTJNO/zj1Uz0
	x/FTA2yAAozlXu4pDlZfDAC9V673OEKWbu/QAegQx4llFl2aPLsVYNv9EPtMNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708706784;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gYbe1yDtXUyQ0sodWy4NQ+yO4YkaKvVupNCaCp2iDBo=;
	b=dbXUCI0RawIlloYCbB7cV3VeIG7d02VmlIf8F5NBGd8YwNMGExhJNmVwHq0pZl7N0USWJ2
	e+Zqw7iVwpU1v8AA==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170870678304.398.7107349021319622516.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     c2cfc23f79676a9857a5a48911011bd56e23fd46
Gitweb:        https://git.kernel.org/tip/c2cfc23f79676a9857a5a48911011bd56e23fd46
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 26 Jan 2024 12:01:01 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 23 Feb 2024 08:40:29 -08:00

x86/trampoline: Bypass compat mode in trampoline_start64() if not needed

The trampoline_start64() vector is used when a secondary CPU starts in
64-bit mode. The current implementation directly enters compatibility
mode. It is necessary to disable paging and re-enable it in the correct
paging mode: either 4- or 5-level, depending on the configuration.

The X86S[1] ISA does not support compatibility mode in ring 0, and
paging cannot be disabled.

Rework the trampoline_start64() function to only enter compatibility
mode if it is necessary to change the paging mode. If the CPU is
already in the desired paging mode, proceed in long mode.

This allows a secondary CPU to boot on an X86S machine as long as the
CPU is already in the correct paging mode.

In the future, there will be a mechanism to switch between paging modes
without disabling paging.

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html

[ dhansen: changelog tweaks ]

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20240126100101.689090-1-kirill.shutemov%40linux.intel.com
---
 arch/x86/realmode/rm/trampoline_64.S | 33 ++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index c9f76fa..14d9c7d 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -37,13 +37,15 @@
 	.text
 	.code16
 
-.macro LOCK_AND_LOAD_REALMODE_ESP lock_pa=0
+.macro LOCK_AND_LOAD_REALMODE_ESP lock_pa=0 lock_rip=0
 	/*
 	 * Make sure only one CPU fiddles with the realmode stack
 	 */
 .Llock_rm\@:
 	.if \lock_pa
         lock btsl       $0, pa_tr_lock
+	.elseif \lock_rip
+        lock btsl       $0, tr_lock(%rip)
 	.else
         lock btsl       $0, tr_lock
 	.endif
@@ -220,6 +222,35 @@ SYM_CODE_START(trampoline_start64)
 	lidt	tr_idt(%rip)
 	lgdt	tr_gdt64(%rip)
 
+	/* Check if paging mode has to be changed */
+	movq	%cr4, %rax
+	xorl	tr_cr4(%rip), %eax
+	testl	$X86_CR4_LA57, %eax
+	jnz	.L_switch_paging
+
+	/* Paging mode is correct proceed in 64-bit mode */
+
+	LOCK_AND_LOAD_REALMODE_ESP lock_rip=1
+
+	movw	$__KERNEL_DS, %dx
+	movl	%edx, %ss
+	addl	$pa_real_mode_base, %esp
+	movl	%edx, %ds
+	movl	%edx, %es
+	movl	%edx, %fs
+	movl	%edx, %gs
+
+	movl	$pa_trampoline_pgd, %eax
+	movq	%rax, %cr3
+
+	pushq	$__KERNEL_CS
+	pushq	tr_start(%rip)
+	lretq
+.L_switch_paging:
+	/*
+	 * To switch between 4- and 5-level paging modes, it is necessary
+	 * to disable paging. This must be done in the compatibility mode.
+	 */
 	ljmpl	*tr_compat(%rip)
 SYM_CODE_END(trampoline_start64)
 

