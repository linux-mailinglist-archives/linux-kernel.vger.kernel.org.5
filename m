Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2077AB077
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjIVLTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjIVLSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:18:54 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6A6AF;
        Fri, 22 Sep 2023 04:18:47 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C2ECD864D8;
        Fri, 22 Sep 2023 13:18:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695381525;
        bh=S8lFLUYb6/ITBQeQZIMqp9rskdoCgZ5dcb217rGxg+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g4t6VHxQvJBWkBGEr7pSoX0XGQ3tG4Qq4iQXCimVN1rhhhjVQykwIgTJV/5s9YQDb
         YlJytUt8xz4eO+1d/vED3v5I+eo+CXkS9PK+7w+DCE6Rc9W34QYg0kOasgT3ubefMH
         A/kH4FBaGt5KcYjugt9DcABTcCVOHVF27jGIkbrqI/UzSeAsL8beynmazf/nXyix2q
         Sk6JjLjANPWaPdlqs4pzxnMaCJJezsufqMLX/HUc0AP5CO/N0UZr4v2c2PVPQBIxu8
         GJgOLvuR/B6Qwmmpykn+qY1tp9VSXOMaXwXJtrWEg/1/HQMunxK08anf0xDe+Ls9Hn
         TUxG21DW7l4Tg==
Date:   Fri, 22 Sep 2023 13:18:38 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading
 for KSZ9477
Message-ID: <20230922131838.4bab19e7@wsk>
In-Reply-To: <20230921192308.kntudhbwc4j4skza@skbuf>
References: <20230920114343.1979843-1-lukma@denx.de>
        <20230921192308.kntudhbwc4j4skza@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W/QH=Z2ZwCA8YgznjhLPoFi";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W/QH=Z2ZwCA8YgznjhLPoFi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> Hi Lukasz,
>=20
> On Wed, Sep 20, 2023 at 01:43:38PM +0200, Lukasz Majewski wrote:
> > Code: v6.6.0-rc1+ Linux repository =20
>=20
> Your patches conflict with Oleksij's ACL patches, merged on the 14th
> of September.
> https://patchwork.kernel.org/project/netdevbpf/patch/20230914131145.23336=
-1-o.rempel@pengutronix.de/
>=20
> Please always submit patches formatted on the most recent tip of the
> "main" branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git

By mistake my net-next repo was pointing to:
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

Please correct me if I'm wrong but it looks like the net repo for
current mainline fixes...

> at the time of submission, not "v6.6.0-rc1+ Linux repository". There
> is nothing that will be done with patches formatted on older trees.
>=20
> https://patchwork.kernel.org/project/netdevbpf/patch/20230920114343.19798=
43-2-lukma@denx.de/
> netdev/apply 	fail 	Patch does not apply to net-next

However, after fetching net-next - I can apply v5 without issues on top
of it.

SHA1: 5a1b322cb0b7d0d33a2d13462294dc0f46911172
"Merge branch 'mlxsw-multicast'"

https://source.denx.de/linux/linux-ksz9477/-/commits/net-next-ksz-HSR-devel=
-v5?ref_type=3Dheads
Linux version from `uname -a`: 6.6.0-rc2+

However, it looks like I would need to prepare v6 anyway...

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/W/QH=Z2ZwCA8YgznjhLPoFi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUNeA4ACgkQAR8vZIA0
zr2tlgf9GNGUt+Fh7VYnv++mOiurxVXYHgW9iDXRzDeqZC136dngGQAv4tKTvSwS
29HAf7ihx6xbCegqujsyLLPNcwSNWDV3GwkhEbAp16PKqT80i1zBcP11NFJsa+kf
hyzT/07nuu7hiiAUJr+1fMHEKQkXjsTb80uO1mb336voZCLlJOkz6NSBthqBQKhV
TZbhK2eKnb3SHwvLL74fOUYzb+Y6KS7DCxR1UBB3PuSosjZn52NBvoFmb/h2MVR9
EqT78808sgzLfMnJx9dTzrNzin8i6djqPe+5XwQoQI7IPnDNvRp8rB9+a2mhN0+O
Vf9ECoKka5RYVgCJh6aX9an7dGHggQ==
=je3w
-----END PGP SIGNATURE-----

--Sig_/W/QH=Z2ZwCA8YgznjhLPoFi--
