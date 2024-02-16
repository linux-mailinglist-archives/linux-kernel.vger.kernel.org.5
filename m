Return-Path: <linux-kernel+bounces-68792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB8858076
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38F4B22E06
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9412FB08;
	Fri, 16 Feb 2024 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBpd/Daz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wdv55JVH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3A612C542;
	Fri, 16 Feb 2024 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096610; cv=none; b=ek7NvAyVTmafU2K22FueNkVSNi02iMpkMZeULvgUVKFuA/npqzSFMmurNLsavBifna5M6VL2wSRQ0u8BIoxFc08GS9dOud4YCjTdNczAz0ZvBX/IZ0VXB3eqTdvYD9vYX55SYcT6RhpNgHVxApz/BdE0kUgYNsYWoDphTy0Jp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096610; c=relaxed/simple;
	bh=8vN22Fa223dpzRdJS0xs9yVX7sKJZJQcuWdsAyULd3g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jiJwwU03UTg0UcCdW4KTOMTeKdLUylzNjKAAp7F55vZRXqrNhi70B8Hq3s8TTWu72FtMbA2RRhVVwsq/ouqxlwnW+6o0W2Pgj7GZ0U7OP9/5p/5fJwAMtLJGyW0is2gcPosO/yxepMWEDvI/u8HQKRKFX9pJKf+F8xdIOUBbIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eBpd/Daz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wdv55JVH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rj+8DezBDvEIayPs/FLnwfQYhVi3iu8ntUmon+Wx8b4=;
	b=eBpd/DazOBi7Sc/Nn9CCazS+q/nVvfl1M8U+IdESCh1o1VcR+uPMRaP7ApRcIag2KMH1h+
	JWGWMsHwxNLMBnmi4CjJo7ASlq0qbxUnEERY6v0RX6XVp3xqAhpdpIIuOprsA9R0XxNClM
	gempvqfyCVCGE+RTHfKt7vXy4s9U0s2GKX+pptfJ4e/JIJ60enAeFcCQWiUM5C5oKdcrwv
	A22nZFI4F7Nhohc+2VFGUxNS5Qr7LMe3/MszMZEZEjg4laOvWwMmC/AYsT8PJvPdNBI+jv
	kN4YjgIJyjG6VV0MKEEh7f9Jz4WuaQb66sA92jm39OzWAivq33jnRn/SpwKnCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096607;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rj+8DezBDvEIayPs/FLnwfQYhVi3iu8ntUmon+Wx8b4=;
	b=wdv55JVHQK1a7yR7KJDU+siN6M8Tw0mC7vY/jb7PP1mpCU8tZ1BCMsDQRrMn/7ZlBKwTlP
	gnv32FWb2hcn+7BA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu/topology: Rename topology_max_die_per_package()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210253.065874205@linutronix.de>
References: <20240213210253.065874205@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809660649.398.17755746396920689604.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     bd745d1c41e7fa56242889eb5dc6df2d7dd5df32
Gitweb:        https://git.kernel.org/tip/bd745d1c41e7fa56242889eb5dc6df2d7dd5df32
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:45 +01:00

x86/cpu/topology: Rename topology_max_die_per_package()

The plural of die is dies.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210253.065874205@linutronix.de





---
 arch/x86/events/intel/cstate.c                                 | 2 +-
 arch/x86/events/intel/uncore.c                                 | 2 +-
 arch/x86/events/intel/uncore_snbep.c                           | 2 +-
 arch/x86/events/rapl.c                                         | 2 +-
 arch/x86/include/asm/topology.h                                | 2 +-
 drivers/hwmon/coretemp.c                                       | 2 +-
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c | 2 +-
 drivers/powercap/intel_rapl_common.c                           | 2 +-
 drivers/thermal/intel/intel_hfi.c                              | 2 +-
 drivers/thermal/intel/intel_powerclamp.c                       | 2 +-
 drivers/thermal/intel/x86_pkg_temp_thermal.c                   | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 4b50a3a..326c8cd 100644
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
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7927c0b..258e2cd 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1893,7 +1893,7 @@ static int __init intel_uncore_init(void)
 		return -ENODEV;
 
 	__uncore_max_dies =
