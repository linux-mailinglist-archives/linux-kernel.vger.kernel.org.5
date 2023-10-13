Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28AD7C847B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjJMLg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjJMLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:36:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3136FB7;
        Fri, 13 Oct 2023 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697196984; x=1728732984;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Vxe8rTuXOh+Ra8l89LvKXu5K+G+sM1HLDgzbp0QfsI0=;
  b=Z+t2bYUknDe3kxiQBvBDqzsklR/8xzZ8wNwIkEluUA124+cI4fdPPtma
   2yB3ks2a3IqXNEMOPfMf2lDxL5k29ysqZvw5ISibhgsJ2P2wwCa5Am2vv
   xesA7RKW9pXoOipsLpjHamUJPF6Y6Kopt1WaKh3wonMsS3lUb2c7pEyrT
   zs0bmknMkjBsp1WhQpTUfjMLeR6bNS3ZbqYroLI33nSKEJWZxqpyDYc/a
   ItfKumqi27kp1QmkwSuBjEXu04cv8N+74eH5AwdpYpiXrz8NGw4yT+Mvd
   ukoW8vMgIUgQhh8QkPiz/8MeXR1/nm/zfOws+Fgj1cd6uPmTsKXwu27g1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416216396"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="416216396"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:36:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="820590424"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="820590424"
Received: from ttmerile-mobl1.ger.corp.intel.com (HELO rploss-MOBL.ger.corp.intel.com) ([10.249.37.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:36:21 -0700
Date:   Fri, 13 Oct 2023 14:36:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V3 09/16] platform/x86/intel/pmc: Allow pmc_core_ssram_init
 to fail
In-Reply-To: <7f2fd7a054912960c6599e4a62e2095d1567aab8.camel@linux.intel.com>
Message-ID: <92594f48-fa9-59d4-e2b7-f5f83ded0ea@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>  <20231012023840.3845703-10-david.e.box@linux.intel.com>  <ac7be397-bc9-a135-9498-72dfa1fe456d@linux.intel.com> <7f2fd7a054912960c6599e4a62e2095d1567aab8.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-729097219-1697196785=:2026"
Content-ID: <940e91-6884-23c1-d36b-d17dc5a55f7c@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-729097219-1697196785=:2026
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <9a57b987-57a3-2aa9-d42d-c48449944d9@linux.intel.com>

On Thu, 12 Oct 2023, David E. Box wrote:

> On Thu, 2023-10-12 at 18:01 +0300, Ilpo Järvinen wrote:
> > On Wed, 11 Oct 2023, David E. Box wrote:
> > 
> > > Currently, if the PMC SSRAM initialization fails, no error is returned and
> > > the only indication is that a PMC device has not been created.  Instead,
> > > allow an error to be returned and handled directly by the caller.
> > 
> > You might have a good reason for it but why isn't the call into 
> > pmc_core_pmc_add() changed in this patch to take the error value into 
> > account?
> 
> Good catch. The return value of pmc_core_pmc_add() is first used in the next
> patch but should be used here.
> 
> > 
> > (I vaguely remember this was probably discussed in the context of some 
> > earlier patch touching this area that it was about the other code dealing 
> > with NULLs or something like that).

Okay but please also take into consideration what I tried to imply above:

Since you are doing what looks a major logic change in the next patch, it 
might be okay to _not use_ that return value until then if you e.g., need 
to add lots of rollback that isn't there already to the code that is going 
away anyway in the next patch. (After all, returning an error code from a 
function that was void previously isn't going to magically break the old
calling code).


-- 
 i.
--8323329-729097219-1697196785=:2026--
