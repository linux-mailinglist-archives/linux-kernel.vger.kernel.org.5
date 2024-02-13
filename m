Return-Path: <linux-kernel+bounces-64242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA8D853C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AF81C22E99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04366214F;
	Tue, 13 Feb 2024 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jK3XKW8T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a0DvwaJw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F76167E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858247; cv=none; b=k0Xyr1o+Hj1FgDFCNRltSMXZ+Q8EUWZbTrL7hVNvH008RWOnqb5k8SAMlv09ucLy2z6woto16fK4868nenXb/30pOO3zXf/MWeQmN1oxZCkzqcdx8FjS9FzhG3ytgrDHCRFCG1JimMYDqjBWtRDWb0h+N3+TldCG0QZAMX89vXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858247; c=relaxed/simple;
	bh=rzJRDd07DQzyOI3vFvLyo30rvQuYP+fyKgjiQvWo65A=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tGSpDa9Qe8m5I7uskMCNVvRXs+TyEcUm8K1uC95pUN/m+BbnNds4xYvhCfjKZQGUnNLMkMzFdo7ixrKslbtY89PaYkqv2c1RnuIc+mFOZ+COzOAmip301xnUTSz5o0OumcMoc7IxqmpoU4PIadw1yGyKDVYz4Cb6MYU/VYMBaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jK3XKW8T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a0DvwaJw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153624.644448852@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=boqcIU/ZFA+rm7+t4NycyG5KGsKb0/dLPE34Do9xfZg=;
	b=jK3XKW8TH25srFoYj/y65xYLR8Ipwzik8HHdyV4FvFFnpDuU27buTTzxYapxo2mlR0fO7L
	QA01tnBnlJnzauZZBgM4MjBk3G81W0NJiQY2jmdTXMTmwPkq5krFaEpCQPGVlSrHsoQ5Cj
	TiijkAifIkpJCZsKi/HEdYk/E01DEINB+cf+Eq/uz753X8o+5qdJ88Nec6rZ1i9f0trZf1
	G5sTTayOlvbAQdlg7ePxFKG8nwJyxMwvaqv4NKXBJBKl7HEH+th41V5wYqMN17nUK1YxOV
	kW1efMnb4ztRytnGwtXaFRLzdIWpFSRX9Moov2oAyrfrhF1p0+Ssn30F72yy4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=boqcIU/ZFA+rm7+t4NycyG5KGsKb0/dLPE34Do9xfZg=;
	b=a0DvwaJwbINSMnYLNG6pS9SuY/Oa/v1OZEKzYPuFUex6iuggsbMIZGrN4bjIfg6FMe2DlG
	yU28GkI16MYr64AA==
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
Subject: [patch V6 03/19] x86/cpu: Add legacy topology parser
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:03 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The legacy topology detection via CPUID leaf 4, which provides the number
of cores in the package and CPUID leaf 1 which provides the number of
logical CPUs in case that FEATURE_HT is enabled and the CMP_LEGACY feature
is not set, is shared for Intel, Centaur and Zhaoxin CPUs.

Lift the code from common.c without the early detection hack and provide it
as common fallback mechanism.

Will be utilized in later changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
V6: Rename parse_num_cores() to parse_num_cores_legacy() - Arjan
    Change comment style - Borislav
---
 arch/x86/kernel/cpu/common.c          |    3 ++
 arch/x86/kernel/cpu/topology.h        |    3 ++
 arch/x86/kernel/cpu/topology_common.c |   46 +++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)
---

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -892,6 +892,9 @@ void detect_ht(struct cpuinfo_x86 *c)
 #ifdef CONFIG_SMP
 	int index_msb, core_bits;
 
+	if (topo_is_converted(c))
+		return;
+
 	if (detect_ht_early(c) < 0)
 		return;
 
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -6,6 +6,9 @@ struct topo_scan {
 	struct cpuinfo_x86	*c;
 	unsigned int		dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int		dom_ncpus[TOPO_MAX_DOMAIN];
+
+	/* Legacy CPUID[1]:EBX[23:16] number of logical processors */
+	unsigned int		ebx1_nproc_shift;
 };
 
 bool topo_is_converted(struct cpuinfo_x86 *c);
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -24,6 +24,48 @@ void topology_set_dom(struct topo_scan *
 	}
 }
 
+static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
+{
+	struct {
+		u32	cache_type	:  5,
+			unused		: 21,
+			ncores		:  6;
+	} eax;
+
+	if (c->cpuid_level < 4)
+		return 1;
+
+	cpuid_subleaf_reg(4, 0, CPUID_EAX, &eax);
+	if (!eax.cache_type)
+		return 1;
+
+	return eax.ncores + 1;
+}
+
+static void __maybe_unused parse_legacy(struct topo_scan *tscan)
+{
+	unsigned int cores, core_shift, smt_shift = 0;
+	struct cpuinfo_x86 *c = tscan->c;
+
+	cores = parse_num_cores_legacy(c);
+	core_shift = get_count_order(cores);
+
+	if (cpu_has(c, X86_FEATURE_HT)) {
+		if (!WARN_ON_ONCE(tscan->ebx1_nproc_shift < core_shift))
+			smt_shift = tscan->ebx1_nproc_shift - core_shift;
+		/*
+		 * The parser expects leaf 0xb/0x1f format, which means
+		 * the number of logical processors at core level is
+		 * counting threads.
+		 */
+		core_shift += smt_shift;
+		cores <<= smt_shift;
+	}
+
+	topology_set_dom(tscan, TOPO_SMT_DOMAIN, smt_shift, 1U << smt_shift);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, core_shift, cores);
+}
+
 bool topo_is_converted(struct cpuinfo_x86 *c)
 {
 	/* Temporary until everything is converted over. */
@@ -47,7 +89,7 @@ static bool fake_topology(struct topo_sc
 	 * which has useless CPUID information.
 	 */
 	topology_set_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
-	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 1, 1);
+	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 0, 1);
 
 	return tscan->c->cpuid_level < 1 || xen_pv_domain();
 }
@@ -88,6 +130,8 @@ static void parse_topology(struct topo_s
 	/* The above is sufficient for UP */
 	if (!IS_ENABLED(CONFIG_SMP))
 		return;
+
+	tscan->ebx1_nproc_shift = get_count_order(ebx.nproc);
 }
 
 static void topo_set_ids(struct topo_scan *tscan)


