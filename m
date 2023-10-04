Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B461E7B7B76
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbjJDJNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjJDJNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:13:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4C98;
        Wed,  4 Oct 2023 02:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696410807; x=1727946807;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=engroHUsDMpbS7kZWKn5ek1QdOf+4p0c/Cv494z9tME=;
  b=iwgbZaEcCL4EDdQ+DHlxAexvnMzvwQ1GuqJ8dbSrWXLNCq8xzMwSBtEY
   T9Xh1O2inNYpP3bRWObNYNNdIrzOedu2zoGbxA1eL5WGWnvXYjTOStys+
   iUIl7ToXgsrArZT/gRVP1dZYeX2jMtBNAGDU8knZH+FOWVu51td+/SHRh
   hV6jVTtYkZmKfHUoTe1sX//S2QTuJohC4rG6YYD3NkJhSciewSXa4AoF6
   TICTraRJfh1DpOIkCLSW5PKbQFr54RoFhbBNdsxJZfNAIaVgQEjOUl5gm
   nGBeKhb6e0n307K4d0+blgxoZifMI41LnOwV+S/JdE4Yy1faBjjqmn8wB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="469382303"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="469382303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="894855817"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="894855817"
Received: from cyrillet-mobl.ger.corp.intel.com ([10.252.55.203])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:11:58 -0700
Date:   Wed, 4 Oct 2023 12:13:21 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Check for valid console index
In-Reply-To: <20231004090859.GF34982@atomide.com>
Message-ID: <375d54d0-f874-92d5-91c5-c7ff2b33daff@linux.intel.com>
References: <20231004085511.42645-1-tony@atomide.com> <1fc2dc1d-33f2-6d65-6bdb-d4c7421cbc57@linux.intel.com> <20231004090859.GF34982@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1096096951-1696410806=:1931"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1096096951-1696410806=:1931
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 4 Oct 2023, Tony Lindgren wrote:

> * Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> [231004 09:05]:
> > On Wed, 4 Oct 2023, Tony Lindgren wrote:
> > 
> > > Let's not allow negative numbers for console index.
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> > > --- a/drivers/tty/serial/8250/8250_core.c
> > > +++ b/drivers/tty/serial/8250/8250_core.c
> > > @@ -611,7 +611,7 @@ static int univ8250_console_setup(struct console *co, char *options)
> > >  	 * if so, search for the first available port that does have
> > >  	 * console support.
> > >  	 */
> > > -	if (co->index >= UART_NR)
> > > +	if (co->index < 0 || co->index >= UART_NR)
> > >  		co->index = 0;
> > 
> > The inconsistencies how different serial drivers handle this situation 
> > seem staggering. Perhaps there should be some effort to make the behavior
> > uniform across them?
> 
> Hmm yeah we should just have them all check for co->index < 0.

Right but it's only about that, some return -Exx codes (more than one -Exx 
variant) and some do assign just 0 like here.

-- 
 i.

--8323329-1096096951-1696410806=:1931--
