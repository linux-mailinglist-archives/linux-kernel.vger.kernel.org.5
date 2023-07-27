Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60D87654A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbjG0NKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjG0NKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:10:42 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7679C211C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690463420; x=1721999420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/lwz7NzWnByDhqIuXrpnxSlLdfcwu8DhHulc0zwVbck=;
  b=WBVJ2AYBkqmlXcz0vJ1sw5dH4yY5NPWjdFlKTCaZyYHYzQ7h/oDpuNwQ
   0tH4AgWlYP5D7Zwby8/8NUUOq5BMys5qkuQHIj88ILw2t4q0UMzqQF4Ob
   mXAbMIqwNpFi2T3PVK02+FZWuwyiHthhtgNzwJAF0Wwjm/li8CxVPTOUh
   NGwIY0U0S/edACFIN7ElNzpTqUolxRGL/ypadS+jxdlcVkiQ83E5io0eH
   AL1fUgdVZMcRkbNzXdJ1Z0OO/ytKt7rVpo/6P84dQaf0XqyXxAd0N2rBX
   TnCnYunlj6XcIlTq1r2ELyI3761HkKa9BoW2hh2AEaQlSZK41scLWhf2l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367182941"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367182941"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 06:10:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817079607"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="817079607"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 06:10:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qP0kz-005E43-07;
        Thu, 27 Jul 2023 16:10:17 +0300
Date:   Thu, 27 Jul 2023 16:10:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] minmax: Fix header inclusions
Message-ID: <ZMJsuKFrYvSWlhjK@smile.fi.intel.com>
References: <20230721133932.12679-1-andriy.shevchenko@linux.intel.com>
 <20230721161033.55bc133c@bootlin.com>
 <ZL6KxZh9SwizrApS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL6KxZh9SwizrApS@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:29:25PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 04:10:33PM +0200, Herve Codina wrote:
> > On Fri, 21 Jul 2023 16:39:32 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> 
> Thank you!
> 
> Note, the https://lore.kernel.org/all/20230724142307.28411-1-andriy.shevchenko@linux.intel.com/
> has a fix to the broken builds the LKP reported about.

Andrew, since the build fix is in your tree, can you apply this one
on top of that, please?

-- 
With Best Regards,
Andy Shevchenko


