Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE5175EEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjGXJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjGXJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:09:01 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20EBAE4F;
        Mon, 24 Jul 2023 02:09:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 247228176;
        Mon, 24 Jul 2023 09:08:59 +0000 (UTC)
Date:   Mon, 24 Jul 2023 12:08:57 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 3/3] serial: core: Fix serial core controller port
 name to show controller id
Message-ID: <20230724090857.GX5194@atomide.com>
References: <20230724050709.17544-1-tony@atomide.com>
 <20230724050709.17544-4-tony@atomide.com>
 <ZL48mdJbBXPdcf25@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL48mdJbBXPdcf25@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [230724 08:56]:
> On Mon, Jul 24, 2023 at 08:07:05AM +0300, Tony Lindgren wrote:
> > We are missing the serial core controller id for the serial core port
> > name. Let's fix the issue for sane /sys/bus/serial-core/devices, and to
> > avoid issues addressing serial ports later on.
> 
> ...
> 
> > -	return dev_set_name(dev, "%s.%s.%d", type->name, dev_name(port->dev), id);
> > -}
> > +	if (type == &serial_ctrl_type)
> 
> 	...
> 
> > +}
> 
> While at it, have you tried to use --patience when forming patches? Does it
> make any (better) difference?

I'll check if it makes it more readable. Seems I need to also enable the
--patience option for myself for sending patches to avoid messing up things
like Reviewed-by tags :)

Tony
