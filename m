Return-Path: <linux-kernel+bounces-46368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA45843E97
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26681C25B72
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9A7BB0E;
	Wed, 31 Jan 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5Hy3ull"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B47AE6E;
	Wed, 31 Jan 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701050; cv=none; b=sr240/zfkLHC7A6pW/A0oJlwBiS8FwI88d7FmcjpjywPuBcRNKCj7iVj2lmtFMZIQT3rn1XYSBNuTxMdxmyoC9EWvjTB+R63ai+uXWIBE9EH+eVokzRLofDk/a8sOiByJ6qt65LpoG5093mFYVKrl1I1knopGVliA/CoWEeNbSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701050; c=relaxed/simple;
	bh=HZHQQsIcvY0GIFCdIWOohL5EGPt1hOYTvfZ+z3doboM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uGFQzgGiUGmJ9gcynjgfLa/B68m5F1IvWi5sblSj9cTZSGGO0ONA3hfzkffm2TWeSrFw7xm3+uNOrMUvgex34hd74wBno8qZDdScFFv8z9+K2RQZhYz9SEV7e+XlMaqbB2DZ4LpdPBDABOfRe3XfUc7EPjsuSyRrNoZ4OS1lm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G5Hy3ull; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706701049; x=1738237049;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZHQQsIcvY0GIFCdIWOohL5EGPt1hOYTvfZ+z3doboM=;
  b=G5Hy3ullwjvLVHqkn1ZIEL62Oxay+osJNpS0ontYmun/JxSQ1pNjG1K6
   Tsy7zlkOBLM7VV3vclssHyQlNsp1LchuLAAdgJaFnz6NaimNzbdZiBrmN
   2+mVUj4fPxyVvzwf9LoyrX8wkNuP6ldCQgqOfI0c866Cy0iXIm5Kc8gnO
   0H+N1pdYzkSg+7YiMp0aHM1UcVUN9EAmgbYzmrVEnqSIZz9JzEOz6OpHD
   6B/OFB/OoNu3CIlZaq4X0K0hD/KX6vPnBD+cx9IXpdpfpEPboOdpZyXI9
   vwLaZutcID0V7KwVjkdYTTE192CXu+z/nnVAWusT9KE4hyQnsxQ4jdJ76
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3441625"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3441625"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788542479"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788542479"
Received: from puhongt-mobl2.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.255.29.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:37:25 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/6] powercap: intel_rapl: Fix locking for TPMI RAPL
Date: Wed, 31 Jan 2024 19:37:09 +0800
Message-Id: <20240131113713.74779-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131113713.74779-1-rui.zhang@intel.com>
References: <20240131113713.74779-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RAPL framework uses CPU hotplug lock to protect rapl_packages list and
rp->lead_cpu to guarantee that
1. the RAPL package device is not unprobed and freed
2. the cached rp->lead_cpu is always valid
for operations like powercap sysfs accesses.

Current RAPL APIs assume they are called from CPU hotplug callbacks
which hold the CPU hotplug lock. But TPMI RAPL driver invokes the APIs
in the driver' .probe() function without CPU hotplug lock held.

Fix the problem by providing both locked and lockless version RAPL APIs.

Fixes: 9eef7f9da928 ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c          | 29 +++++++++++++++++--
 drivers/powercap/intel_rapl_msr.c             |  8 ++---
 .../int340x_thermal/processor_thermal_rapl.c  |  8 ++---
 include/linux/intel_rapl.h                    |  6 ++++
 4 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 1a739afd47d9..9d3e102f1a76 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -5,6 +5,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/list.h>
@@ -1504,7 +1505,7 @@ static int rapl_detect_domains(struct rapl_package *rp)
 }
 
 /* called from CPU hotplug notifier, hotplug lock held */
-void rapl_remove_package(struct rapl_package *rp)
+void rapl_remove_package_cpuslocked(struct rapl_package *rp)
 {
 	struct rapl_domain *rd, *rd_package = NULL;
 
@@ -1533,10 +1534,18 @@ void rapl_remove_package(struct rapl_package *rp)
 	list_del(&rp->plist);
 	kfree(rp);
 }
+EXPORT_SYMBOL_GPL(rapl_remove_package_cpuslocked);
+
+void rapl_remove_package(struct rapl_package *rp)
+{
+	guard(cpus_read_lock)();
+	rapl_remove_package_cpuslocked(rp);
+}
 EXPORT_SYMBOL_GPL(rapl_remove_package);
 
 /* caller to ensure CPU hotplug lock is held */
-struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
+							 bool id_is_cpu)
 {
 	struct rapl_package *rp;
 	int uid;
@@ -1554,10 +1563,17 @@ struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(rapl_find_package_domain_cpuslocked);
+
+struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+{
+	guard(cpus_read_lock)();
+	return rapl_find_package_domain_cpuslocked(id, priv, id_is_cpu);
+}
 EXPORT_SYMBOL_GPL(rapl_find_package_domain);
 
 /* called from CPU hotplug notifier, hotplug lock held */
-struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *priv, bool id_is_cpu)
 {
 	struct rapl_package *rp;
 	int ret;
@@ -1603,6 +1619,13 @@ struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id
 	kfree(rp);
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(rapl_add_package_cpuslocked);
+
+struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu)
+{
+	guard(cpus_read_lock)();
+	return rapl_add_package_cpuslocked(id, priv, id_is_cpu);
+}
 EXPORT_SYMBOL_GPL(rapl_add_package);
 
 static void power_limit_state_save(void)
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index 250bd41a588c..b4b6930cacb0 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -73,9 +73,9 @@ static int rapl_cpu_online(unsigned int cpu)
 {
 	struct rapl_package *rp;
 
-	rp = rapl_find_package_domain(cpu, rapl_msr_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, rapl_msr_priv, true);
 	if (!rp) {
-		rp = rapl_add_package(cpu, rapl_msr_priv, true);
+		rp = rapl_add_package_cpuslocked(cpu, rapl_msr_priv, true);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -88,14 +88,14 @@ static int rapl_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, rapl_msr_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, rapl_msr_priv, true);
 	if (!rp)
 		return 0;
 
 	cpumask_clear_cpu(cpu, &rp->cpumask);
 	lead_cpu = cpumask_first(&rp->cpumask);
 	if (lead_cpu >= nr_cpu_ids)
-		rapl_remove_package(rp);
+		rapl_remove_package_cpuslocked(rp);
 	else if (rp->lead_cpu == cpu)
 		rp->lead_cpu = lead_cpu;
 	return 0;
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index 2f00fc3bf274..e964a9375722 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -27,9 +27,9 @@ static int rapl_mmio_cpu_online(unsigned int cpu)
 	if (topology_physical_package_id(cpu))
 		return 0;
 
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
 	if (!rp) {
-		rp = rapl_add_package(cpu, &rapl_mmio_priv, true);
+		rp = rapl_add_package_cpuslocked(cpu, &rapl_mmio_priv, true);
 		if (IS_ERR(rp))
 			return PTR_ERR(rp);
 	}
@@ -42,14 +42,14 @@ static int rapl_mmio_cpu_down_prep(unsigned int cpu)
 	struct rapl_package *rp;
 	int lead_cpu;
 
-	rp = rapl_find_package_domain(cpu, &rapl_mmio_priv, true);
+	rp = rapl_find_package_domain_cpuslocked(cpu, &rapl_mmio_priv, true);
 	if (!rp)
 		return 0;
 
 	cpumask_clear_cpu(cpu, &rp->cpumask);
 	lead_cpu = cpumask_first(&rp->cpumask);
 	if (lead_cpu >= nr_cpu_ids)
-		rapl_remove_package(rp);
+		rapl_remove_package_cpuslocked(rp);
 	else if (rp->lead_cpu == cpu)
 		rp->lead_cpu = lead_cpu;
 	return 0;
diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 33f21bd85dbf..f3196f82fd8a 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -178,6 +178,12 @@ struct rapl_package {
 	struct rapl_if_priv *priv;
 };
 
+struct rapl_package *rapl_find_package_domain_cpuslocked(int id, struct rapl_if_priv *priv,
+						       bool id_is_cpu);
+struct rapl_package *rapl_add_package_cpuslocked(int id, struct rapl_if_priv *priv,
+						 bool id_is_cpu);
+void rapl_remove_package_cpuslocked(struct rapl_package *rp);
+
 struct rapl_package *rapl_find_package_domain(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 struct rapl_package *rapl_add_package(int id, struct rapl_if_priv *priv, bool id_is_cpu);
 void rapl_remove_package(struct rapl_package *rp);
-- 
2.34.1


