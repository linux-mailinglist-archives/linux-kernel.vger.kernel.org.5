Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEB87D7395
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjJYSuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjJYSue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:50:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF78111;
        Wed, 25 Oct 2023 11:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698259833; x=1729795833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DsRoRBNKoqw/Cc7dTmkqie/fv1TrhPx6ZfTLpdADeQM=;
  b=BQ+akP4gxHkswTNgcXluntrWQ/4GEekGAf0UhauyDzq+86J+BOZ7f5xx
   CvN7Kk46z7OwnjKZQt14kzIZedifL+fvv6Xakpdlr1CbmXwIiu5ro+ec0
   ZVhdPFO0L2tSlczybu9WEliKvKM46fHFwyVoOazZg7kicRNeZJHwmI+f5
   5l5akgILpjSTayBEv7OdbAw465hLDAXUUpQXNzKrR9GyCKAjsUFOy9Olp
   FendhJZV4N2HBqETUIRoi9QdOqTCU9BX8UhaCH0+M+zfRIbP/A+LMtwwz
   mJDFOBDZWyoXLvv6rqB8ky5j/V4J8NiP5a4w8EvirplkhovBxXPbAPfiS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="176173"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="176173"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902642576"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902642576"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2023 11:48:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EABB12F3; Wed, 25 Oct 2023 21:43:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 3/3] gpio: mmio: Clean up headers
Date:   Wed, 25 Oct 2023 21:42:59 +0300
Message-Id: <20231025184259.250588-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a few things done:
- include only the headers we are direct user of
- add missing headers
- group generic headers and subsystem headers
- sort each group alphabetically

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-mmio.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 66308b165a0d..71e1af7c2184 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -40,24 +40,22 @@ o        `                     ~~~~\___/~~~~    ` controller in FPGA is ,.`
  *               `.......````.```
  */
 
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/bug.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/log2.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/gpio/driver.h>
-#include <linux/slab.h>
 #include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/log2.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
-#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <linux/gpio/driver.h>
 
 #include "gpiolib.h"
 
-- 
2.40.0.1.gaa8946217a0b

