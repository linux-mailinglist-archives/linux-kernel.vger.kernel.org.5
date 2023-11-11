Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71DF7E8CB6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 21:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjKKUvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 15:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKKUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 15:51:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169CE2D73;
        Sat, 11 Nov 2023 12:51:20 -0800 (PST)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 262F96607399;
        Sat, 11 Nov 2023 20:51:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699735878;
        bh=vd0GSRMWIAOZt0WFx2rYw8aFeL4aemj6wZ3FIw2qniE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VllkWX9Y108aRmPO2jdH//XkpUtjjH0KcbNQMm1wgtWPxoB70LohgFZnScxFntlv4
         x7ZcHPD6zV0TA9Ki1LJ4Jqv8jxWXZdN0Z6cOqjxtUPdgv16oKav4KvM1VERBg1E0OO
         jIzMSTrNyxo6GS/ZUX1D3URAo5y+3NqTrGdC5RRmN044ffpYcwQAJtVP19+jWuHd4l
         PkNrsVYP0r9q+MqW7uWuR/Hpexo84P5pN9KwGnk+rCXmiCd+YDP9B5PjLspJtvp1t7
         M1jw05ZKj3rJgDOz6Qx8VMoUfft9MGlmRbFOPKp2nIKPu4rlmg3CxRqE2ORAqTpWu1
         izlBQhU1lDq1g==
Received: by mercury (Postfix, from userid 1000)
        id 826B41062B49; Sat, 11 Nov 2023 21:51:15 +0100 (CET)
Date:   Sat, 11 Nov 2023 21:51:15 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Corentin Labbe <clabbe@baylibre.com>, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org, ricardo@pardini.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 5/6] reset: rockchip: secure reset must be used by SCMI
Message-ID: <20231111205115.6hkhjj37ypeq45ax@mercury.elektranox.org>
References: <20231107155532.3747113-1-clabbe@baylibre.com>
 <20231107155532.3747113-6-clabbe@baylibre.com>
 <f1b24f19-c210-4f55-b40f-ab063e7eeb22@linaro.org>
 <11278271.CDJkKcVGEf@diego>
 <d82865bc-29a7-4150-876e-489e0d797699@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2wirqy36iysfq2nl"
