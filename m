Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89778E965
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 11:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbjHaJ33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 05:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238163AbjHaJ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:29:28 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79847CEA;
        Thu, 31 Aug 2023 02:29:24 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 3D11B86556;
        Thu, 31 Aug 2023 11:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693474162;
        bh=1D3Qgb3Pi6YnUtvh04RQFkgAJbK1KQQ0PEsZIO0c6W0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N3DCE24p+3/frfNRwhmRtciInUxjmkqmRSCmPmqUQbcs3zYhieAAGHm4o7av1k+eC
         Op15I/GeshFQJ0X5IRpLfVG3fWAM6VYuKLWxd4yxcEXiud3+uNwptYv+d0qYbFtCEW
         I0lQYu/fnkib38Clj1tnqQ/q+m9o57Ui5OXPiyoWbvmt/eT/cdrAXGVVom04UNl29p
         w1oBCHRjdDf2nN6ZnRn/YntmMaJi3s8Dl2zI+Qbj6gULmFMxLMQCVMS2hfFAAv78a0
         FcqwMDCtKS2j+OQ8cjIve+ZqbBk/JcipuI0+Qzh1vwJFi1OxdEDkfDAnwT2DCoo9UR
         CFgq4iEdsrVqg==
Date:   Thu, 31 Aug 2023 11:29:15 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] net: dsa: Extend the dsa_switch structure to hold
 info about HSR ports
Message-ID: <20230831112915.5b114379@wsk>
In-Reply-To: <6b4733f4a5bedd465b7ee5ea435dcdaf12a61321.camel@redhat.com>
References: <20230829121132.414335-1-lukma@denx.de>
        <20230829121132.414335-2-lukma@denx.de>
        <6b4733f4a5bedd465b7ee5ea435dcdaf12a61321.camel@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/660TvqHPzRjNY.MftTFaPm.";
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

--Sig_/660TvqHPzRjNY.MftTFaPm.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On Tue, 2023-08-29 at 14:11 +0200, Lukasz Majewski wrote:
> > Information about HSR aware ports in a DSA switch can be helpful
> > when one needs tags to be adjusted before the HSR frame is sent.
> >=20
> > For example - with ksz9477 switch - the TAG needs to be adjusted to
> > have both HSR ports marked in tag to allow execution of HW based
> > frame duplication.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  include/net/dsa.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >=20
> > diff --git a/include/net/dsa.h b/include/net/dsa.h
> > index d309ee7ed04b..15274afc42bb 100644
> > --- a/include/net/dsa.h
> > +++ b/include/net/dsa.h
> > @@ -470,6 +470,9 @@ struct dsa_switch {
> >  	/* Number of switch port queues */
> >  	unsigned int		num_tx_queues;
> > =20
> > +	/* Bitmask indicating ports supporting HSR */
> > +	u16                     hsr_ports;
> > +
> >  	/* Drivers that benefit from having an ID associated with
> > each
> >  	 * offloaded LAG should set this to the maximum number of
> >  	 * supported IDs. DSA will then maintain a mapping of _at =20
>=20
> Out of sheer ignorance, I think this new field does not belong to
> dsa_switch, at least not in this form. AFAICS there is no current hard
> limitation on the number of ports a DSA switch can handle at the API
> level, and this will introduce an hard one.
>=20
> I think you are better off keeping this field in the KSZ-specific
> struct.

That was mine first idea - to move it to struct ksz_device from
./drivers/net/dsa/ksz_common.h

However, this file and this struct is not easily accessible from
net/dsa/tag_ksz.c

One idea was to use an exported function - e.g. ksz_get_hsr_ports() and
in it I would read the hsr_ports member ?

Another option would be to loop through all switch ports with
hsr_for_each_port(), but this would affect overall network performance.

> If you really want to keep it here you should remove the above
> limitation somehow (possibly a query op to check if a given port is
> HSR aware???)

I will use the idea of exported helper function to get HSR members
ports.

>=20
> In any case this series looks like net-next material, does not apply
> correctly to net-next and net-next is currently closed. You can share
> a new version as RFC or wait for net-next to re-open in ~2w.
>=20

I will prepare v2 and then adjust it to net-next when required.

> Cheers,
>=20
> Paolo
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/660TvqHPzRjNY.MftTFaPm.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmTwXWsACgkQAR8vZIA0
zr3diQgA3y/D/XBRsPzCT0wKoUyGMoext1WPk/GH4t9IQJAHHVtRZgBU7Y5B1Gh0
ADbhxOxQUOqfR7avWZR6n4S46/3LD2E5xiA9Y36ZtXrxFibDgLhYWtuLiu0mG0nT
eqWcZEKnPl6jpf6V+kGFBJSqGJxlIFKLJW5iBHZEgrAc3FIAu+oVv+0JUnAv9C4d
Kna3Cp4ifwpLd9yGBHVphhXrV4HISoGctpsBCXyNdf6Pqsu/5gxXLF2yPYe+dAUT
uZS2SYYx6cI/HtoMQRVHOK8HQl7jYYZD7TwueuMHBTIhWOE622aR2Ho1S7CCkmKN
GyCG9p1E4hWH89wWXKmx5qZrV117YA==
=YLWD
-----END PGP SIGNATURE-----

--Sig_/660TvqHPzRjNY.MftTFaPm.--
