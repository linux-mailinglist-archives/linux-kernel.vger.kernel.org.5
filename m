Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13357791EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjHKOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjHKOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:32:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03E72D43;
        Fri, 11 Aug 2023 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691764347; x=1723300347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LU25QferihdHqfuOYAm93aazkSuV5DcCHme4q/l43SY=;
  b=cmNiEM48PiRJbEF+W1TFyfB7fz8ndKQPa3oabm5KJ+wnYQbKKv69NaMd
   PJbru762nivzsOfp6rrA9ohptk5j7Kt4YVZJZa5r8Y0IKb8ExDFLb8jFT
   Lkeu/LVVDr7FPaZ3opRx4TLSfCKZc4eDftRtKDsIvtTaNm2e7G6S5gu5I
   fqRzmtpuQC30z1S0aoEryUCfaOix2dpq3ziRfyXzQGux5YUDvXD49DxMV
   1PQypMtCsOKMfDMuixFdD6K3Sbpd1/lstTdPZI4NlCuIyjxE7vqAxH0bM
   jmrt0A8SAJB4LfGJSA5ceUBnNWe8EdsLnyVsQ5Hsj94PVFzxG2CaUb+ze
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402658857"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="402658857"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 07:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="822683177"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="822683177"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2023 07:32:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUTBf-001Ms9-2b;
        Fri, 11 Aug 2023 17:32:23 +0300
Date:   Fri, 11 Aug 2023 17:32:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] gpio: consumer: new virtual driver
Message-ID: <ZNZGdyQ6FuBtDT47@smile.fi.intel.com>
References: <20230808145605.16908-1-brgl@bgdev.pl>
 <ZNJ6HCOV0bzlaoXX@smile.fi.intel.com>
 <CAMRc=Mf_BmhZLN1J2m4SnpmPJzZtYPcfdR54EfG9gR5Px_Ss-Q@mail.gmail.com>
 <ZNT546dM+7QX98pA@smile.fi.intel.com>
 <CAMRc=MfzXbuJb1hYe57MeMXkNaXPg8_Ei0Y=JURyCCoXBffhtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfzXbuJb1hYe57MeMXkNaXPg8_Ei0Y=JURyCCoXBffhtg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:39:08PM +0200, Bartosz Golaszewski wrote:
> On Thu, Aug 10, 2023 at 4:53 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > This can be avoided by
> > > >
> > > >         key = kstrndup(skip_spaces(page), count, GFP_KERNEL);
> > > >
> > > > no?
> > > >
> > >
> > > No, because we also want to remove the trailing spaces and newlines.
> > > But if you have a different suggestion with existing helpers, let me
> > > know. I didn't find any.
> >
> > kstrto*() are newline friendly. The rest as you noted can be covered with
> > sysfs_streq() / sysfs_match_string().
> 
> It's a kstrndup() not a kstrtosomething(). It's not newline friendly.

Right, I messed that up when replying.

-- 
With Best Regards,
Andy Shevchenko


