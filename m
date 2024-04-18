Return-Path: <linux-kernel+bounces-150396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400678A9E7A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720C21C22225
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3E116D32B;
	Thu, 18 Apr 2024 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLIANLVj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F503B18D;
	Thu, 18 Apr 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454406; cv=none; b=tZyeMgVezStuWVJYJd1jL7HlXAiPUoKvRTgwgQ1vidCYGFZ7FxVF0i7pPCmDVOztSPHciT0txtPWz2Iy81IFGE/makZjctijF54qebat3E7ZtK/djGsqBEtMrf+VgaEV2+qtbQz5kaFmRXYxOdalTkGTbq51074/JAj53DNNtNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454406; c=relaxed/simple;
	bh=q4O42SGkOeGQ/1F+YZLb9KAn4xJcxrLvs2XO89PkINQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh4oyoLitjpYTanRnB/pFmPcyxXnqhTmzse7q0dLtPva+MTVj31GDplWkhJlR71GPaW4uf2L2zHH6j+qkNacse3tCddjS9FuMzyTnasY9iIyu2OrayJqX6UKdmZzxew9RSmTvVITxNgkBrFHEsXzXKwkqrPWXUb2LQ9q4/yb8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLIANLVj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02F0C113CC;
	Thu, 18 Apr 2024 15:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713454406;
	bh=q4O42SGkOeGQ/1F+YZLb9KAn4xJcxrLvs2XO89PkINQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLIANLVjUQzJykeXLbvXeqRyg3eoRGt+vdwA8/xEhSjGnZXA7fhBp92q8OBjiwKsx
	 gYIWddDiu03FtZ7QzhR4xejeQxW2fLqlzz8tYNJgS+kXWhxAjxFSmct6iyjkoX0hkj
	 qWHpQpHLNfmYOqZ7oqdr1qG0x1rEHnRY7/OqnsGI1DPHis8gYcvS2EhPKMwvewDsBn
	 kyjTftXxHdCntCglYdcAyf3KYUQ4tVcbwAwvCy3j+rS//ag7J1/yA0Xa2uAwt6QnBL
	 fxIg1sUYTNAmrOVCeF33YU+H/hBN7+fTNCZWUOtTh4FpSGFBuK9fhe1DGdFDPJ0NQh
	 FvcIADhWPJnCg==
Date: Thu, 18 Apr 2024 16:33:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Aiuto <fabio.aiuto@engicam.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Matteo Lisi <matteo.lisi@engicam.com>,
	Mirko Ardinghi <mirko.ardinghi@engicam.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: fsl: add Engicam i.Core MX93
 EDIMM 2.0 Starter Kit
Message-ID: <20240418-lapel-monstrous-5774610c7405@spud>
References: <20240418133923.3705-1-fabio.aiuto@engicam.com>
 <20240418133923.3705-2-fabio.aiuto@engicam.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FWa/j/CWa6P8w6vA"
Content-Disposition: inline
In-Reply-To: <20240418133923.3705-2-fabio.aiuto@engicam.com>


--FWa/j/CWa6P8w6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 03:39:21PM +0200, Fabio Aiuto wrote:
> i.Core MX93 is a NXP i.MX93 based EDIMM SoM by Engicam.
>=20
> EDIMM 2.0 Starter Kit is an EDIMM 2.0 Form Factor Capacitive
> Evaluation Board by Engicam.
>=20
> i.Core MX93 needs to be mounted on top of EDIMM 2.0 Starter Kit
> to get the full i.Core MX93 EDIMM 2.0 Starter Kit board.
>=20
> Add bindings for this board.
>=20
> Cc: Matteo Lisi <matteo.lisi@engicam.com>
> Cc: Mirko Ardinghi <mirko.ardinghi@engicam.com>
> Signed-off-by: Fabio Aiuto <fabio.aiuto@engicam.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentati=
on/devicetree/bindings/arm/fsl.yaml
> index 0027201e19f8..b497a01c7418 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1265,6 +1265,13 @@ properties:
>                - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
>            - const: fsl,imx93
> =20
> +      - description: Engicam i.Core MX93 based Boards
> +        items:
> +          - enum:
> +              - engicam,icore-mx93-edimm2         # i.MX93 Engicam i.Cor=
e MX93 EDIMM 2.0 Starter Kit
> +          - const: engicam,icore-mx93             # i.MX93 Engicam i.Cor=
e MX93 Som
> +          - const: fsl,imx93
> +
>        - description: i.MXRT1050 based Boards
>          items:
>            - enum:
> --=20
> 2.34.1
>=20

--FWa/j/CWa6P8w6vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiE9QQAKCRB4tDGHoIJi
0kPEAQC10Rg0sSsgKlOVov5aMUcCgT71mP1NdQJc6jCwq5QQXAEAxXyM9sMB5skD
jsjdYNCfjQb3ZM/K2SZU4PA0kd8tsQE=
=YA0t
-----END PGP SIGNATURE-----

--FWa/j/CWa6P8w6vA--

