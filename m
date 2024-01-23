Return-Path: <linux-kernel+bounces-35337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277AF838F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 596AA1C286D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A1B60B9E;
	Tue, 23 Jan 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v1c+8OMQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8daHkChi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE56088B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015435; cv=none; b=JYHRv7MJmb5i2LMMlQR0b3oO7EWmxNN7/HorVcIhD+za656vo6CI1RRfSRZlxN4mjDb0r+1S9JPmi+6m7aA4vyKLGqMnIiBguk2HA45MM22QnED6x8d/7xs2/Q7d/Is5e+I/EmoKFNDvuHbsZcKkO/Jvn2P/f/peVM95YYIl1fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015435; c=relaxed/simple;
	bh=0qMVlQPKRxyDbSTYpiblt7ffe4V1bSAmEODgMXO+qeE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MnUf8pWLNpSY5puev5FYrwePRbJ97RNAM5YuoSfNNnczzV9B1wYNa2NJhOp1Rk6Yatmxy/DL2XXkjY4AmNEOlsBSL22yjvWCH7h+7vWq6OdyyPDJGUfmeaHHwUX3wIXCraHrnZoCz6pWOP2hYT+JMquBBuXJCR4MVMTfRaoLn2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v1c+8OMQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8daHkChi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.500431632@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A8RkebXNwsJ5VdVMdWHu1cg5spzu3s2/kJMF+AX7n90=;
	b=v1c+8OMQQJl0M8k0RdvD8Qu4+oyZqncEXua40G0QaHuzCwNAMfa4tsRuDX9l0Og201iPsj
	GosnJKrMXIwNCXJvIHKR/oPUylvmsbfvNf4TcnGHxBKfhP5XcmA1bB510c9vV8tbUyjSbQ
	NIJRfcU1o7PebCPy6/C3YsbSYGF3zJeEWs1OVG2946vc0joNXMYcoU64uTrOGXeayOAfTC
	0DrfEx959LKUi727Bvoo4NByoSADNJTWlWQaz07ecxdz9QJqYfQ3974NaJ01xDdPHouRLj
	sZa7ZAJ2jatJx1ZBvxG48WgwXLDNS9HmKL7L0ExG+uAXaX6x1z+VFEej2NKr1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=A8RkebXNwsJ5VdVMdWHu1cg5spzu3s2/kJMF+AX7n90=;
	b=8daHkChizcJw3Z8Id/1aIEYQRHqOfdGA+7SZ1iYal0JErh336p6mjFZ28rVEmrIiTISK1G
	nitbhyG/ocUiFKDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V2 18/22] x86/mm/numa: Move early mptable evaluation into
 common code
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:31 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

There is no reason to have the early mptable evaluation conditionally
invoked only from the AMD numa topology code.

Make it explicit and invoke it from setup_arch() right after the
corresponding ACPI init call. Remove the pointless wrapper and invoke
x86_init::mpparse::early_parse_smp_config() directly.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/mpspec.h |    5 -----
 arch/x86/kernel/setup.c       |    2 ++
 arch/x86/mm/amdtopology.c     |    7 -------
 3 files changed, 2 insertions(+), 12 deletions(-)
---
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -46,11 +46,6 @@ extern int smp_found_config;
 # define smp_found_config 0
 #endif
 
-static inline void early_get_smp_config(void)
-{
-	x86_init.mpparse.early_parse_smp_cfg();
-}
-
 #ifdef CONFIG_X86_MPPARSE
 extern void e820__memblock_alloc_reserved_mpc_new(void);
 extern int enable_update_mptable;
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1086,7 +1086,9 @@ void __init setup_arch(char **cmdline_p)
 
 	early_platform_quirks();
 
+	/* Some platforms need the APIC registered for NUMA configuration */
 	early_acpi_boot_init();
+	x86_init.mpparse.early_parse_smp_cfg();
 
 	x86_flattree_get_config();
 
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -161,13 +161,6 @@ int __init amd_numa_init(void)
 	 */
 	cores = topology_get_domain_size(TOPO_CORE_DOMAIN);
 
-	/*
-	 * Scan MPTABLE to map the local APIC and ensure that the boot CPU
-	 * APIC ID is valid. This is required because on pre ACPI/SRAT
-	 * systems IO-APICs are mapped before the boot CPU.
-	 */
-	early_get_smp_config();
-
 	apicid = boot_cpu_physical_apicid;
 	if (apicid > 0)
 		pr_info("BSP APIC ID: %02x\n", apicid);


