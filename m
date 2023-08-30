Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6888678DFFB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbjH3TNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244579AbjH3NYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:24:08 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF21A3;
        Wed, 30 Aug 2023 06:24:04 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9ECB0862F1;
        Wed, 30 Aug 2023 15:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693401842;
        bh=tDm48SEXOQC336EEKo1jetqWgnlrhRnlP90mRK3rqnQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KxhWoohO3lenSAOjuLRo2n9uOXXREQkOjVTwPhMbyefQK87DcN4fkAAvusmGNj8Cp
         4AknMk2N9nW1Fq4ElwRg2hJhQKR0Knb52GUhm1ijBjOfiYDvjjSOW30+W4LQBCscQU
         Y4FeZb1ONsf+6pdSUoWZDMq3pmdurX+lnw+LD22CTqjWQAMSwwq45rgBCk8ijtWKh2
         0JegeE8gbJxfjmlqVDA5ow3MulpT/SYu4K3O57blkPCUPYoSAo6e4J4h4SSIxtDokN
         WgYjPRcWFpvjWFyf8QIzo5ESj8OvqFabFQnO5ZRZVEMlvLRHnPPYGIwMsSfOi11+mC
         /QYljx+zCTYEQ==
Date:   Wed, 30 Aug 2023 15:23:54 +0200
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
Message-ID: <20230830152354.57108943@wsk>
In-Reply-To: <20230830121738.GJ31399@pengutronix.de>
References: <20230830092119.458330-1-lukma@denx.de>
        <20230830092119.458330-2-lukma@denx.de>
        <20230830101813.GG31399@pengutronix.de>
        <20230830125224.1012459f@wsk>
        <20230830105941.GH31399@pengutronix.de>
        <20230830135151.683303db@wsk>
        <20230830121738.GJ31399@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r8EfiN=D1y4NgEH=TvzF.ZJ";
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

--Sig_/r8EfiN=D1y4NgEH=TvzF.ZJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

> On Wed, Aug 30, 2023 at 01:51:51PM +0200, Lukasz Majewski wrote:
> > Hi Oleksij, =20
>=20
> > It looks like the most optimal solution would be the one proposed by
> > Tristam:
> > https://www.spinics.net/lists/netdev/msg932044.html =20
>=20
> In this case, please add the reason why it would work on this HW and
> will not break by any changes in PHYlib or micrel.c driver.
>=20

The ksz9477_config_cpu_port() is called from ksz_setup. In this
function we would clear 7.60 MMD register for EEE advertisement.

Only after the switch initialization, the phy code reads 7.60 register
for each port and on that basis decides if the EEE is supported or not.

(And only then ksz9477_get_features() is executed. Finally
ksz_get_phy_flags() is called.

> If I remember it correctly, in KSZ9477 variants, if you write to EEE
> advertisement register, it will affect the state of a EEE capability
> register. Which break IEEE 802.3 specification and the reason why
> ksz9477_get_features() actually exist. But can be used as workaround
> if it is written early enough before PHYlib tried to read EEE
> capability register.
>=20
> Please confirm my assumption by applying your workaround and testing
> it with ethtool --show-eee lanX.
>=20

# ethtool --show-eee lan1
EEE Settings for lan1:
        EEE status: disabled
        Tx LPI: 0 (us)
        Supported EEE link modes:  100baseT/Full=20
                                   1000baseT/Full=20
        Advertised EEE link modes:  Not reported
        Link partner advertised EEE link modes:  Not reported
#=20
# ethtool --show-eee lan2
EEE Settings for lan2:
        EEE status: disabled
        Tx LPI: 0 (us)
        Supported EEE link modes:  100baseT/Full=20
                                   1000baseT/Full=20
        Advertised EEE link modes:  Not reported
        Link partner advertised EEE link modes:  Not reported


> It should be commented in the code with all kind of warnings:
> Don't move!!! We use one bug to workaround another bug!!!

As I've pointed out in the previous e-mail. This kind of bug cannot be
easily fixed with modifying flags in ksz_get_phy_flags() as this
function is called after ksz9477_get_features().

I'm open for ideas to do it right...

> If PHYlib
> start scanning PHYs before this code is executed, then thing may
> break!!

Is it possible that PHY lib will start scanning for phys before the DSA
switch IC is probed with SPI?

KSZ9477-EVB DTS is not using "mdio" node - i.e. the "old" scheme for DSA
switch is used.

>=20
> ... it is broken as hell....
>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/r8EfiN=D1y4NgEH=TvzF.ZJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTvQuoACgkQAR8vZIA0
zr28MggAiXlqveYPpB1sKH2Tl9fFC0ko55CfeSHMhzvn0yVKX6fEA2+oHzuebFeX
gYvC92NFDA65mDzuM/pBrPK/WJJ67aQei2ofZv/dE8XPWyF4lhcg5gpMw6ZFheW0
xOFgiSWJe3cLDi7HZ2iyCguFKYLP5DWWzYLPwAwoewJkWXDhwStI6o+4j1p63Tm/
7wOUDi8SGosKx99PDB5p7XWBOCDiX7KDmcNGizA2Nkq68Fmq9Mz8fJ1Ars4C4FnQ
L3afFHT2xqEJdPZVt1vNCLGjQOHmZJly8h0gi12cTTwntsqucs1xNe02k4uUfQz1
qOmPA8Aec5UWxEpAJlI7o/0fpqyr1A==
=N+Tp
-----END PGP SIGNATURE-----

--Sig_/r8EfiN=D1y4NgEH=TvzF.ZJ--
