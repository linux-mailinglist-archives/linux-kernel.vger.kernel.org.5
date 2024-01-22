Return-Path: <linux-kernel+bounces-33753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7BA836E20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4EF1F25035
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BC73E463;
	Mon, 22 Jan 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2snNYWM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F583DBAE;
	Mon, 22 Jan 2024 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943396; cv=none; b=NaCz5zV8ZZJjruAVisocSskQPDtGs2eM2HAEpiGNgCYUmZcVj3qX5nZA4V2ujvA826GNVPgy0J7FFVJ9/PvtZmVgTxqaTMSEppIcg5XMQJsRWJAmt9Fs2SWRWtzjDoW1iH1r+lgNOLw51suQ4e8tcg9VqyzZy1C5UEMECSCB8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943396; c=relaxed/simple;
	bh=t2lzAIQ/wgiQPWzdfyeH8NuB4LMXlxLjxCYsI2QGApc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmQhPzG8wZUuIsZAnHxXoFMQZXAH211fbsGuCcN6PfjQc4XEPkhrBmpt9dvrNbXM5dPyuPJLN9kvD1BEgiLIYAcZO/xodehbyE/ijTKVfmioZrho2UCOuHAw3AmXQuQT7hw34duKRyY5wPSeTkf8dM7zo5Qgla7GfqtA8SLbcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2snNYWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCC5C43399;
	Mon, 22 Jan 2024 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705943396;
	bh=t2lzAIQ/wgiQPWzdfyeH8NuB4LMXlxLjxCYsI2QGApc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2snNYWMIXDvqOW9DSsiBFnfFglhNTMmq9sWG5U3u9yl5Z1grQnACfmMRT9lf/RUJ
	 yU3zqtX7bU4B6ELEQttqkZRVfCKkO6iq1u2ZpzcFoJZU/UH/nrmqAAukK+fjjzq+8N
	 Ycz5JBtPVuwFDtU2tcW9WZo5vG5e4RQSiM2LoFz1MpvSMx/cWVjldubQacLg28xnqw
	 KWOlTe7XpXZbxMxV4Xs829bra/gshHYAEElmrvU8Fq5cgmqt7xYQi2QHFQwAC6W+iI
	 Cq4rGO/4x1wvTiewOX9eM03hlg/cGUfoKUcbMSAz3Trg074FXEKwozLSQI8+vdtddp
	 bZbLNtxcSZKbQ==
Date: Mon, 22 Jan 2024 17:09:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: fsl: Add
 toradex,apalis_imx6q-eval-v1.2 board
Message-ID: <20240122-unfiled-cruelly-2ee24a8d8116@spud>
References: <20240122123526.43400-1-hiagofranco@gmail.com>
 <20240122123526.43400-2-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BUnWwTpzDy0Sk/a/"
Content-Disposition: inline
In-Reply-To: <20240122123526.43400-2-hiagofranco@gmail.com>


--BUnWwTpzDy0Sk/a/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 09:34:59AM -0300, Hiago De Franco wrote:
> From: Hiago De Franco <hiago.franco@toradex.com>
>=20
> Add the toradex,apalis_imx6q-eval-v1.2 compatible string for version 1.2
> of the Apalis Evaluation Board.
>=20
> Version v1.2 includes the following changes compared to v1.1:
>=20
> - 8-bit MMC connector replaced with a 4-bit uSD connector.
> - Audio codec NAU88C22 added.
> - M24C02 EEPROM i2c added.
> - MIPI-CSI-2 connector directly to the board added.
> - PCIe switch PEX8605 removed and PCIe now is routed directly to Mini
>   PCIe connector.
> - Power measurement IC INA219 added.
> - Replaced DVI with HDMI connector.
> - Single-channel USB to UART converter replaced with four-channel USB
>   to UART/JTAG.
> - Temperature sensor TMP75 added.
>=20
> Please note that version v1.0 (which reached EOL) is compatible with
> v1.1, therefore toradex,apalis_imx6q-eval compatible string should be
> used for both v1.0 and v1.1.
>=20
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--BUnWwTpzDy0Sk/a/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6hXwAKCRB4tDGHoIJi
0lUrAQDaGHf9wC1apPqofEVDUhZIOpU2zo3bsdGjY8rebT8U/AD/R7iUArog2/s/
XkkNjs30GLr+ut34UoHxIxBhVahngAs=
=A/No
-----END PGP SIGNATURE-----

--BUnWwTpzDy0Sk/a/--

