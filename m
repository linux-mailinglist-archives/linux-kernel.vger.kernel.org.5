Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58649793E6A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbjIFOKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjIFOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:10:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B51726;
        Wed,  6 Sep 2023 07:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694009427; x=1725545427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F7bl2h3DX3KJUesLeL2e/fpx9L5jnQCY/nK4NgE/LN8=;
  b=g3TfX+F5c9xs045JV9UkPGwPcOsj25+u2hqakhIJSlX5rsF/Xnj+2PbX
   GFOUeqZxs1Omg3vIbqQoir+ARc9lysQGgTbH1lgVFKuzr2wIE3LQF5Dkl
   LVPw/mEiJWCmdAR4HCu/aP9PXgiWO/3JSdpmPo/OaqRJcAyB+/2dFLsy4
   fJ+zadFSrAZsoP2M8E4LWE7t6OvVY9G7h+fg3Z8loUTRNpqBR2VRVWPRh
   gKhXFt91pM8pzQFuyWtfVd3rHmUWpC0yGL3FdxgGlD8yWVFGfkUdypJ9K
   EQfqvoL8PafH9Q1XCCFqblVCAkFqmy9VY3mDMUPokCMjvYcGcMiit++O3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441049792"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="441049792"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="735068521"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="735068521"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:10:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdtEY-006xYP-12;
        Wed, 06 Sep 2023 17:10:18 +0300
Date:   Wed, 6 Sep 2023 17:10:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 02/21] gpiolib: provide gpio_device_find()
Message-ID: <ZPiISpLoVx35PuYc@smile.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905185309.131295-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:52:50PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpiochip_find() is wrong and its kernel doc is misleading as the
> function doesn't return a reference to the gpio_chip but just a raw
> pointer. The chip itself is not guaranteed to stay alive, in fact it can
> be deleted at any point. Also: other than GPIO drivers themselves,
> nobody else has any business accessing gpio_chip structs.
> 
> Provide a new gpio_device_find() function that returns a real reference
> to the opaque gpio_device structure that is guaranteed to stay alive for
> as long as there are active users of it.

...

> +/**
> + * gpio_device_find() - find a specific GPIO device
> + * @data: data to pass to match function
> + * @match: Callback function to check gpio_chip

> + * Returns:
> + * New reference to struct gpio_device.

I believe this is wrong location of the Return section.
AFAIU how kernel doc uses section markers, this entire description becomes
a Return(s) section. Have you tried to render man/html/pdf and see this?

> + * Similar to bus_find_device(). It returns a reference to a gpio_device as
> + * determined by a user supplied @match callback. The callback should return
> + * 0 if the device doesn't match and non-zero if it does. If the callback
> + * returns non-zero, this function will return to the caller and not iterate
> + * over any more gpio_devices.
> + *
> + * The callback takes the GPIO chip structure as argument. During the execution
> + * of the callback function the chip is protected from being freed. TODO: This
> + * actually has yet to be implemented.
> + *
> + * If the function returns non-NULL, the returned reference must be freed by
> + * the caller using gpio_device_put().
> + */
> +struct gpio_device *gpio_device_find(void *data,

> +				     int (*match)(struct gpio_chip *gc,
> +						  void *data))

One line?
Or maybe a type for it? (gpio_match_fn, for example)

> +{
> +	struct gpio_device *gdev;
> +
> +	guard(spinlock_irqsave)(&gpio_lock);
> +
> +	list_for_each_entry(gdev, &gpio_devices, list) {
> +		if (gdev->chip && match(gdev->chip, data))
> +			return gpio_device_get(gdev);
> +	}
> +
> +	return NULL;
> +}

...

> +struct gpio_device *gpio_device_find(void *data,
> +				     int (*match)(struct gpio_chip *gc,
> +						  void *data));

Ditto.


-- 
With Best Regards,
Andy Shevchenko


