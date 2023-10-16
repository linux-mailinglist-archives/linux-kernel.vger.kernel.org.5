Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619277CAFE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 18:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjJPQjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 12:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjJPQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 12:37:57 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C158252;
        Mon, 16 Oct 2023 09:23:15 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 378FBE0002;
        Mon, 16 Oct 2023 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697473394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XVHBW4OllJOkAPcU2owgNX1LO5d3o45pdtyP1brke4=;
        b=hqgbZmKJTURFIiX5ft6fhvifc3JzLapjCqlmxEd8rPDZ+kcyaFLNEi2/2qzlOkr90NvDhm
        lNLJkQHtfn4K17Pir/2CyMQW3WQ/+VcQC6x2SokKSko5WO/XwQZdOuBeEQHGgLKW9SOw5C
        4dXiSjc0JlSHJUDRNg1vwQ6wJFUGgof64slmcaCYnt7j5DSqqFkibPvkD8+wwPRbvMq24T
        Cr2tWqMbu42VlXFo7XGRB9QJ4p4RKqogyzwXraGpp2nEvGV74nVyomo3vJjobXdYS4NgAo
        ucYUU9I+fR7bocPTlzY5q3Um7oFrD9ga9LQXbKBhRFZr01NCqry2O8jXRVK9TQ==
Date:   Mon, 16 Oct 2023 18:23:07 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231016182307.18c5dcf1@kmaincent-XPS-13-7390>
In-Reply-To: <20231016084346.10764b4a@kernel.org>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-9-kory.maincent@bootlin.com>
        <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
        <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
        <20231013090020.34e9f125@kernel.org>
        <6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
        <20231016124134.6b271f07@kmaincent-XPS-13-7390>
        <20231016072204.1cb41eab@kernel.org>
        <20231016170027.42806cb7@kmaincent-XPS-13-7390>
        <20231016084346.10764b4a@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 08:43:46 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 16 Oct 2023 17:00:27 +0200 K=C3=B6ry Maincent wrote:
> > On Mon, 16 Oct 2023 07:22:04 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote: =20
>
> > Ok, but there might be quality difference in case of several timestamp
> > configuration done in the MAC. Like the timestamping precision vs frequ=
ency
> > precision. In that case how ethtool would tell the driver to switch bet=
ween
> > them? =20
>=20
> What's the reason for timestamp precision differences?
> My understanding so far was the the differences come from:
>  1. different stamping device (i.e. separate "piece of silicon",
>     accessed over a different bus, with different PHC etc.)
>  2. different stamping point (MAC vs DMA)
>=20
> I don't think any "integrated" device would support stamps which
> differ under category 1.

It was a case reported by Maxime on v3:
https://lore.kernel.org/netdev/20230324112541.0b3dd38a@pc-7.home/=20


> > My solution could work for this case by simply adding new values to the
> > enum:
> >=20
> > enum {
> > 	NETDEV_TIMESTAMPING =3D (1 << 0),
> > 	PHYLIB_TIMESTAMPING =3D (1 << 1),
> > 	MAC_TS_PRECISION =3D (1 << 2)|(1 << 0),
> > 	MAC_FREQ_PRECISION =3D (2 << 2)|(1 << 0),
> > }
> >=20
> > Automatically Linux will go through the netdev implementation and could=
 pass
> > the enum value to the netdev driver. =20
>=20
> We can add multiple fields to netlink. Why use the magic encoding?

To simplify the Linux code to go under either netdev or phylib implementati=
on
without needing describing all the enum possibility in the condition:
if (ts_layer & PHYLIB_TIMESTAMPING)
...
if (ts_layer & NETDEV_TIMESTAMPING)
...

We also could add "is_phylib" and "is_netdev" functions with a simple switch
case in it, but we have to be careful to always update these functions when=
 new
enum values will appear.

>=20
> > > But there is a big difference between MAC/PHY and DMA which would
> > > both fall under NETDEV?   =20
> >=20
> > Currently there is no DMA timestamping support right? =20
>=20
> Kinda. Some devices pass DMA stamps as "HW stamps", and pretend they
> are "good enough". But yes, there's no distinction at API level.

Ok. I did suppose this when writing my last reply.

> > In that case we will have MAC and DMA under netdev and PHY under phylib=
 and
> > we won't have to do anything more than this timestamping management pat=
ch:=20
> > https://lore.kernel.org/netdev/20231009155138.86458-14-kory.maincent@bo=
otlin.com/
> > =20
>=20
> Maybe we should start with a doc describing what APIs are at play,
> what questions they answer, and what hard use cases we have.
>=20
> I'm not opposed to the ethool API reporting just the differences
> from my point 1. (in the first paragraph). But then we shouldn't
> call that "layer", IMO, but device or source or such.

I am open to change the naming to fit the best for our current and future u=
sage.
If we take into account the Maxime case of several timestamps on a device t=
hen
maybe source could work.

