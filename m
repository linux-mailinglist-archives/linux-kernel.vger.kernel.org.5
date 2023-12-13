Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2D811C21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442288AbjLMSQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjLMSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:16:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D85A12E;
        Wed, 13 Dec 2023 10:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702491393; x=1734027393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HHpVgwc81Z6qFsooEeCAHjTWxZ9ctdHQjE1DZWDlYOg=;
  b=cHLgaY2eaUJkt7x2V2pq7Eal+6mdyr79iSNa1A+V6wdbivYreR2ClWyh
   q3Dhw053/nPs0l/OfYp/lIhtlnu/G7VnrQiVwI/USjlpXV1eLIB40PIvt
   vhxju7kDATibBogVSb2WkUIVbdL/F3YdpGGHtErDoBXZ/sS1+2CMMp67+
   sRWkqUugiz+pD9klZ7Cif1McY8QJLoTYmvtOqICSBSkKJR3A61MoChweV
   PqABeTu/3aH+F9VYUNQV8SP455/Q3I97Jpv7RPIAe0+PkS2JJ9qevs6HT
   rpRs4rbyTnBzae4BVtOtjpNmbRy1rPeTLu/7cFtm660brxyLVUuOu3h1O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16556040"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="16556040"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:16:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1105393970"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1105393970"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:16:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDTmU-00000005bdu-1rty;
        Wed, 13 Dec 2023 20:16:26 +0200
Date:   Wed, 13 Dec 2023 20:16:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 36/40] ata: pata_ep93xx: remove legacy pinctrl use
Message-ID: <ZXn0-pHxIztvRFLK@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-36-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-36-c307b8ac9aa8@maquefel.me>
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

On Tue, Dec 12, 2023 at 11:20:53AM +0300, Nikita Shubin wrote:
> Drop legacy acquire/release since we are using pinctrl for this now.

...

> -	if (IS_ERR(drv_data->dma_rx_channel)) {
> +	if (PTR_ERR_OR_ZERO(drv_data->dma_rx_channel)) {

This seems incorrect.

>  		ret = PTR_ERR(drv_data->dma_rx_channel);
>  		return dev_err_probe(dev, ret, "rx DMA setup failed");

		return dev_err_probe(...);

>  	}

I think you wanted

	ret = PTR_ERR_OR_ZERO(drv_data->dma_rx_channel);
	if (ret)
		return dev_err_probe(dev, ret, "rx DMA setup failed");

...

>  	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
> -	if (IS_ERR(drv_data->dma_tx_channel)) {
> +	if (PTR_ERR_OR_ZERO(drv_data->dma_tx_channel)) {
>  		ret = PTR_ERR(drv_data->dma_tx_channel);
>  		dev_err_probe(dev, ret, "tx DMA setup failed");
>  		goto fail_release_rx;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


