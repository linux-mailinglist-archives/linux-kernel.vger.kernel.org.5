Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0093D774165
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjHHRTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjHHRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:18:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B88CA7;
        Tue,  8 Aug 2023 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510865; x=1723046865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R6UzZPmeddLD5E78VuDAI1PCQFG215xuKvwMFArd0fs=;
  b=EHy+Hn0ktZWdBtZqAg1pcup75rcH10V0FYUgR7Q8LRrbHTck2yypR142
   iA8KilkE5OM5+g5korQjyEzmnLd0nkmtG0x4FX/A7MmRSKC8qKiJfRFZ7
   W5OrQ8lNPG97md6zJNei6K/TWlEb8V+51A8cQl9qcKQSP4rMWZJxxOtz0
   LnuWjj772+T3AslKe9+P0pqY1OHoI/Dqg4/tpPcKikJqum+BHM2LH9RwI
   10vpdOlDZ9UjuIqWiTfR9tMdNU4s0ai0d47FMtz0dxkXDsdVv27dnpU2j
   OQtOglCi6Tob8JfVma99qjeTb5WzkoLRlmSBrh9hrUMgNPVlUa4ewzgfI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="351138159"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="351138159"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 07:23:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821390354"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="821390354"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 07:23:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTNca-00BeUL-0J;
        Tue, 08 Aug 2023 17:23:40 +0300
Date:   Tue, 8 Aug 2023 17:23:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZNJP6xpOvRJigtMx@smile.fi.intel.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
 <20230808110432.240773-4-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808110432.240773-4-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 01:04:32PM +0200, Marcus Folkesson wrote:
> Microchip does have many similar chips, add support for those.

...

>  	help
> -	  Say yes here to build support for Microchip Technology's MCP3911
> -	  analog to digital converter.
> +	  Say yes here to build support for Microchip Technology's MCP3910,
> +	  MCP3911, MCP3912, MCP3913, MCP3914, MCP3918 and MCP3919
> +	  analog to digital converters.

For maintenance this can be written as

	  Say yes here to build support for one of the following
	  Microchip Technology's analog to digital converters:
	    MCP3910, MCP3911, MCP3912, MCP3913, MCP3914,
	    MCP3918, MCP3919

>  	  This driver can also be built as a module. If so, the module will be
>  	  called mcp3911.

...

> +#define MCP3910_OFFCAL(x)		(MCP3910_REG_OFFCAL_CH0 + x * 6)

Inconsistent macro implementation, i.e. you need to use (x).

...

> +static int mcp3910_get_osr(struct mcp3911 *adc, int *val)
> +{
> +	int ret, osr;

Strictly speaking osr can't be negative, otherwise it's a UB below.

	u32 osr = FIELD_GET(MCP3910_CONFIG0_OSR, *val);
	int ret;

and why val is int?

> +	ret = mcp3911_read(adc, MCP3910_REG_CONFIG0, val, 3);
> +	if (ret)
> +		return ret;
> +
> +	osr = FIELD_GET(MCP3910_CONFIG0_OSR, *val);
> +	*val = 32 << osr;
> +	return ret;
> +}

...

> +static int mcp3910_set_osr(struct mcp3911 *adc, int val)
> +{

> +	int osr;
> +
> +	osr = FIELD_PREP(MCP3910_CONFIG0_OSR, val);

Can be on one line.

> +	return mcp3911_update(adc, MCP3910_REG_CONFIG0,
> +			      MCP3910_CONFIG0_OSR, osr, 3);
> +}

...

> +static int mcp3911_set_osr(struct mcp3911 *adc, int val)
> +static int mcp3911_get_osr(struct mcp3911 *adc, int *val)

As per above comments.

...

> +	if (adc->vref) {
> +		dev_dbg(&adc->spi->dev, "use external voltage reference\n");
> +		regval |= FIELD_PREP(MCP3910_CONFIG1_VREFEXT, 1);
> +	} else {

> +		dev_dbg(&adc->spi->dev,
> +			"use internal voltage reference (1.2V)\n");


As per previous patch comments

		dev_dbg(dev, "use internal voltage reference (1.2V)\n");

> +		regval |= FIELD_PREP(MCP3910_CONFIG1_VREFEXT, 0);
> +	}

...

> +	if (adc->clki) {
> +		dev_dbg(&adc->spi->dev, "use external clock as clocksource\n");
> +		regval |= FIELD_PREP(MCP3910_CONFIG1_CLKEXT, 1);
> +	} else {
> +		dev_dbg(&adc->spi->dev,
> +			"use crystal oscillator as clocksource\n");

Ditto.

> +		regval |= FIELD_PREP(MCP3910_CONFIG1_CLKEXT, 0);
> +	}

...

> +	if (device_property_read_bool(&adc->spi->dev, "microchip,data-ready-hiz"))

This also becomes shorter.

One trick to make it even shorter:

	if (device_property_present(dev, "microchip,data-ready-hiz"))

> +		regval |= FIELD_PREP(MCP3910_STATUSCOM_DRHIZ, 0);
> +	else
> +		regval |= FIELD_PREP(MCP3910_STATUSCOM_DRHIZ, 1);

...

> +	ret = device_property_read_u32(&spi->dev, "microchip,device-addr", &adc->dev_addr);

I would move it after the comment. It will be more visible what we are
expecting and what the legacy is.


> +	/*
> +	 * Fallback to "device-addr" due to historical mismatch between
> +	 * dt-bindings and implementation.
> +	 */

	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);

>  	if (ret)
> -		return ret;
> +		device_property_read_u32(&spi->dev, "device-addr", &adc->dev_addr);

> +	if (adc->dev_addr > 3) {
> +		dev_err(&spi->dev,
> +			"invalid device address (%i). Must be in range 0-3.\n",
> +			adc->dev_addr);
> +		return -EINVAL;

		return dev_err_probe(...);

> +	}

...

> +	dev_dbg(&spi->dev, "use device address %i\n", adc->dev_addr);

Is it useful?

-- 
With Best Regards,
Andy Shevchenko


