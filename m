Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8E787084
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241368AbjHXNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241361AbjHXNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:40:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D3AFD;
        Thu, 24 Aug 2023 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692884406; x=1724420406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5JxF3NtXfjg1zAU90ev0zIFGdywSY+Jx3bPN2EfpVSE=;
  b=JI8Ym3fwWIAwc8xUWIU99qXGNls57mKhrTzbcORbqAH5qj0jbBYiXX61
   650tTCDaW5QmsRLU8SW6tr4Ql7XHJx34ICSYc4paYOHkjzqHuXMI0kTs1
   pvsD9U4Mmc1bcxIALlzt2CwTeJLZjdg01L6A2fuL0ogWd+5jtlV2ABC+7
   1Z7AbRw+X2SM1Rkb/1sHv+ZatwMj8oO/aqoIrL6dU8AmcHLywLZa2Bf0u
   9gKLCUuqN8fGV4EbCYFTrfzt6yatd0gW2AudQyVYIEs3ExstFhB10WxN5
   vt01z2hI13Qlgm7InzmLdNfXCgj103FSdMDHl/kLLhx28sSGrF8RZVIsg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354771480"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354771480"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="983704724"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="983704724"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 24 Aug 2023 06:39:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZAYx-005hgj-18;
        Thu, 24 Aug 2023 16:39:51 +0300
Date:   Thu, 24 Aug 2023 16:39:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 7/7] iio: accel: Add support for Kionix/ROHM
 KX132-1211 accelerometer
Message-ID: <ZOddp3LBHi/3c5XN@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <c41ed69af6432298cbd82896328333f31d41dda0.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdG1wFo892bJU53@smile.fi.intel.com>
 <a3c2e506-3840-0136-a28f-a50eb0fdf72d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3c2e506-3840-0136-a28f-a50eb0fdf72d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:51:18PM +0300, Matti Vaittinen wrote:
> On 8/24/23 15:02, Andy Shevchenko wrote:
> > On Wed, Aug 23, 2023 at 11:16:41PM +0200, Mehdi Djait wrote:

...

> > > +	.yes_ranges = &kx132_volatile_ranges[0],
> > 
> > 
> > This should be the same as
> > 
> > 	.yes_ranges = kx132_volatile_ranges,
> > 
> 
> The driver uses &kx132_volatile_ranges[0] in a few places (for kx022a) so I
> believe this is okay. Well, I know I am biased as I do personally find
> &kx132_volatile_ranges[0] clearer. Here we point to the first element in an
> array - and yes, it may be I am minority here - but at least I wouldn't ask
> for changing this.

It's a minor thingy, can be ignored.

-- 
With Best Regards,
Andy Shevchenko


