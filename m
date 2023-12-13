Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1C811D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjLMSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbjLMSlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:41:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A6D184;
        Wed, 13 Dec 2023 10:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702492917; x=1734028917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YngtccBgY9Zef0aGOZCL52WGR+Vqvpk1pqOsy5KFJjs=;
  b=EZywXAp476EljwD1Gt4rF6bA60kBWvdJNjqknpNqLsrOe639JJ/5OtmP
   RWqaBjLpc+4m/Pb/Mkrv5tK93H/K1br0B9WVf+gH4q5qvJln8O9rdwyt0
   AjdLq7PvsIyhBdnlHph3rIRr1qHzPRLFf/6xWWQaO1NZiaK7rPajdhaf1
   vARi+ZcBxR9qDYensg1jvB8g76VasvQESU3sntPWSS/LZYOIM3aNbBsgq
   ALWqW8Q8odCzYypgPh9m+62kWKqwArO2t8T17Fnjlo/8nFLwR3Nl7gKW1
   VhzOUxUZVjqQidfkOZuO83R5F6p6dCRXxOWyATq9CEnnOgB1r7yb3K0aA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1824973"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1824973"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:41:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="897427472"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="897427472"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:41:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rDUB3-00000005bxZ-1waF;
        Wed, 13 Dec 2023 20:41:49 +0200
Date:   Wed, 13 Dec 2023 20:41:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 24/40] input: keypad: ep93xx: add DT support for
 Cirrus EP93xx
Message-ID: <ZXn67cynJdto4lAb@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-24-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-24-c307b8ac9aa8@maquefel.me>
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

On Tue, Dec 12, 2023 at 11:20:41AM +0300, Nikita Shubin wrote:
> - drop flags, they were not used anyway
> - add OF ID match table
> - process "autorepeat", "debounce-delay-ms", prescale from device tree
> - drop platform data usage and it's header
> - keymap goes from device tree now on

...

>  static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
>  {
>  	unsigned int val = 0;
>  
> +	val |= ((keypad->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK);

Since you are touching these lines (see below) you can drop unneeded outer
parentheses.

>  
> +	val |= ((keypad->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);

See above.

>  	__raw_writel(val, keypad->mmio_base + KEY_INIT);
>  }

-- 
With Best Regards,
Andy Shevchenko


