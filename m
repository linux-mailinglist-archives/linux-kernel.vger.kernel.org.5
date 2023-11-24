Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED037F8506
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346130AbjKXUDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346009AbjKXUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:03:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1314910F0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700856188; x=1732392188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aWAES+X/gzWAf5tameCWgEEuMqs70/3z8X4l0rA0DAY=;
  b=A6P2SMjIsyRusVozu3sTtKwbw4QgMTdu8ZivmCg6s6+tWf/IvjseAP50
   v+fkygbd8pOarvowIHZV1OLcPWpSVlPz98YrgrguwxEYOx2tIUdxJss8C
   mvpHqnNZ8KDUOLAuw/341oYZUNxgbY5QQ4oQBgisK32lNryrrA9OiOg3Q
   r9mbBHBtm7bHXjorWJ31f8F15kH2B8Vgzi77P9sh9uxFQ6Q5i2qr7XtqJ
   W5xYb15h3k0ukc4+Fyit6QDtY5kCpqlGFgk/dUj0/hN9+uYmC5+jBvTW3
   zXvsA7WFPRmM93eaSMd+zqs5gFjwcfSzijCoiQrZRz/n98e0PoOsy8By0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="391338134"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="391338134"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 12:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="1014983741"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="1014983741"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Nov 2023 12:03:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B2674387; Fri, 24 Nov 2023 22:03:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>
Subject: [PATCH v1 3/5] mfd: intel-lpss: Adjust header inclusions
Date:   Fri, 24 Nov 2023 21:31:26 +0200
Message-ID: <20231124200258.3682979-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
References: <20231124200258.3682979-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust header inclusions to avoid "proxy" headers and explicitly
include what we are using.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-acpi.c |  6 +++++-
 drivers/mfd/intel-lpss-pci.c  |  8 ++++++--
 drivers/mfd/intel-lpss.c      | 17 ++++++++++++-----
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/intel-lpss-acpi.c b/drivers/mfd/intel-lpss-acpi.c
index bba208235754..e4a62cc02cfc 100644
--- a/drivers/mfd/intel-lpss-acpi.c
+++ b/drivers/mfd/intel-lpss-acpi.c
@@ -8,15 +8,19 @@
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
+#include <linux/device.h>
+#include <linux/gfp_types.h>
 #include <linux/ioport.h>
-#include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+
 #include <linux/pxa2xx_ssp.h>
 
+#include <asm/errno.h>
+
 #include "intel-lpss.h"
 
 static const struct property_entry spt_spi_properties[] = {
diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 94042bfe7dbf..bc15379afe3b 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -8,14 +8,18 @@
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
-#include <linux/ioport.h>
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/gfp_types.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+
 #include <linux/pxa2xx_ssp.h>
 
+#include <asm/errno.h>
+
 #include "intel-lpss.h"
 
 /* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index bbd65da46db6..79ea5e2ad0a6 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -10,26 +10,33 @@
  *          Jarkko Nikula <jarkko.nikula@linux.intel.com>
  */
 
-#include <linux/clk.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/clkdev.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gfp_types.h>
 #include <linux/idr.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/mfd/core.h>
+#include <linux/module.h>
 #include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
-#include <linux/property.h>
-#include <linux/seq_file.h>
+#include <linux/sprintf.h>
+#include <linux/types.h>
+
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 #include <linux/dma/idma64.h>
 
 #include "intel-lpss.h"
 
+struct dentry;
+
 #define LPSS_DEV_OFFSET		0x000
 #define LPSS_DEV_SIZE		0x200
 #define LPSS_PRIV_OFFSET	0x200
-- 
2.43.0.rc1.1.gbec44491f096

