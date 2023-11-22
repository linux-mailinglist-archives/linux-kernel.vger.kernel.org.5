Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AC87F4F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343962AbjKVS03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235416AbjKVS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:26:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EB41BF;
        Wed, 22 Nov 2023 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700677530; x=1732213530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b9T/lmkOzA8qH1gsqzBaEUXEcJ2xCyHprr1GsLX67Go=;
  b=Nd7nsZ/O0PDv0mbGUgxrFrxmMdNl0nqIbmleG0wl6LU5Q9jYMucavz6h
   pVHyKsgdVnhSpFbMHMG1IgB0gU46GmwZX8z8eQSHmeCoJ+csGGjWf7aRa
   6FYbRfws4y4/yYfT23s4OOoewIVrxeC9T5T5uj7OyExkQFmbjf/ySj8D7
   3XteRxuEIYr9H7Z/EOLQB/5+JV5EP+AXQZ1McJ6Mb4QxreS64cqHHLyRU
   L3Vytp8w3MGQGb/iSbTwbRQkcXWH8fSdG+y0LHYZXGgUCR0A14SMiPF2w
   x2sOY8XeHPcg8/RyGKasU3YgNJKGZwYNyzBWruzHUCDJw825DFWmSjfld
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456442927"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="456442927"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 10:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="890499124"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="890499124"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:13:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r5m3a-0000000G5El-1eRf;
        Wed, 22 Nov 2023 14:10:14 +0200
Date:   Wed, 22 Nov 2023 14:10:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/39] dma: cirrus: add DT support for Cirrus EP93xx
Message-ID: <ZV3vpu8uQFq-9ZuF@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-9-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-9-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:59:47AM +0300, Nikita Shubin wrote:
> - drop subsys_initcall code
> - drop platform probe
> - add OF ID match table with data
> - add of_probe for device tree
> - add xlate for m2m/m2p
> - drop platform structs usage

It's not the best commit message (e.g., unaligned with verb "add"
in the Subject).

...

> +		edmac->clk = of_clk_get(np, i);

Why devm_clk_get() can't be used?

>  		if (IS_ERR(edmac->clk)) {
> +			dev_warn(&pdev->dev, "failed to get clock\n");
>  			continue;
>  		}

...

> +	if (direction != DMA_MEM_TO_DEV && direction != DMA_DEV_TO_MEM)
> +		return NULL;

is_slave_direction() ?

...

> +	dev_info(edma->dma_dev.dev, "%s: port=%d", __func__, port);

info level?! Wouldn't be noisy a bit?

...

> +	if (direction != DMA_MEM_TO_DEV && direction != DMA_DEV_TO_MEM)
> +		return NULL;

As per above.

...

> +	dev_info(dma_dev->dev, "EP93xx M2%s DMA ready\n",
> +			       edma->m2m ? "M" : "P");

One line?

...

> +		if (!IS_ERR_OR_NULL(edmac->clk))
> +			clk_put(edmac->clk);

CLK framework is at least NULL aware. Perhaps you can make sure it's never
IS_ERR() and drop this conditional altogether.

...

> -
> +module_platform_driver(ep93xx_dma_driver);

+ blank line.

>  MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
>  MODULE_DESCRIPTION("EP93xx DMA driver");

...

> --- a/include/linux/platform_data/dma-ep93xx.h
> +++ b/include/linux/platform_data/dma-ep93xx.h
> @@ -5,6 +5,7 @@
>  #include <linux/types.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/property.h>

Can this be a bit more ordered, like put before types.h (at least from the
context I see here)?

Also you missing device.h and string.h according to the new function
implementation.

-- 
With Best Regards,
Andy Shevchenko


