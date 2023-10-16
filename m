Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E257CAEA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjJPQLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbjJPQLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:11:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C78AD56;
        Mon, 16 Oct 2023 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697472658; x=1729008658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YUkxCSHEq/3rOrfuT0Fg4DI7Hj9/49mwADVgWbNCxXM=;
  b=cVj697GdHtSBBYSmilaMSM9/h6D4j+erxXqGAXQmtopyenkoDo2pzX9/
   J+0HhVJ1anSDYgaqvoz2/98mKksvXyzpIcjs9GHt+zeaUgBHcAXRjleI7
   DsIpUMu1TRka2M7uAUAAFk7cwE65ty1cNRGRrx1xZ1WM0InPlWiFzpaKM
   1xQI+abtg4UAy54tdOrjPEb5BavkyLojTzArkqwrvVidp2HYSEhtIedTF
   JcL50o5lhO38Q7BL+SGKHVSyMF3cVBtmwJ2+S31YKVMY/AJeBW8o2oGA9
   K0vdnlyuQlnkRQYEJZaiysr9GPZlao5/Vaaq4hF13Q0oq1903IUCVGoYQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384440997"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="384440997"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 09:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="790856636"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="790856636"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Oct 2023 09:10:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 48A5EA46; Mon, 16 Oct 2023 19:10:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Subject: [PATCH v1 6/6] leds: gpio: Update headers
Date:   Mon, 16 Oct 2023 19:10:05 +0300
Message-Id: <20231016161005.1471768-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
References: <20231016161005.1471768-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include headers which we are direct users of, no need
to have proxies.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/leds/leds-gpio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index d6e8298ffb3e..710c319ad312 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -6,17 +6,21 @@
  * Raphael Assenat <raph@8d.com>
  * Copyright (C) 2008 Freescale Semiconductor, Inc.
  */
+#include <linux/container_of.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/types.h>
+
 #include "leds.h"
 
 struct gpio_led_data {
-- 
2.40.0.1.gaa8946217a0b

