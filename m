Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128A379406A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbjIFPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjIFPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:32:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD868CE6;
        Wed,  6 Sep 2023 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694014325; x=1725550325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IiVDbALXXU+DoRCCfmT3TQFU3G0X433utKATBEiAfvU=;
  b=RBNYnT6rWhcHYRMMx1uV193zM0yLv85AJigq34W7Od4//8LppYkLKKS5
   QPlByDTsAwskkrGkC/22H/iFO+CuCxNOEfrElj6WoH9kHu3yY9Uqn0TkZ
   1MEMuGxi4gp3o4WB5G/bxNVmthYkAlqfDGxR8K9HofFkYnLIvH5gYlZlj
   93kyi7YOJj63cY3O4Lztg6AvXgcnJX/fW7UWNsCV1gCQxePj/4N02hj7w
   kG8oe16WX9PtHPz2VUFsqOn4fvp7Hxd3lZt0UwHIYdZ0nXMcUVHEMC5Tn
   XJMzPlxqjPZZWvcYPXXZFkkPUoIyj/Ba5eE0N2uWMR04t+miiweYoh3e7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362128319"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="362128319"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:31:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="735102887"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="735102887"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:31:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qduV7-006yis-0h;
        Wed, 06 Sep 2023 18:31:29 +0300
Date:   Wed, 6 Sep 2023 18:31:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: mb86s7x: don't include gpiolib.h
Message-ID: <ZPibUFb/A4G9UiYz@smile.fi.intel.com>
References: <20230906145118.139678-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906145118.139678-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 04:51:18PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The gpiolib.h is unnecessarily included in the driver. None of its
> symbols are used so drop it.

For this and all patches "gpio: *: don't include gpiolib.h"
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


