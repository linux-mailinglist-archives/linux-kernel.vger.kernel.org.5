Return-Path: <linux-kernel+bounces-119654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90C88CBA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F81B2561E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1418529B;
	Tue, 26 Mar 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOHCFZ9b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941A1CAA6;
	Tue, 26 Mar 2024 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476584; cv=none; b=pTR75ufTnT7Zws4Qy1dcKeNibTz+6PJQ/MXwFV6MwBXegjR56+z1qwAXzixqp5b/l3AMbKb64ggE5FyLBMtHeHYuu/VTEO1AD8jNsWWoF7C4chOBXkg/cl1TAF7mhER76VEdvnPkLVEKsrOp4cnS0spBG4zhkApT+bbtDlc6oS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476584; c=relaxed/simple;
	bh=BoZYsRYkImtz4DrtH6xel+18JVsPtJGNgh1WEY1wxXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuUWZQudTPOsRUIMxs2ESI//pv1hZ0B2RxWv3l01HxRZtgzL12ePlnDQpwxHq7FIN9ctu8XoCXnXJl6JE+mtXyGmagqGTkIHYqT5YRbsM2PwX2IEgaGkO8cryRoldjjybX91VbFDxHMU4IIbg/EcapC2FAI7UKFxADXaxnlendA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOHCFZ9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDD0C433F1;
	Tue, 26 Mar 2024 18:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711476583;
	bh=BoZYsRYkImtz4DrtH6xel+18JVsPtJGNgh1WEY1wxXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AOHCFZ9bDZOrngpBwpMwYFCeEDFkL77M5GOcuPWQRkrWUjl+XdKuDZr8hcfK9o0vZ
	 HRhT0RkXWKow1fzxVkShJL1uD2BSPMXVokd4IRhLwwgbpsAjkDRlX3pLEjgxCh5emD
	 zLBOfhOuUIvlztzxtgeSCN7ua5iJpN5DsUUNVf0tL1AeyhDeoqvz0ZAmTQSFzcjAfk
	 FmMcFTwXzT9mwsqSbPXZp+PGkmo0O+HGdiNEdsvnehCAYPJpqvyAmMVo7oOuEWmo1B
	 WzBAKvhpSArGc60m/n5vwVxQf5GTmftn5jjhANsPazROoKgNW7V8nI8Dk0WQ751yBY
	 OkAkwhx1Oa0tQ==
Date: Tue, 26 Mar 2024 18:09:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: neil.armstrong@linaro.org, clabbe@baylibre.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, vadim.fedorenko@linux.dev,
	linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
Subject: Re: [PATCH v6 17/23] dt-bindings: crypto: meson: remove clk and
 second interrupt line for GXL
Message-ID: <20240326-obscurity-angriness-d7bb48bc9eaa@spud>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-18-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+unRSAILer2Qnn5+"
Content-Disposition: inline
In-Reply-To: <20240326153219.2915080-18-avromanov@salutedevices.com>


--+unRSAILer2Qnn5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 06:32:13PM +0300, Alexey Romanov wrote:
> GXL crypto IP uses DMA engine, which doesn't require clk input
> and second interrupt line.
>=20
> Fixes: c4a0457eb858 ("ARM64: dts: amlogic: adds crypto hardware node")

How does this fix a commit that only modifies a dts? The commit cited
here should be a dt-bindings commit.

However, your commit message says "require" but you do more than remove
these as required, you remove them entirely. What am I missing?

Thanks,
Conor.

> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  .../bindings/crypto/amlogic,gxl-crypto.yaml         | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.=
yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> index 948e11ebe4ee..d3af7b4d5f39 100644
> --- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> @@ -20,20 +20,11 @@ properties:
>    interrupts:
>      items:
>        - description: Interrupt for flow 0
> -      - description: Interrupt for flow 1
> -
> -  clocks:
> -    maxItems: 1
> -
> -  clock-names:
> -    const: blkmv
> =20
>  required:
>    - compatible
>    - reg
>    - interrupts
> -  - clocks
> -  - clock-names
> =20
>  additionalProperties: false
> =20
> @@ -46,7 +37,5 @@ examples:
>      crypto: crypto-engine@c883e000 {
>          compatible =3D "amlogic,gxl-crypto";
>          reg =3D <0xc883e000 0x36>;
> -        interrupts =3D <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>, <GIC_SPI 189 =
IRQ_TYPE_EDGE_RISING>;
> -        clocks =3D <&clkc CLKID_BLKMV>;
> -        clock-names =3D "blkmv";
> +        interrupts =3D <GIC_SPI 188 IRQ_TYPE_EDGE_RISING>;
>      };
> --=20
> 2.34.1
>=20

--+unRSAILer2Qnn5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMPYQAKCRB4tDGHoIJi
0gUyAQDBzDH7NW6Up524dyfrQC8iScX/snnaCE/sN+SA8QNCzgD/RMPYlpchBH5p
HInA6ICfV7K+t9Br+NT/w6F9vNuzyQY=
=FyeI
-----END PGP SIGNATURE-----

--+unRSAILer2Qnn5+--

