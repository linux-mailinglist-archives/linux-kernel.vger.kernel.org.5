Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD8C782605
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjHUJGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjHUJG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:06:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5AFC1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692608788; x=1724144788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N/gT1jRRqJehuoUm6AcE3sUEu+8uIMdenNWlAYPfT30=;
  b=PUKJPzfjFcrykFKK8Hby4UbeaVAGXC0TWhTjHPLY5heFm1fSt3QJ5NUa
   IRXkYY0BslsY/DFAvp0k3qWb1Ly9i0LlZlQ3z1g6e9MnJ9N+sFvVSTtPu
   hnFq4c2TLy0S3XpcPxBgAJNH+SJRK+lkKUl475EftBw3R+0Dw7ag8F5Uc
   BqelXQ9l9nx/P7ySjLJ+TBVRnIWxqpHtKC5J2T+Cwb0VsTGo0bYkkfuni
   ApfwiOhaiyoky1qd4UvPQzsDQSdqsZgLqPH+Oyc42GgvMiolAjW2jrPb0
   e0hHvOtSY8LJo4je9zq7xqA+RLPdF8MhAc/46EbjFClrJSDALgNG3Xr8Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="377278038"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="377278038"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 02:06:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="805862641"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="805862641"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2023 02:06:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qY0rc-006vuu-1y;
        Mon, 21 Aug 2023 12:06:20 +0300
Date:   Mon, 21 Aug 2023 12:06:20 +0300
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
Message-ID: <ZOMpDEZoF8ZK7vU0@smile.fi.intel.com>
References: <20230818085558.1431-1-shenghao-ding@ti.com>
 <20230818085558.1431-2-shenghao-ding@ti.com>
 <4c1b44b5-995a-fac7-a72b-89b8bf816dd2@linux.intel.com>
 <ZN+j3LmfUW2vB+QS@smile.fi.intel.com>
 <87jztq9iqv.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jztq9iqv.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 11:16:08AM +0200, Takashi Iwai wrote:
> On Fri, 18 Aug 2023 19:01:16 +0200,
> Andy Shevchenko wrote:
> > On Fri, Aug 18, 2023 at 11:00:34AM -0500, Pierre-Louis Bossart wrote:

...

> > > > +static void tas2781_fixup_i2c(struct hda_codec *cdc,
> > > > +	const struct hda_fixup *fix, int action)
> > > > +{
> > > > +	 tas2781_generic_fixup(cdc, action, "i2c", "TIAS2781");
> > > 
> > > TI ACPI ID is TXNW
> > > 
> > > https://uefi.org/ACPI_ID_List?search=TEXAS
> > > 
> > > There's also a PNP ID PXN
> > > 
> > > https://uefi.org/PNP_ID_List?search=TEXAS
> > > 
> > > "TIAS" looks like an invented identifier. It's not uncommon but should
> > > be recorded with a comment if I am not mistaken.
> > > 
> > > > +}
> > 
> > Thank you, but actually it's a strong NAK to this even with the comment.
> > We have to teach people to follow the specification (may be even hard way).
> > 
> > So where did you get the ill-formed ACPI ID?
> > Is Texas Instrument aware of this?
> > Can we have a confirmation letter from TI for this ID, please?
> 
> This is used already for products that have been long in the market,
> so it's way too late to correct it, I'm afraid.
> 
> What we can do is to get the confirmation from TI, complain it, and
> some verbose comment in the code, indeed.

Oh, no! Who made that ID, I really want to point that at their faces.
Look at the Coreboot (successful) case, they created something, but
in time asked and then actually fixed the ill-formed ID (that was for
one of RTC chips).

For this, please make sure that commit message has that summary, explaining that
- states that ID is ill-formed
- states that there are products with it (DSDT excerpt is a must)
- lists (a few?) products where that ID is used
- ideally explains who invented that and Cc them to the patch, so they will
  know they made a big mistake

-- 
With Best Regards,
Andy Shevchenko


