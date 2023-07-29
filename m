Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2A767ED6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjG2LtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2LtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437703580;
        Sat, 29 Jul 2023 04:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAFCC60B7A;
        Sat, 29 Jul 2023 11:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E63C433C7;
        Sat, 29 Jul 2023 11:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690631339;
        bh=bCATGX3f9ZySM31p/l7qUC2Z9WySgspf+r3i8DzjXZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mnde7Y0C+ItaMEK5cc2Sj6icfR2YKS8Vm8cjP4/Yr7gtwIRKt29V+l8DryVuT9OE3
         68isLObdSjh3A7bjDoWWqGiAwlfGyXbqRwu7F4HCQX+H/4AxpJMY7+UECXP1zwFV5Z
         FYy38De0hkyr82N2ofk1hTEA2T9sUF8qkLAym31OeKRi/ibKhIuTl5cC5HOcUUsNJ6
         Y3nBN3yrL5cb/oUkqFOD67A1ggjXbPAJiRQX9zeHBEDcJ/xcQdanw/kTWMWmH8qeod
         2uy/ivlEBAf4DC4mK1XHkEpeD9uGszYm1vDeYQnDBeUK11arSNYgQNtJ96QiyOZIpc
         hhKZzGQlvHd6Q==
Date:   Sat, 29 Jul 2023 12:49:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 4/4] iio: core: Fix issues and style of the comments
Message-ID: <20230729124904.440c79e4@jic23-huawei>
In-Reply-To: <20230724110204.46285-5-andriy.shevchenko@linux.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
        <20230724110204.46285-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 14:02:04 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The `scripts/kernel-doc -v -none -Wall` reports several issues
