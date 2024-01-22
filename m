Return-Path: <linux-kernel+bounces-33113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDFD8364C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF3E288719
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A918A3D0BF;
	Mon, 22 Jan 2024 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W4zoo/o9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nQuzdFPC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22860DF6E;
	Mon, 22 Jan 2024 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705931535; cv=none; b=odzDaG/2cPTfV7X6olp4tvUlIPX//mbY42dOGfqLQbrFPeJT1Qd8rZUIT72RTqA/gGCA0eGNBe5vcMRrCskVa7HwQyyXNICN9yvs59+l9Z0Owk6vWaUohvGf2UDgQCVDw2cZEmEYku/UYD73T29CuXmCiS8yCkUoVuhtnKd5tF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705931535; c=relaxed/simple;
	bh=lyYjyW0PG3GmvvfnJJ7aIuOt9frvldH3vJ4YoyfkjHE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VArAcM4vKNqSiCOeoUY5naADWAkG6bl2+s4+IGevjzs5yc9OrKPi97lVuiJpthFvTVzkS0apv/TGZypRgE5D0fb9zS3SZfbWhPW1V08Nokkmq/VUmXqmS49mAOAgSilF7nMVuvwLWkJJa64NdRZC581RdKfOJlsr+pefWQGAOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W4zoo/o9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nQuzdFPC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 22 Jan 2024 13:52:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705931532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkICZpLK8fX7JPvw7cdwjuDNI2tT7NrN7jBRSSl3G+0=;
	b=W4zoo/o95cZ/e8CUSPgHI1Mn5YO7jdANLUvCx6A6A1rAJXSZ/Y7TeIALLd/yMs+F9aiUTJ
	6puMbS3+f3qo7fRyVW0IsxFNbRL8aGXTC4re7j19H31n3SfEEM2Z5bt3Yk0umXCJX3fo/k
	Z47+dVxfd9GFPN9D9kk3MIkMW2sjTGxAYV/V0i16Cjp52CrQAvgNlBF/y40TvvyeeJOjBp
	yl+HxJLqpHROafaHsJYDlaPxeALG3yeSeMoaBWYFnooqqp0Jc6JCxblDM3TQr1hmMWRyx7
	ZONmfRI/gx4YGtN4nBukk8PFY0/lRUJe//HT7Y/aEZel1KAKMstql77Y0dPn1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705931532;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkICZpLK8fX7JPvw7cdwjuDNI2tT7NrN7jBRSSl3G+0=;
	b=nQuzdFPChKVrvrU72W8r+r6k+ydwOk73DojdQ+F4Xc2UhiBscG6aK4ecMxsQ/M6lTafeY6
	wPLl4GQz7obFiWDw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Harden #VC instruction emulation somewhat
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240105101407.11694-1-bp@alien8.de>
References: <20240105101407.11694-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170593153094.398.7791095482489457964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     df38347f1934b29d4b3075a53a6404b0d58dcb2f
Gitweb:        https://git.kernel.org/tip/df38347f1934b29d4b3075a53a6404b0d58dcb2f
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 05 Jan 2024 11:14:07 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 22 Jan 2024 14:46:36 +01:00

x86/sev: Harden #VC instruction emulation somewhat

Compare the opcode bytes at rIP for each #VC exit reason to verify the
instruction which raised the #VC exception is actually the right one.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20240105101407.11694-1-bp@alien8.de
---
 arch/x86/boot/compressed/sev.c |   4 +-
 arch/x86/kernel/sev-shared.c   | 102 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/sev.c          |   5 +-
 3 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 454acd7..0732918 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -304,6 +304,10 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	if (result != ES_OK)
 		goto finish;
 
+	result = vc_check_opcode_bytes(&ctxt, exit_code);
+	if (result != ES_OK)
+		goto finish;
+
 	switch (exit_code) {
 	case SVM_EXIT_RDTSC:
 	case SVM_EXIT_RDTSCP:
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 1d24ec6..5db24d0 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -10,11 +10,15 @@
  */
 
 #ifndef __BOOT_COMPRESSED
-#define error(v)	pr_err(v)
-#define has_cpuflag(f)	boot_cpu_has(f)
+#define error(v)			pr_err(v)
+#define has_cpuflag(f)			boot_cpu_has(f)
+#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
+#define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
 #else
 #undef WARN
 #define WARN(condition, format...) (!!(condition))
+#define sev_printk(fmt, ...)
+#define sev_printk_rtl(fmt, ...)
 #endif
 
 /* I/O parameters for CPUID-related helpers */
@@ -574,6 +578,7 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 {
 	unsigned int subfn = lower_bits(regs->cx, 32);
 	unsigned int fn = lower_bits(regs->ax, 32);
+	u16 opcode = *(unsigned short *)regs->ip;
 	struct cpuid_leaf leaf;
 	int ret;
 
@@ -581,6 +586,10 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	if (exit_code != SVM_EXIT_CPUID)
 		goto fail;
 
+	/* Is it really a CPUID insn? */
+	if (opcode != 0xa20f)
+		goto fail;
+
 	leaf.fn = fn;
 	leaf.subfn = subfn;
 
@@ -1170,3 +1179,92 @@ static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
 out:
 	return ret;
 }
+
+static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
+					    unsigned long exit_code)
+{
+	unsigned int opcode = (unsigned int)ctxt->insn.opcode.value;
+	u8 modrm = ctxt->insn.modrm.value;
+
+	switch (exit_code) {
+
+	case SVM_EXIT_IOIO:
+	case SVM_EXIT_NPF:
+		/* handled separately */
+		return ES_OK;
+
+	case SVM_EXIT_CPUID:
+		if (opcode == 0xa20f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_INVD:
+		if (opcode == 0x080f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MONITOR:
+		if (opcode == 0x010f && modrm == 0xc8)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MWAIT:
+		if (opcode == 0x010f && modrm == 0xc9)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MSR:
+		/* RDMSR */
+		if (opcode == 0x320f ||
+		/* WRMSR */
+		    opcode == 0x300f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDPMC:
+		if (opcode == 0x330f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSC:
+		if (opcode == 0x310f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSCP:
+		if (opcode == 0x010f && modrm == 0xf9)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_READ_DR7:
+		if (opcode == 0x210f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_VMMCALL:
+		if (opcode == 0x010f && modrm == 0xd9)
+			return ES_OK;
+
+		break;
+
+	case SVM_EXIT_WRITE_DR7:
+		if (opcode == 0x230f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_WBINVD:
+		if (opcode == 0x90f)
+			return ES_OK;
+		break;
+
+	default:
+		break;
+	}
+
+	sev_printk(KERN_ERR "Wrong/unhandled opcode bytes: 0x%x, exit_code: 0x%lx, rIP: 0x%lx\n",
+		   opcode, exit_code, ctxt->regs->ip);
+
+	return ES_UNSUPPORTED;
+}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c672858..1ec7533 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -1752,7 +1752,10 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 					 struct ghcb *ghcb,
 					 unsigned long exit_code)
 {
-	enum es_result result;
+	enum es_result result = vc_check_opcode_bytes(ctxt, exit_code);
+
+	if (result != ES_OK)
+		return result;
 
 	switch (exit_code) {
 	case SVM_EXIT_READ_DR7:

