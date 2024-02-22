Return-Path: <linux-kernel+bounces-76307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD5285F577
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2082B2257E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FF03BB5E;
	Thu, 22 Feb 2024 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z2RtHlwY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m3ekdkY6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C73B287;
	Thu, 22 Feb 2024 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597072; cv=none; b=DsgPz0mVH0hhRTrSQjCEgRDIY6PR5oYCvI/WfeILN8no8IAnV85DABnPY1JDOjWrRqpjC7pAnoKPwEmrtmZ6KcHFXjUtEh6zEecyTgUIVkFeHnjMkIDJONuK8ugp3H0hWAjFtcDX6HfNSHx4t8uIx2bLRCc1U9IvOFlHLCZwnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597072; c=relaxed/simple;
	bh=INKZZAiWKyWWDyhwSQ8Udsb25d4hdSF43VqefEYlMys=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kbb3oPMnJ12z28DFrh/IG2yvwp+T5Qokl0B/S/wufxxydY5RRkTaTzlOW4kEYXwQt/xkUa+x7JP/+tQZDHE+cHqW0WU9RsXa6srRTiKac0AIAi1A10oe3KutSqHT4+4+fcQfr1Quhzmk5CrCVHBwpDWawopD7ZR4h/Cpcuhecqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z2RtHlwY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m3ekdkY6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Feb 2024 10:17:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708597068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4gmjkB/7qKBdMbDFmelw8+dDKrdagBqXy0HOrnWyMNM=;
	b=Z2RtHlwYe1xMOj3IyzG31xqlKJjFfA9EvAHrDldyCLyElFU+3kEC1wlRFxjK6WZQmdKmbm
	9mL+7uUxUH4uHKvk3kqSLaZo+KkGBZlPXI9osxA+5C+t0yLRIxEUK8GvUTS2P4pkHBK5Dr
	5K8D5LtNIGplY2myBE4Ev10pNAEN+hROG4ASIh6ofbxljm/ygV0BvuOpiFftNQs03HrMIN
	mhYSE1VdzoBbL0ZdWrXJOgS67v2gWldqfNxchnMNLwWg8kkXorI84cQ7canwi4AQc70tCu
	ZWilCDuVCfRE98B5qOopJdE92O+kvAB2E2GoBKYZovHlIKRy5zEdKb56kMYUPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708597068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4gmjkB/7qKBdMbDFmelw8+dDKrdagBqXy0HOrnWyMNM=;
	b=m3ekdkY6ffpvDMIu7guq1/0hsIA8gXRO3Httdy4cVSrxTfIxxYW/Yj7RxiFNQDPQP6Dcmn
	e3zZWB97/y17eVAg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/vdso/kbuild: Group non-standard build attributes
 and primary object file rules together
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170859706751.398.5011256103186536643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     b7bcffe752957c6eac7c4cd77dd6f5d943478769
Gitweb:        https://git.kernel.org/tip/b7bcffe752957c6eac7c4cd77dd6f5d943478769
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 22 Feb 2024 10:20:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 22 Feb 2024 10:40:20 +01:00

x86/vdso/kbuild: Group non-standard build attributes and primary object file rules together

The fresh changes to the vDSO Makefile in:

  289d0a475c3e ("x86/vdso: Use CONFIG_COMPAT_32 to specify vdso32")
  329b77b59f83 ("x86/vdso: Simplify obj-y addition")

Conflicted with a pending change in:

  b388e57d4628e ("x86/vdso: Fix rethunk patching for vdso-image-{32,64}.o")

Which was resolved in a simple fasion in this merge commit:

  f14df823a61e ("Merge branch 'x86/vdso' into x86/core, to resolve conflict and to prepare for dependent changes")

.. but all these changes make me look and notice a bit of historic baggage
left in the Makefile:

  - Disordered build rules where non-standard build attributes relating to
    were placed sometimes several lines after - and sometimes *before*
    the .o build rules of the object files... Functional but inconsistent.

  - Inconsistent vertical spacing, stray whitespaces, inconsistent spelling
    of 'vDSO' over the years, a few spelling mistakes and inconsistent
    capitalization of comment blocks.

Tidy it all up. No functional changes intended.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 3ccab61..620f625 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -3,7 +3,7 @@
 # Building vDSO images for x86.
 #
 
-# Include the generic Makefile to check the built vdso.
+# Include the generic Makefile to check the built vDSO:
 include $(srctree)/lib/vdso/Makefile
 
 # Sanitizer runtimes are unavailable and cannot be linked here.
@@ -18,29 +18,29 @@ OBJECT_FILES_NON_STANDARD	:= y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT		:= n
 
-# files to link into the vdso
+# Files to link into the vDSO:
 vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o vdso32/vgetcpu.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
 
-# files to link into kernel
-obj-y					+= vma.o extable.o
-KASAN_SANITIZE_vma.o			:= y
-UBSAN_SANITIZE_vma.o			:= y
-KCSAN_SANITIZE_vma.o			:= y
+# Files to link into the kernel:
+obj-y						+= vma.o extable.o
+KASAN_SANITIZE_vma.o				:= y
+UBSAN_SANITIZE_vma.o				:= y
+KCSAN_SANITIZE_vma.o				:= y
 
-OBJECT_FILES_NON_STANDARD_extable.o		:= n
-OBJECT_FILES_NON_STANDARD_vdso-image-32.o 	:= n
-OBJECT_FILES_NON_STANDARD_vdso-image-64.o 	:= n
 OBJECT_FILES_NON_STANDARD_vma.o			:= n
+OBJECT_FILES_NON_STANDARD_extable.o		:= n
 
-# vDSO images to build
-obj-$(CONFIG_X86_64)		+= vdso-image-64.o
-obj-$(CONFIG_X86_X32_ABI)	+= vdso-image-x32.o
-obj-$(CONFIG_COMPAT_32)		+= vdso-image-32.o vdso32-setup.o
+# vDSO images to build:
+obj-$(CONFIG_X86_64)				+= vdso-image-64.o
+obj-$(CONFIG_X86_X32_ABI)			+= vdso-image-x32.o
+obj-$(CONFIG_COMPAT_32)				+= vdso-image-32.o vdso32-setup.o
 
-OBJECT_FILES_NON_STANDARD_vdso32-setup.o := n
+OBJECT_FILES_NON_STANDARD_vdso-image-32.o	:= n
+OBJECT_FILES_NON_STANDARD_vdso-image-64.o	:= n
+OBJECT_FILES_NON_STANDARD_vdso32-setup.o	:= n
 
 vobjs := $(addprefix $(obj)/, $(vobjs-y))
 vobjs32 := $(addprefix $(obj)/, $(vobjs32-y))

