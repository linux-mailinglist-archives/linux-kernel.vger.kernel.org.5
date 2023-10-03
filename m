Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C4B7B6ACA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjJCNnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjJCNnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:43:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8D9A9;
        Tue,  3 Oct 2023 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696340600; x=1727876600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hw0ayp22z4CmtSiw9uB00dc9fNsdO2wP7X3iUKvjq8U=;
  b=WmSbR74Nh7ZRewrX3LanhPi9K4Oke50gooPotKHmRJysJPmtqM+HHH0q
   jovxDNsjja0iQ7eKnXyGdm62GrR+ArsYUnS18V4ZSc8PQCjFcTWFpwamZ
   jzUnRUELf8ZLoVeLlTUnZmCSYL+oWG7wvgwa7KTPAlTgnjeHNIzb7C2ms
   uHMEzg+oZLPgd46lp0nWTi1L9rEiHmh9oq0wR7etKAlJK1LRQ6Ua1Fjnm
   yhAf/BMeMe2LKarIinoTtoCSgT6bL9v3wPK6neh2f0m1PbZ2LNi3srVjY
   se0eBh30dMMeYyv6GHkpRZTOaVHUGXZwiBVqFvH49y+IpUeH3sVTlLLLb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381755249"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381755249"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 06:43:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="841352572"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="841352572"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 06:43:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnfgB-00000002V0n-3Egb;
        Tue, 03 Oct 2023 16:43:15 +0300
Date:   Tue, 3 Oct 2023 16:43:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 0/2] Drop runtime PM support for Baytrail and
 Lynxpoint pinctrl
Message-ID: <ZRwacwamilg/yN1q@smile.fi.intel.com>
References: <20231003114036.27674-1-raag.jadav@intel.com>
 <ZRwGGS+Uilr/egln@smile.fi.intel.com>
 <ZRwXoK2fca3buQ9y@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRwXoK2fca3buQ9y@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 04:31:12PM +0300, Raag Jadav wrote:
> On Tue, Oct 03, 2023 at 03:16:25PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 03, 2023 at 05:10:34PM +0530, Raag Jadav wrote:

...

> > You forgot --base... :-(
> 
> Sorry, I need to go figure out some send-email automation.

You can start with my "smart" script [1] (patches are welcome!).

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


