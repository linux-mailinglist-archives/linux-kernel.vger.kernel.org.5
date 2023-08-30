Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EC978DEE9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239560AbjH3TXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbjH3IOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:14:01 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22758113;
        Wed, 30 Aug 2023 01:13:57 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3308480274;
        Wed, 30 Aug 2023 10:13:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693383235;
        bh=+mFU7DD8ePRlmYcxB+4/hAOdsHi4ePNBSIitHx85tT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mmuwb8HP8UgItHG8i6PkxyzV50lmXVwAHjqsnj/irTiZPE56rkVDqpE5Ek8cAvAt8
         2XdoPxxPdwQ5QHfgGiVwZVL5NJXnuSqzaAQDYJGEMPNjPs6wZRYv+EVcGJ96gyjPHo
         B4Ik/0oJz9jICQBxlRAVU2WlMT4xKUDPe+q6bXxdhagrtMsmVK0gQVEUXJWcfYs9ta
         tqgPKTzOZgEuYB0U9JM5dfgrl0YzMiyyimy9GCQjAdx1GvlwF/Ns2hl4Vtd7e8B2Yc
         Bb9Sx2xTvbwKHUlA7BZ0L3Rx0BLY0BrVWA/vl/2t7JaU8MfsYOGz6/sVS3g2j3MObw
         ZUXSjV/s9xMow==
Date:   Wed, 30 Aug 2023 10:13:47 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Tristram.Ha@microchip.com, olteanv@gmail.com,
        linux@rempel-privat.de, Arun.Ramadoss@microchip.com,
        f.fainelli@gmail.com, andrew@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, Woojung.Huh@microchip.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477
 errata (DS80000754C)
Message-ID: <20230830101347.0f2aad73@wsk>
In-Reply-To: <20230830061626.GF31399@pengutronix.de>
References: <20230826104910.voaw3ndvs52yoy2v@skbuf>
        <20230829103533.7966f332@wsk>
        <20230829101851.435pxwwse2mo5fwi@skbuf>
        <20230829132429.529283be@wsk>
        <20230829114739.GC31399@pengutronix.de>
        <20230829143829.68410966@wsk>
        <20230829144209.GD31399@pengutronix.de>
        <20230829172913.518210b0@wsk>
        <20230829171205.GE31399@pengutronix.de>
        <BYAPR11MB3558DDEACCFE005DA1D41CDCECE7A@BYAPR11MB3558.namprd11.prod.outlook.com>
        <20230830061626.GF31399@pengutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8iJol8LLxRQX+TMNVMkgaqO";
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

--Sig_/8iJol8LLxRQX+TMNVMkgaqO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

> On Tue, Aug 29, 2023 at 10:23:26PM +0000, Tristram.Ha@microchip.com
> wrote:
> > > Yes, removing linkmod_and() will not should not help. I said, "The
> > > phydev->supported_eee should be cleared."
> > >=20
> > > For example like this:
> > > --- a/drivers/net/phy/micrel.c
> > > +++ b/drivers/net/phy/micrel.c
> > > @@ -1400,6 +1400,7 @@ static int ksz9131_config_aneg(struct
> > > phy_device *phydev)
> > >=20
> > >  static int ksz9477_get_features(struct phy_device *phydev)
> > >  {
> > > +       __ETHTOOL_DECLARE_LINK_MODE_MASK(zero) =3D { 0, };
> > >         int ret;
> > >=20
> > >         ret =3D genphy_read_abilities(phydev);
> > > @@ -1413,7 +1414,7 @@ static int ksz9477_get_features(struct
> > > phy_device *phydev)
> > >          * KSZ8563R should have 100BaseTX/Full only.
> > >          */
> > >         linkmode_and(phydev->supported_eee, phydev->supported,
> > > -                    PHY_EEE_CAP1_FEATURES);
> > > +                    zero);
> > >=20
> > >         return 0;
> > >  }
> > >=20
> > > You will need to clear it only on KSZ9477 variants with this bug.
> > > This change is tested and it works on my KSZ9477-EVB. =20
> > =20
> > I think this is best for disabling EEE support.
> > I think before some customers asked for Ethtool EEE support not
> > because they want to use it but to disable it because of link
> > instability. KSZ9893/KSZ9563 switches should have the same problem.
> >  The EEE problem depends on the link partner.  For example my
> > laptop does not have problem even though EEE is enabled, although I
> > am not sure if EEE is really active.  The problem here is just
> > using two KSZ9477 switches and programming those PHY setup values
> > and enabling EEE will make the link unstable.  Management decided
> > to disable EEE feature to avoid customer support issues.
> > Another issue is EEE should be disabled when using 1588 PTP.
> >  =20
>=20
> I'd like to share my thoughts on the concerns raised:
>=20
> - KSZ9477 & EEE: Disabling EEE for the KSZ9477 makes sense,
> especially since the datasheet doesn't list it as supported.
>=20

+1

I will prepare proper patch

> - EEE Support for KSZ9893 & KSZ9563: The datasheets for the KSZ9893
> indicate support for EEE. The erratum recommends making adjustments
> to the "transmit Refresh Time for Waketx to meet the IEEE Refresh
> Time specification" instead of turning it off completely. The same
> applies to KSZ9563. We should consider these adjustments.
>=20
> - General Experience with KSZ Chips*: From my experience with these
> chips, irrespective of the EEE functionality, only the 1000/full and
> 100/full link modes tend to be stable enough.
>=20
> - Responsibility to Customers and Certifications: As a part of the
> product supply chain, I believe in our commitment to honesty with our
> customers. When we select components for end products, we trust their
> listed features. For instance, designing for ENERGY STAR
> certification requires that all copper-based physical network ports
> in an LNE product must be compliant with IEEE 802.3 Clause 78, which
> mandates Energy Efficient Ethernet. If Microchip promotes a KSZ* chip
> with EEE as a feature, it becomes a cornerstone of the end product.
> Negating a key functionality, which was sold and then incorporated
> into the product, could risk non-compliance with certification
> criteria.
>=20
> - Consistency in Product Representation: If the overarching company
> decision is to disable the EEE feature for all chips to preempt
> potential customer support issues, our product information should
> mirror this change. It's crucial that we neither misrepresent nor
> over-promise on features. Your deeper insights, given your
> involvement with Microchip's strategy, would be most enlightening.
>=20

For the last two - at least the KSZ9477 Errata was clear about the
issue. Other (switch IC) vendors have even problems to admit that
something is wrong with their silicon design...

> Regards,
> Oleksij




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/8iJol8LLxRQX+TMNVMkgaqO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTu+jsACgkQAR8vZIA0
zr33AwgAw10PcBeJ75ZUx46FN4xfGugdqpKnq4OacPNQh/C2moRKWgaxUGFYovb0
4ZDuzp8P7CNL83p1SSETWHzy5rN6CihH9vMaHb5Imwo9l/k9fv7hRr/BbCwLBzoF
jzN5qu0aVwrXePo4fMjlrYE7Bsa9eYr5VgdvMd1uuZIsco98WI4kIkeNDNbQM2b6
nIt6PWZHJYNjiMwlRMSZ2W04Q6xEO3/Gdw3LN4q+UysoYIrSu0a+BCrkDxdMaWBf
4qgh7klA2078xK42r0XxTFhhhmfhmOG7xJ+u6xNDBLxPW68MU/ziId0m/V23ahjB
XcKrfrM1U2ThE9lm5YXqYTQ+KLQqZA==
=QcwB
-----END PGP SIGNATURE-----

--Sig_/8iJol8LLxRQX+TMNVMkgaqO--
