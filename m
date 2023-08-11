Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EAF77915B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjHKOEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbjHKOEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:04:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639742706;
        Fri, 11 Aug 2023 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691762640; x=1723298640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pQh6BC501td+I1bhxOE+ftaZXJZP+zZbEaizIBhZluQ=;
  b=kxYST/kExaHio4mKlqpUnxvZpawIPSaCOrU1hiTFLbtPOYFPFeBVF9nM
   1rNw2gyWAV4Rzq0bdHkKx9uYDUw8OwjrJQnD8VhtREjciA3U2VvBHPCWH
   dEjRkx4WwozyZeIytgoblD+gFNjTKyF5+c7bQpmMRVnuc800R3/Agn7lh
   apQS0gHKHDCTJIAK5kOSprmYnePwpvVVJJaa+p12GBn+NeG07PDe2HGGM
   LxC6XkuLM1OnKuvJAkIyDl8gx/Ltl86nIGo1+EPj4EKA9SvbpijNknIrc
   499ND7ByAy1TheftqJ8wQQ7aHhsiKxDMd5nITvbl7Og2isXjGQjixImUI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402653408"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="402653408"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="1063331365"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="1063331365"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 11 Aug 2023 07:03:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUSjc-000MmV-2b;
        Fri, 11 Aug 2023 17:03:24 +0300
Date:   Fri, 11 Aug 2023 17:03:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpio: sim: simplify
 gpio_sim_device_config_live_store()
Message-ID: <ZNY/rATR7CvxmGZi@smile.fi.intel.com>
References: <20230811131427.40466-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811131427.40466-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:14:26PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Simplify the logic when checking the current live value against the user
> input.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> This is the same as what Andy suggested for gpio-consumer. Let's save a
> line.

Right.

-- 
With Best Regards,
Andy Shevchenko


