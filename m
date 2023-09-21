Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D227A9712
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjIURLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjIURJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:09:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605957290;
        Thu, 21 Sep 2023 10:05:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="466801385"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="466801385"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:27:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="776381793"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="776381793"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:27:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1qjHq4-0000000GsPk-2hpT;
        Thu, 21 Sep 2023 14:27:20 +0300
Date:   Thu, 21 Sep 2023 14:27:20 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V2 3/4] gpio: sprd: Modify the calculation method of eic
 number
Message-ID: <ZQwomPRn0HaqHMgK@smile.fi.intel.com>
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
 <20230921090027.11136-4-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921090027.11136-4-Wenhua.Lin@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 05:00:26PM +0800, Wenhua Lin wrote:
> When the soc changes, the corresponding gpio-eic-sprd.c
> code needs to be modified, and the corresponding
> Document must also be modified, which is quite troublesome.
> To avoid modifying the driver file, the number of EICs
> is automatically calculated by matching dts nodes.

> Fixes: 2788938b7946 ("gpio: eic-sprd: Make the irqchip immutable")
> 
> Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>

Same comment as per patch 1. Also, fixes needs to be grouped at the beginning
of the series. (I don't remember seeing Fixes tag in the patch 2.)

...

> +#define SPRD_EIC_VAR_DATA(soc_name)				\

Misindented \

> +static const struct sprd_eic_variant_data soc_name##_eic_dbnc_data = {	\
> +	.type = SPRD_EIC_DEBOUNCE,					\
> +};									\

...

>  	struct sprd_eic *sprd_eic;
>  	struct resource *res;

>  	int ret, i;
> +	u16 num_banks = 0;

Preserve reversed xmas tree order.

-- 
With Best Regards,
Andy Shevchenko


