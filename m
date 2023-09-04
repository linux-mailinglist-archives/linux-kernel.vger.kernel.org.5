Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0563B79177E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352980AbjIDMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjIDMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:45:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD1ACD5;
        Mon,  4 Sep 2023 05:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693831553; x=1725367553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Wa35J9ZX/nel6BiikunBPw+XkZUx/f4ld1V2g3fh7Q0=;
  b=j9nsnUmGoxmRJ4UVyJmMH2wnX1LdzPp39Ew0nQVO8yG7viDQqLtaDjjs
   ScnSzpPyUokyOcgOq6rnPYqPAfaWRDaLw83vqhyK9Y8VIF/B0+YHc6dua
   3lQcweXx1gmzP5x7EptrgiQYzBo2q9Q7DYEKkQTCZeCdjydlzJL3+ue2w
   zbGPH6mrfuIrVJe2Y5p3yEe1ch13sCR8jKtqcgrKG0F3XBX48KIWFgnz8
   a4Vhf51k8sxssFNiCMA8CS87VqGI2niYbm+1cz7O6awt3MaqCmcGFin23
   SOxseavOGXtSy+TzGXWvtFn8D9KY+jRQG5xDggKIDKwQbTi9O5bgRQs84
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="407589426"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="407589426"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="806251547"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="806251547"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 05:45:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd8xf-006QSG-2q;
        Mon, 04 Sep 2023 15:45:47 +0300
Date:   Mon, 4 Sep 2023 15:45:47 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: unexport gpiod_set_transitory()
Message-ID: <ZPXRexqFQx9Q2BiR@smile.fi.intel.com>
References: <20230903190657.12393-1-brgl@bgdev.pl>
 <ZPWvJc90rmIAPR+r@smile.fi.intel.com>
 <CAMRc=MdMiMPFvvpAg7DqStSb07Z8L5p0RAmcTimHN8YkcLPV=A@mail.gmail.com>
 <ZPW9JuahVYSP1I6m@smile.fi.intel.com>
 <CAMRc=MdzfvnYJt-SkMzYEwp4rKsaJLN_uoBNQ0seuai+im_b=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdzfvnYJt-SkMzYEwp4rKsaJLN_uoBNQ0seuai+im_b=Q@mail.gmail.com>
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

On Mon, Sep 04, 2023 at 01:32:38PM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 4, 2023 at 1:19 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> This is still inconsistent with the rest of the public symbols -
> especially those in gpio/driver.h. My long-term plan - before making
> locking great again - is to limit the usage of any gpiochip_ symbols
> to GPIO providers (as the chip is not guaranteed to be valid, unlike
> gpio_device) and provide a bunch of gpio_device_ or gpiodev_
> interfaces for use by those who *really* need it. Now am I going to
> make up two distinct prefixes for public and non-public APIs? That
> will be even more confusing IMO.
> 
> Just like in C++ you don't make up special names for public vs private
> methods except for some deranged coding styles that also require you
> to name arguments like "in_foo" and "out_bar".

Yeah, I understand your point of view on this, but as I said
"disagree and commit" (used to be corporate value at some point :-).

On my side I criticized and proposed... It's your turn what to do
with that, I'm not insisting on my way, I'm just telling I don't like
yours, but I will survive, no hard feelings :-)

-- 
With Best Regards,
Andy Shevchenko


