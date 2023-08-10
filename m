Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4C777A72
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjHJOVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjHJOVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:21:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A54F120;
        Thu, 10 Aug 2023 07:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691677290; x=1723213290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l4JG1BhwW43nG3qeqhKogwwQrG7lvFAm7ySVzhImUiY=;
  b=QOJwAT/okgIuQcuun2BzHa5KjpaR/E0lqXpzU+AQP/eCTFUYWYcll7GK
   BeZm0wB2OFpGjsU1lLRM0SZaaBBZEFH4L7LE/4HePnylxgYhyydwpcun/
   BGMUvx4ObrlVLuwxv2rb3GihJgj9j14XwT3jCr2RsFYyfe2kdNbUfXhkQ
   i7aX+0z3w67wMtVJP769ymtGstfg/rbr0CLD8SnvrRBsHUTpnBZjDdLiC
   ILIo/diLQBGh5u/R97V4Klc41go0kwP51Ok5hTBRlQgchgzVFsiNjmurK
   qhaPGr2tYFAsD+jVRNh3c/uZk4Abm4y/wOVUOAQs3oilj/DJBhaut8XdT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="368885498"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="368885498"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 07:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709169090"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="709169090"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2023 07:04:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU6Gf-003zpL-2S;
        Thu, 10 Aug 2023 17:04:01 +0300
Date:   Thu, 10 Aug 2023 17:04:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpio: sim: use sysfs_streq() and avoid an strdup()
Message-ID: <ZNTuUUp0IHtfnGK3@smile.fi.intel.com>
References: <20230809131442.25524-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809131442.25524-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:14:41PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> When comparing strings passed to us from configfs, we can pass the page
> argument directly to sysfs_streq() and avoid manual string trimming.

Good one!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


