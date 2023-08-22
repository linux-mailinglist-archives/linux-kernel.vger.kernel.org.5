Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24587842AB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbjHVN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjHVN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:59:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441681BD;
        Tue, 22 Aug 2023 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692712785; x=1724248785;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UNZMHUKfA/nQgTn9id3c+zcGgCLfI4g9Gg00w5kcePs=;
  b=lnbnL75P+wrdfBG6GRsia/Ypd/mUn0Jroe5j++9H//y9N5BW976dX9Te
   g+WCFrIa2YWxGMbfn0UX3kDq72d7WslNjeHe/ceuLgXc0uNUoWeE8R1nc
   xNfF0qajW0mdH+Q1iZf8bpsj3KXEWfB1Yfv7XEeIw3F/TEHrk7URwy9OO
   fmiCKrSnxtArMMYR6MGxUOFrJDvYTkT4IwwzlfppsxUp64ySEPxRqM/Ik
   UBuDL8vizhF7MU1G8x4hrOQBAtaRq5iMxRIBnicESmFD2D32gUO3RF3VT
   nTSjAxyY3D26d7AFByCavfixagUuPl/rzxatz8W+9e/ceDjQaTRz6P8Gv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376623875"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="376623875"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="982877938"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="982877938"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 22 Aug 2023 06:59:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYRul-00DFvq-11;
        Tue, 22 Aug 2023 16:59:23 +0300
Date:   Tue, 22 Aug 2023 16:59:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpio: sim: pass the GPIO device's software node to
 irq domain
Message-ID: <ZOS/O7T/KF14eCqD@smile.fi.intel.com>
References: <20230822075122.6900-1-brgl@bgdev.pl>
 <20230822075122.6900-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822075122.6900-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 09:51:22AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Associate the swnode of the GPIO device's (which is the interrupt
> controller here) with the irq domain. Otherwise the interrupt-controller
> device attribute is will be a no-op.

"is will be" ?

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: cb8c474e79be ("gpio: sim: new testing module")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/gpio/gpio-sim.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index 27515384aa10..835999343f16 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -414,7 +414,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
>  	if (!chip->pull_map)
>  		return -ENOMEM;
>  
> -	chip->irq_sim = devm_irq_domain_create_sim(dev, NULL, num_lines);
> +	chip->irq_sim = devm_irq_domain_create_sim(dev, swnode, num_lines);
>  	if (IS_ERR(chip->irq_sim))
>  		return PTR_ERR(chip->irq_sim);
>  
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


