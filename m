Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2978707C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbjHXNkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbjHXNjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:39:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205EA8;
        Thu, 24 Aug 2023 06:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884382; x=1724420382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ytyz4DisPxGG7v25rMAfmgsjmcCB7im5YSXKnOMR17g=;
  b=TMHZgmz78XuO0qsbLfKMfSenvnVJd1JbwIMKOsT1Mame4bHAg5iaS1cy
   GrMW5YtvYB+1Y8x1mhlJpJyjoAo5kyokj2AktoOdqjr+12tvrcZp4MmHv
   4PvUr0I7fCcGFF/VmJV37tTw/cEagvq6kBVF0GGtadc4h7rmL7UoDw6X8
   cufVabbSOIwnHGQEC7tLeiqz/n/lE2SCnULZ9Ma++EGSL6fq8ojrFdp7Y
   VHtjRArHolK7gHtAiH+bIXbDDXTIyUgdfK2nIhfcuwwAmKT4MYIP+sqVD
   9OIQ0YGzPR0dN1p7pyhWqc0wQky3SDU2J6HszKMMkHVUVRGzpvgqSOBGQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354771248"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354771248"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:39:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="983704613"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="983704613"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 24 Aug 2023 06:39:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZAY9-005fug-2X;
        Thu, 24 Aug 2023 16:39:01 +0300
Date:   Thu, 24 Aug 2023 16:39:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <ZOdddZ0Zpk5CknH8@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdFyKHBc6BcOgZw@smile.fi.intel.com>
 <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:52:56PM +0300, Matti Vaittinen wrote:
> On 8/24/23 14:58, Andy Shevchenko wrote:
> > On Wed, Aug 23, 2023 at 11:16:40PM +0200, Mehdi Djait wrote:

...

> > > +	int ret, fifo_bytes;
> > > +
> > > +	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
> > > +	if (ret) {
> > > +		dev_err(data->dev, "Error reading buffer status\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
> > > +		return KX022A_FIFO_MAX_BYTES;
> > > +
> > > +	return fifo_bytes;
> > 
> > This will be called each time ->get_fifo_bytes() called.
> > Do you expect the fifo_bytes to be changed over times?
> > Shouldn't we simply cache the value?
> 
> I think this value tells how many samples there currently is in the FIFO.
> Caching it does not sound meaningful unless I am missing something.

I see. I think my confusion can be easily cured by renaming the callback to

	get_amount_bytes_in_fifo()

or

	get_bytes_in_fifo()

or alike.

-- 
With Best Regards,
Andy Shevchenko


