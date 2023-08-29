Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC35778C45D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjH2MjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjH2Min (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:38:43 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4B9D7;
        Tue, 29 Aug 2023 05:38:39 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A6C37864E1;
        Tue, 29 Aug 2023 14:38:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693312717;
        bh=4oQIhfEeW8PprqtRZ+HIY9RD/oqGi59F9dmuR6o4GqA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RnOb+6riZJ4PKYVN4GyuViQvsGzteh/TcwmfVZ1XPPh0JQlnhmZK+2lwFI5DK01U6
         kCrCOS8AJ58qjLiZYQtaN1qsqGM0wvRmd7Koxk6fCkIa0nNEhV448163GurEme20aE
         9ybOEjJQyEhKd/FGihtDqJtQWvrjlvsGpiWYH68NhazrrfIv6lKBZp8XOkKb3YSjzY
         187Rkl/A3m5HHNXCzJP7zUEZzjt7NpxZd9psLdLcSs1elNcoKL6yIZvMTta1H6EoQy
         LDpKbozcK2Yx5S+gX9sa3yl0kjwcNkIpVx281xBD3Ggi6XoxjwmUvAcBw+MfOY3qQ7
         Tj3kke2CQwvUg==
Date:   Tue, 29 Aug 2023 14:38:29 +0200
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
Message-ID: <20230829143829.68410966@wsk>
In-Reply-To: <20230829114739.GC31399@pengutronix.de>
References: <20230824154827.166274-1-lukma@denx.de>
        <20230824154827.166274-2-lukma@denx.de>
        <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
        <20230825103911.682b3d70@wsk>
        <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
        <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
        <20230826104910.voaw3ndvs52yoy2v@skbuf>
        <20230829103533.7966f332@wsk>
        <20230829101851.435pxwwse2mo5fwi@skbuf>
        <20230829132429.529283be@wsk>
        <20230829114739.GC31399@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xQQWG5zK/dtc4Bo4dkMkTVH";
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

--Sig_/xQQWG5zK/dtc4Bo4dkMkTVH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

> Hi Lukasz,
>=20
> On Tue, Aug 29, 2023 at 01:24:29PM +0200, Lukasz Majewski wrote:
> > Hi Vladimir,
> >  =20
> > > Hi Lukasz,
> > >=20
> > > On Tue, Aug 29, 2023 at 10:35:33AM +0200, Lukasz Majewski wrote: =20
> > > > Hi Vladimir,
> > > >    =20
> > > > > On Fri, Aug 25, 2023 at 06:48:41PM +0000,
> > > > > Tristram.Ha@microchip.com wrote:   =20
> > > > > > > > IMHO adding functions to MMD modification would
> > > > > > > > facilitate further development (for example LED setup).
> > > > > > > >     =20
> > > > > > >=20
> > > > > > > We already have some KSZ9477 specific initialization done
> > > > > > > in the Micrel PHY driver under drivers/net/phy/micrel.c,
> > > > > > > can we converge on the PHY driver which has a reasonable
> > > > > > > amount of infrastructure for dealing with workarounds,
> > > > > > > indirect or direct MMD accesses etc.?     =20
> > > > > >=20
> > > > > > Actually the internal PHY used in the
> > > > > > KSZ9897/KSZ9477/KSZ9893 switches are special and only used
> > > > > > inside those switches. Putting all the switch related code
> > > > > > in Micrel PHY driver does not really help.  When the switch
> > > > > > is reset all those PHY registers need to be set again, but
> > > > > > the PHY driver only executes those code during PHY
> > > > > > initialization.  I do not know if there is a good way to
> > > > > > tell the PHY to re-initialize again.=20
> > > > >=20
> > > > > Suppose there was a method to tell the PHY driver to
> > > > > re-initialize itself. What would be the key points in which
> > > > > the DSA switch driver would need to trigger that method?
> > > > > Where is the switch reset at runtime?   =20
> > > >=20
> > > > Tristam has explained why adding the internal switch PHY errata
> > > > to generic PHY code is not optimal.   =20
> > >=20
> > > Yes, and I didn't understand that explanation, so I asked a
> > > clarification question. =20
> >=20
> > Ok. Let's wait for Tristram's answer.
> >  =20
> > >  =20
> > > > If adding MMD generic code is a problem - then I'm fine with
> > > > just clearing proper bits with just two indirect writes in the
> > > > drivers/net/dsa/microchip/ksz9477.c
> > > >=20
> > > > I would also prefer to keep the separate ksz9477_errata()
> > > > function, so we could add other errata code there.
> > > >=20
> > > > Just informative - without this patch the KSZ9477-EVB board's
> > > > network is useless when the other peer has EEE enabled by
> > > > default (like almost all non managed ETH switches).   =20
> > >=20
> > > No, adding direct PHY MMD access code to the ksz9477 switch
> > > driver is not even the biggest problem - even though, IIUC, the
> > > "workaround" to disable EEE advertisement could be moved to
> > > ksz9477_get_features() in drivers/net/phy/micrel.c, where
> > > phydev->supported_eee could be cleared. =20
> >=20
> > To be even more interesting (after looking into the PHY micrel.c
> > code):
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c=
#L1804
> >=20
> > The errata from this patch is already present.
> >=20
> > The issue is that ksz9477_config_init() (drivers/net/phy/micrel.c)
> > is executed AFTER generic phy_probe():
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_devi=
ce.c#L3256
> > in which the EEE advertisement registers are read.
> >=20
> > Hence, those registers needs to be cleared earlier - as I do in
> > ksz9477_setup() in drivers/net/dsa/microchip/ksz9477.
> >=20
> > Here the precedence matters ... =20
> > >=20
> > > The biggest problem that I see is that Oleksij Rempel has "just"
> > > added EEE support to the KSZ9477 earlier this year, with an ack
> > > from Arun Ramadoss: 69d3b36ca045 ("net: dsa: microchip: enable
> > > EEE support"). I'm not understanding why the erratum wasn't a
> > > discussion topic then. =20
> >=20
> > +1 =20
>=20
> As this erratum states:  "this feature _can_ cause link drops".
> For example I was indeed able to have EEE relates issue between this
> switch and a link partner with AR8035 PHY. Following patch addressing
> this issue:
> https://lore.kernel.org/all/20230327142202.3754446-8-o.rempel@pengutronix=
.de/
> So, in this case KSZ9477 was not the bad side.
>=20

The errata: http://ww1.microchip.com/downloads/jp/DeviceDoc/jp599888.pdf

Module 4, "End user implications":
--------8<----------
If the link partner is not known, or if the link partner is EEE
capable, then the EEE feature should be manually disabled to avoid link
drop problems.
-------->8----------

> Since this erratum do not describe exact cause of this issue

IMHO, it does - "The EEE feature is enabled by default, but it is not
fully operational. "

It looks like some silicon issue - which in details is probably only
known to Micrel/Microchip.

> or
> specific link partners where this functionality is not working, I
> would prefer to give the user the freedom of choice.

The problem is that - the user - would encounter broken network when
connected to per advertising EEE.=20

Hence, I would prefer to apply the Errata and then somebody, who would
like to enable EEE can try if it works for him.

IMHO, code to fix erratas shall be added unconditionally, without any
"freedom of choice".

>=20
> The same issue we have with Pause Frame support. It is not always a
> good choice, but user has freedom to configure it.
>=20
> Today I wont to create a test setup with different EEE capable link
> partners on one side and KSZ9477 on other side and let it run some
> days. Just to make sure.
>=20
> Beside, are you able to reproduce this issue?
>=20

Yes, I can reproduce the issue. I do use two Microchip's development
boards (KSZ9477-EVB [1]) connected together to test HSR as well as
communication with HOST PC.

The network on this board without this patch is not usable (continually
I do encounter link up/downs).

Another test scenario is to connect this board to non-managed ETH
switch (which shall have the EEE advertised by default).


Please be also aware, that this errata fix is (implicitly I think)
already present in the kernel:
https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L18=
04

However, the execution order of PHY/DSA functions with newest mainline
makes it not working any more (I've described it in details in the
earlier mail to Vladimir).

> Regards,
> Oleksij

Links:
[1] - https://www.microchip.com/en-us/development-tool/evb-ksz9477-1


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/xQQWG5zK/dtc4Bo4dkMkTVH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTt5sUACgkQAR8vZIA0
zr0aAwgAgEZGUs4z/+fB52lCyHVIsdw+vpX5CfPMEgL7NyqeEkMZiklspkcCL6T6
3SOS7wqlsjDPjKyh4BMoLtYkcqUEIbN+43aQ3JpQ8c9TV4h7rrQyZDAKJ0NS61mq
zcIq6h1EyCDp0K4pCYElIgIZHRG4F/Pzj0HrZ2slYL1LSINr/JImjNoi0U8uaZBB
yCbtZN+XcVXeHCLUfkZiwlkNqH4DzfDYvro2XGEVLuPLjqSeaeSW60CjLfaeCv7p
IYI5nH8ehtAncndNbcaYS3+EFudV1rZIdCHgGPz8jteVj96kduEqqzgm/CxGsshi
GcObn4b6aAT75olmhqyN5/RsNr211g==
=sv4S
-----END PGP SIGNATURE-----

--Sig_/xQQWG5zK/dtc4Bo4dkMkTVH--
