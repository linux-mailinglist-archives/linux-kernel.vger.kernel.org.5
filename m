Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E7F7D3E72
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjJWSBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJWSBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:01:20 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45496FF;
        Mon, 23 Oct 2023 11:01:15 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7903A1C006F; Mon, 23 Oct 2023 20:01:13 +0200 (CEST)
Date:   Mon, 23 Oct 2023 20:01:12 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/202] 5.10.199-rc1 review
Message-ID: <ZTa06NblVeww8aQy@duo.ucw.cz>
References: <20231023104826.569169691@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3ugybp7DnIbwL4nr"
Content-Disposition: inline
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ugybp7DnIbwL4nr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.199 release.
> There are 202 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.

This does not build in our configs:

  AR      drivers/pci/controller/mobiveil/built-in.a
2158  CC      drivers/pci/controller/pci-mvebu.o
2159  CC      net/core/failover.o
2160drivers/gpio/gpio-vf610.c:249:11: error: 'IRQCHIP_IMMUTABLE' undeclared=
 here (not in a function); did you mean 'IS_IMMUTABLE'?
2161  249 |  .flags =3D IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
2162      |           ^~~~~~~~~~~~~~~~~
2163      |           IS_IMMUTABLE
2164drivers/gpio/gpio-vf610.c:251:2: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS'=
 undeclared here (not in a function)
2165  251 |  GPIOCHIP_IRQ_RESOURCE_HELPERS,
2166      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2167drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct ini=
tializer
2168drivers/gpio/gpio-vf610.c:251:2: note: (near initialization for 'vf610_=
irqchip')
2169  CC      fs/ubifs/misc.o
2170drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
2171drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of functio=
n 'gpio_irq_chip_set_chip' [-Werror=3Dimplicit-function-declaration]
2172  340 |  gpio_irq_chip_set_chip(girq, &vf610_irqchip);
2173      |  ^~~~~~~~~~~~~~~~~~~~~~
2174cc1: some warnings being treated as errors
2175make[2]: *** [scripts/Makefile.build:286: drivers/gpio/gpio-vf610.o] Er=
ror 1
2176make[2]: *** Waiting for unfinished jobs....
2177  CC      kernel/kexec_core.o

And same error in other config:

  CC      fs/fat/dir.o
1116  CC      crypto/md4.o
1117drivers/gpio/gpio-vf610.c:249:11: error: 'IRQCHIP_IMMUTABLE' undeclared=
 here (not in a function); did you mean 'IS_IMMUTABLE'?
1118  249 |  .flags =3D IRQCHIP_IMMUTABLE | IRQCHIP_MASK_ON_SUSPEND
1119      |           ^~~~~~~~~~~~~~~~~
1120      |           IS_IMMUTABLE
1121drivers/gpio/gpio-vf610.c:251:2: error: 'GPIOCHIP_IRQ_RESOURCE_HELPERS'=
 undeclared here (not in a function)
1122  251 |  GPIOCHIP_IRQ_RESOURCE_HELPERS,
1123      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1124drivers/gpio/gpio-vf610.c:251:2: warning: excess elements in struct ini=
tializer
1125drivers/gpio/gpio-vf610.c:251:2: note: (near initialization for 'vf610_=
irqchip')
1126drivers/gpio/gpio-vf610.c: In function 'vf610_gpio_probe':
1127drivers/gpio/gpio-vf610.c:340:2: error: implicit declaration of functio=
n 'gpio_irq_chip_set_chip' [-Werror=3Dimplicit-function-declaration]
1128  340 |  gpio_irq_chip_set_chip(girq, &vf610_irqchip);
1129      |  ^~~~~~~~~~~~~~~~~~~~~~
1130cc1: some warnings being treated as errors
1131  CC      fs/fat/fatent.o

Details are here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3ugybp7DnIbwL4nr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZTa06AAKCRAw5/Bqldv6
8obNAJ9rnwXyNvwPTzZE8ggtKdiokP1fowCcDUEavfiIIlUH8v3lxietTVbtTdw=
=dBQj
-----END PGP SIGNATURE-----

--3ugybp7DnIbwL4nr--
