Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E50F775247
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjHIFhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHIFhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:37:35 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B968419BC;
        Tue,  8 Aug 2023 22:37:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2B00B80AF;
        Wed,  9 Aug 2023 05:37:34 +0000 (UTC)
Date:   Wed, 9 Aug 2023 08:37:32 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] serial: core: Revert port_id use
Message-ID: <20230809053732.GU14799@atomide.com>
References: <20230806062052.47737-1-tony@atomide.com>
 <b8829d4b-d221-49ce-b0cd-e82dc79be719@roeck-us.net>
 <20230809052650.GT14799@atomide.com>
 <87dd3019-4eed-1c37-22ad-53ef8e5fcd9e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87dd3019-4eed-1c37-22ad-53ef8e5fcd9e@roeck-us.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net> [230809 05:36]:
> On 8/8/23 22:26, Tony Lindgren wrote:
> > Hi,
> > 
> > * Guenter Roeck <linux@roeck-us.net> [230806 13:19]:
> > > On Sun, Aug 06, 2023 at 09:20:50AM +0300, Tony Lindgren wrote:
> > > > Guenter reports boot issues with duplicate sysfs entries for multiport
> > > > drivers. Let's go back to using port->line for now to fix the regression.
> > > > 
> > > > With this change, the serial core port device names are not correct for the
> > > > hardware specific 8250 single port drivers, but that's a cosmetic issue for
> > > > now.
> > > > 
> > > > Fixes: d962de6ae51f ("serial: core: Fix serial core port id to not use port->line")
> > > > Reported-by: Guenter Roeck <groeck7@gmail.com>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > 
> > > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > Thanks for testing.
> > 
> > Guenter, care to also test the patch below on top of this fix and
> > see if things still behave for you?
> > 
> 
> Queued. We should have test results sometime tomorrow.

OK great.

Thanks,

Tony
