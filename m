Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118FD79D003
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbjILLck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjILLb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:31:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEBCB9;
        Tue, 12 Sep 2023 04:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694518283; x=1726054283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RPBdnOWFyucV6OzgxkI9qyKFoFrVZEO/BD5C1eRouhc=;
  b=RpwKuWXUYBM7Zd0Bu0wbxBrtooKNl/q3pG8BOSxnYsU12cMVvtGZ6SK5
   aSlBB1cvYsFuhWD7WQCxPGCEYlek1n4IM/pZOolR8zBak1i9MuuuCoD2F
   EhXvUv0e+LnTbarp0v2m64x0sztdzINVqdCLKXv7mPjbtddHb6DnooT+C
   zqVHbWNuUXr0gRg2+peGDqUohcZ6gvn3sVUybm7P6/NJb6pkV0oHJgJJn
   BvjdaejjC54BGSFH6sak49sERd7QyGju/+RbPI3lPGa6cU+Bs9lPJsgxX
   C8ckK9CBhn9HTPWJ9B4U4wH5u4FWv2HlSKyRZmoIHfeGirAFnGTW0mvN4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="464716596"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464716596"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:31:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990474726"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="990474726"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:31:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg1by-008ZZQ-25;
        Tue, 12 Sep 2023 14:31:18 +0300
Date:   Tue, 12 Sep 2023 14:31:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 09/11] gpio: acpi: replace gpiochip_find() with
 gpio_device_find()
Message-ID: <ZQBMBubLx2zSYwqL@smile.fi.intel.com>
References: <20230912100727.23197-1-brgl@bgdev.pl>
 <20230912100727.23197-10-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912100727.23197-10-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:07:25PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're porting all users of gpiochip_find() to using gpio_device_find().
> Update the ACPI GPIO code.

...

> +	/*
> +	 * FIXME: keep track of this reference somehow instead of putting it
> +	 * here.

Under "this" you meant gdev? Please, spell it explicitly, I spent a couple of
minutes to get what exactly this comment is about.

> +	 */
> +	return gpio_device_get_desc(gdev, pin);
>  }

-- 
With Best Regards,
Andy Shevchenko


