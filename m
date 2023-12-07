Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADA4808F43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443615AbjLGR6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjLGR6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:58:36 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5911A173A;
        Thu,  7 Dec 2023 09:58:25 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50ED81BF20D;
        Thu,  7 Dec 2023 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701971903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ztrqr2r+NdGGR17MQHZJfBYqrLR90ks+eNJU1UUR484=;
        b=BPvuM+nEK1j7qHnJ+Jq4urfc+MAFM7wsIQRL9vOmCGapoIbcgM3x6O4ttn155bCQoAFsB2
        e2wUr9Alq0uET6He5daVB/IHufexQwpI0MkJopgOc4OvovUHTETfP0kPasGmxDN8+S0dNI
        OKPS+bv5gbtpxkcn8EWHcpbbAfz4IsL2wPSKdJ9g8NNylm8fCJ43e9c0xFWykY52tocyIL
        5+LFGLc1G7vU6By0RqUlVfU74saXZH31nJgxJRllWqQASxk7F8mXHuN83zjvF2Fhng/ogj
        I8mVfFMS5As3J5EOr1217b7pV7WrSm6EVU768zWgEobD7sia8vIj/VCT7ci4kw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 07 Dec 2023 18:58:12 +0100
Message-Id: <CXIAOLFK6TFO.1J0V4C5I03Q5F@bootlin.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "LKML" <linux-kernel@vger.kernel.org>,
        "linux-serial" <linux-serial@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
        "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>
To:     =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 2/9] tty: serial: amba: Use linux/{bits,bitfield}.h
 macros
X-Mailer: aerc 0.15.2
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
 <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com>
 <2023120742-argue-slighting-6120@gregkh>
 <CXHZXP7XVD0T.24N3YDLX7I929@bootlin.com>
 <42e8faf-5293-18e4-3877-25e4d094f1d@linux.intel.com>
In-Reply-To: <42e8faf-5293-18e4-3877-25e4d094f1d@linux.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu Dec 7, 2023 at 10:56 AM CET, Ilpo J=C3=A4rvinen wrote:
> On Thu, 7 Dec 2023, Th=C3=A9o Lebrun wrote:
> > On Thu Dec 7, 2023 at 2:37 AM CET, Greg Kroah-Hartman wrote:
> > > On Thu, Nov 30, 2023 at 03:07:14PM +0100, Th=C3=A9o Lebrun wrote:
> > > > The driver uses bit shifts and hexadecimal expressions to declare
> > > > constants. Replace that with the BIT(), GENMASK() & FIELD_PREP_CONS=
T()
> > > > macros to clarify intent.
> > > >=20
> > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > > > ---
> > > >  include/linux/amba/serial.h | 248 +++++++++++++++++++++++---------=
------------
> > > >  1 file changed, 127 insertions(+), 121 deletions(-)
> > >
> > > As 0-day had a problem with this patch, I've applied only patch 1 of
> > > this series.  Can you fix it up and rebase and resend the rest again
> > > (while adding the collected reviewed-by that some patches in this ser=
ies
> > > had)?
> >=20
> > So the issue is this: the header file gets included in
> > arch/arm/include/debug/pl01x.S that gets included in arch/arm/kernel/de=
bug.S
> > (see #include CONFIG_DEBUG_LL_INCLUDE).
> >=20
> > I don't see any easy way out of this, so I guess it means the patch mus=
t be
> > dropped. If someone confirms that there are indeed no solution to have =
BIT(),
> > GENMASK() & FIELD_PREP_CONST() accessible from assembly, I'll send the =
next
> > version.
>
> Yeah, it seems to require UART01x_FR_TXFF and UART01x_FR_BUSY, plus=20
> UART01x_DR and UART01x_FR that are not touched by your patch.
>
> I suppose the rest might be convertable though..

Thanks Greg and Ilpo! v6 has been sent.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
