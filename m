Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8219B77304D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjHGUX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHGUXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:23:25 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5FF1701;
        Mon,  7 Aug 2023 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=VlCr5EbASDMFzl5uU9YzJm5vJdMQg0svCfm0WkYcHO4=; b=MtmW7HCKlS/Zwuhe6IKf5k4RFs
        3WQVzqfX1WrLrH2UhuRn/WGMwYcGztM08VmsE93KBs9veOySb/+QWhCJbQJIOJ/zWtCfJ6C9/7zd0
        pmBcIrljn4fvccTM+Qx+gNXEXkuGxLlF5TH7VNYaGISbaiZQabuCZrPSZdRO/oZxD7jI=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:39608 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qT6l3-0007xr-CZ; Mon, 07 Aug 2023 16:23:18 -0400
Date:   Mon, 7 Aug 2023 16:23:16 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20230807162316.d1aeb77584f1da5b2dec6c72@hugovil.com>
In-Reply-To: <2023080738-headcount-jigsaw-efb7@gregkh>
References: <20230803140551.970141-1-hugo@hugovil.com>
        <2023080417-surname-sizzling-591e@gregkh>
        <20230804101722.7e437a81b2639ccab408d6ba@hugovil.com>
        <20230807112441.c8aa3891cfd6da6b8c65cafc@hugovil.com>
        <2023080738-headcount-jigsaw-efb7@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] serial: max310x: add comments for membase address
 workaround
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2023 17:27:38 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Aug 07, 2023 at 11:24:41AM -0400, Hugo Villeneuve wrote:
> > On Fri, 4 Aug 2023 10:17:22 -0400
> > Hugo Villeneuve <hugo@hugovil.com> wrote:
> > 
> > > On Fri, 4 Aug 2023 15:07:50 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Thu, Aug 03, 2023 at 10:05:51AM -0400, Hugo Villeneuve wrote:
> > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > 
> > > > > Add comments about workaround used to configure membase address. This
> > > > > follows suggestions made during review of a sc16is7xx driver patch to
> > > > > add the same workaround.
> > > > > 
> > > > > Link: https://lore.kernel.org/lkml/2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com
> > > > > Link: https://lore.kernel.org/lkml/20230801131655.80bd8f97f018dda6155d65f6@hugovil.com/
> > > > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > ---
> > > > >  drivers/tty/serial/max310x.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> > > > > index 416d553b73a7..5903dd033fd0 100644
> > > > > --- a/drivers/tty/serial/max310x.c
> > > > > +++ b/drivers/tty/serial/max310x.c
> > > > > @@ -1369,6 +1369,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
> > > > >  		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> > > > >  		s->p[i].port.iotype	= UPIO_PORT;
> > > > >  		s->p[i].port.iobase	= i;
> > > > > +		/*
> > > > > +		 * Use all ones as membase to make sure uart_configure_port() in
> > > > > +		 * serial_core.c does not abort for SPI/I2C devices where the
> > > > > +		 * membase address is not applicable.
> > > > > +		 */
> > > > >  		s->p[i].port.membase	= (void __iomem *)~0;
> > > > >  		s->p[i].port.uartclk	= uartclk;
> > > > >  		s->p[i].port.rs485_config = max310x_rs485_config;
> > > > > 
> > > > > base-commit: 426263d5fb400ccde5444748693dc75bda18f01e
> > > > > -- 
> > > > > 2.30.2
> > > > > 
> > > > 
> > > > Meta-comment, your email system is not correct and is not able to be
> > > > verified as I get the following when attempting to apply your patch:
> > > > 
> > > > ---
> > > >   ✗ [PATCH] serial: max310x: add comments for membase address workaround
> > > >   ---
> > > >   ✗ BADSIG: DKIM/hugovil.com
> > > > 
> > > > Please fix up for future submissions.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Hi Greg,
> > > I will look into it. Thank you.
> > 
> > Hi Greg,
> > I double-checked my DKIM setup, but everything looks fine. If I send
> > emails to gmail or outlook servers, they both report "DKIM
> > signature=pass", and I also checked with an online DKIM validation
> > service and it is also ok.
> > 
> > What tool are you using to check the DKIM signature?
> 
> The patatt tool as part of `b4`.  I just checked, your direct email to
> me here passes, BUT the message you sent to the mailing list did not.
> Check it out yourself, look at the message on lore.kernel.org for this
> response and see if that passes the DKIM check or not.

Hi Greg,
if I look on lore.kernel.org for this response, here it is:

    https://lore.kernel.org/all/2023080738-headcount-jigsaw-efb7@gregkh/raw

If I save this raw message and run it thru patatt, I get:

$ patatt validate test-lore.kernel.mail
 NOSIG | Re: [PATCH] serial: max310x: add comments for membase address
 workaround
       | no signatures found

But if I use another tool, dkimverify (from dkimpy), then it works ok:

$ dkimverify < test-lore.kernel.mail 
signature ok

and if I check the original patch:

    https://lore.kernel.org/all/20230803140551.970141-1-hugo@hugovil.com/raw

I also get a similar failure like you did:

$ dkimverify < test-lore.kernel-original-patch.mail
signature verification failed

The only difference between the two is that the original patch was sent
using 'git send-email'. But in the end, both messages passed thru the
same server (my mail server) running Exim4 v4.92 on a Debian box.

I found that by modifying my Exim configuration and adding the
following (simpler configuration) seems to solve the problem with 'git
send-email' and DKIM:

---------------
DKIM_SIGN_HEADERS =
content-transfer-encoding:mime-version:message-id:date:subject:to:from:cc:subject:date:message-id:reply-to
---------------

I am not an expert in Exim, and I am not sure this is the most
elegant solution, but hope this can help others...

Thank you,
Hugo.
