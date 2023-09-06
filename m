Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FEB794172
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbjIFQ0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjIFQ0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:26:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B6B199A;
        Wed,  6 Sep 2023 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694017604; x=1725553604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PfZQ7/tLxHmEeK1LhlNRWm9awIRclhV2aaDf5eSfX20=;
  b=ZV2c/UO8WpBXJuUPErs286YcKFjHOijcu+ibWHu3NMRuoTZefpU4FgyK
   uJG/6gKc5Ekqw65HRDc8Kk0QfF5eUOTNWpAkt7SS+lVpY4ZPUethlLuUf
   8AhtA21ETDLb8RZICs6Qk6oYUxh4k9YaqfzAogqL5XP4JtYLvVaywKzcG
   thJL38WCR3vDEWLKdB1ArrTDXXkta9yXcamv1eUY90GOiQGNkIa31Df9Q
   /Lap2oPK2YH+eZbBlRatIbXvYQ0PdkpvMXpMbUK15yjhhb9vYoButjP1E
   /OYRBK8K45P17sS74Tp23dJALHuWrNpN2mVmEkLpa9r5vW6sYh52S/weo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="380911172"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="380911172"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 09:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="770828839"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="770828839"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 09:26:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qdvMV-006zWc-1q;
        Wed, 06 Sep 2023 19:26:39 +0300
Date:   Wed, 6 Sep 2023 19:26:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 01/10] gpio: pca953x: Drop unused fields in struct
 pca953x_platform_data
Message-ID: <ZPioPzAewLGY9nBo@smile.fi.intel.com>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Metu3dB0iF1C-5nwTr2Vj1rk0AJAwzn8Dkgto8t-jn_LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Metu3dB0iF1C-5nwTr2Vj1rk0AJAwzn8Dkgto8t-jn_LA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:43:01AM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 1, 2023 at 3:40 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> >         /* number of the first GPIO */
> >         unsigned        gpio_base;
> >
> > -       /* initial polarity inversion setting */
> > -       u32             invert;
> > -
> >         /* interrupt base */
> >         int             irq_base;
> > -
> > -       void            *context;       /* param to setup/teardown */
> > -
> > -       int             (*setup)(struct i2c_client *client,
> > -                               unsigned gpio, unsigned ngpio,
> > -                               void *context);
> > -       void            (*teardown)(struct i2c_client *client,
> > -                               unsigned gpio, unsigned ngpio,
> > -                               void *context);
> > -       const char      *const *names;
> 
> Ah, we're so close to getting rid of platform data entirely...

Yep!

> Series looks good to me, I'll pick it up next week after the merge
> window closes.

Sure, thank you for the review!

-- 
With Best Regards,
Andy Shevchenko


