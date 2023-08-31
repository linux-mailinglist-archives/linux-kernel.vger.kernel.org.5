Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F0778EE90
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241865AbjHaN0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHaN0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:26:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86720CEB;
        Thu, 31 Aug 2023 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693488396; x=1725024396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HgeKJLJxLH8yLNJRCPDzLYvby7ECj242FxWkt/dJEFg=;
  b=K7Mo1Gj7ITuQFrjz/XSrcq1aapUbhtkblpUAmjuhUUiharjv2PQblSRs
   dQE77b7xi64enbqPh5CL0eqpw1LUvdsxVzJlW084AKducmpIVDTDzuLOD
   cJLKHuikH6c+vimVDhcOiy+PD7Y/uq3Y29pv/aOg1Eb5p1Hz0gcWSDF6h
   Sb7c5hoQpeX8gPIY5rWQNBc91b4cdEG0hodLUlr5D78VHg9ElufPR8H+S
   OadP4Wgftpw81NLOpI09FHO+FhPxcHEsOB4fcOguqD4NVwMFSRqx8JO0W
   auE5DNCH0dB5PyzDhzfHeiAhcfzqipMmoFidCQE5XbpMOX5IW2Og6OPCy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355441464"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="355441464"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="742703754"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="742703754"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 06:26:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qbhgt-005Oew-0N;
        Thu, 31 Aug 2023 16:26:31 +0300
Date:   Thu, 31 Aug 2023 16:26:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, alx@kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
Message-ID: <ZPCVBnf9xzUF+8Da@smile.fi.intel.com>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
 <ZOigoVJbjdOx9Wea@smile.fi.intel.com>
 <ZOx1SOBKbmdIvz+b@gondor.apana.org.au>
 <ZOx6+i5HEAY4F4X3@smile.fi.intel.com>
 <ZO3F8AgOS/NnVaeU@gondor.apana.org.au>
 <ZO375Wg0+nTCgCIJ@smile.fi.intel.com>
 <ZPAPSOnSTMgYrlV/@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPAPSOnSTMgYrlV/@gondor.apana.org.au>
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

On Thu, Aug 31, 2023 at 11:55:52AM +0800, Herbert Xu wrote:
> On Tue, Aug 29, 2023 at 05:08:37PM +0300, Andy Shevchenko wrote:
> >
> > Do I understand correctly that you want *ideally* to have THE kernel.h
> > as a _single_ header and that's it?
> 
> My rule of thumb for a .c file is that if you need more than two
> headers directly included by kernel.h then you should just use
> kernel.h.
> 
> > While I understand your motivation as a maintainer, I hate the idea of current
> > kernel.h to be included as a silver bullet to every file because people are not
> > capable to understand this C language part of design. The usage of the proper
> > headers show that developer _thought_ very well about what they are doing in
> > the driver. Neglecting this affects the quality of the code in my opinion.
> > That's why I strongly recommend to avoid kernel.h inclusion unless it's indeed
> > the one that provides something that is used in the driver. Even though, the
> > rest headers also need to be included (as it wasn't done by kernel.h at any
> > circumstances).
> 
> I have no qualms with fixing header files that include kernel.h
> to include whatever it is that they need directly.  That is a
> worthy goal and should be enforced for all new header files.
> 
> I just don't share your enthusiasm about doing the same for .c
> files.

I see, thanks for clarifying this. While you are right about *.c files that
it's not so critical for them, the kernel.h use is still a burden everywhere
in the kernel (at least in the current form). That's why I prefer to exclude
it from *.c-files as well. This will reduce amount of work in the future in
case we will be capable to clean up the crap from kernel.h and make it sane.

-- 
With Best Regards,
Andy Shevchenko


