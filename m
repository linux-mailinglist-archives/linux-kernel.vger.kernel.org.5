Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582677DDE93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjKAJim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKAJii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:38:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFA4F3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698831513; x=1730367513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rAiOaRdxdTks+AgKUTtVlWVE3XviDyR7YMtV3E15TsI=;
  b=Qa2qVjr/9SJ1Gd/eD1lyAj/F9ikrmijGl7WBp8AmhbqYiS1sMMvr80kk
   PS+/TJE4BPppOtVn9/31yoMTLZgF8vhEJbp4oP61GG19Y/KgrEyBI3eJy
   FqWKTjTs7DEENrO4aGZC5U6Kgm/vNu7z5YLi6f58WaLpjdEliBmqiJGam
   Nz1Ndm+6fnVt/mYNA7WS4o0kmvwH+Cit4gxB3jfV8566lbBLvOV9s7kZz
   Lg3vduzr4AW9QR8M8HkJRtpZ06GPhZuxDbtuBOuq9FVHP7DeO5bQJ2OJe
   YPjI5u8ql1Za6uvpzI9thW9dG6dPBaM57XBvY6H1XUyNfSD+mgSz/82cW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="373510279"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="373510279"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="884504105"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="884504105"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 02:38:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qy7gC-0000000APSW-18t3;
        Wed, 01 Nov 2023 11:38:28 +0200
Date:   Wed, 1 Nov 2023 11:38:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Chen Ni <nichen@iscas.ac.cn>, lee@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Fix IRQ check
Message-ID: <ZUIclOuVocLUUk7_@smile.fi.intel.com>
References: <20231101062643.507983-1-nichen@iscas.ac.cn>
 <20231101070310.GF17433@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101070310.GF17433@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:03:10AM +0200, Mika Westerberg wrote:
> On Wed, Nov 01, 2023 at 06:26:43AM +0000, Chen Ni wrote:
> > platform_get_irq() returns a negative error code to indicating an
> > error. So in intel_lpss_probe() the unset / erroneous IRQ should be
> > returned as is.
> > 
> > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")

> There is no need for Fixes tag here.

I said that already in v1 :-)

...

> > -	if (!info || !info->mem || info->irq <= 0)
> > +	if (!info || !info->mem)
> 
> This check (info->irq <= 0) covers both "invalid" interrupt numbers
> (that's the negative errno and 0 as no interrupt) so I don't see how
> this change makes it any better and the changelog does not clarify it
> either.

It makes sense. The IRQ here may not be 0. We should actually fix
the PCI code to guarantee that (platform_get_irq() guarantees that
in platform driver).

-- 
With Best Regards,
Andy Shevchenko


