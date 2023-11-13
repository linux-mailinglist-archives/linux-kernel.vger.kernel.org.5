Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95497EA154
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjKMQgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:36:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E8F7;
        Mon, 13 Nov 2023 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699893397; x=1731429397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PY0SZUM9D2Iqpbq6NuXnG6uxnJLFUzWqQrwtn9mx/MI=;
  b=Sw0l5lD3nLuIrP6GKPsFlPeaPPXbyf7bAdv9qz5QWJfZFN8rE7qdgfJt
   3ulx7uNtnpqB1upfInyxvDG8/xw0GGJwPMDEgzbn4yyzLNQzuENFJKstG
   SROF0WqFBdQI5JjetF1i0/kUAnPh9Sy64gNYbTKw8r0AVq57QXRk++QS8
   3itxP9JCpUkWnXqsHJG5JU1QtRnyppN5mXujBLEWx/fJAwD/2gbAseIMY
   tDNX3+GQsyrH41GEfZaU718DFLMIjMB2WGbEsV17dN8AaPJFtkZpx4gf6
   IaD84KlE4pTbB1LlNGyMqdHEK0XI8gxzDTzC5LKRsXj6aGcVY6XyN2mJU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="456955860"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="456955860"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:35:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="937784242"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937784242"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:35:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2Zua-0000000Dbcc-0UWo;
        Mon, 13 Nov 2023 18:35:44 +0200
Date:   Mon, 13 Nov 2023 18:35:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "larry.lai" <larry.lai@yunjingtech.com>, lee@kernel.org,
        pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        GaryWang@aaeon.com.tw, musa.lin@yunjingtech.com,
        jack.chang@yunjingtech.com, noah.hung@yunjingtech.com
Subject: Re: [PATCH V7 2/3] pinctrl: Add support pin control for UP board
 CPLD/FPGA
Message-ID: <ZVJQX5sfbwersjLo@smile.fi.intel.com>
References: <20231031015119.29756-1-larry.lai@yunjingtech.com>
 <20231031015119.29756-3-larry.lai@yunjingtech.com>
 <CACRpkdbPWxQMz_1gG1He5QN65BActhyea_KBv2cyQ_VQxc6Feg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbPWxQMz_1gG1He5QN65BActhyea_KBv2cyQ_VQxc6Feg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 03:15:58PM +0100, Linus Walleij wrote:
> Hi Larry, Andy,
> 
> On Tue, Oct 31, 2023 at 2:51 AM larry.lai <larry.lai@yunjingtech.com> wrote:
> 
> > The UP Squared board <http://www.upboard.com> implements certain
> > features (pin control) through an on-board FPGA.
> >
> > Reported-by: kernel test robot <lkp@intel.com>

It may not be reported as it's brand new code.

> > Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
> > Signed-off-by: larry.lai <larry.lai@yunjingtech.com>

(...)

> > +#include "core.h"
> > +#include "intel/pinctrl-intel.h"

> As mentioned this is using the intel core pin control driver infrastructure
> so I want Andy's ACK on this before I merge it.

I'm pretty much sure it's an abuse of that.

I guess I told this already in the previous rounds of review... I'll try to
find time to look at this, but it looks like it still needs some job before
being taken.

-- 
With Best Regards,
Andy Shevchenko


