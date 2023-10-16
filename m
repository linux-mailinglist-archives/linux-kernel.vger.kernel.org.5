Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835337CA786
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJPMCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPMCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:02:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FA38E;
        Mon, 16 Oct 2023 05:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697457765; x=1728993765;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9wBAwblOcESjCmTbr8Caj3TkfpSkEK5pDQLiHfV30+E=;
  b=kFwyKI9Mefy7jyWh+w4/J9nkV7n0ZPeygvOaHsLaaeT/3YK2m27EJQc1
   cUY7u0bYIkJ0qyAiKR6YgqbyQM71nyc2ga+0Zp6Fl06OyKtZwqillWOY3
   3gbQn2T2oMkwxkBW0Odm4ZL++B2K4bIZp1QSCRVMN6SSnw9tuCMU9Wk5O
   ZotLsx2pyGqcCGARgCfDNj5E2fZVI+7BRX497s+BE1cdoT5G2OH9cp2ID
   t9/YNnbiZTrcaiswfZ7qZF117NBMksvYt/NOGX7ODnmCW0Kf6wJ0G/+Rd
   fELeigEGUFp4DjbPB60n+r5bUkE41uZv9pkaVYxy769Q0bNwjMSE9fDSC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="384380103"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="384380103"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705592080"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="705592080"
Received: from rhaeussl-mobl.ger.corp.intel.com (HELO bhoerz-mobl1.ger.corp.intel.com) ([10.252.59.103])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 05:02:26 -0700
Date:   Mon, 16 Oct 2023 15:02:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V3 03/16] platform/x86/intel/vsec: Use cleanup.h
In-Reply-To: <ec4ba6b6d05c2b6ca34009f40e84f65801a8104b.camel@linux.intel.com>
Message-ID: <2bf861c9-456a-cf42-9777-1641f6ab87b5@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>   <20231012023840.3845703-4-david.e.box@linux.intel.com>   <114e1cc4-f129-b6cd-a83b-7d822cde178@linux.intel.com>  <fcd4ae3492b8bf08ec637a3405228efd2913921d.camel@linux.intel.com> 
 <4315a8db-16fe-7421-c482-5aede4d5cdd@linux.intel.com> <ec4ba6b6d05c2b6ca34009f40e84f65801a8104b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1110351866-1697457747=:1986"
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

--8323329-1110351866-1697457747=:1986
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 13 Oct 2023, David E. Box wrote:

> On Fri, 2023-10-13 at 13:54 +0300, Ilpo Järvinen wrote:
> > On Thu, 12 Oct 2023, David E. Box wrote:
> > 
> > > On Thu, 2023-10-12 at 17:46 +0300, Ilpo Järvinen wrote:
> > > > On Wed, 11 Oct 2023, David E. Box wrote:
> > > > 
> > > > > Use cleanup.h helpers to handle cleanup of resources in
> > > > > intel_vsec_add_dev() after failures.
> > > > > 
> > > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > > ---


> > > > > @@ -208,8 +207,12 @@ static int intel_vsec_add_dev(struct pci_dev *pdev,
> > > > > struct intel_vsec_header *he
> > > > >         else
> > > > >                 intel_vsec_dev->ida = &intel_vsec_ida;
> > > > >  
> > > > > -       return intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
> > > > > -                                 intel_vsec_name(header->id));
> > > > > +       ret = intel_vsec_add_aux(pdev, NULL, intel_vsec_dev,
> > > > > +                                intel_vsec_name(header->id));
> > > > > +
> > > > > +       no_free_ptr(intel_vsec_dev);
> > > > > +
> > > > > +       return ret;
> > > > 
> > > > So if intel_vsec_add_aux() returned an error, intel_vsec_dev won't be 
> > > > freed because of the call call to no_free_ptr() before return. I that's 
> > > > not what you intended?
> > > 
> > > It will have been freed if intel_vsec_add_aux() fails. It's a little messy.
> > > That
> > > function creates the auxdev and assigns the release function which will free
> > > intel_vsec_dev when the device is removed. But there are failure points that
> > > will also invoke the release function. Because of this, for all the failure
> > > points in that function we free intel_vsec_dev so that it's state doesn't
> > > need
> > > to be questioned here. This happens explicitly if the failure is before
> > > auxiliary_device_init(), or through the release function invoked by
> > > auxiliary_device_uninit() if after.
> > 
> > Oh, that's really convoluted and no wonder I missed it completely. It 
> > might even be that using cleanup.h here isn't really worth it. I know 
> > I pushed you into that direction but I didn't realize all the complexity
> > at that point.

...
> >  are before the intel_vsec_add_aux() call (and I'd also add a comment 
> > to explain that freeing them is now responsability of 
> > intel_vsec_add_aux()). That way, we don't leave a trap into there where 
> > somebody happily adds another no_free_ptr() to the same group and it 
> > causes a mem leak.
> 
> Sure. After the comment I'd just do this then still the value is still needed,
> 
> 	ret = intel_vsec_add_aux(pdev, NULL, no_free_ptr(intel_vsec_dev),
>                                  intel_vsec_name(header->id));

True, I realized later that the variable gets NULLed because of how 
no_free_ptr() works so no_free_ptr() has to be within the call itself, but 
that's actually much better than my initial suggestion!

So I think the best we can get out of this is along the lines of (with the 
subsequent change with res too):

	/* Pass the ownership of intel_vsec_dev and resource within it to intel_vsec_add_aux() */
	no_free_ptr(res);
	return intel_vsec_add_aux(pdev, info->parent, no_free_ptr(intel_vsec_dev), 
				  intel_vsec_name(header->id));

That seems the least trappiest and actually nicely documents who is 
responsible for what. To contrast the earlier, this feels very elegant,
the perceived complexity related to intel_vsec_add_aux() no longer feels 
tricky at all so we end up solving also that problem better than the 
original.

-- 
 i.

--8323329-1110351866-1697457747=:1986--
