Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5945E75B8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGTUxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGTUx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:53:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32C819A6;
        Thu, 20 Jul 2023 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689886405; x=1721422405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2dOmWbmfP+zv2qAY6T8w+Xkd3L39MYUTAsSIdR8ORM=;
  b=Uaetcs5tdtI/0wiRPKGPwTla+4DHBBolHw1amKsyPabAMmXT3Jry85vj
   a0dcTTBFIqo/LM/XR4vZIuC6FKzZMX4qfWntK4d4kLhPBeQ7qAciEkX1k
   /6FKofzNgNpMZze+FACBo2wYD0ySjYWZ7nveXh932DzBylHCZY/k0Qfqg
   1csF/o6hc2PNSWdsKn8STulWtsyDp1gXEkbzTW0WsEZym1LdJ6LFCcX+q
   kF9Y7Vkm5o8Lb7mCjGkxbCcdCzkboxFHm4C2hrRFyHxplFll8XGTnhBp4
   XW4KpfyIMhs2LRmvcZUmZFk0reD/xVH4NvCMM25Tkkyi5qk8zzZ/jc8x7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356846050"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="356846050"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 13:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="838273951"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="838273951"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jul 2023 13:53:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75CAA69F; Thu, 20 Jul 2023 23:53:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 8/8] iio: core: Improve indentation in a few places
Date:   Thu, 20 Jul 2023 23:53:24 +0300
Message-Id: <20230720205324.58702-9-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve an indentation in a few places to increase readability.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 202a1a67ba98..1918da2a70ad 100644
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

