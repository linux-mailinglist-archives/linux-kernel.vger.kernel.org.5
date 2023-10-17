Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB597CBEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjJQJVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbjJQJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:21:37 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7A2121;
        Tue, 17 Oct 2023 02:21:31 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12FE6FF806;
        Tue, 17 Oct 2023 09:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697534490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=URU2Msd1JV3mmAQRvAa9Xwc0yE40juXPkEqApuI7tHk=;
        b=lkHmRQyw+miKlH74ilaYWkL2wK/zyDpmOBF4iy0LzuVV5zUFjgG320qaNHrt1yeLpsVK4f
        ovOzjgxduw/pBroEthTnQeJ9g5zblI16zVDtVMwPn3sNl79n1tqJMaPQO8tDpW22mMVZSM
        yl35FJtscrmERdmIJyociDxx+Bp48hi+vPmFGcvHEHYNW3u8Ep/ppFH+Y2AIJCen7wC421
        MHMEmC6oUd0iDDAAXVemAs9vhY2AfH3fJBeT09QuYORl3JnbApX0Hptsk2CSC/LzjYsqK9
        UYwf5E/9EGWmrgRVh9ysl5mwLRWbcHwJe0lbQ39SrOHEenK93sU7qWsiZyrc5A==
Date:   Tue, 17 Oct 2023 11:21:22 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        <UNGLinuxDriver@microchip.com>,
        "Broadcom internal kernel review list" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231017112122.1548bb57@kmaincent-XPS-13-7390>
In-Reply-To: <bae82fe3-56da-49df-94b6-1e2998f86503@intel.com>
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
        <20231016182307.18c5dcf1@kmaincent-XPS-13-7390>
        <20231016100313.36d4eab9@kernel.org>
        <bae82fe3-56da-49df-94b6-1e2998f86503@intel.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 16:03:13 -0700
Jacob Keller <jacob.e.keller@intel.com> wrote:

> On 10/16/2023 10:03 AM, Jakub Kicinski wrote:
> > On Mon, 16 Oct 2023 18:23:07 +0200 K=C3=B6ry Maincent wrote: =20
> >>> What's the reason for timestamp precision differences?
> >>> My understanding so far was the the differences come from:
> >>>  1. different stamping device (i.e. separate "piece of silicon",
> >>>     accessed over a different bus, with different PHC etc.)
> >>>  2. different stamping point (MAC vs DMA)
> >>>
> >>> I don't think any "integrated" device would support stamps which
> >>> differ under category 1.   =20
> >>
> >> It was a case reported by Maxime on v3:
> >> https://lore.kernel.org/netdev/20230324112541.0b3dd38a@pc-7.home/  =20
> >=20
> > IMHO this talks about how clock control/disciplining works which
> > is a somewhat independent topic of timestamping. =20
>=20
> The thread in question mentions that the device has two modes, one which
> has higher precision for the timestamps, and one which has better
> precision on frequency adjustments. I don't know the details for why the
> hardware has this behavior, but being able to switch between the two
> timestamp modes has value as described by the thread.
>=20
> I'm not sure how to represent that in such an API because both modes
> seem to capture the timestamp at the MAC.

After some thought, indeed moving back to MAC/PHY_TIMESTAMPING seems better.
This case of several timestamp modes in MAC is currently only for the speci=
al
stmmac case.
We could support it the same way we could support multiPHY by saving the
source id of the timestamp like this in net_device:
struct {
	enum ts_layer layer,
	int source_id,
} ts

