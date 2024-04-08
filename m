Return-Path: <linux-kernel+bounces-134764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A272989B698
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432451F223A7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D876FB6;
	Mon,  8 Apr 2024 03:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJcZAU4a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9A187F;
	Mon,  8 Apr 2024 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712548317; cv=none; b=C32MYqaruNylijMj169odAb766KRZ810OX3FwZ3Rd8AoBWjBY4NvGzZIZmY6xKf5YssxeUV35MiADeSMEqB/V1H/2flHHdzA0LwUa2Zj2dEO1cZOYBEHAQpzrkr+gGlzKGufunRIh4l2/6mxpAwSSKIbQSKXIXbhgwE+nYsAErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712548317; c=relaxed/simple;
	bh=j379rSTUR0Ce5ip59QtuRg1bNWYwoLOMVJkQdI+EU2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eS5u5cfzHhXqNRv5S06o1y0vkDLViyd9ERWM3P3QkrMYBO5r+QH3/L+w8RutmeL8RaHxYtvsjn7Dwv5Kowj6f0sVisqdQxNzHCw7nqLjv0OeDP7XK5HmtiLVANaZ4FajeVmMkY1kcXVkg3lrbNMKBTVwLa2vNJPCniNtfQDm4tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJcZAU4a; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712548316; x=1744084316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j379rSTUR0Ce5ip59QtuRg1bNWYwoLOMVJkQdI+EU2M=;
  b=lJcZAU4am8zl0PSKh3AW0zbcwR9AnYHNQRpbtrv7Lqf9fSnhKcHYvoOq
   EPQsZggJlm2vgwAIOrjhn/ZkWcYi26//onShNTrBivnKyhUSik4LfAz8m
   MXvbgYAYR9xSVcaeK4vd/PY7Gyoc0Rxj49YvVECMlaz099175cHcsVxCL
   bBNJP4zqDs45Fi/e/Taf2BBm0N1m8xSh7aQFwFqdKmBVGhK/H/PQZ3RCu
   nKZA31SOy7k2/IrnwdDJ+nWHehFoJTpzgoAmDcPJX0x2Z5enkDrvTzVRA
   iLlY1h7OeU6GiEDambWLNaPA6sEaD/Y4yDYX5EsjTBnkJsjv7f9i2x7FN
   g==;
X-CSE-ConnectionGUID: 5Z27K2KSRAqcrg9C0hftZg==
X-CSE-MsgGUID: zmldObq/R9q2TiNEWnMv2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="7909940"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="7909940"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:51:56 -0700
X-CSE-ConnectionGUID: W3Xp7JebTiGXPetE2bWBPg==
X-CSE-MsgGUID: OSYQHC+sRryAUR9iSa0Hsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19870362"
Received: from lihon19x-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.173.91])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 20:51:53 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH V2 1/3] powercap: intel_rapl: Sort header files
Date: Mon,  8 Apr 2024 11:51:39 +0800
Message-Id: <20240408035141.248644-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240408035141.248644-1-rui.zhang@intel.com>
References: <20240408035141.248644-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort header files alphabetically.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_common.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index a28d54fd5222..1f4a7aa12d77 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -5,27 +5,27 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bitmap.h>
 #include <linux/cleanup.h>
+#include <linux/cpu.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/intel_rapl.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/list.h>
-#include <linux/types.h>
-#include <linux/device.h>
-#include <linux/slab.h>
 #include <linux/log2.h>
-#include <linux/bitmap.h>
-#include <linux/delay.h>
-#include <linux/sysfs.h>
-#include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/powercap.h>
-#include <linux/suspend.h>
-#include <linux/intel_rapl.h>
 #include <linux/processor.h>
-#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
-#include <asm/iosf_mbi.h>
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
+#include <asm/iosf_mbi.h>
 
 /* bitmasks for RAPL MSRs, used by primitive access functions */
 #define ENERGY_STATUS_MASK      0xffffffff
-- 
2.34.1


