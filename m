Return-Path: <linux-kernel+bounces-166406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF408B9A34
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083371C21015
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856175817;
	Thu,  2 May 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VQERwyiQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/zKBDVi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FC60DE9;
	Thu,  2 May 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650189; cv=none; b=Ce4vhSk4O0jIVcimX0N4P42WUkWb9wUlpnKCMX4rLha5wz0/2bkl21zrT4xSR+sQ/JAuPP/hLyJdiBZkawFlxWN4q70ZhRz3OLdNRi+BQ3POPhBWoKc4ei7qDwjbg+chG39WYP9yAxP9ZMCBq8eEg8wCE09E0MGSecJ6byuYqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650189; c=relaxed/simple;
	bh=c5POMlepPRVoF1s5Ffqtb5y0sEw0/bvEI/jA+bNF9EM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NwSfuoFwFa1ccHyAZjC/TNDobtX0x2hU/wR6rXeC6NDhqandRwNgUCv+K7FioopoSRWymcl5ADmVXpJyACOB87fI8UIxg7oKqwHa4u3bJAl0y+Q/A4Ltt0ZwN6LBR3z7J4m73TEeaiczBaEyQei5Z97C5ejJbZzDCPZ4u5DHvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VQERwyiQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/zKBDVi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 02 May 2024 11:43:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714650185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WmSmEVUnGOCD2Zf9f9N8l2nvmwjYFBRuFodFEopZsE=;
	b=VQERwyiQjAlU+0TInsUtxVQtJv0FieqiUarPLmqIPpxowt2Xi5LzmHyIg4XWOQ9Vuyee+g
	K1YEydiZbyO4U1FAZVTmxli5B0KAMM43kLF/lKCohB6dRYPOimUWz16bDjubvzWZ8RSPKb
	0sX1yKiO71Bjt73Z210RuJsynHahmclYwabdZ/EJ8GFhWidoHfQN7FE78Le6MpoPbPBoqN
	IX4u5ck70qBW0+ZG6MgIfR/D1G96nuVoxB4ILO4KrXLAETlHwVyVaSigYUEv2+8Jj0UiYn
	zhGkEprpvx7gsT2TvAOFE9S8Yeio2ivXgCrwDstgi5XIDti9/dgHz3VyMwsz8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714650185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WmSmEVUnGOCD2Zf9f9N8l2nvmwjYFBRuFodFEopZsE=;
	b=m/zKBDVi8steFp9ml8YT/LkalkrJgF+QB570UQCOinXvQqA0keUwAkq8ifytAdV0h+wDlF
	0OT/e53zun6bPBDQ==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240502095115.177713-3-Dhananjay.Ugwekar@amd.com>
References: <20240502095115.177713-3-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171465018456.10875.10497808495496531229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5d4d0283c0546559600dee7e9a4d87e402f3f4d9
Gitweb:        https://git.kernel.org/tip/5d4d0283c0546559600dee7e9a4d87e402f3f4d9
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Thu, 02 May 2024 15:21:15 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 02 May 2024 13:32:22 +02:00

perf/x86/rapl: Fix the energy-pkg event for AMD CPUs

After:

  63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")

on AMD processors that support extended CPUID leaf 0x80000026, the
topology_die_cpumask() and topology_logical_die_id() macros, no longer
return the package cpumask and package id, instead they return the CCD
(Core Complex Die) mask and id respectively. This leads to the energy-pkg
event scope to be modified to CCD instead of package.

Replacing these macros with their package counterparts fixes the
energy-pkg event for AMD CPUs.

However due to the difference between the scope of energy-pkg event for
Intel and AMD CPUs, we have to replace these macros conditionally only for
AMD CPUs.

On a 12 CCD 1 Package AMD Zen4 Genoa machine:

Before:

  $ cat /sys/devices/power/cpumask
  0,8,16,24,32,40,48,56,64,72,80,88.

The expected cpumask here is supposed to be just "0", as it is a package
scope event, only one CPU will be collecting the event for all the CPUs in
the package.

  After:
  $ cat /sys/devices/power/cpumask
  0

Fixes: 63edbaa48a57 ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf")
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240502095115.177713-3-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 46e6735..c3897f5 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -102,6 +102,10 @@ static struct perf_pmu_events_attr event_attr_##v = {				\
 	.event_str	= str,							\
 };
 
+#define rapl_pmu_is_pkg_scope()				\
+	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
+	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+
 struct rapl_pmu {
 	raw_spinlock_t		lock;
 	int			n_active;
@@ -139,9 +143,21 @@ static unsigned int rapl_cntr_mask;
 static u64 rapl_timer_ms;
 static struct perf_msr *rapl_msrs;
 
+static inline unsigned int get_rapl_pmu_idx(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
+					 topology_logical_die_id(cpu);
+}
+
+static inline cpumask_t *get_rapl_pmu_cpumask(int cpu)
+{
+	return rapl_pmu_is_pkg_scope() ? topology_core_cpumask(cpu) :
+					 topology_die_cpumask(cpu);
+}
+
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
@@ -542,6 +558,7 @@ static struct perf_msr amd_rapl_msrs[] = {
 
 static int rapl_cpu_offline(unsigned int cpu)
 {
+	cpumask_t *cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -551,7 +568,7 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 	pmu->cpu = -1;
 	/* Find a new cpu to collect rapl events */
-	target = cpumask_any_but(topology_die_cpumask(cpu), cpu);
+	target = cpumask_any_but(cpumask, cpu);
 
 	/* Migrate rapl events to the new target */
 	if (target < nr_cpu_ids) {
@@ -564,6 +581,8 @@ static int rapl_cpu_offline(unsigned int cpu)
 
 static int rapl_cpu_online(unsigned int cpu)
 {
+	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
+	cpumask_t *cpumask = get_rapl_pmu_cpumask(cpu);
 	struct rapl_pmu *pmu = cpu_to_rapl_pmu(cpu);
 	int target;
 
@@ -578,14 +597,14 @@ static int rapl_cpu_online(unsigned int cpu)
 		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
 		rapl_hrtimer_init(pmu);
 
-		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
+		rapl_pmus->pmus[rapl_pmu_idx] = pmu;
 	}
 
 	/*
 	 * Check if there is an online cpu in the package which collects rapl
 	 * events already.
 	 */
-	target = cpumask_any_and(&rapl_cpu_mask, topology_die_cpumask(cpu));
+	target = cpumask_any_and(&rapl_cpu_mask, cpumask);
 	if (target < nr_cpu_ids)
 		return 0;
 
@@ -676,6 +695,9 @@ static int __init init_rapl_pmus(void)
 {
 	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
 
+	if (rapl_pmu_is_pkg_scope())
+		nr_rapl_pmu = topology_max_packages();
+
 	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;

