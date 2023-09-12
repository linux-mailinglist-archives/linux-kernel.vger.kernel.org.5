Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F4479CBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjILJbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjILJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:31:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F11B123;
        Tue, 12 Sep 2023 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694511096; x=1726047096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KAbjzoM9A507xCYTGkBxWAfT/6us+iLQDYfKZxIiLqM=;
  b=SomspT2sQgJQF5t82fg7aeolHu7lleGHp/AXWKWv5bFQ5sCDu7ZRiTCO
   XEuqUPDWH5ICfrxSA9LyEG3msbIyugrPkMueig11vSC0vBYEZn+TJtxni
   HAmberY+68uor/NBkh+evBtRmnK4eORDYjrGw5NugkplsJHK1kInzoGDh
   FTOpxiw0/EmntYILjT7b9Wzf3K1igFboYDGBEOff416Y6Xm14bqnyw5MT
   fmX/wp3XWk+k2iCUtag+Jdpj12TBlnjDJSnSLjuauUDISUpwuygiDjHJz
   nTfWLlz76Ub8d4I/8vIMvBb0Op5ju+3H9R21NfA/Ii78kNHlgzh4bNhK9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368581969"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="368581969"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="743658827"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="743658827"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:31:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfzk3-008Y5a-3B;
        Tue, 12 Sep 2023 12:31:31 +0300
Date:   Tue, 12 Sep 2023 12:31:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 01/10] gpio: pca953x: Drop unused fields in struct
 pca953x_platform_data
Message-ID: <ZQAv8wJuS7t0RV+m@smile.fi.intel.com>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdboT46oadZJZTde=ze2vEvC9aUGjO5-MjDdVwCNijFqDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdboT46oadZJZTde=ze2vEvC9aUGjO5-MjDdVwCNijFqDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:50:06AM +0200, Linus Walleij wrote:
> On Fri, Sep 1, 2023 at 3:40 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > New code should solely use firmware nodes for the specifics and
> > not any callbacks.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Patches look good to me:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> for all patches.

Thank you!

> Patch 8 looks HTML on my gmail but I guess the problem
> is on my side.

The entire series has been sent in the same way, it's quite unlikely that
the only patch got mangled while others are okay.

-- 
With Best Regards,
Andy Shevchenko


