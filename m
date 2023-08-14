Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8902E77B76C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjHNLSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjHNLSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:18:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC3E58;
        Mon, 14 Aug 2023 04:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692011909; x=1723547909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LwXTc34PIhThEixHnA6kYem0jG0C3Vl5cr3G0oK3FTM=;
  b=Cb1F0Ud/2OfO7BztXtlOeYA9eoOLxoljCHARh86U0d8bqiyziDtpBywP
   4fvABep8GcMeWPG9jlF7pa7gSradZdtzwoFXc3li6O6VTkr6Pdzrt58RX
   mCszsVpjLm0Hn7unyafWgHpywtZkmjXKZpTjRKdnvU+7IIe66RyS+tDGz
   lyspGTvmEKgaaOzx8NjWnuU3VMPHTzoLMFnyw+W9rxmbOxMqerI3DZAAg
   /+RDE2sSPKNo45D52zE2Tt3viqwUI1GbdUvmKiNe+eeK0T86GgrFpbnlN
   f5DdZ/YSu3Sd3Fiygy+hvGVmr55WLLaJDv5NP2plti/puea7EsUt/OiJC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="374785657"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="374785657"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 04:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="979951515"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="979951515"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 14 Aug 2023 04:18:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVVab-0026aN-2H;
        Mon, 14 Aug 2023 14:18:25 +0300
Date:   Mon, 14 Aug 2023 14:18:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: regression from commit b0ce9ce408b6 ("gpiolib: Do not unexport
 GPIO on freeing")
Message-ID: <ZNoNgWQG/5jdXlCK@smile.fi.intel.com>
References: <20230808102828.4a9eac09@dellmb>
 <ZNYKjnPjIRWIYVot@smile.fi.intel.com>
 <20230814093934.1793961e@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814093934.1793961e@dellmb>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:39:34AM +0200, Marek Behún wrote:
> On Fri, 11 Aug 2023 13:16:46 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> tested, works.

I convert this to the Tested-by tag, I hope you won't object.
But tell me if it's the case.

> Please add Fixes tag when sending the patch

Sure, it's done locally that day already :-)

-- 
With Best Regards,
Andy Shevchenko


