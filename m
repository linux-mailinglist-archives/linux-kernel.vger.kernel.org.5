Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A82C758D55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 07:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGSFuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 01:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGSFug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 01:50:36 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CCF11BF2;
        Tue, 18 Jul 2023 22:50:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C01C780AA;
        Wed, 19 Jul 2023 05:50:34 +0000 (UTC)
Date:   Wed, 19 Jul 2023 08:50:33 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-omap@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix serial core port id to not use
 port->line
Message-ID: <20230719055033.GL5194@atomide.com>
References: <20230719051235.46396-1-tony@atomide.com>
 <82c49602-8c6e-51c2-6f73-28fb9b458db8@kernel.org>
 <ZLd154hdaSG2lnue@smile.fi.intel.com>
 <c5e71fa4-ad39-f958-4eca-887f60544f54@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e71fa4-ad39-f958-4eca-887f60544f54@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jiri Slaby <jirislaby@kernel.org> [230719 05:37]:
> On 19. 07. 23, 7:34, Andy Shevchenko wrote:
> > On Wed, Jul 19, 2023 at 07:26:41AM +0200, Jiri Slaby wrote:
> > > On 19. 07. 23, 7:12, Tony Lindgren wrote:
> > 
> > ...
> > 
> > > >    	int			ctrl_id;		/* optional serial core controller id */
> > > > +	int			port_id;		/* optional serial core port id */
> > > 
> > > Can the id be negative? If not, please use uint.
> > 
> > Does this suggestion apply to ctrl_id as well?
> 
> Sure, but he hasn't added it in this series ;). So it should go to someone's
> todo :P.

Yes it can be uint, that's left over from some earlier revision where -ENODEV
was used, will fix that too.

Regards,

Tony
