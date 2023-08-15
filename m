Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A7E77CB39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbjHOKj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 06:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbjHOKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 06:39:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157CBB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 03:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692095962; x=1723631962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1+slWlyrr8ZG73XYTgPfGrl47HDYAi2pGGhpLGv/13Q=;
  b=Vhb3NiKSKI2lG0Td8MbwvCYOfb1jRTJlJfxPRXURZZxSCA3dNJK9P21b
   ABp12fGzQlyW4CGRc4sXzrL+bv2Opwh+TSlU4ly8ZFyp554IbEx8+xmLD
   +sgtn3F2DQQEe0cUuYv8bkrkG+gFOixU3nWjUfradtX7SiQoJgmOqOOFj
   u9DRNYn2BUoaBGdxtYrjzHnj0M60SZLisrLowTFOHQsgUg3TCQ+iiLcz0
   llJiQvLrz7csfsqbHCOyfCLxlXghW9zMS4VaOReycOAx6yYW6mGUpX668
   +p4/HU95P1rjwRaQA+zdeJ3nsK4Se8oHxJcrRlJxnIdGsVhaTe7gcuvwh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="375982299"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="375982299"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 03:39:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="733797663"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733797663"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 03:39:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVrSI-00Ew7c-0n;
        Tue, 15 Aug 2023 13:39:18 +0300
Date:   Tue, 15 Aug 2023 13:39:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/4] genirq/irq_sim: order includes alphabetically
Message-ID: <ZNtV1eSg2atvkt9F@smile.fi.intel.com>
References: <20230812194457.6432-1-brgl@bgdev.pl>
 <20230812194457.6432-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812194457.6432-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 09:44:55PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> For better maintenance and readability keep the included headers in
> alphabetical order.

...

> -#include <linux/list.h>

> +#include <linux/list.h>

This can be done in the previous patch already.

-- 
With Best Regards,
Andy Shevchenko


