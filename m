Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904AA76F99B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 07:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjHDFg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 01:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjHDFgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 01:36:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1FAE46
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 22:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691127381; x=1722663381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2xmlsVCXXnRZ5WQZgizNnKFlU3XJq+04NvpRMM9jhRA=;
  b=Gicjms3pOLognJ8RpKeqJbFODRxhpBBsOqyYC0KaO4vvqCK+LkoZ9Q+L
   f8kIOk/DoLfr9oRo1Sg1oAc0v6S/g+r0GNKvqNFJOHUdXbV7fpqppm0bj
   Q1GSJVxnTCfou6AOJgTdaCEICpC/9BkscwO/23ftoX/pD6+tGePpe6P0m
   Vhsu0cb182ZAHqe+d6hUBfiWGbP2ToxVTMZl1+ExkQoZwoBI/KHVehD9q
   mT9OU9IQ4hjKqPXOnt9ttRSwMnolLk9/zrxZXLHwL3iUe9rlRL9KkJrh+
   cR5KWdKBKtheqBlSedC+ANuAFGRCWY0/J0loSlWm7lSNfHwtvSG+3wz81
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="436395274"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="436395274"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 22:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976406165"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; 
   d="scan'208";a="976406165"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 03 Aug 2023 22:36:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRnU1-00Bpv1-0E;
        Fri, 04 Aug 2023 08:36:17 +0300
Date:   Fri, 4 Aug 2023 08:36:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] math.h: Document abs_diff()
Message-ID: <ZMyOUAgIRqkz2ett@smile.fi.intel.com>
References: <20230804050934.83223-1-andriy.shevchenko@linux.intel.com>
 <a1640e13-75b5-bc3c-74a6-5eaf6d74e7bc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1640e13-75b5-bc3c-74a6-5eaf6d74e7bc@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:23:48PM -0700, Randy Dunlap wrote:
> On 8/3/23 22:09, Andy Shevchenko wrote:

...

> > +/**
> > + * abs_diff - return absolute value of the difference between the arguments
> > + * @a: the first argument
> > + * @b: the second argument
> > + *
> > + * @a and @b has to be of the same type. With this restriction we compare

> Preferably s/has/have/.

Thank you! I fixed it locally, I hope Andrew can update this, but if needed
I will send a v2 with the proposed correction.

> > + * signed to signed and unsigned to unsigned. The result is the subtraction
> > + * the smaller of the two from the bigger, hence result is always a positive
> > + * value.
> > + *
> > + * Return: an absolute value of the difference between the @a and @b.
> > + */

-- 
With Best Regards,
Andy Shevchenko


