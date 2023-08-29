Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1614078C6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbjH2OI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236897AbjH2OIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:08:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2C3AB;
        Tue, 29 Aug 2023 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693318128; x=1724854128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QcRTdMPxHjuLWDOXyu4h/ormVbye2DsbkNaPbcklGUs=;
  b=Q5srh7GOp39G4Mz4rtS1SZJt4o4tUc2NE4vXhnXDiKHYbGNw4TgcCNGP
   sq6C/DsUrANRjv9AxT2pzC5kVA8RFXYroS5A6jfg/1WIxN+l/GegMb0tR
   jgZuEbOvFiJHXNUF9pw9gdHgm+hpwnpa2JVyrqjqSZ1Ay7rAYOmA5N3eU
   eUmkKGkoELhHjRehRr96AIYK/f9rwb0oG5PMulNIW80rG7psuZLSxNFIu
   RVQ0Aw9BbUR0qJISO/xyT5cKxcHFB/h04C9t0Z5ixvDWcrrjfIE6dFrD9
   2KH6aCZ51e2z6hQ/GAyATrmFXYSX/3Mexy4ZLQ2ey3AzCAac6yfdiOzuY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="378094343"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="378094343"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="741827436"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="741827436"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2023 07:08:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qazOX-004tjD-1H;
        Tue, 29 Aug 2023 17:08:37 +0300
Date:   Tue, 29 Aug 2023 17:08:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, alx@kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
Message-ID: <ZO375Wg0+nTCgCIJ@smile.fi.intel.com>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
 <ZOigoVJbjdOx9Wea@smile.fi.intel.com>
 <ZOx1SOBKbmdIvz+b@gondor.apana.org.au>
 <ZOx6+i5HEAY4F4X3@smile.fi.intel.com>
 <ZO3F8AgOS/NnVaeU@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO3F8AgOS/NnVaeU@gondor.apana.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 06:18:24PM +0800, Herbert Xu wrote:
> On Mon, Aug 28, 2023 at 01:46:18PM +0300, Andy Shevchenko wrote:
> >
> > kernel.h is misleading here. It includes 98% of something which this file is
> > not using or going to use. Can you tell _why_ we need that 98% bulk to be
> > included here?
> 
> For most drivers in drivers/crypto they will need multiple header
> files included by kernel.h.  I'd hate for people to start posting
> patches replacing one inclusion of kernel.h with multiple inclusions.
> 
> They're bound to get it wrong and we'll be forever dealing with
> random build failures because someone changes a random header
> elsewhere which then exposes a missed inclusion.

Do I understand correctly that you want *ideally* to have THE kernel.h
as a _single_ header and that's it?

While I understand your motivation as a maintainer, I hate the idea of current
kernel.h to be included as a silver bullet to every file because people are not
capable to understand this C language part of design. The usage of the proper
headers show that developer _thought_ very well about what they are doing in
the driver. Neglecting this affects the quality of the code in my opinion.
That's why I strongly recommend to avoid kernel.h inclusion unless it's indeed
the one that provides something that is used in the driver. Even though, the
rest headers also need to be included (as it wasn't done by kernel.h at any
circumstances).

-- 
With Best Regards,
Andy Shevchenko


