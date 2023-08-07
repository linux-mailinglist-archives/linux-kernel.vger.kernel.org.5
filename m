Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5A7726D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjHGN4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjHGN40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:56:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC835AE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:54:10 -0700 (PDT)
Message-ID: <20230807135029.113801542@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w4U+yB4ROBK4XzZUwiiPUCYehecaC+ipD1PTXQaVmCQ=;
        b=fgD2PDxVwUdKHh2/dXbkPQQh2+P8oZa9wFPNt0LfCVfaIwvLWbw8GnzZbrnMp3vzym6fY/
        gzy1z1c4L3xVcEiFqdgki0QIPc6dxSeR9DVvxlkCCLpA/cjO6wqkt+5zPaXoli0v41dAdh
        ++GoXSRoY4G7Desul1Xx4PQxIwjbKGIj3h//Op0eKxEnUpAOZxzvRbSRMmAVgrU8Bb+igW
        NYHJUi0vJNak3MvubdkU/vA587wuuGdln6dxUBcbWjYi23sN0bDpKcBXq+2hpumeNA2oUn
        928/YyKdFDcYsNixfENVifg+o4NL85+d6MF1ntEgW5NYKITnEcV5qz/JWeLeNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=w4U+yB4ROBK4XzZUwiiPUCYehecaC+ipD1PTXQaVmCQ=;
        b=/kkrO2CUw/3bkBxO1bRbt/+Dbz00VgAyWPb+rqGZ93bThk51PNJlMJoFL0axJDwnasya16
        rwDq9Vm9y3Q3X9DA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 51/53] x86/cpu/topology: Rename topology_max_die_per_package()
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:53 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -751,7 +751,7 @@ static int __init cstate_init(void)
 	}
 
 	if (has_cstate_pkg) {
-		if (topology_max_die_per_package() > 1) {
+		if (topology_max_dies_per_package() > 1) {
 			err = perf_pmu_register(&cstate_pkg_pmu,
 						"cstate_die", -1);
 		} else {
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1881,7 +1881,7 @@ static int __init intel_uncore_init(void
 		return -ENODEV;
 
 	__uncore_max_dies =
-		topology_max_packages() * topology_max_die_per_package();
+		topology_max_packages() * topology_max_dies_per_package();
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id) {
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1441,7 +1441,7 @@ static int snbep_pci2phy_map_init(int de
 			 */
 			for (i = 0; i < 8; i++) {
 				if (nodeid == GIDNIDMAP(config, i)) {
-					if (topology_max_die_per_package() > 1)
+					if (topology_max_dies_per_package() > 1)
 						die_id = i;
 					else
 						die_id = topology_phys_to_logical_pkg(i);
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -678,7 +678,7 @@ static const struct attribute_group *rap
 
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
@@ -229,7 +229,7 @@ static int __init intel_uncore_init(void
 		return -ENODEV;
 
 	uncore_max_entries = topology_max_packages() *
-					topology_max_die_per_package();
+					topology_max_dies_per_package();
 	uncore_instances = kcalloc(uncore_max_entries,
 				   sizeof(*uncore_instances), GFP_KERNEL);
 	if (!uncore_instances)
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1566,7 +1566,7 @@ struct rapl_package *rapl_add_package(in
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
@@ -542,7 +542,7 @@ void __init intel_hfi_init(void)
 
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

