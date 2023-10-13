Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268757C83CC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjJMKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjJMKyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:54:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E5FBE;
        Fri, 13 Oct 2023 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697194458; x=1728730458;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5eWUjBqPlnFCsnz+FrbWxqesd3yAFBdea7r8Bx04azc=;
  b=Wt6KgWWxo7R4oyqR99fpka6WwjLn/v+2JEUVSxnYDQCzMeqh/5EFHxMb
   3VXnqwyU29hsct/q0TSdlofPg1iq3Fe0NFeKtTHdEOejc9yocJlfEGCZ2
   pjj1KFqvf0i/U5dPRF2gMSkIO1Asii5YcFpCWRxcJckqJAOZuBVMq9UcV
   fh6qddMVtoqf5lu9FJdJeLBSRuT5ZJf5XR9u2YxOUraYzcEMQ4eyU9ymV
   LhOOs4QRewotnlY9rG0pwr1tZchoZGpe6uAkmFSj7PySTp0gnX19vt3Kd
   GIV1tHwjwhWqPHx9QFPHp2RFxaPjJ2iudZaSYfS0S0ioZKCwLc0rJzFwS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471388848"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="471388848"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="871026449"
X-IronPort-AV: E=Sophos;i="6.03,221,1694761200"; 
   d="scan'208";a="871026449"
Received: from ttmerile-mobl1.ger.corp.intel.com (HELO rploss-MOBL.ger.corp.intel.com) ([10.249.37.202])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 03:54:16 -0700
Date:   Fri, 13 Oct 2023 13:54:14 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
In-Reply-To: <fcd4ae3492b8bf08ec637a3405228efd2913921d.camel@linux.intel.com>
Message-ID: <4315a8db-16fe-7421-c482-5aede4d5cdd@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>  <20231012023840.3845703-4-david.e.box@linux.intel.com>  <114e1cc4-f129-b6cd-a83b-7d822cde178@linux.intel.com> <fcd4ae3492b8bf08ec637a3405228efd2913921d.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-971062823-1697194458=:2026"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-971062823-1697194458=:2026
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 12 Oct 2023, David E. Box wrote:

> On Thu, 2023-10-12 at 17:46 +0300, Ilpo Järvinen wrote:
> > On Wed, 11 Oct 2023, David E. Box wrote:
> > 
> > > Use cleanup.h helpers to handle cleanup of resources in
> > > intel_vsec_add_dev() after failures.
> > > 
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > > V3 - New patch.
> > > 
> > >  drivers/platform/x86/intel/vsec.c | 17 ++++++++++-------
> > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/platform/x86/intel/vsec.c
> > > b/drivers/platform/x86/intel/vsec.c
> > > index 15866b7d3117..f03ab89ab7c0 100644
> > > --- a/drivers/platform/x86/intel/vsec.c
> > > +++ b/drivers/platform/x86/intel/vsec.c
> > > @@ -15,6 +15,7 @@
> > >  
> > >  #include <linux/auxiliary_bus.h>
> > >  #include <linux/bits.h>
> > > +#include <linux/cleanup.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/idr.h>
> > > @@ -155,10 +156,10 @@ EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, INTEL_VSEC);
> > >  static int intel_vsec_add_dev(struct pci_dev *pdev, struct
> > > intel_vsec_header *header,
> > >                               struct intel_vsec_platform_info *info)
> > >  {
> > > -       struct intel_vsec_device *intel_vsec_dev;
> > > +       struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
> > >         struct resource *res, *tmp;
> > >         unsigned long quirks = info->quirks;
> > > -       int i;
> > > +       int ret, i;
> > >  
> > >         if (!intel_vsec_supported(header->id, info->caps))
> > >                 return -EINVAL;
> > > @@ -178,10 +179,8 @@ static int intel_vsec_add_dev(struct pci_dev *pdev,
> > > struct intel_vsec_header *he
> > >                 return -ENOMEM;
> > >  
> > >         res = kcalloc(header->num_entries, sizeof(*res), GFP_KERNEL);
> > > -       if (!res) {
> > > -               kfree(intel_vsec_dev);
> > > +       if (!res)
> > >                 return -ENOMEM;
> > > -       }
> > >  
> > >         if (quirks & VSEC_QUIRK_TABLE_SHIFT)
> > >                 header->offset >>= TABLE_OFFSET_SHIFT;
> > > @@ -208,8 +207,12 @@ static int intel_vsec_add_dev(struct pci_dev *pdev,
> > > struct intel_vsec_header *he
> > >         else
> > >                 intel_vsec_dev->ida = &intel_vsec_ida;
> > >  
> > > -       return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
> > > -                                 intel_vsec_name(header->id));
> > > +       ret = intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
> > > +                                intel_vsec_name(header->id));
> > > +
> > > +       no_free_ptr(intel_vsec_dev);
> > > +
> > > +       return ret;
> > 
> > So if intel_vsec_add_aux() returned an error, intel_vsec_dev won't be 
> > freed because of the call call to no_free_ptr() before return. I that's 
> > not what you intended?
> 
> It will have been freed if intel_vsec_add_aux() fails. It's a little messy. That
> function creates the auxdev and assigns the release function which will free
> intel_vsec_dev when the device is removed. But there are failure points that
> will also invoke the release function. Because of this, for all the failure
> points in that function we free intel_vsec_dev so that it's state doesn't need
> to be questioned here. This happens explicitly if the failure is before
> auxiliary_device_init(), or through the release function invoked by
> auxiliary_device_uninit() if after.

Oh, that's really convoluted and no wonder I missed it completely. It 
might even be that using cleanup.h here isn't really worth it. I know 
I pushed you into that direction but I didn't realize all the complexity
at that point.

If you still want to keep using cleanup.h, it would perhaps be less 
dangerous if you change the code such that no_free_ptr() for
intel_vsec_dev and the resource (in 4/16, that's a similar case, isn't 
it?) are before the intel_vsec_add_aux() call (and I'd also add a comment 
to explain that freeing them is now responsability of 
intel_vsec_add_aux()). That way, we don't leave a trap into there where 
somebody happily adds another no_free_ptr() to the same group and it 
causes a mem leak.


-- 
 i.

--8323329-971062823-1697194458=:2026--
