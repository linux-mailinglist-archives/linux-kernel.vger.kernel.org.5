Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5A877524B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjHIFlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHIFlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:41:51 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC15819BC;
        Tue,  8 Aug 2023 22:41:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3F96D80AF;
        Wed,  9 Aug 2023 05:41:50 +0000 (UTC)
Date:   Wed, 9 Aug 2023 08:41:48 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] serial: core: Revert port_id use
Message-ID: <20230809054148.GV14799@atomide.com>
References: <20230806062052.47737-1-tony@atomide.com>
 <b8829d4b-d221-49ce-b0cd-e82dc79be719@roeck-us.net>
 <20230809052650.GT14799@atomide.com>
 <20230809053314.dwksdbl63dnuiar3@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809053314.dwksdbl63dnuiar3@dhruva>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dhruva Gole <d-gole@ti.com> [230809 05:33]:
> On Aug 09, 2023 at 08:26:50 +0300, Tony Lindgren wrote:
> > --- a/drivers/tty/serial/serial_base.h
> > +++ b/drivers/tty/serial/serial_base.h
> > @@ -16,6 +16,7 @@ struct device;
> >  
> >  struct serial_ctrl_device {
> >  	struct device dev;
> > +	struct ida ida;
> 
> When you send the proper patch, might want to change variable name to
> something other than ida?

OK I'll change it to port_ida.

Tony
