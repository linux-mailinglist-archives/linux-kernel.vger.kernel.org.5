Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD87915B4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbjIDK3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238285AbjIDK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:29:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57987EB;
        Mon,  4 Sep 2023 03:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693823348; x=1725359348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=w6903lkUD2Wjd8BhRcIqgIqE9OORrcNm+1vWaZu4tTc=;
  b=PcvsUCGv/vWF81wKWij5lkhacOAdMfJebXwiB4mEgsVVjPVTbbxtTKKD
   g9LZz0q9uVizqzY8OsKiBylhf9cGjz0f10K4of3+1AJC3XKynrxreRgNV
   dcWtQSG4GOfd+IPH7XuOxHR0X4ieEcLa6tBzRNrFs8eUq1IhR3Pm2CpGV
   mQxYdtcqhyLdVPhud3S9I3tYMGafYpqlmMAZVtlf/iFIDHMY5Rj39hx7G
   4TQqUKFvlAZdMHDs3Hq+2O3oAyJ4pb/wl7DHxu4YPReyPvrQ/mmVHmnN9
   0+aG9ARZa+n6zAaKdVNultU9Xyp6hA2HBMcTnL08Xu/V+deIk1fQe4XZM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="375460500"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="375460500"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:29:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="806219515"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="806219515"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:29:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6pJ-006Oq0-2A;
        Mon, 04 Sep 2023 13:29:01 +0300
Date:   Mon, 4 Sep 2023 13:29:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZPWxbfHNOqAnkR09@smile.fi.intel.com>
References: <20230901183240.102701-1-brgl@bgdev.pl>
 <ZPJTT/l9fX1lhu6O@smile.fi.intel.com>
 <CAMRc=Mekf9Rek3_G2ttQY+yBvWM3+P4RAWVOQH99eajn38F+og@mail.gmail.com>
 <ZPWcTMPiu4MSq+F7@smile.fi.intel.com>
 <CAMRc=MfZv70FXHyNw4yK90NL5-jjAJa6qbKc6SV2ZwbaJkKQqg@mail.gmail.com>
 <ZPWmDL6QJJMNi2qa@smile.fi.intel.com>
 <CAMRc=Mc0JgPUEpaes7WcbkMu5JyrpLW8N1+bM-+OJaB+pPX4ew@mail.gmail.com>
 <ZPWr3dRP5C1GSY9F@smile.fi.intel.com>
 <CAMRc=Mfae+=HPPWzsG8bgK2CGOGY9GPkS5VZcwLyr_yY8A_y2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfae+=HPPWzsG8bgK2CGOGY9GPkS5VZcwLyr_yY8A_y2g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 12:12:44PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 4, 2023 at 12:05 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Sep 04, 2023 at 11:47:54AM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 4, 2023 at 11:40 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Mon, Sep 04, 2023 at 11:22:32AM +0200, Bartosz Golaszewski wrote:
> > > > > On Mon, Sep 4, 2023 at 10:59 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Sat, Sep 02, 2023 at 04:40:05PM +0200, Bartosz Golaszewski wrote:
> > > > > > > On Fri, Sep 1, 2023 at 11:10 PM Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > On Fri, Sep 01, 2023 at 08:32:40PM +0200, Bartosz Golaszewski wrote:

...

> > > > > > > > > -     /* Used by sysfs and configfs callbacks. */
> > > > > > > > > -     dev_set_drvdata(&gc->gpiodev->dev, chip);
> > > > > > > > > +     /* Used by sysfs callbacks. */
> > > > > > > > > +     dev_set_drvdata(swnode->dev, chip);
> > > > > > > >
> > > > > > > > dev pointer of firmware node is solely for dev links. Is it the case here?
> > > > > > > > Seems to me you luckily abuse it.
> > > > > > >
> > > > > > > I don't think so. If anything we have a helper in the form of
> > > > > > > get_dev_from_fwnode() but it takes reference to the device while we
> > > > > > > don't need it - we know it'll be there because we created it.
> > > > > > >
> > > > > > > This information (struct device of the GPIO device) can also be
> > > > > > > retrieved by iterating over the device children of the top platform
> > > > > > > device and comparing their fwnodes against the one we got passed down
> > > > > > > from probe() but it's just so many extra steps.
> > > > > > >
> > > > > > > Or we can have a getter in gpio/driver.h for that but I don't want to
> > > > > > > expose another interface is we can simply use the fwnode.
> > > > > >
> > > > > > dev pointer in the fwnode strictly speaking is optional. No-one, except
> > > > > > its solely user, should rely on it (its presence and lifetime).
> > > > >
> > > > > Where is this documented? Because just by a quick glance into
> > > > > drivers/base/core.c I can tell that if a device has an fwnode then
> > > > > fwnode->dev gets assigned when the device is created and cleared when
> > > > > it's removed (note: note even attached to driver, just
> > > > > created/removed). Seems like pretty reliable behavior to me.
> > > >
> > > > Yes, and even that member in fwnode is a hack in my opinion. We should not mix
> > > > layers and the idea in the future to get rid of the fwnode_handle to be
> > > > _embedded_ into struct device. It should be separate entity, and device
> > > > instance may use it as a linked list. Currently we have a few problems because
> > > > of the this design mistake.
> > >
> > > I don't see how this would work if fwnodes can exist before struct
> > > device is even created.
> >
> > That's whole idea behind swnodes. They (ideally) should be created _before_
> > any other object they are being used with. This is how it works today.
> 
> Yes, this is what I meant: if fwnodes can be created before struct
> device (as it is now) and their life-time is separated then how could
> you possibly make the fwnode part of struct device?
> 
> > And doing swnode->dev = ... contradicts a lot: layering, lifetime objects, etc.
> 
> No it doesn't. We have the software node - the template for the
> device. It can only be populated with a single device entry.

Which is wrong assumption. Software nodes (and firmware nodes) in general
can be shared. Which device pointer you want to add there? Which one
should be next when one of the devices is gone?

No, simply no. Do not use it!

> Once it's done, I don't see why you wouldn't want to assign this device to
> its corresponding software node. Provided locking is in place etc.
> 
> > > They - after all - represent the actual
> > > physical device hierarchy which may or may not be populated at
> > > run-time depending on many factors.
> >
> > No. This is a mistaken assumption.
> 
> How so?

See above.

> > > Once populated, being able to retrieve the software representation of
> > > the device (struct device) from the node from which it was populated
> > > sounds like a reasonable thing to do. What are those problems and are
> > > they even linked to this issue?
> > >
> > > > The get_dev_from_fwnode() is used only in devlink and I want to keep it that way.
> > > > Nobody else should use it, really.
> > >
> > > I don't care all that much, I can get the device from the children of
> > > the platform device. Still comparing fwnodes, though this time the
> > > other way around.
> >
> > Fine, but do not use dev pointer from fwnode, esp. software node.
> 
> I will do it but I'd like to clarify the above at some point.

The relationship between device instance(s) and firmware node instance(s)
is m:n, where each of them can be from 0 to ... x or y.

There is no unique mapping between two.

> > > > We can discuss with Saravana, but I don't believe he can convince me otherwise.

-- 
With Best Regards,
Andy Shevchenko


