Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385C57FC1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344423AbjK1QGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 11:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjK1QGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 11:06:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8587D12A;
        Tue, 28 Nov 2023 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701187588; x=1732723588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bwo7ggHdQ8ZPC43AT1LI2aW1ivPm7/3+xNO0T21w5Gs=;
  b=fW/qwdbmdT3sqiqU2yOcJ8Ei/gaeuWTQGnFvCYBMH+ed/JSfPzvx5Ujj
   CwhID1jQFnWVZU8xm9uWSyoS11WHIC8UOid2BnlXcSEfUUUoCtxzj0rWh
   OH1r+WBKpYduXi2v62Fsr3/IHXMXDCBhEb3RHaqJeCaVbTvopnCzcD3/0
   JMiLcRX7p0nwFNlSp8je331mM2k3c3PNy6/u56GvaRoggWQPvwb8zFNnj
   R7xRWRJlxtUoNmk5czySFVCXOaNOYKirfhk2V4jGqUr6BAu89ZLY4Fls5
   xGkZp/sag/4RxqnuhHaP0lxIEjfKGTr5MDVJD+IyZ8JE4Nrn87miSwx42
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457281923"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457281923"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:06:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="839104227"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="839104227"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 08:06:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r80bO-00000000CjM-2Wuh;
        Tue, 28 Nov 2023 18:06:22 +0200
Date:   Tue, 28 Nov 2023 18:06:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpio: sysfs: fix forward declaration of struct
 gpio_device
Message-ID: <ZWYP_uRWps9W0cVn@smile.fi.intel.com>
References: <20231127193716.63143-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127193716.63143-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 08:37:15PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The forward declaration for struct gpio_device should be provided for
> both branches of the #ifdef.

Oh, right.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


