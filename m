Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F8B7915A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350082AbjIDKT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIDKT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:19:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E677F1B6;
        Mon,  4 Sep 2023 03:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693822762; x=1725358762;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x9gwmSu7l1tKKTY4O9ewxpOuxFGgmB7wkxku8KGG2AU=;
  b=BveA4ZBse5Y1xv4WP3GyPvVs48hqH7r+KvaDyZktRKrdDkL5FD9yE6hq
   ZNml2T8NQ5UjilW3YXjyOm6r67yJYDELVO4O/3Cpfje7mu1DxfwBCxAWv
   7BcXHqUdQsVvKccUovjExU57vTfwUds61IAbCWWpxqe5QCZtQwL843IWD
   +Ih5X54Kepm0hP3cudjYmdYqZSDZpR5AMUPy5acg+hkq1EJcdvhLxpOV0
   wqStBHJsZaPryIIG6Fa48+s1i1fBGkCgJoToC0KI1LnbKsz78T60k7+Fr
   a/DFMm8XzBsXyRr6cggo4z4Apg7FbOD/5acXwmSmAQKCfkd98v306Tgat
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="361589627"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="361589627"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="883987539"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="883987539"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:19:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd6ft-006Oim-1R;
        Mon, 04 Sep 2023 13:19:17 +0300
Date:   Mon, 4 Sep 2023 13:19:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: unexport gpiod_set_transitory()
Message-ID: <ZPWvJc90rmIAPR+r@smile.fi.intel.com>
References: <20230903190657.12393-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903190657.12393-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 09:06:57PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There are no and never have been any users of gpiod_set_transitory()
> outside the core GPIOLIB code. Make it private.

And rename to be gpio_desc_...()?

With this done,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The rationale has been explained in the other threads with renaming matters.

-- 
With Best Regards,
Andy Shevchenko


