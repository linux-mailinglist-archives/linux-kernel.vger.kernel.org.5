Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA5679B4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358844AbjIKWNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjIKJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:36:32 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A01DE3;
        Mon, 11 Sep 2023 02:36:17 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 193721C0004; Mon, 11 Sep 2023 11:36:16 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:36:15 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, GONG@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Westphal <fw@strlen.de>, pablo@netfilter.org,
        kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 6/8] netfilter: ebtables: fix fortify
 warnings in size_entry_mwt()
Message-ID: <ZP7fj1LW3YLu2LrM@duo.ucw.cz>
References: <20230908182127.3461199-1-sashal@kernel.org>
 <20230908182127.3461199-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EYwzxsuobC4JVE2D"
Content-Disposition: inline
In-Reply-To: <20230908182127.3461199-6-sashal@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EYwzxsuobC4JVE2D
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit a7ed3465daa240bdf01a5420f64336fee879c09d ]
>=20
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=3Dy, the following
> warning appears:
>=20
> In function =E2=80=98fortify_memcpy_chk=E2=80=99,
>     inlined from =E2=80=98size_entry_mwt=E2=80=99 at net/bridge/netfilter=
/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to =E2=80=98__read_o=
verflow2_field=E2=80=99
> declared with attribute warning: detected read beyond size of field (2nd =
parameter);
> maybe use struct_group()? [-Werror=3Dattribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size=
);
>       |
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is not queued for 4.19. Mistake?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EYwzxsuobC4JVE2D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7fjwAKCRAw5/Bqldv6
8jOPAJ446x9CNCOtOGu8jnKHqakoizjVowCfRJpsAS8y5nIe7eQnbTc+73ASZFY=
=5xRs
-----END PGP SIGNATURE-----

--EYwzxsuobC4JVE2D--
