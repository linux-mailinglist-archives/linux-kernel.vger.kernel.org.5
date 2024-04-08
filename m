Return-Path: <linux-kernel+bounces-135495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7309589C6B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320C1281242
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045F86242;
	Mon,  8 Apr 2024 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3QDJlZ/n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="enPTaBQf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C951D85C6F;
	Mon,  8 Apr 2024 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585806; cv=none; b=AyZBBH3mk5XqD6hxJ/4jWUV+WpBueRoJ+xR2fI/Y9jseMTmTQmoQy50V5ekgBqgfsSiiXLJwem229sBNXvTooYFAQCzhx8vi7YB/GWjvIXpEGTHnbxbO825CWtAMhMLBfpKZ2SWKmkdx/9y/TRYpd5eeq3sbSv8ZFgmAzWCTHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585806; c=relaxed/simple;
	bh=bh8nWSuXPbDtnBugyVIiuU1sUkbw3RyB5fyuPJeGgvA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PslPokGPHqY2XGPhw3ktAHRQRiY2mgPEzFPLr56h7ZvfqfBWMlhef3556smDuS53O79dPdanmDJuzT8TM3t8BlcIuYOCcgSTgiJG+PTvmYrdoVADN+gx2SAFvQNjZAXc2qnZcGaIxVVb/16r8GNHkXXQxY24TlFji+N7BP0SvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3QDJlZ/n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=enPTaBQf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 08 Apr 2024 14:16:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712585802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MlJ5XHbN1NPPl7eX/WyHg2J+EFd1iqsdaFiPEliwt8=;
	b=3QDJlZ/nu3I3QxaFTacN+LZXoUyV7TUDMa4E7DEKxKCc2oBxrfmpoG51Vvt31wHQ7dsZw6
	neGdlzsxSEfdJDIEFdECvfYrcybpMSq5i9UWQH82Bfu6iLr6faYRtsarl94LMZTJBOVgYv
	6LoXtaZ1eNf6sIylkog/BzYj5lrerVeScSrKC8U+BhVh4acASTK95SgK0u799e4HQIvja5
	zN/byFh9RuwaHe4ujTWBl+B8xwPcw3YapwOQzvny9Z9AgtLFYKzta15XLcWEVBcBMX2tRT
	ooHsMhlOJwUzFlyfx3dhrDAm7fwTp3ivNCCLT933GtPWPB40taGsxBZ1nVGw+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712585802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MlJ5XHbN1NPPl7eX/WyHg2J+EFd1iqsdaFiPEliwt8=;
	b=enPTaBQf12ezEGVDgbh18i7JayXf6RHCU8JxnLcYSfJ099dAciZVc2iNyC2NCavwI1EQEy
	rIqOBM3b0zggu6BA==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/math-emu: Fix function cast warnings
Cc: Arnd Bergmann <arnd@arndb.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213095631.454543-1-arnd@kernel.org>
References: <20240213095631.454543-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171258580133.10875.15729476936056309317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     e0ca9353a86c0459a9c3fc8d65f7c88e96217cea
Gitweb:        https://git.kernel.org/tip/e0ca9353a86c0459a9c3fc8d65f7c88e96217cea
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Thu, 04 Apr 2024 18:17:24 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 Apr 2024 16:06:22 +02:00

x86/math-emu: Fix function cast warnings

clang-16 warns about casting function pointers with incompatible
prototypes. The x86 math-emu code does this in a number of places
to call some trivial functions that need no arguments:

  arch/x86/math-emu/fpu_etc.c:124:14: error: cast from 'void (*)(void)' to 'FUNC_ST0' \
    (aka 'void (*)(struct fpu__reg *, unsigned char)') converts to incompatible function \
    type [-Werror,-Wcast-function-type-strict]
    124 |         fchs, fabs, (FUNC_ST0) FPU_illegal, (FUNC_ST0) FPU_illegal,
        |                     ^~~~~~~~~~~~~~~~~~~~~~

  arch/x86/math-emu/fpu_trig.c:1634:19: error: cast from 'void (*)(void)' to 'FUNC_ST0' \
    (aka 'void (*)(struct fpu__reg *, unsigned char)') converts to incompatible function \
    type [-Werror,-Wcast-function-type-strict]
   1634 |         fxtract, fprem1, (FUNC_ST0) fdecstp, (FUNC_ST0) fincstp
        |                          ^~~~~~~~~~~~~~~~~~

  arch/x86/math-emu/reg_constant.c:112:53: error: cast from 'void (*)(void)' to 'FUNC_RC' \
  (aka 'void (*)(int)') converts to incompatible function \
  type [-Werror,-Wcast-function-type-strict]
    112 |         fld1, fldl2t, fldl2e, fldpi, fldlg2, fldln2, fldz, (FUNC_RC) FPU_illegal

