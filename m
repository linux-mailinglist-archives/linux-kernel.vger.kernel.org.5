Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82E7F1565
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbjKTONO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjKTONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:13:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F9DA0;
        Mon, 20 Nov 2023 06:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700489587; x=1732025587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XKZFQUi+U4ersNqM4YmQM70MnyE4Os/TQpc7j9Ab95o=;
  b=iO19RStEWjyQLAwIbTLZEi7AOOE4fHs1zJvBjy5sUCbH5AH+5KktXaSm
   Y7SJzDPSMDuC2qf0xiDtVR/Gq0AVUCv2wjEyN22RRB0nI2Cu5tlr92gBv
   bVL9HOjngVvrRsPGUwmyfQGFM0dbNsofAuN4rpOYbc+RKuWR0ge7S8UVi
   At3/LhgF238bvxXwQ1gcSGp4AR/YpNZTA3X8yLLmJ0kCKG0Gg5YYddUXU
   olmlHWz7ExltKUGiUNQKtxiE/tlrhGRm/p8BqSWyOJbl15YTbRDtjtVar
   QeQkM+w7sW0DTPPYV83TM+ZgVZrcXtw6OAPGeowQ6S0sATogxUJ32bOIf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458121755"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="458121755"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 06:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801184239"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="801184239"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2023 06:12:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3DA4E4F8; Mon, 20 Nov 2023 16:12:33 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH v2 4/4] EDAC, pnd2: Sort headers alphabetically
Date:   Mon, 20 Nov 2023 16:10:48 +0200
Message-ID: <20231120141231.1638240-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
References: <20231120141231.1638240-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the headers in alphabetic order in order to ease
the maintenance for this part.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tag (Qiuxu) 

 drivers/edac/pnd2_edac.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
index 969fb2465edb..2afcd148fcf8 100644
--- a/drivers/edac/pnd2_edac.c
+++ b/drivers/edac/pnd2_edac.c
@@ -16,19 +16,20 @@
  * rank, bank, row and column using the appropriate "dunit_ops" functions/parameters.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <linux/pci_ids.h>
-#include <linux/slab.h>
+#include <linux/bitmap.h>
 #include <linux/delay.h>
 #include <linux/edac.h>
-#include <linux/mmzone.h>
-#include <linux/sizes.h>
-#include <linux/smp.h>
-#include <linux/bitmap.h>
+#include <linux/init.h>
 #include <linux/math64.h>
+#include <linux/mmzone.h>
 #include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/smp.h>
+
 #include <linux/platform_data/x86/p2sb.h>
 
 #include <asm/cpu_device_id.h>
-- 
2.43.0.rc1.1.gbec44491f096

