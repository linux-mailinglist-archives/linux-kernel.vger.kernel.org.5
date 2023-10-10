Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0817BF981
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjJJLSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjJJLS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:18:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665ABF4;
        Tue, 10 Oct 2023 04:18:22 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 910C61C006D; Tue, 10 Oct 2023 13:18:19 +0200 (CEST)
Date:   Tue, 10 Oct 2023 13:18:19 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Pavel Machek <pavel@denx.de>
Cc:     wsa+renesas@sang-engineering.com,
        niklas.soderlund+renesas@ragnatech.se,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        biju.das.jz@bp.renesas.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris.Paterson2@renesas.com, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: renesas_sdhi problems in 5.10-stable was Re: [PATCH 5.10
 000/226] 5.10.198-rc1 review
Message-ID: <ZSUy+zA0+Chm6dFb@duo.ucw.cz>
References: <20231009130126.697995596@linuxfoundation.org>
 <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
 <ZSRe78MAQwbBdyFP@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="A9Lr04onjTJhAtpN"
Content-Disposition: inline
In-Reply-To: <ZSRe78MAQwbBdyFP@duo.ucw.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A9Lr04onjTJhAtpN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This is the start of the stable review cycle for the 5.10.198 release.
> > > There are 226 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >=20
> > > Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> > > Anything received after that time might be too late.
> >=20
> > 4.14, 4.19 and 6.1 tests ok, 5.10 seems to have problems:
>=20
> Guessing from stack traces, these may be relevant:

So bisection reveals these are relevant:

  |e10d3d256 b161d8 o: 5.10| mmc: renesas_sdhi: probe into TMIO after   SCC=
 parameters have been setup

Ok

 |493b70c48 d14ac6 o: 5.10| mmc: renesas_sdhi: populate SCC pointer at  the=
 proper place

Testing now: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipeline=
s/1031822035

 |c508545f4 0d856c o: 5.10| mmc: tmio: support custom irq masks
 |8df1f0639 74f45d o: 5.10| mmc: renesas_sdhi: register irqs before registe=
ring controller

Fail: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/10317=
86077

I should be able to point specific commit with two more tests.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--A9Lr04onjTJhAtpN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSUy+wAKCRAw5/Bqldv6
8l+cAKC5myuJkrwEyf9tCv+eqSAzp44+BACgpL5hAh7OSoSbpIj6nYPrbvMxOZA=
=ZKvd
-----END PGP SIGNATURE-----

--A9Lr04onjTJhAtpN--
