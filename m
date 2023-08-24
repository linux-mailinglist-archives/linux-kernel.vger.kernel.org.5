Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB9787108
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240960AbjHXOGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjHXOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:05:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9670719A0;
        Thu, 24 Aug 2023 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692885947; x=1724421947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JHnxnhsgSXxo4kxl1LPWQSy8+89EqVAhWiLsQc6eRYE=;
  b=ZR236XtTAk30f0OhWwhR3IUeojR3DbEVYBErWKNFYRA02mbTq9MmoqRP
   PebxCGkLFAfvqBVjf5EzR+DveQQenAiwgI8zGI/ODbpuK0JUGadc+arX4
   P8wG6hoYm1TQ9WZLBiPLIQtFDaqUsVLXAUAIes7zsWEXi+FiAUDC1A14x
   aBMTU/nCRTeSFXt59VQ2tsugHyxzjltXdavqJHoUGRivnrFYKwkX3Mjwl
   StFdURchJ6e5CeIKYQx/gcXmBBHddtUifSTQLNXgBnqW531cc0ixH+8YM
   z9yojD2UHmjlP5YvbI69bpVfqa561Nlxc90glheT+qvcxFEmUy5A5etCw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="378213939"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378213939"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 06:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="772105678"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="772105678"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 24 Aug 2023 06:47:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZAgT-005yQg-2M;
        Thu, 24 Aug 2023 16:47:37 +0300
Date:   Thu, 24 Aug 2023 16:47:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <ZOdfeaW6AxE4eeqw@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
 <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
 <ZOdFyKHBc6BcOgZw@smile.fi.intel.com>
 <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
 <ZOdddZ0Zpk5CknH8@smile.fi.intel.com>
 <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 03:44:29PM +0200, Mehdi Djait wrote:
> On Thu, Aug 24, 2023 at 3:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Aug 24, 2023 at 03:52:56PM +0300, Matti Vaittinen wrote:
> > > On 8/24/23 14:58, Andy Shevchenko wrote:
> > > > On Wed, Aug 23, 2023 at 11:16:40PM +0200, Mehdi Djait wrote:

...

> > I see. I think my confusion can be easily cured by renaming the callback to
> >
> >         get_amount_bytes_in_fifo()
> >
> > or
> >
> >         get_bytes_in_fifo()
> >
> > or alike.
> 
> or leave it as is. The function is documented:

> + * @get_fifo_bytes: function pointer to get number of bytes in the FIFO buffer

Do you find it unambiguous? I do not.

Still needs more words to explain if it's a capacity of FIFO or is it amount of
valid bytes for the current transfer or what?

-- 
With Best Regards,
Andy Shevchenko


