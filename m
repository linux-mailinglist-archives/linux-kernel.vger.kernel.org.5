Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ADA7E7F52
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjKJRwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjKJRwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:36 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B88A244A4;
        Fri, 10 Nov 2023 01:33:31 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF6CCC0010;
        Fri, 10 Nov 2023 09:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699608810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nC0pAlOXIGUdD+VbkSZGUyt+AICBgKUhgiU0tdd5070=;
        b=psGwELNbfHZ+a8j1bBxaVMw71b/wkWrnwxPY/Do7fG5XWdEyK0WagG8cyoVvrbsDHAI9xr
        0sCuonz2sXS20x2HDGI1tSEwSY7oFYfB5yIcPkhhBvLaaqUYX2iTLjwv4sAnrYlabel93t
        /88QQyQqhw4MaF1wePocA4xTb8cDK+VH9ur5H/rjsh5gLWFBP4J0QfBkLfutGCICt/LvAt
        X/vls4T4QRB9tOkeK5sxtn/LFIePkbwDye6Kbo0hUtNdVKR6Uw/ixu0xFNacAHB8vdoA8v
        J6+4gg4v2GmXtPgwJxRcFa2xvBnVHLXGx1aYfVdb8hXu3O7uV1noXURToMpdRQ==
Date:   Fri, 10 Nov 2023 10:33:28 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <20231110103328.0bc3d28f@fedora>
In-Reply-To: <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
        <20231108113445.24825-2-quic_luoj@quicinc.com>
        <20231108131250.66d1c236@fedora>
        <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
        <20231109101618.009efb45@fedora>
        <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
        <46d61a29-96bf-868b-22b9-a31e48576803@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2023 17:17:58 +0800
Jie Luo <quic_luoj@quicinc.com> wrote:

> On 11/10/2023 4:53 PM, Jie Luo wrote:
> >=20
> >=20
> > On 11/9/2023 5:16 PM, Maxime Chevallier wrote: =20
> >> Hello,
> >>
> >> On Thu, 9 Nov 2023 16:32:36 +0800
> >> Jie Luo <quic_luoj@quicinc.com> wrote:
> >>
> >> [...]
> >> =20
> >>>> What I understand from this is that this PHY can be used either as a
> >>>> switch, in which case port 4 would be connected to the host interface
> >>>> at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
> >>>> speed would be limited to 1G per-port, is that correct ? =20
> >>>
> >>> When the PHY works on the interface mode QUSGMII for quad-phy, all 4
> >>> PHYs can support to the max link speed 2.5G, actually the PHY can
> >>> support to max link speed 2.5G for all supported interface modes
> >>> including qusgmii and sgmii. =20
> >>
> >> I'm a bit confused then, as the USGMII spec says that Quad USGMII real=
ly
> >> is for quad 10/100/1000 speeds, using 10b/8b encoding.
> >>
> >> Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
> >> =C2=A0 with 66b/64b encoding ?
> >>
> >> Thanks,
> >>
> >> Maxime =20
> >=20
> > Hi Maxime,
> > Yes, for quad PHY mode, it is using 66b/64 encoding.
> >=20
> > it seems that PHY_INTERFACE_MODE_USXGMII is for single port,
> > so i take the interface name PHY_INTERFACE_MODE_QUSGMII for
> > quad PHYs here.
> >=20
> > can we apply PHY_INTERFACE_MODE_USXGMII to quad PHYs in this
> > case(qca8084 quad PHY mode)?
> >=20
> > Thanks,
> > Jie. =20
>=20
> one more thing, if we use the PHY_INTERFACE_MODE_USXGMII for
> the quad PHY here, the MAC serdes can't distinguish the actual
> mode PHY_INTERFACE_MODE_USXGMII and 10G-QXGMII(qca8084 quad phy mode),
> the MAC serdes has the different configurations for usxgmii(10g single=20
> port) and qxsgmii(quad PHY).

Yes you do need a way to know which mode to use, what I'm wondering is
that the usxgmii spec actually defines something like 9 different modes
( 1/2/4/8 ports, with a total bandwidth ranging from 2.5Gbps to 20 Gbps
), should we define a phy mode for all of these variants, or should we
have another way of getting the mode variant (like, saying I want to
use usxgmii, in 4 ports mode, with the serdes at 10.3125Gbps).

That being said, QUSGMII already exists to define a specific variant of
USGMII, so maybe adding 10G-QXGMII is fine...

Also, net-next is still currently closed.
