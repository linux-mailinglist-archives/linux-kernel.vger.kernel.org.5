Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9986B75D042
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGURAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjGURA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:00:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D712D51;
        Fri, 21 Jul 2023 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689958822; x=1721494822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T3XCTeFPAAlE3o8HaU8QjcX7N6rcLUJEWl9U9IJiSCU=;
  b=lLMQjffvtZR+2dHaF/m8iHVcgSsDh9b0HglP2T0gz/4ZDRD/GTMYOF0p
   +VRdb347xUL5MCLwgz3pmJjmPMyu1K2m3rhw4kRrFALEEPxevEjiwm12x
   DsIW/nB+LhnrYocICim14FRp3ezsaYP24W/q3wpZgpx1BelEuc6COSZFH
   GEL/m8voLyIgWYm12iquthdAgwbobzwkP7PVHcNbcMRBaJG/cGIa0EA0y
   D4ipuvai7+vR/oNo3EWURal20IV3pWUiapeKgbtp1mdiMTpqrYqdJZ4Y5
   KnH2H0kP+MTw0qRl/cZKTVf6JJSw/4ySDzc9e3uJJFv6eA2NlTQrjVmR1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369739486"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="369739486"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 10:00:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="754540213"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="754540213"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2023 10:00:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 78376516; Fri, 21 Jul 2023 20:00:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v2 6/8] iio: core: Fix issues and style of the comments
Date:   Fri, 21 Jul 2023 20:00:20 +0300
Message-Id: <20230721170022.3461-7-andriy.shevchenko@linux.intel.com>
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

