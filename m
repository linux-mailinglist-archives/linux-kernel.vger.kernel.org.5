Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3778DBAD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbjH3Sbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243845AbjH3LwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:52:06 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D0CCB;
        Wed, 30 Aug 2023 04:52:00 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B1832863CF;
        Wed, 30 Aug 2023 13:51:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693396318;
        bh=ZfkA8l3AfpsaQkpYEzpGtnwaPR6OeMuECHjD17xnjtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RLAtI32C/+Ryd01DYVy0mRJUEKob6m6w/K8qdIyl4It3ptK7dpOChP3ApQrKRKx9n
         oEH6wkHT1dhjJAvZ2niCf3LiHWla8snEgtTn2A+fZqsNN6uH+SOZn/tWw9jWkwKtTJ
         4DBxXqeBTxjdIt2CbNSXvTTWM7O78MldrmvbbkJ+dvyIIzVK4pGUDou+qvliMENmHY
         9ZlegYhqsn0Y8FeuYCwI4vMlGfHVUpmkESjsNyI0e3HwF31Yy7eDRg2Iax+jObzocj
         CWlUG3pX66e5lf7ZvbhNKLCCBbhKGQu3RbN3/Aq02IxwSfGmoL5GZumrUI6fyA/TDP
         qE7PX4BHHyPPQ==
Date:   Wed, 30 Aug 2023 13:51:51 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230830135151.683303db@wsk>
In-Reply-To: <20230830105941.GH31399@pengutronix.de>
References: <20230830092119.458330-1-lukma@denx.de>
        <20230830092119.458330-2-lukma@denx.de>
        <20230830101813.GG31399@pengutronix.de>
        <20230830125224.1012459f@wsk>
        <20230830105941.GH31399@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tJ.TSE4IFMq=Jd_C=j17xAQ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tJ.TSE4IFMq=Jd_C=j17xAQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

> On Wed, Aug 30, 2023 at 12:52:24PM +0200, Lukasz Majewski wrote:
> > Hi Oleksij,
> >  =20
> > > On Wed, Aug 30, 2023 at 11:21:19AM +0200, Lukasz Majewski wrote: =20
> > > > The KSZ9477 errata points out (in 'Module 4') the link up/down
> > > > problem when EEE (Energy Efficient Ethernet) is enabled in the
> > > > device to which the KSZ9477 tries to auto negotiate.
> > > >=20
> > > > The suggested workaround is to clear advertisement of EEE for
> > > > PHYs in this chip driver.
> > > >=20
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > ---
> > > >  drivers/net/phy/micrel.c | 31 ++++++++++++++++++++++++++++++-
> > > >  1 file changed, 30 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > > > index 87b090ad2874..469dcd8a5711 100644
> > > > --- a/drivers/net/phy/micrel.c
> > > > +++ b/drivers/net/phy/micrel.c
> > > > @@ -1418,6 +1418,35 @@ static int ksz9131_get_features(struct
> > > > phy_device *phydev) return 0;
> > > >  }
> > > > =20
> > > > +static int ksz9477_get_features(struct phy_device *phydev)
> > > > +{
> > > > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(zero) =3D { 0, };
> > > > +	int ret;
> > > > +
> > > > +	ret =3D genphy_read_abilities(phydev);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* KSZ9477 Errata DS80000754C
> > > > +	 *
> > > > +	 * Module 4: Energy Efficient Ethernet (EEE) feature
> > > > select must be
> > > > +	 * manually disabled
> > > > +	 *   The EEE feature is enabled by default, but it is
> > > > not fully
> > > > +	 *   operational. It must be manually disabled through
> > > > register
> > > > +	 *   controls. If not disabled, the PHY ports can
> > > > auto-negotiate
> > > > +	 *   to enable EEE, and this feature can cause link
> > > > drops when linked
> > > > +	 *   to another device supporting EEE.
> > > > +	 *
> > > > +	 *   Although, the KSZ9477 MMD register
> > > > +	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that
> > > > EEE is
> > > > +	 *   operational one needs to manualy clear them to
> > > > follow the chip
> > > > +	 *   errata.
> > > > +	 */
> > > > +	linkmode_and(phydev->supported_eee, phydev->supported,
> > > > zero); +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
> > > >  #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
> > > >  #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
> > > > @@ -4871,7 +4900,7 @@ static struct phy_driver ksphy_driver[] =3D
> > > > { .handle_interrupt =3D kszphy_handle_interrupt,
> > > >  	.suspend	=3D genphy_suspend,
> > > >  	.resume		=3D genphy_resume,
> > > > -	.get_features	=3D ksz9131_get_features,
> > > > +	.get_features	=3D ksz9477_get_features,   =20
> > >=20
> > > Sorry, i didn't described all details how to implement it.
> > >=20
> > > This code will break EEE support for the KSZ8563R switch.
> > >  =20
> >=20
> > And then another switch (KSZ8563R) pops up.... with regression.... =20
>=20
> Initially ksz9477_get_features() was introduced to fix KSZ8563R.
>=20
> > In the micrel.c the ksz9477_get_features was only present in:
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c=
#L4832
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c=
#L4874
> > so I only changed it there.
> >=20
> > Apparently the KSZ8563R re-uses the KSZ9477 code. =20
>=20
> Most (all?) switch variant support by the ksz9477 DSA driver share
> the same PHYid, so it is not possible to identify it by the micrel.c
> PHY driver. As far as a know, the only commonly accepted way to
> notify about some quirks between this both drivers is not user
> dev_flags.
>=20

We would need another idea on fixing this problem as there is following
order of function calls:

-> ksz9477_setup
-> ksz9477_get_features  (here we are supposed to use the MICREL_NO_EEE
flag)
-> ksz_get_phy_flags  (here we are supposed to set the MICREL_NO_EEE
flag)

The ksz9477_get_features is called early.=20



It looks like the most optimal solution would be the one proposed by
Tristam:
https://www.spinics.net/lists/netdev/msg932044.html

It would clear the 7.60 per-port register with two ksz_write16
functions.

That exactly follows the recommendation for KSZ9477 Errata Module4.

> Regards,
> Oleskij




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/tJ.TSE4IFMq=Jd_C=j17xAQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTvLVcACgkQAR8vZIA0
zr23BAgAucOpuRW6eOUhNVv+yygM5Oc1EDctA4R/phRBS86LRqtnvhGCQsPcFaT3
HXKym9s0mUJ0pWxQSF8x9/p8cd7qZFCoAw50Y/1oPfqAo3vlqkmMJXYOscGOXbpK
cdM9G+j/49ynAAU2NrVKW96clr3swHLbZsNiaE8apW9V15aNHYEtHt6nvXDFOOKt
pV98/smax72bZ7XC27Sfrn+NM0gRRMFEs1eTMyGjOUKJDbnlki+mGSBM2155icxG
dmvMQQyB2mYeM9OXsTV/jpgiQvXq9Xhu6ohvqNNo84XFbAreldPHWykd+nU1lWIc
rwfeEUPaK5oGk4E9TwoHC4CMEsHhnA==
=uhka
-----END PGP SIGNATURE-----

--Sig_/tJ.TSE4IFMq=Jd_C=j17xAQ--
