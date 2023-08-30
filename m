Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF2378DF34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243502AbjH3TNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbjH3Kwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:52:36 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8801BF;
        Wed, 30 Aug 2023 03:52:34 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5D3EF86516;
        Wed, 30 Aug 2023 12:52:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693392752;
        bh=4iy2dgBtv1IFl2QeVny+BMUypmk/B0kng10sRZaOjfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=puhuMduyerGNtMY194xqhkJ38jVeZTe7/phaxlcILl2rKeRwH5j8ZWWtltatFXUCs
         wIIM7TTP/HtEmumaB4mGjT3k0SRKysHGL4P+R5Ll4Vel3flFtyCm4hJ5xmVg0rfGcp
         M5xwWjvbS5JKs1DJTM3VqgUd6jO7+cMa9LLROGj1qfYSjpajabWqAbtHwOGEtSGJlx
         ibd6G2YxpFimgoJjiBdl6oTp1WaltC15dMRJltLE+NVGMwOwqIiC0TSoBE4Tv0+49H
         9BoMCBePcmRRn+qeaDV65H4yHpQ1h5vTewUS6K+INQbrk9dtJT1s3HrX6mcWRMY9e0
         5KGiTj5FAt/Eg==
Date:   Wed, 30 Aug 2023 12:52:24 +0200
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
Message-ID: <20230830125224.1012459f@wsk>
In-Reply-To: <20230830101813.GG31399@pengutronix.de>
References: <20230830092119.458330-1-lukma@denx.de>
        <20230830092119.458330-2-lukma@denx.de>
        <20230830101813.GG31399@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h9eFv_ld1ej3r2/LQFcjcHy";
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

--Sig_/h9eFv_ld1ej3r2/LQFcjcHy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

> On Wed, Aug 30, 2023 at 11:21:19AM +0200, Lukasz Majewski wrote:
> > The KSZ9477 errata points out (in 'Module 4') the link up/down
> > problem when EEE (Energy Efficient Ethernet) is enabled in the
> > device to which the KSZ9477 tries to auto negotiate.
> >=20
> > The suggested workaround is to clear advertisement of EEE for PHYs
> > in this chip driver.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  drivers/net/phy/micrel.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index 87b090ad2874..469dcd8a5711 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -1418,6 +1418,35 @@ static int ksz9131_get_features(struct
> > phy_device *phydev) return 0;
> >  }
> > =20
> > +static int ksz9477_get_features(struct phy_device *phydev)
> > +{
> > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(zero) =3D { 0, };
> > +	int ret;
> > +
> > +	ret =3D genphy_read_abilities(phydev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* KSZ9477 Errata DS80000754C
> > +	 *
> > +	 * Module 4: Energy Efficient Ethernet (EEE) feature
> > select must be
> > +	 * manually disabled
> > +	 *   The EEE feature is enabled by default, but it is not
> > fully
> > +	 *   operational. It must be manually disabled through
> > register
> > +	 *   controls. If not disabled, the PHY ports can
> > auto-negotiate
> > +	 *   to enable EEE, and this feature can cause link drops
> > when linked
> > +	 *   to another device supporting EEE.
> > +	 *
> > +	 *   Although, the KSZ9477 MMD register
> > +	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that
> > EEE is
> > +	 *   operational one needs to manualy clear them to follow
> > the chip
> > +	 *   errata.
> > +	 */
> > +	linkmode_and(phydev->supported_eee, phydev->supported,
> > zero); +
> > +	return 0;
> > +}
> > +
> >  #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
> >  #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
> >  #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
> > @@ -4871,7 +4900,7 @@ static struct phy_driver ksphy_driver[] =3D {
> >  	.handle_interrupt =3D kszphy_handle_interrupt,
> >  	.suspend	=3D genphy_suspend,
> >  	.resume		=3D genphy_resume,
> > -	.get_features	=3D ksz9131_get_features,
> > +	.get_features	=3D ksz9477_get_features, =20
>=20
> Sorry, i didn't described all details how to implement it.
>=20
> This code will break EEE support for the KSZ8563R switch.
>=20

And then another switch (KSZ8563R) pops up.... with regression....

In the micrel.c the ksz9477_get_features was only present in:
https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L48=
32
https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L48=
74
so I only changed it there.

Apparently the KSZ8563R re-uses the KSZ9477 code.

> Please search for MICREL_KSZ8_P1_ERRATA in the kernel source.
> Then add new flag, for example MICREL_NO_EEE and use it in a similar
> way how MICREL_KSZ8_P1_ERRATA was set and used. With this
> implementation, first patch is not needed.
>=20
> The code will be something like this:
>    if (dev_flags & MICREL_NO_EEE)
>       /* lots of comments */
>       linkmode_and(phydev->supported_eee, phydev->supported, zero);
>    else
>       /* lots of other comments */
>       linkmode_and(phydev->supported_eee, phydev->supported,
>                    PHY_EEE_CAP1_FEATURES);
>=20
> On the switch driver side i would expect something like this:
> ksz_get_phy_flags(struct dsa_switch *ds, int port)
>=20
>        swtich (dev->chip_id)
>        case KSZ8830_CHIP_ID:
>          ....
>          break;
>        case KSZ9477_CHIP_ID:
>          return MICREL_NO_EEE;
>=20

Ok.

>=20
> Regards,
> Oleksij




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/h9eFv_ld1ej3r2/LQFcjcHy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTvH2gACgkQAR8vZIA0
zr03EAf/dzKX5xBDzxxf3gCzBx845qIrLKBbcefyefXWjwKRGvwRt+etzNPY0dAV
W9AfR/hlRhVv5CZvZv8UtXNEKvscvf15vcjnNoEtu7ZRWyaaRoGbcBGSL6dlKt9q
/FusYl39cP1yxJxavoYXDRfWtZyQLNbB1HipukrRy/SpBMMt9ixG8qnXRsnriEPW
ID14Wa+AJbZX0CnbB9imG5u70zY624HFB62xRXcLVhoioNdIl6okSU/SmWIGl8Rl
DCQy7Pz+JedrSiG/NoDyTKokITGDyvpYqaNAjV09IlpY2rF5aTxnt/obpRceAkls
IZtIjE09lf7uuM3yFFYYR6NKIx5cCQ==
=nFBB
-----END PGP SIGNATURE-----

--Sig_/h9eFv_ld1ej3r2/LQFcjcHy--