Content-Disposition: inline
In-Reply-To: <d82865bc-29a7-4150-876e-489e0d797699@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2wirqy36iysfq2nl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 07, 2023 at 06:45:03PM +0100, Krzysztof Kozlowski wrote:
> On 07/11/2023 18:35, Heiko St=FCbner wrote:
> > Am Dienstag, 7. November 2023, 17:21:41 CET schrieb Krzysztof Kozlowski:
> >> On 07/11/2023 16:55, Corentin Labbe wrote:
> >>> While working on the rk3588 crypto driver, I loose lot of time
> >>> understanding why resetting the IP failed.
> >>> This is due to RK3588_SECURECRU_RESET_OFFSET being in the secure worl=
d,
> >>> so impossible to operate on it from the kernel.
> >>> All resets in this block must be handled via SCMI call.
> >>>
> >>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> >>> ---
> >>>  drivers/clk/rockchip/rst-rk3588.c             | 42 ------------
> >>>  .../dt-bindings/reset/rockchip,rk3588-cru.h   | 68 +++++++++--------=
--
> >>
> >> Please run scripts/checkpatch.pl and fix reported warnings. Some
> >> warnings can be ignored, but the code here looks like it needs a fix.
> >> Feel free to get in touch if the warning is not clear.
> >>
> >>>  2 files changed, 34 insertions(+), 76 deletions(-)
> >>>
> >>> diff --git a/drivers/clk/rockchip/rst-rk3588.c b/drivers/clk/rockchip=
/rst-rk3588.c
> >>> index e855bb8d5413..6556d9d3c7ab 100644
> >>> --- a/drivers/clk/rockchip/rst-rk3588.c
> >>> +++ b/drivers/clk/rockchip/rst-rk3588.c
> >>> @@ -16,9 +16,6 @@
> >>>  /* 0xFD7C8000 + 0x0A00 */
> >>>  #define RK3588_PHPTOPCRU_RESET_OFFSET(id, reg, bit) [id] =3D (0x8000=
*4 + reg * 16 + bit)
> >>> =20
> >>> -/* 0xFD7D0000 + 0x0A00 */
> >>> -#define RK3588_SECURECRU_RESET_OFFSET(id, reg, bit) [id] =3D (0x1000=
0*4 + reg * 16 + bit)
> >>> -
> >>>  /* 0xFD7F0000 + 0x0A00 */
> >>>  #define RK3588_PMU1CRU_RESET_OFFSET(id, reg, bit) [id] =3D (0x30000*=
4 + reg * 16 + bit)
> >>> =20
> >>> @@ -806,45 +803,6 @@ static const int rk3588_register_offset[] =3D {
> >>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_PMU0IOC, 5, 4),
> >>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_P_GPIO0, 5, 5),
> >>>  	RK3588_PMU1CRU_RESET_OFFSET(SRST_GPIO0, 5, 6),
> >>> -
> >>> -	/* SECURECRU_SOFTRST_CON00 */
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_NS_BIU, 0, 10),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_NS_BIU, 0, 11),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_SECURE_S_BIU, 0, 12),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SECURE_S_BIU, 0, 13),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_SECURE_S_BIU, 0, 14),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_CORE, 0, 15),
> >>> -
> >>> -	/* SECURECRU_SOFTRST_CON01 */
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_PKA, 1, 0),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_CRYPTO_RNG, 1, 1),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_CRYPTO, 1, 2),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_CRYPTO, 1, 3),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_CORE, 1, 9),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_KEYLADDER_RNG, 1, 10),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_KEYLADDER, 1, 11),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_KEYLADDER, 1, 12),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_OTPC_S, 1, 13),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_OTPC_S, 1, 14),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_WDT_S, 1, 15),
> >>> -
> >>> -	/* SECURECRU_SOFTRST_CON02 */
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_T_WDT_S, 2, 0),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM, 2, 1),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_A_DCF, 2, 2),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_DCF, 2, 3),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_BOOTROM_NS, 2, 5),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_KEYLADDER, 2, 14),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_S, 2, 15),
> >>> -
> >>> -	/* SECURECRU_SOFTRST_CON03 */
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_TRNG_NS, 3, 0),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_D_SDMMC_BUFFER, 3, 1),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC, 3, 2),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_H_SDMMC_BUFFER, 3, 3),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_SDMMC, 3, 4),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_P_TRNG_CHK, 3, 5),
> >>> -	RK3588_SECURECRU_RESET_OFFSET(SRST_TRNG_S, 3, 6),
> >>>  };
> >>> =20
> >>>  void rk3588_rst_init(struct device_node *np, void __iomem *reg_base)
> >>> diff --git a/include/dt-bindings/reset/rockchip,rk3588-cru.h b/includ=
e/dt-bindings/reset/rockchip,rk3588-cru.h
> >>> index d4264db2a07f..c0d08ae78cd5 100644
> >>> --- a/include/dt-bindings/reset/rockchip,rk3588-cru.h
> >>> +++ b/include/dt-bindings/reset/rockchip,rk3588-cru.h
> >>> @@ -716,39 +716,39 @@
> >>>  #define SRST_P_GPIO0			627
> >>>  #define SRST_GPIO0			628
> >>> =20
> >>> -#define SRST_A_SECURE_NS_BIU		629
> >>> -#define SRST_H_SECURE_NS_BIU		630
> >>> -#define SRST_A_SECURE_S_BIU		631
> >>> -#define SRST_H_SECURE_S_BIU		632
> >>> -#define SRST_P_SECURE_S_BIU		633
> >>> -#define SRST_CRYPTO_CORE		634
> >>> -
> >>> -#define SRST_CRYPTO_PKA			635
> >>> -#define SRST_CRYPTO_RNG			636
> >>> -#define SRST_A_CRYPTO			637
> >>> -#define SRST_H_CRYPTO			638
> >>> -#define SRST_KEYLADDER_CORE		639
> >>> -#define SRST_KEYLADDER_RNG		640
> >>> -#define SRST_A_KEYLADDER		641
> >>> -#define SRST_H_KEYLADDER		642
> >>> -#define SRST_P_OTPC_S			643
> >>> -#define SRST_OTPC_S			644
> >>> -#define SRST_WDT_S			645
> >>> -
> >>> -#define SRST_T_WDT_S			646
> >>> -#define SRST_H_BOOTROM			647
> >>> -#define SRST_A_DCF			648
> >>> -#define SRST_P_DCF			649
> >>> -#define SRST_H_BOOTROM_NS		650
> >>> -#define SRST_P_KEYLADDER		651
> >>> -#define SRST_H_TRNG_S			652
> >>> -
> >>> -#define SRST_H_TRNG_NS			653
> >>> -#define SRST_D_SDMMC_BUFFER		654
> >>> -#define SRST_H_SDMMC			655
> >>> -#define SRST_H_SDMMC_BUFFER		656
> >>> -#define SRST_SDMMC			657
> >>> -#define SRST_P_TRNG_CHK			658
> >>> -#define SRST_TRNG_S			659
> >>> +#define SRST_A_SECURE_NS_BIU		10
> >>
> >> NAK. You just broke all users.
> >=20
> > If I'm reading the commit message correctly, all resets in that area
> > couldn't have any users to begin with, as the registers controlling them
> > are in the secure space, and need a higher exception level
> >=20
> > So if  anything is trying to handle these resets, would end up with some
> > security exception right now.
> >=20
> > Though I guess we might want to use different names and not reuse the
> > existing ones. scmi clocks use a SCMI_CLK_* id scheme, so maybe SCMI_SR=
ST_* ?
>=20
> I don't quite get what the patch wants to achieve. Why dropping driver
> support for given reset ID is connected with changing the value of
> binding for given reset?
>=20
> What is the point of this define SRST_A_SECURE_NS_BIU 10?

