Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA877CC334
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbjJQMbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbjJQMbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:31:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC195;
        Tue, 17 Oct 2023 05:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697545866; x=1729081866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iJ3kV5VAjVElTAv4Wqe2dsOu95MxYQTG3Oo/diZ0GYc=;
  b=Go3+crxN+yVlrI8PtTfa6MwmCs4ZPnn3RBq6213sGzq3TEsSCM41FznC
   vjmDPfRwzS2oV/RXifAnbgENwQtKSowyLTbSWP+qBVLz+v66AcAtetFYg
   rFIJ+uHQYF4dv22Pw/oKqhy1Ng8KzK50tInG5evHc79F20YhbANRlnX89
   lba71AhJP8Clky0vX16HGtplqcCDdOCAT1D9rUS5qGz8xTBt9TJX6bifl
   luKQRDQCSH5EzO8YgXxOxGG0cLgOzdTI+ug/Gru25k/dNnEgUrK9WUZ+k
   exz9KjaOifJZusHRgE53oTlnnIoQo3S6kOp5vU2N+AUgA35HHd/xnQsI8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="4370128"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="4370128"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:31:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="705981093"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="705981093"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:31:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsjDw-00000006Hg0-1Y2m;
        Tue, 17 Oct 2023 15:31:00 +0300
Date:   Tue, 17 Oct 2023 15:31:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 55/73] pinctrl: intel: cherryview: drop the wrappers
 around pinctrl_gpio_direction_input()
Message-ID: <ZS5+hCWtOg7JRdk9@smile.fi.intel.com>
References: <20231017120431.68847-1-brgl@bgdev.pl>
 <20231017120431.68847-56-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017120431.68847-56-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:04:13PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> pinctrl_gpio_direction_input() now has the same signature as the
> wrappers around it so we can drop them.

W/o "intel:" part in the Subj
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


