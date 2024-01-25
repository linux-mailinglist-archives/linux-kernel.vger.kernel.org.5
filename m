Return-Path: <linux-kernel+bounces-39009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7C083C998
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCFB298693
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E935132C15;
	Thu, 25 Jan 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0jMYfzi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBC6130E4B;
	Thu, 25 Jan 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202490; cv=none; b=WfE1YMUMxrvXOM6fXMxoUlESLgV4y8ESo2/6lhsplrp8crxU4Z/jSqUkYVXDLPsVyNuZ7TjwksKlCSSIFfR16Qz8C0eaGtFHpA8cxj2cJgkN1AaQNUq4OXhqXzPN1AazOJKE0KKMYcKDytdDnBbRSCZSNteG6QK9xE3qyQH+nHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202490; c=relaxed/simple;
	bh=AExTusMF4INxCnd5hFNzvqahxV6pvzKQNN6GGi8BlDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqs2lqsuS0PSOLQYQGLfEpcdKQ6cEQ/vblK1yVqLLaWNvtLkfvsXFJpgAw+Gt4J28ZdPRHjEdWuPmoy7w3Jx3M2doBwwcdfFTXYQDRAzzv90LT0uf/UdeW7Kqlk9Wn8g/8arz3Tt5RwxXj675Tl4s23vXzaKDvpJpErjSFCdi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0jMYfzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C9FC433C7;
	Thu, 25 Jan 2024 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706202489;
	bh=AExTusMF4INxCnd5hFNzvqahxV6pvzKQNN6GGi8BlDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r0jMYfziQNN9sa6AmXoKSCurKA6BqmG0INQ+XdOsKnF8kNWE7IY7ybm+Wd0PgA0Zr
	 U9pPkSnIheEO2AJYHygBeqbbgcaOYR3BPX8PWO664E66/DhClkUbL49zuAKBhzDqPr
	 s5otYwc+lDBvuoi9aIbkqKjCx38tZpTsbNC5+YCw6wR8rpnKjUosv6G32FwG+yH8pd
	 fEKHJL+yRuyHsbOiSkFSwiOo4MaG8fRDEv+H6Edg+kFD1WbU6qYqT8i18yfTBdZLHY
	 ZnY5/fPfeo1plfWXTvWXEdkMMQ21mQgaGWHB5qFx6XUbh9I9A3nwHvcfaboSdAWy1F
	 HXLbKmS5E5Iuw==
Date: Thu, 25 Jan 2024 17:08:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: fsl: add imx8qm apalis eval
 v1.2 carrier board
Message-ID: <20240125-player-disposal-a9cd852e9061@spud>
References: <20240125101457.9873-1-francesco@dolcini.it>
 <20240125101457.9873-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G03XcziqO5uHVHWG"
Content-Disposition: inline
In-Reply-To: <20240125101457.9873-2-francesco@dolcini.it>


--G03XcziqO5uHVHWG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:14:56AM +0100, Francesco Dolcini wrote:
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
>=20
> Add the toradex,apalis-imx8-eval-v1.2 and
> toradex,apalis-imx8-v1.1-eval-v1.2 compatible strings for version 1.2
> of the Apalis Evaluation Board.
>=20
> Version v1.2 includes the following changes compared to v1.1:
>=20
> - 8-bit MMC connector replaced with a 4-bit uSD connector.
> - Audio codec NAU88C22 added.
> - M24C02 EEPROM i2c added.
> - MIPI-CSI-2 connector directly to the board added.
> - PCIe switch PEX8605 removed and PCIe now is routed directly to Mini
> PCIe connector.
> - Power measurement IC INA219 added.
> - Replaced DVI with HDMI connector.
> - Single-channel USB to UART converter replaced with four-channel USB
> to UART/JTAG.
> - Temperature sensor TMP75 added.
>=20
> Please note that board version v1.0 (which reached EOL) is compatible with
> v1.1, therefore toradex,apalis-imx8-eval and toradex,apalis-v1.1-imx8-eval
> compatible strings should be used for both v1.0 and v1.1.
>=20
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

I was convinced that I acked this already a few days ago, but no:
https://lore.kernel.org/all/20240124141849.26254-2-hiagofranco@gmail.com/

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 228dcc5c7d6f..b877f940490a 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1194,7 +1194,8 @@ properties:
>        - description: i.MX8QM Boards with Toradex Apalis iMX8 Modules
>          items:
>            - enum:
> -              - toradex,apalis-imx8-eval            # Apalis iMX8 Module=
 on Apalis Evaluation Board
> +              - toradex,apalis-imx8-eval            # Apalis iMX8 Module=
 on Apalis Evaluation V1.0/V1.1 Board
> +              - toradex,apalis-imx8-eval-v1.2       # Apalis iMX8 Module=
 on Apalis Evaluation V1.2 Board
>                - toradex,apalis-imx8-ixora-v1.1      # Apalis iMX8 Module=
 on Ixora V1.1 Carrier Board
>            - const: toradex,apalis-imx8
>            - const: fsl,imx8qm
> @@ -1202,7 +1203,8 @@ properties:
>        - description: i.MX8QM Boards with Toradex Apalis iMX8 V1.1 Modules
>          items:
>            - enum:
> -              - toradex,apalis-imx8-v1.1-eval       # Apalis iMX8 V1.1 M=
odule on Apalis Eval. Board
> +              - toradex,apalis-imx8-v1.1-eval       # Apalis iMX8 V1.1 M=
odule on Apalis Eval. V1.0/V1.1 Board
> +              - toradex,apalis-imx8-v1.1-eval-v1.2  # Apalis iMX8 V1.1 M=
odule on Apalis Eval. V1.2 Board
>                - toradex,apalis-imx8-v1.1-ixora-v1.1 # Apalis iMX8 V1.1 M=
odule on Ixora V1.1 C. Board
>                - toradex,apalis-imx8-v1.1-ixora-v1.2 # Apalis iMX8 V1.1 M=
odule on Ixora V1.2 C. Board
>            - const: toradex,apalis-imx8-v1.1
> --=20
> 2.39.2
>=20

--G03XcziqO5uHVHWG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKVdAAKCRB4tDGHoIJi
0k1uAQDJEsSzP9Dn7ZbijgWvm6jFf4fSgLV6t0SmvLAG4DSHVwEAlDIHQnE1ionO
Hu1NVhWyn9DTkBsNbO+5Lju+D7DX/QA=
=drxf
-----END PGP SIGNATURE-----

--G03XcziqO5uHVHWG--

