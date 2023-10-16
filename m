Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6898C7CA8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjJPNKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjJPNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27247F7;
        Mon, 16 Oct 2023 06:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461789; x=1728997789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ycKEu6aIli6lxZMS9klc458Zt4d5Yco6j3mjsSXjEcE=;
  b=ZVx5nvbD8G2ZM6GvG/c6x5y0hrQHWEMNohBnpmt2pr3LIHzyffSdZrjy
   FfQysvRwbfqk3x2FjkWxFmACmkclz7PjW7g7iEglgdvflMSpGSestubkR
   ZT/wnekmrhuVL/7YMJcSZqsf1d2SKtLB+tq87/RIP1l9FHicchk1JcUH3
   7uWVLhkUhuE2OM3B6jlcVrhOMIOMIW2KvhrmRp3xYHWA4RW/ohtGgsQsF
   QFL5Glw+mRlXpkqWp/pxv2e8b29f3wJQ67ZzYoImOPUjVk2Ox9FvXpefe
   4ga1TB74viVA2+buTcSnVPtjQ5l4da5jF2rwLXwvuoJTzoL6ROPtwmku3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="416590166"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="416590166"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="759385522"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="759385522"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 16 Oct 2023 06:09:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 626A9BC2; Mon, 16 Oct 2023 16:09:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 10/10] xhci: dbc: Add missing headers
Date:   Mon, 16 Oct 2023 16:09:34 +0300
Message-Id: <20231016130934.1158504-11-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
References: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't inherit headers "by chances" from asm/bug.h, asm/io.h,
etc... Include the needed headers explicitly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 73494d55b0be..d82935d31126 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -6,9 +6,24 @@
  *
  * Author: Lu Baolu <baolu.lu@linux.intel.com>
  */
+#include <linux/bug.h>
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
-#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/kstrtox.h>
+#include <linux/list.h>
 #include <linux/nls.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+#include <linux/io-64-nonatomic-lo-hi.h>
+
+#include <asm/byteorder.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
-- 
2.40.0.1.gaa8946217a0b

