Return-Path: <linux-kernel+bounces-32635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18D0835E46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0CCB29589
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA4139ADD;
	Mon, 22 Jan 2024 09:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUv5PgcR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A06939ACA;
	Mon, 22 Jan 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915985; cv=none; b=ncwbVb+zDOmGscRAV8rBoWdu01P1jdIf568NzG3jKcSLa28HzX4V2uBgUK23gIiV0mr94hRnYbZk7MUp/L08C4TPDwve3zDqyM7AZgCSM8uF66JmmyFSs0GumqAaJL4q6817lWasOMLywF3Mxkt4aC2BCitcRioGhzgtUI2t5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915985; c=relaxed/simple;
	bh=S6s4EtVqBSvAaKFT9SU46dJKrkzU7pcRxs4qug349Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5qsQKrd6iyt8IJPg01B552LTxtAEddgG+sDF0mR4hwgv5MX36Tk6zBz1/tT++fV0wt0HyxNmjrk/KWxjEsNfwyj9ZWwpDKwU6jPhDcKIM7Ma4Afvmk9bz4UTFYf46GpSuTqa6yFu5GOheu2BTfIknkvKJE0PTt8u0sl0+2O5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUv5PgcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF7EC433C7;
	Mon, 22 Jan 2024 09:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705915984;
	bh=S6s4EtVqBSvAaKFT9SU46dJKrkzU7pcRxs4qug349Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VUv5PgcRLcc+SSNBl4cvP7XNYUAyr4sW8nWbjpz66OnozCzVvAspXl+qp7hD4MkAk
	 +PN+tSH+O5/J8z0u5CnZBJ302hpsM/SVhQ/GYXjzUhffIYqshdQga5wMozLhiGvB5G
	 oEMDX/ayfIAGY8xTTUdG6DO8NvVfHNymS1a/R2j/XAFouLDSFsEHy/qyaJKN1XQ40W
	 i5PPXPqeLiuVYhglNfDPNM93gd8z3bRlvHpKeFPQQ7SdOFg4WW1o5hSUILi2+ELZ5w
	 PQn8MTykhdiINJ8PphytWsQ1rDX5eO+1TREO1DZIYsr/ZKg6ZbYRo8MCzxuhEb9wLx
	 SIpgrCuHrD5/A==
Date: Mon, 22 Jan 2024 09:32:59 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: broonie@kernel.org, conor+dt@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, han.xu@nxp.com,
	haibo.chen@nxp.com, yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95
Message-ID: <20240122-smuggler-wrath-843cb20a8e07@spud>
References: <20240122091510.2077498-1-peng.fan@oss.nxp.com>
 <20240122091510.2077498-2-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pfapuoot4ESQXufK"
Content-Disposition: inline
In-Reply-To: <20240122091510.2077498-2-peng.fan@oss.nxp.com>


--pfapuoot4ESQXufK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 05:15:10PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX93/95 flexspi compatible strings, which are compatible with
> i.MX8MM
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/spi/spi-nxp-fspi.yaml  | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Do=
cumentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> index 7fd591145480..4a5f41bde00f 100644
> --- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
> @@ -15,12 +15,18 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - nxp,imx8dxl-fspi
> -      - nxp,imx8mm-fspi
> -      - nxp,imx8mp-fspi
> -      - nxp,imx8qxp-fspi
> -      - nxp,lx2160a-fspi
> +    oneOf:
> +      - enum:
> +          - nxp,imx8dxl-fspi
> +          - nxp,imx8mm-fspi
> +          - nxp,imx8mp-fspi
> +          - nxp,imx8qxp-fspi
> +          - nxp,lx2160a-fspi
> +      - items:
> +          - enum:
> +              - nxp,imx93-fspi
> +              - nxp,imx95-fspi
> +          - const: nxp,imx8mm-fspi
> =20
>    reg:
>      items:
> --=20
> 2.37.1
>=20

--pfapuoot4ESQXufK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa42SwAKCRB4tDGHoIJi
0tdXAP98HpM2PK3w7yVrMJ8SZk8ztWP8ufj76c/z3c/OsyqXMQD+McQ49WApWvAd
u2jR/iBqItcGxbfMgGsMUl8f7Wc1UQA=
=EkRj
-----END PGP SIGNATURE-----

--pfapuoot4ESQXufK--

