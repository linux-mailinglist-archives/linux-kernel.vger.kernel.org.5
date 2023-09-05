Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073C37927E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237172AbjIEQET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354475AbjIEL7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:59:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC7F1AB;
        Tue,  5 Sep 2023 04:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693915161; x=1725451161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TcBkexx1ijuD6/7qzSOMMmTOOVh0jXXDYPWa8+VyVY4=;
  b=RKlXh3U0vw4fy6pE/3/82fyF0IQD15hvIZA7hne3ZUb/+CqL3l+ufJ/t
   E+KaT6IZnWiy+sZp0K9/FJMGt4dCpBvl4lDsKdbYyf8PY7NJCmB5kMkRG
   b4Iu+efmni5wrQyc/0CDI75MJVmOv0cT6HO3PCpme58Xl17Bg0buOVyc9
   //2yASEAJHIRl2RXnQXrLYMT8ZldHCIh5KOY0gK0wLaH/rPkX7gOYOwfK
   VkZP0FzoIhqGCe2Uez4/s3V80xvVgTvkZ3kEg9uacDEa2Yi6UkQJQjR51
   zA7uH25tGh7ugnB2BQfLdMDfLz/1mdtIzl2zsgTrF23DNXCpIhQUbSyi8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="407764460"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="407764460"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 04:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806575589"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="806575589"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 04:59:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdUiD-006g0F-06;
        Tue, 05 Sep 2023 14:59:17 +0300
Date:   Tue, 5 Sep 2023 14:59:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpiolib: rename gpio_chip_hwgpio() for consistency
Message-ID: <ZPcYFF7sSrriFYqV@smile.fi.intel.com>
References: <20230904073410.5880-1-brgl@bgdev.pl>
 <20230904073410.5880-2-brgl@bgdev.pl>
 <ZPWjAUzqeAwF1wro@smile.fi.intel.com>
 <CAMRc=MeMYi0KbK=1RYGX2zbUjVZyQp-Y_aXfy6+EZcEtUSEU0A@mail.gmail.com>
 <ZPcEFXF9Fz762kzK@smile.fi.intel.com>
 <CAMRc=MctTGNe2v8bBKQp6Dh3EuhP+OmO8yxrMgrHT3+m2AGjnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MctTGNe2v8bBKQp6Dh3EuhP+OmO8yxrMgrHT3+m2AGjnQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 01:26:34PM +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 5, 2023 at 12:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Sep 05, 2023 at 10:37:32AM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 4, 2023 at 11:27 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Sep 04, 2023 at 09:34:10AM +0200, Bartosz Golaszewski wrote:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > All other functions that manipulate a struct gpio_desc use the gpiod_
> > > > > prefix. Follow this convention and rename gpio_chip_hwgpio() to
> > > > > gpiod_get_hwgpio().
> > > >
> > > > Same comment. Also, I don't think it's good idea as it steps on the exported
> > > > API's toes. I.o.w. I won't mix those two.
> > >
> > > Even if I agreed with your other comment, gpio_chip_hwgpio() is a
> > > terrible name and if I didn't know, I couldn't tell you what it does
> > > just from looking at the name.
> >
> > That's can be improved, my previous comments were basically to avoid
> > mixing prefixes for internal and external APIs, let's say prefix them
> > similarly, but for internal with space and/or more verbose naming
> >
> >         gpiod_          gpio_desc_
> >         gpiochip_       gpio_chip_
> >         gdev_           gpio_device_
> 
> There's one more possibility. Have all exported symbols be prefixed
> with gpiod in one way or another and the internal symbols just drop
> the prefix so it would be like:
> 
> gpiod_
> gpiochip_
> gpio_device_
> 
> and
> 
> desc_
> chip_
> device_
> 
> Because for internal symbols we already know they refer to gpiolib.

With the above schema we have two caveats, one is not significant
(as we have desc_to_gpio() and complimentary API). And another one
is device/dev, which is conflicting with global. That's why I still
prefer gpio_desc_ and so on.

> Anyway, I'll drop the patches for now and let's revisit in the future
> when the consensus is reached.

Yes, let's focus on something more important now.

-- 
With Best Regards,
Andy Shevchenko


