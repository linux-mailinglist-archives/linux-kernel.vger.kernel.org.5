Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F7B774099
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjHHRFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjHHRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:04:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB11A744;
        Tue,  8 Aug 2023 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510527; x=1723046527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XveRea9FANQPUg2+NGfW1ls9tlTN5Z18q/yQQW52Pdg=;
  b=eLl/B+C6sBC8bNHtExz3HCdThPt5hLYA8yttYiQaKVGc9dfy/1XvdrGs
   rEfaDAFJyBXWIeFXgLled8Mt6sYQxuCxAgaiDWefQS/efHAXi2xRlgGoQ
   avBAqH3GDMwnNOMZ3/iGKd4z3kW7t9QF8rbziuaTngdvEpyCqoLJ9tqUR
   7DV1uuPYGez7wQN74dHO/WrylRuvMmR/MGwiG3DneNTNZj9NxDwOfS1gJ
   pqZLCnN8xRiaOUXEzzsnOz+6vcTF5HqK/hVLYeHEe6xyAZKAc++vdfHYa
   7IC4ktsUmotG6zwOY4uAgJvB+ahfic+ke+7yDFvXdsTtsaqdZs/G01gpC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373581385"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="373581385"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 07:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801337918"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="801337918"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2023 07:13:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTNSg-00BIxZ-0M;
        Tue, 08 Aug 2023 17:13:26 +0300
Date:   Tue, 8 Aug 2023 17:13:25 +0300
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
Subject: Re: [PATCH v4 3/4] iio: adc: mcp3911: fix indentation
Message-ID: <ZNJNhSLIv/fazbhz@smile.fi.intel.com>
References: <20230808110432.240773-1-marcus.folkesson@gmail.com>
 <20230808110432.240773-3-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808110432.240773-3-marcus.folkesson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 01:04:31PM +0200, Marcus Folkesson wrote:
> The file does not make use of indentation properly.
> Fix that.

...

>  static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
> -		u32 val, u8 len)
> +			  u32 val, u8 len)

Can val be moved to the previous line?

...

>  		if (ret < 0) {
>  			dev_err(&adc->spi->dev,
>  				"failed to get vref voltage: %d\n",
> -			       ret);
> +				ret);
>  			return ret;

With

	struct device *dev = &adc->spi->dev;

this becomes

			dev_err(dev, "failed to get vref voltage: %d\n", ret);

and one change less here.

>  		}

...

> -#define MCP3911_CHAN(idx) {					\
> -		.type = IIO_VOLTAGE,				\
> -		.indexed = 1,					\
> -		.channel = idx,					\
> -		.scan_index = idx,				\
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
> -			BIT(IIO_CHAN_INFO_OFFSET) |		\
> -			BIT(IIO_CHAN_INFO_SCALE),		\
> -		.info_mask_shared_by_type_available =           \
> -			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> -		.info_mask_separate_available =			\
> -			BIT(IIO_CHAN_INFO_SCALE),		\
> -		.scan_type = {					\
> -			.sign = 's',				\
> -			.realbits = 24,				\
> -			.storagebits = 32,			\
> -			.endianness = IIO_BE,			\
> -		},						\

>  }

This looks like unneeded churn to me.

...

>  	if (ret < 0) {
>  		dev_warn(&adc->spi->dev,
> -				"failed to get conversion data\n");
> +			 "failed to get conversion data\n");
>  		goto out;
>  	}

Same as above with temporary variable for struct device.

-- 
With Best Regards,
Andy Shevchenko


