Return-Path: <linux-kernel+bounces-47126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC908449A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1D11F287B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4928E3A8F6;
	Wed, 31 Jan 2024 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wEGEXbMQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/XYa1Cmz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A13A1AF;
	Wed, 31 Jan 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735689; cv=none; b=D6VZwhCjbcWx3+b09QBjEYwhR/NaG9fODaXj9dDS1S+io8csYL7mQIg4xKM3jVZmzwmeCalnLcjxKKinrnYgl71kkfC4nOdGOCGUVSmCKR5DDlZKOSpe+azvV+v64/ykmm9VZF3Fm3ZfzZVdCm09l8B0vF2nV2n9T7TW+k74OP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735689; c=relaxed/simple;
	bh=Ypu/2eUmvIVBmgoTBS3XLAy0cqa61KOQCiNVBJZFIxs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UlQeoxoNVQwWYWYp+X9gP5gk+km6mNsOyaIoX0ncP+UQSoz2eJQJJuYtDdvVtx8QAvLEstN3iPeUJHnEaV0Eq6D6WBYUWbczL0bPxU9rncf2CZIMVGUT35Vr0cGr3ne7Hoz2EOLVAWpYS7QTsT/m91bd6dNaVZHxJRSf9fa00ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wEGEXbMQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/XYa1Cmz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAsKqSZQiMmyEBIxsOBVerb+//M+p5CBe7734Eoe210=;
	b=wEGEXbMQYDxbekMpNs6dTsmUjvG1TqZau2jrNx1UqK6N34Cl7bVaJCCl3V2QutKw7KZ1Xb
	WuV0/KwpAiRnmwWUFu0++rRy10SG6XwkEAPA9JtakpxshNPuqbVD8ju4IBAZSpr1+EyYkP
	FzqUcsyWeyZbeu8fdoQuaRU9tjKjVzX2LJxFC45B2BjRdz6yTWKY/oLF+8D2SQEDQ5YGZX
	TWokSZGHf1IFPoYiDBAZEPFS7unPeoHOUVXZNMuFnP2zqsKXpGpR9ywEir2z/TDSixHZFw
	L3goHyfKxHa8JIHGSrQwov5wUtq4cj8nDlELK4qZK642qcqJXdTFfoqaNGnmDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735685;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAsKqSZQiMmyEBIxsOBVerb+//M+p5CBe7734Eoe210=;
	b=/XYa1CmzO1/5C3NmtPPb48AUIct7ap6vGEFSKKQYdNtYerKlMvwld84BBcqLzkrxQHmeLk
	z2nFSyK5GQ7JJJAA==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Add a machine check entry stub for FRED
Cc: Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-26-xin3.li@intel.com>
References: <20231205105030.8698-26-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568505.398.17054166707598114339.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     ffa4901f0e004e1a0a4e18a2452a1fcc27277cc0
Gitweb:        https://git.kernel.org/tip/ffa4901f0e004e1a0a4e18a2452a1fcc27277cc0
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:14 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:02:25 +01:00

x86/fred: Add a machine check entry stub for FRED

Like #DB, when occurred on different ring level, i.e., from user or kernel
context, #MCE needs to be handled on different stack: User #MCE on current
task stack, while kernel #MCE on a dedicated stack.

This is exactly how FRED event delivery invokes an exception handler: ring
3 event on level 0 stack, i.e., current task stack; ring 0 event on the
the FRED machine check entry stub doesn't do stack switch.

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-26-xin3.li@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index bc39252..04acdc3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -46,6 +46,7 @@
 #include <linux/hardirq.h>
 #include <linux/kexec.h>
 
+#include <asm/fred.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
@@ -2166,6 +2167,31 @@ DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
 	exc_machine_check_user(regs);
 	local_db_restore(dr7);
 }
+
+#ifdef CONFIG_X86_FRED
+/*
+ * When occurred on different ring level, i.e., from user or kernel
+ * context, #MCE needs to be handled on different stack: User #MCE
+ * on current task stack, while kernel #MCE on a dedicated stack.
+ *
+ * This is exactly how FRED event delivery invokes an exception
+ * handler: ring 3 event on level 0 stack, i.e., current task stack;
+ * ring 0 event on the #MCE dedicated stack specified in the
+ * IA32_FRED_STKLVLS MSR. So unlike IDT, the FRED machine check entry
+ * stub doesn't do stack switch.
+ */
+DEFINE_FREDENTRY_MCE(exc_machine_check)
+{
+	unsigned long dr7;
+
+	dr7 = local_db_save();
+	if (user_mode(regs))
+		exc_machine_check_user(regs);
+	else
+		exc_machine_check_kernel(regs);
+	local_db_restore(dr7);
+}
+#endif
 #else
 /* 32bit unified entry point */
 DEFINE_IDTENTRY_RAW(exc_machine_check)

