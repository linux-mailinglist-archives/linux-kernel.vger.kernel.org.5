Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F62792B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjIEQwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354287AbjIEKeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:34:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3105CE8;
        Tue,  5 Sep 2023 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693910046; x=1725446046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=y11ZHa+JZmvOm6gwUSg6E263+YzQF1w25u/4Vg0K8mI=;
  b=TvnYY4/xY6l6wbMqVkKIypZ6EfRlTmaGWrQKQOFKwJxK1YMukbeX3ukf
   7V3bHrZCRiR77VptkBG/vCmTJTvOrUbWltEDHaRsenmmM2o8+JHA02B8b
   8GCoOxtdJuLsUJmVP+UnWNwfQr9IoZrd2lTh0N4ZKmVWQYAk4Lc4fOwnv
   of5UbEuBifsfGsLZuwTBe89mAKn9W0jtouzzUhudLRHdrTpcxFv9m95DQ
   bRPQ0MmCIbYIUBhnYajI/XJwBZzQfcfDwCihSryoI6dFzs/ZXKnKXmHED
   1tI1kDe16purxmn68qrZ+KpuMJix15sc5fsJOL0Hw5B89GHsL0xeUM9id
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="356255368"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="356255368"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 03:34:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="734606064"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="734606064"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 03:34:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdTNd-006eig-3A;
        Tue, 05 Sep 2023 13:33:57 +0300
Date:   Tue, 5 Sep 2023 13:33:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] gpiolib: rename gpio_chip_hwgpio() for consistency
Message-ID: <ZPcEFXF9Fz762kzK@smile.fi.intel.com>
References: <20230904073410.5880-1-brgl@bgdev.pl>
 <20230904073410.5880-2-brgl@bgdev.pl>
 <ZPWjAUzqeAwF1wro@smile.fi.intel.com>
 <CAMRc=MeMYi0KbK=1RYGX2zbUjVZyQp-Y_aXfy6+EZcEtUSEU0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeMYi0KbK=1RYGX2zbUjVZyQp-Y_aXfy6+EZcEtUSEU0A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:37:32AM +0200, Bartosz Golaszewski wrote:
> On Mon, Sep 4, 2023 at 11:27 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Sep 04, 2023 at 09:34:10AM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > All other functions that manipulate a struct gpio_desc use the gpiod_
> > > prefix. Follow this convention and rename gpio_chip_hwgpio() to
> > > gpiod_get_hwgpio().
> >
> > Same comment. Also, I don't think it's good idea as it steps on the exported
> > API's toes. I.o.w. I won't mix those two.
> 
> Even if I agreed with your other comment, gpio_chip_hwgpio() is a
> terrible name and if I didn't know, I couldn't tell you what it does
> just from looking at the name.

That's can be improved, my previous comments were basically to avoid
mixing prefixes for internal and external APIs, let's say prefix them
similarly, but for internal with space and/or more verbose naming

	gpiod_		gpio_desc_
	gpiochip_	gpio_chip_
	gdev_		gpio_device_

(as an example).

-- 
With Best Regards,
Andy Shevchenko