The `scripts/kernel-doc -v -none -Wall` reports several issues
with the kernel doc in IIO core C file. Update the comments
accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/industrialio-core.c | 57 +++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 66cea23df7e0..a9b9804097ab 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* The industrial I/O core
+/*
+ * The industrial I/O core
  *
  * Copyright (c) 2008 Jonathan Cameron
  *
@@ -183,7 +184,9 @@ static const char * const iio_chan_info_postfix[] = {
  * @indio_dev:		Device structure whose ID is being queried
  *
  * The IIO device ID is a unique index used for example for the naming
- * of the character device /dev/iio\:device[ID]
+ * of the character device /dev/iio\:device[ID].
+ *
+ * Returns: Unique ID for the device.
  */
 int iio_device_id(struct iio_dev *indio_dev)
 {
@@ -196,6 +199,8 @@ EXPORT_SYMBOL_GPL(iio_device_id);
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
  * @indio_dev:		IIO device structure for device
+ *
+ * Returns: True, if the buffer is enabled.
  */
 bool iio_buffer_enabled(struct iio_dev *indio_dev)
 {
@@ -225,6 +230,9 @@ EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
  * iio_find_channel_from_si() - get channel from its scan index
  * @indio_dev:		device
  * @si:			scan index to match
+ *
+ * Returns:
+ * Constant pointer to iio_chan_spec, if scan index matches, NULL on failure.
  */
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si)
@@ -249,7 +257,9 @@ EXPORT_SYMBOL(iio_read_const_attr);
 /**
  * iio_device_set_clock() - Set current timestamping clock for the device
  * @indio_dev: IIO device structure containing the device
- * @clock_id: timestamping clock posix identifier to set.
+ * @clock_id: timestamping clock POSIX identifier to set.
+ *
+ * Returns: 0 on success, or a negative error code.
  */
 int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
 {
@@ -275,6 +285,8 @@ EXPORT_SYMBOL(iio_device_set_clock);
 /**
  * iio_device_get_clock() - Retrieve current timestamping clock for the device
  * @indio_dev: IIO device structure containing the device
+ *
+ * Returns: Clock ID of the current timestamping clock for the device.
  */
 clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
 {
@@ -287,6 +299,8 @@ EXPORT_SYMBOL(iio_device_get_clock);
 /**
  * iio_get_time_ns() - utility function to get a time stamp for events etc
  * @indio_dev: device
+ *
+ * Returns: Timestamp of the event in nanoseconds.
  */
 s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 {
@@ -594,7 +608,7 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
  * If device is assigned no mounting matrix property, a default 3x3 identity
  * matrix will be filled in.
  *
- * Return: 0 if success, or a negative error code on failure.
+ * Returns: 0 if success, or a negative error code on failure.
  */
 int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
 {
@@ -692,9 +706,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
  * @vals:	Pointer to the values, exact meaning depends on the
  *		type parameter.
  *
- * Return: 0 by default, a negative number on failure or the
- *	   total number of characters written for a type that belongs
- *	   to the IIO_VAL_* constant.
+ * Returns:
+ * 0 by default, a negative number on failure or the total number of characters
+ * written for a type that belongs to the IIO_VAL_* constant.
  */
 ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
 {
@@ -847,8 +861,8 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
  * @fract: The fractional part of the number
  * @scale_db: True if this should parse as dB
  *
- * Returns 0 on success, or a negative error code if the string could not be
- * parsed.
+ * Returns:
+ * 0 on success, or a negative error code if the string could not be parsed.
  */
 static int __iio_str_to_fixpoint(const char *str, int fract_mult,
 				 int *integer, int *fract, bool scale_db)
@@ -917,8 +931,8 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
  * @integer: The integer part of the number
  * @fract: The fractional part of the number
  *
- * Returns 0 on success, or a negative error code if the string could not be
- * parsed.
+ * Returns:
+ * 0 on success, or a negative error code if the string could not be parsed.
  */
 int iio_str_to_fixpoint(const char *str, int fract_mult,
 			int *integer, int *fract)
@@ -1618,7 +1632,10 @@ const struct device_type iio_device_type = {
  * iio_device_alloc() - allocate an iio_dev from a driver
  * @parent:		Parent device.
  * @sizeof_priv:	Space to allocate for private structure.
- **/
+ *
+ * Returns:
+ * Pointer to allocated iio_dev on success, NULL on failure.
+ */
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 {
 	struct iio_dev_opaque *iio_dev_opaque;
@@ -1668,7 +1685,7 @@ EXPORT_SYMBOL(iio_device_alloc);
 /**
  * iio_device_free() - free an iio_dev from a driver
  * @dev:		the iio_dev associated with the device
- **/
+ */
 void iio_device_free(struct iio_dev *dev)
 {
 	if (dev)
@@ -1689,7 +1706,7 @@ static void devm_iio_device_release(void *iio_dev)
  * Managed iio_device_alloc. iio_dev allocated with this function is
  * automatically freed on driver detach.
  *
- * RETURNS:
+ * Returns:
  * Pointer to allocated iio_dev on success, NULL on failure.
  */
 struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv)
@@ -1716,8 +1733,8 @@ EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
  * @filp:	File structure for iio device used to keep and later access
  *		private data
  *
- * Return: 0 on success or -EBUSY if the device is already opened
- **/
+ * Returns: 0 on success or -EBUSY if the device is already opened
+ */
 static int iio_chrdev_open(struct inode *inode, struct file *filp)
 {
 	struct iio_dev_opaque *iio_dev_opaque =
@@ -1750,7 +1767,7 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
  * @inode:	Inode structure pointer for the char device
  * @filp:	File structure pointer for the char device
  *
- * Return: 0 for successful release
+ * Returns: 0 for successful release.
  */
 static int iio_chrdev_release(struct inode *inode, struct file *filp)
 {
@@ -1789,7 +1806,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
 
-	/**
+	/*
 	 * The NULL check here is required to prevent crashing when a device
 	 * is being removed while userspace would still have open file handles
 	 * to try to access this device.
@@ -1966,7 +1983,7 @@ EXPORT_SYMBOL(__iio_device_register);
 /**
  * iio_device_unregister() - unregister a device from the IIO subsystem
  * @indio_dev:		Device structure representing the device.
- **/
+ */
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
@@ -2017,7 +2034,7 @@ EXPORT_SYMBOL_GPL(__devm_iio_device_register);
  *
  * Use with iio_device_release_direct_mode()
  *
- * Returns: 0 on success, -EBUSY on failure
+ * Returns: 0 on success, -EBUSY on failure.
  */
 int iio_device_claim_direct_mode(struct iio_dev *indio_dev)
 {
-- 
2.40.0.1.gaa8946217a0b

