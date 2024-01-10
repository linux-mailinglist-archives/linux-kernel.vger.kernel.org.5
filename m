Return-Path: <linux-kernel+bounces-22484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD9E829E5E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40251C22B88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A734CB44;
	Wed, 10 Jan 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pY6jjH47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6284CB2D;
	Wed, 10 Jan 2024 16:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C8CC433F1;
	Wed, 10 Jan 2024 16:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704903502;
	bh=nU3COBzq4pLx6zAhVKFwSz115z9oTUjZ0QeUJviR93M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pY6jjH477CM7IrNtbWxIRcL6AwTNBPrKJ7b8toeEoU9IkYb5sVjTdXqAGORPIArKj
	 33XVs3qwxqevL4KCOYlnUABtYmMdZdXOdFi36+m3WMu+cs5Q+qlW4DxAgdvTTBHtJd
	 JHtDF7mLrbBk9Cwi8d29PYZ2Lk+cMLi9A/cWzu3XOcrB5d22wi3RKHrEREkl4zaNrw
	 M3CJ0tvs8NcfWyKRApS3GcUzwtSnzl869vd7bxZEo8sKV3ammouiDWKGvgBXzhG4A7
	 VOF4Adr3om5kssiAYNzdmr9vFl/vc45yfKxCMpMEKFSQGRRKOuqgLW30edh0avWbdh
	 7vv3zo8y2WlRg==
Date: Wed, 10 Jan 2024 16:18:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: hmc425a: add entry for LTC6373
Message-ID: <20240110-employer-morphine-5ed8b4ab4e2e@spud>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
 <20240110153757.5754-3-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0JxhTmKDSBQWo7rj"
Content-Disposition: inline
In-Reply-To: <20240110153757.5754-3-mitrutzceclan@gmail.com>


--0JxhTmKDSBQWo7rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 05:37:10PM +0200, Dumitru Ceclan wrote:
> The LTC6373 is a silicon, 3-bit Fully-Differential digital instrumentation
> amplifier that supports the following programmable gains (Vout/Vin):
>  G =3D 0.25, 0.5, 1, 2, 4, 8, 16 + Shutdown.
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/iio/amplifiers/adi,hmc425a.yaml       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a=
=2Eyaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> index a434cb8ddcc9..3a470459b965 100644
> --- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> @@ -21,6 +21,8 @@ description: |
>    HMC540S 1 dB LSB Silicon MMIC 4-Bit Digital Positive Control Attenuato=
r, 0.1 - 8 GHz
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
hmc540s.pdf
> =20
> +  LTC6373 is a 3-Bit precision instrumentation amplifier with fully diff=
erential outputs
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
ltc6373.pdf
> =20
>  properties:
>    compatible:
> @@ -28,6 +30,7 @@ properties:
>        - adi,adrf5740
>        - adi,hmc425a
>        - adi,hmc540s
> +      - adi,ltc6373
> =20
>    vcc-supply: true
> =20
> @@ -38,6 +41,7 @@ properties:
>          ADRF5740  - 4 GPIO connected to D2-D5
>          HMC540S   - 4 GPIO connected to V1-V4
>          HMC425A   - 6 GPIO connected to V1-V6
> +        LTC6373   - 3 GPIO connected to A0-A2
>      minItems: 1
>      maxItems: 6
> =20
> @@ -64,6 +68,16 @@ allOf:
>          ctrl-gpios:
>            minItems: 4
>            maxItems: 4
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ltc6373
> +    then:
> +      properties:
> +        ctrl-gpios:
> +          minItems: 3
> +          maxItems: 3
> =20
>  required:
>    - compatible
> --=20
> 2.42.0
>=20

--0JxhTmKDSBQWo7rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ7DSgAKCRB4tDGHoIJi
0t7uAP9JvFc7x2g3jXsi84nAehApcV7rM5etRnNTadBaxvY/SgEAuU0ALz/eBEcR
4nvxbb7MSRK9sSHdm1eyshtDwNqMKwA=
=yUmA
-----END PGP SIGNATURE-----

--0JxhTmKDSBQWo7rj--

