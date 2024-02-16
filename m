Return-Path: <linux-kernel+bounces-68791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26504858073
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4991C21095
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBF312F5B0;
	Fri, 16 Feb 2024 15:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENMIdNGw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wbZSeAw6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C83D12F58E;
	Fri, 16 Feb 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096610; cv=none; b=gbMw2UMgBtjPYkK/H2KYmc/AN1v7gqj7yu+3MPfLcpnzaUOhDZ3SC/UB+DUTnDwZfkOQi8RfGkI2Sqs59F0HqfVrJ5Ka1cBK6xqOZhySZyLq0WfA94kelXQOysTn9ihELGkDK4k0wmSarnFvWyvdSoyglOop4Wi9dpMwB8D1PuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096610; c=relaxed/simple;
	bh=87aBUH2geLqP6qWJcMgFrUxnJ6oAgwG0kK+U7lTN4vM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VxSAGTOs01khC/2mKTqL3Y2qM0po6camvukJmEygIM+VoysJQwnLcmqWDPbgnpaNAMeqL/lg5qaPtR2HMNWD6cFzDvruWd4h6INDVMWWKMOjpBlEWu4biTAnGGt59T2Lb04jpicXFwZuFn8XaciDknM7MYeUvo9GZ+RnszPFKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENMIdNGw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wbZSeAw6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvfbQ983vsDbDkLwt4MWftilcISBcmuNDYwYREOaqhQ=;
	b=ENMIdNGwsprTzd7jbD2HEaqCKcjSlx2p4yIHsOtJV2tux4kKqwW739xbRJ4nRAeGizQwFv
	sscuVNolx6L8+75ONdAnasYf090jjG0g2oCScXsplU4p/yY9O5VcRi5NGfGNxdZ5PMD/oG
	LzYyfX+Ix+vC0SxBo6fH+KkX1Y4mf1zazy2/Ea3wG0f1F/cgRKSAqgcbl0TeSmU4Su9YxP
	oRzc2zUguQKerFBTY5cJjLaflsGS3K9Ct9dIQZpeICdHvLbweIS8rT9dLRD5rW3L/xIJul
	WxPeVlssXtqYYw533M/a8xSRTXaiELcvusN5OR/yK/OUZWqz3u6UVk5x6/0zKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096606;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvfbQ983vsDbDkLwt4MWftilcISBcmuNDYwYREOaqhQ=;
	b=wbZSeAw6Ol6Q9E1ODWUGmB8KOQQyrtA/2ranfarbgkbri3cQoAN7z78b7eBhMGUeBAo4r8
	0MPg+HkwnqPDi6DQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu/topology: Provide __num_[cores|threads]_per_package
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210253.120958987@linutronix.de>
References: <20240213210253.120958987@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809660562.398.5308891544456323136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     fd43b8ae76e903c76f14d06eb939449bcc3f614f
Gitweb:        https://git.kernel.org/tip/fd43b8ae76e903c76f14d06eb939449bcc3f614f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:45 +01:00

x86/cpu/topology: Provide __num_[cores|threads]_per_package

Expose properly accounted information and accessors so the fiddling with
other topology variables can be replaced.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210253.120958987@linutronix.de





---
 arch/x86/include/asm/topology.h | 12 ++++++++++++
 arch/x86/kernel/cpu/common.c    |  6 ++++++
 arch/x86/kernel/cpu/topology.c  |  8 +++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 6a71794..76b1d87 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -146,6 +146,8 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 extern unsigned int __max_dies_per_package;
 extern unsigned int __max_logical_packages;
 extern unsigned int __max_threads_per_core;
+extern unsigned int __num_threads_per_package;
+extern unsigned int __num_cores_per_package;
 
 static inline unsigned int topology_max_packages(void)
 {
@@ -157,6 +159,16 @@ static inline unsigned int topology_max_dies_per_package(void)
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb22cb8..c9a1014 100644
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
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index b078fac..41dd8e0 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -392,7 +392,7 @@ void __init topology_init_possible_cpus(void)
 	unsigned int disabled = topo_info.nr_disabled_cpus;
 	unsigned int cnta, cntb, cpu, allowed = 1;
 	unsigned int total = assigned + disabled;
-	u32 apicid;
+	u32 apicid, firstid;
 
 	if (!restrict_to_up()) {
 		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
@@ -432,6 +432,12 @@ void __init topology_init_possible_cpus(void)
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

