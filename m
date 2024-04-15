Return-Path: <linux-kernel+bounces-145578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C11C8A580B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418E11F227F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1738248C;
	Mon, 15 Apr 2024 16:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbbyECV5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E758F78C90;
	Mon, 15 Apr 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199402; cv=none; b=S5sYfrLb5U7zkOiH94Xuwq6WiJxB98U+yLC+2K91OBKjR3kEbIAv8tFYYl2n+UcYKE4l64Soi3ve5GTQ2zfOte41sHEB3WPbo6EHtRzBPteBuQ5xycQrnOWZdkg/tRF267VCgfUwkmjntSQ5Anl3VpeLXnQPfcidQSmHvvLQU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199402; c=relaxed/simple;
	bh=HqN7TdZSCNbgHFtvjYms+Ul+s+gTntsHUY9FnuUU/Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6y+oSo5/oyzJXQMebQzLqWQnZf/f5ZbXdAilX7iT+IeYBV9rViZMLNmV4nTYpDTUV78guwpU6RxirvTyTdnwRpN/FAz0nD3Q0utwIqEHuOYnDLOo5krO4W9zVNZZ9x1vpurmVM5FO0h9UKIoLzLVFNl8tNKKB9H3ZT2+zls9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbbyECV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CC2C113CC;
	Mon, 15 Apr 2024 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713199401;
	bh=HqN7TdZSCNbgHFtvjYms+Ul+s+gTntsHUY9FnuUU/Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbbyECV5u1njLxj1sF0tKve7TJuwGRRhA6T/bdFIVrWQ0FzQ1wDl68Mp/rvHOgSjQ
	 +qHqwmjimQphMf8bZmdCJYVc5qEmtTwZvY8TYWGXaXX85L4Vb7TmDSzQOaGQwh75uv
	 b2aX5MEA5lkd83gT8/34X+NtSGD6zXt4YwbFsNGclyTkZURGIbnxJOuWEoNHkasJJ8
	 VQV2jzbCjgzb2eI+Xe/qLqDrtUDGnbRtHMq6Ggn7LB8Y2+p0x5A1jIlMPbcmZzhlAS
	 2Gp6+IL7vEULSAIM8kbjp255kUoSO+dV4G0PoLmwNvMAZofiMYCxb3WcRR/RGw/I9i
	 EYtzWb7DFVESA==
Date: Mon, 15 Apr 2024 17:43:15 +0100
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
Subject: Re: [PATCH v7 17/23] dt-bindings: crypto: meson: remove clk and
 second interrupt line for GXL
Message-ID: <20240415-schnapps-plating-eb0895459004@spud>
References: <20240411133832.2896463-1-avromanov@salutedevices.com>
 <20240411133832.2896463-18-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IiySJqPLPF6ewTlK"
Content-Disposition: inline
In-Reply-To: <20240411133832.2896463-18-avromanov@salutedevices.com>


--IiySJqPLPF6ewTlK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 04:38:26PM +0300, Alexey Romanov wrote:
> GXL crypto IP isn't connected to clk and seconnd interrput line,
> so we must remove them from dt-bindings.

How does the device work without a clock?

Cheers,
Conor.

>=20
> Fixes: 7f7d115dfb51 ("dt-bindings: crypto: Add DT bindings
> documentation for amlogic-crypto")
>=20
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

--IiySJqPLPF6ewTlK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh1ZIwAKCRB4tDGHoIJi
0iLLAQDovtu6Lo9YH7fWCXHcFimMK0bA/cJ2pWBnM1sPsAdf2AD/abKRTjUdcDB5
z7YNr3N9wShAoF4Vf330Pxfn8jY+NAU=
=SyyT
-----END PGP SIGNATURE-----

--IiySJqPLPF6ewTlK--

