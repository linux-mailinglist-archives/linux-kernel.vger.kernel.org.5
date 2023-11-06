Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCA17E2EF3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjKFVa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjKFVaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:30:24 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70B9D6E;
        Mon,  6 Nov 2023 13:30:20 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 24F1D1C0070; Mon,  6 Nov 2023 22:30:18 +0100 (CET)
Date:   Mon, 6 Nov 2023 22:30:17 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
Message-ID: <ZUla6RAd3LMyHZ9G@duo.ucw.cz>
References: <20231106130304.678610325@linuxfoundation.org>
 <8aec1bd5-befc-486c-9e47-7571b937b8c7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SlteEoC60KSBKHNT"
Content-Disposition: inline
In-Reply-To: <8aec1bd5-befc-486c-9e47-7571b937b8c7@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SlteEoC60KSBKHNT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This is the start of the stable review cycle for the 5.10.200 release.
> > There are 95 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> > Anything received after that time might be too late.
> >=20
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.=
200-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.g=
it linux-5.10.y
> > and the diffstat can be found below.
>=20
> There seems to be a problem building for RISC-V with GCC 8, 12, and Clang=
 17. This is with defconfig, allnoconfig, tinyconfig:
>=20
> -----8<-----
> /builds/linux/drivers/irqchip/irq-riscv-intc.c: In function 'riscv_intc_i=
nit':
> /builds/linux/drivers/irqchip/irq-riscv-intc.c:119:17: error: implicit de=
claration of function 'fwnode_dev_initialized'; did you mean 'zone_is_initi=
alized'? [-Werror=3Dimplicit-function-declaration]
>   119 |                 fwnode_dev_initialized(of_fwnode_handle(node), tr=
ue);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~
>       |                 zone_is_initialized
> cc1: some warnings being treated as errors
> make[3]: *** [/builds/linux/scripts/Makefile.build:286: drivers/irqchip/i=
rq-riscv-intc.o] Error 1
> make[3]: Target '__build' not remade because of errors.
> make[2]: *** [/builds/linux/scripts/Makefile.build:503: drivers/irqchip] =
Error 2
> make[2]: Target '__build' not remade because of errors.
> make[1]: *** [/builds/linux/Makefile:1832: drivers] Error 2
> make[1]: Target '__all' not remade because of errors.
> make: *** [Makefile:192: __sub-make] Error 2
> make: Target '__all' not remade because of errors.
> ----->8-----

We see same problems in our risc-v build:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/546849=
2319

> Currently bisecting.

Thank you!

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--SlteEoC60KSBKHNT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZUla6QAKCRAw5/Bqldv6
8sEcAJ9mFWtNIHn1WL1ES3oJMB3QbtUh3QCfYXOqshd6mrKwsY02B4hDExKfLQk=
=LsI3
-----END PGP SIGNATURE-----

--SlteEoC60KSBKHNT--
