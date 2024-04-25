Return-Path: <linux-kernel+bounces-158503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6748B2156
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8214BB24C02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BC012C544;
	Thu, 25 Apr 2024 12:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6+jeEJi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B012C46D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046679; cv=none; b=LfFvfPL3FjX9oSxWWYTEBaIkZAc/Zn+zCgB+Yjazm0O5c1M4M5g3o8AJhHW+MhPe+oVHeo0BltXJ1Cbh3GBNo1zhbwjcUXkhfabS+4Ag/l+aII+RSCLokVrikCCEQzNTCbgt4HcVVNUZPWrzL0KgQ6Rr0QRvT3pEd3GlvwyQ7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046679; c=relaxed/simple;
	bh=rF23wvKTq87SEeQ4ourazzrM1UpHiAnLoC7/CSIqNnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IqWNYX26cX1JGTDcayaO1+VMCxLL620bFzYrHpx7xHMy4UII80jIjStdH5Hnw4MGsggT51ifNfDm/0niZvoytNcm/SAEmNZudE4d09spAzvb8Lcx3MP4EmuVuZz5j8sIh32CXLcptL0z/g8hBe+vAtcVZ2V29MOaFChpSr3u2Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6+jeEJi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b028ae5easo16710347b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714046676; x=1714651476; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3uSrwI845cCjiiSjorMAUNJ/iyuZIm8zuWraMcqxvs=;
        b=B6+jeEJiYZMg8r7W1P1wB6vfCp4fjpj0qbxXEhIy/UQGHuRoajFzm4TQyXFr4e51sY
         HWQSCyrJaY8yJNT6IfQaBiJFKQXmrPHJYzvdSGTtr8VeGqT/0fTYjmACP461dqj72HLN
         ZUxbw07sFZiMWOyiDyng9lOAXQ5Au6jBxvtm36w3e2iwZbA6B+C29x5CYXShrCuOICEy
         IuEY3Hj1+sIFS8PTIWCCETpuvWHE0D/qfbJNana4Wvjm4+ZCdvtg6l/9h0ewwfQvsQGG
         P1LtxYmlDVrFZozgSZcMB//zmUC1ZGjIhjZXRRAhuJj2/xbBdGdQ+7O304sdueI81ZFv
         XRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714046676; x=1714651476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3uSrwI845cCjiiSjorMAUNJ/iyuZIm8zuWraMcqxvs=;
        b=SC1E3LFIZdFrmKrEZ88tq9ZzTxHYki+/6/b8maYqC867ynse2Eax2uqeMYDtjlU4wb
         rczBuffcHQsZU9nTqAzVQrIAW0Hgih37Qh2sVfzr8tcdLfmbmwB9j8tpA+vdxp6TeF4s
         KX4pQ2muokVd+ObG2ZiOB2idLA77XTu7dMvlyCxVMsxAQJvXkN+mfG8dIptKn5fCAkbZ
         BA95T4kyxKnz+szwtEnsh8f44ef8nWGEJ8ewkME01Xi0qkVFqHJ4aI9ABUx/Vf4VQohj
         KwsTL3QlJGFFGsYhj31J2MMtSqpSjGkVFVOWHEhNF+fArPdfkxPNrjGMYYi+kAbyH1SG
         4HOw==
X-Gm-Message-State: AOJu0Yw/FGToHPod8S7FDaiDzDsQDXP3VnSZcMN6Jp6RWWjNlovkf5NA
	tkKFzA/pCj55NEvKzo1AwUxYyqHaTVXBq1yPvTlxB5In+Vv9trAScUlmwtN9cd/R3DXkKpJvH9U
	n6mAYVCD1takc3arI/QyTQ7Z8BBA0v7CM1ya9xMP0SLGEqQzQdEc7U2whNNwnNICqmrdMZkQpSs
	81rlCBlrkDJFwwwT90/ZRSM548y6MQiQ==
X-Google-Smtp-Source: AGHT+IFyPYnxQ4Jm+h7UiFxOTB0Ck2tWMjCmnheR7HlmrBnYOgn1dDNHMX8jk8QOccBBA6TU9mst3Mrd
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:84e:b0:61b:7dd6:1b24 with SMTP id
 bz14-20020a05690c084e00b0061b7dd61b24mr1199861ywb.8.1714046676534; Thu, 25
 Apr 2024 05:04:36 -0700 (PDT)
