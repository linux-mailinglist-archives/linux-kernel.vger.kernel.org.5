Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C972D7A880C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbjITPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbjITPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:20:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D98794;
        Wed, 20 Sep 2023 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695223206; x=1726759206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EmXFqkTuFNEaiLGXrgBSisJ8kBCI85FLrWVY62a5974=;
  b=jsPwY2utVaqSd28m/9h1V49RMrnNErp3kCrqKEfrkfnkxboDwmle/aLT
   ufK5nVLMo8YfqitNwmbdduiJ4WLV1l3GgdlXewOPvmnRufGeBrkPLhYjm
   gr5ZYZbmyUJkL61XBO5XhHJZv/jHAPhUDm4oHUxviuGJ3EUqSReqx/hpw
   ZftJtkL6Avwd5nzZjZMuK6XFmzWchlQ14yj+cgWAwsDu2g+1gAh6Bxg/f
   o6ALBzrf8yDiQz/l+RWGJqFZYe/T/U/qCGwc3BkSwNjtGm/0s7Mtp+Rh9
   lmVZRdzkKtKhQ67wqWNi+fgjSax5I7MHZIWoDqUiOGVyOnfTP4BjFigG8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444349108"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="444349108"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 08:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="862024014"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="862024014"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 08:19:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiyzY-0000000Gc8Z-1pGW;
        Wed, 20 Sep 2023 18:19:52 +0300
Date:   Wed, 20 Sep 2023 18:19:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>, tiwai@suse.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] ALSA: hda: cirrus_scodec: Add KUnit test
Message-ID: <ZQsNl146RFAYdjSL@smile.fi.intel.com>
References: <20230918095129.440-1-rf@opensource.cirrus.com>
 <20230918095129.440-3-rf@opensource.cirrus.com>
 <ZQoILN6QCjzosCOs@google.com>
 <874jjpwd4i.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jjpwd4i.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 08:51:57AM +0200, Takashi Iwai wrote:
> On Tue, 19 Sep 2023 22:44:28 +0200,
> Nick Desaulniers wrote:
> > 
> > On Mon, Sep 18, 2023 at 10:51:29AM +0100, Richard Fitzgerald wrote:
> (snip)
> > > +static void cirrus_scodec_test_set_gpio_ref_arg(struct software_node_ref_args *arg,
> > > +						int gpio_num)
> > > +{
> > > +	struct software_node_ref_args template =
> > > +		SOFTWARE_NODE_REFERENCE(&cirrus_scodec_test_gpio_swnode, gpio_num, 0);
> > 
> > I'm observing the following error when building with:
> > 
> > $ make LLVM=1 -j128 allmodconfig sound/pci/hda/cirrus_scodec_test.o
> > 
> > sound/pci/hda/cirrus_scodec_test.c:151:60: error: initializer element is not a compile-time constant
> >   151 |                 SOFTWARE_NODE_REFERENCE(&cirrus_scodec_test_gpio_swnode, gpio_num, 0);
> >       |                                                                          ^~~~~~~~
> > /builds/linux/include/linux/property.h:291:37: note: expanded from macro 'SOFTWARE_NODE_REFERENCE'
> >   291 |         .nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1, \
> >       |                                            ^~~~~~~~~~~
> > /builds/linux/include/linux/kernel.h:57:75: note: expanded from macro 'ARRAY_SIZE'
> >    57 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
> >       |                                                                           ^~~
> > /builds/linux/include/linux/compiler.h:228:59: note: expanded from macro '__must_be_array'
> >   228 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
> >       |                                                                ^
> > /builds/linux/include/linux/compiler_types.h:366:63: note: expanded from macro '__same_type'
> >   366 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
> >       |                                                               ^
> > /builds/linux/include/linux/build_bug.h:16:62: note: expanded from macro 'BUILD_BUG_ON_ZERO'
> >    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> >       |                                                              ^
> 
> Hm, this looks like some inconsistent handling of the temporary array
> passed to ARRAY_SIZE() in the SOFTWARE_NODE_REFERENCE macro.  LLVM
> can't treat it if it contains a variable in the given array, while GCC
> doesn't care.
> 
> A hackish workaround would be the patch like below, but it's really
> ugly.  Ideally speaking, it should be fixed in linux/properties.h, but
> I have no idea how to fix there for LLVM.
> 
> Adding more relevant people to Cc.

Thank you, I think it's quite easy to fix. Lemme cook the patch...

-- 
With Best Regards,
Andy Shevchenko


