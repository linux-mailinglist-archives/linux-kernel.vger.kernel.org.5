Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DB575979A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjGSN75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjGSN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:59:55 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE198E;
        Wed, 19 Jul 2023 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689775194; x=1721311194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=looCyhUaIxJ67yA9rnHsM2+5OW4oeW1pu/8q4IfbMgk=;
  b=CRFpK4Cvt6kCCh48XQ8nCJbnzascqI8ktQ9K3LfuKYeXUi1cYSpRIlSe
   eBNzx1r9zsSZDdRoA0JIhTUQeWfgqzHESO/gY5wA2EGztScXKObx/OLaP
   XTkPQZXGPm4RvQCRVdOA/5ze10dfq/GUD0vHxjTnUG3Kb8V1FpnPxUnF2
   aMW/5LFGSzOD/XWKkJ1wvkBc7yYYeZxauh+l8Efoyg9yztZ/w8dKcw3Qu
   29uZXXcbe70SDenrIKD/2HwjAFc9cymwEpGfwGGsT//R0qeXWDpDIoL1c
   LDqDFM8bfO1TE6RlPs9eOV2+6Lo5oSHvl3c8+5jqezhmN01IrICiA339a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="452842430"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="452842430"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:59:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="727308049"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="727308049"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jul 2023 06:59:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qM7iX-00DBxH-1P;
        Wed, 19 Jul 2023 16:59:49 +0300
Date:   Wed, 19 Jul 2023 16:59:49 +0300
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
Message-ID: <ZLfsVU7uiA3IReHU@smile.fi.intel.com>
References: <20230719051613.46569-1-tony@atomide.com>
 <ZLd1uCKoGMBruwiN@smile.fi.intel.com>
 <20230719054321.GJ5194@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719054321.GJ5194@atomide.com>
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

On Wed, Jul 19, 2023 at 08:43:21AM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [230719 05:34]:
> > On Wed, Jul 19, 2023 at 08:16:11AM +0300, Tony Lindgren wrote:
> > > Let's allow the userspace to find out the tty name for a serial core
> > > controller id if a tty exists. This can be done with:
> > > 
> > > $ grep DEVNAME /sys/bus/serial-base/devices/port*/tty/uevent
> > > /sys/bus/serial-base/devices/port.00:04.0/tty/uevent:DEVNAME=ttyS0
> > > /sys/bus/serial-base/devices/port.serial8250.1/tty/uevent:DEVNAME=ttyS1
> > > /sys/bus/serial-base/devices/port.serial8250.2/tty/uevent:DEVNAME=ttyS2
> > > /sys/bus/serial-base/devices/port.serial8250.3/tty/uevent:DEVNAME=ttyS3
> > 
> > What part is the controller ID here?
> 
> Oh looks like controller id it's missing in the name, I'll send a fix
> for that.
> 
> > We also have something in procfs (I don't remember what info exactly is there).
> 
> Do you mean /proc/devices?

Something tty specific, /proc/tty/, but I had a look and it seems for another
stuff.

> > > And with this, we can add /dev/serial/by-id symlinks to the serial port
> > > device instances so we can start using serial core port addressing in
> > > addition to the legacy ttyS naming.
> > > 
> > > The naming we can use is dev_name:0.0 where 0.0 are the serial core
> > > controller id and port id, so for the ttyS0 example above the naming
> > > would be 00:04.0:0.0.
> > 
> > This is interesting idea. But any hint why it can be useful?
> 
> If you have lots of serial ports and we are stuck with adding aliases
> for the ports in the dts files where the ttyS naming and ordering does
> not really help or may not necessarily make sense if the ports are on
> different buses or domains. With CONFIG_SERIAL_8250_RUNTIME_UARTS=4,
> the ttyS naming is only needed for the legacy ports really.

I see. Does it fix the long standing issue with ttyS enumeration (on x86
at least) when depending on the presence of the legacy ports the HSUART
(high speed) can preempt the legacy placeholders (ttyS0..ttyS3)?

To me sounds like it may very well do fix it and I would be glad to see that
in the commit message (as selling point) and in documentation.

-- 
With Best Regards,
Andy Shevchenko


