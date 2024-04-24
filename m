Return-Path: <linux-kernel+bounces-157255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82328B0F24
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203141F23302
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABE41649DA;
	Wed, 24 Apr 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugi2y/zj"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6C8161314
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974020; cv=none; b=Dv2AOY7tb8DgeHO5BBgs2JHsOlCE/LViR3z1D/hHysBw8+Et2kgKXHmrB3om6oJKja/gttOSI5qmIyHfxQT1gJxvJ+Xp8fjgMqub6rw4A/SBIRCL8LiC6FW4PhKDiLka1Pjjnp7fjKwSZB1OW50DUW2BZoUxhfI1V5DK96HXzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974020; c=relaxed/simple;
	bh=UGJFnwz8Yivv3UDxxViYQxnCrqFztPuVzkCiJJhxZBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g7m+P2zPDBvhrkuoejY53RojXfOZvhykZHzqULXVCXECFkIn4bKr3qFE/HsSIxEuEOFsF1G5hVNZ0NSNbZ5mDFe+dAjdozh1iA3JDg3ZgvErmHaCBKLHO8iK20dCTt1hbnCXGyeAzjS2g7anSz0em8gjQUL/hVlGChnyz1Tsyfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugi2y/zj; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343d02b62ddso4842983f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974017; x=1714578817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSE6Y9L7llOYPHAz3r3bPOJVA5fqH/Ut+JPxK7SpOhY=;
        b=ugi2y/zjJEKApwAhVVovaNId4jDQTJGq/2RNnPFcihYuqAmvl7sfvoHQDFQCzbzC1y
         46KnZ+Hy+Wb/GUfrffeaX5vw0hDv5V3qzXTQggZi0xaOtsvXXjtULVlZVaf2/t820eoa
         0cRFmaRptl8ibzdxOcKXia/zprGZyB94N6RezUvzkVUr9gwen4Z2PkI98WbIyTzdQ0SH
         al3uhu8AH7DLJQKcdClXO0QfJzVO4B9eL0rzav1fs2rJUi2pL3qKOgbV41onUuKGCgZL
         nv+XAl01vwsZxn5jOMTZJUM1U6dbYUjrdRWT/mAV/7ZFHn0/y+DeQX2TjJKZc2M3cGpO
         3LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974017; x=1714578817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSE6Y9L7llOYPHAz3r3bPOJVA5fqH/Ut+JPxK7SpOhY=;
        b=lWv7kLJub2Dij92mmMv1buwVKF/puK2bB762jQjSZIyq3A9QGL0bRZSXu02sQj26Rl
         PX5JIACOCXDXayIPNTfV1aJK7itHhHGxLAhzYoUmhpGm9I2Ov7C3xpLpYyDrzJbJBe43
         z2IUDWcbP2Z9H+T3u5DENBggNTr86qoyRpado9dKaZlm3YROoEnvSqMQuCg1YysmV6TF
         vDKqItEQKzHZRXNSydiH7ifduK29pzGynZCAZ/mGI8D52FenlJbuf10EmPfqaeqCUdvZ
         I5sW/l1Ttypz52ojm1/xNMHkzzWdfYjabfyh8IIMcTrx+hd06lycgQI9BCXP/ghmpoy+
         EXfg==
X-Gm-Message-State: AOJu0Yydt8NEN525jBKPwGJbe+xaj5Rm2U+NyPc4crgq1O+aGT8lRA2c
	KosHd+hGcxfKmMW2R4TR/f7iS/bo7BAcyCI9ypo4fmxsN0WZ4L1fj6vk/Jc3iuTJvmnNNcDCLlG
	jHifrWdLlzIuTo3X3BX1dTwExOsVNBpXOVYK0lT3P6gEWBr3tswbqDE/XUeKf5uVOkZsiOt/boM
	bu+iPjf4wKMvxDOsHsAlPfAYeFjiMBNw==
X-Google-Smtp-Source: AGHT+IHdgZ/1scdNqsOsUGU/8rbl3y5ChDBjzKHAuJmkQp2vLW7lbyWqrKe1MbUP5BNj2PMZ2v+By58o
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6000:120a:b0:34a:6e5b:6c37 with SMTP id
 e10-20020a056000120a00b0034a6e5b6c37mr7967wrx.10.1713974017351; Wed, 24 Apr
 2024 08:53:37 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:12 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4653; i=ardb@kernel.org;
 h=from:subject; bh=UdYv+ny0ilnq/CzBfGtaYL0PFzYJ1VTxddLIDb1PfGU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T67nCweD+3Odn154LP+T386FQ3vcJEoLvuZ6H6ZVvW
 m2pqLmyo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExkNhvD/+izvZU7ZxwT13nN
 9Nqwxme2rWdAyA7PdYXVXxWbvmYHxTAytASGi8fes/QNXDApfaVBhs3J+IcOfA+rNh7kkZr5L1K eCwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-13-ardb+git@google.com>
