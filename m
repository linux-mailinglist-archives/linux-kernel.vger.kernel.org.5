Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDAF78EF50
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346258AbjHaOJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245476AbjHaOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:09:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B1AB8;
        Thu, 31 Aug 2023 07:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693490985; x=1725026985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X39F6ruqS79stTr3dP59PNYtIfJSvM7ItKv/bC8c6Qk=;
  b=kQ7QSaa1M9P0ShM+M2Z4La51yMnvtkQlhz+TItrrrJd4UDZAcNRvR+fk
   YPn+34UzVbwpVf7EdAaPt24/ubSomtZA1Cxw+CmSxgfWdxsM1kP/QGqL0
   uIfoHpRrWhye7mRkd9wESHldJN4EfGNH0Ip5Dt7QShRhYQK+rfCX90KPt
   YCCLv4vvBwua7W0G5hZ0wuhuiM4x2BWwNm4kV9nMgHD+/hSxPYHALwsbT
   9RylxahFzn/QsWcMxS2OdtTXQPDJ5DiCqrpNXMr/Q91/Am32zwBVqUOa8
   2KWW1cDAg/6rsEZlpDtXO4PXLUHRKnkeudgBkgR4J04uaLvaUDph+N5Uk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="379714299"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="379714299"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:29:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="986235185"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="986235185"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:29:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qbhjY-005Ogy-13;
        Thu, 31 Aug 2023 16:29:16 +0300
Date:   Thu, 31 Aug 2023 16:29:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Alejandro Colomar <alx@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
Message-ID: <ZPCVrE8SqyAC7rG/@smile.fi.intel.com>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
 <ZOigoVJbjdOx9Wea@smile.fi.intel.com>
 <ZOx1SOBKbmdIvz+b@gondor.apana.org.au>
 <ZOx6+i5HEAY4F4X3@smile.fi.intel.com>
 <ZO3F8AgOS/NnVaeU@gondor.apana.org.au>
 <ZO375Wg0+nTCgCIJ@smile.fi.intel.com>
 <ZPAPSOnSTMgYrlV/@gondor.apana.org.au>
 <88708464-cc1c-c31d-5cb0-171a41dec936@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88708464-cc1c-c31d-5cb0-171a41dec936@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:18:11PM +0200, Alejandro Colomar wrote:
> On 2023-08-31 05:55, Herbert Xu wrote:
> > On Tue, Aug 29, 2023 at 05:08:37PM +0300, Andy Shevchenko wrote:
> >>
> >> Do I understand correctly that you want *ideally* to have THE kernel.h
> >> as a _single_ header and that's it?
> > 
> > My rule of thumb for a .c file is that if you need more than two
> > headers directly included by kernel.h then you should just use
> > kernel.h.
> > 
> >> While I understand your motivation as a maintainer, I hate the idea of current
> >> kernel.h to be included as a silver bullet to every file because people are not
> >> capable to understand this C language part of design. The usage of the proper
> >> headers show that developer _thought_ very well about what they are doing in
> >> the driver. Neglecting this affects the quality of the code in my opinion.
> >> That's why I strongly recommend to avoid kernel.h inclusion unless it's indeed
> >> the one that provides something that is used in the driver. Even though, the
> >> rest headers also need to be included (as it wasn't done by kernel.h at any
> >> circumstances).
> > 
> > I have no qualms with fixing header files that include kernel.h
> > to include whatever it is that they need directly.  That is a
> > worthy goal and should be enforced for all new header files.
> > 
> > I just don't share your enthusiasm about doing the same for .c
> > files.
> 
> <https://include-what-you-use.org/
> 
> Maybe this is helpful, if you didn't know about it.  :)
> (I disagree with the forward declarations that are recommended there,
> though.)

Yeah, but IWYU is too radical and requires a lot of manual job done in
the kernel. Jonathan tried it at some point.

I prefer to have a balance here (not to include literally _everything_
what we are using, just generic enough).

-- 
With Best Regards,
Andy Shevchenko


