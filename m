Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7007CA107
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjJPHxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJPHxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:53:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF33AD;
        Mon, 16 Oct 2023 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697442823; x=1728978823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ixX0RLZqUvYdCViWR3QC9hB3nJJiOPVVdf0NCyC6K4w=;
  b=UaQ3UF6tZkAdy8GjSn568XIgUttoPiobxb/anzT0RCEmhnGpl/YHT8Aq
   xSd3Ial+nQn7nN94iT0vDsYgwbOfS4GFnjEOPamMIwofmz9RaBrxmZHdF
   M0USy4cjdxp1z7qu6ky/elz3CG8KH9zNvgSfTNaSwLE8ruAlcfSsfzJUX
   AGrimZho/9pmqTaej9CLmiu8a0n+kaKx5nWq8HHI5TJHVqakgK0uXWujn
   VRHBLsEwD65ku0z2B4JtkiJ4irzXKFDta7gLOsCjwDFOXKlKhzB4WksuN
   xahhZpcydK8iSiBAnJfYgk8NE0gxp1W5IMlBq90eo6EbbrZQkY52zBIha
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="370544795"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="370544795"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 00:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="929256670"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="929256670"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 00:53:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsIPy-00000005x8u-2BI4;
        Mon, 16 Oct 2023 10:53:38 +0300
Date:   Mon, 16 Oct 2023 10:53:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/5] iio: pressure: bmp280: Allow multiple chips id per
 family of devices
Message-ID: <ZSzsAnE38p7zwM2+@smile.fi.intel.com>
References: <cover.1697381932.git.ang.iglesiasg@gmail.com>
 <9f8489d82325b2dfb5c8c71c3d558d509b2b01bf.1697381932.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f8489d82325b2dfb5c8c71c3d558d509b2b01bf.1697381932.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 05:16:26PM +0200, Angel Iglesias wrote:
> Improve device detection in certain chip families known to have various
> chip ids.

...

> +#include <linux/overflow.h>

Probably you don't need this, see below.

...

>  	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
>  	if (ret < 0)
>  		return ret;

> +	if (i == data->chip_info->num_chip_id) {
> +		size_t nbuf;
> +		char *buf;
> +
> +		// 0x<id>, so four chars per number plus one space + ENDL
> +		if (check_mul_overflow(data->chip_info->num_chip_id, 5, &nbuf))
> +			return ret;

First of all, it _implicitly_ returns 0 here...

> +		buf = kmalloc_array(data->chip_info->num_chip_id, 5, GFP_KERNEL);
> +		if (!buf)
> +			return ret;

...and here.

Second, kmalloc_array() has that check inside.

Third, define this magic 5 either as strlen(), or a constant (in latter case
with the comment of its meaning).

> +		for (i = 0; i < data->chip_info->num_chip_id; i++)
> +			snprintf(&buf[i*5], nbuf - i*5, "0x%x ", data->chip_info->chip_id[i]);

Fourth, use incremental position, i.e. use retuned value from snprintf().

> +		dev_err(dev, "bad chip id: expected one of [ %s ] got 0x%x\n", buf, chip_id);
> +		kfree(buf);

> +		return ret;

As per "first" and "second" above.

>  	}

-- 
With Best Regards,
Andy Shevchenko


