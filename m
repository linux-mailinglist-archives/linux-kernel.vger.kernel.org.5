Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D053878849D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbjHYKSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244164AbjHYKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:18:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492FC26AD;
        Fri, 25 Aug 2023 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692958673; x=1724494673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DXvtEtll5/zpeSBBt+eRjKo+MIEcDiI1EFE2uMAjDxI=;
  b=Xb32OIHG5KBJ2AvWFbTtk0lutLfnMrWISZU+QO98dMIvlab5AgJ25s6V
   DZ82rO5p0lwSkcxjyeqMspFrfE2g32tACdj44ZgDV8i3SefFxBbu26XDq
   2OhnrrFjXB7BN4gUI4OSrJWYxo1IAxHF9rrFQnv/aPMWXjlef2YY2qH7P
   vFruIQtklhQMmS2LFApKyE2iFAk8CZnuICEx+7Tg3Ly6r++2PRnGHMe+7
   O3EuL7bxR96uiRizstoC17hbmycYnEWu7FlsFxuAUJegnWIuZCQP9luwI
   A+pRkCQR9Vapi5Jd39WFRHcb4ctYD8JIscLn9f3x/deVrP8ukIoXszm1e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359680475"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359680475"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 03:17:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="911243807"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="911243807"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 25 Aug 2023 03:17:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZTsp-00Cekg-1R;
        Fri, 25 Aug 2023 13:17:39 +0300
Date:   Fri, 25 Aug 2023 13:17:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 4/6] pinctrl: sprd: Add pinctrl support for UMS512
Message-ID: <ZOh/wpBKoO9wYYE4@smile.fi.intel.com>
References: <20230825031826.31599-1-Linhua.xu@unisoc.com>
 <20230825031826.31599-5-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825031826.31599-5-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:18:24AM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> This patch adds the pin control driver for UNISOC UMS512 platform.

Read "Submitting Patches" documentation and find there what to do
with "This patch..."

...

> +config PINCTRL_SPRD_UMS512
> +	tristate "Spreadtrum ums512 pinctrl driver"

> +	depends on OF

Shouldn't you drop this from all drivers you have? I do not see this driver
being dependent on the OF.

> +	depends on ARCH_SPRD || COMPILE_TEST
> +	select PINCTRL_SPRD

...

kernel.h for ARRAY_SIZE()

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>

...

> +#define	PINCTRL_REG_OFFSET		0x34

0x0034

> +#define	PINCTRL_REG_MISC_OFFSET		0x434

> +static int sprd_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return sprd_pinctrl_core_probe(pdev, sprd_ums512_pins_info,
> +				       ARRAY_SIZE(sprd_ums512_pins_info),
> +				       PINCTRL_REG_OFFSET,
> +				       PINCTRL_REG_MISC_OFFSET);
> +}

...

> +static const struct of_device_id sprd_pinctrl_of_match[] = {
> +	{
> +		.compatible = "sprd,ums512-pinctrl",
> +	},

Can be one line.

> +	{ },

Drop trailing comma in the terminator entry.

> +};

...

> +static struct platform_driver sprd_pinctrl_driver = {
> +	.driver = {
> +		.name = "sprd-pinctrl",
> +		.of_match_table = sprd_pinctrl_of_match,
> +	},
> +	.probe = sprd_pinctrl_probe,
> +	.remove = sprd_pinctrl_remove,
> +	.shutdown = sprd_pinctrl_shutdown,
> +};

> +

Redundant blank line.

> +module_platform_driver(sprd_pinctrl_driver);

-- 
With Best Regards,
Andy Shevchenko


