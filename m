Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6275C404
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGUKGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjGUKGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:06:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149DAB7;
        Fri, 21 Jul 2023 03:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689933963; x=1721469963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xwcGg3ySjrKkjK/u5gq0+w18B/u62vuaII+nleYZ4b0=;
  b=WdNWkxprAR9xjQof60ZCiP+YMEegrL7XQe8jmSLNvRgSitDO7a8N4wqC
   BLUngPJ4NOkPeaWc+uaIStX+wXoWR+qpgvDw3tcoSjdVF46jtPywlq6lI
   Ea9u5ERdj/ysjUk/aQwnWUm9n7wI+uUaGFS65DO+NwfeGJpWmCefQhJRN
   oBiXnxWkpFkXmvMMSRONSSMOeZnYlcyIr6n++4cAcbWHV8plgyFSoB5yH
   PqZ5upaw7gc5iLWQ+BiQjJ3usgMI9Im+ZNrwZW7TLZN/uLgMRTFxd+cvs
   W8VMPue5bk730uxlYOtdjm0F9Au0KEzTTZAaOvfaMl4uF61GYGZ1Dj0ni
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367025011"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367025011"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:06:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718767951"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="718767951"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2023 03:05:55 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qMn1B-00GqHL-1x;
        Fri, 21 Jul 2023 13:05:49 +0300
Date:   Fri, 21 Jul 2023 13:05:49 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Add sysfs links for serial core port
 instances for ttys
Message-ID: <ZLpYfZDplupNQHnb@smile.fi.intel.com>
References: <20230719051613.46569-1-tony@atomide.com>
 <ZLd1uCKoGMBruwiN@smile.fi.intel.com>
 <20230719054321.GJ5194@atomide.com>
 <ZLfsVU7uiA3IReHU@smile.fi.intel.com>
 <20230720041319.GM5194@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720041319.GM5194@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:13:19AM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [230719 13:59]:
> > On Wed, Jul 19, 2023 at 08:43:21AM +0300, Tony Lindgren wrote:
> > > * Andy Shevchenko <andriy.shevchenko@intel.com> [230719 05:34]:
> > > > On Wed, Jul 19, 2023 at 08:16:11AM +0300, Tony Lindgren wrote:

...

> > > > > And with this, we can add /dev/serial/by-id symlinks to the serial port
> > > > > device instances so we can start using serial core port addressing in
> > > > > addition to the legacy ttyS naming.
> > > > > 
> > > > > The naming we can use is dev_name:0.0 where 0.0 are the serial core
> > > > > controller id and port id, so for the ttyS0 example above the naming
> > > > > would be 00:04.0:0.0.
> > > > 
> > > > This is interesting idea. But any hint why it can be useful?
> > > 
> > > If you have lots of serial ports and we are stuck with adding aliases
> > > for the ports in the dts files where the ttyS naming and ordering does
> > > not really help or may not necessarily make sense if the ports are on
> > > different buses or domains. With CONFIG_SERIAL_8250_RUNTIME_UARTS=4,
> > > the ttyS naming is only needed for the legacy ports really.
> > 
> > I see. Does it fix the long standing issue with ttyS enumeration (on x86
> > at least) when depending on the presence of the legacy ports the HSUART
> > (high speed) can preempt the legacy placeholders (ttyS0..ttyS3)?
> >
> > To me sounds like it may very well do fix it and I would be glad to see that
> > in the commit message (as selling point) and in documentation.
> 
> It won't affect how ttyS0..ttyS3 get assigned, but it helps finding your
> HSUART instance with DEVNAME:0.0 style addressing. So you don't need to
> care what ttyS number the port has. If you have such a test case maybe give
> it a try.

Exactly, the problem (currently) is, that depending on the BIOS settings
the kernel can't use the same command line and this is quite a PITA for
our customers!

As far as we can specify hardware (path) to the console, it will be so
cool and hopefully solves this very long standing issue.

-- 
With Best Regards,
Andy Shevchenko


