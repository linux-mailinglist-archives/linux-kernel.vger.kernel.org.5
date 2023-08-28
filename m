Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7A78B543
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjH1QU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjH1QUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:20:48 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADE4185;
        Mon, 28 Aug 2023 09:20:40 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 99AD41C0004; Mon, 28 Aug 2023 18:20:38 +0200 (CEST)
Date:   Mon, 28 Aug 2023 18:20:38 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 4.19 000/129] 4.19.293-rc1 review
Message-ID: <ZOzJVveC2YhjBA9d@duo.ucw.cz>
References: <20230828101153.030066927@linuxfoundation.org>
 <CA+G9fYuQXq7-jkL59MMKfRbqqB509T3nQdtcW+4wVW_QRovx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="t7PEBjmXvmbOHmzp"
Content-Disposition: inline
In-Reply-To: <CA+G9fYuQXq7-jkL59MMKfRbqqB509T3nQdtcW+4wVW_QRovx5g@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t7PEBjmXvmbOHmzp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This is the start of the stable review cycle for the 4.19.293 release.
> > There are 129 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patc=
h-4.19.293-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>=20
> Results from Linaro=E2=80=99s test farm.
> Regressions on arm.
>=20
> stable-rc linux-4.19.y arm gcc-12 builds fails with
> following warnings / errors.
>=20
> Build errors:
> --------------
> drivers/bus/ti-sysc.c: In function 'sysc_reset':
> drivers/bus/ti-sysc.c:982:15: error: implicit declaration of function
> 'sysc_read_sysconfig' [-Werror=3Dimplicit-function-declaration]
>   982 |         val =3D sysc_read_sysconfig(ddata);
>       |               ^~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

We see this one, too:

  CC      kernel/kthread.o
1126drivers/bus/ti-sysc.c: In function 'sysc_reset':
1127drivers/bus/ti-sysc.c:982:8: error: implicit declaration of function 's=
ysc_read_sysconfig'; did you mean 'sysc_read_revision'? [-Werror=3Dimplicit=
-function-declaration]
1128  val =3D sysc_read_sysconfig(ddata);
1129        ^~~~~~~~~~~~~~~~~~~
1130        sysc_read_revision
1131  CC      drivers/char/hw_random/omap3-rom-rng.o
1132  CC      fs/readdir.o

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--t7PEBjmXvmbOHmzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZOzJVgAKCRAw5/Bqldv6
8sGYAJ4ufDqWxOYm44vyNUUZS0yCNsdmIQCcC1lWmrgK4yhClD/2za9/oIevXO0=
=ucW/
-----END PGP SIGNATURE-----

--t7PEBjmXvmbOHmzp--
