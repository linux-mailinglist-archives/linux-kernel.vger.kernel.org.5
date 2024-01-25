Return-Path: <linux-kernel+bounces-39081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2BD83CAB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144EAB25A32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1217135A45;
	Thu, 25 Jan 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NZUtpDRq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7bqEtTd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC735133994;
	Thu, 25 Jan 2024 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706206878; cv=none; b=nCCCVpxQOwVQjVgX+euKryWmO3N1oypdYs28uu++n7AONWVgbXrKpAIOxmFe2ExmXyN0rQFOMI4JfUCSnv7sr3amV1jFTrSaKrjYFCMl22ifUh0T/fryi4XATmJWmDqw+1d5OTgBwUoJ+A6SCZyOQ0Zzlfr1s5DOuS5dJ6rMayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706206878; c=relaxed/simple;
	bh=+gYbRRNF8VL4AUO+/s19Tp8vjrP5BmpHxwfIE0dYgUI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o8PNBCiv1DlxQYZAdYHNUHUrdAb5Aj70Oj/ayRvpuZpooeQ/YRWezg5FZCyLsGtGbA5obtU86NHbQH7dGSX8F17f5QP4tFh2vknEVoa/PkpX6zK+gi2HlEjgmZMMA2/5mWA277aEWrgPpDR19M5EUdbSIXg61D/MwhlBV4ZT8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NZUtpDRq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v7bqEtTd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Jan 2024 18:21:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706206874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEO2pBTBit5Kauaudc9uk4cBNZqTpRTvXqnfWiOO+LQ=;
	b=NZUtpDRqtLfRKx5rqVRM0TnzzdDMeUVIQbO/bXLQQbjEGjNehWSeqvOyAlo5cbz3skPu9t
	nRWYfyBLfl+Kry3NvuyMaZmnmp2uShqlRSUrRIz+bemE6k4FQD/i6HRxk3oesxxWfhpiRp
	g9FDYmnhQUKqjuq8EYWtwRULeXzXFUT08xR2Mdu0g+nnJvcPN6fxqqA8zVaGwJEc41J2H8
	2paRPILmbth0gK4+Fvp2fvgbQ8kkCwByy4dTk61lrUffu3Jx3v465OE91ExfVP04KkZVvq
	FwBpNaEIkpJCVp1OJ821IIljaoXWlbpFALdMl7Gv43+17+5k5nFSyzcTUgZS8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706206874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEO2pBTBit5Kauaudc9uk4cBNZqTpRTvXqnfWiOO+LQ=;
	b=v7bqEtTds46SzjPMzx0VjmwJaP1ne5xmKXZLU/0TPlYNPq78KqPaw3oWhvWu+vufzWXBTJ
	jUwHdu6V3+7K0IDA==
From: "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fred] x86/fred: Invoke FRED initialization code to enable FRED
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Xin Li <xin3.li@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-36-xin3.li@intel.com>
References: <20231205105030.8698-36-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170620687375.398.11388384121726676497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     a9f26154bf5478fc155309fc69128415f3a1be08
Gitweb:        https://git.kernel.org/tip/a9f26154bf5478fc155309fc69128415f3a1be08
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:24 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Jan 2024 19:10:33 +01:00

x86/fred: Invoke FRED initialization code to enable FRED

Let cpu_init_exception_handling() call cpu_init_fred_exceptions() to
initialize FRED. However if FRED is unavailable or disabled, it falls
back to set up TSS IST and initialize IDT.

Co-developed-by: Xin Li <xin3.li@intel.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-36-xin3.li@intel.com

---
 arch/x86/kernel/cpu/common.c | 22 +++++++++++++++++-----
 arch/x86/kernel/irqinit.c    |  7 ++++++-
 arch/x86/kernel/traps.c      |  5 ++++-
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 399f0d0..5ed968c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -61,6 +61,7 @@
 #include <asm/microcode.h>
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
+#include <asm/fred.h>
 #include <asm/uv/uv.h>
 #include <asm/ia32.h>
 #include <asm/set_memory.h>
@@ -2110,7 +2111,15 @@ void syscall_init(void)
 	/* The default user and kernel segments */
 	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
 
-	idt_syscall_init();
+	/*
+	 * Except the IA32_STAR MSR, there is NO need to setup SYSCALL and
+	 * SYSENTER MSRs for FRED, because FRED uses the ring 3 FRED
+	 * entrypoint for SYSCALL and SYSENTER, and ERETU is the only legit
+	 * instruction to return to ring 3 (both sysexit and sysret cause
+	 * #UD when FRED is enabled).
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		idt_syscall_init();
 }
 
 #else	/* CONFIG_X86_64 */
@@ -2216,8 +2225,9 @@ void cpu_init_exception_handling(void)
 	/* paranoid_entry() gets the CPU number from the GDT */
 	setup_getcpu(cpu);
 
-	/* IST vectors need TSS to be set up. */
-	tss_setup_ist(tss);
+	/* For IDT mode, IST vectors need to be set in TSS. */
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		tss_setup_ist(tss);
 	tss_setup_io_bitmap(tss);
 	set_tss_desc(cpu, &get_cpu_entry_area(cpu)->tss.x86_tss);
 
@@ -2226,8 +2236,10 @@ void cpu_init_exception_handling(void)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
 
-	/* Finally load the IDT */
-	load_current_idt();
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		cpu_init_fred_exceptions();
+	else
+		load_current_idt();
 }
 
 /*
diff --git a/arch/x86/kernel/irqinit.c b/arch/x86/kernel/irqinit.c
index c683666..f79c5ed 100644
--- a/arch/x86/kernel/irqinit.c
+++ b/arch/x86/kernel/irqinit.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/i8259.h>
 #include <asm/traps.h>
+#include <asm/fred.h>
 #include <asm/prom.h>
 
 /*
@@ -96,7 +97,11 @@ void __init native_init_IRQ(void)
 	/* Execute any quirks before the call gates are initialised: */
 	x86_init.irqs.pre_vector_init();
 
-	idt_setup_apic_and_irq_gates();
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		fred_complete_exception_setup();
+	else
+		idt_setup_apic_and_irq_gates();
+
 	lapic_assign_system_vectors();
 
 	if (!acpi_ioapic && !of_ioapic && nr_legacy_irqs()) {
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index a03c233..cf198d9 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1412,7 +1412,10 @@ void __init trap_init(void)
 
 	/* Initialize TSS before setting up traps so ISTs work */
 	cpu_init_exception_handling();
+
 	/* Setup traps as cpu_init() might #GP */
-	idt_setup_traps();
+	if (!cpu_feature_enabled(X86_FEATURE_FRED))
+		idt_setup_traps();
+
 	cpu_init();
 }

