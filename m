Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97D07BB3D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjJFJGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjJFJGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:06:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07CAA6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696583185; x=1728119185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lvoVBUh+SUYUea27xl/90JlmH3CAwSmY0Gelg5Q/Aa0=;
  b=UEgPaXR6KUI/X2CEeDs6VMFOaNMdgghdrGwEED10TigM+nRjLmPD/YF3
   om+JgGl0D/Da6XiWFTaht3j/7S34YV9mAgoiu2T1MXol9fG+FxkYE8DM8
   EH2gpRL11VIKCSpVXFVRReRSOlLlq4D8RPqE1V7yJ6/nl4FGaLxbwli+K
   fCcmDAGZ95hcUzoCGpu/gSfBim92Ar7cL7NXpy/e8f3DkYkqE5aykRO/F
   iiU66Iw8Mb/I2MKBP4arknEEUaVhBAEpr6z3s+xBv3MB4TjZNHavyK+qI
   SNa26AZKHgZiKzCFTR4VCBCIor4CldufYwB7k1LcfKsrCHw0dWgD5YII1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="5269344"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="5269344"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 02:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="701994148"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="701994148"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 02:06:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qogmo-00000003FMf-2aGf;
        Fri, 06 Oct 2023 12:06:18 +0300
Date:   Fri, 6 Oct 2023 12:06:18 +0300
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
Message-ID: <ZR/OCrjX+/A3t2tQ@smile.fi.intel.com>
References: <1e02cc71-baee-1e75-9160-062d563af795@enneenne.com>
 <BYAPR11MB32408E2D9758BD01EC65FB49E1DA9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f2788a74-19f8-8992-5b92-427c7b2a27ab@enneenne.com>
 <BYAPR11MB3240C6789B4C04F3BDAE34D5E1A39@BYAPR11MB3240.namprd11.prod.outlook.com>
 <f8a97493-a5ab-565f-825a-dd0a508f2b66@enneenne.com>
 <BYAPR11MB32405694C3C9A1DE083EA673E1C9A@BYAPR11MB3240.namprd11.prod.outlook.com>
 <8ca736c3-7da9-2599-7e55-15e2fc9fedc2@enneenne.com>
 <ZR/GgpHAWYEKvzdN@smile.fi.intel.com>
 <ZR/Gs3q1JfJ3pCky@smile.fi.intel.com>
 <633ea9ab-7d86-33c7-f20c-6b7be945750a@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <633ea9ab-7d86-33c7-f20c-6b7be945750a@enneenne.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 10:57:37AM +0200, Rodolfo Giometti wrote:
> On 06/10/23 10:34, andriy.shevchenko@linux.intel.com wrote:
> > On Fri, Oct 06, 2023 at 11:34:10AM +0300, andriy.shevchenko@linux.intel.com wrote:
> > > On Fri, Oct 06, 2023 at 08:23:09AM +0200, Rodolfo Giometti wrote:
> > > > On 06/10/23 07:31, N, Pandith wrote:
> > > > > > From: Rodolfo Giometti <giometti@enneenne.com>
> > > > > > Sent: Wednesday, February 15, 2023 1:16 PM
> > > > > > On 15/02/23 08:09, N, Pandith wrote:

[snip]

> > > > > > Regarding Documentation/driver-api/pps.rst let me suggest you to prose a
> > > > > > separate patch to rewrite the Generators section in such a way you easily can add
> > > > > > your solution at the end. A possible example is attached but feel free to rewrite it
> > > > > > according to your needs.
> > > > > > 
> > > > > Ok, we are updating documentation as you have suggested as a separate patch.
> > > > > Can we use your "Signed-off-by" tag for attached patch.
> > > > 
> > > > If you just followed my suggestion then it's OK for me.
> > > 
> > > But can we have your SoB or not? If so, please provide it explicitly as
> > > the (Linux kernel) process requires.
> > 
> > Or even better if you provide the patch itself or apply directly to your tree
> > that we can rebase the our stuff on.
> 
> Just send the patch to the kernel mail list and, if OK, I'm going to sign it
> and forwarding to Greg Kroah-Hartman.

Okay, now it's clear, thank you!

-- 
With Best Regards,
Andy Shevchenko


