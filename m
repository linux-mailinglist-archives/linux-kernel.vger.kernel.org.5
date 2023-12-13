Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717FA811CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjLMShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:37:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE2AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702492638; x=1734028638;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EOhMcZbrvHstdBAULniZzSThfnXX++EnI56G1uShkgc=;
  b=fIdZb9ZbdyXWiYCE9jNQonZa1028zhwzNqjWvOiIJ2LZfqfGdHOxAS0p
   biiYKpqSa3i+sTGo+H7dZGY89A0hZCGSeUAtAgobdPaHjnuYgSRr9IND2
   76lVk4cONGP+SgSDQF8vVsWyzV5yG5HQBQlZr/uECZvZVqpM/P2e+4tMN
   Wxe82oVV/65W0LAjDrcMIzwIX5OAalMkzCfMFaInGnXM60soU92fUJnDi
   QD/4qIuWKYFDtEvpEk2aJ1wjMBNDyVaZ+hq5Ky2sgUcNC3xQ31dr74GMq
   MlSeQK+PrGXWqMwiy1MQHMgn8b1pDTNFkoccp2Zg1NsYGDklKp7kdyHU7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="13706839"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="13706839"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:37:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="839986312"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="839986312"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:37:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1rDU6Z-00000005bto-03zh;
        Wed, 13 Dec 2023 20:37:11 +0200
Date:   Wed, 13 Dec 2023 20:37:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Walker Chen <walker.chen@starfivetech.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Huisong Li <lihuisong@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Wei Xu <xuwei5@hisilicon.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/40] soc: Add SoC driver for Cirrus ep93xx
Message-ID: <ZXn51mcYslZzQ3y-@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-8-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-8-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:20:25AM +0300, Nikita Shubin wrote:
> Add an SoC driver for the ep93xx. Currently there is only one thing
> not fitting into any other framework, and that is the swlock setting.

...

> +/*
> + * SoC driver for Cirrus EP93xx chips.
> + * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
> + *
> + * Based on a rewrite of arch/arm/mach-ep93xx/core.c
> + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> + * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
> + *
> + * Thanks go to Michael Burian and Ray Lehtiniemi for their key
> + * role in the ep93xx Linux community

Missing period.

> + */

...

> +#include <linux/bits.h>
> +#include <linux/init.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/platform_device.h>

Isn't this an incorrect header and should be auxiliary one?

> +#include <linux/regmap.h>
> +#include <linux/slab.h>

+ spinlock.h ?

But since it's a new code, why not cleanup.h?

> +#include <linux/sys_soc.h>

...

> +	enum ep93xx_soc_model model = (int)(uintptr_t)of_device_get_match_data(&pdev->dev);

int?

Maybe

	strict device *dev = &pdev->dev;
	enum ep93xx_soc_model model;
	...
	model = (enum ep93xx_soc_model)(uintptr_t)device_get_match_data(dev);

?

...

> +	struct device *dev = &pdev->dev;

Ah you even have this already!

...

> +	dev_info(dev, "EP93xx SoC revision %s\n", attrs->revision);

Hmm... Is this message anyhow useful?

-- 
With Best Regards,
Andy Shevchenko


