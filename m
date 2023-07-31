Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA9F769D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjGaRCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjGaRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:01:37 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF6C19A8;
        Mon, 31 Jul 2023 10:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FBR9wwJom4r3orNjJ+5M5NZ9MSmemWUz/1G0E48j3D8=; b=uUfi28sR89tS7ntMPW/X1j5gdV
        KHonWqU8nMPRmN1n96lPiZqsN4LX0Y8wM/O1lxzRoLQ0FSkamVNv8M0TeuDbAdE6d/9FGy8mzHTVl
        3krYsrGgOz+4y3Xs+ga1USPJ7lh/T45/dJhRV8QODlrui5qrT3sHkNzav77277iNbcOw=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:33912 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qQWGS-0006im-Eh; Mon, 31 Jul 2023 13:01:00 -0400
Date:   Mon, 31 Jul 2023 13:00:59 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        andy.shevchenko@gmail.com
Message-Id: <20230731130059.f098bed0f6a9957fe4444758@hugovil.com>
In-Reply-To: <2023073159-follow-resume-cc9b@gregkh>
References: <20230725142343.1724130-1-hugo@hugovil.com>
        <20230725142343.1724130-10-hugo@hugovil.com>
        <2023073159-follow-resume-cc9b@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v9 09/10] serial: sc16is7xx: add post reset delay
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 17:57:50 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Jul 25, 2023 at 10:23:41AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Make sure we wait at least 3us before initiating communication with
> > the device after reset.
> 
> That says what you do, but not _why_ you do it?

You are right, it is not clear. I will add a note that it is
recommended to do so by the manufacturer in the device datasheet.

> Please read the kernel documentation again for how to write a good
> changelog text.  It's usually the hardest part of submitting a patch.

Yes.


> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> > index 49213be60baf..718e982e1efe 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1526,6 +1526,12 @@ static int sc16is7xx_probe(struct device *dev,
> >  	regmap_write(s->regmap, SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> >  			SC16IS7XX_IOCONTROL_SRESET_BIT);
> >  
> > +	/*
> > +	 * After reset, the host must wait at least 3us before initializing a
> > +	 * communication with the device.
> > +	 */
> > +	usleep_range(5, 10);
> 
> 5, 10 is NOT 3us.

In v3, Andy Shevchenko suggested "I would put (5, 10) instead to relax
a bit the scheduler."

Should I add a comment to that effect:

/*
 * After reset, the datasheet indicates that the host must wait at least
 * 3us before initializing a communication with the device.
 * Use (5, 10) range to relax the scheduler.
 */

?

Hugo.

