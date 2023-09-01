Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A2D78FE75
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349825AbjIANlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349788AbjIANkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:40:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F0EE7E;
        Fri,  1 Sep 2023 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693575651; x=1725111651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=352rupwp0v18APS/064zEU6rKG+0wRf5vuEg+1M9N+w=;
  b=ClQGSaoEHsh55chbP9snHsIgQ9W4pq5DjVkXwh5ulokmJKkmYXud7VtU
   5nfr9szOzghH/vgv6WhAEgKpumxLL3utSkusW+B6o9DOzhF6RElRuGUo5
   hUhlSmGovs4ea+eegbEta0cwAFVJttJiZbtqSTmqRTLg+NWaeMwRPRS8+
   GagWcVadGMk/DxiV091SI3+itBuTzegOWWKTQ9EYziyVQwUd3RzYCWycC
   au9g0oc4sQwbfBjJUhygk4xv9qnMpiZE0uKd2Xg0FwwqEwduRN2SM2Nky
   2Uf6Anb7GPyceBEUzzkQaSEPhXtcx+OJi+bMnIchM+wo5CD+8yryYet0D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373617950"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="373617950"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 06:40:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="986684302"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="986684302"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 01 Sep 2023 06:40:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 636B2899; Fri,  1 Sep 2023 16:40:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 10/10] gpio: pca953x: Revisit header inclusions
Date:   Fri,  1 Sep 2023 16:40:41 +0300
Message-Id: <20230901134041.1165562-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the headers are not use, some are missing. Fix that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pca953x.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 16f5e3043bf0..b0d768ebf21d 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -8,23 +8,30 @@
  *  Derived from drivers/i2c/chips/pca9539.c
  */
 
-#include <linux/acpi.h>
+#include <linux/atomic.h>
 #include <linux/bitmap.h>
 #include <linux/cleanup.h>
-#include <linux/gpio/consumer.h>
-#include <linux/gpio/driver.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
-#include <linux/platform_data/pca953x.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 
-#include <asm/unaligned.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/driver.h>
+
+#include <linux/pinctrl/pinconf-generic.h>
+
+#include <linux/platform_data/pca953x.h>
 
 #define PCA953X_INPUT		0x00
 #define PCA953X_OUTPUT		0x01
@@ -119,6 +126,7 @@ MODULE_DEVICE_TABLE(i2c, pca953x_id);
 
 #ifdef CONFIG_GPIO_PCA953X_IRQ
 
+#include <linux/acpi.h>
 #include <linux/dmi.h>
 
 static const struct acpi_gpio_params pca953x_irq_gpios = { 0, 0, true };
-- 
2.40.0.1.gaa8946217a0b

