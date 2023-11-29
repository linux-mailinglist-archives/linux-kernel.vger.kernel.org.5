Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D80D7FDE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjK2RYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjK2RYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:24:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118C137;
        Wed, 29 Nov 2023 09:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701278677; x=1732814677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zcZl6izXCOZOAATp4wYpT1f8NPvvO0WuaGYAg0Ab9VU=;
  b=NXZqfAQi54Am5pwd50kRXBxt+Ju8SZNR/HQwWilbdneTaRWXkwEZB2Y4
   yYrVQ995TfMKG2XsBXyA2fQyd3AiO1QRqOHjTJP/2o+19CxwvmmSRKgCT
   3Y7/AtE+YNPnx94qMAEdQylwe5iCGG2i71fe+z1oBVnra9Snqoy+qSV21
   YnbWh8yXKCi/+PnJIbVXzOc1QmFT/e2lNLrPdrvJiCbq2QSjU9mSRmY7U
   ZArOONYbdhHUhiLP4+kz7E9MDXADreMXkqZ5JrxHQDNXAWnSgEUuL8xXO
   ThGEeO0TR5A9aEUcXrD8OiC5NrFjYdZOIWL40uYpNrFuUSw22pCx/hvZD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="479399234"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="479399234"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1100595850"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="1100595850"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:24:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8OIZ-00000000VJR-1s2D;
        Wed, 29 Nov 2023 19:24:31 +0200
Date:   Wed, 29 Nov 2023 19:24:31 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZWdzz7VzCW5ctend@smile.fi.intel.com>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <20231129170425.3562-2-petre.rodan@subdimension.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129170425.3562-2-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 07:04:12PM +0200, Petre Rodan wrote:
> Adds driver for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors.
> Communication is one way. The sensor only requires 4 bytes worth of
> clock pulses on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.

...

> v6: modifications based on Andy's review
>     - use str_has_prefix(), match_string() instead of strncmp()

And why not using the respective property API for that case where
match_string() is used?

I'm also a bit tired to repeat about:
- capitalization and punctuation in the multi-line comments;
- broken indentation is some cases.

Otherwise it's a good stuff, I leave it now to Jonathan.

...

> +	tmp = div_s64(((s64)(hsc->pmax - hsc->pmin)) * MICRO,
> +		      hsc->outmax - hsc->outmin);
> +	hsc->p_scale = div_s64_rem(tmp, NANO, &hsc->p_scale_dec);
> +	tmp = div_s64(((s64)hsc->pmin * (s64)(hsc->outmax - hsc->outmin)) *
> +		      MICRO, hsc->pmax - hsc->pmin);

Why not put MICRO on the previous line?

-- 
With Best Regards,
Andy Shevchenko


