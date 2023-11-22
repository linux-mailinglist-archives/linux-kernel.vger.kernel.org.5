Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED9A7F4614
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbjKVM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344252AbjKVMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:25:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89467172C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700655947; x=1732191947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aPEPX+hBinPfZSGmuXVuXAa1a7X48cIoj9/Bph606Dk=;
  b=TZQD2XigeVzPpntbyAYwlFjhX8Es2c78M0UR5z4edUdE4jf9y1wWN4kx
   NFLst7gsZWs9gOMZ8AFKIUc1IsO2Mdjs+AFS+FoLBF8sk341oIE5clhcu
   zVJyK1NNfCsI7M6x9ffOvPiNZdS/y82R/PJlLwtpnzukZOHv/h7n75pFt
   CHzKvGlhI0QdsX/9Lg041sxCnwFZKvCLtFgKDOS/a6B+WNvEU4t93/0NY
   0QEfQc/tBCh4vHV9prZF8J67kk3NCePBKLoVDLjLEcXTtTWgL22HlMpZl
   dDW2FTbl4HAV50fR2g8+yhcjI2AmwNj9mXqVidYO6tjQLRnbPxvuzklnW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="423134301"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="423134301"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:25:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="837365110"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="837365110"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:25:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r5lvW-0000000G57z-1qGE;
        Wed, 22 Nov 2023 14:01:54 +0200
Date:   Wed, 22 Nov 2023 14:01:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Joel Stanley <joel@jms.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Huisong Li <lihuisong@huawei.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Walker Chen <walker.chen@starfivetech.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/39] soc: Add SoC driver for Cirrus ep93xx
Message-ID: <ZV3tsg7qE5IVbNYb@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-7-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-7-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:59:45AM +0300, Nikita Shubin wrote:
> Add an SoC driver for the ep93xx. Currently there is only one thing
> not fitting into any other framework, and that is the swlock setting.
> 
> Used for clock settings, pinctrl and restart.

...

> +# SPDX-License-Identifier: GPL-2.0

only

> +# SPDX-License-Identifier: GPL-2.0

only

> +// SPDX-License-Identifier: GPL-2.0+

or any new

Hmm...

...

> +#include <linux/kernel.h>

JFYI (in case you are using this as a proxy) we have new headers:

array_size,h
sprintf.h

Same applies to all your patches where it's being used.

...

> +#include <linux/soc/cirrus/ep93xx.h>
> +
> +

One blank line is enough.

...

> +static const char __init *ep93xx_get_soc_rev(struct regmap *map)
> +{
> +	switch (ep93xx_soc_revision(map)) {
> +	case EP93XX_CHIP_REV_D0:
> +		return "D0";
> +	case EP93XX_CHIP_REV_D1:
> +		return "D1";
> +	case EP93XX_CHIP_REV_E0:
> +		return "E0";
> +	case EP93XX_CHIP_REV_E1:
> +		return "E1";
> +	case EP93XX_CHIP_REV_E2:
> +		return "E2";
> +	default:
> +		return "unknown";
> +	}
> +}

+ Blank line.

> +const char *pinctrl_names[] = {
> +	"pinctrl-ep9301",	/* EP93XX_9301_SOC */
> +	"pinctrl-ep9307",	/* EP93XX_9307_SOC */
> +	"pinctrl-ep9312"	/* EP93XX_9312_SOC */

I would leave a trailing comma.

> +};

...

> +	enum ep93xx_soc_model model = (int)of_device_get_match_data(&pdev->dev);

Same comment about uintptr_t casting.

-- 
With Best Regards,
Andy Shevchenko


