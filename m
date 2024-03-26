Return-Path: <linux-kernel+bounces-119643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D0B88CB7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837B91F82974
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F7780C1F;
	Tue, 26 Mar 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhqPwuZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014641C2AF;
	Tue, 26 Mar 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476293; cv=none; b=LIuD8tXiz1ctkXP3rOxhlzoZYytlSQOaoiIOBkjbNXPRUB9FXGGwkOBcOq6OW7OLEeVcx8LAJborbdZzxbVqgZO18NjZFq/qrStzQ1uaooB9HI1Uxw7wemDGETARcEQ70enx+2KmeYts3kSoRmJ+xiW2SpyN1m67anbzbwdh5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476293; c=relaxed/simple;
	bh=FpwR17g2PH56G0XDh6Pi3WB67cdLCnSyZjbxboXsr0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1xPafAie7fDsuf+0O8Hs6Ahv6Nefcio/yyFwhZO3O9+gyGBOHh+PiCJND6Q94P/Bban9JziEnRuO4OVMOp3OWbKyhkjzaC8rO4ahKeBDwI6BdoDlAnhE4GClMaPaGDKu8xnv662CuGk1JyP98y69CkJu4GArg/XKFm78V5Gg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhqPwuZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14588C433F1;
	Tue, 26 Mar 2024 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711476292;
	bh=FpwR17g2PH56G0XDh6Pi3WB67cdLCnSyZjbxboXsr0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhqPwuZTdQ1s7BpgL1VIfuejwlhhnnaQebCxnJRAG0seH7mpEyQLj8LiyS6MhTs3D
	 lAsHUNE6c5YMjRyPqRfd1SioWqtf+T74GNlkByMBviw6YJiCSjPGxhY8iRV7s+qwcw
	 qvxfkjefy4d0o2sX9eBnM6zuVZg4clFyVlPCmIJyIxM8jje4z1vxa1H/D7ZoHNxCAe
	 guE2pbxtTTqlzpZDIeZhzbw08HFzcIv+Jo5mI8SXPjbXWVcQQZBNyz5cPX9gVYg6VV
	 t3oNj0XtFGgXIuFircYNgE4t+HXmIX9iZSHEVETnqq+FzRLbUdLtwNm0Oh2a/ILudH
	 H3VeWif2pNhEA==
Date: Tue, 26 Mar 2024 18:04:46 +0000
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
Subject: Re: [PATCH v6 19/23] dt-bindings: crypto: meson: support new SoC's
Message-ID: <20240326-boneless-patrol-b1156a4be70b@spud>
References: <20240326153219.2915080-1-avromanov@salutedevices.com>
 <20240326153219.2915080-20-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TsFS7LpYqhJ6X8MW"
Content-Disposition: inline
In-Reply-To: <20240326153219.2915080-20-avromanov@salutedevices.com>


--TsFS7LpYqhJ6X8MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 06:32:15PM +0300, Alexey Romanov wrote:
> Now crypto module available at G12A/G12B/S4/A1/SM1/AXG.
>=20
> 1. Add new compatibles:
>   - amlogic,g12a-crypto
>   - amlogic,axg-crypto
>   - amlogic,a1-crypto
>   - amlogic,s4-crypto (uses a1-crypto as fallback)
>=20
> 2. Add power-domains in schema.
>=20
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  .../bindings/crypto/amlogic,gxl-crypto.yaml       | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.=
yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> index d3af7b4d5f39..c92edde314aa 100644
> --- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> +++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> @@ -11,8 +11,16 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    items:
> -      - const: amlogic,gxl-crypto
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,s4-crypto
> +          - const: amlogic,a1-crypto
> +      - enum:
> +          - amlogic,gxl-crypto
> +          - amlogic,axg-crypto
> +          - amlogic,g12a-crypto
> +          - amlogic,a1-crypto
> =20
>    reg:
>      maxItems: 1
> @@ -21,6 +29,9 @@ properties:
>      items:
>        - description: Interrupt for flow 0
> =20
> +  power-domains:
> +    maxItems: 1

Is power-domains valid for the devices that existed prior to your patch?

--TsFS7LpYqhJ6X8MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMOPgAKCRB4tDGHoIJi
0tshAQCtbEqOHiJFUm5lxRMtAn+5YxU2CDgCh0rFA4v9v07M5QEAtxnoZzj0b3c8
yH8w5AJrE8FRKbXSqTKMNF83M4Te2Qo=
=OFV3
-----END PGP SIGNATURE-----

--TsFS7LpYqhJ6X8MW--

