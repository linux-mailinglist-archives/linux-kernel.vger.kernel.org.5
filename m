Return-Path: <linux-kernel+bounces-39093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE9E83CAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25199B21207
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B113313AA3B;
	Thu, 25 Jan 2024 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U1Hprlxq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mD+8b/O1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30827137C52;
	Thu, 25 Jan 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206894; cv=none; b=hqwouBE0jHYAXGK6MuXRNOzTYse0kT3QVnwZRTVHofuU+emFl75tpGVGxqDAAqgPrwkkYxfcTS38Bb/NAV9lXCJ7bD1zVUkZYV81PA9cLeA5JwUKG7uMHrvOvXRu6a4OXw4kmNhVWoYbTEMIbAB/iigm3ct23PuVeY5yd9cJQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206894; c=relaxed/simple;
	bh=U8wU0tpOdBA1ZprQ9hWgFxIOfVWfsMC8zjPRZXmshrw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lsCKNLdVbV3XV64FG4Q8PNchgxD6aRx/1NyAgNH/PfLCbmmLKkTnWzkpfDxCAV7jssEODEanw4ty2OXrcPmc7jceQCCRD3z5j5SXu8onEQaO8oQ/4+ELpglw3sUx/4TNCSFqEhcAlBDV1tWu9xwWV6Hz9B3lUINrB1UEsGxcI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U1Hprlxq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mD+8b/O1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQSFg9Dy8lzzF5h5RDkKNHeY9A3b6XpFG3jki0EYwrs=;
	b=U1HprlxqbAZzdPqLfbM1pCFE9pz+WvQsSu6btOCPZRSoO1T4ZzICAqSnJTnYB2iy8i/j/i
	cfmYsPehO/0BKoSMRY3ZYbVk1hAb6HfmEl2DojH/Fgd27IHbFx8dMWjjJG3ZFXkeD/UhJ3
	/vU5Zj6xF1waQpCr8M44BlXoIzB0c3TAwGeRuvVzvDnC4p88ImOtAoaCGwoJ2ppuxZ/vk+
	vKJ7VJ3N/XlzszR4cfS3M9lvHdrHaf+FTszx634uvmtnzKlGFXaFiL4w6BlfSRTNSNlEx4
	FSrUlPWfUSvoETu0/V83A0S28oerNjprejA3CAc1H3Sub1SJIQDEknAePsaLig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NQSFg9Dy8lzzF5h5RDkKNHeY9A3b6XpFG3jki0EYwrs=;
	b=mD+8b/O1E12wX/Tsv0T/mbBx0XY0k9aqrHQ27vPUrk+PqjgfJKcMy1WCSpd9rtWv7g2aLt
	DrY2G4pzNzGzfMAA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/fred: Allow single-step trap and NMI when
 starting a new task
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-21-xin3.li@intel.com>
References: <20231205105030.8698-21-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620688629.398.742717203781279189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     2ecb2c4fc69011364110a36cd9056adf3fefbc56
Gitweb:        https://git.kernel.org/tip/2ecb2c4fc69011364110a36cd9056adf3fefbc56
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:09 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:31 +01:00

x86/fred: Allow single-step trap and NMI when starting a new task

Entering a new task is logically speaking a return from a system call
(exec, fork, clone, etc.). As such, if ptrace enables single stepping
a single step exception should be allowed to trigger immediately upon
entering user space. This is not optional.

NMI should *never* be disabled in user space. As such, this is an
optional, opportunistic way to catch errors.

Allow single-step trap and NMI when starting a new task, thus once
the new task enters user space, single-step trap and NMI are both
enabled immediately.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-21-xin3.li@intel.com

---
 arch/x86/kernel/process_64.c | 38 +++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4f87f59..c075591 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -56,6 +56,7 @@
 #include <asm/resctrl.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
+#include <asm/fred.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
@@ -528,7 +529,7 @@ void x86_gsbase_write_task(struct task_struct *task, unsigned long gsbase)
 static void
 start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 		    unsigned long new_sp,
-		    unsigned int _cs, unsigned int _ss, unsigned int _ds)
+		    u16 _cs, u16 _ss, u16 _ds)
 {
 	WARN_ON_ONCE(regs != current_pt_regs());
 
@@ -545,11 +546,36 @@ start_thread_common(struct pt_regs *regs, unsigned long new_ip,
 	loadsegment(ds, _ds);
 	load_gs_index(0);
 
-	regs->ip		= new_ip;
-	regs->sp		= new_sp;
-	regs->cs		= _cs;
-	regs->ss		= _ss;
-	regs->flags		= X86_EFLAGS_IF;
+	regs->ip	= new_ip;
+	regs->sp	= new_sp;
+	regs->csx	= _cs;
+	regs->ssx	= _ss;
+	/*
+	 * Allow single-step trap and NMI when starting a new task, thus
+	 * once the new task enters user space, single-step trap and NMI
+	 * are both enabled immediately.
+	 *
+	 * Entering a new task is logically speaking a return from a
+	 * system call (exec, fork, clone, etc.). As such, if ptrace
+	 * enables single stepping a single step exception should be
+	 * allowed to trigger immediately upon entering user space.
+	 * This is not optional.
+	 *
+	 * NMI should *never* be disabled in user space. As such, this
+	 * is an optional, opportunistic way to catch errors.
+	 *
+	 * Paranoia: High-order 48 bits above the lowest 16 bit SS are
+	 * discarded by the legacy IRET instruction on all Intel, AMD,
+	 * and Cyrix/Centaur/VIA CPUs, thus can be set unconditionally,
+	 * even when FRED is not enabled. But we choose the safer side
+	 * to use these bits only when FRED is enabled.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		regs->fred_ss.swevent	= true;
+		regs->fred_ss.nmi	= true;
+	}
+
+	regs->flags	= X86_EFLAGS_IF | X86_EFLAGS_FIXED;
 }
 
 void

