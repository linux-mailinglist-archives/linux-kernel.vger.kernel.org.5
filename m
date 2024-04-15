Return-Path: <linux-kernel+bounces-145580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A278A5810
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2CF1C21ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8098248E;
	Mon, 15 Apr 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiImsyMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207EE1FDD;
	Mon, 15 Apr 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199478; cv=none; b=m7wKyh4N6tJJ0qSV+uuOArA2AOxBuJmZ5Z3wyTinqjcYsVxaipidL6H67hivrZiUJeRrKLLqDHIjeh+jtPK8Fc99wb6UnSWNAbTQxp0e2HhWNAzRRVLdCJtoH8YguKnJ7BPb9PHtcUPo1C/Ceo+Uz3CUNrv67nrQD6KM2LJ34yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199478; c=relaxed/simple;
	bh=/PeuD96WIZJSMjilmlalAw5Sh612uVNegKTxOfnIhCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHXQvW2MpWHh8jxTA0vndaUQVzDxMHk2lR1qGxg35GhBWSPElPUQflGOnj9XIzeFsvHWW2LTpXftkn5dDfVheYXvT4SGzBIEciHY/oxadzG2dEgQjTtqABrMAcYccGAfjyWt1hVNDgpBcamyjUWDpcekLss2+0afX9cJYuWZhvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiImsyMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421BDC113CC;
	Mon, 15 Apr 2024 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713199477;
	bh=/PeuD96WIZJSMjilmlalAw5Sh612uVNegKTxOfnIhCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiImsyMOvAhGFvPt+0Jnit7mkby93vTkBGiG2SQPOxSDq/k70rItcAceLzyahP2aU
	 3Ym5JdHSA1n8l0qmqKaMQtRLw4QMjXmtIZ8kOdNEYy/BVy+qjoztuXOSYRm7gIUrtG
	 dTo+UAlj4CXPF+Fn7I0C3v+ibIBax2NbysBOXbFObAqU6CAl38iC0k2amsjV8UDAf1
	 AtjsttY8BUTr1wqpcgC7JWHZcHsHkIjBYhd7N3OS3vMBKvXPRV2J93X88ELOAfaITJ
	 JNDe6d0CIwoeF0G6D1bDho5YGE3CkKXtvtEzz4m6pImy9C8WaAG8AESfT97Em4iCGD
	 XVdZ+wUwEds6A==
Date: Mon, 15 Apr 2024 17:44:32 +0100
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
Subject: Re: [PATCH v7 19/23] dt-bindings: crypto: meson: support new SoC's
Message-ID: <20240415-armrest-chokehold-e5027ecd4ef6@spud>
References: <20240411133832.2896463-1-avromanov@salutedevices.com>
 <20240411133832.2896463-20-avromanov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AauLJy3HD9QY9WGP"
Content-Disposition: inline
In-Reply-To: <20240411133832.2896463-20-avromanov@salutedevices.com>


--AauLJy3HD9QY9WGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 04:38:28PM +0300, Alexey Romanov wrote:
> Now crypto module available at G12A/G12B/S4/A1/SM1/AXG.
>=20
> 1. Add new compatibles:
>   - amlogic,g12a-crypto
>   - amlogic,axg-crypto
>   - amlogic,a1-crypto
>   - amlogic,s4-crypto (uses a1-crypto as fallback)

The commit message should mention why most of these devices are not
compatible with eachother (be that different algorithms available etc)

Thanks,
Conor.

>=20
> 2. Add power-domains in schema, which is required only for A1.
>=20
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>  .../bindings/crypto/amlogic,gxl-crypto.yaml   | 24 +++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.=
yaml b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
> index d3af7b4d5f39..23743701952a 100644
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
> @@ -21,11 +29,23 @@ properties:
>      items:
>        - description: Interrupt for flow 0
> =20
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: amlogic,a1-crypto
> +    then:
> +      required:
> +        - power-domains
> +
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.34.1
>=20

--AauLJy3HD9QY9WGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh1ZcAAKCRB4tDGHoIJi
0tO6AP9x7P3GKoxerzltNOawstZRE73mkiQXZ84qfhSGloZOggEA38mkqZEFSXOe
SDYdmAePKbFVRq3BsEG85zqyyN9JyAE=
=TCep
-----END PGP SIGNATURE-----

--AauLJy3HD9QY9WGP--

