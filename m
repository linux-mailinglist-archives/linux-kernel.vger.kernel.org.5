Return-Path: <linux-kernel+bounces-35268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F3D838EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E0E1F24F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CAA5F870;
	Tue, 23 Jan 2024 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sz195eBc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dOdjb4dZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555905F846
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014419; cv=none; b=KbizqQT7sg7MHrUy05nwws1EjXdi+WX5D9XEcWNBDM1/2VgSR7L9xTjpoIfqgrnnlQyys3EblZbVqwtnxP6xdonQ8TzQFzSWy3Wubjz1OYdvysSFsgQXbYWT9s63hX3QcE+fdVxgPTEaO0xyTj8D8NMX502Zep9WInFJ0mJADDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014419; c=relaxed/simple;
	bh=hBxUau5onbyu+zjuJhrMNZuHL+WMvv5PXELy3ItN9yY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Ud7pEoB8M0stpd8J1SdGiWzNhJDGTX9FvSVVTtPmMcyR5Jo7y1pwu0SlDlgkcpiFW/LgUX92yxV9Z11oBzbn1E7At+uwVZPMcnrgFCptCZbch1Jo7WBt9Jl+0uVodVtqCOm26v4/FHLIuANdUxRQ1fIVFMfo+BOH7d21X8Sz/nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sz195eBc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dOdjb4dZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115908.542473474@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RLy749FW2PFLvVXjhU8LmOLJWnw66SbG5wPjqrOoIvw=;
	b=Sz195eBcyIV/x/RdoIVyfC76Ecpk7SkM4lMDqqujWENkQG8P3hkwFRDqEQio7kDS+YE2uv
	q6hcAm8NvwBzjcQm16TAQbLJZxQADDf48DBN7mUrGouDRpJ7rc7N37OmkIhDT+BNf/oPj5
	1li0fbEMIYZA9s346hin02nO3ZbnKQVxll8EUh4Rl+94iXpAYQRC8KQndMLqUe+XuKclmC
	D2B4u3jj6ABVIoHQTOHIxZdCZFm11GC6TJLke9qiTd8kPaTbOkpzpaMCd4TTShI7vpdiss
	R8yKC2AZKnMsTErHbtk/yYgnNPgzfAUiXpUTWh7sUcaku8qycTOPmrkj8FQIHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=RLy749FW2PFLvVXjhU8LmOLJWnw66SbG5wPjqrOoIvw=;
	b=dOdjb4dZsj1ct237gcypXb60Xf1HgmmKEUeAmpVyXeZ0lK6XfySO8/kOL41fYd9z3YI0Mj
	71itvTZTje2cbrDA==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v5 04/19] x86/cpu: Use common topology code for Centaur and
 Zhaoxin
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:35 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Centaur and Zhaoxin CPUs use only the legacy SMP detection. Remove the
invocations from their 32bit path and exempt them from the call 64bit.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


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


