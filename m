Return-Path: <linux-kernel+bounces-64243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 337F0853C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC23E1F245E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD962173;
	Tue, 13 Feb 2024 21:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4eAnK4JW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GzM1rkYV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2E62145
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858248; cv=none; b=PwdLoa5v+5co9OFAV4Og9Z+mWhSOkmfuJG+s9HdxR1ZUO3cGyz59eLrVAk6f6W7DHtmS4K4s5baztl8MSPAM+W3oYt6xTx5gdxbqg0vdJHnddSb2QjLtR3quqd+JxHuNGGcvAIOenstwnAeXUydVt97rVLMAGC6LGKquq+leXOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858248; c=relaxed/simple;
	bh=vVMaaZa/gDKoCoSidPyHPqMNGJI6wBZu/Y6hGssq/dk=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=uyM4U5zo21xB4qXGo5d4BV5UDyoipBxNcngQ+YQ4RtArFfmM/fjaHs9b5PA87Hj55KIFgjDLZ0n4mjQeT76RFAYkzMkt4pAkKSwFYqq0PdbAtw/FTaDeFjv7GIy0cmQk7d6fxrpDUcr3c5RaNhfKwOuoMXOdJNEC6ePF9FY1mdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4eAnK4JW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GzM1rkYV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153624.706794189@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=z/2utW/eab7c/d43I2wk7KTcIRtO+0FmA0sU6rsMN3s=;
	b=4eAnK4JWNmX5xl460AybW40H4SzD8SyJe/Tj90QL7VUy4DEe/9or5bTgGtquS/6Mv6uW/m
	gCguqdG0Og7+3ewT8v0zBsCLkwvyENN8sKSFC1sev/Ubq9gX6KJRmnMH8atWZdHPLU5jsD
	c7FpFI2iPUj6Rf+iUT13uLK1ER8fRmTI8n0seM9V+E17ax9ZABBIAVIeSm+/GBtq1NcUqD
	UoxC01iAZXfguv/G7a3JZi6cJ6ui19U4UHCGcY0s8V4sDx4sELkT0zsl59P/avFXckJf3Q
	uLdmAUqAGDH0bDKaIX6ABxN/oOhmhEPnhxp2HgMtYTkXhat7oaJG0Jcis0xuoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=z/2utW/eab7c/d43I2wk7KTcIRtO+0FmA0sU6rsMN3s=;
	b=GzM1rkYV0UXW8yunt+VoXNJys3Rdgc+2x+saH8CvkfvE7CWc8a9BCcLlQ15HOhSaKCl+/y
	2vFFdcLNUDKhedBA==
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
 Wang Wendy <wendy.wang@intel.com>
Subject: [patch V6 04/19] x86/cpu: Use common topology code for Centaur and
 Zhaoxin
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:04 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Centaur and Zhaoxin CPUs use only the legacy SMP detection. Remove the
invocations from their 32bit path and exclude them from the 64-bit call
path.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
V6: Fixup changelog - Borislav
---
 arch/x86/kernel/cpu/centaur.c         |    4 ----
 arch/x86/kernel/cpu/topology_common.c |   11 ++++++++---
 arch/x86/kernel/cpu/zhaoxin.c         |    4 ----
 3 files changed, 8 insertions(+), 11 deletions(-)
---

--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -128,10 +128,6 @@ static void init_centaur(struct cpuinfo_
 #endif
 	early_init_centaur(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-	detect_ht(c);
-#endif
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -42,7 +42,7 @@ static unsigned int parse_num_cores(stru
 	return eax.ncores + 1;
 }
 
-static void __maybe_unused parse_legacy(struct topo_scan *tscan)
+static void parse_legacy(struct topo_scan *tscan)
 {
 	unsigned int cores, core_shift, smt_shift = 0;
 	struct cpuinfo_x86 *c = tscan->c;
@@ -71,10 +71,8 @@ bool topo_is_converted(struct cpuinfo_x8
 	/* Temporary until everything is converted over. */
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
-	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_HYGON:
-	case X86_VENDOR_ZHAOXIN:
 		return false;
 	default:
 		/* Let all UP systems use the below */
@@ -132,6 +130,13 @@ static void parse_topology(struct topo_s
 		return;
 
 	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_CENTAUR:
+	case X86_VENDOR_ZHAOXIN:
+		parse_legacy(tscan);
+		break;
+	}
 }
 
 static void topo_set_ids(struct topo_scan *tscan)
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -71,10 +71,6 @@ static void init_zhaoxin(struct cpuinfo_
 {
 	early_init_zhaoxin(c);
 	init_intel_cacheinfo(c);
-	detect_num_cpu_cores(c);
-#ifdef CONFIG_X86_32
-	detect_ht(c);
-#endif
 
 	if (c->cpuid_level > 9) {
 		unsigned int eax = cpuid_eax(10);




