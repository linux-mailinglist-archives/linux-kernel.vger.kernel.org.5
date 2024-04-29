Return-Path: <linux-kernel+bounces-163151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F78B6664
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439681C22275
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006F71A0AE5;
	Mon, 29 Apr 2024 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsvmkLoU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835E199EB9;
	Mon, 29 Apr 2024 23:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433715; cv=none; b=o9+DHBBgRVkSXNDxjjHaRQNPQbQilg7Z3B4mTS4iHONFrPL8dBBfKnMYW/BLslo4YB550V+H8tFHKKbf3ICCu6/Mv9qc8gh2tWBjzdCYNx3g8o+s0qvQrsZG73zGkVdw7P286l5BzkalJzB2RN9t0JvTFMFXbcaQqh9QmuigTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433715; c=relaxed/simple;
	bh=U0zOPBg06/Ek10lV/P5KRW59pMlND6/3ke+JnVTjiek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Hu7pgLBPMx+JnQosvgivoGDk6HqSKrlHzQn6mtFuXsRIP8nsB3LwOamxyTrwUJV9Wnkulf9ST3K4MXgwj5uXTXAl3jBxV+gOQDek+UB3913gd0Uu06/p0+zjvsHERZ8L0kX8JtZNnT97XFfZc6GQvqoxHpL6lZ8uY3IH8H5V4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsvmkLoU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433714; x=1745969714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=U0zOPBg06/Ek10lV/P5KRW59pMlND6/3ke+JnVTjiek=;
  b=DsvmkLoUWoAqDowigSrM7YBPO68e/xZTESeM6VKbYvKC3dQjk0H1Xe7/
   wvjHC+b1HhjA8UdgU4YHN1DLX+87P42PDggmg2CCRgdZJmeL+y2VGPt2I
   pLZ7SqVVtvPO8EZfsD5bDdY57E20ZRUejEJYXZI/RqXZruhqO8XxcTcqz
   LKvhvEBHcgAWfFbH4hOddSonDnaUWMobvq30vLE4JtEP7ofczY7plSo5V
   0eSSCP+SF3VyGdKNWtiInlLkq1pZc6Ms0a65tczA36LTSMNdbN5Maheiu
   8VCpm6oroOULRtq6ElHiGUxqP9G/QXXVrY2k00g8SMGbA6vtolpXbn5Tc
   A==;
X-CSE-ConnectionGUID: ZuArEuUlRUKHquD1ynocFg==
X-CSE-MsgGUID: ON+c4UCGTleTO/I97FhJwA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10274511"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10274511"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:35:09 -0700
X-CSE-ConnectionGUID: oNC+hNXiSnCIa+eGtRA/Zg==
X-CSE-MsgGUID: E1i4qlq/QSiv4RamYiSiJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26200139"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 16:35:09 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 3/4] thermal: intel: hfi: Rename HFI_MAX_THERM_NOTIFY_COUNT
Date: Mon, 29 Apr 2024 16:41:51 -0700
Message-Id: <20240429234152.16230-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
References: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When processing a hardware update, HFI generates as many thermal netlink
events as needed to relay all the updated CPU capabilities to user space.
The constant HFI_MAX_THERM_NOTIFY_COUNT is the number of CPU capabilities
updated per each of those events.

Give this constant a more descriptive name.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/intel/intel_hfi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index 24d708268c68..d6d3544509fc 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -171,7 +171,7 @@ static DEFINE_MUTEX(hfi_instance_lock);
 
 static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_DELAY		HZ
-#define HFI_MAX_THERM_NOTIFY_COUNT	16
+#define HFI_THERMNL_CAPS_PER_EVENT	16
 
 /* Keep this variable 8-byte aligned to get atomic accesses. */
 static unsigned long hfi_update_delay = HFI_UPDATE_DELAY;
@@ -286,14 +286,14 @@ static void update_capabilities(struct hfi_instance *hfi_instance)
 
 	get_hfi_caps(hfi_instance, cpu_caps);
 
-	if (cpu_count < HFI_MAX_THERM_NOTIFY_COUNT)
+	if (cpu_count < HFI_THERMNL_CAPS_PER_EVENT)
 		goto last_cmd;
 
-	/* Process complete chunks of HFI_MAX_THERM_NOTIFY_COUNT capabilities. */
+	/* Process complete chunks of HFI_THERMNL_CAPS_PER_EVENT capabilities. */
 	for (i = 0;
-	     (i + HFI_MAX_THERM_NOTIFY_COUNT) <= cpu_count;
-	     i += HFI_MAX_THERM_NOTIFY_COUNT)
-		thermal_genl_cpu_capability_event(HFI_MAX_THERM_NOTIFY_COUNT,
+	     (i + HFI_THERMNL_CAPS_PER_EVENT) <= cpu_count;
+	     i += HFI_THERMNL_CAPS_PER_EVENT)
+		thermal_genl_cpu_capability_event(HFI_THERMNL_CAPS_PER_EVENT,
 						  &cpu_caps[i]);
 
 	cpu_count = cpu_count - i;
-- 
2.34.1


