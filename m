Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820B0770920
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjHDThj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHDThf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:37:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529F0E7;
        Fri,  4 Aug 2023 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691177854; x=1722713854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aPArex8+yqQJfr0Dx1twcKyz+HqyUonP/iP9Dd9pRd4=;
  b=DRyk7v4uZZ9b0Jn5B+pJ0Z3gwRrEb+ectCW4bVUN2/Q/Ke3mucI4q4Xj
   WcceKOqL0rp/GiKcPExUflK9pWUy2ckE/eTts4hLR+wJ4DoCwqZgfCOAG
   aVpmFjK2dbZABTJlnM/f704WyCJ8yGJpNFVlShoXH/LrDMbj37VoN6YZt
   doOqWRX3+30M8CTJUguD5E3cJfMVsAWDMpW2Vx+4PrlmuS/nhWTobXAxl
   vRdKG96nJhmVV0LYwYsjngPzEkwhgJF8b8II6vCRsXQCOyMZ08Y1qSRru
   dE/HWrUJME+SzHcko8XY3lNYaBzHc/fixnDAgdAj7rHngTaKrgfn/NgY6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373886342"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="373886342"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 12:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="733383459"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="733383459"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 04 Aug 2023 12:37:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qS0c3-0055Lo-1J;
        Fri, 04 Aug 2023 22:37:27 +0300
Date:   Fri, 4 Aug 2023 22:37:27 +0300
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
Subject: Re: [PATCH v2 2/2] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZM1Td+v3tcoaID9v@smile.fi.intel.com>
References: <20230804100248.3773861-1-marcus.folkesson@gmail.com>
 <20230804100248.3773861-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804100248.3773861-2-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 12:02:48PM +0200, Marcus Folkesson wrote:
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

>  	help
> -	  Say yes here to build support for Microchip Technology's MCP3911
> -	  analog to digital converter.
> +	  Say yes here to build support for Microchip Technology's MCP3910,

> +          MCP3911, MCP3912, MCP3913, MCP3914, MCP3918 and MCP3919

This line is misindented. Should be <TAB><space><space>.

> +	  analog to digital converters.

...

> +#define MCP3910_REG_OFFCAL_CH0		0x0f
> +#define MCP3910_OFFCAL(x)		(MCP3910_REG_OFFCAL_CH0 + x * 6)
> +
> +

Single blank line is enough.

...

> +static int mcp3910_get_offset(struct mcp3911 *adc, int channel, int *val)
> +{
> +	return mcp3911_read(adc, MCP3910_OFFCAL(channel), val, 3);

Just to be sure, the proper endianess conversion is done in mcp3911_read()
and mcp3911_write() calls?

This question applies to all calls to that APIs.

> +}

...

> +	int ret = mcp3911_write(adc, MCP3910_OFFCAL(channel), val,
> +			3);

This looks weird not being on a single line. Moreover it fits even
80 characters. Same applies to other similar cases.

Also, please use better approach, i.e.

	int ret;

	ret = ...(...);
	if (ret)
		...

Also applies to several places.

> +	if (ret)
> +		return ret;

...

> +	/* Enable offset*/

Missing space.

...

> +static int mcp3910_get_osr(struct mcp3911 *adc, int *val)
> +{
> +	int ret = mcp3911_read(adc, MCP3910_REG_CONFIG0, val, 3);

Have you run checkpatch? Here should be a blank line. Same in other several
places.

> +	*val = FIELD_GET(MCP3910_CONFIG0_OSR, *val);
> +	*val = 32 << *val;

Please, use a temporary variable and assign the result only once.
It will be a better code.

> +	return ret;
> +}

...

> +static int mcp3911_set_osr(struct mcp3911 *adc, int val)
> +{
> +	val = FIELD_PREP(MCP3911_CONFIG_OSR, val);

As per above.

> +	return mcp3911_update(adc, MCP3911_REG_CONFIG,
> +			MCP3911_CONFIG_OSR, val, 2);

> +

Redundant blank line.

> +}

...

> +static int mcp3911_get_osr(struct mcp3911 *adc, int *val)
> +{

As per above.

> +}

...

> +       /* Set gain to 1 for all channels */

Again, wrong indentation. Can you check all your lines for the proper
indentation. (Here should be just <TAB>.)

...

> +	for (int i = 0; i < adc->chip->num_channels - 1; i++) {
> +		adc->gain[i] = 1;
> +		regval &= ~MCP3911_GAIN_MASK(i);
> +	}

Missing blank line.

> +	return mcp3911_write(adc, MCP3911_REG_GAIN, regval, 1);
> +
> +

Too many redundant blank lines.

> +}

...

> +       /* Set gain to 1 for all channels */

Mind indentation.

...

> +	/* Disable offset to ignore any old values in offset register*/

Missing space.

...

> +	adc->chip = (struct mcp3911_chip_info *)spi_get_device_id(spi)->driver_data;

Can't you use spi_get_device_match_data()?

...

> +	/*
> +	 * Fallback to "device-addr" due to historical mismatch between
> +	 * dt-bindings and implementation

Missing grammatical period at the end.

> +	 */

...

> +		device_property_read_u32(&adc->spi->dev, "device-addr", &adc->dev_addr);

With

	struct device *dev = &adc->spi->dev;

lines like this will be neater.

-- 
With Best Regards,
Andy Shevchenko


