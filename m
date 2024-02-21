Return-Path: <linux-kernel+bounces-74637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF1E85D724
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424C41F234DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6674D9E3;
	Wed, 21 Feb 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUdSHzvF"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ADE4D134
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515354; cv=none; b=qPQFGOF9Pd/edIXIWN4IAhciO4gv49m09I9UXz7pIv08Km9zun1C7L/FCm+tIV1VohpM3dVNxtqW4bW+Do22cCQH/MvTmAkynZhkNUMVF0r6hulcobwpZAfCqMg1ZpaV7DhHb9Rk/mtB5O2BGqQmutl5wpYHSuPXwHOdkHInBEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515354; c=relaxed/simple;
	bh=+vNI1MmLFGS1GivHerZyjgoY4sNAT6wDfnGDYRsl6Po=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L0fId5mne7m7chEKaNQwpMETmLPp/GY1oOKf3t3bPRJKUUbyWSYevRTw6UWgqDXK7Jk5sr6Vu3Ah4PG7gxKgnFksJqiWjyIa1OwTDHGZecS2TDxJMRDFLwhryap47dDTapmONJ287n3c8VA2vQ17FkNcoK72WTxU7SfakRlNjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUdSHzvF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60832a48684so43910207b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515351; x=1709120151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EkxcLENiSlDOPoQNco4VFPfOwd/QcirP1cMQb5AjsLI=;
        b=HUdSHzvFKPPDstZtNL3AuROXQglCVOQW91cKv2q4pk+2jsrpvNUxc6qdc4t1/mPRX5
         AlB+Cr5BCSgREX05P0N5nOYVKEFQm8RfZXG1ya6ffkcRoNiOXpTJTrNQClXDp6lI7D2D
         k8KDOgLGC6L3M4pZgtaEpkKet2jWRduZXsl/Ybzf0ggM4OGkJdQ4ghu+idGoug8xLJsu
         KEbCSokgZjWd5j4CJEctAhPwwHBPsn6R+/0hew/rxEPd425BhMyKaBe6gsK0sqyx1gZG
         0bz3mrfsKf/x3lT/Z/+3nBIePxWybSuo+78weNarM2CHbv6sLEIbpzTXW2VbJ4s0q8AY
         Q7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515351; x=1709120151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkxcLENiSlDOPoQNco4VFPfOwd/QcirP1cMQb5AjsLI=;
        b=prNmuSEhFM/Dc6F9KrBn7FMJ/9COoRkJ1wvOiQWAMX8Cj4C7q7ddXkSdi8Wdj2XK9J
         eanOmAQQ36H9kG5HPeypMTVUos/vNcajEDsRI4ZZp/XkCXQEqdue3OdtyMPZpNpcO6VH
         OalYwWC/luiAVf6Qg0NnYARWuv9SAcwoy4orTMLohWC/3V8bOYzL9X/Lo0ayybtDEuF0
         8w0zX46IH2xnkUNg9yDB3MLrC2Jjegqx37ibEHkXQXnIO2WRO8H90oeLVe+rBQhzPspw
         0HsjDsQ4xbXE5AScmsEJY0Ru4NBNdlVlpyU6aOC0MAk+o31CzLactyxUAK7j0NmGrHgM
         41rA==
X-Gm-Message-State: AOJu0YwFakY13X16OFmxke1hm4GCmkmkGfYr/Qjz9+s2YydG0jQYvUOv
	UI3F217ptvt/+KylHlU0pudJI5yIYB8FRLn6i+bYqgb0LaxjDXaUjq1l+WRUGp3lfgAkn0deIu3
	sNSpyjM1g0xmuxm11GITvvCMs9mglT2ZERZ6K9TOI3+wESYFlt1uR/BLkzC/VkVMPgGCPgLr+ej
	t7Io5OWHMFCc8zNOxmEZTW4NboPyenzA==
X-Google-Smtp-Source: AGHT+IFTRE+rjlo0n123vKQQ/YSTuUniFgCWLLvxLk3zUHW0XkwfLMGbBSM3H4ZXpfRdO6tGiZoXr62j
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a0d:d790:0:b0:608:1fec:1dd8 with SMTP id
 z138-20020a0dd790000000b006081fec1dd8mr1741929ywd.6.1708515351508; Wed, 21
 Feb 2024 03:35:51 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:14 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2455; i=ardb@kernel.org;
 h=from:subject; bh=yaS/9ovMSw8F0QV6XZaoG3EypsAj0QA2cGCCi/EyQdM=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/Q+6elITfjUkXFxSXNX0UuVCU/Pf1rdHz2ydK3dXK
 7z/yoWTHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAij18wMvQIb7OtV6/2qrBx
 Cv98yNPx7toM9qoPhkYHVx1mi2xTXs7I8NctSEVKctq3g9P4dr+z/LD31RzWlr/pAolrNTynt09 3ZgAA
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-25-ardb+git@google.com>
Subject: [PATCH v5 07/16] x86/startup_64: Simplify CR4 handling in startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

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
therefore be omitted.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head_64.S | 24 +++++++-------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index fb2a98c29094..426f6fdc0075 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -185,6 +185,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	addq	$(init_top_pgt - __START_KERNEL_map), %rax
 1:
 
+	/* Create a mask of CR4 bits to preserve */
+	movl	$(X86_CR4_PAE | X86_CR4_LA57), %edx
 #ifdef CONFIG_X86_MCE
 	/*
 	 * Preserve CR4.MCE if the kernel will enable #MC support.
@@ -193,20 +195,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
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
@@ -226,11 +221,8 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 	 * Do a global TLB flush after the CR3 switch to make sure the TLB
 	 * entries from the identity mapping are flushed.
 	 */
-	movq	%cr4, %rcx
-	movq	%rcx, %rax
-	xorq	$X86_CR4_PGE, %rcx
+	btsl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
-	movq	%rax, %cr4
 
 	/* Ensure I am executing from virtual addresses */
 	movq	$1f, %rax
-- 
2.44.0.rc0.258.g7320e95886-goog


