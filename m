Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C683E7CF878
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345531AbjJSMNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345479AbjJSMNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:13:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA02AB;
        Thu, 19 Oct 2023 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697717622; x=1729253622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i4WwgJ3o94Vpc1j4dMgWvIKNhHkKPOtwMgr1IzruUfo=;
  b=miNFtG/8cYi/neVyXhNPGvm5yuHDfIIgmgDT3KmTC5G0ufruanoOop1u
   78EuY2RtZk27BzuTseb8dG/NI6Qixj6Vz83F0nbjRFZziM6JAl6FoqChR
   iAKjt2BIu+D/fmxIV0oWCqznwYdWJRKy4OmZ9xKVqLM1L/au6Ow6pSL7u
   W2Cd1uQfdmxDJhxA6mnLalZudXTIjjvQWzZa55grQHYkGlnmbNBWgNs64
   8lODLhXNYEmF4Py2INWJSJ6LrFEmgQMBgX+q/RT6aRWLvIBvYWG9rHRRb
   YNYAoyb2jx3HnTmtWAaViiG7kGeR5/Q3+HY35LqNBg9VblmVb6zFaAkeP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7788028"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="7788028"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004213877"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="1004213877"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:13:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtRuD-00000006rBf-346f;
        Thu, 19 Oct 2023 15:13:37 +0300
Date:   Thu, 19 Oct 2023 15:13:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in
 find_pinctrl()"
Message-ID: <ZTEdcVQH00911hfc@smile.fi.intel.com>
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
 <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
 <ZS7kY/+80Be4geGM@smile.fi.intel.com>
 <ZS7_5VGvRnw99gzd@google.com>
 <ZS9mo4/jnRNoTE+v@smile.fi.intel.com>
 <ZTBfFIyCsl2gkp6f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTBfFIyCsl2gkp6f@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 03:41:24PM -0700, Dmitry Torokhov wrote:
> On Wed, Oct 18, 2023 at 08:01:23AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 17, 2023 at 02:43:01PM -0700, Dmitry Torokhov wrote:
> > > On Tue, Oct 17, 2023 at 10:45:39PM +0300, Andy Shevchenko wrote:
> > 
> > Thanks for your response.

...

> > > I wonder, could you please post entire dmesg for your system?
> > 
> > Working, non-working or both?
> 
> Non working, especially if you also enable debug logs in
> drivers/mmc/host/sdhci-pci-core.c.
> 
> What I do not quite understand is that I think we should not be hitting
> the case where pinctrl is already created for the device, which is the
> code path my patch was changing. IIUIC we should be mostly executing the
> "pinctrl not found" path and that did not really change. Maybe you could
> also put some more annotations to show how/at what exact point the probe
> order changed? Maybe log find_pinctrl() calls and compare?
> 
> Linus, BTW, I think there are more problems there with pinctrl lookup,
> because, if we assume there are concurrent accesses to pinctrl_get(),
> the fact that we did not find an instance while scanning the list does
> not mean we will not find it when we go to insert a newly created one.
> 
> Another problem, as far as I can see, that there is not really a defined
> owner of pinctrl structure, it is created on demand, and destroyed when
> last user is gone. So if we execute last pintctrl_put() and there is
> another pinctrl_get() running simultaneously, we may get and bump up the
> refcount, and then release (pinctrl_free) will acquire the mutex, and
> zap the structure.

Oh, that's a lot of fixing ahead! But if you send anything to test, I would
happy do it.

> Given that there are more issues in that code, maybe we should revert
> the patch for now so Andy has a chance to convert to UUID/LABEL booting?

I believe it's not feasible, see below why.

...

> > > I think the right answer is "fix the userspace" really in this case. We
> > > could also try extend of_alias_get_id() to see if we could pass some
> > > preferred numbering on x86. But this will again be fragile if the
> > > knowledge resides in the driver and is not tied to a particular board
> > > (as it is in DT case): there could be multiple controllers, things will
> > > be shifting board to board...
> > 
> > Any suggestion how should it be properly done in the minimum shell environment?
> > (Busybox uses mdev with static tables IIRC and there is no fancy udev or so)
> 
> I'm not sure, so you have something like blkid running? You just need to
> locate the device and chroot there. This assumes you do have initramfs.

I don't think this is working solution.

My case is: I have build an environment with a script that has hardcoded
mmcblk0 to mount from. When I run this script I do not know _which_ exact
board I run on, it should work on any of them (same boards, but different
UUIDs).

While writing this I realised that the common denominator I have here is
the physical device (as it's a PCI one), and it's on-SoC, so can't change
its BDF. So, there seem to be a solution. Let me try to implement that.

-- 
With Best Regards,
Andy Shevchenko


