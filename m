Return-Path: <linux-kernel+bounces-88408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246DB86E132
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC46E287B41
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27203FBBB;
	Fri,  1 Mar 2024 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s5hcxKmu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hu+OmJm1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C9210E6;
	Fri,  1 Mar 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709296797; cv=none; b=jYUolR13OWgPppW/ouhuDyk2H/rfK1e4hFVa3qxZyJgKI6KUqsewvycdafsPjMUErJUzNLeRDxcRtRqRB/OEIAbgSAMqIeM67pAO570IUFKgskXY2nhdiA0A6KAtCMljoUxaEHk0KgfCqnm1xQ87uuQ4VqbAEaSFtbgA52yWyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709296797; c=relaxed/simple;
	bh=5KawH1Xgk6F7NIVexpSdY71nUOEpwpolhEFVgGoFnAw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EIsRLNM+5gl1Ke9uesk6x2VRSxKNBsHP7HgmLLDdhpSd529xMnijOSzzrSU7NeNGFuBUNjXTlza7bbvcQEPetGj5b3/l5CeeC5e2EYEDRFBUx77N5VZfo8IPiBZ9BIlZ/vwYnJ0V5bEJkF+R0IsrMFdz0/lGMsjwiyUKkaOKr40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s5hcxKmu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hu+OmJm1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 12:39:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709296793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYxNSlgLBg6+/vw2aXKnmTKWdbDDwyTtC2Rtnz0LLP0=;
	b=s5hcxKmuho5rc0z4bRyhBN9eaxNsxSvQyM3891OgJotu1HuF5h+sbgPlofgVAC9A5mzghc
	4+KMLcS3WQFcr86gWtEEs5yepETePkp+qFIKK6075HDfZk0FN2TsDilgXKf3ZS9B5jjwjd
	0cWAGsD04tMtLdtO6x5JxPVNJH53wTC3x4KedYVvEXG+Bpk5MZzdFIbTqP1fu2I37Nldwv
	Jey9l7k/Nyg8odNiYyCyk0YMiJhWOG6X3v3PtxqvTN9V4BhQOMc2sK50lBhnHuP+aYn7uD
	eHdTuXDnz7Xz9TEUekRcbaSd6DT3eHjvMuiYNQ+w2SSajcX46nuEBFxzmS3MYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709296793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vYxNSlgLBg6+/vw2aXKnmTKWdbDDwyTtC2Rtnz0LLP0=;
	b=Hu+OmJm1EW6XHSuoUT2A0oDFVwoWqSHuaeYEBZHRhF5g3ICYBtCvgD06W7vgo/iobfcW4H
	XcjpXrjPApd8sIDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Use 32-bit XOR to clear registers
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240124103859.611372-1-ubizjak@gmail.com>
References: <20240124103859.611372-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170929679278.398.4143931058196373559.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     721f791ce1cddfa5f2bf524ac14741bfa0f72697
Gitweb:        https://git.kernel.org/tip/721f791ce1cddfa5f2bf524ac14741bfa0f72697
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 24 Jan 2024 11:38:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 01 Mar 2024 12:47:37 +01:00

x86/boot: Use 32-bit XOR to clear registers

x86_64 zero extends 32-bit operations, so for 64-bit operands,
XORL r32,r32 is functionally equal to XORQ r64,r64, but avoids
a REX prefix byte when legacy registers are used.

Slightly smaller code generated, no change in functionality.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20240124103859.611372-1-ubizjak@gmail.com
---
 arch/x86/kernel/head_64.S         | 6 +++---
 arch/x86/kernel/sev_verify_cbit.S | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d295bf6..86136a7 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -169,7 +169,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 
 	/* Clear %R15 which holds the boot_params pointer on the boot CPU */
-	xorq	%r15, %r15
+	xorl	%r15d, %r15d
 
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
@@ -178,7 +178,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	movq	sme_me_mask, %rax
 #else
-	xorq	%rax, %rax
+	xorl	%eax, %eax
 #endif
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
@@ -295,7 +295,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 .Llookup_AP:
 	/* EAX contains the APIC ID of the current CPU */
-	xorq	%rcx, %rcx
+	xorl	%ecx, %ecx
 	leaq	cpuid_to_apicid(%rip), %rbx
 
 .Lfind_cpunr:
diff --git a/arch/x86/kernel/sev_verify_cbit.S b/arch/x86/kernel/sev_verify_cbit.S
index 3355e27..1ab65f6 100644
--- a/arch/x86/kernel/sev_verify_cbit.S
+++ b/arch/x86/kernel/sev_verify_cbit.S
@@ -77,7 +77,7 @@ SYM_FUNC_START(sev_verify_cbit)
 	 * The check failed, prevent any forward progress to prevent ROP
 	 * attacks, invalidate the stack and go into a hlt loop.
 	 */
-	xorq	%rsp, %rsp
+	xorl	%esp, %esp
 	subq	$0x1000, %rsp
 2:	hlt
 	jmp 2b

