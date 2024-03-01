Return-Path: <linux-kernel+bounces-89118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2B86EAAC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BFAA1F26162
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872B756B6E;
	Fri,  1 Mar 2024 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QTN+HlnB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3z3WOrnR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62E535DF;
	Fri,  1 Mar 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326129; cv=none; b=dg6vdc2ntbaBV1jN39J2dhf0/RsNWk1GRch88nhuM9eA3EMt7vSuD/nq1QBZPd8wDs2AmlqD7WKnBagHgxOiF/AFtHqAw08lNDnM5y46CExZu7aNBbjyxGSGXa+QRwIH55e0Tl/v20mCPjrY1RKFJcNnA6x2cV5Ycu6vqWo5SCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326129; c=relaxed/simple;
	bh=cRvXMa+HiUdQCI7oCuhee7TQ71oyfaiMhTtdJ1DwZ7k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qRnhMRMTJ8AiTgYWkXXY7LwE7QXuuZZLGHBtwHGygzrKNbn2ClNDMskOb/1XXO45koDeakWsqrbGDfGiaq5zQ6OeTOitatQ0YpZLEMx9PIMNsQ6b9SrDYZH70IyDdmDphHAD1hEnTH3AqlO2b/hr7cqat9Dy33Xw+ivPJo8OPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QTN+HlnB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3z3WOrnR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Mar 2024 20:48:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709326121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9H3lpdsOdOgobAjbpYohIUvcrULTxKy8/5jJJrx0Ts=;
	b=QTN+HlnBx1WgRtGwYF1kULQMOwzw0hyIbdtcAfFwi4MqNx8aM5Ebwn/KutBuGvovV9gcoC
	Lw/ZZKmvd/q5peol6/rd9gbYZM7aOQdLG/psHMp9i1Zfym64tqVhouE/2BPa7QjKTx+PN6
	bX+eKvuIGdNLojrd5D7fIpHgJL7ukl/ke3csWHlV5PU1cCYF4nHFLdZwe8SnuubtaESjzG
	Vgp68PxxXMNMhmmCasKg2RFEY1LiTl3APtrVfJJv2KmrjH/XsFR86qYn6iZOqfROhv4kHI
	nV8Gu5Qb6Alwfr25fxNbuSyLAMy/iif5SUXFUm5WVQhtCg4W0JStBgRKyekeGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709326121;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M9H3lpdsOdOgobAjbpYohIUvcrULTxKy8/5jJJrx0Ts=;
	b=3z3WOrnR3l/uK22KoyXP+qRJEWenhprxUpw/K6wANAVKx8lsfelyAaJuOn6WF9ntt7ChK5
	Th2tISzIdfUIYrDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/idle: Select idle routine only once
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87edcu6vaq.ffs@tglx>
References: <87edcu6vaq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170932611993.398.17268708078847688756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     25525edd9c99d3aa799e80a8e98bdd62ed1639f9
Gitweb:        https://git.kernel.org/tip/25525edd9c99d3aa799e80a8e98bdd62ed1639f9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 28 Feb 2024 23:20:32 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 01 Mar 2024 21:34:55 +01:00

x86/idle: Select idle routine only once

The idle routine selection is done on every CPU bringup operation and
has a guard in place which is effective after the first invocation,
which is a pointless exercise.

Invoke it once on the boot CPU and mark the related functions __init.
The guard check has to stay as xen_set_default_idle() runs early.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/87edcu6vaq.ffs@tglx
---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/cpu/common.c     | 4 ++--
 arch/x86/kernel/process.c        | 8 +++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 1188e8b..523c466 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -558,7 +558,7 @@ static inline void load_sp0(unsigned long sp0)
 
 unsigned long __get_wchan(struct task_struct *p);
 
-extern void select_idle_routine(const struct cpuinfo_x86 *c);
+extern void select_idle_routine(void);
 extern void amd_e400_c1e_apic_setup(void);
 
 extern unsigned long		boot_option_idle_override;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8f367d3..5c72af1 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1938,8 +1938,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Init Machine Check Exception if available. */
 	mcheck_cpu_init(c);
 
-	select_idle_routine(c);
-
 #ifdef CONFIG_NUMA
 	numa_add_cpu(smp_processor_id());
 #endif
@@ -2344,6 +2342,8 @@ void __init arch_cpu_finalize_init(void)
 {
 	identify_boot_cpu();
 
+	select_idle_routine();
+
 	/*
 	 * identify_boot_cpu() initialized SMT support information, let the
 	 * core code know.
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 2d51cbd..ac34342 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -853,8 +853,9 @@ void __noreturn stop_this_cpu(void *dummy)
  * Do not prefer MWAIT if MONITOR instruction has a bug or idle=nomwait
  * is passed to kernel commandline parameter.
  */
-static bool prefer_mwait_c1_over_halt(const struct cpuinfo_x86 *c)
+static __init bool prefer_mwait_c1_over_halt(void)
 {
+	const struct cpuinfo_x86 *c = &boot_cpu_data;
 	u32 eax, ebx, ecx, edx;
 
 	/* If override is enforced on the command line, fall back to HALT. */
@@ -908,7 +909,7 @@ static __cpuidle void mwait_idle(void)
 	__current_clr_polling();
 }
 
-void select_idle_routine(const struct cpuinfo_x86 *c)
+void __init select_idle_routine(void)
 {
 	if (boot_option_idle_override == IDLE_POLL) {
 		if (IS_ENABLED(CONFIG_SMP) && smp_num_siblings > 1)
@@ -916,10 +917,11 @@ void select_idle_routine(const struct cpuinfo_x86 *c)
 		return;
 	}
 
+	/* Required to guard against xen_set_default_idle() */
 	if (x86_idle_set())
 		return;
 
-	if (prefer_mwait_c1_over_halt(c)) {
+	if (prefer_mwait_c1_over_halt()) {
 		pr_info("using mwait in idle threads\n");
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {

