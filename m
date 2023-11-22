Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561707F4613
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbjKVM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344177AbjKVMZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:25:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BD273E;
        Wed, 22 Nov 2023 04:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700655941; x=1732191941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hVCT4/npLTdjlg5tixDfLXiqiZYzc2CLBiSEe1vpvPk=;
  b=ermd5uacni5beL/NzTxmMZPHhVVGw66OOI/DJuc+ZTSQKj2FaTD6wvnz
   mMvO7iqWo/5ftFjob/G3vR25veQa3UTzmsuTxa44LzCO9MraeGFQsbzhl
   e2mUcMDdyO/VFyjFatVJOpQigMJCyT9QVBa4xlTgFLO6md/wImxI6J1R9
   2fOoxGgD3h02valP4mYxXECJASQk/xsrs8JJI+ivVGUPnAtmkK01miSlD
   mGrgNO4qZ4RmnDZ1Bo/TxbbJqJr7OR99tWXrXWI1yt/yGdMoNlhoCnDv5
   k0bG83k1pPjhDoDr8pSLYKb4045BD3bMVcseptJ2i2Fqea+GKpZIeSOq+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="10704213"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="10704213"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:25:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="857709524"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="857709524"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:25:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r5mIS-0000000G5Rf-0h7d;
        Wed, 22 Nov 2023 14:25:36 +0200
Date:   Wed, 22 Nov 2023 14:25:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 21/39] ata: pata_ep93xx: add device tree support
Message-ID: <ZV3zP65l91aq6hNw@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-21-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-21-d59a76d5df29@maquefel.me>
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

On Wed, Nov 22, 2023 at 11:59:59AM +0300, Nikita Shubin wrote:
> - add OF ID match table
> - drop platform DMA and filters
> - change DMA setup to OF, so we can defer probe

...

> +	drv_data->dma_rx_channel = dma_request_chan(dev, "rx");
> +	if (IS_ERR(drv_data->dma_rx_channel)) {
> +		ret = PTR_ERR(drv_data->dma_rx_channel);
> +		return dev_err_probe(dev, ret, "rx DMA setup failed");
> +	}

PTR_ERR_OR_ZERO() as suggested in another patch?

...

> +	drv_data->dma_tx_channel = dma_request_chan(&pdev->dev, "tx");
> +	if (IS_ERR(drv_data->dma_tx_channel)) {
> +		ret = PTR_ERR(drv_data->dma_tx_channel);
> +		dev_err_probe(dev, ret, "tx DMA setup failed");
> +		goto fail_release_rx;
>  	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