Change the fdecstp() and fincstp() functions to actually have the correct
prototypes based on the caller, and add wrappers around FPU_illegal() for
adapting those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/lkml/20240213095631.454543-1-arnd@kernel.org
---
 arch/x86/math-emu/fpu_etc.c      |  9 +++++++--
 arch/x86/math-emu/fpu_trig.c     |  6 +++---
 arch/x86/math-emu/reg_constant.c |  7 ++++++-
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/math-emu/fpu_etc.c b/arch/x86/math-emu/fpu_etc.c
index 1b118fd..39423ec 100644
--- a/arch/x86/math-emu/fpu_etc.c
+++ b/arch/x86/math-emu/fpu_etc.c
@@ -120,9 +120,14 @@ static void fxam(FPU_REG *st0_ptr, u_char st0tag)
 	setcc(c);
 }
 
+static void FPU_ST0_illegal(FPU_REG *st0_ptr, u_char st0_tag)
+{
+	FPU_illegal();
+}
+
 static FUNC_ST0 const fp_etc_table[] = {
-	fchs, fabs, (FUNC_ST0) FPU_illegal, (FUNC_ST0) FPU_illegal,
-	ftst_, fxam, (FUNC_ST0) FPU_illegal, (FUNC_ST0) FPU_illegal
+	fchs, fabs, FPU_ST0_illegal, FPU_ST0_illegal,
+	ftst_, fxam, FPU_ST0_illegal, FPU_ST0_illegal,
 };
 
 void FPU_etc(void)
diff --git a/arch/x86/math-emu/fpu_trig.c b/arch/x86/math-emu/fpu_trig.c
index 990d847..85daf98 100644
--- a/arch/x86/math-emu/fpu_trig.c
+++ b/arch/x86/math-emu/fpu_trig.c
@@ -433,13 +433,13 @@ static void fxtract(FPU_REG *st0_ptr, u_char st0_tag)
 #endif /* PARANOID */
 }
 
-static void fdecstp(void)
+static void fdecstp(FPU_REG *st0_ptr, u_char st0_tag)
 {
 	clear_C1();
 	top--;
 }
 
-static void fincstp(void)
+static void fincstp(FPU_REG *st0_ptr, u_char st0_tag)
 {
 	clear_C1();
 	top++;
@@ -1631,7 +1631,7 @@ static void fscale(FPU_REG *st0_ptr, u_char st0_tag)
 
 static FUNC_ST0 const trig_table_a[] = {
 	f2xm1, fyl2x, fptan, fpatan,
-	fxtract, fprem1, (FUNC_ST0) fdecstp, (FUNC_ST0) fincstp
+	fxtract, fprem1, fdecstp, fincstp,
 };
 
 void FPU_triga(void)
diff --git a/arch/x86/math-emu/reg_constant.c b/arch/x86/math-emu/reg_constant.c
index 742619e..003a0b2 100644
--- a/arch/x86/math-emu/reg_constant.c
+++ b/arch/x86/math-emu/reg_constant.c
@@ -108,8 +108,13 @@ static void fldz(int rc)
 
 typedef void (*FUNC_RC) (int);
 
+static void FPU_RC_illegal(int unused)
+{
+	FPU_illegal();
+}
+
 static FUNC_RC constants_table[] = {
-	fld1, fldl2t, fldl2e, fldpi, fldlg2, fldln2, fldz, (FUNC_RC) FPU_illegal
+	fld1, fldl2t, fldl2e, fldpi, fldlg2, fldln2, fldz, FPU_RC_illegal
 };
 
 void fconst(void)

