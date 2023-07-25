Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD89761D21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjGYPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGYPQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:16:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C0122;
        Tue, 25 Jul 2023 08:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690298194; x=1721834194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xpHwSbXJDRSJ66SV37sB5LCnaud2LYp/SXO1YFM1PJ4=;
  b=aMlxej4SkBVltj9tM8XvPg6cPMFtIZEF+ilGkNeucbAEzWEx182WrnEf
   xZ+Ngu8BXxio3870xvoHcH69N7n5GgeHWOeAJwVrD69XKD2vxxMz/AXXm
   Be3KeK7FCD6kMIw7AYIGXLJBtR0lhzV8dqmWxgXMCXQ7PTqdZUPl78fOg
   mjyUi5k+bA/wAD3Og4CvRQondFqoqELsn0SChja5JzqyW+tzqQMbd3fDa
   fe64vjGK/708TrZ+nO+uUPD9pxHt8YgEosI20TzfPR/CEi9D0s60FLWyB
   gu33vBNtRhmTRrEXszhczpoPIJlc6lUivN8/lAqrB4CZCXm5JU6kq8NLy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="434009697"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="434009697"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="850066794"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="850066794"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 25 Jul 2023 08:16:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOJm3-00FDHf-0I;
        Tue, 25 Jul 2023 18:16:31 +0300
Date:   Tue, 25 Jul 2023 18:16:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Message-ID: <ZL/nTi3LNPiLI8dF@smile.fi.intel.com>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
 <87a5vkb0ee.fsf@meer.lwn.net>
 <b761d010-ef21-4be6-b6c3-678498b7fa71@sirena.org.uk>
 <ZL/W5rc043oPLfMV@smile.fi.intel.com>
 <29369f0b-732d-4d20-9afa-0918dba0f512@sirena.org.uk>
 <ZL/e9oguxJ8+nht/@smile.fi.intel.com>
 <4f6c9be9-22bd-472e-a20a-cd361b46e005@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f6c9be9-22bd-472e-a20a-cd361b46e005@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:51:44PM +0100, Mark Brown wrote:
> On Tue, Jul 25, 2023 at 05:40:54PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 25, 2023 at 03:27:58PM +0100, Mark Brown wrote:
> 
> > > There was some random patch you just sent me the message ID for in the
> > > replies to something from Stephen which I'm fairly sure I queued,
> > > perhaps it was a different thing or git thought it was a noop when it
> > > was applied?
> 
> > The first version is here [1].
> > Then it was a discussion about Linux Next build issues [2].
> 
> > In the discussion I mentioned:
> 
> >   The 20230713165320.14199-1-andriy.shevchenko@linux.intel.com had been sent.
> 
> > which is exactly what [1] is.
> 
> > I have no idea how it can be a noop, but the patch is missing as far
> > as I can tell.
> 
> > This thread is v2 of what was in [1].
> 
> > [1]: https://lore.kernel.org/linux-doc/20230713165320.14199-1-andriy.shevchenko@linux.intel.com/
> > [2]: https://lore.kernel.org/linux-next/20230713121627.17990c86@canb.auug.org.au/T/#u
> 
> So there's two versions of the patch and for some reason v1 was
> mentioned yesterday but there's also a v2 version?

Yes, and I forgot to initially Cc you for v2.

If you are using b4, you can take Message ID of this message and I am sure it
capable to retrieve v2 of the patch. Or I can resend with you in Cc list.

-- 
With Best Regards,
Andy Shevchenko


