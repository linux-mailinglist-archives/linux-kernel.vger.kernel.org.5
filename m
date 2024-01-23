Return-Path: <linux-kernel+bounces-35371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941B3838FE2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E34CB26A38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398667742;
	Tue, 23 Jan 2024 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k3CVQvDR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p9vjR1pw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015166B52
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015500; cv=none; b=oRHD2Ao2nhMEzHkBj9aVaz/TA2O5/TrQUvwAevvzvkPXE4CP9hC9Jc356IPcl2x7wrp63h5AMbzlaT5stLaSVyg79wju0UmOQkRHqiqgNj8BOQmZIJufu1AqPN5164SrQ4nRPmQTCtr6+Ow2naCXkBsK0RMSXOokMo7gWnoyN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015500; c=relaxed/simple;
	bh=evvK7ga7udVVxA8A5oaBHks8qKmsIHUbst7bXfEr5X8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Twc5v1z28aM602pCdVPoP6TTzpPXYMRgpo9ZR5CbHlKLPT2oF9GdLOIYbpgTVR05kw1Z50cMaBq+cjU3N65lpdqCYa/vfhES5SkaOIFxqDy9RuwhhQ5XvBPo6PX6Y61XvuKNk9+PcTjQlS8XG24I28ZQo649WLddf1h/Saqywfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k3CVQvDR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p9vjR1pw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240118123650.140932565@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NtCn1qIjdDagUvktcocvZnySBrSVkEHTjg+7jYEXYkc=;
	b=k3CVQvDRCvPF8Cbv3D1LJfnFe8ZqE1LdOR7FDjch0AP3QqC0hhYkD0QGgYZZs7ZUyt/wm7
	sKYgb9uxd4gTqvUIhzKosEMnJdqXdlEcBYBREpYKiXbnxP/vzlWleTbHRWqbNhIXG5QrcE
	m87Hsdd6WiFCJducFUQjuQzC1Cg7ddkSxlVEcXzNlaR//Hy+d3jPtLOcGEszMFTSwlbk7e
	dpdlwagIjP+iLB7F9D4Q/V+D4btoGE5tMxYFozFAk3/lFIfh6sKNvQ3NrhwAdwFkIDkdO0
	DSFDGs/08aKK99Mna48/IBA3QsKq4dNE3X6sjwB05PcK5zs6zQfU6MgCWGFnsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NtCn1qIjdDagUvktcocvZnySBrSVkEHTjg+7jYEXYkc=;
	b=p9vjR1pwtgtuA3dBWfSxIoL0FWoPIHhLKXg8yLXmUM1OvrR6oGFq7Aw3rx2FdQIHtLQ8eW
	cqCCd941UModO8BA==
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
Subject: [patch v2 28/30] x86/cpu/topology: Rename
 topology_max_die_per_package()
References: <20240118123127.055361964@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:11:35 +0100 (CET)

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