> with the kernel doc in IIO core C file. Update the comments
> accordingly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Applied to the togreg branch of iio.git, but initially pushed out as testing
to let 0-day see if it can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 57 +++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 13d6b6ac5ccf..7302a342dd48 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* The industrial I/O core
> +/*
> + * The industrial I/O core
>   *
>   * Copyright (c) 2008 Jonathan Cameron
>   *
> @@ -183,7 +184,9 @@ static const char * const iio_chan_info_postfix[] = {
>   * @indio_dev:		Device structure whose ID is being queried
>   *
>   * The IIO device ID is a unique index used for example for the naming
> - * of the character device /dev/iio\:device[ID]
> + * of the character device /dev/iio\:device[ID].
> + *
> + * Returns: Unique ID for the device.
>   */
>  int iio_device_id(struct iio_dev *indio_dev)
>  {
> @@ -196,6 +199,8 @@ EXPORT_SYMBOL_GPL(iio_device_id);
>  /**
>   * iio_buffer_enabled() - helper function to test if the buffer is enabled
>   * @indio_dev:		IIO device structure for device
> + *
> + * Returns: True, if the buffer is enabled.
>   */
>  bool iio_buffer_enabled(struct iio_dev *indio_dev)
>  {
> @@ -225,6 +230,9 @@ EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
>   * iio_find_channel_from_si() - get channel from its scan index
>   * @indio_dev:		device
>   * @si:			scan index to match
> + *
> + * Returns:
> + * Constant pointer to iio_chan_spec, if scan index matches, NULL on failure.
>   */
>  const struct iio_chan_spec
>  *iio_find_channel_from_si(struct iio_dev *indio_dev, int si)
> @@ -249,7 +257,9 @@ EXPORT_SYMBOL(iio_read_const_attr);
>  /**
>   * iio_device_set_clock() - Set current timestamping clock for the device
>   * @indio_dev: IIO device structure containing the device
> - * @clock_id: timestamping clock posix identifier to set.
> + * @clock_id: timestamping clock POSIX identifier to set.
> + *
> + * Returns: 0 on success, or a negative error code.
>   */
>  int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
>  {
> @@ -275,6 +285,8 @@ EXPORT_SYMBOL(iio_device_set_clock);
>  /**
>   * iio_device_get_clock() - Retrieve current timestamping clock for the device
>   * @indio_dev: IIO device structure containing the device
> + *
> + * Returns: Clock ID of the current timestamping clock for the device.
>   */
>  clockid_t iio_device_get_clock(const struct iio_dev *indio_dev)
>  {
> @@ -287,6 +299,8 @@ EXPORT_SYMBOL(iio_device_get_clock);
>  /**
>   * iio_get_time_ns() - utility function to get a time stamp for events etc
>   * @indio_dev: device
> + *
> + * Returns: Timestamp of the event in nanoseconds.
>   */
>  s64 iio_get_time_ns(const struct iio_dev *indio_dev)
>  {
> @@ -593,7 +607,7 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
>   * If device is assigned no mounting matrix property, a default 3x3 identity
>   * matrix will be filled in.
>   *
> - * Return: 0 if success, or a negative error code on failure.
> + * Returns: 0 if success, or a negative error code on failure.
>   */
>  int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
>  {
> @@ -691,9 +705,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>   * @vals:	Pointer to the values, exact meaning depends on the
>   *		type parameter.
>   *
> - * Return: 0 by default, a negative number on failure or the
> - *	   total number of characters written for a type that belongs
> - *	   to the IIO_VAL_* constant.
> + * Returns:
> + * 0 by default, a negative number on failure or the total number of characters
> + * written for a type that belongs to the IIO_VAL_* constant.
>   */
>  ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
>  {
> @@ -846,8 +860,8 @@ static ssize_t iio_read_channel_info_avail(struct device *dev,
>   * @fract: The fractional part of the number
>   * @scale_db: True if this should parse as dB
>   *
> - * Returns 0 on success, or a negative error code if the string could not be
> - * parsed.
> + * Returns:
> + * 0 on success, or a negative error code if the string could not be parsed.
>   */
>  static int __iio_str_to_fixpoint(const char *str, int fract_mult,
>  				 int *integer, int *fract, bool scale_db)
> @@ -916,8 +930,8 @@ static int __iio_str_to_fixpoint(const char *str, int fract_mult,
>   * @integer: The integer part of the number
>   * @fract: The fractional part of the number
>   *
> - * Returns 0 on success, or a negative error code if the string could not be
> - * parsed.
> + * Returns:
> + * 0 on success, or a negative error code if the string could not be parsed.
>   */
>  int iio_str_to_fixpoint(const char *str, int fract_mult,
>  			int *integer, int *fract)
> @@ -1629,7 +1643,10 @@ const struct device_type iio_device_type = {
>   * iio_device_alloc() - allocate an iio_dev from a driver
>   * @parent:		Parent device.
>   * @sizeof_priv:	Space to allocate for private structure.
> - **/
> + *
> + * Returns:
> + * Pointer to allocated iio_dev on success, NULL on failure.
> + */
>  struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque;
> @@ -1679,7 +1696,7 @@ EXPORT_SYMBOL(iio_device_alloc);
>  /**
>   * iio_device_free() - free an iio_dev from a driver
>   * @dev:		the iio_dev associated with the device
> - **/
> + */
>  void iio_device_free(struct iio_dev *dev)
>  {
>  	if (dev)
> @@ -1700,7 +1717,7 @@ static void devm_iio_device_release(void *iio_dev)
>   * Managed iio_device_alloc. iio_dev allocated with this function is
>   * automatically freed on driver detach.
>   *
> - * RETURNS:
> + * Returns:
>   * Pointer to allocated iio_dev on success, NULL on failure.
>   */
>  struct iio_dev *devm_iio_device_alloc(struct device *parent, int sizeof_priv)
> @@ -1727,8 +1744,8 @@ EXPORT_SYMBOL_GPL(devm_iio_device_alloc);
>   * @filp:	File structure for iio device used to keep and later access
>   *		private data
>   *
> - * Return: 0 on success or -EBUSY if the device is already opened
> - **/
> + * Returns: 0 on success or -EBUSY if the device is already opened
> + */
>  static int iio_chrdev_open(struct inode *inode, struct file *filp)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque =
> @@ -1761,7 +1778,7 @@ static int iio_chrdev_open(struct inode *inode, struct file *filp)
>   * @inode:	Inode structure pointer for the char device
>   * @filp:	File structure pointer for the char device
>   *
> - * Return: 0 for successful release
> + * Returns: 0 for successful release.
>   */
>  static int iio_chrdev_release(struct inode *inode, struct file *filp)
>  {
> @@ -1800,7 +1817,7 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  
>  	mutex_lock(&iio_dev_opaque->info_exist_lock);
>  
> -	/**
> +	/*
>  	 * The NULL check here is required to prevent crashing when a device
>  	 * is being removed while userspace would still have open file handles
>  	 * to try to access this device.
> @@ -1978,7 +1995,7 @@ EXPORT_SYMBOL(__iio_device_register);
>  /**
>   * iio_device_unregister() - unregister a device from the IIO subsystem
>   * @indio_dev:		Device structure representing the device.
> - **/
> + */
>  void iio_device_unregister(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> @@ -2029,7 +2046,7 @@ EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>   *
>   * Use with iio_device_release_direct_mode()
>   *
> - * Returns: 0 on success, -EBUSY on failure
> + * Returns: 0 on success, -EBUSY on failure.
>   */
>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev)
>  {

