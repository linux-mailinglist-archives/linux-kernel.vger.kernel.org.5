Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1875F41F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjGXLCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjGXLCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:02:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5E7187;
        Mon, 24 Jul 2023 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196524; x=1721732524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wWRqT8vpJKT05tICl5ocqYcd9Og4iXGsP7bje/RHewk=;
  b=E3/mImZdNT27yQkPXslSFksdujZU0bzTij0oeB7hAU1wx62+JJDQbJnC
   tt4n+WmsZQ7TiEjJvvpx95h0fdKaqW8inKsC9zgDmFTCFrKJZaoFMD4gC
   +W6wLDHwQ0BGG3gOHqOWkF+PHkWU+sxlLpS2ZsbDj/lgGk/wcgBrWFCBP
   svOzOZ+0TSl0KPa1iW2GzcH+g6V0bMUIlgThwCgwcwyB82xleaskLbAVg
   Y4FXiCVsm77BnOg+lKrI4OHrNRvtIF2OLYIspB0DBXwLSkNcS6E2DUdNu
   4f6rt07YWnmZusyR+jZTHzdWg/t1NYFD22nFrs/97VQOiBqB0GeDwnB6n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="371009921"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="371009921"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:02:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="869036288"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 24 Jul 2023 04:01:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D770D2BC; Mon, 24 Jul 2023 14:02:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 4/4] iio: core: Fix issues and style of the comments
Date:   Mon, 24 Jul 2023 14:02:04 +0300
Message-Id: <20230724110204.46285-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
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
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/iio/industrialio-core.c | 57 +++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 13d6b6ac5ccf..7302a342dd48 100644
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
@@ -593,7 +607,7 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
  * If device is assigned no mounting matrix property, a default 3x3 identity
  * matrix will be filled in.
  *
- * Return: 0 if success, or a negative error code on failure.
+ * Returns: 0 if success, or a negative error code on failure.
  */
 int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
 {
@@ -691,9 +705,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
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
@@ -846,8 +860,8 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
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
@@ -916,8 +930,8 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
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
@@ -1629,7 +1643,10 @@ const struct device_type iio_device_type = {
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
@@ -1679,7 +1696,7 @@ EXPORT_SYMBOL(iio_device_alloc);
 /**
  * iio_device_free() - free an iio_dev from a driver
  * @dev:		the iio_dev associated with the device
- **/
+ */
 void iio_device_free(struct iio_dev *dev)
 {
 	if (dev)
@@ -1700,7 +1717,7 @@ static void devm_iio_device_release(void *iio_dev)
  * Managed iio_device_alloc. iio_dev allocated with this function is
  * automatically freed on driver detach.
  *
- * RETURNS:
+ * Returns:
  * Pointer to allocated iio_dev on success, NULL on failure.
  */
 struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv)
@@ -1727,8 +1744,8 @@ EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
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
@@ -1761,7 +1778,7 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
  * @inode:	Inode structure pointer for the char device
  * @filp:	File structure pointer for the char device
  *
- * Return: 0 for successful release
+ * Returns: 0 for successful release.
  */
 static int iio_chrdev_release(struct inode *inode, struct file *filp)
 {
@@ -1800,7 +1817,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	mutex_lock(&iio_dev_opaque->info_exist_lock);
 
-	/**
+	/*
 	 * The NULL check here is required to prevent crashing when a device
 	 * is being removed while userspace would still have open file handles
 	 * to try to access this device.
@@ -1978,7 +1995,7 @@ EXPORT_SYMBOL(__iio_device_register);
 /**
  * iio_device_unregister() - unregister a device from the IIO subsystem
  * @indio_dev:		Device structure representing the device.
- **/
+ */
 void iio_device_unregister(struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
@@ -2029,7 +2046,7 @@ EXPORT_SYMBOL_GPL(__devm_iio_device_register);
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

