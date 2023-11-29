Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3D7FD3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjK2KTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjK2KTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:19:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E0BA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701253168; x=1732789168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3SPZbtqVDMWq6w4WTsaBdEU6bWK9YPoSMPsXmWSnY+c=;
  b=Hn1GIHHtH7+2T2pAZiPM+JnWG+bPZHJ6BfQoLxvZjZa8uSUTW3DTeU8G
   E8QddRbXbLwwgTYilrjJDNemiP2rr2rG2WDje4K2K5qYK5U0/hvYs9lx9
   +hN3hAYSjpXnNTCmFLuiJIv//4OCg7psDeR6oWdnPP4CQjd0ePHSB9byn
   XJf0dlBjRDdtBq2n28YfJt98vtCW1GA9UmF2a4+mTomIpxudn2FJc84TE
   wZlBfsu78lfjWl3HJpfsZQSQsGl+At+dOmV5CuzyhwjtsvMjjY020Uedk
   ixlAmyuADzON215r21ZHIHtm5nkiSdmQbJQfNoQTp8AlZxbiwFQrRNm9a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="26495"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="26495"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:19:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="912792822"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="912792822"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:19:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8Hf8-00000000Pgh-021O;
        Wed, 29 Nov 2023 12:19:22 +0200
Date:   Wed, 29 Nov 2023 12:19:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Damian Muszynski <damian.muszynski@intel.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v1 1/1] units: Add missing header
Message-ID: <ZWcQKYlCXUIAGnlK@smile.fi.intel.com>
References: <20231128174404.393393-1-andriy.shevchenko@linux.intel.com>
 <20231128180957.ac5caa884abb2b5f00ca47c4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128180957.ac5caa884abb2b5f00ca47c4@linux-foundation.org>
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

On Tue, Nov 28, 2023 at 06:09:57PM -0800, Andrew Morton wrote:
> On Tue, 28 Nov 2023 19:44:03 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > BITS_PER_BYTE is defined in bits.h.
> > 
> > Fixes: e8eed5f7366f ("units: Add BYTES_PER_*BIT")
> 
> This is post-6.6, so the fix should go into this -rc whatever happens, but...
> 
> It would be rather nice to know the effects of this change please.  Did
> some build break?

Not of my knowledge. Fixes tag here to make sure people won't forget that
headers are special and we need a bit stricter rules on how we add a new
stuff (which will require another header) or remove an old one (which may
give a stale inclusion).

-- 
With Best Regards,
Andy Shevchenko