Date: Thu, 25 Apr 2024 14:04:20 +0200
In-Reply-To: <20240425120416.2041037-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425120416.2041037-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4363; i=ardb@kernel.org;
 h=from:subject; bh=23IiH9zvtbn57cKpEGcuPb87YW4uD5sU5PW9hxnA730=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU3L7cjRwKPWcsbr65gEb7lUVP5qOSJmKyxxyCRf1EzMb
 f4HpykdpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKHEhkZmtN5vr37Z/+/LMN8
 uwjnBHWzN99nLMwwY3pfZhwhWNEnwvDf94WohWxxHc/X25cPydRyljGc+R9+P+Oifs7EZ+4s/pN ZAA==
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425120416.2041037-9-ardb+git@google.com>
Subject: [PATCH v2 3/4] x86/boot/64: Determine VA/PA offset before entering C code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Implicit absolute symbol references (e.g., taking the address of a
global variable) must be avoided from the C code that runs from the
early 1:1 mapping of the kernel, given that this is a practice that
violates assumptions on the part of the toolchain. I.e., absolute and
RIP-relative references are expected to produce the same result, and so
the compiler is free to choose either, and currently, the code assumes
that RIP-relative references are never emitted here.

So an explicit virtual-to-physical offset will be used instead to derive
the kernel virtual addresses of _text and _end, instead of simply taking
the address and having to rely on such implicit absolute symbol
references.

Currently, phys_base is used for this purpose, which is derived from the
kernel virtual address of _text, and this would lead to a circular
dependency. So instead, derive this virtual-to-physical offset in asm
code, using the kernel VA of common_startup_64 (which we already keep in
a global variable for other reasons), and pass it to the C startup code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/setup.h | 2 +-
 arch/x86/kernel/head64.c     | 8 +++++---
 arch/x86/kernel/head_64.S    | 9 ++++++++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index e61e68d71cba..aca18be5a228 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -47,7 +47,7 @@ extern unsigned long saved_video_mode;
 
 extern void reserve_standard_io_resources(void);
 extern void i386_reserve_resources(void);
-extern unsigned long __startup_64(unsigned long physaddr, struct boot_params *bp);
+extern unsigned long __startup_64(unsigned long p2v_offset, struct boot_params *bp);
 extern void startup_64_setup_gdt_idt(void);
 extern void early_setup_idt(void);
 extern void __init do_early_exception(struct pt_regs *regs, int trapnr);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index a817ed0724d1..81696a4967e6 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -138,12 +138,14 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
  * boot-time crashes. To work around this problem, every global pointer must
- * be accessed using RIP_REL_REF().
+ * be accessed using RIP_REL_REF(). Kernel virtual addresses can be determined
+ * by subtracting p2v_offset from the RIP-relative address.
  */
-unsigned long __head __startup_64(unsigned long physaddr,
+unsigned long __head __startup_64(unsigned long p2v_offset,
 				  struct boot_params *bp)
 {
 	pmd_t (*early_pgts)[PTRS_PER_PMD] = RIP_REL_REF(early_dynamic_pgts);
+	unsigned long physaddr = (unsigned long)&RIP_REL_REF(_text);
 	unsigned long pgtable_flags;
 	unsigned long load_delta;
 	pgdval_t *pgd;
@@ -163,7 +165,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Compute the delta between the address I am compiled to run at
 	 * and the address I am actually running at.
 	 */
-	load_delta = physaddr - (unsigned long)(_text - __START_KERNEL_map);
+	load_delta = __START_KERNEL_map + p2v_offset;
 	RIP_REL_REF(phys_base) = load_delta;
 
 	/* Is the address not 2M aligned? */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d8198fbd70e5..cb7efb3628ef 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -100,13 +100,20 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Sanitize CPU configuration */
 	call verify_cpu
 
+	/*
+	 * Use the 1:1 physical and kernel virtual addresses of
+	 * common_startup_64 to determine the physical-to-virtual offset, and
+	 * pass it as the first argument to __startup_64().
+	 */
+	leaq	common_startup_64(%rip), %rdi
+	subq	0f(%rip), %rdi
+
 	/*
 	 * Perform pagetable fixups. Additionally, if SME is active, encrypt
 	 * the kernel and retrieve the modifier (SME encryption mask if SME
 	 * is active) to be added to the initial pgdir entry that will be
 	 * programmed into CR3.
 	 */
-	leaq	_text(%rip), %rdi
 	movq	%r15, %rsi
 	call	__startup_64
 
-- 
2.44.0.769.g3c40516874-goog


