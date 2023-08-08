Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4556177459F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjHHSoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHHSn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:43:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC293FD0E;
        Tue,  8 Aug 2023 09:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512780; x=1723048780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hiGQtDujvx9jZiOBlDP88aP5ToGv6i5pFuFnlCfWPcY=;
  b=Km9GNLCOcmGToWjPQJNVMSCh+ir9ZAOAknan1Yh+YPl5JOB1b9KueDi/
   k/KG9Lh1hHHUF60YcAFGxp3HStvrxeQMzTBIGVGnTJO6hXFVBksK1EOnp
   vROCB15b21JTRIpUQ4tywB9igbJ5LjrwCRG4eRdbjxxiBfgaZTff4XMqK
   3WZcSohCdXrvHUYQH1yNDZ8GzjgogdTYbEduFUkdbetUxqvQSAUhjWDRY
   R0r5iA0nKdyYDQj1zrTB4VLcaAyCtKY4nt0XBNPSyJ28IoO3T7S0sO8g0
   AMBbaZ7MQ1vMe5uxwxrCZoWfW3ShFlbpiG53pMwBIG/FjkJFwBdU4R6Fq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="401841237"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="401841237"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681316723"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="681316723"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 09:38:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5B58215C; Tue,  8 Aug 2023 19:42:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: accel: kionix-kx022a: Use correct header(s) instead of string_helpers.h
Date:   Tue,  8 Aug 2023 19:42:04 +0300
Message-Id: <20230808164204.66818-1-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/accel/kionix-kx022a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 4ea3c6718ed4..f164b09520c9 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -15,7 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-#include <linux/string_helpers.h>
+#include <linux/string_choices.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
-- 
2.40.0.1.gaa8946217a0b

