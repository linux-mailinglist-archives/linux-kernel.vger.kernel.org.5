Return-Path: <linux-kernel+bounces-35267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E2838EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6BE9286A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552DF5F858;
	Tue, 23 Jan 2024 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gqo8fpm0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xXX2SZW9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E65F574
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014418; cv=none; b=CzckxtRKE38oAvqykMMVObZd1RIP5Ae+kO7dNmlOBFy53/u2G4Gk9gtm/iZXBXT5JQLKvKnvjE/EV4H5PKneXlay7dAih8FXPKaGcnloswfcoXbqzcHp3goH/fTYi9zl+MmkbZBGje50y9odGqWErZxTQTibdF8rmMhzOQW8cDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014418; c=relaxed/simple;
	bh=V70qJUYY8oyHztXjt5ElJsr4r84LmSynsQcDzBQCb0k=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OEWbss+5HfDzUPJvJSK+bkh0vyixgRg9hgDnkX7JnGNfuVek2tqhHKIuwAxkDer3yfsw4xVrcIvbH+re0LgDVmHHZevY9T1nvMXrQv9fLUMRbugV7pgToYCbAOSEJtjPyWOSa3Pk2Rq2AvsVYF/RTPI+Isf92FmuWydCy0LCak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gqo8fpm0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xXX2SZW9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115908.477060795@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8VUl7pYr590afD01ha6vPyQIe2lBly9mAJe0mtABk/E=;
	b=Gqo8fpm0jQugypsMtvfTEljTWrL5oNDuEgskAbYJsqlQzO9LM5HXrWDGIVXogvTAi+XiRa
	jOXC0NUfa8rrEuP9pmDKTa1PI6XW1WL7/EXT0hZASAofRhgk0DcOKYmZNHhphnETVNXPtN
	PP+nhUZViE4938xuDzKSLkIL6Jcwhtb91+41O+0yVjis+7mBoNMH6zphUwCGAxCuQFzUe3
	uvoyUQgNvJDuzpXTZE8A/qizUImU+M3ygM8CnRVx8dY+B7sT0S4JEMDum7EaX9uUo6P8K0
	oz9T/fkVWh/c2Lb4MxqfWKokO04MaeBnps6JtmNcwqedR4YD7fdtYNz3dziPYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=8VUl7pYr590afD01ha6vPyQIe2lBly9mAJe0mtABk/E=;
	b=xXX2SZW9BI738ejKEPtAgf3doA5bSGLPZcxPAFtNrfqZt0uQPfYoB+k65P61uGSYDAGvG1
	f7LSExxP27tSiPBA==
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
Subject: [patch v5 03/19] x86/cpu: Add legacy topology parser
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:34 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The legacy topology detection via CPUID leaf 4, which provides the number
of cores in the package and CPUID leaf 1 which provides the number of
logical CPUs in case that FEATURE_HT is enabled and the CMP_LEGACY feature
is not set, is shared for Intel, Centaur amd Zhaoxin CPUs.

Lift the code from common.c without the early detection hack and provide it
as common fallback mechanism.

Will be utilized in later changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


---
 arch/x86/kernel/cpu/common.c          |    3 ++
 arch/x86/kernel/cpu/topology.h        |    3 ++
 arch/x86/kernel/cpu/topology_common.c |   46 +++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)
---
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -891,6 +891,9 @@ void detect_ht(struct cpuinfo_x86 *c)
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
+	// Legacy CPUID[1]:EBX[23:16] number of logical processors
+	unsigned int		ebx1_nproc_shift;
 };
 
 bool topo_is_converted(struct cpuinfo_x86 *c);
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -24,6 +24,48 @@ void topology_set_dom(struct topo_scan *
 	}
 }
 
+static unsigned int parse_num_cores(struct cpuinfo_x86 *c)
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
+	cores = parse_num_cores(c);
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


