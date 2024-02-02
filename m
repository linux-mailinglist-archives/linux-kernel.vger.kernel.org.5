Return-Path: <linux-kernel+bounces-50135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F078474B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB51D1F2A22A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19DD1474CE;
	Fri,  2 Feb 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7Moz6Ig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5991474CD;
	Fri,  2 Feb 2024 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891353; cv=none; b=vC8SzVOjKtpLcTWUq7fkVhIQLuFqVNrW9rs/4CcfGPmfJHW7KKi1JrXGagCZTv3wa6pUYDiRHWNVH+9UhQriBmaeBnd8evlRZ66lpdxjRGi5o2U3WmVZmzvNAzdEVe4uqHvH5ffI5dQ/xPGuzBruM1+y3O/4b0BwezlCt8xzBmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891353; c=relaxed/simple;
	bh=98G9IePCbTbTJ4HmAf42k76x+JQnzIskPUOU0VvWz28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smGhfozGGrrUTwZ8/kfBx6+jKwhOj74M7RpED1pOOZKNmf41HmuR349FUtw8FkO+FBlLqcpLuOqBdWdAIKqreEV5YeFt1Zu0PRsTdVRI0X7xnS0jctRdemq8Eo5aLpD06wKqGokJsdDGdXcuUS4smGxwONYa9iD9bwXAHT9iZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7Moz6Ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03C7C433C7;
	Fri,  2 Feb 2024 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891352;
	bh=98G9IePCbTbTJ4HmAf42k76x+JQnzIskPUOU0VvWz28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7Moz6IgEOutVwCFEPAm5gxKiPRgnp5oc6njZVdKPcjQjp/sZ1i3Sx6KFelNiB8Xd
	 4YGBtSRUtYOymd1sRgHFOsTxyKJJIOle0Qu3KmQJg46UGlKTWlnEDviR54EPZA+hOu
	 V8lmgINzJMmNgjV/kr8djOVT2pS0Knb8NzDoFWbtzqg0xFjFOxa4+FU/kJadRrpMx6
	 gWIK/tPJSlriDfsaUviWheAAJnD+JzJwC946v8175fQZkqtAVsFbhYNJUZl8UVcXsU
	 XD7wkZprKYE8ENabFM+UVnJpxl1wBc5F6n+jGIxeKYRx6J5Fo04+IDePKr7tyW6QTq
	 wLFkYvqbqee5g==
Date: Fri, 2 Feb 2024 16:29:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti-ads1298: Add bindings
Message-ID: <20240202-lilly-dart-0968dbcc6b17@spud>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.50455eb1-2ccc-4e6a-b8ed-0c142743ae03@emailsignatures365.codetwo.com>
 <20240202105901.925875-1-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8aKFfDyEDP8k0FDZ"
Content-Disposition: inline
In-Reply-To: <20240202105901.925875-1-mike.looijmans@topic.nl>


--8aKFfDyEDP8k0FDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 11:59:00AM +0100, Mike Looijmans wrote:
> Bindings for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.
>=20
> The device has so many options for connecting stuff, at this
> point the bindings aren't nearly complete but partial bindings
> are better than no bindings at all.

I'm inclined to agree, particularly given your comments on v1.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>=20
> ---
>=20
> Changes in v2:
> Remove "clk" name
> Add datasheet and "incomplete" note
>=20
>  .../bindings/iio/adc/ti,ads1298.yaml          | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1298.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> new file mode 100644
> index 000000000000..bf5a43a81d59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ads1298 medical ADC chips
> +
> +description: |
> +  Datasheet at: https://www.ti.com/product/ADS1298
> +  Bindings for this chip aren't complete.
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads1298
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      Analog power supply, voltage between AVDD and AVSS. When providing=
 a
> +      symmetric +/- 2.5V, the regulator should report 5V.
> +
> +  vref-supply:
> +    description:
> +      Optional reference voltage. If omitted, internal reference is used,
> +      which is 2.4V when analog supply is below 4.4V, 4V otherwise.
> +
> +  clocks:
> +    description: Optional 2.048 MHz external source clock on CLK pin
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Interrupt on DRDY pin, triggers on falling edge
> +    maxItems: 1
> +
> +  label: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - interrupts
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@1 {
> +          reg =3D <1>;
> +          compatible =3D "ti,ads1298";
> +          label =3D "ads1298-1-ecg";
> +          avdd-supply =3D <&reg_iso_5v_a>;
> +          clocks =3D <&clk_ads1298>;
> +          interrupt-parent =3D <&gpio0>;
> +          interrupts =3D <78 IRQ_TYPE_EDGE_FALLING>;
> +          spi-max-frequency =3D <20000000>;
> +          spi-cpha;
> +        };
> +    };
> +...
> --=20
> 2.34.1
>=20
>=20
> Met vriendelijke groet / kind regards,
>=20
> Mike Looijmans
> System Expert
>=20
>=20
> TOPIC Embedded Products B.V.
> Materiaalweg 4, 5681 RJ Best
> The Netherlands
>=20
> T: +31 (0) 499 33 69 69
> E: mike.looijmans@topic.nl
> W: www.topic.nl
>=20
> Please consider the environment before printing this e-mail

--8aKFfDyEDP8k0FDZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb0YVAAKCRB4tDGHoIJi
0pgiAQDLmXCoilJP7jFxL0Q/yEzCgj/cMi+2Y6Z1OdtihVJ2xAEArqU2Y3pjTG6i
QDgq4HpsV4D2j70ezmHDJ6mL15ipZAU=
=ntYu
-----END PGP SIGNATURE-----

--8aKFfDyEDP8k0FDZ--

