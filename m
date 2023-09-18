Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9EC7A4498
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbjIRIZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbjIRIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:25:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C641D1A4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695025420; x=1726561420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LSr4AFp7VQS9eCOKjiyauP1ikNwrfoAhtarijUPvqlU=;
  b=lWuFJt/WweiS/irdhX20vgsXxKR8qFvaDG/EjARyNMbv+4tfaiahoPVH
   VA8/CeM29Ot8XaKSBXBUzOIR14W9dmQPzC0Gt2ZQ11655NuqKya18wLBl
   BPPfF0ZKby7IDmOFalkW8VHaoJM9lV2q2JlHJSaUOSU9yHCv5z37bWvx0
   Hu/yO2m6FT03CsPq6RZHqfih9BpktBU9G9mib3Mu0IH8Wq4t+rHDPTCRs
   eQksNPfxXNgXtWiX1Gyyzme/bhdeCk6P/HssWpxWmO4OvoZn/j0xE7Upd
   a8JBbzUgTD4XD4qk9TgKfCB4W15wwcL60yq3iZzW+R3D4tx7yIwbfU16K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="382341051"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="382341051"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="860971603"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="860971603"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 01:23:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qi9Xb-0000000GMuR-2iAg;
        Mon, 18 Sep 2023 11:23:35 +0300
Date:   Mon, 18 Sep 2023 11:23:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Huacai Chen <chenhuacai@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <kernel@xen0n.name>
Subject: Re: [PATCH v1 1/2] LoongArch: Add missing headers
Message-ID: <ZQgJB6KKYka6YGNK@smile.fi.intel.com>
References: <20230914103445.511285-1-andriy.shevchenko@linux.intel.com>
 <CAAhV-H6Q0sirFEDdc1v4BSfDY94eZvJazy0XLKM8V94GMJvQnQ@mail.gmail.com>
 <ZQNWh2DY319jGbfq@smile.fi.intel.com>
 <CAAhV-H66LUWHP-eGp6VGvs0F+QD=QJ69uR3_1A3SqH9cyPUPoQ@mail.gmail.com>
 <ZQWCeI6E7rm8Akbt@smile.fi.intel.com>
 <CAAhV-H6dakVH0a4Mt9MdcY8OO3gdne6rW0Z1kK6YRq9hDLP05w@mail.gmail.com>
 <ZQfzDXc0WRHCUeIq@smile.fi.intel.com>
 <CAAhV-H4HkA=SZAb-4q5QVdyDB1MsEsmjVO_N8h30MkSXzpzimQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H4HkA=SZAb-4q5QVdyDB1MsEsmjVO_N8h30MkSXzpzimQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:05:50PM +0800, Huacai Chen wrote:
> On Mon, Sep 18, 2023 at 2:49 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Sep 16, 2023 at 08:05:52PM +0800, Huacai Chen wrote:
> > > On Sat, Sep 16, 2023 at 6:27 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 15, 2023 at 08:36:24AM +0800, Huacai Chen wrote:
> > > > > On Fri, Sep 15, 2023 at 2:53 AM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Thu, Sep 14, 2023 at 11:25:22PM +0800, Huacai Chen wrote:
> > > >
> > > > > > > Thank you for your patch, can this patch solve the problem below?
> > > > > > > https://lore.kernel.org/oe-kbuild-all/202309072237.9zxMv4MZ-lkp@intel.com/T/#u
> > > > > >
> > > > > > Nope, this just adds missing includes.
> > > > > > No functional change, so warnings will still be there.
> > > > > But I think a patch should solve a problem.
> > > >
> > > > No, that problem is static analyser concern, not the compiler nor linker.
> > > >
> > > > > If we don't get a build
> > > > > error or warning without this patch, does that mean the 'missing'
> > > > > headers are actually included indirectly?
> > > >
> > > > I might be missing something, but I do not see any build error in the above message.
> > > Hmm, then I think I will take the second patch only.
> >
> > Thanks, but can you shed a light why?
> >
> > The rule of thumb is to include the headers we are direct users of, we have not
> > to imply any other inclusions done by others, unless it's kinda same family of
> > headers (like types.h always includes compiler_types.h). Since in your case
> > the const.h is included the other two are missing and it's even worse, as I
> > understand you rely on the specific headers to be included _before_ using this
> > one in the users.
> I agree with you more or less, but I doubt there is another rule: no
> break, no fix. Please see:
> 
> https://lore.kernel.org/loongarch/20221024070105.306280-1-chenhuacai@loongson.cn/T/#t
> 
> Obviously static_key is used in page-flags.h and it really causes
> build errors once before, but at last I removed the inclusion of
> static_key.h to get that series merged.

This is strange requirement to be honest. Doing like this is to move your
responsibility and understanding of the code to be a burden of the person who
volunteers cleaning up the header mess we have in the Linux kernel source tree.

Since I'm the one who tries to fix some mess (in particular kernel.h), I am
pretty much know what I am talking about from the experience.

Cc'ing Guo. Guo, can you shed a light on the rationale of your comment in
the above mentioned thread?

-- 
With Best Regards,
Andy Shevchenko


