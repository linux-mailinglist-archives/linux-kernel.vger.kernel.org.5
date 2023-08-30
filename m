Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E8A78E006
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242097AbjH3TYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343705AbjH3Qij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:38:39 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B4B19A;
        Wed, 30 Aug 2023 09:38:32 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 94013863DA;
        Wed, 30 Aug 2023 18:38:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693413505;
        bh=Vq4tCwGppZsplQyXZje86VCfWpaZHishwdiN+Yqfavg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G7GyKrERuJqi8IhQNYV2gMCOHk2zZKdRRMjRSTOLkfZkv89siaO9eiSVzRsiTHpvC
         mtvlovxnRuiFZkpfWYRDhZ8T4TDCeU4SfVsBTVFLsKAUSEWdj9q3WTDoOU4/KQ6Wii
         yQ+5NIOSl+7HiDo6Ag9OSzDyF109XefnltyG1jmfU0HsRP/4lVVu7i050PfGOrJBMb
         FJ9/15RIQlMyNGflCncoGnOVl9WclNWq7hYSrhWv3AkDE9ykuiVRll9lWjpby69oJu
         gr/GtiXg/KP6x63kQtKxaxQ6wakxXv5xskNlQ/6TSnG4c9so63fKSLDkRSVrndQ/7t
         rrljrDpu+vG2A==
Date:   Wed, 30 Aug 2023 18:38:18 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230830183818.1f42919b@wsk>
In-Reply-To: <20230830142650.GL31399@pengutronix.de>
References: <20230830092119.458330-1-lukma@denx.de>
        <20230830092119.458330-2-lukma@denx.de>
        <20230830101813.GG31399@pengutronix.de>
        <20230830125224.1012459f@wsk>
        <20230830105941.GH31399@pengutronix.de>
        <20230830135151.683303db@wsk>
        <20230830121738.GJ31399@pengutronix.de>
        <ZO83htinyfAp4mWw@shell.armlinux.org.uk>
        <20230830130649.GK31399@pengutronix.de>
        <ZO9Ejx9G8laNRasu@shell.armlinux.org.uk>
        <20230830142650.GL31399@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HDhBKiZ42GjkylX./H/Qstn";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HDhBKiZ42GjkylX./H/Qstn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

