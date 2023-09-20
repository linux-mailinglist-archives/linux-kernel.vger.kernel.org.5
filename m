Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E1E7A78ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjITKRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjITKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:17:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE17AC;
        Wed, 20 Sep 2023 03:17:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D1DAB1FEFB;
        Wed, 20 Sep 2023 10:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695205045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l5B9hsdGEfpu9et9HD7ee07vfPP6fjNNgHA7kbGtnVk=;
        b=q2jYWo+pznGXJhooC+vqWhYp96bNPF1k1XicAUeR0ltEjeblU3wdnICbMhvj+oYGe2TTm2
        RYKLeegWZvqst67JvWRrzb2T2WudEePlvDVnYO1RKiLR/LrIgZbBCRgxC1xne7MqZ9HGco
        Sd/X/bR2mQWbTrNUKG8FIVDT+MKeZB0=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D66CC2C142;
        Wed, 20 Sep 2023 10:17:24 +0000 (UTC)
Date:   Wed, 20 Sep 2023 12:17:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 1/3] printk: Constify name for add_preferred_console()
Message-ID: <ZQrGtIfqGWk-iO87@alley>
References: <20230912110350.14482-1-tony@atomide.com>
 <20230912110350.14482-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912110350.14482-2-tony@atomide.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-09-12 14:03:43, Tony Lindgren wrote:
> While adding a preferred console handling for serial_core for serial port
> hardware based device addressing, Jiri suggested we constify name for
> add_preferred_console(). The gets copied anyways. This allows serial core
> to add a preferred console using serial drv->dev_name without copying it.
> 
> Note that constifying options causes changes all over the place because of
> struct console for match().
> 
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Makes sense:

Reviewed-by: Petr Mladek <pmladek@suse.com>

I assume that this patch would via Greg's tree together with
the rest of the patchset. Please, tell me if you would prefer to
queue this via printk tree.

Best Regards,
Petr
