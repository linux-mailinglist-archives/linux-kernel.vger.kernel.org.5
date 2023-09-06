Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A4793652
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjIFHdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjIFHdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:33:51 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A27BCE;
        Wed,  6 Sep 2023 00:33:47 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id DC01986523;
        Wed,  6 Sep 2023 09:33:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693985624;
        bh=UJWljPQXvOypFo4WQDXEALB4mYPKGa4dqbtuml8FL+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GNWpdtg8rMITb2SWUiCwvyz8MJ1i72FfPO2TjQFPjmT0x7zZjx4GxCB0pcWP+v/E4
         32U8MEciJrvbCAAyVqXDfhGINrX8YK2NHxWy69svFR5PLAHOTzAbi5jlYR0Cj/Z1kF
         wJQBCEogH1UuFn3mUnEMUrPnLi/s8f9q9BR+8amyqjTpcTQMJJsoic12rKMNHQpBD9
         UE1Z0gPldaoWahMt5jRmFUFuLnMp7OKpEsaPmB5dzoYmlXI0CZrqmwU0Vrq2XDjv8Z
         sLl8F2VhUh+OFHy1SouhMd49QyzKPN9hYLRYM1LAFhTVEVVnnOUtFclc7nnE8Wyl/k
         jUEn1TlEr6Osw==
Date:   Wed, 6 Sep 2023 09:33:34 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net v4] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230906093334.74aac85b@wsk>
In-Reply-To: <20230905134828.74d37681@kernel.org>
References: <20230905093315.784052-1-lukma@denx.de>
        <20230905134828.74d37681@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jjjZ/WFFogDTusqEuJSt00V";
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

--Sig_/jjjZ/WFFogDTusqEuJSt00V
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Tue,  5 Sep 2023 11:33:15 +0200 Lukasz Majewski wrote:
> > Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support")
> > (for KSZ9477).
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> No need to repost for just this, but if there is a v5:

I hope that this is the last version of this errata patch ... :-)

>  - no empty line between Fixes and other tags
>  - add the comment after '#' i.e.:
>=20
> Fixes: 69d3b36ca045 ("net: dsa: microchip: enable EEE support") # for
> KSZ9477

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/jjjZ/WFFogDTusqEuJSt00V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT4K04ACgkQAR8vZIA0
zr2dBwgAwM58TG28ruHADpUY69jG54PGuCvuswRUucdN46TXDJGKJ3h/dHl7LVps
MdKZJbYDgBDR+F2a53oqVoqbtj5m2ZjGz+ImTVHij+CqOnmf4SUnwsVl5a9/fC0O
egmVyEG2IVX4Xj8IEmN7tJJIIXrnivWQ0Lb1fFJkWD/nl5oBms68FniY1F354EFy
LaapwhsYsPt3RQTRPI2O0NxukQaTX+/WnaNFOJ9wMi1H3v98fsCJ2yx0p+Q2d+ai
fxnhcr82AfP++DPSnHyHpqFBusrLUVwnESNYYsLkK+i0MgyyThNj1vTbM/5f+4m4
Vtr5xbszy7QoPoX2wQJymaZDk9OY/w==
=4rbo
-----END PGP SIGNATURE-----

--Sig_/jjjZ/WFFogDTusqEuJSt00V--
