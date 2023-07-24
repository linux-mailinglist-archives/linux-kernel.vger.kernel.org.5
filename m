Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3702675FB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjGXQNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGXQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:13:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFA610DC;
        Mon, 24 Jul 2023 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690215203; x=1721751203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q9NRNMG34ThGTaFRAgzsbGNmmuVIUJha9nRtnT1HMq4=;
  b=K9HjVPwTc4DMYO5Gxvdyzo/w9aT5laYxyPROIhfgPDN/Jsfk5vSNcP22
   nQLeSEZ5FRDuvt2DBQuNHB3MdvQHJY97qIUEgcpOGrq6hC42Ia90OLveJ
   WT8xpbufaP5pSTcvWBm3IurJisI2wCBh1ITPfEul99cvTRTX98z8S1dlQ
   vIrrY32QM4yDs2iGdHo7LHmOk06oZ2O3OoBTyUqfaqMFDKoQOsgJxZ7FL
   3vQWVRXip/g1NmIaJxr9Jc0ss7bqcvoIu5ePtmZdp6+/OYsceod5qmHrf
   NwZAKiXr0bvH6YvBqx83xv3HULRwy7atqrJEZ4YSEguT1oghc69RmJkRR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347089844"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347089844"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 09:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="815884109"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815884109"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 09:13:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71F52195; Mon, 24 Jul 2023 19:13:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v1 1/6] gpio: ge: Add missing header
Date:   Mon, 24 Jul 2023 19:13:15 +0300
Message-Id: <20230724161320.63876-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
References: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing platform_device.h that used to be implied by of_device.h.

While at it, sort headers alphabetically for better maintenance.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: e91d0f05e66a ("gpio: Explicitly include correct DT includes")
Closes: https://lore.kernel.org/r/65b4ac1a-1128-6e2a-92c0-9bbcca4b760a@infradead.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-ge.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ge.c b/drivers/gpio/gpio-ge.c
index 4eecbc862abc..ecadb81ce7f8 100644
--- a/drivers/gpio/gpio-ge.c
+++ b/drivers/gpio/gpio-ge.c
@@ -17,13 +17,14 @@
  * the I/O interrupt controllers mask to stop them propergating
  */
 
-#include <linux/kernel.h>
+#include <linux/gpio/driver.h>
 #include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/gpio/driver.h>
+#include <linux/of_address.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #define GEF_GPIO_DIRECT		0x00
 #define GEF_GPIO_IN		0x04
-- 
2.40.0.1.gaa8946217a0b

