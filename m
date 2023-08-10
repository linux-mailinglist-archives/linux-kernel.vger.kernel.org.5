Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E177799B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjHJN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjHJN3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:29:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0E92115;
        Thu, 10 Aug 2023 06:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691674169; x=1723210169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EBF+COueCekwMR2I3qVFSbTuJOjqTaqeByXFOY1SFa4=;
  b=V43mVJhy0uKu/PV8VHWWRC4Ur/Z02/dR0wuHmF6kP602Ar9H4CwvUSzB
   XXzk/fIjM4ZGPl4snWZAwDjC18G6pwW5ssZ6RAPInCOvXn4268KjTfGAg
   8Uc/SV7sekEcrl1SU3SBROBwZIOXyu8yrve12WsvV1nGMzZTVBYsOAYxg
   6hKu4UbMoCZjFYgYvHpENJEGC/7wEVG8DHbtH4VWG+jaG8V0onReCx/Gk
   olIMBMWIGr6CTWHDZsIFebLaWkV1TQhnw7oD3m1IMO72/2FzmUqRJRAW2
   503U5gU1eBR9oVeIVsBxc0cfIFDRptUcgekAdLtztG+d1EV4QXIhcwDmQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="374169989"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="374169989"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 06:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="732231353"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="732231353"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2023 06:29:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU5jB-002odo-3D;
        Thu, 10 Aug 2023 16:29:25 +0300
Date:   Thu, 10 Aug 2023 16:29:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: accel: kionix-kx022a: Use correct header(s)
 instead of string_helpers.h
Message-ID: <ZNTmNW1I2aI6ervP@smile.fi.intel.com>
References: <20230808164204.66818-1-andriy.shevchenko@linux.intel.com>
 <d8f84ec0-142d-88d1-c317-acfb8c234bad@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8f84ec0-142d-88d1-c317-acfb8c234bad@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:00:39AM +0300, Matti Vaittinen wrote:
> On 8/8/23 19:42, Andy Shevchenko wrote:
> > There is nothing from string_helpers.h used in the driver, correct
> > the header inclusion block accordingly.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Out of the curiosity - is the goal to get rid of including choices from
> helpers? (I think) then the header split would be more beneficial.

At the end, yes.

Thank you for acknowledging!

-- 
With Best Regards,
Andy Shevchenko


