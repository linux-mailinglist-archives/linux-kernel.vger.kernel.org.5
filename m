Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B734177CF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbjHOPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbjHOPpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:45:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1C10C6;
        Tue, 15 Aug 2023 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692114304; x=1723650304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N4FQQZBClojt4wY/wN9yRlt7dQFZc3hyheZLUA0OBTc=;
  b=TtXIdm5yXGPjRwXudY+Dh+mg9xd9/7to6zfyChaL9fC8QvBBfseYfFnG
   55GHs1NUxWa3WbFKdHBs4RAFTQO1q6+rbJolRi05RuCLpJhHp2TasL2Fp
   bBTMCbqjJgcKeGAgxYfad98aGNMD/DUaoLBbAR0sUTgMbnUXGFQH8FfAj
   SqnJEtT42USmjBEZG6nxN53y6AYAC6vLs66537xIzyHDBRcdTakFVpQfY
   cOpA4gZt8lWAynPWaBMMYWZ6EbKLcMPGA8OY6eJNxfCdkC7rEqfA+X3+b
   oVzi6dleeHb9TcFX6oMavuwXR8Q4419eEoirjMPQjQwmY3gziCj8tXFRX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438647161"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="438647161"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 08:45:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="907654997"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="907654997"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2023 08:44:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVwE5-007rrs-0v;
        Tue, 15 Aug 2023 18:44:57 +0300
Date:   Tue, 15 Aug 2023 18:44:56 +0300
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
Subject: Re: [PATCH v5 6/6] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZNudeE+VNzSqFRGY@smile.fi.intel.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
 <20230814121010.184842-6-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121010.184842-6-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:10:10PM +0200, Marcus Folkesson wrote:
> Microchip does have many similar chips, add support for those.
> 
> The new supported chips are:
>   - microchip,mcp3910
>   - microchip,mcp3912
>   - microchip,mcp3913
>   - microchip,mcp3914
>   - microchip,mcp3918
>   - microchip,mcp3919

...

>  	struct {
> -		u32 channels[MCP3911_NUM_CHANNELS];
> +		u32 channels[MCP39XX_MAX_NUM_CHANNELS];
>  		s64 ts __aligned(8);

Can we actually have the __aligned_s64 defined?

Rhetorical... Let me send a patch for that as it's not related to this series.

>  	} scan;

...

> +	/* Enable offset*/

Missing space.

...

> +static int mcp3911_get_osr(struct mcp3911 *adc, u32 *val)
> +{
> +	int ret, osr;
> +
> +	ret = mcp3911_read(adc, MCP3911_REG_CONFIG, val, 2);
> +	if (ret)
> +		return ret;
> +
> +	osr = FIELD_GET(MCP3911_CONFIG_OSR, *val);
> +	*val = 32 << osr;

> +	return ret;

	return 0;

> +}

...

>  {
> -	struct device *dev = &adc->spi->dev;
>  	u32 regval;
>  	int ret;

> +	struct device *dev = &adc->spi->dev;

Stray change.

...

> +	/* Disable offset to ignore any old values in offset register*/

Missing space.

...

> +	u32 regval;
> +	int ret;
> +	struct device *dev = &adc->spi->dev;

Make the longer line first.

...

> +		dev_dbg(dev,
> +			"use internal voltage reference (1.2V)\n");

One line.

...

> +		dev_dbg(dev,
> +			"use crystal oscillator as clocksource\n");

Ditto.

(This is the outcome of the exercise with temporary dev variable)

...

> +	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
>  	if (ret)
> -		return ret;
> +		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
> +	if (adc->dev_addr > 3) {

> +		dev_err_probe(dev, -EINVAL,
> +			"invalid device address (%i). Must be in range 0-3.\n",
> +			adc->dev_addr);

Missing return?

		return dev_err_probe(...);

> +	}
> +	dev_dbg(dev, "use device address %i\n", adc->dev_addr);

-- 
With Best Regards,
Andy Shevchenko


