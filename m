Return-Path: <linux-kernel+bounces-133745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D51F89A803
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B3A1F2352E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB9A125DC;
	Sat,  6 Apr 2024 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UpX3lwKI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80C65695;
	Sat,  6 Apr 2024 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365095; cv=none; b=Ka7WXxIiZ45k8wSo//RlNFOxdew6cGJjyNgnqOKkO1kCb3PVReA1JSkgE7dbL9iMImVludMHpntNs/0vJ6VQmi5/h52rC4QnqysyU/yujLt9Ni8QC9UH4ZAEbYA/Lf0AuolekLy7fogHYwwWl/NMyoRMYvp1CuQbG+N3dA5VDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365095; c=relaxed/simple;
	bh=KCAYWXnfTfIof0z3ccXzlxFYy3XY+yZ85HhlAqLhXHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DtuFOrWCltaBL8uBraJov0nAUeSZYrHDdsYQeS7rYugJ8kMTJlSk8gTy7QQad2yxgrieuKiY6h1H6gQF5UasJRKETkBCcPqLqeswR075qkbey5Jq9aVy0XamZczxtqDdceP+o0wCf2/9ekuNepWEWTvWIwiXNFdPWlKtV047u30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UpX3lwKI; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712365094; x=1743901094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=KCAYWXnfTfIof0z3ccXzlxFYy3XY+yZ85HhlAqLhXHc=;
  b=UpX3lwKIJZMqQu7GEcSBxmHMuP9BMorZ9xz0pcBY+260V3q4uJMYhajt
   xaGkS+ebEViei+JzNYmCrUYMIo07Dem5OjvRINz7NMxuGKYIiMHi8gHUv
   S3oXusRjrKK7HxB+rqLfTcJn+bqZyOT2DKMLTYa972fHSr8gZj2rjwISG
   gq1u/KK0RFsUIzXWL9t2uYyurbFZmvyFZj4GrOUW/mjxmjUojjGNX6o/+
   M22CqUCxPKuLR1W96ksjhDekh8mUj9LWSN5Nl9DyJqUY1pI/2FHZwENaL
   d9lVIW7fjmjEAvGvsFOfCCZZdDUYNCYVdMWSZObzyQiSm4R56Kja0DiGT
   g==;
X-CSE-ConnectionGUID: T8cX7N7wTJexSsaZYiaR8g==
X-CSE-MsgGUID: zP9PIpUyS66hufb1wHwokQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="25153878"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="25153878"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:58:12 -0700
X-CSE-ConnectionGUID: 7oUEoezVS+uoDoEUGK9v7w==
X-CSE-MsgGUID: LIl4jerqRay0FJkOJbMslQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19252366"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP; 05 Apr 2024 17:58:12 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 2/3] thermal: intel: intel_tcc_cooling: Use a model-specific bitmask for TCC offset
Date: Fri,  5 Apr 2024 18:04:15 -0700
Message-Id: <20240406010416.4821-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The TCC offset field in the register MSR_TEMPERATURE_TARGET is not
architectural. The TCC library provides a model-specific bitmask. Use it to
determine the maximum TCC offset.

Suggested-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v6.7+
---
 drivers/thermal/intel/intel_tcc_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
index 6c392147e6d1..308946853cdd 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -20,7 +20,7 @@ static struct thermal_cooling_device *tcc_cdev;
 static int tcc_get_max_state(struct thermal_cooling_device *cdev, unsigned long
 			     *state)
 {
-	*state = 0x3f;
+	*state = get_tcc_offset_mask();
 	return 0;
 }
 
-- 
2.34.1


