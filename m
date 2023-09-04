Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC17914C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjIDJac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjIDJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:30:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D81BF;
        Mon,  4 Sep 2023 02:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693819828; x=1725355828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MW9q+YZhg4vjahZ7s+Ly/jSrnaKMwzwsb0Yy4HuYxYQ=;
  b=O2iYspfAw5b/ajPCLQ3cBxH7tqe1uXzf2LpPJwOVIBhpJnYgkZW6Q0kM
   ghvbsNGljqoqpCu3MUouDuLiwd/2t3zUxq+i8dmkRcBMtxLsjQRHaereo
   JEzCxXAAWRyV15XFcNAZqfeYWur+V7pNh9TGOyBh0o9kbL/ZjN7vKevVh
   ML0RriWsi4oK4GUv/29Tm+EVJv6DngRR1x0I/lGIU1hkUellFCJirl1+C
   vC/pCBdUAke4/E1k8Z963Ht52MvOsFiTHqJXHNxDfLLC3rzaVykjKjpvZ
   VR7kyUNivuvmjgm3W75Z2Bk02gFWzH3K7XrRgFYEcJJb8uUlmgTro7VB9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="462926132"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="462926132"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:30:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="717480614"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="717480614"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:30:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd5uZ-006O0X-1j;
        Mon, 04 Sep 2023 12:30:23 +0300
Date:   Mon, 4 Sep 2023 12:30:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpiolib: rename gpio_set_debounce_timeout() for
 consistency
Message-ID: <ZPWjr7CP+WK064PI@smile.fi.intel.com>
References: <20230904073410.5880-1-brgl@bgdev.pl>
 <ZPWiZSgyar1zWfR1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPWiZSgyar1zWfR1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:24:53PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 04, 2023 at 09:34:09AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > All other functions that manipulate a struct gpio_desc use the gpiod_
> > prefix. Follow this convention and rename gpio_set_debounce_timeout() to
> > gpiod_set_debounce_timeout().
> 
> No, that's not true. This one is inline with the other gpio_set() _internal_
> APIs. If renamed, should be done consistently.

It's even broader, like for_each_gpio_desc(). So, looking at that one I would
rather use gpio_desc_ prefix / suffix than gpiod in case you are so eager to
rename (Personally I consider this as unneeded churn). Also consider going
thru all _internal_ APIs, like gpiod_not_found(), to be renamed to
gpio_desc_not_found().

-- 
With Best Regards,
Andy Shevchenko