-		topology_max_packages() * topology_max_die_per_package();
+		topology_max_packages() * topology_max_dies_per_package();
 
 	id = x86_match_cpu(intel_uncore_match);
 	if (!id) {
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index a96496b..3f6bd3e 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -1406,7 +1406,7 @@ static int topology_gidnid_map(int nodeid, u32 gidnid)
 	 */
 	for (i = 0; i < 8; i++) {
 		if (nodeid == GIDNIDMAP(gidnid, i)) {
-			if (topology_max_die_per_package() > 1)
+			if (topology_max_dies_per_package() > 1)
 				die_id = i;
 			else
 				die_id = topology_phys_to_logical_pkg(i);
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8d98d46..fb2b196 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -674,7 +674,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 
 static int __init init_rapl_pmus(void)
 {
-	int maxdie = topology_max_packages() * topology_max_die_per_package();
+	int maxdie = topology_max_packages() * topology_max_dies_per_package();
 	size_t size;
 
 	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index f9eb7a7..6a71794 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -152,7 +152,7 @@ static inline unsigned int topology_max_packages(void)
 	return __max_logical_packages;
 }
 
-static inline unsigned int topology_max_die_per_package(void)
+static inline unsigned int topology_max_dies_per_package(void)
 {
 	return __max_dies_per_package;
 }
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index b8fc8d1..b0991dd 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -782,7 +782,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_zones = topology_max_packages() * topology_max_die_per_package();
+	max_zones = topology_max_packages() * topology_max_dies_per_package();
 	zone_devices = kcalloc(max_zones, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!zone_devices)
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index a5e0f5c..b89c0dd 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -242,7 +242,7 @@ static int __init intel_uncore_init(void)
 		return -ENODEV;
 
 	uncore_max_entries = topology_max_packages() *
-					topology_max_die_per_package();
+					topology_max_dies_per_package();
 	uncore_instances = kcalloc(uncore_max_entries,
 				   sizeof(*uncore_instances), GFP_KERNEL);
 	if (!uncore_instances)
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 2feed03..00c8618 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -1564,7 +1564,7 @@ struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id
 	if (id_is_cpu) {
 		rp->id = topology_logical_die_id(id);
 		rp->lead_cpu = id;
-		if (topology_max_die_per_package() > 1)
+		if (topology_max_dies_per_package() > 1)
 			snprintf(rp->name, PACKAGE_DOMAIN_NAME_LENGTH, "package-%d-die-%d",
 				 topology_physical_package_id(id), topology_die_id(id));
 		else
diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 3b04c6e..40d664a 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -607,7 +607,7 @@ void __init intel_hfi_init(void)
 
 	/* There is one HFI instance per die/package. */
 	max_hfi_instances = topology_max_packages() *
-			    topology_max_die_per_package();
+			    topology_max_dies_per_package();
 
 	/*
 	 * This allocation may fail. CPU hotplug callbacks must check
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index bc6eb0d..4ba6493 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -587,7 +587,7 @@ static int powerclamp_idle_injection_register(void)
 	poll_pkg_cstate_enable = false;
 	if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask)) {
 		ii_dev = idle_inject_register_full(idle_injection_cpu_mask, idle_inject_update);
-		if (topology_max_packages() == 1 && topology_max_die_per_package() == 1)
+		if (topology_max_packages() == 1 && topology_max_dies_per_package() == 1)
 			poll_pkg_cstate_enable = true;
 	} else {
 		ii_dev = idle_inject_register(idle_injection_cpu_mask);
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 11a7f81..f6c2e59 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -494,7 +494,7 @@ static int __init pkg_temp_thermal_init(void)
 	if (!x86_match_cpu(pkg_temp_thermal_ids))
 		return -ENODEV;
 
-	max_id = topology_max_packages() * topology_max_die_per_package();
+	max_id = topology_max_packages() * topology_max_dies_per_package();
 	zones = kcalloc(max_id, sizeof(struct zone_device *),
 			   GFP_KERNEL);
 	if (!zones)

