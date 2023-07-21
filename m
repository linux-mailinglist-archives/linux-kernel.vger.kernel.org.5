Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECFD75BEA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjGUGTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjGUGSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:18:33 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D02C349C7;
        Thu, 20 Jul 2023 23:15:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4463A80BA;
        Fri, 21 Jul 2023 06:15:25 +0000 (UTC)
Date:   Fri, 21 Jul 2023 09:15:23 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] serial: core: Controller id cannot be negative
Message-ID: <20230721061523.GP5194@atomide.com>
References: <20230720051021.14961-1-tony@atomide.com>
 <20230720051021.14961-2-tony@atomide.com>
 <2023072022-country-replace-68ca@gregkh>
 <20230721054326.GO5194@atomide.com>
 <2023072144-splurge-debate-e681@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023072144-splurge-debate-e681@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230721 06:00]:
> On Fri, Jul 21, 2023 at 08:43:26AM +0300, Tony Lindgren wrote:
> > * Greg Kroah-Hartman <gregkh@linuxfoundation.org> [230720 19:33]:
> > > On Thu, Jul 20, 2023 at 08:10:14AM +0300, Tony Lindgren wrote:
> > > > The controller id cannot be negative.
> > > > 
> > > 
> > > What does this mean for a changelog?
> > 
> > Just let's fix it while at it and adding port_id in the following patch.
> > If you prefer I can squash the change into the fix adding port_id.
> 
> A separate patch like this is fine, just properly document it please :)

OK will do.

Looks like linux-serial not getting added is caused by MAINTAINERS
not listing serial_base_bus.c, serial_ctrl.c and serial_port.c. This
causes get_maintainer.pl to not show linux-serial for a patch touching
serial_base_bus.c.. And this will causes git send-email to not pick up
linux-serial.. I'll send a patch for MAINTAINERS file too.

Regards,

Tony
