Return-Path: <linux-kernel+bounces-64315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00380853CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EEE1C219D7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E868C126F38;
	Tue, 13 Feb 2024 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYaOnL/2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3J2b59gv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68186656
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858378; cv=none; b=Zhkg53Nlotm8jb3tBWM1OOKKurlAoOrNqTpY3+/FkVneC+TEYEobGW2oENXMAjQM3kNQsulMJLzMCKlHuMrdTYD14BRSqSJeZD1//A3Zm3Tebqk4MGdSo+tsGJxVz2bWOGPfxme1TQ+JCG7CmIpA54Zp64Axzx4HyEI3T3qmgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858378; c=relaxed/simple;
	bh=BYCek0/+KoSqfQdbi1lbVUiGFjTm1kaHkGsteLGoGIE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=X+6pSAoa9PBlwKuIwtWwgOmpCxP8m+SkzI5/OyR2UZNLM1Y2JtaYkqqZBGs9djaNGxGDVIhuMDxIO7dpZi48x55qGe5LtI5ZXPSA4Tutzy5RYgIg7hxPV6jH5uBCYlRsB7aFrjE/cD1h5zuZbxvjV1CwM5FeHoWa/LjZPJZtXoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hYaOnL/2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3J2b59gv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210253.120958987@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=C480USuDHEN1DJ+mKCDr2IgHfoW7jqhf18boy4k9tqM=;
	b=hYaOnL/2Ivox9nGn6t1XhqdZYSeR367afVMDfPkVKYBkupJXWsIv3t0KB/M60YAmcRbtRQ
	GJsQ9TsdWBQ0Vh9i0vc3pHz5awnxMJRYE52WHDqwaFl7o1rVeSWAWiki82qlR/o1uMaABo
	qdyAHDgFOPDOehXMgCsc5nHiptunDWV3ZolodYWeKNAE0a1jLz8Zi6bHAUb4U3TVqkLJ1H
	iOlNyc0JfnU4lA9/HGWBXd0hIsMqHnCg1X1LNKCk24Hrb4dGiO5TOXSgw1mgI3Ar8uSDBJ
	Mi7UF6MD2hLVhMeIOcDL9iyKr9q480hyTWcVLVGxd+5BaoOL9wATQtP5tQ2NVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=C480USuDHEN1DJ+mKCDr2IgHfoW7jqhf18boy4k9tqM=;
	b=3J2b59gvV8IAF6w5DQ21L0W8SAgnPLSrBqG0IGpzra53FVKM3SBvvgt86wGk+3SkkW/qRy
	NKCjFWVmism2MOAA==
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
Subject: [patch 29/30] x86/cpu/topology: Provide
 __num_[cores|threads]_per_package
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:06:14 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Expose properly accounted information and accessors so the fiddling with
other topology variables can be replaced.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>




---
 arch/x86/include/asm/topology.h |   12 ++++++++++++
 arch/x86/kernel/cpu/common.c    |    6 ++++++
 arch/x86/kernel/cpu/topology.c  |    8 +++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)
---

--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -146,6 +146,8 @@ extern const struct cpumask *cpu_cluster
 extern unsigned int __max_dies_per_package;
 extern unsigned int __max_logical_packages;
 extern unsigned int __max_threads_per_core;
+extern unsigned int __num_threads_per_package;
+extern unsigned int __num_cores_per_package;
 
 static inline unsigned int topology_max_packages(void)
 {
@@ -157,6 +159,16 @@ static inline unsigned int topology_max_
 	return __max_dies_per_package;
 }
 
+static inline unsigned int topology_num_cores_per_package(void)
+{
+	return __num_cores_per_package;
+}
+
+static inline unsigned int topology_num_threads_per_package(void)
+{
+	return __num_threads_per_package;
+}
+
 #ifdef CONFIG_X86_LOCAL_APIC
 int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
 #else
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -82,6 +82,12 @@ EXPORT_SYMBOL(__max_dies_per_package);
 unsigned int __max_logical_packages __ro_after_init = 1;
 EXPORT_SYMBOL(__max_logical_packages);
 
+unsigned int __num_cores_per_package __ro_after_init = 1;
+EXPORT_SYMBOL(__num_cores_per_package);
+
+unsigned int __num_threads_per_package __ro_after_init = 1;
+EXPORT_SYMBOL(__num_threads_per_package);
+
 static struct ppin_info {
 	int	feature;
 	int	msr_ppin_ctl;
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -392,7 +392,7 @@ void __init topology_init_possible_cpus(
 	unsigned int disabled = topo_info.nr_disabled_cpus;
 	unsigned int cnta, cntb, cpu, allowed = 1;
 	unsigned int total = assigned + disabled;
-	u32 apicid;
+	u32 apicid, firstid;
 
 	if (!restrict_to_up()) {
 		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
@@ -432,6 +432,12 @@ void __init topology_init_possible_cpus(
 	__max_threads_per_core = DIV_ROUND_UP(cntb, cnta);
 	pr_info("Max. threads per core: %3u\n", __max_threads_per_core);
 
+	firstid = find_first_bit(apic_maps[TOPO_SMT_DOMAIN].map, MAX_LOCAL_APIC);
+	__num_cores_per_package = topology_unit_count(firstid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN);
+	pr_info("Num. cores per package:   %3u\n", __num_cores_per_package);
+	__num_threads_per_package = topology_unit_count(firstid, TOPO_SMT_DOMAIN, TOPO_PKG_DOMAIN);
+	pr_info("Num. threads per package: %3u\n", __num_threads_per_package);
+
 	pr_info("Allowing %u present CPUs plus %u hotplug CPUs\n", assigned, disabled);
 	if (topo_info.nr_rejected_cpus)
 		pr_info("Rejected CPUs %u\n", topo_info.nr_rejected_cpus);


