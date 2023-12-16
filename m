Return-Path: <linux-kernel+bounces-2400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84958815C9E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 00:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C81C284365
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300BF37D08;
	Sat, 16 Dec 2023 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8YvkXZ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113D39ADF;
	Sat, 16 Dec 2023 23:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AA1C433C8;
	Sat, 16 Dec 2023 23:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702770909;
	bh=jUWCpQuntd7FLZ5VSvblzKYwGE3d0UrsZ5sCSburff4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8YvkXZ+g+79moR5UrJbKEVmttUNh0VC3orUH1inTDoh4QrTY0xYJSiCjOY0+Sa/u
	 ifenv2hVyrBHS2iWoOxLC7C0rj/T57R7I2LcbwGMuJVbdRQuVWy4Sg+l+tUtfnNySO
	 R7UYfZ2/D8OUG2jMpkNwFW/D2WpfzA5m0NFrEQXJXpEbyebMcbdLRfobjzHhm9z32F
	 +ks3eMaF1YkBCxcuwesnSnwSqxYT/axFlBMefhaIp53uJ1VAUc+ZShZVWpt+VHUPXe
	 ohot3Dql1+eU4WbVtrG1LEiJtBhNpZCbIVnp/9Lr2x+II2/khXim3yJwXsjyHnICit
	 Z6n2Jde364EWA==
Date: Sat, 16 Dec 2023 23:55:04 +0000
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com, paul.cercueil@analog.com,
	Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, dan.carpenter@linaro.org,
	dlechner@baylibre.com, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/15] dt-bindings: iio: Add AD7091R-8
Message-ID: <20231216-curfew-sandbox-69a0aac58010@spud>
References: <cover.1702746240.git.marcelo.schmitt1@gmail.com>
 <7c725dbb0ddeeec77d56bb67c77e819b4ba78e2e.1702746240.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Th6k7RUxHz5pajtC"
Content-Disposition: inline
In-Reply-To: <7c725dbb0ddeeec77d56bb67c77e819b4ba78e2e.1702746240.git.marcelo.schmitt1@gmail.com>


--Th6k7RUxHz5pajtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 02:50:11PM -0300, Marcelo Schmitt wrote:
> Add device tree documentation for AD7091R-8.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/iio/adc/adi,ad7091r5.yaml        | 82 ++++++++++++++++++-
>  1 file changed, 78 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml =
b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> index ce7ba634643c..ddec9747436c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> @@ -4,36 +4,92 @@
>  $id: http://devicetree.org/schemas/iio/adc/adi,ad7091r5.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Analog Devices AD7091R5 4-Channel 12-Bit ADC
> +title: Analog Devices AD7091R-2/-4/-5/-8 Multi-Channel 12-Bit ADCs
> =20
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> =20
>  description: |
> -  Analog Devices AD7091R5 4-Channel 12-Bit ADC
> +  Analog Devices AD7091R5 4-Channel 12-Bit ADC supporting I2C interface
>    https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
7091r-5.pdf
> +  Analog Devices AD7091R-2/AD7091R-4/AD7091R-8 2-/4-/8-Channel 12-Bit AD=
Cs
> +  supporting SPI interface
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7091R-2_7091R-4_7091R-8.pdf
> =20
>  properties:
>    compatible:
>      enum:
> +      - adi,ad7091r2
> +      - adi,ad7091r4
>        - adi,ad7091r5
> +      - adi,ad7091r8
> =20
>    reg:
>      maxItems: 1
> =20
> +  vdd-supply:
> +    description:
> +      Provide VDD power to the sensor (VDD range is from 2.7V to 5.25V).
> +
> +  vdrive-supply:
> +    description:
> +      Determines the voltage level at which the interface logic will ope=
rate.
> +      The V_drive voltage range is from 1.8V to 5.25V and must not excee=
d VDD by
> +      more than 0.3V.
> +
>    vref-supply:
>      description:
>        Phandle to the vref power supply
> =20
> -  interrupts:
> +  convst-gpios:
> +    description:
> +      GPIO connected to the CONVST pin.
> +      This logic input is used to initiate conversions on the analog
> +      input channels.
>      maxItems: 1
> =20
> +  reset-gpios:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt for signaling when conversion results exceed the high li=
mit for
> +      ADC readings or fall below the low limit for them. Interrupt sourc=
e must
> +      be attached to ALERT/BUSY/GPO0 pin.
> +    maxItems: 1
> =20
>  required:
>    - compatible
>    - reg
> =20
> -additionalProperties: false
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +  # AD7091R-2 does not have ALERT/BUSY/GPO pin
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7091r2
> +    then:
> +      properties:
> +        interrupts: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7091r2
> +              - adi,ad7091r4
> +              - adi,ad7091r8
> +    then:
> +      required:
> +        - convst-gpios
> +
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> @@ -51,4 +107,22 @@ examples:
>              interrupt-parent =3D <&gpio>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ad7091r8";
> +            reg =3D <0x0>;
> +            spi-max-frequency =3D <1000000>;
> +            vref-supply =3D <&adc_vref>;
> +            convst-gpios =3D <&gpio 25 GPIO_ACTIVE_LOW>;
> +            reset-gpios =3D <&gpio 27 GPIO_ACTIVE_LOW>;
> +            interrupts =3D <22 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent =3D <&gpio>;
> +        };
> +    };
>  ...
> --=20
> 2.42.0
>=20

--Th6k7RUxHz5pajtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX442AAKCRB4tDGHoIJi
0puPAP481u/M1/SE7A3mGnzFFhFkdDY4nGG8wkkWzNIYlFCwqgEAxTcIAVT87Vjy
v52dK6ZRY/blA9VyxQfCS/FpCiyx8QI=
=0TDZ
-----END PGP SIGNATURE-----

--Th6k7RUxHz5pajtC--

