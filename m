Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E8793E87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240489AbjIFOQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIFOQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:16:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4910CC;
        Wed,  6 Sep 2023 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694009769; x=1725545769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0VcmV16fT8VmJAsdObBcJuWeG66DH8vv5hB7iUtf9Fk=;
  b=Pkdeh21jdhUaBzLo2BBA95Zwm5kTX4I1WB8tNbtHulHLFrhZ1PFi8fl+
   0sNdSDqRweXeC2+M5/0stoZ4cDLJQYQHtATSL4K9fenStYtRnnBOzxOAr
   DhXgqTWFl2E3aQZGJ7AiVCxZhhowiyugJbS3Yk/zPwi/c0TNkqoPRW/pq
   yBTRLdg6i9VAFgZjlf3tBHJzw1TeTn+xmAnZsCmYZtekHHHYavpYCeHXb
   XmVxq2JOzgX7rQxJOhw+/DrkO5H5diFDA5IQ7kM/SRzfF0ANn/c85Yh55
   SyRln+tDpGWH5BM2DLh0s0TtfA+gecrpeNDgS0gE0fifAVl0usdPeSoqT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441051172"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="441051172"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:16:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="735072513"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="735072513"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:16:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdtK3-006xcz-1V;
        Wed, 06 Sep 2023 17:15:59 +0300
Date:   Wed, 6 Sep 2023 17:15:59 +0300
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
Subject: Re: [PATCH 04/21] gpiolib: provide gpio_device_get_desc()
Message-ID: <ZPiJn5I4SI034bn6@smile.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905185309.131295-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:52:52PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Getting the GPIO descriptor directly from the gpio_chip struct is
> dangerous as we don't take the reference to the underlying GPIO device.
> In order to start working towards removing gpiochip_get_desc(), let's
> provide a safer variant that works with an existing reference to struct
> gpio_device.

...

> +/**
> + * gpio_device_get_desc() - get the GPIO descriptor corresponding to the given
> + *                          hardware number for this GPIO device
> + * @gdev: GPIO device to get the descriptor from
> + * @hwnum: hardware number of the GPIO for this chip
> + *
> + * Returns:
> + * A pointer to the GPIO descriptor or ``ERR_PTR(-EINVAL)`` if no GPIO exists

The known constants can be referenced as %EINVAL.

> + * in the given chip for the specified hardware number or ``ERR_PTR(-ENODEV)``

Ditto.

> + * if the underlying chip already vanished.
> + *
> + * The reference count of struct gpio_device is *NOT* increased like when the
> + * GPIO is being requested for exclusive usage. It's up to the caller to make
> + * sure the GPIO device will stay alive together with the descriptor returned
> + * by this function.
> + */

-- 
With Best Regards,
Andy Shevchenko


