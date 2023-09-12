Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9851179CFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjILLWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjILLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:21:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2898;
        Tue, 12 Sep 2023 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694517679; x=1726053679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=56HV7jHuZyzZZ9uTHHL5L4UREo6SlD9cnmXzbwvt/98=;
  b=hZhENIoX0R57TxNsqXbWCGGqT0+5prRd8/nzZQc5eNxnSONjM9gob1st
   DSOJ3ROoI/fbLq7Nc/qv9SGw45EWxT9RxloPz/GB8whiOx5H8RXLcSUWg
   qJdbYsQQTEB4aGDJbdKYkDu9dCIUqa0mDWot2vebCDj7umcvxuMrQjzg0
   Ez1bRF2Ujy+NEC88JdL5p78iKErDWZPLj7RYQAEHu1NQfVIuIG2CBlNo4
   d33CPdSdEWVLSf88U8smrP45N2YSKH/bWyj+dOjVY8+ZXJyZa5WLpCLt3
   /7YhEhSaprGJ4msgpoCWBAJyy350fFIVCigrawMM639DNt4NazHer6eaG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381045830"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="381045830"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="743692533"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="743692533"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:20:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg1Rs-008ZRc-1d;
        Tue, 12 Sep 2023 14:20:52 +0300
Date:   Tue, 12 Sep 2023 14:20:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 08/11] gpio: of: replace gpiochip_find_* with
 gpio_device_find_*
Message-ID: <ZQBJlJy2NnCJ489y@smile.fi.intel.com>
References: <20230912100727.23197-1-brgl@bgdev.pl>
 <20230912100727.23197-9-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912100727.23197-9-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:07:24PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the OF GPIO code.

...

> +	desc = of_xlate_and_get_gpiod_flags(gdev->chip, &gpiospec, flags);

> +		ret = of_gpiochip_add_hog(gpio_device_get_chip(gdev), rd->dn);

> +		of_gpiochip_remove_hog(gpio_device_get_chip(gdev), rd->dn);

Find the difference in the first parameter in all three.

-- 
With Best Regards,
Andy Shevchenko


