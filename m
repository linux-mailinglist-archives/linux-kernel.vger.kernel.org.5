Return-Path: <linux-kernel+bounces-163150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5EB8B6661
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5741F22BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D569819DF5E;
	Mon, 29 Apr 2024 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIHRtSqt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2F194C99;
	Mon, 29 Apr 2024 23:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714433714; cv=none; b=We6EDEBBEyPEwzpDO29WqqpsaaVDH5MdYfi9dVdElQG3z9QuFnGJpEzKR+VU/1+xEp0zS2tKZRqU0xccOGcC3+1zJmRz1/eQrihxshZxHa1/RasGM8tfWYqUkh/TItQ1rTAUsUo5Iz1h4r7avmUmAWbk5ItSHK01o2zXZPQpGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714433714; c=relaxed/simple;
	bh=lzO2e+Oo+4UfllUX+wCgOchpiGEB/1rygV2TaWXK7hA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BDsyeQlhUgYRQ8nR3+hMnStu6OJNFEbVRIQJq9+nhTKoAgJ7AM3ihbT/+pfsIYoLLEX1R5NFSa2sL1PJ5qe+Q8rXkTI7h3PVdpS+j5HB37oDh9Bg5HLvUGEElycc5ZfX8Mo9nNNF+sBKxjPjCZSZHDD++qGwqI08zU0h3rEINuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIHRtSqt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714433713; x=1745969713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lzO2e+Oo+4UfllUX+wCgOchpiGEB/1rygV2TaWXK7hA=;
  b=nIHRtSqt07gKf94rqPaz/U3c1FbwIoCJaS33t5Nfa36ZyEltubE7vew0
   kKiEGuSBB1Kb9wpL7Nu8ifZbjaU1uo8W41mLLPFAE1kRlUjwkb7qd+3xA
   RwWo8JWLR9HKZfH5As572LnmPx9Gn0SzcQ/MgDUuswYEj8N+MN1toxlAI
   YZXHhKPZMDhX6lj9mJiB5mCGIz/o4z6tv42hz380cLCsthjRVb4nqEVMU
   6seATVKfJnDitVkAJrDM2ozgMP60q52Xx5VlyYUFl9ihLx5H/SG7fG0wl
   YTOZ8sv4nbcNSR5tVgIEkFEt6MZbVAZpfyy3RmG03UNwVfa/t/X6rUhvp
   Q==;
X-CSE-ConnectionGUID: QQHyUoFDRryiJCQeJLUUcQ==
X-CSE-MsgGUID: vxa8zuiJT0e1WQPNrcrzfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10274509"
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="10274509"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 16:35:09 -0700
X-CSE-ConnectionGUID: WEkgMhMWQbGf7gLBE2hEGw==
X-CSE-MsgGUID: x8CDHq49Qs2OawCtBg6sYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,240,1708416000"; 
   d="scan'208";a="26200136"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa009.fm.intel.com with ESMTP; 29 Apr 2024 16:35:08 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <len.brown@intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 2/4] thermal: intel: hfi: Tune the HFI thermal netlink event delay via debugfs
Date: Mon, 29 Apr 2024 16:41:50 -0700
Message-Id: <20240429234152.16230-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
References: <20240429234152.16230-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

THe delay between an HFI interrupt and its corresponding thermal netlink
event has so far been hard-coded to CONFIG_HZ jiffies. This may not suit
the needs of all hardware configurations or listeners of events.

If the update delay is too long, much of the information of consecutive
hardware updates will be lost as the HFI delayed workqueue posts a new
thermal netlink event only when there are no previous pending events. If
the delay is too short, multiple, events may overwhelm listeners.

Listeners are better placed to determine the delay of events. They know how
quickly they can act on them effectively. They may also want to experiment
with different values.

Start a debugfs interface to tune the notification delay.

