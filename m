Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF3978271D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjHUKct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbjHUKcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:32:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5334E7;
        Mon, 21 Aug 2023 03:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692613964; x=1724149964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1fn7q7fMoBV0BbqGytVXn+QfD/C+CWrW/pDiqREweWk=;
  b=T8R0Qh3K0+ss/ltSnEdBInvS1KoKVWIG7NObbq0HymNCALC9uf+/Gxv2
   D91FCjQ3xcxBSvkah4+II+r9+4MpXlnx+ObzAJK14bNQWpXM3W+MwJDjd
   iddBIACMLSOp+/ApeXF+hJtIN/t0KRkzSh0Cc+oFi3bIjq8EsxfZXRKJ5
   AW1oSkp9EKl4o4Jf7H2nQ33YgzgN3yYaVMMu0ksJIdfchgu9rk4QqQUMa
   uknhd3lrKXq3N2nmmTjxzyVK0CPxmq8TR/m+75GRIm2cJqLn5ujidxEog
   WN2IgHR61q6BAGPEY/DbAZgarHexeFHuMitwtlSpiBmS1VbHzhzzKn9WJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="437476081"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="437476081"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:32:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="765319278"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="765319278"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2023 03:32:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY2DB-009sOm-0m;
        Mon, 21 Aug 2023 13:32:41 +0300
Date:   Mon, 21 Aug 2023 13:32:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Benjamin Tissoires <bentiss@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Message-ID: <ZOM9SLLuWJzeHTiO@smile.fi.intel.com>
References: <ZMK60UphgVuj4Z+L@smile.fi.intel.com>
 <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm>
 <ZND/8wd67YbGs8d5@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308141128260.14207@cbobk.fhfr.pm>
 <ZOMcHQc8Em/s6C+y@smile.fi.intel.com>
 <ez2oewpi3yeaiejrvbe433ude75pgm3k3s5sh5gnn7pvnzm7b4@ajuopfgwocft>
 <ZOMvpmoWLCgcAyJR@smile.fi.intel.com>
 <ZOMv4VB0bZpupNlN@smile.fi.intel.com>
 <CAO-hwJ+Pa0yMV5taEc9+RXEWJzkotpyj4gz2qftyLV4G73F-mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-hwJ+Pa0yMV5taEc9+RXEWJzkotpyj4gz2qftyLV4G73F-mg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:19:39PM +0200, Benjamin Tissoires wrote:
> On Mon, Aug 21, 2023 at 11:35 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Aug 21, 2023 at 12:34:30PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 21, 2023 at 10:51:04AM +0200, Benjamin Tissoires wrote:
> > > > On Aug 21 2023, Andy Shevchenko wrote:

...

> > > > Long story short, I'm not able to test it right now (and I got quite
> > > > some backlog as you can imagine). IIRC the code was fine, so I think we
> > > > can just take the series as is, and work on the quirks (if any) later.
> > >
> > > Thank you!
> > >
> > > The thing that might be broken is interrupts handling. If that works,
> > > I'm pretty confident with the rest.
> >
> > I.o.w. first 5 patches to test is already 98% of guarantee that everything
> > is fine.
> 
> Actually I applied you series locally, and applied Danny's patches on
> top, and I could run your series in qemu with the cp2112 as USB
> passthrough.
> 
> Everything is working fine, so I can take this one just now.

Thank you! I assume you have some IRQ (like GPIO button) to test with that.
If no, it's easily to describe (in ACPI, see [1]) and use a wire to emulate
the button presses. In that case the /proc/interrupts should show the
different numbers.

[1]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-tables/samples/edison/buttons.asli

-- 
With Best Regards,
Andy Shevchenko


