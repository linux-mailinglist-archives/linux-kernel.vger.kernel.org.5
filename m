Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3895379BBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376761AbjIKWU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240984AbjIKO64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:58:56 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68893E40;
        Mon, 11 Sep 2023 07:58:51 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5071486D90;
        Mon, 11 Sep 2023 16:58:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694444329;
        bh=NlBBt43y5lcwH7fnaA3d3KUuzCDKemg3sKPBS708Mrw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=He1TXX+EAZe1usILniqW6VQSOdzi7OYtwLssN1I1Nrmb9c46eT6pMyoaU9CCxq0OX
         68XjhamzGoIUblIkeUnyVMqfs6m4kdt0uQsJgq9kcGCIHoGYeJ9sGDgfEnzYRUm3Pe
         uIKiNvglsoee6/t4XMVP7PoiayhT4Hgffy4UgDAFYncB3kd/vSkLPkdjO+taGW008R
         J2+drsi2egK2QPoCbhF+hXZEYlFarleswdnE6dxtcTBq4JucFI8sN+cNOVWhBeo/Aw
         MVXhddKIMyZ9sEtRh7aKO9JrzaHrNGdN22Ld26UXDRrhda//iVXzUfhkoQantP+U0n
         0Rn6q4wPy855Q==
Date:   Mon, 11 Sep 2023 16:58:48 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW
 offloading for KSZ9477
Message-ID: <20230911165848.0741c03c@wsk>
In-Reply-To: <20230906152801.921664-1-lukma@denx.de>
References: <20230906152801.921664-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/l1xVNpnAFR9tiKENrOB14ys";
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

--Sig_/l1xVNpnAFR9tiKENrOB14ys
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear Community,

> This patch series provides support for HSR HW offloading in KSZ9477
> switch IC.
>=20
> To test this feature:
> ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45
> version 1 ip link set dev lan1 up
> ip link set dev lan2 up
> ip a add 192.168.0.1/24 dev hsr0
> ip link set dev hsr0 up
>=20
> To remove HSR network device:
> ip link del hsr0
>=20
> It is also possible to create another HSR interface, but it will
> only support HSR is software - e.g.
> ip link add name hsr1 type hsr slave1 lan3 slave2 lan4 supervision 45
> version 1
>=20
> Test HW:
> Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".
>=20
> Performance SW used:
> nuttcp -S --nofork
> nuttcp -vv -T 60 -r 192.168.0.2
> nuttcp -vv -T 60 -t 192.168.0.2
>=20
> Code: v6.5-rc7 Linux repository
> Tested HSR v0 and v1
> Results:
> With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
> With no offloading 		       RX: 63 Mbps  TX: 63 Mbps
>=20
>=20
> Lukasz Majewski (2):
>   net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
>   net: dsa: hsr: Enable in KSZ9477 switch HW HSR offloading
>=20
>  drivers/net/dsa/microchip/ksz9477.c    | 81
> ++++++++++++++++++++++++++ drivers/net/dsa/microchip/ksz9477.h    |
> 2 + drivers/net/dsa/microchip/ksz_common.c | 76
> ++++++++++++++++++++++++ drivers/net/dsa/microchip/ksz_common.h |  3 +
>  net/dsa/tag_ksz.c                      |  8 +++
>  5 files changed, 170 insertions(+)
>=20


Are there any comments regarding this new revision of the HSR support
for KSZ9477 switch?

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/l1xVNpnAFR9tiKENrOB14ys
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmT/KygACgkQAR8vZIA0
zr3D9gf/b+7FlEt0P70xpGzznuBH+xSxzGUPSwSHARy2wlLTNLTPM5RdP8qFIS8B
j82vP1JNb+nb/AqLlr61kgASyyo7NVdWSmXq+1F68UqfsChS714O6zgt1w2Hl3YI
3kPpR0ZYTMv1r3G0iiLIXmhTzKUBJ7lshxADI5vMlWdG8qhaSnS/X6KlQ/rtO5UJ
pnwdn4rfZtti0YU6UNBHeqltF25tPlot0Se2z6sAIisp6hNjhKF3cItHF4M646Z/
tbLJAd3S607I2QmhFKuAN1rhHk5Hd9UiMQvwEtCw/jS0jp0aD6wuxc/FX8P/sAqg
EKofoXbT8NvfQFtOf3YWW0b50TUeBw==
=9srb
-----END PGP SIGNATURE-----

--Sig_/l1xVNpnAFR9tiKENrOB14ys--
