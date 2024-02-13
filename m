Return-Path: <linux-kernel+bounces-64314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5525853CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07F31C2647D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5942F126F26;
	Tue, 13 Feb 2024 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sKlP4aTv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="08E1zKcb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE17586641
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858377; cv=none; b=UtRimFGVv1MAhamt20u+I0sR1ZCrj4WancVZKi0Wwan7Ol200ZDnB0XUKOXQ+ml7qTKrRI4Sf+FcY5SajstbjH0MUHOn6fDSci1h8LEX86MaxndS2zT8E3qzCkXKPiEjilbMAGjw7liE94OlT1fTTtz9iPNLxp4F4cUHgMKXdCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858377; c=relaxed/simple;
	bh=IrKSZPpLJ/Y/f8FnuQwmNVIDJwx1Y6EVcBMi8JiDE1c=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=N1nBxHcE26KnbgSkC6w9J+SHHsM1VSOqP+LS5UPqqVOYPFd5UbTauKuENK9x6Lfb6osTMIvJ2nwR1zBGZ882wxJqW0iMcoU0kLXXXJPNYws15nHuVKCSVhozjvEWRJw06hJiTnjlYpWeHBk1PN5rmFvt/r0PZhtn45SGykKatYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sKlP4aTv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=08E1zKcb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240213210253.065874205@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ffq8OSBfFXk7L/XYpfubgUqVDyHdsKBV4J5Vam4i0Rg=;
	b=sKlP4aTvJcHUS9KacVFyIIlWua9semKXHohWG6ENNW10gEVuhL24dZDdnQljswBSlwvoAA
	iEHzaNRbEZp0txTbCndX61n4rKy+X3zndMIeViAC/It7DjFq5pDN0L2znIN5rOgADV6IRN
	gjy9FnJPNbZkbE/sNpojpwWM4bLXPv2JwAisCS1R5aRkYvdzyt+T5U/Fqe1yhIeIgHvfn/
	ByH9lxjttx7OjPwnTFhlF8lVbS7p8pO1y6xUS44VDMFsF7awwVyEajwJ4IORcrJ8UMDlcF
	Grj5E19pxLmw7Wa9sEoU96N8Erp/rcowhzETekvo+aRpmQOZnrtPxLfZIqyOuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ffq8OSBfFXk7L/XYpfubgUqVDyHdsKBV4J5Vam4i0Rg=;
	b=08E1zKcbb05+VQEAI55k7BaQ0SMktbZcbEloPOT0gMEJ9cvuP02V6yXcJOcK8YXqv6jzLR
	d6eIMawFzBCYcpCw==
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
Subject: [patch 28/30] x86/cpu/topology: Rename topology_max_die_per_package()
References: <20240213205415.307029033@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:06:13 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

The plural of die is dies.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>




---
 arch/x86/events/intel/cstate.c                                 |    2 +-
 arch/x86/events/intel/uncore.c                                 |    2 +-
 arch/x86/events/intel/uncore_snbep.c                           |    2 +-
 arch/x86/events/rapl.c                                         |    2 +-
 arch/x86/include/asm/topology.h                                |    2 +-
 drivers/hwmon/coretemp.c                                       |    2 +-
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c |    2 +-
 drivers/powercap/intel_rapl_common.c                           |    2 +-
 drivers/thermal/intel/intel_hfi.c                              |    2 +-
 drivers/thermal/intel/intel_powerclamp.c                       |    2 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c                   |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)
---

--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -834,7 +834,7 @@ static int __init cstate_init(void)
 	}
 
 	if (has_cstate_pkg) {
-		if (topology_max_die_per_package() > 1) {
+		if (topology_max_dies_per_package() > 1) {
 			err = perf_pmu_register(&cstate_pkg_pmu,
 						"cstate_die", -1);
 		} else {
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1893,7 +1893,7 @@ static int __init intel_uncore_init(void
 		return -ENODEV;
 
 	__uncore_max_dies =
-		topology_max_packages() * topology_max_die_per_package();
+		topology_max_packages() * topology_max_dies_per_package();
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id) {
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1406,7 +1406,7 @@ static int topology_gidnid_map(int nodei
 	 */
 	for (i = 0; i < 8; i++) {
 		if (nodeid == GIDNIDMAP(gidnid, i)) {
-			if (topology_max_die_per_package() > 1)
+			if (topology_max_dies_per_package() > 1)
 				die_id = i;
 			else
 				die_id = topology_phys_to_logical_pkg(i);
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -674,7 +674,7 @@ static const struct attribute_group *rap
 
 static int __init init_rapl_pmus(void)
 {
-	int maxdie = topology_max_packages() * topology_max_die_per_package();
+	int maxdie = topology_max_packages() * topology_max_dies_per_package();
 	size_t size;
 
 	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -152,7 +152,7 @@ static inline unsigned int topology_max_
 	return __max_logical_packages;
 }
 
-static inline unsigned int topology_max_die_per_package(void)
+static inline unsigned int topology_max_dies_per_package(void)
 {
 	return __max_dies_per_package;
 }
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -780,7 +780,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_zones = topology_max_packages() * topology_max_die_per_package();
+	max_zones = topology_max_packages() * topology_max_dies_per_package();
 	zone_devices = kcalloc(max_zones, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!zone_devices)
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -242,7 +242,7 @@ static int __init intel_uncore_init(void
 		return -ENODEV;
 
 	uncore_max_entries = topology_max_packages() *
-					topology_max_die_per_package();
+					topology_max_dies_per_package();
 	uncore_instances = kcalloc(uncore_max_entries,
 				   sizeof(*uncore_instances), GFP_KERNEL);
 	if (!uncore_instances)
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1564,7 +1564,7 @@ struct rapl_package *rapl_add_package(in
 	if (id_is_cpu) {
 		rp->id = topology_logical_die_id(id);
 		rp->lead_cpu = id;
-		if (topology_max_die_per_package() > 1)
+		if (topology_max_dies_per_package() > 1)
 			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
 				 topology_physical_package_id(id), topology_die_id(id));
 		else
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -581,7 +581,7 @@ void __init intel_hfi_init(void)
 
 	/* There is one HFI instance per die/package. */
 	max_hfi_instances = topology_max_packages() *
-			    topology_max_die_per_package();
+			    topology_max_dies_per_package();
 
 	/*
 	 * This allocation may fail. CPU hotplug callbacks must check
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -616,7 +616,7 @@ static int powerclamp_idle_injection_reg
 	poll_pkg_cstate_enable = false;
 	if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask)) {
 		ii_dev = idle_inject_register_full(idle_injection_cpu_mask, idle_inject_update);
-		if (topology_max_packages() == 1 && topology_max_die_per_package() == 1)
+		if (topology_max_packages() == 1 && topology_max_dies_per_package() == 1)
 			poll_pkg_cstate_enable = true;
 	} else {
 		ii_dev = idle_inject_register(idle_injection_cpu_mask);
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -494,7 +494,7 @@ static int __init pkg_temp_thermal_init(
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	max_id = topology_max_packages() * topology_max_die_per_package();
+	max_id = topology_max_packages() * topology_max_dies_per_package();
 	zones = kcalloc(max_id, sizeof(struct zone_device *),
 			   GFP_KERNEL);
 	if (!zones)