This is about two different reset controllers. The IDs defined here
are used by the operating system to access the correct registers.
The kernel has a LUT from the ID to a register addresses, which is
something you asked for during upstreaming.

The ID defined by Corentin is for reset control via SCMI firmware,
which has different number scheme than Linux. To me the suggestion
=66rom Heiko looks sensible (i.e. create a new ID scheme and keep the
current one unchanged).

Greetings,

-- Sebastian

--2wirqy36iysfq2nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmVP6ToACgkQ2O7X88g7
+pp22g//RQCNh/wWsCawBz03xeDAIaJe/Os0GoNhvXwLp854ltQt9yEy9EZUqrvt
QYxOW5q1b3HiA+OwHHn0gGwY2+rIhpdZ2RztoeWVzVznl04x14oPuF6g8hnZ4LlE
hkaxKae2mgv65YcliU+5qKoZc2ElJPC8XUjsWzng/4VnvWfR6i7OsMQox1AMyvJJ
q9oKCPPjDO6Nw8jI7eXT3wzDAtqp+THogKbHW2+7Sy3tEl5ammeFi6S5BZJnK2Nz
CKxfb+HFH9CHroj5P48rE2wrXcbpwQ70xzVpU66RKv07ZQwCcTR6gnO1LfyqTqKD
aKO2fH5lX+XnbcijlE84JqU+w1YH4WZOnr0Sw8AdnMaH6diJ/iDPAlWml6UmAjKd
zOZv1QU73gXn4VbQvNQZJCNCUWYTzYQ4JJzrD0S+ujlIAq9mjrqmw9n8qsKGa3Ff
pGUAIF+Oiccset9juteCF2qq+pFJtXQmfaWyPbWVMo11MxfHa91MXKohker0z8az
oKzOAYT3fpTfbLdRLc7j3d4uGzWBoiE4vCfGyfY1nGs++bfJSXW2iFqtcUhHd7p8
U3R0o1ryXNWxjQfrZFTizEKRazs2NRkSYfzgjdGsqGvS+aps9fI4AxAjLqKAp5R1
OqBvcPBKi1/OhECzmMheGjMLvzy/BukKMdfBgYxibQkhzx5bzk8=
=+Mmt
-----END PGP SIGNATURE-----

--2wirqy36iysfq2nl--
