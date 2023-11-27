Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758967FA05F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjK0Muk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjK0Muh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:50:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F54C19D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701089442; x=1732625442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aSRjgfFZERfpt1uNhcSIIvD+EE3DjlExYDVUjg6vshk=;
  b=EQ/UrXlYOEaAKYtEDiXq0Y2XHDYoF6HZzg9p5IOr6E9jzN7mhksdNzgM
   3KdkWtYH86Yg519KgwYR3TeeNM2iU71DwtWzuJS6giAIP3lmUIRJ9YiBI
   +kNAD+eQM+Yqf6xVz4E22iCXWX1ZRqCcENCHRyuMpC4fHf4+8wBk+BdHG
   HSfBf0NoeiQv+3eH5y2m8gSvQRYBR8vgxNGpBwmakupbNpMz2Fv0GM0gH
   9N7Cg1/l4EnzbhQux1/dDFYxohvs0hfQkKNqVl57WiTbw1fcJW4qUmPK2
   Op14Tm3tF6oRdMku46w+cUyAWGyPh56EnMy6jT9eXfUVLE4NPknX1fc/u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="457028034"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="457028034"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 04:50:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="1015554098"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="1015554098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 04:50:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r7b4P-0000000HTWN-462j;
        Mon, 27 Nov 2023 14:50:37 +0200
Date:   Mon, 27 Nov 2023 14:50:37 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: intel-lpss: Add missing check for
 platform_get_resource
Message-ID: <ZWSQnZfGKQ_0DaYJ@smile.fi.intel.com>
References: <20230609014818.28475-1-jiasheng@iscas.ac.cn>
 <ZWDhpZLCZ5xz1RKR@smile.fi.intel.com>
 <20231127085356.GD1470173@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127085356.GD1470173@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 08:53:56AM +0000, Lee Jones wrote:
> On Fri, 24 Nov 2023, Andy Shevchenko wrote:
> > On Fri, Jun 09, 2023 at 09:48:18AM +0800, Jiasheng Jiang wrote:

...

> > > Fixes: 4b45efe85263 ("mfd: Add support for Intel Sunrisepoint LPSS devices")
> > 
> > This does not fix anything and just introduces a duplication code.
> > I would like this to be reverted. Should I send one?
> 
> Checking this value at the source of obtention and providing and earlier
> return with arguably a better return value, all at the cost of an
> inexpensive pointer comparison to NULL doesn't sound like a terrible
> idea.

In general, I agree with you, but the cases similar to this. Why?
Because memory resource retrieval and remapping has a lot of helpers,
some of which are enriched with own error handling and messaging.

Yes, we use devm_ioremap_uc(), which doesn't give that (yet?).
However, it will be more work if we, theoretically, switch to
something like devm_ioremap_resource() in the future.

Hence, I would like to have a common code to be in common place
and behave in the same way independently on the glue druver (PCI,
ACPI, etc).

> If you were committed to the idea of removing it, which I suggest you
> reconsider, I would insist that you replace it with at least a comment.

Isn't what I have done in the series I sent last week?

-- 
With Best Regards,
Andy Shevchenko


