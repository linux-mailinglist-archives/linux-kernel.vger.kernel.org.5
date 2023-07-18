Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078D758090
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbjGRPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjGRPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:15:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C31702;
        Tue, 18 Jul 2023 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689693311; x=1721229311;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iUdiwJf9CrfUfsKDKgfEzvHdxQZKd55P1wdk/zf8PuA=;
  b=Ok3q07F3Jz6w9lgtlKPABOAd5YzqBE3u/kRmTY3wFYS7ZUHD9WRMVC6t
   Ru9GODxp4KTcS5bT8rivXGzNaFvtXE5/uMC5fnWwFmVe/Biw5mHhix6hD
   YpnalfDQ2ZzNWnjW6Y0BcdfREp7mO08WKGI2TMKLlU+qWneJ+GCeIVoIP
   Igs8bqiP3528e70LoSxvTZAeRFEp7eXVav1V4rQmM2vsT859d/9T1zWOc
   d3aFoPSbSjuylknkSKIrm4oq1cvAirUjzJBOF4nr9Qp7nA+YKR772wgrl
   WcdKmy5qCSVJ2UPRq5Zx7Pfv/R2KdR8X34gHW1X0faFD/5r7oH8fzCQML
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346532894"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="346532894"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 08:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="700946947"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="700946947"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2023 08:15:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLmPq-0019YS-1v;
        Tue, 18 Jul 2023 18:15:06 +0300
Date:   Tue, 18 Jul 2023 18:15:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 3/3] platform/x86: Move all simatic ipc drivers to the
 subdirectory siemens
Message-ID: <ZLasehsClBD8pkPC@smile.fi.intel.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
 <20230718105213.1275-4-henning.schild@siemens.com>
 <ZLagYgJT4cz4jZ5r@smile.fi.intel.com>
 <20230718164727.6a89e3da@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718164727.6a89e3da@md1za8fc.ad001.siemens.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 04:47:27PM +0200, Henning Schild wrote:
> Am Tue, 18 Jul 2023 17:23:30 +0300
> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> 
> > On Tue, Jul 18, 2023 at 12:52:13PM +0200, Henning Schild wrote:
> > > Users without a Siemens Simatic IPC will not care about any of these
> > > drivers. Users who do care can enable the submenu and all drivers
> > > behind it will be enabled.  

...

> > >  # Siemens Simatic Industrial PCs
> > > +obj-$(CONFIG_X86_PLATFORM_DRIVERS_SIEMENS)		+=
> > > siemens/  
> > 
> > Do you need conditional here? We have stumbled over similar for
> > entire intel subfolder, it might affect the rest as well when you
> > don't expect it.
> > 
> > obj-y		+= siemens/
> > 
> > ?
> 
> It was requested to be done like that by Hans, he wanted me to do a
> similar thing that

"Similar" is not the "same". :-)

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28
> is doing.
> 
> And that is what i did. If there was a y ... the whole "one switch to
> rule them all" story would not work out anymore.

See these:
https://git.kernel.org/torvalds/c/8bd836feb6ca
https://git.kernel.org/torvalds/c/4f6c131c3c31

-- 
With Best Regards,
Andy Shevchenko


