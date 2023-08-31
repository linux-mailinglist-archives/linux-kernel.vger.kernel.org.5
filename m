Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B179C78F31A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347144AbjHaTJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347143AbjHaTJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:09:35 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0523E69
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=QQCvMl5iMBaAhl4A9VB4FX1lg99oI6M+k4A+VnsS760=; b=eeTKv5sc+qoSkyRdfWwBiayYnA
        fRIEcM2cuYOtu9szoyB/1KbY0pbnZE3IryzyXBynpK6X/FSDQnIWM20f2P9DS018eZjSRjSFCorgS
        DoBofkkXFjOHA61Ntf2rCFdPsHmI349XRVOI1rzSTTIwNU4AtztLvvH3Jnt63WzYywMbNLz+P/N7h
        5M3tgAuLFhoOdwRdVSH7414vCk1cDp2lXun6DsWxBS1SOonwPCC6g3H5YPQyO/12W0EjZW6/zqoaP
        xMCIM1DXzoN/pVWi35kYOVsPcy+ewiTRjgRdKqMUKTfTV0jKi1LOZJ5G6Bt9avmf5PE70sAJar9wu
        gqCwGS+g==;
Received: from [2a01:e34:ec5d:a741:9a7b:5831:531:65c9] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qbn2H-001LAk-Dy; Thu, 31 Aug 2023 21:08:57 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qbn2G-009WjP-2E;
        Thu, 31 Aug 2023 21:08:56 +0200
Date:   Thu, 31 Aug 2023 21:08:56 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     jiajie.ho@starfivetech.com, huan.feng@starfivetech.com,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel@esmil.dk,
        linux-riscv@lists.infradead.org, davidlt@rivosinc.com
Subject: Re: starfive crypto list_add corruption
Message-ID: <ZPDlSLQQkYuIVLYJ@aurel32.net>
Mail-Followup-To: Conor Dooley <conor.dooley@microchip.com>,
        jiajie.ho@starfivetech.com, huan.feng@starfivetech.com,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel@esmil.dk,
        linux-riscv@lists.infradead.org, davidlt@rivosinc.com
