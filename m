Return-Path: <linux-kernel+bounces-22482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1368829E57
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E7F283053
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDAE4CB3E;
	Wed, 10 Jan 2024 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvsM2yLM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F76C4BAA3;
	Wed, 10 Jan 2024 16:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2A0C433C7;
	Wed, 10 Jan 2024 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704903469;
	bh=pbmSsy1/d6xhr1NG03LlnQKyRKDqNIQsX4bsmOvDy4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvsM2yLMyutDa9ogOPS0SwOZ4ivFss6rzuKCVYgE4yuHWSWQl2Vc7l/lmRuk4U3JU
	 3+VNA2r0i95Xy3BB4utIttOd27N1l02xdoJh5GTCGKTTUMjFGnRsSp7zH7yqP+UMS8
	 kr1gB0+XZBVMxZ4Kbgg7/4To3M55wGyHMiA52n81Y0nSBjsgM3ayhrtaGdHH1xd8yo
	 hIK46hbKH98MM0KzyUZGT8qFDmw3lQfwhj8l/MPiv0ebRr23kExR7rvkU8roGpoH9D
	 Xg+sLJx8feKllrMUTCebxd6gIQhuiCrXdWN3H3ndzRQQQCSh3ikR8zhHFL/tYSuYpC
	 XAaMNkf2F0QzA==
Date: Wed, 10 Jan 2024 16:17:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ceclan Dumitru <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: hmc425a: add conditional GPIO
 array size constraints
Message-ID: <20240110-unfitting-squander-b1d71c185bb7@spud>
References: <20240110153757.5754-1-mitrutzceclan@gmail.com>
 <20240110153757.5754-2-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ocmaXkT3FSa5q5AJ"
Content-Disposition: inline
In-Reply-To: <20240110153757.5754-2-mitrutzceclan@gmail.com>


--ocmaXkT3FSa5q5AJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 05:37:09PM +0200, Dumitru Ceclan wrote:
> ADRF5740 and HMC540S have a 4 bit parallel interface.
> Update ctr-gpios description and min/maxItems values depending on the
> matched compatible to correctly reflect the hardware properties.
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>

Seems like you need a Fixes: tag, since the original binding was wrong?

> ---
>  .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 33 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a=
=2Eyaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> index 67de9d4e3a1d..a434cb8ddcc9 100644
> --- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
> @@ -33,11 +33,38 @@ properties:
> =20
>    ctrl-gpios:
>      description:
> -      Must contain an array of 6 GPIO specifiers, referring to the GPIO =
pins
> -      connected to the control pins V1-V6.
> -    minItems: 6
> +      Must contain an array of GPIO specifiers, referring to the GPIO pi=
ns
> +      connected to the control pins.
> +        ADRF5740  - 4 GPIO connected to D2-D5
> +        HMC540S   - 4 GPIO connected to V1-V4
> +        HMC425A   - 6 GPIO connected to V1-V6
> +    minItems: 1
>      maxItems: 6
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,hmc425a
> +    then:
> +      properties:
> +        ctrl-gpios:
> +          minItems: 6

> +          maxItems: 6

This one should not be needed, it's already set by constraints on the
property above.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: adi,adrf5740
> +              - const: adi,hmc540s
> +    then:
> +      properties:
> +        ctrl-gpios:
> +          minItems: 4
> +          maxItems: 4

I'd say this should be an else, but that clearly would just be churn
since your next patch adds something with a different set of
constraints.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> +
>  required:
>    - compatible
>    - ctrl-gpios
> --=20
> 2.42.0
>=20

--ocmaXkT3FSa5q5AJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ7DKQAKCRB4tDGHoIJi
0j1+AQDpkvkoiKiOe2NBsll+Y6LgOQPhgPUftyg19N0ErtAPtQD/eOIioUVTYqnh
quZX75EybwW5nU18g2mZW9A+dBsUzw0=
=fYKx
-----END PGP SIGNATURE-----

--ocmaXkT3FSa5q5AJ--

