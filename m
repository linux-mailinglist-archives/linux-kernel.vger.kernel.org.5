Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E475E0E3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjGWJYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGWJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E871A1;
        Sun, 23 Jul 2023 02:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AF8060BFF;
        Sun, 23 Jul 2023 09:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DD7C433C8;
        Sun, 23 Jul 2023 09:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690104287;
        bh=J95bXDDSrHefTSiGU1JVTbmCq80sX+eTmpH161clEuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ew7oTg4JNsj2q5YJotKYVIqpvW2PZB7epx8kiExTEdg3CP9zkJ9tB0r/cbGqYWbVj
         B/KI5+vDFEnAwEj0nOAsACXa6p56cCVNZU8uHpA8eh0Y1q3xGa9R8Nl50A9QzYa26o
         0N9F48guDtBskW+5knJMNGk1PjyNkW/1kziao/J003Kf3KJQdpJWqV+HqPpqps6zja
         IXB+HKwKgJDq2uOXyzLak/2OMKiORwNxUZZ6tKY+/VJHWYlmfojaNXBK0maDT8A0ra
         XWF8GLAvF7tKnSzWmB+6eZdVcjz25Lvb9yw3wf6/Be9swfh28KmDMol8HAxPMpROlu
         tFjFOmx5JrnaQ==
Date:   Sun, 23 Jul 2023 10:24:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 8/8] iio: core: Improve indentation in a few places
Message-ID: <20230723102443.7bcb1abb@jic23-huawei>
In-Reply-To: <20230721170022.3461-9-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
        <20230721170022.3461-9-andriy.shevchenko@linux.intel.com>
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

On Fri, 21 Jul 2023 20:00:22 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Improve an indentation in a few places to increase readability.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to not notice any change (hopefully ;)

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 5c9c68d69fc6..e1293fdbc0ef 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -206,9 +206,9 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  
> -	return iio_dev_opaque->currentmode
> -		& (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
> -		   INDIO_BUFFER_SOFTWARE);
> +	return iio_dev_opaque->currentmode &
> +	       (INDIO_BUFFER_HARDWARE | INDIO_BUFFER_SOFTWARE |
> +		INDIO_BUFFER_TRIGGERED);
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_enabled);
>  
> @@ -388,8 +388,8 @@ static ssize_t iio_debugfs_read_reg(struct file *file, char __user *userbuf,
>  	}
>  
>  	iio_dev_opaque->read_buf_len = snprintf(iio_dev_opaque->read_buf,
> -					      sizeof(iio_dev_opaque->read_buf),
> -					      "0x%X\n", val);
> +						sizeof(iio_dev_opaque->read_buf),
> +						"0x%X\n", val);
>  
>  	return simple_read_from_buffer(userbuf, count, ppos,
>  				       iio_dev_opaque->read_buf,
> @@ -492,8 +492,7 @@ static ssize_t iio_read_channel_ext_info(struct device *dev,
>  
>  static ssize_t iio_write_channel_ext_info(struct device *dev,
>  				     struct device_attribute *attr,
> -				     const char *buf,
> -					 size_t len)
> +				     const char *buf, size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> @@ -585,9 +584,9 @@ static int iio_setup_mount_idmatrix(const struct device *dev,
>  ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
>  			      const struct iio_chan_spec *chan, char *buf)
>  {
> -	const struct iio_mount_matrix *mtx = ((iio_get_mount_matrix_t *)
> -					      priv)(indio_dev, chan);
> +	const struct iio_mount_matrix *mtx;
>  
> +	mtx = ((iio_get_mount_matrix_t *)priv)(indio_dev, chan);
>  	if (IS_ERR(mtx))
>  		return PTR_ERR(mtx);
>  
> @@ -1025,14 +1024,12 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>  	if (chan->modified && (shared_by == IIO_SEPARATE)) {
>  		if (chan->extend_name)
>  			full_postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
> -						 iio_modifier_names[chan
> -								    ->channel2],  
> +						 iio_modifier_names[chan->channel2],
>  						 chan->extend_name,
>  						 postfix);
>  		else
>  			full_postfix = kasprintf(GFP_KERNEL, "%s_%s",
> -						 iio_modifier_names[chan
> -								    ->channel2],  
> +						 iio_modifier_names[chan->channel2],
>  						 postfix);
>  	} else {
>  		if (chan->extend_name == NULL || shared_by != IIO_SEPARATE)

