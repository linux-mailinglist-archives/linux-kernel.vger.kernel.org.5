Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28B77F6F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351030AbjHQM7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351029AbjHQM6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:58:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23522D7E;
        Thu, 17 Aug 2023 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692277131; x=1723813131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KrypkWV1dHYb49zfPyAXomQ6ntXuDb7YJdmm+yorAKc=;
  b=DdEvBC0l4kQN6ttdYWfhOJDAyr8XKLFx+3A8g1i9z+KpEV1x/nbxzNI6
   ixn1Qbwyh/RUQFQ3s32b0So1h+umVu4Qh5HEM9Hvj5aY3RbTk5TN+dK2n
   IgLNv01ginXpOQX7ucsSl5NSJbpwupamcA7AGPfhzU4MDtCNba/u4dcRZ
   yN2dlbxnxq5aw8lQd3B5VC8Ns3etaxe2i4SuvhuUibjrCszIBXLLmsUnG
   VN82Kv1Lrtrx1txgL6RGUb3Ef92oXWba2fN647pZrlnrCdfCCvBHENxtm
   3uY/H0rzH6ReG/YUygVP4dBDLhhvkPzhBdUbuZCEsMFxzLcdEljN4Xsav
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371706872"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="371706872"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="858224570"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="858224570"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2023 05:58:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWcaJ-00COmW-2o;
        Thu, 17 Aug 2023 15:58:43 +0300
Date:   Thu, 17 Aug 2023 15:58:43 +0300
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
Subject: Re: [PATCH v6 6/6] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZN4Zg235AdYwI70E@smile.fi.intel.com>
References: <20230817120518.153728-1-marcus.folkesson@gmail.com>
 <20230817120518.153728-6-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120518.153728-6-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 02:05:18PM +0200, Marcus Folkesson wrote:
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

> +static int mcp3910_set_offset(struct mcp3911 *adc, int channel, int val)
> +{

	unsigned int mask = MCP3910_CONFIG0_EN_OFFCAL;

> +	int ret;
> +
> +	/* Write offset */
> +	ret = mcp3911_write(adc, MCP3910_OFFCAL(channel), val, 3);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable offset */
> +	return mcp3911_update(adc, MCP3910_REG_CONFIG0,
> +			      MCP3910_CONFIG0_EN_OFFCAL,
> +			      MCP3910_CONFIG0_EN_OFFCAL, 3);

	return mcp3911_update(adc, MCP3910_REG_CONFIG0, mask, mask, 3);

> +}

...

> +static int mcp3911_set_offset(struct mcp3911 *adc, int channel, int val)
> +{

As per above.

> +}

...

> +static int mcp3910_set_osr(struct mcp3911 *adc, u32 val)
> +{

	unsigned int mask = MCP3910_CONFIG0_OSR;

> +	int osr = FIELD_PREP(MCP3910_CONFIG0_OSR, val);
> +
> +	return mcp3911_update(adc, MCP3910_REG_CONFIG0,
> +			      MCP3910_CONFIG0_OSR, osr, 3);

	return mcp3911_update(adc, MCP3910_REG_CONFIG0, mask, osr, 3);

> +}

...

> +static int mcp3911_set_osr(struct mcp3911 *adc, u32 val)

In the similar way.

...

> +static int mcp3910_set_scale(struct mcp3911 *adc, int channel, u32 val)
> +{
> +	return mcp3911_update(adc, MCP3910_REG_GAIN,
> +			      MCP3911_GAIN_MASK(channel),
> +			      MCP3911_GAIN_VAL(channel, val), 3);
> +}
> +
> +static int mcp3911_set_scale(struct mcp3911 *adc, int channel, u32 val)
> +{
> +	return mcp3911_update(adc, MCP3911_REG_GAIN,
> +			      MCP3911_GAIN_MASK(channel),
> +			      MCP3911_GAIN_VAL(channel, val), 1);
> +}

These can be also converted, but I don't see much difference
(same LoC amount, similar readability).

...

> +	/* Disable offset to ignore any old values in offset register */
> +	return mcp3911_update(adc, MCP3910_REG_CONFIG0,
> +			      MCP3910_CONFIG0_EN_OFFCAL,
> +			      MCP3910_CONFIG0_EN_OFFCAL, 3);

This is a dup code with some of mcp3910_set_offset(). Perhaps a helper?

-- 
With Best Regards,
Andy Shevchenko


