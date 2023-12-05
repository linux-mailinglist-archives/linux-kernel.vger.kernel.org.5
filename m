Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9681580503D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 11:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbjLEKf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 05:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjLEKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 05:35:24 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63F109;
        Tue,  5 Dec 2023 02:35:29 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9C7FE1C007F; Tue,  5 Dec 2023 11:35:27 +0100 (CET)
Date:   Tue, 5 Dec 2023 11:35:27 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/107] 6.1.66-rc1 review
Message-ID: <ZW78708vOccgxX1P@duo.ucw.cz>
References: <20231205031531.426872356@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nNEJpFFVy8/6pjhj"
Content-Disposition: inline
In-Reply-To: <20231205031531.426872356@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nNEJpFFVy8/6pjhj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.66 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

We see build failure on risc-v:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/568005=
0135

  AR      drivers/nvmem/built-in.a
2686In file included from ./arch/riscv/include/asm/ptrace.h:10,
2687                 from ./arch/riscv/include/uapi/asm/bpf_perf_event.h:5,
2688                 from ./include/uapi/linux/bpf_perf_event.h:11,
2689                 from ./include/linux/perf_event.h:18,
2690                 from ./include/linux/perf/riscv_pmu.h:12,
2691                 from drivers/perf/riscv_pmu_sbi.c:14:
2692drivers/perf/riscv_pmu_sbi.c: In function 'pmu_sbi_ovf_handler':
2693drivers/perf/riscv_pmu_sbi.c:582:40: error: 'riscv_pmu_irq_num' undecla=
red (first use in this function); did you mean 'riscv_pmu_irq'?
2694  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
2695      |                                        ^~~~~~~~~~~~~~~~~
2696./arch/riscv/include/asm/csr.h:400:45: note: in definition of macro 'cs=
r_clear'
2697  400 |         unsigned long __v =3D (unsigned long)(val);            =
   \
2698      |                                             ^~~
2699drivers/perf/riscv_pmu_sbi.c:582:36: note: in expansion of macro 'BIT'
2700  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
2701      |                                    ^~~
2702drivers/perf/riscv_pmu_sbi.c:582:40: note: each undeclared identifier i=
s reported only once for each function it appears in
2703  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
2704      |                                        ^~~~~~~~~~~~~~~~~
2705./arch/riscv/include/asm/csr.h:400:45: note: in definition of macro 'cs=
r_clear'
2706  400 |         unsigned long __v =3D (unsigned long)(val);            =
   \
2707      |                                             ^~~
2708drivers/perf/riscv_pmu_sbi.c:582:36: note: in expansion of macro 'BIT'
2709  582 |                 csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
2710      |                                    ^~~
2711make[3]: *** [scripts/Makefile.build:250: drivers/perf/riscv_pmu_sbi.o]=
 Error 1
2712make[2]: *** [scripts/Makefile.build:500: drivers/perf] Error 2
2713make[2]: *** Waiting for unfinished jobs....
2714  CC      drivers/firmware/efi/earlycon.o
2715

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nNEJpFFVy8/6pjhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZW787wAKCRAw5/Bqldv6
8gOWAJwL8heLPlMLxzxCyYJUolIZ/NkangCeOu/Wu+mI7zBIwEFY6TIEWSj+LYk=
=vpMf
-----END PGP SIGNATURE-----

--nNEJpFFVy8/6pjhj--
