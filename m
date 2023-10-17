Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0F37CCC86
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjJQTpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjJQTpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:45:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92030F1;
        Tue, 17 Oct 2023 12:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697571945; x=1729107945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N7ORy6k2dxvfyteuCSTaJBoDsO/YHTfYnab+FNPQi1U=;
  b=Oo7B3BXv5/AvjluDWhFA3r0/eiAGicZNPujItFs6r1HLY8AIVaDbaSQb
   KfUSmVgRjSlTNuKP60RQt8XoNBkf0vj9K3fJlIgKik1g73UJse0rdzMIw
   gsu2OvtrFNPmDJJiZ7rIkLJmwLtO3IlN2+2CWSaDyZirSh3VASaqpSfHj
   FxQ4JH+ubWqLQhuAZaXJpCzZ6nNIV3q0RcMkKK5VfFnZHkXzzi0LqzhaN
   yzNWGvVklquMaKZNxIMT7YL6dLFfHIXfJ1tlOPvCv6OranP0bgwKX4dHE
   yTVZPFD2eOTDJvMVWKem3jhrkn4RqC4xJKXvl7JRPclYkmO/7QJvz4qOf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="450089432"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="450089432"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="872718031"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="872718031"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 12:45:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsq0Z-00000006Pdp-3vyB;
        Tue, 17 Oct 2023 22:45:39 +0300
Date:   Tue, 17 Oct 2023 22:45:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in
 find_pinctrl()"
Message-ID: <ZS7kY/+80Be4geGM@smile.fi.intel.com>
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
 <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:59:05PM +0200, Linus Walleij wrote:
> On Tue, Oct 17, 2023 at 8:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 17, 2023 at 08:18:23PM +0200, Linus Walleij wrote:
> 
> > > In the past some file system developers have told us (Ulf will know)
> > > that we can't rely on the block device enumeration to identify
> > > devices, and requires that we use things such as sysfs or the
> > > UUID volume label in ext4 to identify storage.
> >
> > While I technically might agree with you, this was working for everybody
> > since day 1 of support of Intel Merrifield added (circa v4.8), now _user
> > space_ is broken.
> 
> Actually, I don't agree with that, just relaying it. I would prefer that we
> solve exactly the problem that we are facing here: some random unrelated
> code or similar affecting enumeration order of mmc devices.
> 
> It's not the first time it happens to me, I have several devices that change
> this enumeration order depending on whether an SD card is plugged
> in or not, and in a *BIG* way: the boot partition on the soldered eMMC
> changes enumeration depending on whether an SD card is inserted
> or not, and that has never been fixed (because above).

This is not the problem I have. I haven't added any SD card, hardware
configuration is the same. The solely difference in the whole setup is
this revert applied or not.

> > > That said, device trees are full of stuff like this:
> > >
> > >         aliases {
> > >                 serial0 = &uart_AO;
> > >                 mmc0 = &sd_card_slot;
> > >                 mmc1 = &sdhc;
> > >         };
> >
> > And Rob, AFAIU, is against aliases.
> >
> > > Notice how this enumeration gets defined by the aliases.
> > >
> > > Can you do the same with device properties? (If anyone can
> > > answer that question it's Dmitry!)
> >
> > No, and why should we?
> 
> Because device properties are not device tree, they are just some
> Linux thing so we can do whatever we want. Just checking if
> Dmitry has some idea that would solve this for good, he usually
> replies quickly.

OK.

-- 
With Best Regards,
Andy Shevchenko


