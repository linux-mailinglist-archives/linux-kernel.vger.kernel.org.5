Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A817BEB5C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378556AbjJIUNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378523AbjJIUNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:13:39 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CD2A3;
        Mon,  9 Oct 2023 13:13:37 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 039091C006C; Mon,  9 Oct 2023 22:13:36 +0200 (CEST)
Date:   Mon, 9 Oct 2023 22:13:35 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Pavel Machek <pavel@denx.de>, wsa+renesas@sang-engineering.com,
        niklas.soderlund+renesas@ragnatech.se,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        biju.das.jz@bp.renesas.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris.Paterson2@renesas.com, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: renesas_sdhi problems in 5.10-stable was Re: [PATCH 5.10 000/226]
 5.10.198-rc1 review
Message-ID: <ZSRe78MAQwbBdyFP@duo.ucw.cz>
References: <20231009130126.697995596@linuxfoundation.org>
 <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bqgKRRZNMaEHlqWY"
Content-Disposition: inline
In-Reply-To: <ZSRVgj5AqJbDXqZU@duo.ucw.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NEUTRAL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqgKRRZNMaEHlqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2023-10-09 21:33:22, Pavel Machek wrote:
> Hi!
>=20
> > This is the start of the stable review cycle for the 5.10.198 release.
> > There are 226 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> > Anything received after that time might be too late.
>=20
> 4.14, 4.19 and 6.1 tests ok, 5.10 seems to have problems:

Guessing from stack traces, these may be relevant:

 |e10d3d256 b161d8 o: 5.10| mmc: renesas_sdhi: probe into TMIO after SCC pa=
rameters have been setu\
p
 |493b70c48 d14ac6 o: 5.10| mmc: renesas_sdhi: populate SCC pointer at the =
proper place
 |c508545f4 0d856c o: 5.10| mmc: tmio: support custom irq masks
 |8df1f0639 74f45d o: 5.10| mmc: renesas_sdhi: register irqs before registe=
ring controller

Leaving below for context...

Best regards,
								Pavel

> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
/1030540843
>=20
> Lets see arm64_defconfig:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/5254=
610954
>=20
> ...and this seems  to be real failure:
>=20
> https://lava.ciplatform.org/scheduler/job/1018088
>=20
> [   62.871632] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
> [   62.874253] rcar-dmac e6700000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   62.889345] rcar-dmac e7300000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   62.892139] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000018
> [   62.901256] rcar-dmac e7310000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   62.906431] Mem abort info:
> [   62.906438]   ESR =3D 0x96000004
> [   62.917751] rcar-dmac ec700000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   62.920548]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   62.920551]   SET =3D 0, FnV =3D 0
> [   62.920554]   EA =3D 0, S1PTW =3D 0
> [   62.920559] Data abort info:
> [   62.927031] renesas_sdhi_internal_dmac ee100000.mmc: mmc1 base at 0x00=
000000ee100000, max clock rate 200 MHz
> [   62.931976] rcar-dmac ec720000.dma-controller: deferred probe timeout,=
 ignoring dependency
