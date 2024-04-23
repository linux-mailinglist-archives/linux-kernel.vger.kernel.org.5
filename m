Return-Path: <linux-kernel+bounces-154658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB7A8ADF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221E6287F80
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560BD3F9E8;
	Tue, 23 Apr 2024 08:04:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DD21A0B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859497; cv=none; b=q7rU/OP1byWPJ8wJPZNYzT5Y+ynVeB2WzcAHhRIHo1PCcn5ZzDYL0j1eHEO3azV79M8oJP5CnEu6Tg9WSBH1BLHJuZr8WXVo46DIfF/8HfNs2GVc6SPWOZ1IUD0hblzK/YnwPkcjTlY8wVAEkDzIW9ADcnmU8b19lk1RgfgS4J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859497; c=relaxed/simple;
	bh=SJDuUew+/fONGg57g1C9S/LfOHF08ES9ORW9a2GA+qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPt1Q908faxm1RlQgRl9E8YsVLXRr+36sZbdlpJeAi7H0Nsif2K/n/GCscIxyk7zJkSmHoCjrbXf8KOl70Itz4C36YOHtxhHZ4u9YLN2PD7p76SwyKlPOhunFWOHCSHv26GCn8yZY6KzaQwzP6DD2IUNNuKwz8MVpJjWxa5fIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzB8f-0002Ao-VR; Tue, 23 Apr 2024 10:04:29 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzB8f-00Dq02-2W; Tue, 23 Apr 2024 10:04:29 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D862E2BD8CF;
	Tue, 23 Apr 2024 07:53:51 +0000 (UTC)
Date: Tue, 23 Apr 2024 09:53:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 07/10] arm64: dts: imx8qm-mek: add flexcan support
Message-ID: <20240423-savvy-straight-shellfish-ac1c64-mkl@pengutronix.de>
References: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
 <20240422-dts_8qm_audio-v3-7-680cee731ced@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tics6yqmbhuzwzxy"
Content-Disposition: inline
In-Reply-To: <20240422-dts_8qm_audio-v3-7-680cee731ced@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--tics6yqmbhuzwzxy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.04.2024 15:50:09, Frank Li wrote:
> Add flexcan[1,2,3] support for imx8qm-mek board.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 80 ++++++++++++++++++++++=
++++++
>  1 file changed, 80 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/bo=
ot/dts/freescale/imx8qm-mek.dts
> index 3ab2fab7f7fa3..62ea3efd1ee2c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
[...]
> @@ -433,6 +492,27 @@ IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
>  		>;
>  	};
> =20
> +	pinctrl_flexcan1: flexcan0grp {
> +		fsl,pins =3D <
> +			IMX8QM_FLEXCAN0_TX_DMA_FLEXCAN0_TX			0x21
> +			IMX8QM_FLEXCAN0_RX_DMA_FLEXCAN0_RX			0x21
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan1grp {
> +		fsl,pins =3D <
> +			IMX8QM_FLEXCAN1_TX_DMA_FLEXCAN1_TX			0x21
> +			IMX8QM_FLEXCAN1_RX_DMA_FLEXCAN1_RX			0x21
> +			>;

The indention of the closing ">" looks strange.

> +	};
> +
> +	pinctrl_flexcan3: flexcan3grp {
> +		fsl,pins =3D <
> +			IMX8QM_FLEXCAN2_TX_DMA_FLEXCAN2_TX			0x21
> +			IMX8QM_FLEXCAN2_RX_DMA_FLEXCAN2_RX			0x21
> +			>;

Same here.

> +	};
> +
>  	pinctrl_lpuart0: lpuart0grp {
>  		fsl,pins =3D <
>  			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020
>=20
> --=20
> 2.34.1
>=20
>=20
>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--tics6yqmbhuzwzxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYnaQwACgkQKDiiPnot
vG+uXwf/ZHhRwk/bowRcZWxqTLDKiPbKvuLEbsGITuh4y6PkYYF2mPGF/MgcJPGC
Qad5zoD5VfrziHtjbnRNCBNz2r6KZ24waVXE0p8NDfcSYjr3sPYgsgxHPWCpyGxQ
DeCiJ4m8prwHyPioC1bapLI60Td6Df0VlM2l7LxO7MA+psF9bncGYWNdWCSRP1J0
PLi0I2w99Y75+aPy07U+huVlldIHhPjJGmLyq9KW5VuE29PspApRT1wMwx+ZvthO
Lv5R0d3aTxIQBGtRlMQvX9aTIKMtgMs+Qhbgu+xgQw0AC3L6TfMskIGBxoUzPUKl
YqcMaIGLEhWOM5QicIPtaOdUa9oYyg==
=PR7J
-----END PGP SIGNATURE-----

--tics6yqmbhuzwzxy--

