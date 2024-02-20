Return-Path: <linux-kernel+bounces-73022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0D785BC39
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9022823D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA57A69302;
	Tue, 20 Feb 2024 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T0ml1uRi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VaxFvJMH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5BF5A7A0;
	Tue, 20 Feb 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432314; cv=none; b=FW5EgRd9fnVsegjBMfawRNg5fpr6iS8Y6FHMAiFachGBtXpG6sLelf1dy9swUOin4tuhE9ja86ZZfSKB8fvuqVuwKxHUUqnC5Qpv+h2GVnqmyVDX1vSQfrUne0Wf9wnv5AsPxYaGg5pWrjJRhTS/N0iNAyWcD+y8RnoEQwoaD7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432314; c=relaxed/simple;
	bh=BqN8PgniJ71+Vcwo7x0QfMXaIGIehoo59YjYvGKY3jc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z5JKPwKJ5Ijxz0uUpnuj4gBm1HlicdcsXXEHHoNFs3PjuWUGstlcJ0rAlusKdIRJCcMZG9YL1DD8s2dAmLAZ27JEEETHovME1SFpS9YooHBqcaOJz0J2oaVzY2b7R1M6Rn8dARggcWngwGmzfBcwqubfeiKYLpcNwAKG8Az028w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T0ml1uRi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VaxFvJMH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Feb 2024 12:31:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708432309;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObXswrodBxrGU5oQHeC85uf/NVy2j94FFoEd8MVsz0I=;
	b=T0ml1uRiNfh+jWuPm/p/dDl+wTmqYCfjsH6Vf+9vZYsMFkzpCYRUaueW8jrXFHKWk6B4kz
	N6X8O8z2dFErYvtQcWDQ18Gt32tMxce4ZJ1jEQU7xawvX2YG61Npn3GLSGyUlnUsgTxQ8R
	zuuASYLHKbrhMlkgUStLEbx3hZy+0dzWq3r7VM3EAQj2KhN4DPvjnoKF2ixhrbdLLpgM1M
	hjYudVq5DIdFTJlAUHUmOTp4q+0Zxcvzhg5HERPHvAJQLlYVmj+VlGIwcdttFTyuSIdmSp
	hRK4JX0l+z7qCt/qPxTK+cy/WRoAPefSa4Rtj5ydWHLc+/rnw5s+rZSY4l4nsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708432309;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ObXswrodBxrGU5oQHeC85uf/NVy2j94FFoEd8MVsz0I=;
	b=VaxFvJMHPY7KaMVFZH7MUAkx5jkkHTYrT5kLDVAY9YiTWRcFVvqWQuun+kIN1kHoOUA+w0
	tiwTSjB8M33o7OCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/vdso: Fix rethunk patching for vdso-image-{32,64}.o
Cc: Nathan Chancellor <nathan@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240215032049.GA3944823@dev-arch.thelio-3990X>
References: <20240215032049.GA3944823@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170843230884.398.17338035419021257054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b388e57d4628eb22782bdad4cd5b83ca87a1b7c9
Gitweb:        https://git.kernel.org/tip/b388e57d4628eb22782bdad4cd5b83ca87a1b7c9
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 19 Feb 2024 21:57:18 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 20 Feb 2024 13:26:10 +01:00

x86/vdso: Fix rethunk patching for vdso-image-{32,64}.o

For CONFIG_RETHUNK kernels, objtool annotates all the function return
sites so they can be patched during boot.  By design, after
apply_returns() is called, all tail-calls to the compiler-generated
default return thunk (__x86_return_thunk) should be patched out and
replaced with whatever's needed for any mitigations (or lack thereof).

The commit

  4461438a8405 ("x86/retpoline: Ensure default return thunk isn't used at runtime")

adds a runtime check and a WARN_ONCE() if the default return thunk ever
gets executed after alternatives have been applied.  This warning is
a sanity check to make sure objtool and apply_returns() are doing their
job.

As Nathan reported, that check found something:

  Unpatched return thunk in use. This should not happen!
  WARNING: CPU: 0 PID: 1 at arch/x86/kernel/cpu/bugs.c:2856 __warn_thunk+0x27/0x40
  RIP: 0010:__warn_thunk+0x27/0x40
  Call Trace:
   <TASK>
   ? show_regs
   ? __warn
   ? __warn_thunk
   ? report_bug
   ? console_unlock
   ? handle_bug
   ? exc_invalid_op
   ? asm_exc_invalid_op
   ? ia32_binfmt_init
   ? __warn_thunk
   warn_thunk_thunk
   do_one_initcall
   kernel_init_freeable
   ? __pfx_kernel_init
   kernel_init
   ret_from_fork
   ? __pfx_kernel_init
   ret_from_fork_asm
   </TASK>

Boris debugged to find that the unpatched return site was in
init_vdso_image_64(), and its translation unit wasn't being analyzed by
objtool, so it never got annotated.  So it got ignored by
apply_returns().

This is only a minor issue, as this function is only called during boot.
Still, objtool needs full visibility to the kernel.  Fix it by enabling
objtool on vdso-image-{32,64}.o.

Note this problem can only be seen with !CONFIG_X86_KERNEL_IBT, as that
requires objtool to run individually on all translation units rather on
vmlinux.o.

  [ bp: Massage commit message. ]

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240215032049.GA3944823@dev-arch.thelio-3990X
---
 arch/x86/entry/vdso/Makefile |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c4df99a..b80f4bb 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -34,8 +34,12 @@ obj-y					+= vma.o extable.o
 KASAN_SANITIZE_vma.o			:= y
 UBSAN_SANITIZE_vma.o			:= y
 KCSAN_SANITIZE_vma.o			:= y
-OBJECT_FILES_NON_STANDARD_vma.o		:= n
-OBJECT_FILES_NON_STANDARD_extable.o	:= n
+
+OBJECT_FILES_NON_STANDARD_extable.o		:= n
+OBJECT_FILES_NON_STANDARD_vdso-image-32.o 	:= n
+OBJECT_FILES_NON_STANDARD_vdso-image-64.o 	:= n
+OBJECT_FILES_NON_STANDARD_vdso32-setup.o	:= n
+OBJECT_FILES_NON_STANDARD_vma.o			:= n
 
 # vDSO images to build
 vdso_img-$(VDSO64-y)		+= 64
@@ -43,7 +47,6 @@ vdso_img-$(VDSOX32-y)		+= x32
 vdso_img-$(VDSO32-y)		+= 32
 
 obj-$(VDSO32-y)				 += vdso32-setup.o
-OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
 
 vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
 vobjs32 := $(foreach F,$(vobjs32-y),$(obj)/$F)

