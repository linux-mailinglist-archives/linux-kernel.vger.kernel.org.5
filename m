Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626D77786DF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjHKFLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHKFLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:11:30 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 188F62D4F;
        Thu, 10 Aug 2023 22:11:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 11A6780A9;
        Fri, 11 Aug 2023 05:11:23 +0000 (UTC)
Date:   Fri, 11 Aug 2023 08:11:21 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: core: Fix serial core port id, including
 multiport devices
Message-ID: <20230811051121.GL11676@atomide.com>
References: <20230810065737.47294-1-tony@atomide.com>
 <ZNUBHaDTsAXVNNLZ@smile.fi.intel.com>
 <ZNUBvZQcbBbCziXU@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUBvZQcbBbCziXU@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230810 15:26]:
> On Thu, Aug 10, 2023 at 06:24:13PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 10, 2023 at 09:57:34AM +0300, Tony Lindgren wrote:
> 
> ...
> 
> > > +	unsigned int min = 0, max = ~0U;
> > 
> > Shouldn't this be int? The max IIRC will be INT_MAX with this anyway.
> 
> Ah, and then you can supply is as 0 (IIRC).

The returned id will be INT_MAX, but idr.h uses unsigned int:

int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);

If there's some reason to limit max id we can do it, otherwise it's just
a don't care flag.

Please clarify if I'm not following what you are suggesting :)

Regards,

Tony
