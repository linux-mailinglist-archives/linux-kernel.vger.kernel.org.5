Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8D7A9710
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjIURLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjIURJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:09:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F9965BC;
        Thu, 21 Sep 2023 10:05:16 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="466800712"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="466800712"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:24:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="776381303"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="776381303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:24:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1qjHnK-0000000GsO5-33XN;
        Thu, 21 Sep 2023 14:24:30 +0300
Date:   Thu, 21 Sep 2023 14:24:30 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V2 2/4] gpio: sprd: Clear interrupt after set the
 interrupt type
Message-ID: <ZQwn7lEJVfKWtKDx@smile.fi.intel.com>
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com>
 <20230921090027.11136-3-Wenhua.Lin@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921090027.11136-3-Wenhua.Lin@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 05:00:25PM +0800, Wenhua Lin wrote:
> The initialization state of the EIC module is a high level trigger.

Here you use EIC, in other places eic. Can you, please, be consistent?

> If it is currently a high level, the interrupt condition is met at
> this time, and the EIC interrupt has a latch capability, which will
> cause an interrupt to occur after booting. To avoid this, When setting
> the EIC interrupt trigger type, clear the interrupt once.

-- 
With Best Regards,
Andy Shevchenko


