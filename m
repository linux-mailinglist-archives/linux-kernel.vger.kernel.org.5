Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F9B772913
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjHGPYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGPYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:24:46 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEB883;
        Mon,  7 Aug 2023 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KKQfHfIn4A+51pYAsg98lmEl57EfbQ66seb9xvjWI08=; b=w4LaAmcr4sPrucHtK+GJN1jAnB
        XFgRybepb3zDWobH8xHWzEkB942a11cShIU9K7y08xet8hxCSUcJdqJDjBCvnvgiqM5ku/imTkOMG
        uPH9YSQHnvWct/PqBk0XuKnKwbq4Vfqq/oyXbqMh9E/K6eD5qNYja7xp467UpCDrP0g8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51798 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qT266-0004KT-8S; Mon, 07 Aug 2023 11:24:43 -0400
Date:   Mon, 7 Aug 2023 11:24:41 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20230807112441.c8aa3891cfd6da6b8c65cafc@hugovil.com>
In-Reply-To: <20230804101722.7e437a81b2639ccab408d6ba@hugovil.com>
References: <20230803140551.970141-1-hugo@hugovil.com>
        <2023080417-surname-sizzling-591e@gregkh>
        <20230804101722.7e437a81b2639ccab408d6ba@hugovil.com>
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

On Fri, 4 Aug 2023 10:17:22 -0400
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Fri, 4 Aug 2023 15:07:50 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Aug 03, 2023 at 10:05:51AM -0400, Hugo Villeneuve wrote:
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > Add comments about workaround used to configure membase address. This
> > > follows suggestions made during review of a sc16is7xx driver patch to
> > > add the same workaround.
> > > 
> > > Link: https://lore.kernel.org/lkml/2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com
> > > Link: https://lore.kernel.org/lkml/20230801131655.80bd8f97f018dda6155d65f6@hugovil.com/
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  drivers/tty/serial/max310x.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> > > index 416d553b73a7..5903dd033fd0 100644
> > > --- a/drivers/tty/serial/max310x.c
> > > +++ b/drivers/tty/serial/max310x.c
> > > @@ -1369,6 +1369,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
> > >  		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> > >  		s->p[i].port.iotype	= UPIO_PORT;
> > >  		s->p[i].port.iobase	= i;
> > > +		/*
> > > +		 * Use all ones as membase to make sure uart_configure_port() in
> > > +		 * serial_core.c does not abort for SPI/I2C devices where the
> > > +		 * membase address is not applicable.
> > > +		 */
> > >  		s->p[i].port.membase	= (void __iomem *)~0;
> > >  		s->p[i].port.uartclk	= uartclk;
> > >  		s->p[i].port.rs485_config = max310x_rs485_config;
> > > 
> > > base-commit: 426263d5fb400ccde5444748693dc75bda18f01e
> > > -- 
> > > 2.30.2
> > > 
> > 
> > Meta-comment, your email system is not correct and is not able to be
> > verified as I get the following when attempting to apply your patch:
> > 
> > ---
> >   ✗ [PATCH] serial: max310x: add comments for membase address workaround
> >   ---
> >   ✗ BADSIG: DKIM/hugovil.com
> > 
> > Please fix up for future submissions.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hi Greg,
> I will look into it. Thank you.

Hi Greg,
I double-checked my DKIM setup, but everything looks fine. If I send
emails to gmail or outlook servers, they both report "DKIM
signature=pass", and I also checked with an online DKIM validation
service and it is also ok.

What tool are you using to check the DKIM signature?

Thank you,
Hugo.
