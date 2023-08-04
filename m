Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1736276F8C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 06:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjHDEHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 00:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjHDEHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 00:07:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861AF3C28;
        Thu,  3 Aug 2023 21:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691122042; x=1722658042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nct1OPaQWyF0NLQQ6u7Wq7eG9CS3igaS6y0hh8xq7cc=;
  b=P+mTRk0pXznlqitB1u0k4IgWqFzHW6Q69Y7LD1EgJiZ8s32Wnp8jexBh
   Q6npLYLmmP8Zcu0bFVOGXi0sO06FlbQ9qliXd2+TXhQ0CA0Jr4qf1QaRC
   EgHc8X+NyeUeWym7wWggt60pVhftfk+EEQA3d1x1JezGZM60vivSeIlu/
   CId8NjVOlGe+KCrhctoIsk5z8z5NikS9P+c7dIjCrcxzn7Gms3NCjzjPE
   fQrBvR3KjCSkL3CO0XxZ7JzWT7pCCc2z60e9Y6DVv4zTKaNiQOxWePeQS
   Oaxvh5VVxvvBYG6abP4ob7hwKQRoVC30JXaN74Poyk6wZTevn0Kxx3mIb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368962279"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="368962279"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 21:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="679758521"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="679758521"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2023 21:07:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRm5q-008pgS-0y;
        Fri, 04 Aug 2023 07:07:14 +0300
Date:   Fri, 4 Aug 2023 07:07:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 1/1] drm/i915: Move abs_diff() to math.h
Message-ID: <ZMx5cp1u5noAH0Zg@smile.fi.intel.com>
References: <20230803131918.53727-1-andriy.shevchenko@linux.intel.com>
 <20230803102446.8edf94acc77e81ab2e09cee3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803102446.8edf94acc77e81ab2e09cee3@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:24:46AM -0700, Andrew Morton wrote:
> On Thu,  3 Aug 2023 16:19:18 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > +#define abs_diff(a, b) ({			\
> > +	typeof(a) __a = (a);			\
> > +	typeof(b) __b = (b);			\
> > +	(void)(&__a == &__b);			\
> > +	__a > __b ? (__a - __b) : (__b - __a);	\
> > +})
> 
> Can we document it please?
> 
> Also, the open-coded type comparison could be replaced with __typecheck()?
> 
> And why the heck isn't __typecheck() in typecheck.h, to be included by
> minmax.h.
> 
> etcetera.  Sigh.  I'll grab it, but please at least send along some
> kerneldoc?

Sure and thank you!

-- 
With Best Regards,
Andy Shevchenko


