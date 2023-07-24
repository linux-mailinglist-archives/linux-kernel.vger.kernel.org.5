Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6A875F8CA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGXNro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGXNrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:47:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA61FE1;
        Mon, 24 Jul 2023 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690206301; x=1721742301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rY2/R9GFp/Je8rfy5KAQqpLAzPjjeEx7LgTpj02B9e8=;
  b=N0P+3d/x2OkZtzms2qiSIdMF3G0Pl4BoCicrc67gIKwltndVQ0tzh3Jc
   xr9S4QD8cbF5LdWOeF7838D6Cc92OmwTJoPinndY4+EE+ljPxL6d87Yju
   XGrYWnjoxaFOU2xN/ivz5Q1YUiOZOe9p3GjCoZ8DrJmLh5nMYssrp3QCD
   ncZARnSDuY9gM4ItoKdq9QZNyPU4YODec44OngaqWPkyEtiKHGsthFdmr
   Ps3nHDdf3WpojxX/pzHw6/r4B5Zg1PG9nwqzB8LjyEj0DG1pdX4VSOxae
   ebUHoSwVMC7uNSWj/Y93yzD+K4PRKZ/PbtfK2KFlxn248ClsXjaMoQqo3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367467742"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="367467742"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 06:45:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719682886"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="719682886"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2023 06:44:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNvrs-00FRjQ-2O;
        Mon, 24 Jul 2023 16:44:56 +0300
Date:   Mon, 24 Jul 2023 16:44:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <ZL6AWGiabBGyU3Dq@smile.fi.intel.com>
References: <20230713121627.17990c86@canb.auug.org.au>
 <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
 <ZK/w5LFanElxZazG@smile.fi.intel.com>
 <ZLES/6iNcmR7H+f7@smile.fi.intel.com>
 <20230724135858.3c1abb01@canb.auug.org.au>
 <ZL410jAw2ksuBx56@smile.fi.intel.com>
 <cbff36d5-cde7-43bd-b0d5-ede8950fd885@sirena.org.uk>
 <ZL53HkIWuE4byo+R@smile.fi.intel.com>
 <43862e72-eeb2-4670-8cd6-0e334044583d@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43862e72-eeb2-4670-8cd6-0e334044583d@sirena.org.uk>
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

+Cc: Jon

On Mon, Jul 24, 2023 at 02:11:00PM +0100, Mark Brown wrote:
> On Mon, Jul 24, 2023 at 04:05:34PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 24, 2023 at 01:36:53PM +0100, Mark Brown wrote:
> 
> > > Jon's usually fairly responsive, perhaps there's something worrying
> > > there,
> 
> > Hmm... maybe my understanding of the :export: is wrong? Or what do you suggest?
> 
> I have no idea what any of that is doing.  I'm hoping Jon does.

Okay, so far we are waiting for his reply...

> > > though I do note you only sent it a bit more than a week ago.
> 
> > I fully aware of that and you can see that this reply has been induced by
> > the ping from Stephen.
> 
> Sure, but that means that it's possible he's just not got round to it
> yet rather than that there's a problem.

-- 
With Best Regards,
Andy Shevchenko


