Return-Path: <linux-kernel+bounces-81624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3286787E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85CB2904AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5979312BE88;
	Mon, 26 Feb 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TeoOGVgj"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710DE12BE89
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708957811; cv=none; b=nwXNeU5it/U4GdJzVwrLpiVf0x6RtglOuDzw5yYp+Yktpn8gbFIBBoBn9hhw281+0wAupsp7NwqkIdMTU+fMa3WX7icKkoTgzdbyqMbWr2NPqpZJ0dxP3o+n9CkUK0Cet9GTfiM14mFHA94J00agDAdhOZM84ISNcJQ3Ndy6e1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708957811; c=relaxed/simple;
	bh=BbfBvgfVi77/QhkFi7YZNDyhrbZynGkOkpHyBXM04sE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aXapUhoF+z4WHE6qKgby3s9eRk+zHPUGkazqR38yineU+epf6OUFLxLGqLz/MtmbTgMjXNaufPJ5TmFppz8iUZWqcn83tUe3wFGUiwPDrbTxh6WlnzcHyC1GYjfY3P8gdKqheVNzwpjj1D3tgPRgpk6PIH0ZSc3OjXmWtEdOk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TeoOGVgj; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-33d308b0c76so1190085f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708957807; x=1709562607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggv/9mL4EwQQhS5S3/vq6rfpKgE+aVW7oD/WPNHnqXE=;
        b=TeoOGVgjf/+/FxX2ZXGvSn3YschiMOIY421Bc3MbAxB1fs+z7Ai2bReIGNE7NyZthr
         Jai2f5KdqOyOLumqHAcztnK2y0H0m2PNJ5E95BR2Clpxt48NBwpeSOZ8CD5aBoxXKO9R
         SKz3hHvPbThw6S1vHzJbBjChv3zmNMmBaeS8M8tOFqJFPe2nwB1Md9N/jdW9nCVzSP2i
         7skBL9wNRahxahNbHctFDh399EiumcT5Iz/S9km0fpN3A6dQm8pf3KgoejaA62AThbH8
         vZLVJ5JzOJ1kMxE4XsnITYPeZr7AXo4uRA6t96j8bHkJt6ECLe+m338bAmWbWAO5BZBg
         j5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708957807; x=1709562607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggv/9mL4EwQQhS5S3/vq6rfpKgE+aVW7oD/WPNHnqXE=;
        b=AElduKEJa06EId7DM/+dMQ15FgkKiA+wM+2H2/eXoEZUUQOhlPEU7rz49NINUF/7WN
         TZ6q5a/K0TfUAbeCrdVPvqdfdCSmtx9ZYyJR5dGiv+7IvOrxRvzme1vlfcvsp1WhzhmW
         QrdeIwlRhJVWgqEP1T/Ehik45ic7c4wRVPIdwrH+IoQ+HRZKeRVbz628rRUC3h4VyqpW
         u5E4xspJvba6/7Zavz75qvYBd3YxSLwV/NUKaHu2jwcEuo3ckdy+Q0ZyTtJkN3o4jr5K
         lvxrS9+GhwwqW1I197lIt/BdPU/gSzqPWJxhjfRdiynKESnIjh3CYK+0ZdXGEY9zkYcj
         miIA==
X-Gm-Message-State: AOJu0YzBuzIIVpbsLVpnrSVXEVCimTueMkOtvLFmh3YBXfZwwNxawVkg
	yKrvcea4rXh8gA2Oi9FcbRfFXyfd52n1LZZSS8fUA6y0+eXq9W5tTpVi3Q/xct5w2K/nYLK75x+
	Ely+z48bvUf4w6LT3D4+ATu4RKS3wN1bGOwGeZBIqF7mtKANK+4gVzXNRiAOXVvRdS4y5/Tzmlj
	6bhjEDE6rakqFPawUbaPPUUWlJ51PnsQ==
X-Google-Smtp-Source: AGHT+IGOa/0IIHkznSqdrVOzLLC9y/608OD7pg2KZa9XsWXSizRSdG2GuLAJENDIQ63llQx4vYg3m0Sa
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:4c8f:0:b0:33d:b376:89f0 with SMTP id
 z15-20020a5d4c8f000000b0033db37689f0mr21108wrs.4.1708957806552; Mon, 26 Feb
 2024 06:30:06 -0800 (PST)
Date: Mon, 26 Feb 2024 15:29:56 +0100
In-Reply-To: <20240226142952.64769-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240226142952.64769-12-ardb+git@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240226142952.64769-15-ardb+git@google.com>
Subject: [PATCH v6 03/10] x86/startup_64: Simplify calculation of initial page
 table address
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Determining the address of the initial page table to program into CR3
involves:
- taking the physical address
- adding the SME encryption mask

On the primary entry path, the code is mapped using a 1:1 virtual to
physical translation, so the physical address can be taken directly
using a RIP-relative LEA instruction.

On the secondary entry path, the address can be obtained by taking the
offset from the virtual kernel base (__START_kernel_map) and adding the
physical kernel base.

This is implemented in a slightly confusing way, so clean this up.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 25 ++++++--------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 1b054585bfd1..c451a72bc92b 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -111,13 +111,11 @@ SYM_CODE_START_NOALIGN(startup_64)
 	call	__startup_64
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(early_top_pgt - __START_KERNEL_map), %rax
+	leaq	early_top_pgt(%rip), %rcx
+	addq	%rcx, %rax
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	mov	%rax, %rdi
-	mov	%rax, %r14
-
-	addq	phys_base(%rip), %rdi
 
 	/*
 	 * For SEV guests: Verify that the C-bit is correct. A malicious
@@ -126,12 +124,6 @@ SYM_CODE_START_NOALIGN(startup_64)
 	 * the next RET instruction.
 	 */
 	call	sev_verify_cbit
-
-	/*
-	 * Restore CR3 value without the phys_base which will be added
-	 * below, before writing %cr3.
-	 */
-	 mov	%r14, %rax
 #endif
 
 	jmp 1f
@@ -171,18 +163,18 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	/* Clear %R15 which holds the boot_params pointer on the boot CPU */
 	xorq	%r15, %r15
 
+	/* Derive the runtime physical address of init_top_pgt[] */
+	movq	phys_base(%rip), %rax
+	addq	$(init_top_pgt - __START_KERNEL_map), %rax
+
 	/*
 	 * Retrieve the modifier (SME encryption mask if SME is active) to be
 	 * added to the initial pgdir entry that will be programmed into CR3.
 	 */
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	movq	sme_me_mask, %rax
-#else
-	xorq	%rax, %rax
+	addq	sme_me_mask(%rip), %rax
 #endif
 
-	/* Form the CR3 value being sure to include the CR3 modifier */
-	addq	$(init_top_pgt - __START_KERNEL_map), %rax
 1:
 
 	/*
@@ -207,9 +199,6 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	btsl	$X86_CR4_PSE_BIT, %ecx
 	movq	%rcx, %cr4
 
-	/* Setup early boot stage 4-/5-level pagetables. */
-	addq	phys_base(%rip), %rax
-
 	/*
 	 * Switch to new page-table
 	 *
-- 
2.44.0.rc0.258.g7320e95886-goog


