Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1DF75C46F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjGUKR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjGUKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:16:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358923C0F;
        Fri, 21 Jul 2023 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689934553; x=1721470553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z97GlncTszgLV54yUBZc5/yl2uCx8DjeagF255hYrm4=;
  b=NrF0j9hDCliOq2hfla9ecayw/BceiY6vR/ryiCbD+EMwQNV30XGZk3X6
   WivK+MFqLEY5L5KgenqnpC9h7asnAX3y9tuh9DlcH5g7QMzT2VwKqaspe
   b9xblVVa/S96R/fx50gdrdfTOp+7RABgDqIbHmEgbiqskHM3PLNAlRSUR
   ZLbFn3aQpqFrEXKW4yiT+W+uGyGu7f5Bapq/7Nd8GX/hpdQx2xu5LDosW
   R0KtYbkbEk2S4AzQpY8gPcMvo6FNIh3/jKpp+Q7F6zW0/VAmyMTWG21ft
   snYOalC1VB66u8iq9vAE4n8fkmzBh0fVXbkkIupx98M2YatsK+gz3lMnq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="356973978"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="356973978"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759907990"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="759907990"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2023 03:15:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMnAL-00HAtl-04;
        Fri, 21 Jul 2023 13:15:17 +0300
Date:   Fri, 21 Jul 2023 13:15:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 0/8] iio: core: A few code cleanups and documentation
 fixes
Message-ID: <ZLpatHP1R9bHRFJF@smile.fi.intel.com>
References: <20230720205324.58702-1-andriy.shevchenko@linux.intel.com>
 <d65e25da75142b7414cbf082c7f485464b82b6d1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d65e25da75142b7414cbf082c7f485464b82b6d1.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:06:05AM +0200, Nuno Sá wrote:
> On Thu, 2023-07-20 at 23:53 +0300, Andy Shevchenko wrote:
> > Just set of almost unrelated to each other cleanups against IIO
> > core implementation.
> > 
> > The positive LoCs diffstat due to first patch that adds a lot of
> > documentation for the new added macro.
> > 
> > Andy Shevchenko (8):
> >   iio: core: Add opaque_struct_size() helper and use it
> >   iio: core: Use sysfs_match_string() helper
> >   iio: core: Switch to krealloc_array()
> >   iio: core: Use min() instead of min_t() to make code more robust
> >   iio: core: Get rid of redundant 'else'
> >   iio: core: Fix issues and style of the comments
> >   iio: core: Move initcalls closer to the respective calls
> >   iio: core: Improve indentation in a few places
> > 
> >  drivers/iio/industrialio-core.c | 226 ++++++++++++++++----------------
> >  1 file changed, 115 insertions(+), 111 deletions(-)
> > 
> 
> Neat series... Just a few comments on my side and on patch 3 is up to you to
> take the comments or not.
> 
> With my comment addressed on patch 2:

Agree, I won't change patch 3 for now, I replied there why.

> Reviewed-by: Nuno Sa <nuno.sa@analog.com>

Thank you! I'll embed this into v2.

-- 
With Best Regards,
Andy Shevchenko


