Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0F67BEAA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378416AbjJITd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377727AbjJITd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:33:27 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C78A4;
        Mon,  9 Oct 2023 12:33:24 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DCAD41C006C; Mon,  9 Oct 2023 21:33:22 +0200 (CEST)
Date:   Mon, 9 Oct 2023 21:33:22 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris.Paterson2@renesas.com
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/226] 5.10.198-rc1 review
Message-ID: <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
References: <20231009130126.697995596@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+7JMdyyWGl6EnF8R"
Content-Disposition: inline
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+7JMdyyWGl6EnF8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.198 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.

4.14, 4.19 and 6.1 tests ok, 5.10 seems to have problems:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
030540843

Lets see arm64_defconfig:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/525461=
0954

=2E..and this seems  to be real failure:

https://lava.ciplatform.org/scheduler/job/1018088

[   62.871632] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
[   62.874253] rcar-dmac e6700000.dma-controller: deferred probe timeout, i=
gnoring dependency
[   62.889345] rcar-dmac e7300000.dma-controller: deferred probe timeout, i=
gnoring dependency
[   62.892139] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000018
[   62.901256] rcar-dmac e7310000.dma-controller: deferred probe timeout, i=
gnoring dependency
[   62.906431] Mem abort info:
[   62.906438]   ESR =3D 0x96000004
[   62.917751] rcar-dmac ec700000.dma-controller: deferred probe timeout, i=
gnoring dependency
[   62.920548]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   62.920551]   SET =3D 0, FnV =3D 0
[   62.920554]   EA =3D 0, S1PTW =3D 0
[   62.920559] Data abort info:
[   62.927031] renesas_sdhi_internal_dmac ee100000.mmc: mmc1 base at 0x0000=
0000ee100000, max clock rate 200 MHz
[   62.931976] rcar-dmac ec720000.dma-controller: deferred probe timeout, i=
gnoring dependency
[   62.934138]   ISV =3D 0, ISS =3D 0x00000004
[   62.934145]   CM =3D 0, WnR =3D 0
[   62.940844] ravb e6800000.ethernet: deferred probe timeout, ignoring dep=
endency
[   62.943210] [0000000000000018] user address but active_mm is swapper
[   62.943221] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   62.954866] ravb e6800000.ethernet eth0: Base address at 0xe6800000, fc:=
28:99:92:7b:e0, IRQ 118.
[   62.961296] Modules linked in:
[   62.961313] CPU: 5 PID: 135 Comm: kworker/u12:2 Not tainted 5.10.198-rc1=
-g18c65c1b4996 #1
[   63.007289] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
[   63.013658] Workqueue: events_unbound async_run_entry_fn
[   63.018971] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=3D--)
[   63.024982] pc : renesas_sdhi_reset_scc+0x94/0xe0
[   63.029681] lr : renesas_sdhi_reset_scc+0x60/0xe0
[   63.034379] sp : ffff800012353ab0
[   63.037688] x29: ffff800012353ab0 x28: ffff80001110b2c0=20
[   63.042998] x27: 0000000000000000 x26: ffff0005c03f6e80=20
[   63.048308] x25: ffff0005c11c7a90 x24: ffff0005c0822010=20
[   63.053618] x23: ffff0005c0822000 x22: ffff0005c08221d0=20
[   63.058928] x21: ffff0005c11c7a80 x20: 0000000000000020

Let's see bbb_defconfig:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/525461=
1119

Fails:

https://lava.ciplatform.org/scheduler/job/1018083

bootz 0x82000000 - 0x88000000
zimage: Bad magic!
bootloader-commands timed out after 281 seconds
end: 2.4.3 bootloader-commands (duration 00:04:41) [common]

Not sure about this one.

Lets see arm_shmobile_defconfig:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/525461=
1233

That's:

https://lava.ciplatform.org/scheduler/job/1018084

Seems similar to previous failure:

2.092944] usbcore: registered new interface driver usbhid
[    2.098710] sh_mobile_sdhi ee140000.mmc: Got CD GPIO
[    2.103206] usbhid: USB HID core driver
[    2.108224] sh_mobile_sdhi ee140000.mmc: Got WP GPIO
[    2.124168] 8<--- cut here ---
[    2.124476] sgtl5000 0-000a: sgtl5000 revision 0x11
[    2.127222] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000c
[    2.127228] pgd =3D (ptrval)
[    2.140755] rcar_sound ec500000.sound: probed
[    2.142917] [0000000c] *pgd=3D00000000
[    2.147915] NET: Registered protocol family 10
[    2.150849] Internal error: Oops: 5 [#1] SMP ARM
[    2.155700] sh_mmcif ee200000.mmc: Chip version 0x0003, clock rate 12MHz
[    2.159894] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.10.198-rc1-g1=
8c65c1b4996 #1
[    2.174486] Hardware name: Generic RZ/G1 (Flattened Device Tree)
[    2.174540] Segment Routing with IPv6
[    2.180501] Workqueue: events_unbound async_run_entry_fn
[    2.184234] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.189455] PC is at renesas_sdhi_reset_scc+0x34/0x50
[    2.189462] LR is at sd_ctrl_write16+0x30/0x48
[    2.195810] NET: Registered protocol family 17
[    2.200409] pc : [<c05da960>]    lr : [<c05da754>]    psr: 60000013
[    2.200415] sp : c10a9e30  ip : 00000024  fp : c11b3cc0
[    2.204877] can: controller area network core
[    2.209282] r10: c11ae410  r9 : c11ae400  r8 : c18e9d48
[    2.209288] r7 : fffffe00  r6 : c18e9d48  r5 : c18e9d40  r4 : c1970b80
[    2.215590] NET: Registered protocol family 29
[    2.220759] r3 : 0000000c  r2 : 00000006  r1 : 00000001  r0 : 00000000
[    2.225117] can: raw protocol
[    2.230322] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[    2.236848] can: broadcast manager protocol

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+7JMdyyWGl6EnF8R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSRVggAKCRAw5/Bqldv6
8iUSAJ4zccITOyGdlz5sQNJNYGO6ftZ4TACeKDAlNWbmdERfrC9VmYPkwfBkrMk=
=xitt
-----END PGP SIGNATURE-----

--+7JMdyyWGl6EnF8R--
