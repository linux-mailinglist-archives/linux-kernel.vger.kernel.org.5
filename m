Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350FE7DCA73
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbjJaKL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjJaKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:11:58 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF8AE8;
        Tue, 31 Oct 2023 03:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=F6HSRCh1E2WnLizJ2e2K9sm1VmNQJDhsLgyY83003MM=; b=C4RPTTNCMMLU2UBli351NL1+Iw
        T8Xssy99hjexsUtvzJ2bLS7PawptX1Fyn/Yu40yK2y217GkU37t9zVhypMEkQDAKIMWQcOuSeRIh0
        /RugVqvdK+hKZxW9hnnT2/JvQjoJBi82mK91yk9GGDOpLoRh4m5drnFkWc39kDivbE4duTVCyctlT
        +dmWUYe4i/buC1mKDg2S2N7Jur7aoW4gDsnDnKAb1brN0f4SgNjyIMOtSTnOGoweQCkkPFz7H4Q2s
        QHjaH60iK+p+0IBC6ZLzz5X3koH7ZVV6uY8a/MfJ13EMDAMDDIFsz1yRf8KjiG88wguIx0A7sd0PA
        5PTi4nyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56870)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qxliv-0002Z3-0K;
        Tue, 31 Oct 2023 10:11:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qxliv-00051T-2y; Tue, 31 Oct 2023 10:11:49 +0000
Date:   Tue, 31 Oct 2023 10:11:49 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc:     Hugo Villeneuve <hugo@hugovil.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH 6/6] tty: serial: amba-pl011: Parse bits option as 5, 6,
 7 or 8 in _get_options
Message-ID: <ZUDS5UpWlo+DUZc4@shell.armlinux.org.uk>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
 <20231026-mbly-uart-v1-6-9258eea297d3@bootlin.com>
 <20231026105329.0ee9603563202bd2157a7d27@hugovil.com>
 <CWMITJ9VX9IP.1WPQCX981VRDE@tleb-bootlin-xps13-01>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CWMITJ9VX9IP.1WPQCX981VRDE@tleb-bootlin-xps13-01>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 10:35:29AM +0100, Théo Lebrun wrote:
> Hello,
> 
> On Thu Oct 26, 2023 at 4:53 PM CEST, Hugo Villeneuve wrote:
> > On Thu, 26 Oct 2023 12:41:23 +0200
> > Théo Lebrun <theo.lebrun@bootlin.com> wrote:
> >
> > Hi,
> > I would change the commit title to better indicate that you add support
> > for bits 5 and 6, which was missing.
> >
> > Maybe "Add support for 5 and 6 bits in..." ?
> >
> > > pl011_console_get_options() gets called to retrieve currently configured
> > > options from the registers. Previously, LCRH_TX.WLEN was being parsed
> >
> > It took me some time to understand your explanation :) Maybe change
> > to:
> >
> > "Previously, only 7 or 8 bits were supported."
> >
> > > as either 7 or 8 (fallback). Hardware supports values from 5 to 8
> >
> > Add bits:
> >
> > "5 to 8 bits..."
> >
> > And indicate that this patch adds support for 5 and 6 bits.
> 
> I agree the whole commit message is unclear. Let's rewrite it. What do
> you think of the following:
> 
>    tty: serial: amba-pl011: Allow parsing word length of 5/6 bits at console setup
> 
>    If no options are given at console setup, we parse hardware register
>    LCRH_TX.WLEN for bits per word. We compare the value to the 7 bits
>    value (UART01x_LCRH_WLEN_7). If the hardware is configured for 5, 6
>    or 8 bits per word, we fallback to 8 bits.
> 
>    Change that behavior to parse the whole range available: from 5 to 8
>    bits per word.
> 
> Note that we don't add support for 5/6 bits, we only update the parsing
> of the regs (if no options are passed at setup) to reflect the current
> hardware config. The behavior will be different only if the inherited
> value (from reset/bootloader) is 5 or 6: previously we guessed 8 bits
> word length, now we guess the right value.
> 
> What's your opinion on this new commit message?

There is no point in supporting 5 or 6 bits for console usage. Think
about it. What values are going to be sent over the console? It'll be
ASCII, which requires at _least_ 7-bit. 6-bit would turn alpha
characters into control characters, punctuation and numbers. 5-bit
would be all control characters.

So there's no point trying to do anything with 5 or 6 bits per byte,
and I decided we might as well take that as an error (or maybe a
case that the hardware has not been setup) and default to 8 bits per
byte.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
