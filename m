Return-Path: <linux-kernel+bounces-164785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECC18B82D2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23F21F22CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CF117B4FA;
	Tue, 30 Apr 2024 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSgTkK9k"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E186D1B806;
	Tue, 30 Apr 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517918; cv=none; b=JhIpJqbYYGIH8HNppPSFwN1tJAh2Urgn7WQAP+k3eJoZX7p/4WtrrSIYWyGNS0sHbJXQwrQCxx2CC9oKsk1SCQXMu2/gGthBpn8BeawDNK5Mc0uvfZs5KSqL78QfV9WrtlC1uSYl3gGAPZ2puY0Ng/4tH/eXY0FLQSlbn6G706c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517918; c=relaxed/simple;
	bh=i2LBlzw9iKOjzEXU0CEVXfSh5oG4+DpG2KcSsVkKhwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yzp63QinHjnY/y6vdksTAY+1iQR9nsSQkwR2II0GgF7t3LQizAL68ixidLdLh7xIu0WxOMetAt51cVOmR8YAYegHRLqarv4XoWPZfb0mjHvJM5L3GsNLyfgTd7Z+qwOKL2aXsJmbxddCrPJ1UB90dQ8Z1+eql+2YC4A0rSpKigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSgTkK9k; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714517917; x=1746053917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i2LBlzw9iKOjzEXU0CEVXfSh5oG4+DpG2KcSsVkKhwo=;
  b=DSgTkK9kcQCSOCToThSCVmuleJkGJou574Jly7trCsPqJcKVvMMPGqIm
   tauvx4C8+18DdWy3REKOdZgqi1qqpBJyzCie6vA0Wb2lMyVXZxkZS6lg7
   dMkF/oD2My//D9Q4jsA28/l0WWuLUtSWQ1x/a0TTwRyULwUrcbDxGclcE
   S341d5/WbFvpwhGWYa4Gg7m43G/zxtH19pni2JVrgE/XHBNPXAhs449yP
   c+RjIFW28ZAO4qZBpfiSGHVSnkLuy/eRPZFoaJ13+oR+0fs7DzFhWnV9B
   6t9LGQuTAzAx1BIUjoFro/FEIFKV+RUKRuBpFG1flbZDlNRurKVPxyxyU
   Q==;
X-CSE-ConnectionGUID: DyRDVSy9TN2PGhdXwg28Xw==
X-CSE-MsgGUID: ssjkH76NR5uLSWs/JEZtFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="13175983"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="13175983"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 15:58:36 -0700
X-CSE-ConnectionGUID: rjrUFFKNSJqnN7K5i6dMYA==
X-CSE-MsgGUID: p21KnFsLScOdKMKdvoDMhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31226001"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by fmviesa004.fm.intel.com with ESMTP; 30 Apr 2024 15:58:35 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH] thermal: intel: Add missing module description
Date: Tue, 30 Apr 2024 15:58:25 -0700
Message-ID: <20240430225826.65289-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warnings displayed by "make W=1" build:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/intel_soc_dts_iosf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor

Reported-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c   | 1 +
 .../intel/int340x_thermal/processor_thermal_power_floor.c        | 1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c   | 1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c   | 1 +
 .../thermal/intel/int340x_thermal/processor_thermal_wt_hint.c    | 1 +
 drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c | 1 +
 drivers/thermal/intel/intel_soc_dts_iosf.c                       | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
index 4d3bd32ff9ea..af2ec0beb7a1 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_mbox.c
@@ -156,3 +156,4 @@ int processor_thermal_mbox_interrupt_config(struct pci_dev *pdev, bool enable,
 EXPORT_SYMBOL_NS_GPL(processor_thermal_mbox_interrupt_config, INT340X_THERMAL);
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Processor Thermal Mail Box Interface");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
index a1a108407f0f..d6b787ca2741 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
@@ -124,3 +124,4 @@ EXPORT_SYMBOL_NS_GPL(proc_thermal_power_floor_intr_callback, INT340X_THERMAL);
 
 MODULE_IMPORT_NS(INT340X_THERMAL);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Processor Thermal power floor notification Interface");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index e964a9375722..e9aa9e23aab9 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -133,3 +133,4 @@ void proc_thermal_rapl_remove(void)
 EXPORT_SYMBOL_GPL(proc_thermal_rapl_remove);
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("RAPL interface using MMIO");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
index 546b70434004..e56db75a94fb 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rfim.c
@@ -384,3 +384,4 @@ void proc_thermal_rfim_remove(struct pci_dev *pdev)
 EXPORT_SYMBOL_GPL(proc_thermal_rfim_remove);
 
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Processor Thermal RFIM Interface");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
index 9d5e4c169d1b..e947d84f4977 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_hint.c
@@ -253,3 +253,4 @@ EXPORT_SYMBOL_NS_GPL(proc_thermal_wt_hint_remove, INT340X_THERMAL);
 
 MODULE_IMPORT_NS(INT340X_THERMAL);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Processor Thermal Work Load type hint Interface");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
index 711c4f761c9a..f298e7442662 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_wt_req.c
@@ -134,3 +134,4 @@ EXPORT_SYMBOL_GPL(proc_thermal_wt_req_remove);
 
 MODULE_IMPORT_NS(INT340X_THERMAL);
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Processor Thermal Work Load type request Interface");
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 2ab943b66f7a..7adf942665d4 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -387,3 +387,4 @@ EXPORT_SYMBOL_GPL(intel_soc_dts_iosf_exit);
 
 MODULE_IMPORT_NS(INTEL_TCC);
 MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("SoC DTS driver using side band interface");
-- 
2.44.0


