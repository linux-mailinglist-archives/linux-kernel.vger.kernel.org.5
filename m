Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9BE77F682
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350893AbjHQMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHQMi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:38:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78182D57;
        Thu, 17 Aug 2023 05:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692275934; x=1723811934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XKAlDtu8w5r2ImV3XxMTRJjxDaYlAichBPMvi13fXvc=;
  b=VqsbESa+YHRjI9coof1u0zvfGUtLwbjTcar+YWRnAKkSD2c0kYWxjOiC
   b8XU7V8aQhE1lSF1Oe5ae8JVwHZKMlhgtJ9lTdKNRwcIOPhMYzEo3JBPP
   YjE0EzJ73tghqOnxlwzqnp8h8j94477VV+Hch5d3q9AauauQn6dRs3BBt
   /7pV5zgUWZU016inb6dtw6jhGsvLzcqHs/yQXq5VAlgAvMaogjIoALsgD
   3j7Kl17drHXKFELgi0qsHJLixqLNdWHWbMUS6XNXDqUbZBETTgkt5nurq
   R1PaL7kzqnrpJoype5MoMDTPujLDaUkAjjOh/8GFiBBPVmlH8fVldJ+Km
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="403779073"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403779073"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:38:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="981142718"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="981142718"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 05:38:52 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWcH4-00BiQC-0y;
        Thu, 17 Aug 2023 15:38:50 +0300
Date:   Thu, 17 Aug 2023 15:38:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v5] gpio: consumer: new virtual driver
Message-ID: <ZN4U2u9h0vVNmf9d@smile.fi.intel.com>
References: <20230815185650.152968-1-brgl@bgdev.pl>
 <ZN3wauUBENDd7aRU@smile.fi.intel.com>
 <CAMRc=MdUWXZVnjkPqH2BZvDY0v-OOysQ=NMjwQEi1rt+16NEQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdUWXZVnjkPqH2BZvDY0v-OOysQ=NMjwQEi1rt+16NEQQ@mail.gmail.com>
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

On Thu, Aug 17, 2023 at 02:14:04PM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 17, 2023 at 12:03 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 15, 2023 at 08:56:50PM +0200, Bartosz Golaszewski wrote:

...

> > > +     struct gpio_consumer_device *dev = lookup->parent;
> > > +
> > > +     guard(mutex)(&dev->lock);
> > > +
> > > +     return sprintf(page, "%s\n", lookup->key);

(1)

...

> > > +static ssize_t
> > > +gpio_consumer_lookup_config_offset_show(struct config_item *item, char *page)
> > > +{
> > > +     struct gpio_consumer_lookup *lookup = to_gpio_consumer_lookup(item);
> > > +     struct gpio_consumer_device *dev = lookup->parent;
> > > +     unsigned int offset;
> > > +
> > > +     scoped_guard(mutex, &dev->lock)
> > > +             offset = lookup->offset;
> > > +
> > > +     return sprintf(page, "%d\n", offset);
> >
> > Consistently it can be simplified same way
> >
> >         guard(mutex)(&dev->lock);
> >
> >         return sprintf(page, "%d\n", lookup->offset);
> >
> > BUT. Thinking about this more. With guard() we put sprintf() inside the lock,
> > which is suboptimal from runtime point of view. So, I think now that all these
> > should actually use scoped_guard() rather than guard().
> >
> 
> Precisely why I used a scoped guard here. Same elsewhere.

So the 1) has to be amended then.

> > > +}

...

> > > +     enum gpio_lookup_flags flags;
> > > +
> > > +     flags = gpio_consumer_lookup_get_flags(item);
> >
> > This is perfectly one line < 80 characters.
> 
> There's nothing wrong with setting the variable on another line though.

Why do we need 3 LoCs instead of a single one? Do you increase your line
statistics? :-) I really would like to know the rationale behind this.

-- 
With Best Regards,
Andy Shevchenko


