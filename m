Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB3A79CF04
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjILK6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbjILK55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:57:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D81173D;
        Tue, 12 Sep 2023 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694516247; x=1726052247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/TcDrQ6ZA804X+FGceYvm4xySIxcsUNJZtVj4ZCuNFE=;
  b=LxTyGSplO1f1/VJWFnXVzvEvw0pEItV+65RLRRHyjBKZ9+SVzSg/AHkB
   dfrVv0RrlcMaalDpVQgCx4uGqoOdMbwfASISDbXYa3VO5wiyDwV94wcjB
   jvqetmqNxIqHfIUpA3Rtyfa2kQkDD0LtKVw8hl17mtQcFfFSOBudMTZQg
   FcR4uqkYki0VLrT6IUldYQbttZu5kcDOJu5SgWHoIBYylJbiswhERNCI+
   Es/AONQ3sXBoJhXOwH/JNZB/g8XAj8EvoQl+MFE71zk1mKKhThe6ozaMI
   ujqCVoraj2v6OPqMPqntA+kc1/5bZfXYBk8j3rzDcmkr17VqujuhFGDtH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358615708"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="358615708"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:57:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="693455911"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="693455911"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:57:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg150-008ZAi-1Z;
        Tue, 12 Sep 2023 13:57:14 +0300
Date:   Tue, 12 Sep 2023 13:57:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 04/11] gpiolib: provide gpio_device_find_by_label()
Message-ID: <ZQBECsLHhuNRYr20@smile.fi.intel.com>
References: <20230912100727.23197-1-brgl@bgdev.pl>
 <20230912100727.23197-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912100727.23197-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:07:20PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> By far the most common way of looking up GPIO devices is using their
> label. Provide a helpers for that to avoid every user implementing their
> own matching function.

...

> +static int gpio_chip_match_by_label(struct gpio_chip *gc, void *label)
> +{
> +	return gc->label && !strcmp(gc->label, label);

When gc->label can be NULL?

> +}

-- 
With Best Regards,
Andy Shevchenko


