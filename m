Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350787914AF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243589AbjIDJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjIDJZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:25:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83D18D;
        Mon,  4 Sep 2023 02:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693819505; x=1725355505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dx0HBQX0UmIwihurZc9uf11+NqLj8xcwxV3sRqawfy0=;
  b=R/LnEapCO2xI0tEGE+NpOrcnevhDbmPCNgeHPCJxQwkN83g3lnbAld05
   1YXvCjoUwn1iQg892pRDauDJCBZ5HLEo83u/unR4DPw4ozlaP1DxWXgtt
   gveDkTpYEdGb7RL864R+xwFY15EwCOkN7byVDMSlg/MON99njANghLtio
   apYEjyvnUMcvPieImHtWf5ZZgGIxBUzvvvk94tMIeOev+LtJX/8A39U+i
   JunrCL6xl7u2gs/nttetPjrTUizmsqyjYCHvUGqWm2+4A7byfQ+CWp39x
   7QxzTNdoYXtWDk4WH3Y9jpYf//BZ0V/OmIAPgORu+7jam8jI+nbsSWQbt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="462925238"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="462925238"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:24:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="987434951"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="987434951"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:24:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd5pF-006Nv8-1C;
        Mon, 04 Sep 2023 12:24:53 +0300
Date:   Mon, 4 Sep 2023 12:24:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/2] gpiolib: rename gpio_set_debounce_timeout() for
 consistency
Message-ID: <ZPWiZSgyar1zWfR1@smile.fi.intel.com>
References: <20230904073410.5880-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904073410.5880-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 09:34:09AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> All other functions that manipulate a struct gpio_desc use the gpiod_
> prefix. Follow this convention and rename gpio_set_debounce_timeout() to
> gpiod_set_debounce_timeout().

No, that's not true. This one is inline with the other gpio_set() _internal_
APIs. If renamed, should be done consistently.

-- 
With Best Regards,
Andy Shevchenko


