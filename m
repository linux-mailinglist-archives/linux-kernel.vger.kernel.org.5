Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465CA78C344
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjH2LZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjH2LYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:24:43 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4240E10E;
        Tue, 29 Aug 2023 04:24:39 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 7C794864D7;
        Tue, 29 Aug 2023 13:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693308277;
        bh=wGPvmCpkY09PxXZP/4FBJb0ijHryN5PPK0042+jRj4k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MtKvRUyMVMAwMWfBRmaX4y4PX6Fgv8sbbFfLRUsXq5HJ8CLlF61Nxa2UZFO0asv+M
         qA6Fc9VoaZ7YvUHzxVVWC+j5/oAaXRkZd2Yh5LLZ7L/i6TIlpw+Rp59QkhSGcynzg6
         flchxP75wi2AmdPX+VQ2+M8ENolj0NHjYYNSszSjgnZpd8SDy7qckOfx1Up7PH0D1x
         Xnj+83qxt9BMnePPU/CocZ+FJ0F6ukTPqqzfRpDVbyvXKDr4NVenFtVxZv7kFPjLUl
         dyTSFyMSw7M/O0u1Muzg2SuWkECOfq+7JSOn59OygGkHg8ykH2uM1Vk8XLdWS4YAED
         rrLMOxzzGNHLA==
Date:   Tue, 29 Aug 2023 13:24:29 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com
Cc:     Oleksij Rempel <linux@rempel-privat.de>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        f.fainelli@gmail.com, andrew@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, Woojung.Huh@microchip.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477
 errata (DS80000754C)
Message-ID: <20230829132429.529283be@wsk>
In-Reply-To: <20230829101851.435pxwwse2mo5fwi@skbuf>
References: <20230824154827.166274-1-lukma@denx.de>
        <20230824154827.166274-2-lukma@denx.de>
        <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
        <20230825103911.682b3d70@wsk>
        <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
        <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
        <20230826104910.voaw3ndvs52yoy2v@skbuf>
        <20230829103533.7966f332@wsk>
        <20230829101851.435pxwwse2mo5fwi@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fbGdaC+4hdAn8S0lyh_1yJe";
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

--Sig_/fbGdaC+4hdAn8S0lyh_1yJe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> Hi Lukasz,
>=20
> On Tue, Aug 29, 2023 at 10:35:33AM +0200, Lukasz Majewski wrote:
> > Hi Vladimir,
> >  =20
> > > On Fri, Aug 25, 2023 at 06:48:41PM +0000,
> > > Tristram.Ha@microchip.com wrote: =20
> > > > > > IMHO adding functions to MMD modification would facilitate
> > > > > > further development (for example LED setup).   =20
> > > > >=20
> > > > > We already have some KSZ9477 specific initialization done in
> > > > > the Micrel PHY driver under drivers/net/phy/micrel.c, can we
> > > > > converge on the PHY driver which has a reasonable amount of
> > > > > infrastructure for dealing with workarounds, indirect or
> > > > > direct MMD accesses etc.?   =20
> > > >=20
> > > > Actually the internal PHY used in the KSZ9897/KSZ9477/KSZ9893
> > > > switches are special and only used inside those switches.
> > > > Putting all the switch related code in Micrel PHY driver does
> > > > not really help.  When the switch is reset all those PHY
> > > > registers need to be set again, but the PHY driver only
> > > > executes those code during PHY initialization.  I do not know
> > > > if there is a good way to tell the PHY to re-initialize again.
> > > >  =20
> > >=20
> > > Suppose there was a method to tell the PHY driver to re-initialize
> > > itself. What would be the key points in which the DSA switch
> > > driver would need to trigger that method? Where is the switch
> > > reset at runtime? =20
> >=20
> > Tristam has explained why adding the internal switch PHY errata to
> > generic PHY code is not optimal. =20
>=20
> Yes, and I didn't understand that explanation, so I asked a
> clarification question.

Ok. Let's wait for Tristram's answer.

>=20
> > If adding MMD generic code is a problem - then I'm fine with just
> > clearing proper bits with just two indirect writes in the
> > drivers/net/dsa/microchip/ksz9477.c
> >=20
> > I would also prefer to keep the separate ksz9477_errata() function,
> > so we could add other errata code there.
> >=20
> > Just informative - without this patch the KSZ9477-EVB board's
> > network is useless when the other peer has EEE enabled by default
> > (like almost all non managed ETH switches). =20
>=20
> No, adding direct PHY MMD access code to the ksz9477 switch driver is
> not even the biggest problem - even though, IIUC, the "workaround" to
> disable EEE advertisement could be moved to ksz9477_get_features() in
> drivers/net/phy/micrel.c, where phydev->supported_eee could be
> cleared.

To be even more interesting (after looking into the PHY micrel.c code):
https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L18=
04

The errata from this patch is already present.

The issue is that ksz9477_config_init() (drivers/net/phy/micrel.c) is
executed AFTER generic phy_probe():
https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c=
#L3256
in which the EEE advertisement registers are read.

Hence, those registers needs to be cleared earlier - as I do in
ksz9477_setup() in drivers/net/dsa/microchip/ksz9477.

Here the precedence matters ...

>=20
> The biggest problem that I see is that Oleksij Rempel has "just" added
> EEE support to the KSZ9477 earlier this year, with an ack from Arun
> Ramadoss: 69d3b36ca045 ("net: dsa: microchip: enable EEE support").
> I'm not understanding why the erratum wasn't a discussion topic then.

+1

>=20
> I am currently on vacation and won't be able to look very deeply into
> the problem, but IIUC, your patch undoes that work, and so, it needs
> an ACK from Oleksij.

Ok.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/fbGdaC+4hdAn8S0lyh_1yJe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTt1W0ACgkQAR8vZIA0
zr2zkggAhj+GVYbj7DP5xNuMZ/JCrsTXEMIA6zcZ9NvRRnUSWKrGT+3oZ8U6CDQC
XGdfJieF5pIa6cTHND6RC59H+3T7qWOgLG5PzWaG4dysK2JY9EfhvQdRcF9ygBL5
9v1XpZIf+asMsP5EBSuqI8BUDM/GctXBL1FNb7YiNt9+x3f4zLnAoMb2iPm8w4rs
JtYTPc/ItdW3uOvUpKjV1XLg3n4lp5XbiIjqIcIa3PH0IsuNyTUBStsc9j0wtqif
i9LJiy9mLnVqj2pOMr0sQF7DbIb11ri7pxsfmqZIRZC0v/kQNQoEr9pUHXJi8Djk
WNvbJBt2OfvkA9M7POqrFm1CpUt+ag==
=P8Xf
-----END PGP SIGNATURE-----

--Sig_/fbGdaC+4hdAn8S0lyh_1yJe--
