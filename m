Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294B67D00AE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 19:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbjJSRfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346331AbjJSRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 13:35:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C9F137;
        Thu, 19 Oct 2023 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736900; x=1729272900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oP1mt93DT3hlKeGPPwOROBVmLyrVMSuv6RGvzsjvmm8=;
  b=PBiCIaOF48a4pooNWdBvV5L3TSXkRMYd6MpcaFlEIWGGBnwirtOJsArm
   f/IIJGNn8acunyGJe+K9iiS9+j/92EBEfz1Amd5mDVVhJc7pbCDMjBZMa
   cniZ2ppRyD465g1KpMknAMBzlQr5stD7R8G5cxG/6L4K3f70l0uRg838Z
   DP1aeypv2crGzksU/eEbGq3+DI+d4SxyBJCSqbGiQSAikhiiUMlY8N5Xi
   Zr8QClQW55bt3ny8P5shdxGrCkpveugGgLMbNkzQZobeUaVgxr4+6Wsd8
   eUfTd/rrj3RFdJGmXsoWV+adhip6mINDQ5dFc/ygUTFATXXJWxy+rlFh1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389184205"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389184205"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:35:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760723540"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760723540"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:34:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtWg5-00000006wKs-45AS;
        Thu, 19 Oct 2023 20:19:21 +0300
Date:   Thu, 19 Oct 2023 20:19:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in
 find_pinctrl()"
Message-ID: <ZTFlGUJYoMFf02iB@smile.fi.intel.com>
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
 <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
 <ZS7kY/+80Be4geGM@smile.fi.intel.com>
 <ZS7_5VGvRnw99gzd@google.com>
 <ZS9mo4/jnRNoTE+v@smile.fi.intel.com>
 <ZTBfFIyCsl2gkp6f@google.com>
 <ZTFeyt1PwxgC6ID1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTFeyt1PwxgC6ID1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 07:52:26PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 18, 2023 at 03:41:24PM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 18, 2023 at 08:01:23AM +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 17, 2023 at 02:43:01PM -0700, Dmitry Torokhov wrote:
> > > > On Tue, Oct 17, 2023 at 10:45:39PM +0300, Andy Shevchenko wrote:
> > > 
> > > Thanks for your response.

...

> > > > I wonder, could you please post entire dmesg for your system?
> > > 
> > > Working, non-working or both?
> > 
> > Non working, especially if you also enable debug logs in
> > drivers/mmc/host/sdhci-pci-core.c.
> 
> Here we are
> https://paste.debian.net/hidden/5d778105/

For the sake of completeness

https://paste.debian.net/hidden/149933ac/

the working case on the same codebase (the hash is different due to patch that
changes couple of BUG*() to WARN*(), other than that the code is identical).

> > What I do not quite understand is that I think we should not be hitting
> > the case where pinctrl is already created for the device, which is the
> > code path my patch was changing. IIUIC we should be mostly executing the
> > "pinctrl not found" path and that did not really change. Maybe you could
> > also put some more annotations to show how/at what exact point the probe
> > order changed? Maybe log find_pinctrl() calls and compare?
> 
> I see this order in dmesg
> [   48.429681] sdhci-pci 0000:00:01.2: Mapped GSI37 to IRQ79
> [   48.436219] sdhci-pci 0000:00:01.0: Mapped GSI0 to IRQ80
> [   48.450347] sdhci-pci 0000:00:01.3: Mapped GSI38 to IRQ81
> 
> which suggests that PCI enabling devices are happening in parallel
> (pcim_enable_device() in SDHCI PCI driver) and whoever wins first gets
> the ID via IDA (see mmc_alloc_host() implementation). But PCI itself
> guarantees that function 0 has to be always present, so the PCI itself
> enumerates it _always_ in the same order (and we are talking about exactly
> BDF == x:y.0 in this case).
> 
> > Linus, BTW, I think there are more problems there with pinctrl lookup,
> > because, if we assume there are concurrent accesses to pinctrl_get(),
> > the fact that we did not find an instance while scanning the list does
> > not mean we will not find it when we go to insert a newly created one.
> > 
> > Another problem, as far as I can see, that there is not really a defined
> > owner of pinctrl structure, it is created on demand, and destroyed when
> > last user is gone. So if we execute last pintctrl_put() and there is
> > another pinctrl_get() running simultaneously, we may get and bump up the
> > refcount, and then release (pinctrl_free) will acquire the mutex, and
> > zap the structure.
> > 
> > Given that there are more issues in that code, maybe we should revert
> > the patch for now so Andy has a chance to convert to UUID/LABEL booting?
> 
> I'm testing a PoC of the script, so looks promising, but needs more time to
> check other possibilities (see below) and deploy.

...

> > > > I think the right answer is "fix the userspace" really in this case. We
> > > > could also try extend of_alias_get_id() to see if we could pass some
> > > > preferred numbering on x86. But this will again be fragile if the
> > > > knowledge resides in the driver and is not tied to a particular board
> > > > (as it is in DT case): there could be multiple controllers, things will
> > > > be shifting board to board...
> > > 
> > > Any suggestion how should it be properly done in the minimum shell environment?
> > > (Busybox uses mdev with static tables IIRC and there is no fancy udev or so)
> > 
> > I'm not sure, so you have something like blkid running? You just need to
> > locate the device and chroot there. This assumes you do have initramfs.
> 
> blkid shows UUID for the partition of interest and it doesn't have any label,
> OTOH I could parse it for the specific template, while it's less reliable than
> going via sysfs from PCI device name, that's defined by hardware and may not be
> changed.

-- 
With Best Regards,
Andy Shevchenko


