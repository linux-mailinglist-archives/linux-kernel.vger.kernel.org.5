Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9416978C89C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237277AbjH2P3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbjH2P31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:29:27 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D55132;
        Tue, 29 Aug 2023 08:29:22 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 31DCA80702;
        Tue, 29 Aug 2023 17:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693322961;
        bh=GXRLNBa2w1Prm2RkQtWFwcIN9kBBUv94ZVlih8cyj54=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oK5fLib1FGuYUOCooikMUvyGA7BNtcSGvVmHLRl2cMKvEINL/C6ZYCgE6IjVBYbD+
         BQTlZPmuaX/K3wW0YTksg/+d+sy5OrLDfVWgEUWrHW8tb70peHU2Lsvn8zTWsES12I
         XFPP78mxNNuaHPm3k2DFlAJGkcn8XTg9USza97HO0EiOuO8RqaY3dkPDcPdZShiuVO
         1j8ubzS2ZHO1o5WR3DzOtQwxTWGui6KMQDd0tb0GLT5QvYFNbxC0DY3pjviw+LK7WE
         8dAjndFtzlc/cERHItK3dJiI0IcrFFbdvBno22qngcKsqiRXAya7sCKpu9a2zrolyd
         zZOC/M8U7/MUA==
Date:   Tue, 29 Aug 2023 17:29:13 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        f.fainelli@gmail.com, andrew@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, Woojung.Huh@microchip.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477
 errata (DS80000754C)
Message-ID: <20230829172913.518210b0@wsk>
In-Reply-To: <20230829144209.GD31399@pengutronix.de>
References: <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
        <20230825103911.682b3d70@wsk>
        <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
        <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
        <20230826104910.voaw3ndvs52yoy2v@skbuf>
        <20230829103533.7966f332@wsk>
        <20230829101851.435pxwwse2mo5fwi@skbuf>
        <20230829132429.529283be@wsk>
        <20230829114739.GC31399@pengutronix.de>
        <20230829143829.68410966@wsk>
        <20230829144209.GD31399@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m3=fATDj/Tb/P3I_F3IAylm";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m3=fATDj/Tb/P3I_F3IAylm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

> On Tue, Aug 29, 2023 at 02:38:29PM +0200, Lukasz Majewski wrote:
> > Hi Oleksij, =20
>=20
> ...
>=20
> > Hence, I would prefer to apply the Errata and then somebody, who
> > would like to enable EEE can try if it works for him. =20
>=20
> ok.
>=20
> > IMHO, code to fix erratas shall be added unconditionally, without
> > any "freedom of choic =20
>=20
> This claim is not consistent with the patch. To make it without
> ability to enable EEE, you will need to clear all eee_supported bits.
> If this HW is really so broken, then it is the we how it should be
> fixed.
>=20
> > > Beside, are you able to reproduce this issue? =20
> >=20
> > Yes, I can reproduce the issue. I do use two Microchip's development
> > boards (KSZ9477-EVB [1]) connected together to test HSR as well as
> > communication with HOST PC. =20
>=20
> I use KSZ9477-EVB as well.
>=20
> > The network on this board without this patch is not usable
> > (continually I do encounter link up/downs). =20
>=20
> My test setup runs currently about two hours. It had 4 link drops on
> LAN3 and none on other ports. Swapping cables connected to LAN2 and
> LAN3 still let the LAN3 sometimes drop the connection. So far, for
> example LAN2 works stable and this is probably the reason why I have
> not seen this issue before. After disabling EEE on LAN3 I start
> getting drops on LAN2.
>=20

Ok.

> > Please be also aware, that this errata fix is (implicitly I think)
> > already present in the kernel:
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c=
#L1804
> >=20
> > However, the execution order of PHY/DSA functions with newest
> > mainline makes it not working any more (I've described it in
> > details in the earlier mail to Vladimir). =20
>=20
> Ok, since it was already not advertised by default, I have nothing
> against having default policy to not advertise EEE for this switch.
>=20

Ok.

> On other hand, since this functionality is not listed as supported by
> the KSZ9477 datasheet (No word about IEEE 802.3az Energy Efficient
> Ethernet (EEE)) compared to KSZ8565R datasheet (where EEE support is
> listed) and it is confirmed to work not stable enough, then it should
> be disabled properly.

I've described this problem in more details here:
https://lore.kernel.org/lkml/20230829132429.529283be@wsk/

-------->8---------
The issue is that ksz9477_config_init() (drivers/net/phy/micrel.c) is
executed AFTER generic phy_probe():
https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c=
#L3256
in which the EEE advertisement registers are read.

Hence, those registers needs to be cleared earlier - as I do in
ksz9477_setup() in drivers/net/dsa/microchip/ksz9477.

Here the precedence matters ...
----------8<-------------

> The phydev->supported_eee should be cleared.
> See ksz9477_get_features().
>=20

Removing the linkmod_and() from ksz9477_get_features():
https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L14=
08

doesn't help.

It looks like it is done too late (please read the above e-mail). We
would need to disable the eee support at all for this switch IC or
apply the original version of this patch (I mean clear in-KSZ9477 EEE
advertisement register early).

>=20
> Regards,
> Oleksij




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/m3=fATDj/Tb/P3I_F3IAylm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTuDskACgkQAR8vZIA0
zr0SzAf8CF4+HvTpzAC4rMQhvCWNO2d9+Ik3lbPeKjmb8NTc271HPNi/9rVI7feR
7H3KIOKiRHeLwcfYUMhZ2/YFa3Cz4M2V0PRn2e3M7bd0/8d4qy05mbwpM7vs8plb
1QMbHrtqWaK9hN+mErgbV1y+nqCZIf/zJluQp4GAwLKknedR7/5PSHJ6SU04lQLy
J/y+fgrxB7N0muLoOLfPT9TuEEZ1DnzBQawk951kfjOsaxIGuweOmAsjTNavWlf3
FI4d0RTCsupVrov+JIsWJtaHnMYSSYS44dBgnxAFkgdx8bMoMbSA1oRxwIj+9tYP
zcfQr9+gkIQNcRziQ+ZpP1uvLWyBDw==
=5Cw7
-----END PGP SIGNATURE-----

--Sig_/m3=fATDj/Tb/P3I_F3IAylm--