> On Wed, Aug 30, 2023 at 02:30:55PM +0100, Russell King (Oracle) wrote:
> > On Wed, Aug 30, 2023 at 03:06:49PM +0200, Oleksij Rempel wrote: =20
> > > On Wed, Aug 30, 2023 at 01:35:18PM +0100, Russell King (Oracle)
> > > wrote: =20
> > > > On Wed, Aug 30, 2023 at 02:17:38PM +0200, Oleksij Rempel wrote:
> > > > =20
> > > > > On Wed, Aug 30, 2023 at 01:51:51PM +0200, Lukasz Majewski
> > > > > wrote: =20
> > > > > > Hi Oleksij, =20
> > > > >  =20
> > > > > > It looks like the most optimal solution would be the one
> > > > > > proposed by Tristam:
> > > > > > https://www.spinics.net/lists/netdev/msg932044.html =20
> > > > >=20
> > > > > In this case, please add the reason why it would work on this
> > > > > HW and will not break by any changes in PHYlib or micrel.c
> > > > > driver.
> > > > >=20
> > > > > If I remember it correctly, in KSZ9477 variants, if you write
> > > > > to EEE advertisement register, it will affect the state of a
> > > > > EEE capability register. Which break IEEE 802.3 specification
> > > > > and the reason why ksz9477_get_features() actually exist. But
> > > > > can be used as workaround if it is written early enough
> > > > > before PHYlib tried to read EEE capability register.
> > > > >=20
> > > > > Please confirm my assumption by applying your workaround and
> > > > > testing it with ethtool --show-eee lanX.
> > > > >=20
> > > > > It should be commented in the code with all kind of warnings:
> > > > > Don't move!!! We use one bug to workaround another bug!!! If
> > > > > PHYlib start scanning PHYs before this code is executed, then
> > > > > thing may break!! =20
> > > >=20
> > > > Why would phylib's scanning cause breakage?
> > > >=20
> > > > phylib's scanning for PHYs is about reading the ID registers
> > > > etc. It doesn't do anything until the PHY has been found, and
> > > > then the first thing that happens when the phy_device structure
> > > > is created is an appropriate driver is located, and the
> > > > driver's ->probe function is called.
> > > >=20
> > > > If that is successful, then the fewatures are read. If the PHY
> > > > driver's ->features member is set, then that initialises the
> > > > "supported" mask and we read the EEE abilities.
> > > >=20
> > > > If ->features is not set, then we look to see whether the driver
> > > > provides a ->get_features method, and call that.
> > > >=20
> > > > Otherwise we use the generic genphy_c45_pma_read_abilities() or
> > > > genphy_read_abilities() depending whether the PHY's is_c45 is
> > > > set or not.
> > > >=20
> > > > So, if you want to do something very early before features are
> > > > read, then either don't set .features, and do it early in
> > > > .get_features before calling anything else, or do it in the
> > > > ->probe function. =20
> > >=20
> > > Let me summarize my view on the problem, so may be you can
> > > suggest a better way to solve it.
> > > - KSZ9477, KSZ8565, KSZ9893, KSZ9563, seems to have different
> > > quirks by the same PHYid. micrel.c driver do now know what exact
> > > HW is actually in use.
> > > - A set of PHY workarounds was moved from dsa/microchip/ksz9477.c
> > > to micrel.c, one of this workaround was clearing EEE advertisement
> > >   register, which by accident was clearing EEE capability
> > > register. Since EEE cap was cleared by the
> > > dsa/microchip/ksz9477.c code before micrel.c was probed, PHYlib
> > > was assuming that his PHY do not supports EEE and dint tried to
> > > use it. After moving this code to micrel.c, it is now trying to
> > > change EEE advertisement state without letting PHYlib to know
> > > about it and PHYlib re enables it as actually excepted.
> > > - so far, only KSZ9477 seems to be broken beyond repair, so it is
> > > better to disable EEE without giving it as a choice for user
> > > configuration. =20
> >=20
> > We do have support in phylib for "broken EEE modes" which DT could
> > set for the broken PHYs, and as it is possible to describe the DSA
> > PHYs in DT. This sets phydev->eee_broken_modes.
> >=20
> > phydev->eee_broken_modes gets looked at when genphy_config_aneg() or
> > genphy_c45_an_config_aneg() gets called - which will happen when the
> > PHY is being "started".
> >=20
> > So, you could add the DT properties as appropriate to disable all
> > the EEE modes.
> >=20
> > Alternatively, in your .config_init function, you could detect your
> > flag and force eee_broken_modes to all-ones. =20
>=20
> @Lukasz,
>=20
> can you please try to set eee_broken_modes to all-ones. Somewhat like
> this:
> ksz9477_config_init()
> ...
>    ...quirks...
>=20
>    if (phydev->dev_flages & .. NO_EEE...)
>        phydev->eee_broken_modes =3D -1;
>=20
>    err =3D genphy_restart_aneg(phydev);
>    ...
>=20

The implementation as you suggested seems to work :-)

The ksz_get_phy_flags() - where the MICREL_NO_EEE is set is executed
before ksz9477_config_init().

And then the eee_broken_modes are taken into account.

# ethtool --show-eee lan1
EEE Settings for lan1:
        EEE status: disabled
        Tx LPI: 0 (us)
        Supported EEE link modes:  100baseT/Full=20
                                   1000baseT/Full=20
        Advertised EEE link modes:  Not reported
        Link partner advertised EEE link modes:  Not reported

I will prepare tomorrow a proper patch.

> @Russell, thx!
>=20
> Regards,
> Oleksij




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/HDhBKiZ42GjkylX./H/Qstn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTvcHoACgkQAR8vZIA0
zr2CKggAwnXHPCv9T3+LjMLaAbCfTmQYU3/eM2lw9tY6SuziHn5nilWy1m2YPxHy
fCMCf65/sJO5ll3aY7g6rZrgJNzaA65O/WcevEMzsJdbORHknngFtSmbjEWKhZML
zccUWjONPEQJRz8VKHbSEBJU0+vI6WM/V8gMlezIsHLWv2r3CyUEdovDm5Byfu2x
/+Hveps5DckxLILVBqHz/26ilrLV50RjUbQhL/CNjy/vP+flFzb+v3d4d2EAkEqD
ypOylv6tQUvptjLeBTRHTb5yYH+f2TOaktZNBA8VK8DPohSFhgAoeL9jS06tltNY
cxF01C4vci92cJysyHglAGWOb4MJnA==
=C6Us
-----END PGP SIGNATURE-----

--Sig_/HDhBKiZ42GjkylX./H/Qstn--
