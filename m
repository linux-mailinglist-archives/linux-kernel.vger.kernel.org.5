Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA5A791628
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjIDLTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIDLTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:19:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68380E3;
        Mon,  4 Sep 2023 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693826348; x=1725362348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DccO812bQ218hR2XBGScxOeCSdKFIO+vOyW4fom7rnw=;
  b=WvgjmjjCaHsPpnwCpwyrhrYdtTtf9nEVVAjQjfO/PNjWPzPIOyYc14G1
   0uTKQStI60kPpY3sR5ZMxQL1ZX51ghK7GJY6xRISlKt9xe9Iv2Lcnfy7P
   cZ3y9SiRV2BRr879rJQWTnaRyWZTMa5fNjHR3ekNgUZNKX/e2dDsQMneK
   vMEFd6FNw3+AVkysSATSUAn5F4rVsN/C7RxmjMoSuN6WZTdSM8E21y61f
   Jts0WpiAK14h0GoBYhOI9EbByi/WZN9RfXPEURCtrXR3pGRgnPvDMZS/+
   ydCt+Sj63izyOM2yjISvTqo/6NCvx3XrcXgXYcxrt7dmtPlJYt5m4n6Gf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="442977206"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="442977206"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769958895"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="769958895"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 04:19:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd7bj-006PSQ-0t;
        Mon, 04 Sep 2023 14:19:03 +0300
Date:   Mon, 4 Sep 2023 14:19:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: unexport gpiod_set_transitory()
Message-ID: <ZPW9JuahVYSP1I6m@smile.fi.intel.com>
References: <20230903190657.12393-1-brgl@bgdev.pl>
 <ZPWvJc90rmIAPR+r@smile.fi.intel.com>
 <CAMRc=MdMiMPFvvpAg7DqStSb07Z8L5p0RAmcTimHN8YkcLPV=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdMiMPFvvpAg7DqStSb07Z8L5p0RAmcTimHN8YkcLPV=A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 01:14:29PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 4, 2023 at 12:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, Sep 03, 2023 at 09:06:57PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > There are no and never have been any users of gpiod_set_transitory()
> > > outside the core GPIOLIB code. Make it private.
> >
> > And rename to be gpio_desc_...()?
> >
> > With this done,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > The rationale has been explained in the other threads with renaming matters.
> 
> I'm not buying this explanation. Public GPIO functions don't have a
> monopoly on the gpiod_ prefix. Eventually I'd love to unify the naming
> convention for the three important structures that we use:
> gpio_device, gpio_chip and gpio_desc, no matter whether they're public
> or private as that's already clear from their placement in
> include/linux/ or drivers/gpio/.

And I would like to avoid adding confusion by mixing internal and external APIs
under the same prefix.

Personally I do not like this change, when gpiod_ is being used. So, you may
override this, you are the maintainer, but then here is the formal NAK from me
(as a user of these APIs internally and externally).

-- 
With Best Regards,
Andy Shevchenko


