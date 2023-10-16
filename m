Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAA87CA8E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbjJPNJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjJPNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:09:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2764510E;
        Mon, 16 Oct 2023 06:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697461788; x=1728997788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VH0RJCsrmhvVcZdnAPlndDrhI1n8zmF4zmgMquI63Ds=;
  b=Sladi6xohBQCxQxU/HD/YCUlSc0Wwm6nTwYn2GyTw+SRLps4Ek6CE7mB
   q/hVrP3JN2IzMXIPHjjCuDFwvkxX+5wXYrG1DvqBdKXHOqzN1SXVv5avk
   XL0aLHosNEPdHMINKuwWmZG74AGPZs0bZ6pa6PgfqrDg/pzUL401hEr8y
   z4C20tW1McB4ilLIIdYlPe88FD7/VWmYd9TulGuodzLuls95aNqGfxVLC
   sjF3Qb7KSGy4nO7/rKplhYmxMcSMQ59MrkAX8EiSWs9Iocmupke9ggFhc
   Tte12cQxIL07+//uvE0Kz8QtmOqlu+Avorhtm0hseGGn+MiRcz9bFeCSq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4133286"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4133286"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 06:09:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1087067129"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1087067129"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 06:09:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 29235988; Mon, 16 Oct 2023 16:09:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 04/10] xhci: dbc: Use ATTRIBUTE_GROUPS()
Date:   Mon, 16 Oct 2023 16:09:28 +0300
Message-Id: <20231016130934.1158504-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
References: <20231016130934.1158504-1-andriy.shevchenko@linux.intel.com>
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

Embrace ATTRIBUTE_GROUPS() to avoid boiler plate code.
This should not introduce any functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index df14e336370d..660e3ee31dc6 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -1123,7 +1123,7 @@ static DEVICE_ATTR_RW(dbc_idProduct);
 static DEVICE_ATTR_RW(dbc_bcdDevice);
 static DEVICE_ATTR_RW(dbc_bInterfaceProtocol);
 
-static struct attribute *dbc_dev_attributes[] = {
+static struct attribute *dbc_dev_attrs[] = {
 	&dev_attr_dbc.attr,
 	&dev_attr_dbc_idVendor.attr,
 	&dev_attr_dbc_idProduct.attr,
@@ -1131,10 +1131,7 @@ static struct attribute *dbc_dev_attributes[] = {
 	&dev_attr_dbc_bInterfaceProtocol.attr,
 	NULL
 };
-
-static const struct attribute_group dbc_dev_attrib_grp = {
-	.attrs = dbc_dev_attributes,
-};
+ATTRIBUTE_GROUPS(dbc_dev);
 
 struct xhci_dbc *
 xhci_alloc_dbc(struct device *dev, void __iomem *base, const struct dbc_driver *driver)
@@ -1160,7 +1157,7 @@ xhci_alloc_dbc(struct device *dev, void __iomem *base, const struct dbc_driver *
 	INIT_DELAYED_WORK(&dbc->event_work, xhci_dbc_handle_events);
 	spin_lock_init(&dbc->lock);
 
-	ret = sysfs_create_group(&dev->kobj, &dbc_dev_attrib_grp);
+	ret = sysfs_create_groups(&dev->kobj, dbc_dev_groups);
 	if (ret)
 		goto err;
 
@@ -1179,7 +1176,7 @@ void xhci_dbc_remove(struct xhci_dbc *dbc)
 	xhci_dbc_stop(dbc);
 
 	/* remove sysfs files */
-	sysfs_remove_group(&dbc->dev->kobj, &dbc_dev_attrib_grp);
+	sysfs_remove_groups(&dbc->dev->kobj, dbc_dev_groups);
 
 	kfree(dbc);
 }
-- 
2.40.0.1.gaa8946217a0b

