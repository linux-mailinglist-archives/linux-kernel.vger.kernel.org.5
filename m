Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01577A426D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbjIRHb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbjIRHam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:30:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADED9129;
        Mon, 18 Sep 2023 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695022226; x=1726558226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nEHYuNO2Tri2ErH9EU6gTZpEDiK3nEfVaAIgLoF4k/A=;
  b=ddaP/uzuINxViNHD5kMu3D8vu+8eUTHEYbUhDDGhfsMUi+9RKnsw1v2D
   c2kAOckkSQvr+HFzFrFnJyqwb7l94Yyv+MKbVHNk4Itp0RmnR7q7wWhaF
   WToqZUoSIPNtPiU94cu5/wAMUMhKuWwAqP391290AXP9ja+SsVMM7NHQS
   10zlskBtuugVaCNQ1hQfvT36CuPgiuflqKp74RB/QQ6dhqWEnEmtOxdnj
   L0tGIrYNyL6fy89Esr/PxY7Arb+Um6JeXwedWzXw8sSFYs9UNXkBOYSn4
   KwlfQfLgGVjZuBtvKddTap5DEskJB+VVHVFVzYtZqqi+cuyg4LitH+sN+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="359003954"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="359003954"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:28:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="860949152"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="860949152"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:27:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qi8fd-0000000EYoE-3dJF;
        Mon, 18 Sep 2023 10:27:49 +0300
Date:   Mon, 18 Sep 2023 10:27:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 30/42] input: keypad: ep93xx: add DT support for
 Cirrus EP93xx
Message-ID: <ZQf79f6hjGcXR0aG@smile.fi.intel.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-30-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-ep93xx-v4-30-a1d779dcec10@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:11:12AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> - drop flags, they were not used anyway
> - add OF ID match table
> - process "autorepeat", "debounce-delay-ms", prescale from device tree
> - drop platform data usage and it's header
> - keymap goes from device tree now on

...

>  #include <linux/bits.h>
>  #include <linux/module.h>
> +#include <linux/of.h>

Is this correct header? Shouldn't be property.h?

>  #include <linux/platform_device.h>

> +#include <linux/mod_devicetable.h>

Can you. please, try to squeeze them to most ordered parts?

>  #include <linux/interrupt.h>
>  #include <linux/clk.h>

-- 
With Best Regards,
Andy Shevchenko


