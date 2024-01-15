Return-Path: <linux-kernel+bounces-26228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD5682DD10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184E62820BE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820E817BA8;
	Mon, 15 Jan 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrTxj9h8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0017BA1;
	Mon, 15 Jan 2024 16:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C89C433C7;
	Mon, 15 Jan 2024 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705335020;
	bh=w/OftDh4haN2MUyHJodrZDqK6lQj9eUZRQeCxQ/l7Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrTxj9h8iv3oUVYDlsDMw6ziBXPwyLBfz1FBQFz1heG31SYFyJOeUEjqZT04R/kQT
	 oyP2cP8Ir19etl5iRIbATXbSLxSUonr0Y7EftVyljpVF426h+dauRzy2AUqa9JLUlL
	 uvxgUU+4mUiLMQj3LvXtY9avfeK/nAR2Pt0CQRQSuUIygt2LQPNVoX+QnuzrZ56tlb
	 zrJKICdYsb1Wxa05xvMMfs7XJ3MC5JmF8zm4h+4fNBlWsiFVnDGZdc4Um7jvBBkJmi
	 F6duLj91sviOzFqpwdxWAeIwKoK3Vh4JXmzWqpbY/X8EPQfOpeKOKOjsbTqulHqEfC
	 M0JSUGFpvTK2A==
Date: Mon, 15 Jan 2024 16:10:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: adc: ad7173: add support for additional
 models
Message-ID: <20240115-praising-disdain-d81d4ce69194@spud>
References: <20240115135416.10595-1-mitrutzceclan@gmail.com>
 <20240115135416.10595-2-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sV1oz/EzmBq1F27T"
Content-Disposition: inline
In-Reply-To: <20240115135416.10595-2-mitrutzceclan@gmail.com>


--sV1oz/EzmBq1F27T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 03:53:04PM +0200, Dumitru Ceclan wrote:
> Add support for: AD7172-2, AD7175-8, AD7177-2
> Add hardware description of the AD771X family instead of "Bindings for"
> AD7172-4 does not feature an internal reference, check for ext-ref
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>  .../bindings/iio/adc/adi,ad7173.yaml          | 50 +++++++++++++++++--
>  1 file changed, 46 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> index 7c8caef76528..6d4b26e43144 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -11,19 +11,33 @@ maintainers:
>    - Ceclan Dumitru <dumitru.ceclan@analog.com>
> =20
>  description: |
> -  Bindings for the Analog Devices AD717X ADC's. Datasheets for supported=
 chips:
> +  Analog Devices AD717X ADC's:
> +  The AD717x family offer a complete integrated Sigma-Delta ADC solution=
 which
> +  can be used in high precision, low noise single channel applications
> +  (Life Science measurements) or higher speed multiplexed applications
> +  (Factory Automation PLC Input modules). The Sigma-Delta ADC is intended
> +  primarily for measurement of signals close to DC but also delivers out=
standing
> +  performance with input bandwidths out to ~10kHz.
> +
> +  Datasheets for supported chips:
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-4.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7175-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7175-8.pdf
>      https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7176-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7177-2.pdf
> =20
>  properties:
>    compatible:
>      enum:
>        - adi,ad7172-2
> +      - adi,ad7172-4
>        - adi,ad7173-8
>        - adi,ad7175-2
> +      - adi,ad7175-8
>        - adi,ad7176-2
> +      - adi,ad7177-2
> =20
>    reg:
>      maxItems: 1
> @@ -89,8 +103,10 @@ patternProperties:
>            refout-avss: REFOUT/AVSS (Internal reference)
>            avdd       : AVDD
> =20
> -          External reference refin2 only available on ad7173-8.
> -          If not specified, internal reference used.
> +          External reference refin2 only available on ad7173-8 and ad717=
2-4.
> +          Internal reference refout-avss not available on ad7172-4.
> +
> +          If not specified, internal reference used (if available).
>          $ref: /schemas/types.yaml#/definitions/string
>          enum:
>            - refin
> @@ -111,12 +127,15 @@ required:
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> =20
> +  # Only ad7172-4 and ad7173-8 support refin2
>    - if:
>        properties:
>          compatible:
>            not:
>              contains:
> -              const: adi,ad7173-8
> +              anyOf:
> +                - const: adi,ad7172-4
> +                - const: adi,ad7173-8
>      then:
>        properties:
>          refin2-supply: false
> @@ -129,6 +148,29 @@ allOf:
>                  - refout-avss
>                  - avdd
> =20
> +  # Model ad7172-4 does not support internal reference
> +  #  mandatory to have an external reference
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,ad7172-4
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-f]$":
> +          properties:
> +            adi,reference-select:
> +              enum:
> +                - refin
> +                - refin2
> +                - avdd
> +              default: false

The default shouldn't be needed here since the property is required.

> +          required:
> +            - adi,reference-select
> +      oneOf:
> +        - required: [refin2-supply]
> +        - required: [refin-supply]

I'm a little curious - the enum allows avdd but you are requiring one of
these two references to be set. Is one required if avdd is used as the
reference?

Thanks,
Conor.

> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.42.0
>=20

--sV1oz/EzmBq1F27T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaVY5QAKCRB4tDGHoIJi
0g7lAQCHDDAXjWK+zjzjnxHJR7BmkaEep2iUVKmmYQAuU3Z6twEAgeAYhyvVcXaM
9H46UOZvwaIiwAfWx07mC2comwosZAM=
=tR9x
-----END PGP SIGNATURE-----

--sV1oz/EzmBq1F27T--

