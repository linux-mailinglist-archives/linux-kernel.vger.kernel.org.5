Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5827AB128
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjIVLr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjIVLrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:47:55 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74E3FB;
        Fri, 22 Sep 2023 04:47:48 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1E0F78646A;
        Fri, 22 Sep 2023 13:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695383267;
        bh=wZ4qEmkgvGBQxuMpDb2RuZll8Or+xcawRQGRdom8Msw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t/Fb1wZRps1aXga8sCjPShIsti8Y3lhvjvRtrxAZVJrQQnNHpgFRdk8NgOx3pCUUU
         ObEC2RstTMui28bHijrOF9KvMeHtPlkKH0GjVbvD/Sp6KRyVHG6/rQrz1ZWNy8Ery9
         6ern9XL6O2Vjgua1p2HzNamZp6RCiKNXjEvTFV/WGqHLVns0FLXXlwSZcDCKlpRw5N
         O44nTJDT8yoyC8SNk1EUKTJcnxnphTYPrZmoZRfMY7QTfyMhD/BzJ0DbnX9xieGyec
         ajwCsY97UTjtauUkgWYFSJ3eqPjmHi0OlaWw2KdnGudrrC1zvdUvs2Cxtq3nLp/+py
         wDYnwCuzELtiw==
Date:   Fri, 22 Sep 2023 13:47:39 +0200
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
Message-ID: <20230922134739.6f55f46d@wsk>
In-Reply-To: <20230922113136.jgfo2waalz2pya6b@skbuf>
References: <20230920114343.1979843-1-lukma@denx.de>
        <20230921192308.kntudhbwc4j4skza@skbuf>
        <20230922131838.4bab19e7@wsk>
        <20230922113136.jgfo2waalz2pya6b@skbuf>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8Zz4y42B9pmx0W0fITOB7ek";
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

--Sig_/8Zz4y42B9pmx0W0fITOB7ek
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

> On Fri, Sep 22, 2023 at 01:18:38PM +0200, Lukasz Majewski wrote:
> > By mistake my net-next repo was pointing to:
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> >=20
> > Please correct me if I'm wrong but it looks like the net repo for
> > current mainline fixes... =20
>=20
> Yes, net.git is for fixes to the current mainline branch, and net-next
> is for new features to be included in mainline during the next merge
> window. They are the same at the beginning of the development cycle
> and then they start to diverge.
>=20
> > However, after fetching net-next - I can apply v5 without issues on
> > top of it.
> >=20
> > SHA1: 5a1b322cb0b7d0d33a2d13462294dc0f46911172
> > "Merge branch 'mlxsw-multicast'"
> >=20
> > https://source.denx.de/linux/linux-ksz9477/-/commits/net-next-ksz-HSR-d=
evel-v5?ref_type=3Dheads
> > Linux version from `uname -a`: 6.6.0-rc2+
> >=20
> > However, it looks like I would need to prepare v6 anyway... =20
>=20
> I don't know. "git rebase" is a bit smarter than "git am" and can
> automatically resolve some conflicts, on which "git am" will simply
> bail out if even the context is not identical. Either way, both
> patchwork and me failed to apply your v5 series on net-next, and the
> patches won't be accepted without build testing.

Ok. I will test them with git am -3


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/8Zz4y42B9pmx0W0fITOB7ek
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmUNftsACgkQAR8vZIA0
zr3YUggA3jZ3lHpn8ZkcF4MmRins1g2DVkXSl71NXa1XaRcAcQeMJrEdCpj6HFkB
ex/zy+QtQkEnkVA+V5ME6lH8C4zd4ezp0sqaDeXstaV2CTt3j1G66STYkV4ELQ5N
aeV2CLxk1y9+QFTCHazhjD4pVeP+0WaLCJxAtelb4PO25WT0SQ7l711Qblas0F4k
HCiAilgpD80GoOMeTwo/Pbe04zQ9fTVyhuAkEliRi47+s1VcbKdErhny+Ccwr8V5
EUlUFk4ifYNni1TMSHd/C+GsLVTiq/z12sTZD1OM0sUeKhDRKiL7FLnSVtMQRd0M
q6RzfYy0MWyvfdnfvBK34I8YiqnAfw==
=CMjG
-----END PGP SIGNATURE-----

--Sig_/8Zz4y42B9pmx0W0fITOB7ek--
