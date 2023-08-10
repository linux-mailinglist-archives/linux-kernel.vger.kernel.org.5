Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CC4777B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbjHJOx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjHJOx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:53:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5F8A8;
        Thu, 10 Aug 2023 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691679207; x=1723215207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CUopxJtCJYSckZIOl9IDA1Xy5A+d1BoFHwDOySQ1Brk=;
  b=kAtsMd98Z9tUYMWjyHmJPVZOEfdwBpPJTF4JTDhj03E2dxl/4A7T2BVm
   CF0qIlj1wxp4zZUnD7DNoEzvFj9j11MkogWjmo0WqLSr++2thsCAPQouU
   wE0X3CSpHOyZGoa9bJo4BdCVAxCX54JhYbw6FqBAnN7GFIHmf7OGobZIh
   qR5lHDoA4aE/XZG6GdFZZaCrrvpBSjkh0925wKt15V2mnqY0lkpK59GhJ
   IfP/Bh5yz2Ps3E4NwUO2tDoLge0bkydPn4OqR3tQoLiB2iSTIzvsO9+0F
   5YjHPWdDpz4fkWxLZFi+W/NwUWSUtn3RElofuKdEC6Td+KM47P9oiF12C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="402399115"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="402399115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 07:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="846424778"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="846424778"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 10 Aug 2023 07:53:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU72R-005g5G-1a;
        Thu, 10 Aug 2023 17:53:23 +0300
Date:   Thu, 10 Aug 2023 17:53:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: consumer: new virtual driver
Message-ID: <ZNT546dM+7QX98pA@smile.fi.intel.com>
References: <20230808145605.16908-1-brgl@bgdev.pl>
 <ZNJ6HCOV0bzlaoXX@smile.fi.intel.com>
 <CAMRc=Mf_BmhZLN1J2m4SnpmPJzZtYPcfdR54EfG9gR5Px_Ss-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf_BmhZLN1J2m4SnpmPJzZtYPcfdR54EfG9gR5Px_Ss-Q@mail.gmail.com>
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

On Wed, Aug 09, 2023 at 09:29:14AM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 8, 2023 at 8:11 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 08, 2023 at 04:56:05PM +0200, Bartosz Golaszewski wrote:

...

> > But again, why not
> >
> >         timer_data->val ^= 1;
> 
> This is not ok in my book. If I need to think for more than a second
> about what it does, then it's worse. I put clarity over brevity.

Yes, this will require bit ops to check.

...

> > This can be avoided by
> >
> >         key = kstrndup(skip_spaces(page), count, GFP_KERNEL);
> >
> > no?
> >
> 
> No, because we also want to remove the trailing spaces and newlines.
> But if you have a different suggestion with existing helpers, let me
> know. I didn't find any.

kstrto*() are newline friendly. The rest as you noted can be covered with
sysfs_streq() / sysfs_match_string().

...

> > > +     ret = kstrtoint(page, 0, &offset);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /* Use -1 to indicate lookup by name. */
> >
> > This comment is unclear as offset can be -1 given by the user.
> > What does above mean in that context?
> 
> I added this to the documentation. Negative number means: lookup by
> line name, positive or zero - lookup offset in chip.

Then add a link to the documentation from here? Because reading this comment
and the code is confusing.

> > > +     if (offset > (U16_MAX - 1))
> >
> > And how does it related to this -1 if related at all?
> 
> GPIOLIB interprets U16_MAX as "lookup by line name". So we can allow
> max (U16_MAX - 1). I will add a comment.
> 
> > > +             return -EINVAL;

...

> > > +     struct gpio_consumer_device *dev;
> > > +
> > > +     dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> > > +     if (!dev)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     dev->id = ida_alloc(&gpio_consumer_ida, GFP_KERNEL);
> > > +     if (dev->id < 0) {
> > > +             kfree(dev);
> >
> > Wondering if you can utilize cleanup.h.
> 
> Whooaah! In february this year I suggested basic C RAII during my talk
> at fosdem and here we are? I missed this one. Yeah, I will use it!
> Even better, I will abuse the cr*p out of it in gpio-sim as well!
> Thanks for bringing this to my attention. This may be the best thing
> that happened to kernel C code in years if people widely adopt it.
> (This paragraph was written by a fan of GLib's autopointer paradigm.
> :) )

So let it be!

-- 
With Best Regards,
Andy Shevchenko


