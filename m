Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61877CE4A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237711AbjHOOj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbjHOOjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:39:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207F410F4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692110359; x=1723646359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1QsjsphQD4R65At3tzZerTNLkM9c1wf3X6C5UAeg5c4=;
  b=Btc+KIB5yeMu1q7kBJit4K/nd5Lnjv8iU4SeBg/vdn4MZiHjQttuznL6
   GNhtBnvsQoULCJqEDjx0jo3cEeMuSIbD+v8X8nzn7w+fRMNWJY/8X6o5u
   gNRHN26uS1NXXDirxVR8mDTl2IGz7Y/x+GPAW4k4JQQ00FsRU9Uyo1avv
   a8igRtB9AkxElxYroc1fhkCOoGWXLaRWiAs2xcWRDK5iDZvWk3N6AmxWc
   kF+zz0KULJ0RnKTQjSgGOxtD/Gc0Wb/mazro7PEtaWftxTujP/TrIB+Pm
   IPstzyr1r8dXUZMh1s8kbo/mkbfmkaP6Tg3QvipExDDQ1FWkQcLnbqVal
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371202941"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="371202941"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:39:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877361572"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2023 07:39:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvCP-005a2x-0P;
        Tue, 15 Aug 2023 17:39:09 +0300
Date:   Tue, 15 Aug 2023 17:39:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        rostedt@goodmis.org, pmladek@suse.com, linux@rasmusvillemoes.dk,
        glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org
Subject: Re: + lib-vsprintf-split-out-sprintf-and-friends.patch added to
 mm-nonmm-unstable branch
Message-ID: <ZNuODCU2i0Mr2l8R@smile.fi.intel.com>
References: <20230814183752.0E34CC433C8@smtp.kernel.org>
 <893b27ec-3f78-47fc-8298-903f991d5aaa@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893b27ec-3f78-47fc-8298-903f991d5aaa@p183>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 05:24:27PM +0300, Alexey Dobriyan wrote:
> On Mon, Aug 14, 2023 at 11:37:51AM -0700, Andrew Morton wrote:

...

> > +__scanf(2, 3) int sscanf(const char *, const char *, ...);
> > +__scanf(2, 0) int vsscanf(const char *, const char *, va_list);
> 
> I'd suggest to leave scanf alone and rename file to printf.h
> Some archs have such files already (printf.c)

if you are talking about these

$ git ls-files */printf.c
arch/m68k/sun3/prom/printf.c
arch/sparc/prom/printf.c
arch/x86/boot/printf.c

they have no business with the main Linux kernel code.

I don't think we need to go that direction.

-- 
With Best Regards,
Andy Shevchenko


