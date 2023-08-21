Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41235782630
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjHUJZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjHUJZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:25:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62878C4;
        Mon, 21 Aug 2023 02:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692609926; x=1724145926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kLAaEII6sdvBluC/Z9sMXU4h15+uEOKpVCPxM/TNG74=;
  b=IWJfVisfEGzZosB8jMHaYzWwheO2O7wEUsnIlYSnAVlAZsJIo1sUVvpw
   CQ9M25N3WuOwUd3TO3FXdDmXIu8wfq9BuMpvrxcoXau7LM1C8tA2wdt01
   mLli8tcFW9M1NVWmx+6oQDC04qhffjl8Db5ynz6AkEgeEABa0DCVcgqL0
   8V6JiPUHrgBfbm+yJTRF5Fc38Oy2UUgoUsHANFgVACkyCl29SviQGqHpN
   +tW97U2yY1iYiOZUJdAO3z/ElwB11yCZv6tHN00tP0HEHNd34VhJxvtWz
   VrfmfDjSm50ZsMWo+DbDsJKVR+OfYMsGgLDKsAlK6L0LId8ugg3qwpmYp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="370976402"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="370976402"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 02:25:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="879451781"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2023 02:25:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY19s-007ZgT-2b;
        Mon, 21 Aug 2023 12:25:12 +0300
Date:   Mon, 21 Aug 2023 12:25:12 +0300
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
Subject: Re: [PATCH v7 6/6] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZOMteFUsKhDy1yks@smile.fi.intel.com>
References: <20230820102610.755188-1-marcus.folkesson@gmail.com>
 <20230820102610.755188-7-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820102610.755188-7-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 12:26:10PM +0200, Marcus Folkesson wrote:
> Microchip does have many similar chips, add support for those.
> 
> The new supported chips are:
>   - microchip,mcp3910
>   - microchip,mcp3912
>   - microchip,mcp3913
>   - microchip,mcp3914
>   - microchip,mcp3918
>   - microchip,mcp3919

A few really minor things, after addressing them
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for this journey!

...

> +static int mcp3910_enable_offset(struct mcp3911 *adc, bool enable)
> +{
> +	unsigned int mask = MCP3910_CONFIG0_EN_OFFCAL;

	unsigned int value = enable ? mask : 0;

> +
> +	if (enable)
> +		return mcp3911_update(adc, MCP3910_REG_CONFIG0, mask, mask, 3);
> +	else
> +		return mcp3911_update(adc, MCP3910_REG_CONFIG0, mask, 0, 3);

	return mcp3911_update(adc, MCP3910_REG_CONFIG0, mask, value, 3);

> +}

...

> +static int mcp3911_enable_offset(struct mcp3911 *adc, bool enable)
> +{
> +	unsigned int mask = MCP3911_STATUSCOM_EN_OFFCAL;
> +
> +	if (enable)
> +		return mcp3911_update(adc, MCP3911_REG_STATUSCOM, mask, mask, 2);
> +	else
> +		return mcp3911_update(adc, MCP3911_REG_STATUSCOM, mask, 0, 2);
> +}

Ditto.

...

> +static int mcp3910_get_osr(struct mcp3911 *adc, u32 *val)
> +{
> +	int ret, osr;

	unsigned int osr;

> +
> +	ret = mcp3911_read(adc, MCP3910_REG_CONFIG0, val, 3);
> +	if (ret)
> +		return ret;
> +
> +	osr = FIELD_GET(MCP3910_CONFIG0_OSR, *val);
> +	*val = 32 << osr;
> +	return 0;
> +}

...

> +static int mcp3910_set_osr(struct mcp3911 *adc, u32 val)
> +{
> +	int osr = FIELD_PREP(MCP3910_CONFIG0_OSR, val);

Ditto.

> +	unsigned int mask = MCP3910_CONFIG0_OSR;
> +
> +	return mcp3911_update(adc, MCP3910_REG_CONFIG0, mask, osr, 3);
> +}

...

> +static int mcp3911_set_osr(struct mcp3911 *adc, u32 val)
> +{
> +	int osr = FIELD_PREP(MCP3911_CONFIG_OSR, val);

Ditto.

> +	unsigned int mask = MCP3911_CONFIG_OSR;
> +
> +	return mcp3911_update(adc, MCP3911_REG_CONFIG, mask, osr, 2);
> +}
> +
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
> +}

-- 
With Best Regards,
Andy Shevchenko


