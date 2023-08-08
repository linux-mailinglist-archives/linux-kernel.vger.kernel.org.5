Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE64774B7F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjHHUsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjHHUsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:48:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCD73A6A2;
        Tue,  8 Aug 2023 09:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512768; x=1723048768;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tUYyTi27C9U7oBXkmhgDUe3l+COqQEi+8Wl103dDY0U=;
  b=OZT0oeOXipwfakgs20pBHzfR1CZM2zNmcmqLsv7jri+aFo8bPN8MHFpM
   Gi1/A+sl3kHPbp8MuQ5434NhfIyyDGFgaodpH8BL+WBrO926o3VVLi+o3
   JiZKu1AWpDxe+IOobKR+XwuEPphlfz+O2Nu5HeFwzkEyMF39cp0za2JIU
   /89J/Rv7oHwFAiOxZgw/SS0q85e3Lm5B4LoEwA375tA2xrt/XPJvv4Zv+
   qDxSQZZ1bhYyTMzgQkpwMo/dC+jkklaiwVmdzIW2x1P+BysjaEH9H6ydp
   n1hZv2NDmKCTmx2qiN1Bn4joJ6Aw5v8gPi2wIaKZn+o4lK2yl6+76Dy+Y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401841224"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="401841224"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681316520"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="681316520"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 09:38:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B17F815C; Tue,  8 Aug 2023 19:41:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: accel: msa311: Use correct header(s) instead of string_helpers.h
Date:   Tue,  8 Aug 2023 19:41:52 +0300
Message-Id: <20230808164152.66748-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing from string_helpers.h used in the driver, correct
the header inclusion block accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/msa311.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
index 6ddcc3c2f840..b8ddbfd98f11 100644
--- a/drivers/iio/accel/msa311.c
+++ b/drivers/iio/accel/msa311.c
@@ -33,7 +33,7 @@
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/string_helpers.h>
+#include <linux/string_choices.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
-- 
2.40.0.1.gaa8946217a0b

