Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2CD75D041
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGURAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjGURA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:00:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53962D53;
        Fri, 21 Jul 2023 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689958822; x=1721494822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/foF2WXy3sLwO5FNP6HwLNSDaxhXkIAkyYPFiKkl/9I=;
  b=dcdysi9UIF59ioef9yEo0G/TLTe/+CJDffBPPt4MdQWp/RFxdQe58pKn
   nMSK6JnPswZ1cfW6BQx+G5Lgjy9lk+BtEqY2dEnronWTLSabo9EOPYljX
   5vmsDe1ylNvAWgHGLOREpb026lYoijVd3YBVHdiwIzqva1Qlqbo2PgAKy
   BUBxnyeq2WhDMz4t7vwDKX2/qJfZgJk9BGSiyUcN1myGNJiz9wjqzts4z
   60+6/X0VhQqu0IwbCvAQhm61eKFd1yDZ9RJEydfUQ+VwlZv6Qp8t0DzK7
   73osIS0TyHfCXmymMhOKZTVQEVym2KdTUlEehgaPPLJufj8qVwN8Ky8gw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369739492"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="369739492"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="754540217"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="754540217"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 10:00:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8ABF769F; Fri, 21 Jul 2023 20:00:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 8/8] iio: core: Improve indentation in a few places
Date:   Fri, 21 Jul 2023 20:00:22 +0300
Message-Id: <20230721170022.3461-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve an indentation in a few places to increase readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 5c9c68d69fc6..e1293fdbc0ef 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -206,9 +206,9 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
-	return iio_dev_opaque->currentmode
-		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
-		   INDIO_BUFFER_SOFTWARE);
+	return iio_dev_opaque->currentmode &
+	       (INDIO_BUFFER_HARDWARE | INDIO_BUFFER_SOFTWARE |
+		INDIO_BUFFER_TRIGGERED);
 }
 EXPORT_SYMBOL_GPL(iio_buffer_enabled);
 
@@ -388,8 +388,8 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
 	}
 
 	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
-					      sizeof(iio_dev_opaque->read_buf),
-					      "0x%X\n", val);
+						sizeof(iio_dev_opaque->read_buf),
+						"0x%X\n", val);
 
 	return simple_read_from_buffer(userbuf, count, ppos,
 				       iio_dev_opaque->read_buf,
@@ -492,8 +492,7 @@ static ssize_t iio_read_channel_ext_info(struct device *dev,
 
 static ssize_t iio_write_channel_ext_info(struct device *dev,
 				     struct device_attribute *attr,
-				     const char *buf,
-					 size_t len)
+				     const char *buf, size_t len)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
@@ -585,9 +584,9 @@ static int iio_setup_mount_idmatrix(const struct device *dev,
 ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
 			      const struct iio_chan_spec *chan, char *buf)
 {
-	const struct iio_mount_matrix *mtx = ((iio_get_mount_matrix_t *)
-					      priv)(indio_dev, chan);
+	const struct iio_mount_matrix *mtx;
 
+	mtx = ((iio_get_mount_matrix_t *)priv)(indio_dev, chan);
 	if (IS_ERR(mtx))
 		return PTR_ERR(mtx);
 
@@ -1025,14 +1024,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	if (chan->modified && (shared_by == IIO_SEPARATE)) {
 		if (chan->extend_name)
 			full_postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
-						 iio_modifier_names[chan
-								    ->channel2],
+						 iio_modifier_names[chan->channel2],
 						 chan->extend_name,
 						 postfix);
 		else
 			full_postfix = kasprintf(GFP_KERNEL, "%s_%s",
-						 iio_modifier_names[chan
-								    ->channel2],
+						 iio_modifier_names[chan->channel2],
 						 postfix);
 	} else {
 		if (chan->extend_name == NULL || shared_by != IIO_SEPARATE)
-- 
2.40.0.1.gaa8946217a0b

