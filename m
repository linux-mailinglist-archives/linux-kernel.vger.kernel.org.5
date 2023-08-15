Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE3B77CE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbjHOOhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237693AbjHOOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:36:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B219A4;
        Tue, 15 Aug 2023 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692110212; x=1723646212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rtgdSA9vcQoHmkbubdnn9solITQI/tTkYq65Mu7X6gY=;
  b=VhOgHn8V0RoGNFP/BqQ6DUzXDhvKQVzQZyvuRJNbxVLyQ1ICZa7jBEDv
   RVPtlpN/qt2CTNyt/6ZsFR0ual0ts7GCi5uYkQ24vwExzhgSsiNfWcuyV
   UNFsfUlxL3VFWGpjilhqMMPSTZze+AcBcUVi7hPtMmeGW+VRUgKdwC1Qk
   uZ3+/7UgrXgESbtju8/wjl7GGpz4Nn5JRR9AbU8w31XTHMVE0eeqbAuRO
   FRQF70sQa4JUrzVGUiFpHnZPHRXG/rMZQM0JyMgbIiW863MT4Fzp4yrwn
   2gsi8Ml2g6A2wnYVPHy26gyYElVm341sf0hwyp3fK3fLyfLQsdA40z+19
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376023162"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="376023162"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799211216"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="799211216"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2023 07:36:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvA1-005Uej-29;
        Tue, 15 Aug 2023 17:36:41 +0300
Date:   Tue, 15 Aug 2023 17:36:41 +0300
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
Subject: Re: [PATCH v5 2/6] iio: adc: mcp3911: make use of dev_err_probe()
Message-ID: <ZNuNedpsuPmdfumG@smile.fi.intel.com>
References: <20230814121010.184842-1-marcus.folkesson@gmail.com>
 <20230814121010.184842-2-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121010.184842-2-marcus.folkesson@gmail.com>
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

On Mon, Aug 14, 2023 at 02:10:06PM +0200, Marcus Folkesson wrote:
> Simplify code by switch to dev_err_probe().
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
> Notes:
>     v5:
>         - New patch in this series
> 
>  drivers/iio/adc/mcp3911.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 974c5bd923a6..681248a3ddde 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -468,6 +468,7 @@ static int mcp3911_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct mcp3911 *adc;
> +	struct device *dev = &spi->dev;
>  	int ret;

With preserved reversed xmas tree order (longer line comes first),
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> @@ -482,10 +483,7 @@ static int mcp3911_probe(struct spi_device *spi)
>  		if (PTR_ERR(adc->vref) == -ENODEV) {
>  			adc->vref = NULL;
>  		} else {
> -			dev_err(&adc->spi->dev,
> -				"failed to get regulator (%ld)\n",
> -				PTR_ERR(adc->vref));
> -			return PTR_ERR(adc->vref);
> +			return dev_err_probe(dev, PTR_ERR(adc->vref), "failed to get regulator\n");
>  		}
>  
>  	} else {
> @@ -504,10 +502,7 @@ static int mcp3911_probe(struct spi_device *spi)
>  		if (PTR_ERR(adc->clki) == -ENOENT) {
>  			adc->clki = NULL;
>  		} else {
> -			dev_err(&adc->spi->dev,
> -				"failed to get adc clk (%ld)\n",
> -				PTR_ERR(adc->clki));
> -			return PTR_ERR(adc->clki);
> +			return dev_err_probe(dev, PTR_ERR(adc->clki), "failed to get adc clk\n");
>  		}
>  	}
>  
> -- 
> 2.41.0
> 

-- 
With Best Regards,
Andy Shevchenko