Keep things simple and do not add extra locking or memory barriers. This
may result in the HFI interrupt ocassionally queueing work using stale
delay values, if at all. This should not be a problem: the debugfs file
will update the delay value atomically, we do not expect users to update
the delay value frequently, and the delayed workqueue operates in jiffies
resolution.

Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Len Brown <len.brown@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/intel/intel_hfi.c | 77 ++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
index e2b82d71ab6b..24d708268c68 100644
--- a/drivers/thermal/intel/intel_hfi.c
+++ b/drivers/thermal/intel/intel_hfi.c
@@ -43,6 +43,10 @@
 
 #include <asm/msr.h>
 
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
+
 #include "intel_hfi.h"
 #include "thermal_interrupt.h"
 
@@ -169,6 +173,70 @@ static struct workqueue_struct *hfi_updates_wq;
 #define HFI_UPDATE_DELAY		HZ
 #define HFI_MAX_THERM_NOTIFY_COUNT	16
 
+/* Keep this variable 8-byte aligned to get atomic accesses. */
+static unsigned long hfi_update_delay = HFI_UPDATE_DELAY;
+
+#ifdef CONFIG_DEBUG_FS
+static int hfi_update_delay_get(void *data, u64 *val)
+{
+	mutex_lock(&hfi_instance_lock);
+	*val = jiffies_to_msecs(hfi_update_delay);
+	mutex_unlock(&hfi_instance_lock);
+	return 0;
+}
+
+static int hfi_update_delay_set(void *data, u64 val)
+{
+	/*
+	 * The mutex only serializes access to the debugfs file.
+	 *
+	 * hfi_process_event() loads @hfi_update_delay from interrupt context.
+	 * We could have serialized accesses with a spinlock or a memory barrier.
+	 * But this is a debug feature, the store of @hfi_update_delay is
+	 * atomic, and will seldom change. A few loads of @hfi_update_delay may
+	 * see stale values but the updated value will be seen eventually.
+	 */
+	mutex_lock(&hfi_instance_lock);
+	hfi_update_delay = msecs_to_jiffies(val);
+	mutex_unlock(&hfi_instance_lock);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(hfi_update_delay_fops, hfi_update_delay_get,
+			 hfi_update_delay_set, "%llu\n");
+
+static struct dentry *hfi_debugfs_dir;
+
+static void hfi_debugfs_unregister(void)
+{
+	debugfs_remove_recursive(hfi_debugfs_dir);
+	hfi_debugfs_dir = NULL;
+}
+
+static void hfi_debugfs_register(void)
+{
+	struct dentry *f;
+
+	hfi_debugfs_dir = debugfs_create_dir("intel_hfi", NULL);
+	if (!hfi_debugfs_dir)
+		return;
+
+	f = debugfs_create_file("update_delay_ms", 0644, hfi_debugfs_dir,
+				NULL, &hfi_update_delay_fops);
+	if (!f)
+		goto err;
+
+	return;
+err:
+	hfi_debugfs_unregister();
+}
+
+#else
+static void hfi_debugfs_register(void)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static void get_hfi_caps(struct hfi_instance *hfi_instance,
 			 struct thermal_genl_cpu_caps *cpu_caps)
 {
@@ -321,8 +389,13 @@ void intel_hfi_process_event(__u64 pkg_therm_status_msr_val)
 	raw_spin_unlock(&hfi_instance->table_lock);
 	raw_spin_unlock(&hfi_instance->event_lock);
 
+	/*
+	 * debugfs may atomically store @hfi_update_delay without locking. The
+	 * updated value may not be immediately observed. See note in
+	 * hfi_update_delay_set().
+	 */
 	queue_delayed_work(hfi_updates_wq, &hfi_instance->update_work,
-			   HFI_UPDATE_DELAY);
+			   hfi_update_delay);
 }
 
 static void init_hfi_cpu_index(struct hfi_cpu_info *info)
@@ -708,6 +781,8 @@ void __init intel_hfi_init(void)
 
 	register_syscore_ops(&hfi_pm_ops);
 
+	hfi_debugfs_register();
+
 	return;
 
 err_nl_notif:
-- 
2.34.1


