Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7967BB34B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjJFIeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjJFIeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:34:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD90283
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696581255; x=1728117255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MN+wQWa3TlnziJQ6s0UuidRFVHz4FxFSwgA8QmYTLAY=;
  b=fHFLPElu7gw4NpHVWSniczQgLhAGLziv0/nTt8m4ZfOcIQ1TQWcYwJG/
   /MRjik94srxxyhY5rtxBKacx74xWo+ete8J9pIbPp1+kyWrmpM6echt4K
   5WrQtrkiEgfp/WCCLJ+q1QGk0Tw1vAp8tg2S09YiARCBCsyLhcn2TaCHM
   DvC/wQzBUKpdaBNGIcOOQn/rslHZmctqmD7sHKfikSIvUB7gEaIljuF4Z
   6uRuZTVoEoogO6iBkqsqwJLaw1+m3r2IuNlFdqgRchSSzWepqn+whUWF+
   im0wIvQrmtbHuEkWICxlfmYA1niJ0DxO7SHsaLZRJh0EUitYzD9n384iP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="469972480"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="469972480"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842752502"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842752502"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:34:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qogHi-00000003ErH-19mM;
        Fri, 06 Oct 2023 11:34:10 +0300
Date:   Fri, 6 Oct 2023 11:34:10 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     "N, Pandith" <pandith.n@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Gross, Mark" <mark.gross@intel.com>
Subject: Re: PPS functionality for Intel Timed I/O
Message-ID: <ZR/GgpHAWYEKvzdN@smile.fi.intel.com>
References: <BYAPR11MB3240A86B426158623DB9983EE1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <fa3f1765-eb59-bf69-7f7b-14621caef6ea@enneenne.com>
 <BYAPR11MB3240801F21598EEFAEA79605E1D39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
 <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f2788a74-19f8-8992-5b92-427c7b2a27ab@enneenne.com>
 <BYAPR11MB3240C6789B4C04F3BDAE34D5E1A39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f8a97493-a5ab-565f-825a-dd0a508f2b66@enneenne.com>
 <BYAPR11MB32405694C3C9A1DE083EA673E1C9A@BYAPR11MB3240.namprd11.prod.outlook.com>
 <8ca736c3-7da9-2599-7e55-15e2fc9fedc2@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca736c3-7da9-2599-7e55-15e2fc9fedc2@enneenne.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 08:23:09AM +0200, Rodolfo Giometti wrote:
> On 06/10/23 07:31, N, Pandith wrote:
> > > From: Rodolfo Giometti <giometti@enneenne.com>
> > > Sent: Wednesday, February 15, 2023 1:16 PM
> > > On 15/02/23 08:09, N, Pandith wrote:
> > > > > From: Rodolfo Giometti <giometti@enneenne.com>
> > > > > Sent: Monday, February 6, 2023 4:17 PM

[snip]

> > > Regarding Documentation/driver-api/pps.rst let me suggest you to prose a
> > > separate patch to rewrite the Generators section in such a way you easily can add
> > > your solution at the end. A possible example is attached but feel free to rewrite it
> > > according to your needs.
> > > 
> > Ok, we are updating documentation as you have suggested as a separate patch.
> > Can we use your "Signed-off-by" tag for attached patch.
> 
> If you just followed my suggestion then it's OK for me.

But can we have your SoB or not? If so, please provide it explicitly as
the (Linux kernel) process requires.

-- 
With Best Regards,
Andy Shevchenko