> [   62.934138]   ISV =3D 0, ISS =3D 0x00000004
> [   62.934145]   CM =3D 0, WnR =3D 0
> [   62.940844] ravb e6800000.ethernet: deferred probe timeout, ignoring d=
ependency
> [   62.943210] [0000000000000018] user address but active_mm is swapper
> [   62.943221] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [   62.954866] ravb e6800000.ethernet eth0: Base address at 0xe6800000, f=
c:28:99:92:7b:e0, IRQ 118.
> [   62.961296] Modules linked in:
> [   62.961313] CPU: 5 PID: 135 Comm: kworker/u12:2 Not tainted 5.10.198-r=
c1-g18c65c1b4996 #1
> [   63.007289] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
> [   63.013658] Workqueue: events_unbound async_run_entry_fn
> [   63.018971] pstate: 20000005 (nzCv daif -PAN -UAO -TCO BTYPE=3D--)
> [   63.024982] pc : renesas_sdhi_reset_scc+0x94/0xe0
> [   63.029681] lr : renesas_sdhi_reset_scc+0x60/0xe0
> [   63.034379] sp : ffff800012353ab0
> [   63.037688] x29: ffff800012353ab0 x28: ffff80001110b2c0=20
> [   63.042998] x27: 0000000000000000 x26: ffff0005c03f6e80=20
> [   63.048308] x25: ffff0005c11c7a90 x24: ffff0005c0822010=20
> [   63.053618] x23: ffff0005c0822000 x22: ffff0005c08221d0=20
> [   63.058928] x21: ffff0005c11c7a80 x20: 0000000000000020
>=20
> Let's see bbb_defconfig:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/5254=
611119
>=20
> Fails:
>=20
> https://lava.ciplatform.org/scheduler/job/1018083
>=20
> bootz 0x82000000 - 0x88000000
> zimage: Bad magic!
> bootloader-commands timed out after 281 seconds
> end: 2.4.3 bootloader-commands (duration 00:04:41) [common]
>=20
> Not sure about this one.
>=20
> Lets see arm_shmobile_defconfig:
>=20
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/5254=
611233
>=20
> That's:
>=20
> https://lava.ciplatform.org/scheduler/job/1018084
>=20
> Seems similar to previous failure:
>=20
> 2.092944] usbcore: registered new interface driver usbhid
> [    2.098710] sh_mobile_sdhi ee140000.mmc: Got CD GPIO
> [    2.103206] usbhid: USB HID core driver
> [    2.108224] sh_mobile_sdhi ee140000.mmc: Got WP GPIO
> [    2.124168] 8<--- cut here ---
> [    2.124476] sgtl5000 0-000a: sgtl5000 revision 0x11
> [    2.127222] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000c
> [    2.127228] pgd =3D (ptrval)
> [    2.140755] rcar_sound ec500000.sound: probed
> [    2.142917] [0000000c] *pgd=3D00000000
> [    2.147915] NET: Registered protocol family 10
> [    2.150849] Internal error: Oops: 5 [#1] SMP ARM
> [    2.155700] sh_mmcif ee200000.mmc: Chip version 0x0003, clock rate 12M=
Hz
> [    2.159894] CPU: 1 PID: 7 Comm: kworker/u4:0 Not tainted 5.10.198-rc1-=
g18c65c1b4996 #1
> [    2.174486] Hardware name: Generic RZ/G1 (Flattened Device Tree)
> [    2.174540] Segment Routing with IPv6
> [    2.180501] Workqueue: events_unbound async_run_entry_fn
> [    2.184234] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    2.189455] PC is at renesas_sdhi_reset_scc+0x34/0x50
> [    2.189462] LR is at sd_ctrl_write16+0x30/0x48
> [    2.195810] NET: Registered protocol family 17
> [    2.200409] pc : [<c05da960>]    lr : [<c05da754>]    psr: 60000013
> [    2.200415] sp : c10a9e30  ip : 00000024  fp : c11b3cc0
> [    2.204877] can: controller area network core
> [    2.209282] r10: c11ae410  r9 : c11ae400  r8 : c18e9d48
> [    2.209288] r7 : fffffe00  r6 : c18e9d48  r5 : c18e9d40  r4 : c1970b80
> [    2.215590] NET: Registered protocol family 29
> [    2.220759] r3 : 0000000c  r2 : 00000006  r1 : 00000001  r0 : 00000000
> [    2.225117] can: raw protocol
> [    2.230322] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [    2.236848] can: broadcast manager protocol
>=20
> Best regards,
> 								Pavel



--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bqgKRRZNMaEHlqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZSRe7wAKCRAw5/Bqldv6
8lWvAJ4o+78CmzeqYTuoVeAMXewcUEcVjQCgxN3GtsUioMz6oMM6DgzZkbTBK5E=
=NEGZ
-----END PGP SIGNATURE-----

--bqgKRRZNMaEHlqWY--