Subject: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86 purgatory, which does little more than verify a SHA-256 hash of
the loaded segments, currently uses three different stacks:
- one in .bss that is used to call the purgatory C code
- one in .rodata that is only used to switch to an updated code segment
  descriptor in the GDT
- one in .data, which allows it to be prepopulated from the kexec loader
  in theory, but this is not actually being taken advantage of.

Simplify this, by dropping the latter two stacks, as well as the loader
logic that programs RSP.

Both the stacks in .bss and .data are 4k aligned, but 16 byte alignment
is more than sufficient.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/kexec.h      |  1 -
 arch/x86/kernel/kexec-bzimage64.c |  8 --------
 arch/x86/purgatory/entry64.S      |  8 --------
 arch/x86/purgatory/setup-x86_64.S |  2 +-
 arch/x86/purgatory/stack.S        | 18 ------------------
 5 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 91ca9a9ee3a2..ee7b32565e5f 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -163,7 +163,6 @@ struct kexec_entry64_regs {
 	uint64_t rcx;
 	uint64_t rdx;
 	uint64_t rbx;
-	uint64_t rsp;
 	uint64_t rbp;
 	uint64_t rsi;
 	uint64_t rdi;
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index cde167b0ea92..f5bf1b7d01a6 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -400,7 +400,6 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	unsigned long bootparam_load_addr, kernel_load_addr, initrd_load_addr;
 	struct bzimage64_data *ldata;
 	struct kexec_entry64_regs regs64;
-	void *stack;
 	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
 	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
 	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
@@ -550,14 +549,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	regs64.rbx = 0; /* Bootstrap Processor */
 	regs64.rsi = bootparam_load_addr;
 	regs64.rip = kernel_load_addr + 0x200;
-	stack = kexec_purgatory_get_symbol_addr(image, "stack_end");
-	if (IS_ERR(stack)) {
-		pr_err("Could not find address of symbol stack_end\n");
-		ret = -EINVAL;
-		goto out_free_params;
-	}
 
-	regs64.rsp = (unsigned long)stack;
 	ret = kexec_purgatory_get_set_symbol(image, "entry64_regs", &regs64,
 					     sizeof(regs64), 0);
 	if (ret)
diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 0b4390ce586b..9913877b0dbe 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -26,8 +26,6 @@ SYM_CODE_START(entry64)
 	movl    %eax, %fs
 	movl    %eax, %gs
 
-	/* Setup new stack */
-	leaq    stack_init(%rip), %rsp
 	pushq   $0x10 /* CS */
 	leaq    new_cs_exit(%rip), %rax
 	pushq   %rax
@@ -41,7 +39,6 @@ new_cs_exit:
 	movq	rdx(%rip), %rdx
 	movq	rsi(%rip), %rsi
 	movq	rdi(%rip), %rdi
-	movq    rsp(%rip), %rsp
 	movq	rbp(%rip), %rbp
 	movq	r8(%rip), %r8
 	movq	r9(%rip), %r9
@@ -63,7 +60,6 @@ rax:	.quad 0x0
 rcx:	.quad 0x0
 rdx:	.quad 0x0
 rbx:	.quad 0x0
-rsp:	.quad 0x0
 rbp:	.quad 0x0
 rsi:	.quad 0x0
 rdi:	.quad 0x0
@@ -97,7 +93,3 @@ SYM_DATA_START_LOCAL(gdt)
 	/* 0x18 4GB flat data segment */
 	.word 0xFFFF, 0x0000, 0x9200, 0x00CF
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
-
-SYM_DATA_START_LOCAL(stack)
-	.quad   0, 0
-SYM_DATA_END_LABEL(stack, SYM_L_LOCAL, stack_init)
diff --git a/arch/x86/purgatory/setup-x86_64.S b/arch/x86/purgatory/setup-x86_64.S
index 89d9e9e53fcd..2d10ff88851d 100644
--- a/arch/x86/purgatory/setup-x86_64.S
+++ b/arch/x86/purgatory/setup-x86_64.S
@@ -53,7 +53,7 @@ SYM_DATA_START_LOCAL(gdt)
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 	.bss
-	.balign 4096
+	.balign 16
 SYM_DATA_START_LOCAL(lstack)
 	.skip 4096
 SYM_DATA_END_LABEL(lstack, SYM_L_LOCAL, lstack_end)
diff --git a/arch/x86/purgatory/stack.S b/arch/x86/purgatory/stack.S
deleted file mode 100644
index 1ef507ca50a5..000000000000
--- a/arch/x86/purgatory/stack.S
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * purgatory:  stack
- *
- * Copyright (C) 2014 Red Hat Inc.
- */
-
-#include <linux/linkage.h>
-
-	/* A stack for the loaded kernel.
-	 * Separate and in the data section so it can be prepopulated.
-	 */
-	.data
-	.balign 4096
-
-SYM_DATA_START(stack)
-	.skip 4096
-SYM_DATA_END_LABEL(stack, SYM_L_GLOBAL, stack_end)
-- 
2.44.0.769.g3c40516874-goog


