Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA4A782635
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjHUJ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHUJ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:26:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F0BCA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692609991; x=1724145991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oligcDY65hRN+faG6t2KYv3VGifp5EVHySffw6MwQCI=;
  b=RG6+MX1nqq3KI5Cyb+MQoEjQEm5QgCX6eHmxnrhIi8tpxJmHt4MRzr9X
   cIFsZGhFtS/Z5wR0CXx+eAz1xqkgxk3cdNvB9GhAV2oyUDBAistxVNpVj
   vLv9kkwNRrrdfHpAv/krr5pQk7mS2zugaSUX7TtYzeA14CNVnIEn7kpZk
   oMGnUQlnipEuGqSBzjQRi3TUZHE+B8k2cgQ6GXMpMA3dYV34gDZGFjeTU
   ZNtsneiei81HxP1A43zGxMXClKpI/ac3lCiu2S1//bBuO3YxqYiCMsMmK
   b3Lo/8Ral1aRF38A0p6NY0RmnkV//pR0hB/ZQge4zesw4TfhGP4TFmI4k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="372444982"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="372444982"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 02:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="770874433"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="770874433"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 02:26:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY1B1-007cDD-0e;
        Mon, 21 Aug 2023 12:26:23 +0300
Date:   Mon, 21 Aug 2023 12:26:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Shenghao Ding <shenghao-ding@ti.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, kevin-lu@ti.com,
        13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        broonie@kernel.org, gentuser@gmail.com
Subject: Re: [PATCH v3 2/2] ALSA: hda/tas2781: Add tas2781 HDA driver
Message-ID: <ZOMtvgKiCsGY+iOz@smile.fi.intel.com>
References: <20230818085558.1431-1-shenghao-ding@ti.com>
 <20230818085558.1431-2-shenghao-ding@ti.com>
 <4c1b44b5-995a-fac7-a72b-89b8bf816dd2@linux.intel.com>
 <ZN+j3LmfUW2vB+QS@smile.fi.intel.com>
 <87jztq9iqv.wl-tiwai@suse.de>
 <ZOMpDEZoF8ZK7vU0@smile.fi.intel.com>
 <87jzto92p8.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzto92p8.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:14:59AM +0200, Takashi Iwai wrote:
> On Mon, 21 Aug 2023 11:06:20 +0200,
> Andy Shevchenko wrote:
> > On Sun, Aug 20, 2023 at 11:16:08AM +0200, Takashi Iwai wrote:
> > > On Fri, 18 Aug 2023 19:01:16 +0200,
> > > Andy Shevchenko wrote:
> > > > On Fri, Aug 18, 2023 at 11:00:34AM -0500, Pierre-Louis Bossart wrote:

...

> > > > > > +	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
> > > > > 
> > > > > TI ACPI ID is TXNW
> > > > > 
> > > > > https://uefi.org/ACPI_ID_List?search=TEXAS
> > > > > 
> > > > > There's also a PNP ID PXN
> > > > > 
> > > > > https://uefi.org/PNP_ID_List?search=TEXAS
> > > > > 
> > > > > "TIAS" looks like an invented identifier. It's not uncommon but should
> > > > > be recorded with a comment if I am not mistaken.
> > > > > 
> > > > > > +}
> > > > 
> > > > Thank you, but actually it's a strong NAK to this even with the comment.
> > > > We have to teach people to follow the specification (may be even hard way).
> > > > 
> > > > So where did you get the ill-formed ACPI ID?
> > > > Is Texas Instrument aware of this?
> > > > Can we have a confirmation letter from TI for this ID, please?
> > > 
> > > This is used already for products that have been long in the market,
> > > so it's way too late to correct it, I'm afraid.
> > > 
> > > What we can do is to get the confirmation from TI, complain it, and
> > > some verbose comment in the code, indeed.
> > 
> > Oh, no! Who made that ID, I really want to point that at their faces.
> > Look at the Coreboot (successful) case, they created something, but
> > in time asked and then actually fixed the ill-formed ID (that was for
> > one of RTC chips).
> > 
> > For this, please make sure that commit message has that summary, explaining that
> > - states that ID is ill-formed
> > - states that there are products with it (DSDT excerpt is a must)
> > - lists (a few?) products where that ID is used
> > - ideally explains who invented that and Cc them to the patch, so they will
> >   know they made a big mistake
> 
> Sure, we should complain further and ask them that such a problem
> won't happen again.  I'm 100% for it.
> 
> But the fact is that lots of machines have been already shipped with
> this ID since long time ago, and 99.99% of them have been running on
> Windows.  Hence I expect that the chance to get a corrected ID is very
> very low, and waiting for the support on Linux until the correction of
> ID actually happens makes little sense; that's my point.

Yes, I understand that. But we have to inform them to prevent from
repeating this big mistake in the future.

-- 
With Best Regards,
Andy Shevchenko


