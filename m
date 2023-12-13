Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91D811D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379133AbjLMSs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjLMSs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:48:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6975BD;
        Wed, 13 Dec 2023 10:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702493344; x=1734029344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z/Q+UPMHmt44cji+uKAe1SPXYy0AJonMorDcsxZBYFE=;
  b=QOT/EzKmiOQiIswR4BxDLsOi/xZDGWq94ZCSMh7rCkUcwmd1HVU+RrNJ
   /NnThdGPo2DV0nvMX0gGTOlyvNOdnsv/9BQiIvkQ79A4QvcsO9DR7zpix
   rQe+rOsK6x0B8dHUb9Px/JY5DrQRo6XPuSbGX1WNpljcKSAzhnmyC45HA
   u2SGtV9M3phtRsnJ2kMYS+DAEM3v6wshjyrFKO2VXtnpajhnNRGfm1XrG
   eMDq2iVT/akdE3Jjh19BXBEZUtMqfKqWdtXJ+19yfy7HohLgfCHD7SGCF
   Dx0hxJ9mc/uOo0uBpm5L+8/X9RUHwkM2AltwPjo1qt/m8ck/i17T8YT/v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1825724"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1825724"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="802973014"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="802973014"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:48:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDUHv-00000005c3Y-3yQa;
        Wed, 13 Dec 2023 20:48:55 +0200
Date:   Wed, 13 Dec 2023 20:48:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 36/40] ata: pata_ep93xx: remove legacy pinctrl use
Message-ID: <ZXn8lzb953iDiM_m@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-36-c307b8ac9aa8@maquefel.me>
 <ZXn0-pHxIztvRFLK@smile.fi.intel.com>
 <20231213183349.hdjoxxszrrc4hqrg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213183349.hdjoxxszrrc4hqrg@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 07:33:49PM +0100, Uwe Kleine-König wrote:
> On Wed, Dec 13, 2023 at 08:16:26PM +0200, Andy Shevchenko wrote:
> > On Tue, Dec 12, 2023 at 11:20:53AM +0300, Nikita Shubin wrote:
> > > Drop legacy acquire/release since we are using pinctrl for this now.

...

> > > -	if (IS_ERR(drv_data->dma_rx_channel)) {
> > > +	if (PTR_ERR_OR_ZERO(drv_data->dma_rx_channel)) {
> > 
> > This seems incorrect.
> > 
> > >  		ret = PTR_ERR(drv_data->dma_rx_channel);
> > >  		return dev_err_probe(dev, ret, "rx DMA setup failed");
> > 
> > 		return dev_err_probe(...);
> > 
> > >  	}
> > 
> > I think you wanted
> > 
> > 	ret = PTR_ERR_OR_ZERO(drv_data->dma_rx_channel);
> > 	if (ret)
> > 		return dev_err_probe(dev, ret, "rx DMA setup failed");
> 
> How is that different from
> 
> 	if (IS_ERR(drv_data->dma_rx_channel))
> 		return dev_err_probe(dev, PTR_ERR(drv_data->dma_rx_channel), "....");
> 
> (which seems to be more idiomatic to me)? While I was involved in
> creating PTR_ERR_OR_ZERO, I don't particularily like it (today).

Makes lines shorter, either works for me.

> Also note that you want a \n at the end of error messages.

Indeed.

-- 
With Best Regards,
Andy Shevchenko