References: <20230830-track-glutinous-39f536b4ced1@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jML+LdgAwhBXYINm"
Content-Disposition: inline
In-Reply-To: <20230830-track-glutinous-39f536b4ced1@wendy>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jML+LdgAwhBXYINm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On 2023-08-30 11:26, Conor Dooley wrote:
> Hi,
>=20
> There's been a report on the irc fedora-riscv irc of list_add corruption
> with the starfive crypto stuff:
> 	list_add corruption. next->prev should be prev (ffffffff02f65320), but w=
as ffffffd8eef15848. (next=3Dffffffd8eef15840).
> 	------------[ cut here ]------------
> 	kernel BUG at lib/list_debug.c:29!
> 	Kernel BUG [#1]

[snip]

> I feel like this isn't the first report I saw, but the other might've
> been for the equivalent driver in the vendor tree & I probably didn't
> pay any attention to.

I got this issue, if I remember correctly, I fixed it by enabling
CONFIG_ARM_AMBA and CONFIG_AMBA_PL08X. It improved things a bit, but now
the driver is still not functional and instead I get this kind of trace
appearing during the self test of the driver:

------------[ cut here ]------------
WARNING: CPU: 3 PID: 292 at crypto/api.c:176 crypto_wait_for_test+0x8e/0x92
Modules linked in: nvme_fabrics ad7418 binfmt_misc jh7110_tdm snd_soc_core =
snd_pcm_dmaengine ofpart spi_nor snd_pcm starfive_wdt mtd watchdog jh7110_c=
rypto(+) snd_timer jh7110_trng crypto_engine rng_core snd soundcore sfctemp=
 cpufreq_dt drm loop fuse drm_panel_orientation_quirks configfs ip_tables x=
_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 rtc_ds1307 dm_mod da=
x nvme xhci_pci nvme_core t10_pi crc64_rocksoft crc64 crc_t10dif crct10dif_=
generic crct10dif_common xhci_hcd usbcore axp20x_regulator dwmac_starfive s=
tmmac_platform usb_common dw_mmc_starfive dw_mmc_pltfm axp20x_i2c axp20x mf=
d_core regmap_i2c stmmac dw_mmc pcs_xpcs of_mdio fixed_phy phylink fwnode_m=
dio mmc_core libphy clk_starfive_jh7110_vout clk_starfive_jh7110_isp clk_st=
arfive_jh7110_aon spi_cadence_quadspi i2c_designware_platform clk_starfive_=
jh7110_stg phy_jh7110_usb phy_jh7110_pcie i2c_designware_core
CPU: 3 PID: 292 Comm: (udev-worker) Not tainted 6.5.0-rc7+ #1
Hardware name: StarFive VisionFive 2 v1.2A (DT)
epc : crypto_wait_for_test+0x8e/0x92
 ra : crypto_wait_for_test+0x44/0x92
epc : ffffffff803d421e ra : ffffffff803d41d4 sp : ffffffc80067b830
 gp : ffffffff8198de98 tp : ffffffd8ce189b80 t0 : 0000000000000000
 t1 : 00000000000000aa t2 : 000000000000031e s0 : ffffffc80067b850
 s1 : ffffffd8d9df5e00 a0 : fffffffffffffe00 a1 : ffffffc80067b798
 a2 : ffffffc80067b798 a3 : ffffffd8d9df5f98 a4 : 0000000000000000
 a5 : fffffffffffffe00 a6 : ffffffd8c1285400 a7 : 00000000000000a9
 s2 : ffffffff0343e340 s3 : 0000000000000000 s4 : ffffffff0343e280
 s5 : 000000000000000a s6 : ffffffff80e5cef0 s7 : ffffffff819ceba8
 s8 : 0000000000000000 s9 : ffffffc80067bd58 s10: ffffffff0343fb58
 s11: ffffffc80067bca0 t3 : 000000000000ff00 t4 : 0000000000ff0000
 t5 : 0000000000000040 t6 : 0000000000000006
status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[<ffffffff803d421e>] crypto_wait_for_test+0x8e/0x92
[<ffffffff803d62f8>] crypto_register_alg+0xa8/0xea
[<ffffffff803d941c>] crypto_register_ahashes+0x4c/0xd0
[<ffffffff033e48e0>] starfive_hash_register_algs+0x22/0x2a [jh7110_crypto]
[<ffffffff033e35dc>] starfive_cryp_probe+0x3ca/0x468 [jh7110_crypto]
[<ffffffff806525d6>] platform_probe+0x5e/0xba
[<ffffffff8064f5f4>] really_probe+0xa0/0x35a
[<ffffffff8064f928>] __driver_probe_device+0x7a/0x138
[<ffffffff8064fa1e>] driver_probe_device+0x38/0xc6
[<ffffffff8064fc60>] __driver_attach+0xd0/0x1b8
[<ffffffff8064d18e>] bus_for_each_dev+0x6c/0xba
[<ffffffff8064ee8a>] driver_attach+0x26/0x2e
[<ffffffff8064e688>] bus_add_driver+0x108/0x20a
[<ffffffff80650d52>] driver_register+0x52/0xf4
[<ffffffff806521c2>] __platform_driver_register+0x28/0x30
[<ffffffff033e9028>] starfive_cryp_driver_init+0x28/0x1000 [jh7110_crypto]
[<ffffffff800028be>] do_one_initcall+0x5c/0x22e
[<ffffffff800b3e36>] do_init_module+0x5e/0x21a
[<ffffffff800b5b06>] load_module+0x1842/0x1db4
[<ffffffff800b6272>] init_module_from_file+0x82/0xba
[<ffffffff800b645e>] sys_finit_module+0x194/0x326
[<ffffffff80939194>] do_trap_ecall_u+0xc6/0x134
[<ffffffff80003cec>] ret_from_exception+0x0/0x64
---[ end trace 0000000000000000 ]---

Regards
Aurelien

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net

--jML+LdgAwhBXYINm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUryGlb40+QrX1Ay4E4jA+JnoM2sFAmTw5UUACgkQE4jA+Jno
M2sOaA/9FhG3LlDZCMNJuvXF/y7l1hS0VD90XHzDhWSVid2wYZCs8J2HvLBfgbmc
8ilS/cg8fyPRPgnPNoU5FhNa/9V2TRu40oxolf8i/eJIPlcEldcnfIOO/l0py1Fc
VhUHItmAxoOzAow9fO1C4+3HdnER/TWbw/sC30Z8Q7QIMQJUoKq9KcLpr6gvXmCg
aBq5pcAw5cT4dPQYJFsiaWwzQPqnmwRPsE13wWu8eYnE3CaJCdMY7kIXlJWofr6r
axRSrUlbZIhsYVBXybsCcOr9Wt6FCoQAs+gR1QXYL2H4fCt/aZK+poYSxIf7KUmF
JpDt2pzP9/BBGMnLEL8no6BBQCfuL0XdzqkUxMVzw5wea0MtHCtrrr4Q3mus8WYj
4zecZJCdn1pgtVQwosxgIY8XtS2bt37ZkjrI3Ta4+lDPf0tRg1zJJ5JFmrHqg4TS
NKJGmF6cfYLSI+ufvsdJKUN+YrtVDk2yCBW8ULm+v1rBtGFzfvNNPVPJFtTkwwv+
kmSD3YhqexXPzBE1ep30ylLhQP0xxb7/5PgfJRUpaIWxTacT5R0vZrFfXXuagKVo
tYdg3QDIStwNrGCHBUO4W3qVHyxlgsoVW6iWnrs8RORV9Haz/SQLoZGIdA64wQqr
7yOky1stPb88p0i9hempEplCFJ8Z3dL8wFE58X+aRzx5U7QmLs4=
=PXOJ
-----END PGP SIGNATURE-----

--jML+LdgAwhBXYINm--
