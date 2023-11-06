Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADE47E1E38
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKFK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjKFK1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:27:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A7CD8;
        Mon,  6 Nov 2023 02:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699266460; x=1730802460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VV8FhN3eu/AlRFbG+72mkF5xgKloicJTe1Nvqf9cbbs=;
  b=V7jfu8o0XDeBstCe/3s0cmyxvdUkCfcUH0sgr9sUivztgpZuCZAZWEqg
   2E4Xs05SxZzLwJ/91Hbe8/8nudJRffPEGSV5sJUQ/baHTpfrdbHq8vdvv
   J7Ri7vRIuPULJ0SOkUJLoIjpYm1P6sfdza3jFLLXL/zdiwKO6I/0Z+noo
   AAbjBWxVQeYg1kDY75J0lC5naUcuY70fFVwtKQAQO9mzAQE4ZC6+Tlvx/
   Xkyd5KDNyHWG3kXWKd8fzxqoEpjCf6fUnZ2Lafch6km+kHk9dMt8hxzY5
   6Pb7tXvzYpQKTlonjfNDFJyFWMoH3Wi4L42+Bt1LHghkOMKBAY++apB29
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2157336"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="2157336"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:27:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="738761530"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="738761530"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:27:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qzwpN-0000000BlGy-385G;
        Mon, 06 Nov 2023 12:27:29 +0200
Date:   Mon, 6 Nov 2023 12:27:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7192: Add AD7194 support
Message-ID: <ZUi_kWzZBMRBs3EU@smile.fi.intel.com>
References: <20231105193132.47009-1-alisadariana@gmail.com>
 <20231105193132.47009-4-alisadariana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105193132.47009-4-alisadariana@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2023 at 09:31:31PM +0200, alisadariana@gmail.com wrote:
> From: Alisa-Dariana Roman <alisa.roman@analog.com>
> 
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The default configuration for these channels can be changed
> from the devicetree.
> 
> The default configuration is hardcoded in order to have a stable number
> of channels.

...

>  config AD7192
> -	tristate "Analog Devices AD7190 AD7192 AD7193 AD7195 ADC driver"
> +	tristate "Analog Devices AD7190 AD7192 AD7193 AD7194 AD7195 ADC driver"

This doesn't scale. Please change this and below like:

	tristate "Analog Devices AD719x ADC driver"

>  	depends on SPI
>  	select AD_SIGMA_DELTA
>  	help
>  	  Say yes here to build support for Analog Devices AD7190,
> -	  AD7192, AD7193 or AD7195 SPI analog to digital converters (ADC).
> +	  AD7192, AD7193, AD7194 or AD7195 SPI analog to digital converters (ADC).

	  Say yes here to build support for Analog Devices SPI analog to
	  digital converters (ADC):
	  - AD7190
	  - AD7192
	  - AD7193
	  - AD7194
	  - AD7195

>  	  If unsure, say N (but it's safe to say "Y").

With above change adding a new one will be just a mater of adding a single
line.

...

> +static int ad7192_parse_channel(struct iio_dev *indio_dev,
> +				struct fwnode_handle *child)
> +{
> +	u32 reg, ain[2];
> +	int ret;
> +
> +	ret = fwnode_property_read_u32(child, "reg", &reg);
> +	if (ret)
> +		return ret;

> +	if (reg < AD7194_CH_DIFF_NR_MIN || reg > AD7194_CH_DIFF_NR_MAX)
> +		return -EINVAL;

in_range()


> +	ret = fwnode_property_read_u32_array(child, "diff-channels", ain,
> +					     ARRAY_SIZE(ain));
> +	if (ret)
> +		return ret;
> +
> +	if (ain[0] < AD7194_CH_AIN_MIN || ain[0] > AD7194_CH_AIN_MAX ||
> +	    ain[1] < AD7194_CH_AIN_MIN || ain[1] > AD7194_CH_AIN_MAX)

Ditto.

> +		return -EINVAL;
> +
> +	ad7194_channels[reg].channel = ain[0];
> +	ad7194_channels[reg].channel2 = ain[1];
> +	ad7194_channels[reg].address = AD7194_CH_DIFF(ain[0], ain[1]);
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


