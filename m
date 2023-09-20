Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D99C7A8888
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjITPhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjITPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:37:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E35D3;
        Wed, 20 Sep 2023 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695224212; x=1726760212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lhCDbbz/k3yd5t3lV5B14JBHiXIkpR5x8p+ht093KL4=;
  b=ViJF+hwch/855qxcgFRH/CSQkLmCjDp+9vw+TyXYEK0a5ALl+j9cy+QM
   zxjP8pPrt6xspKDrioJVGjkTc7CJKSZ6CHMB+DSKr1lh4HK7fTXjQoALs
   V+Omn3rosMjfmIRyiLZO9fBuGV8b0EenesqI/Aza6l3UFkuppHVE3vwYI
   n4Gr06gCRZBspmxZEuIIIQIhUgFymegc+4vtsHVn8z6OptYU2G2Fzdj5T
   Y1qob5b2jEUJ8JckIAyHofe6sZJl5oO3ym+4teRqK0nrx9QE9MjhqnzrR
   KqE1I/8xtXdK6GmNbcxRVOXLFKuD7q6V0rBr4oebhgr2km0w+WraQkDTp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359646650"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359646650"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 08:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812196962"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="812196962"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 20 Sep 2023 08:36:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D222178; Wed, 20 Sep 2023 18:36:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v1 1/1] interconnect: imx: Replace inclusion of kernel.h in the header
Date:   Wed, 20 Sep 2023 18:36:45 +0300
Message-Id: <20230920153645.2068193-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

The kernel.h is not used here directly, replace it with proper
set of headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

depends on https://lore.kernel.org/r/20230920153432.2067664-1-andriy.shevchenko@linux.intel.com

 drivers/interconnect/imx/imx.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
index 4ec9bc5f383e..d4d0e9888655 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -11,8 +11,12 @@
 #define __DRIVERS_INTERCONNECT_IMX_H
 
 #include <linux/args.h>
+#include <linux/bits.h>
+#include <linux/types.h>
+
 #include <linux/interconnect-provider.h>
-#include <linux/kernel.h>
+
+struct platform_device;
 
 #define IMX_ICC_MAX_LINKS	4
 
-- 
2.40.0.1.gaa8946217a0b

