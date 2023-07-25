Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648237619A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjGYNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjGYNTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:19:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0D62132;
        Tue, 25 Jul 2023 06:19:23 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="431521549"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="431521549"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 06:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="720059951"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="720059951"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2023 06:19:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qOHwc-00B8Ul-2F;
        Tue, 25 Jul 2023 16:19:18 +0300
Date:   Tue, 25 Jul 2023 16:19:18 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, romain.perier@gmail.com,
        daniel@thingy.jp, Alexandru Ardelean <alex@shruggie.ro>
Subject: Re: [PATCH] gpio: msc313: remove unnecessary call to
 platform_set_drvdata()
Message-ID: <ZL/L1tiKjLDP5bet@smile.fi.intel.com>
References: <20230721131157.26640-1-aboutphysycs@gmail.com>
 <ZLqu56eHfpc0TnMw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLqu56eHfpc0TnMw@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 07:14:31PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 04:11:57PM +0300, Andrei Coardos wrote:
> > This function call was found to be unnecessary as there is no equivalent
> > platform_get_drvdata() call to access the private data of the driver.

Not true.

> > Also, the private data is defined in this driver, so there is no risk of
> > it being accessed outside of this driver file.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

I have to withdraw this, the patch is wrong.
NAK.

Sorry for the confusion (I have looked for the wrong pattern).

-- 
With Best Regards,
Andy Shevchenko


