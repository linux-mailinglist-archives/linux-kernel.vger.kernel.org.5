Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9CA77CE88
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbjHOOyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237783AbjHOOx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:53:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF7DE5B;
        Tue, 15 Aug 2023 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692111239; x=1723647239;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8cZYt7HFAnk2MmSwXTT2RjgwpBr32yZmczsS440Qatw=;
  b=Vv7sNR3/duZXS1dd7e7sSt9EfIfKffR5uw0GNL3gw5J6EL0o6e06KBNh
   Vy3ZmMwMd/YIGx/0vPPKWqoGnKtiCbyxldkElDvGHyJ8yj5lh1WOi3o/6
   zIlblfbtGUeKKizPiap8yKaSyEzkGJ0Cs/5WwGKXLzLywvBBCzalvtBaw
   pTDJtT55X43tQmruEmmThMreQE8FevHaalzMMua6UMzhUn3RS7t0LGj4n
   atADgBfdHi1zVk0bh2kA/fmo5m4HohKGGOQq51hUeUz/gAdsIFVBqNwM0
   KGD1qOthzNBpeLE5ZD8G0QhYflK50aohws1EeYCGLzUAa/Q05xGPpWMcI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371207049"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="371207049"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="907630159"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="907630159"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2023 07:53:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvQd-0065qi-2C;
        Tue, 15 Aug 2023 17:53:51 +0300
Date:   Tue, 15 Aug 2023 17:53:51 +0300
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
Subject: Re: [PATCH v5 3/6] iio: adc: mcp3911: simplify usage of spi->dev
Message-ID: <ZNuRf3hZ9Z2fddxa@smile.fi.intel.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
 <20230814121010.184842-3-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121010.184842-3-marcus.folkesson@gmail.com>
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

On Mon, Aug 14, 2023 at 02:10:07PM +0200, Marcus Folkesson wrote:
> Replace the usage of `adc->spi->dev` with `dev` to make the code prettier.

...

>  	u32 ref = MCP3911_INT_VREF_MV;
> +	struct device *dev = &adc->spi->dev;

Keep it upper.

>  	u32 div;
>  	int ret;
>  	u64 tmp;

...

> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      NULL,

This can be moved to the upper line.

> +					      mcp3911_trigger_handler, NULL);
>  	if (ret)
>  		return ret;

...

With above addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


