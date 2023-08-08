Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDE37747A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjHHTRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjHHTQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:16:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73EA3A6B7;
        Tue,  8 Aug 2023 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512773; x=1723048773;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/xmEuNUa1F857kBIWG/rzmWse5hqaes6dViG2uDIUl0=;
  b=J3jBeuW9rm0HpbuAS/TBiGYNp6NaWkepve69CycYiImqgbars7sYNCjq
   TuFsmWQO0lRWo0i89R9BfVFMrjUIG+duZVMhlVv3mgNYMeW7NLHaZxbUZ
   Rgqbwqvgn8OwA+VfPJFFeNSf4f/3vDOxJWIeQfr99GIx1M2alIKmikSz6
   64ZNvc9JDwi0dxDZ201vyG7GdmsJGIq5mqjsP3B+DLZxOlBdh0B1afYQw
   UUx0mDcN4q6/HE8B7Xi3q1cOZ5mXxrImyVdAG8g/ROXj8HOtAsbwrbWV4
   6WzZzRJ4/YXi5x1OSs9U2B879fr9r+p9wNMohoIQn8GFnqKttTCK56GpH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369777246"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="369777246"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:38:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="734623035"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="734623035"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Aug 2023 09:38:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A8B515C; Tue,  8 Aug 2023 19:41:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH v1 1/1] iio: dac: stm32-dac: Use correct header(s) instead of string_helpers.h
Date:   Tue,  8 Aug 2023 19:41:37 +0300
Message-Id: <20230808164137.66663-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing from string_helpers.h used in the driver, correct
the header inclusion block accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/dac/stm32-dac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 15eb44075107..3cab28c7ee3b 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -11,12 +11,13 @@
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/string_helpers.h>
+#include <linux/string_choices.h>
 
 #include "stm32-dac-core.h"
 
-- 
2.40.0.1.gaa8946217a0b

