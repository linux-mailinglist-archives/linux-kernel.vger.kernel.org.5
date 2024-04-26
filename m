Return-Path: <linux-kernel+bounces-160546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B48B3EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811EDB243DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4E17166E;
	Fri, 26 Apr 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E5caP7nm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vd+HeKZJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425916F82B;
	Fri, 26 Apr 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155137; cv=none; b=BgZDQ0GF/upCV2cRVs9c5G2QbNLrc/D2DQtlGlfrdPWX9AV5r6HuuyPuApvdkERttMmFoBiSO4RhvobVffqV3pbHyRyZy7utleUso3ZWo7GqXk3aAa3N60LaPLQwHk0ICKckMBsgNr8+zTXFxnekqPvYtus6BFRL5Xh2DWR6wk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155137; c=relaxed/simple;
	bh=j1s8BytxteU6L31qJDKVHbfwR/gpeZVZyn+fN5dYims=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Cpkum0MXC6iyubPZD0y8ajvQ3sAbMquUsnP6ltJ0Cz7zKPHvUvFpYPQsGO/MnKdtq+xv8ER/eo8jFXb7jgZZpjqxgQEVfTBrQCKE0DklsDSfLSf4yb93bMFxEDnBGAfepBHE9yYgb3qvd/9WgiVpOmI2GpBBqx4a9s+j+edXmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E5caP7nm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vd+HeKZJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Apr 2024 18:12:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kEk+Ni7dBssUWov1yoq7v0tuj0EPxCUFL8UOqBjBWro=;
	b=E5caP7nm6cxnA/F6hiI04llJoU6QdlSKSFrkyxnJkx2lZacn1LcnCz0g8IWTH4YzBhRSjv
	qJ7RUCRH7DUVMFGfRs9woh3UTrq/IcrghxDNy0tgJ/IQp0nlE/lvw+O4klzvtf1CY4hJ9U
	qkw1U+fqw8vWho2baPLJYLrW+1wA0Or5/Cv8ZxT89hX46VlNDA4KUXvnMeFJiMHefMP5Dj
	AowNuOd6Y+OwVjMpmjlOVte/r9yItStaRae+WNEYPXpr5sr3P5XLdJWgx1geAjSEqZc/O7
	NL3Siiq/yfdCk5HYPB4AuE4X7EfG0nPhfjFtNJQPM/8Sux1gRTcSytV2u+arRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714155131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kEk+Ni7dBssUWov1yoq7v0tuj0EPxCUFL8UOqBjBWro=;
	b=vd+HeKZJS+yV7GkOYru7Ut3JJZJ2Rb43EXTWGWitO8Hi9orOSTdUqCY/l1IJjb00p2WAdm
	PSUAYGYyQMpOLkCg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mce: Switch to new Intel CPU model defines
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171415513118.10875.11391783217612357854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     68b4c6d168c547b19ba5697f9398c3f4aa8b4276
Gitweb:        https://git.kernel.org/tip/68b4c6d168c547b19ba5697f9398c3f4aa8b4276
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Apr 2024 11:15:13 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 26 Apr 2024 08:49:24 -07:00

x86/mce: Switch to new Intel CPU model defines

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240424181513.41810-1-tony.luck%40intel.com
---
 arch/x86/kernel/cpu/mce/severity.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index fc8988c..7293a1c 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -12,7 +12,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/mce.h>
-#include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #include <asm/traps.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
@@ -45,14 +45,14 @@ static struct severity {
 	unsigned char context;
 	unsigned char excp;
 	unsigned char covered;
-	unsigned char cpu_model;
+	unsigned int cpu_vfm;
 	unsigned char cpu_minstepping;
 	unsigned char bank_lo, bank_hi;
 	char *msg;
 } severities[] = {
 #define MCESEV(s, m, c...) { .sev = MCE_ ## s ## _SEVERITY, .msg = m, ## c }
 #define BANK_RANGE(l, h) .bank_lo = l, .bank_hi = h
-#define MODEL_STEPPING(m, s) .cpu_model = m, .cpu_minstepping = s
+#define VFM_STEPPING(m, s) .cpu_vfm = m, .cpu_minstepping = s
 #define  KERNEL		.context = IN_KERNEL
 #define  USER		.context = IN_USER
 #define  KERNEL_RECOV	.context = IN_KERNEL_RECOV
@@ -128,7 +128,7 @@ static struct severity {
 	MCESEV(
 		AO, "Uncorrected Patrol Scrub Error",
 		SER, MASK(MCI_STATUS_UC|MCI_ADDR|0xffffeff0, MCI_ADDR|0x001000c0),
-		MODEL_STEPPING(INTEL_FAM6_SKYLAKE_X, 4), BANK_RANGE(13, 18)
+		VFM_STEPPING(INTEL_SKYLAKE_X, 4), BANK_RANGE(13, 18)
 	),
 
 	/* ignore OVER for UCNA */
@@ -398,7 +398,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char 
 			continue;
 		if (s->excp && excp != s->excp)
 			continue;
-		if (s->cpu_model && boot_cpu_data.x86_model != s->cpu_model)
+		if (s->cpu_vfm && boot_cpu_data.x86_model != s->cpu_vfm)
 			continue;
 		if (s->cpu_minstepping && boot_cpu_data.x86_stepping < s->cpu_minstepping)
 			continue;

