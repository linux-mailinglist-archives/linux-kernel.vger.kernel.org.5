Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C16675E0A5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGWJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWJQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209B019B;
        Sun, 23 Jul 2023 02:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA8660C6E;
        Sun, 23 Jul 2023 09:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB23C433C8;
        Sun, 23 Jul 2023 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690103767;
        bh=YR0xW1wnhiUCWmh+Rs4nFneJQ5jzk2gDscX++ESLFCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DCKWREIYTcvr396gebzgilZ5A5CvBGpmfuvvbCWgYgmfYSUlva8Gu2AQ6x23zWnuM
         byJKjEk25YmtS8/uCoQ/omA0aDt7+QPZ5yetw3SuzHXtkgkBeqlz6TA26uhOwX+/NX
         G0v0U71OEQlHqL0AZtiG3FhR6YFBCyPqizQFOJJtj8WXabZgrGW7XYGc5MOnaR7bWW
         kYMKDhHg5faklxfS2O8c8AdcJkA2kHfirHZyUC4sc1/d285SJvx0+AXYjuuf3MmqhK
         AqdhFpDlElcELPxtumls1ePjoHN0e1yR7V9XsiucMusnLaos1rxZWpbowsvf0rYjYw
         +PiCjIcAhnZIQ==
Date:   Sun, 23 Jul 2023 10:16:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v2 5/8] iio: core: Get rid of redundant 'else'
Message-ID: <20230723101606.0bc28e72@jic23-huawei>
In-Reply-To: <20230721170022.3461-6-andriy.shevchenko@linux.intel.com>
References: <20230721170022.3461-1-andriy.shevchenko@linux.intel.com>
        <20230721170022.3461-6-andriy.shevchenko@linux.intel.com>
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

On Fri, 21 Jul 2023 20:00:19 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In the snippets like the following
> 
> 	if (...)
> 		return / goto / break / continue ...;
> 	else
> 		...
> 
> the 'else' is redundant. Get rid of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 78cc67efa490..66cea23df7e0 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -524,7 +524,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
>  	i = e->get(indio_dev, chan);
>  	if (i < 0)
>  		return i;
> -	else if (i >= e->num_items || !e->items[i])
> +	if (i >= e->num_items || !e->items[i])
>  		return -EINVAL;
>  
>  	return sysfs_emit(buf, "%s\n", e->items[i]);
> @@ -1217,7 +1217,7 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
>  					     &iio_dev_opaque->channel_attr_list);
>  		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
>  			continue;
> -		else if (ret < 0)
> +		if (ret < 0)
>  			return ret;
>  		attrcount++;
>  	}
> @@ -1255,7 +1255,7 @@ static int iio_device_add_info_mask_type_avail(struct iio_dev *indio_dev,
>  		kfree(avail_postfix);
>  		if ((ret == -EBUSY) && (shared_by != IIO_SEPARATE))
>  			continue;
> -		else if (ret < 0)
> +		if (ret < 0)
>  			return ret;
>  		attrcount++;
>  	}

