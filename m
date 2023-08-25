Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4D78879B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbjHYMi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbjHYMh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:37:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069FF1BE;
        Fri, 25 Aug 2023 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692967078; x=1724503078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0P8LVyyYV/bBtuIZwJOj8Oxh3A98oYPL5yCf8fQ3JY=;
  b=GyZHVNukuumCqD7eWC1JXFuCAIAxcfgtmcsXNZeGGzdHVkaXPvgf0Hbe
   Cld6UKt8DnEecX47GMvMKBtIg6Ft6II6ERCy1JbxL4AGqTwK9cXPYpXgB
   qNDKx0K4LdCLvnE7fVvZdKDjJUyVU4jSGR0HXkYx0KPqaQ7eYdE4pbQQ1
   qTmRzjJbkHC+uhH4vCIuvTm6G0Oy/yD8dhLxKOLOUSzMPj7NCq591xrVi
   C2hR1dvZxrWgxQTZS2L5pNKskQTqxaC9Imgw/UdmKwY1zFGU4Kt7N/To8
   Iyu3NpAFTxtUIbp0ioqhuNzflvltvjkz1KepkcjB5/f2R+L6DYi385nlk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="354233284"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="354233284"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 05:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="740598066"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="740598066"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2023 05:37:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qZW4X-00HUOr-2Z;
        Fri, 25 Aug 2023 15:37:53 +0300
Date:   Fri, 25 Aug 2023 15:37:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, alx@kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
Message-ID: <ZOigoVJbjdOx9Wea@smile.fi.intel.com>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOiEHCsjBCL04Z3x@gondor.apana.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 06:36:12PM +0800, Herbert Xu wrote:
> On Fri, Aug 18, 2023 at 12:23:08PM +0200, Lucas Segarra Fernandez wrote:

> > +#include <linux/kstrtox.h>
> > +#include <linux/types.h>
> 
> Please include linux/kernel.h instead of these two.

Why?

-- 
With Best Regards,
Andy Shevchenko


