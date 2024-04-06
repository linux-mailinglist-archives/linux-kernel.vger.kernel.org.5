Return-Path: <linux-kernel+bounces-133747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C5B89A808
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 02:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B15A1F23D6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7581BC46;
	Sat,  6 Apr 2024 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1yIZBdG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F8EEB3;
	Sat,  6 Apr 2024 00:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365097; cv=none; b=rXmNcE/SWbdeX81V+qJ754O4cYsWCRLLszTUj6V8x91lqmGm8hwPSM0yzbhgj01IjdwhLECQ0ouVA/HGyJQilaE2IVqAqnzP606Y4x5WGNLizeeFLNUmYw6w/pYc1/HfJ5yvIp/S7dpEX+75xzTbRqwomaM2XJ2/5Apeh3m0fhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365097; c=relaxed/simple;
	bh=LvJf7IpSrSk0ODEovUEZymwOVnvp4IWE/x7bmgvJpPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U+fOkC29Vuns77v3UKs5A1flwKDO/R451LNe1iPUmY5ZmkTB4oPXd+GwmC+1j9FRurTmRIi6UNZuhrjHjxM2SqjbeoANxeigV6aqXnKgosyHcxA6MVybIvNHp7bGihVaejROyUNmsVDy0iG7U8ntPiKUAe7joG0Wf6UB9XXVulI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1yIZBdG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712365096; x=1743901096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LvJf7IpSrSk0ODEovUEZymwOVnvp4IWE/x7bmgvJpPE=;
  b=K1yIZBdG+7sjaUxlEtCVrl/Jd9PdI9efY/1LbaDTQ28msICnTRK9I3S3
   wkE8P1uXl8h/xtSg00C8u9h75ff/cIrczBa7bE3AIYEuza5iblNGHaVQM
   Cr6atgtxrWYPt8ceGjebeUgLVEEvkC4O93hj2VKEHQfkVfMwO0TFIEwQS
   w3TwPvGKm9YankUjsoRJhtWJbidjiaQ6HgWOC5IZMcPTV3GrPsgVOkUyr
   DCRIlEu1B7Ci7pOJ8Hhdgu8T6z5RXSdoUz6ipl4b1YSx6TJvUbgenSC6g
   cfsKneobfK/2NYLhkFSZvjMg8ka2pBhqAzJBPuGXR3eZRnMgpuO/NynFx
   w==;
X-CSE-ConnectionGUID: /9cJtAYFSG+8mHGkSNXjRA==
X-CSE-MsgGUID: m7LQNKegR8aYfHo8NTTxVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="25153884"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="25153884"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 17:58:12 -0700
X-CSE-ConnectionGUID: pysUpNznTUKUAfBlXx2RyQ==
X-CSE-MsgGUID: xTKN75TDQoyumuzIHGfrAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19252369"
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
Subject: [PATCH 3/3] hwmon: (coretemp) Use a model-specific bitmask to read registers
Date: Fri,  5 Apr 2024 18:04:16 -0700
Message-Id: <20240406010416.4821-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
References: <20240406010416.4821-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The Intel Software Development manual defines states the temperature
digital readout as the bits [22:16] of the IA32_[PACKAGE]_THERM_STATUS
registers. In recent processor, however, the range is [23:16]. Use a
model-specific bitmask to extract the temperature readout correctly.

Instead of re-implementing model checks, extract the correct bitmask
using the intel_tcc library. Add an 'imply' weak reverse dependency on
CONFIG_INTEL_TCC. This captures the dependency and lets user to unselect
them if they are so inclined. In such case, the bitmask used for the
digital readout is [22:16] as specified in the Intel Software Developer's
manual.

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
 drivers/hwmon/Kconfig    | 1 +
 drivers/hwmon/coretemp.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 83945397b6eb..11d72b3009bf 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -847,6 +847,7 @@ config SENSORS_I5500
 config SENSORS_CORETEMP
 	tristate "Intel Core/Core2/Atom temperature sensor"
 	depends on X86
+	imply INTEL_TCC
 	help
 	  If you say yes here you get support for the temperature
 	  sensor inside your CPU. Most of the family 6 CPUs
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 616bd1a5b864..5632e1b1dfb1 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -17,6 +17,7 @@
 #include <linux/sysfs.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/intel_tcc.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/platform_device.h>
@@ -404,6 +405,8 @@ static ssize_t show_temp(struct device *dev,
 	tjmax = get_tjmax(tdata, dev);
 	/* Check whether the time interval has elapsed */
 	if (time_after(jiffies, tdata->last_updated + HZ)) {
+		u32 mask = intel_tcc_get_temp_mask(is_pkg_temp_data(tdata));
+
 		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
 		/*
 		 * Ignore the valid bit. In all observed cases the register
@@ -411,7 +414,7 @@ static ssize_t show_temp(struct device *dev,
 		 * Return it instead of reporting an error which doesn't
 		 * really help at all.
 		 */
-		tdata->temp = tjmax - ((eax >> 16) & 0x7f) * 1000;
+		tdata->temp = tjmax - ((eax >> 16) & mask) * 1000;
 		tdata->last_updated = jiffies;
 	}
 
@@ -838,4 +841,5 @@ module_exit(coretemp_exit)
 
 MODULE_AUTHOR("Rudolf Marek <r.marek@assembler.cz>");
 MODULE_DESCRIPTION("Intel Core temperature monitor");
+MODULE_IMPORT_NS(INTEL_TCC);
 MODULE_LICENSE("GPL");
-- 
2.34.1


