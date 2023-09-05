Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4075792AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjIEQpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354551AbjIEMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:35:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0981AD;
        Tue,  5 Sep 2023 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693917335; x=1725453335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6lmLJ6H5zU3EUldRsqwHO7V8tPddeVLvBnfcVZaU8Ek=;
  b=TWSg4ROTl4qbTNZ8rxM8TK59bTMFFKxvYueiNyDL7bx4S/6HUeLrFt9Q
   LKnHrTwvdUvxKQqcQhJ36rg9wxBTK7aGR+jzwEoLfzJdZNDrx64fTNSyz
   DIGI8fnWYcoVu/sGXnXhqqDLbapphXE//gdUvBV3b0tts/Xn0LwoQD9Sm
   jPQX1dQnUuFnbQJTgfss0inWfPDWjxNGFjZysnX1v1w/daX/ZJxPrGiR5
   fFFWKpcK+xYGOPJwzVmjD7Mut66VSc6hORXIoxL/BYfqjckg+sPaO6k/C
   OBVtNmH3GtVcC4rb/tJbIwrqAmIqPj6uLNlvqVtzTSWCf2ljM5/11/ugg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="357090284"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="357090284"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:35:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="744256861"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="744256861"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 05:35:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdVHH-006gZh-0h;
        Tue, 05 Sep 2023 15:35:31 +0300
Date:   Tue, 5 Sep 2023 15:35:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZPcgkmotz0kukTZJ@smile.fi.intel.com>
References: <20230905082413.21954-1-brgl@bgdev.pl>
 <ZPcZfd5UtzMmIUvm@smile.fi.intel.com>
 <ZPcaVjOudGeLd5EP@smile.fi.intel.com>
 <CAMRc=McjfYqkX5jL=kwWnceHopebbgDr2XV_h5fjkG=7n7kD-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McjfYqkX5jL=kwWnceHopebbgDr2XV_h5fjkG=7n7kD-Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 02:10:38PM +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 5, 2023 at 2:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Sep 05, 2023 at 03:05:17PM +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 05, 2023 at 10:24:13AM +0200, Bartosz Golaszewski wrote:

...

> > > > +   chip->swnode = swnode;
> > > > +   ret = device_for_each_child(dev, chip, gpio_sim_chip_set_device);
> > > > +   if (!ret)
> > > > +           return -ENODEV;
> > >
> > > Can bus_find_device_by_fwnode() be used here?
> >
> > Answering to myself: you already mentioned that this should cover any bus,
> > so the answer is "no".
> 
> I think I mentioned it under the gpio-consumer where it's true. Here
> we are sure it's on the platform bus.

Then bus_find_device_by_fwnode() can be used here, no?

> > But also we have device_find_child() if I understood the purpose of the above
> > it should suit better, no?
> 
> Right, it's a better match.

In either case be careful about reference counting on the returned dev.

-- 
With Best Regards,
Andy Shevchenko


