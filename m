Return-Path: <linux-kernel+bounces-33951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DB28370A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C720E1F28F23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781740C0B;
	Mon, 22 Jan 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFH6ERSa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00213E474;
	Mon, 22 Jan 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947312; cv=none; b=ox3NRb0LSUwJo308mZ6SVAp4VDGTADYU65DoMSL9fUNPPL4KSvdAyqvhuEb24MOjqxwbuvymAq4WcQX67SxWyEHINecTjCwcNTcOEJDYAjHt4FhhSC+0GWY5Fl6yekdo+OHMzZAgcJ69IO0kFf2TFmchJRQRuReTVdxC+2N9hL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947312; c=relaxed/simple;
	bh=5C6exGsza/X9DUjMWBVUbMQ8kIAdM/dB4GnTMkspNvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABdTO+hevpqrU46SddQBuAnx/RVNeUysT7JsdgK3j+k3uq1wbR/u55iJ1zgP6dPXZCCdA/odbhbjlj6RQZwXQGbUoMjQqeRFlAn8KdSj16vjFfFkzOfwwhTG29x+GbuR8qb2pkIPaSI4gwT9Eg3qy72Uvoa5libcA3PI1y2cNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFH6ERSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7914C433F1;
	Mon, 22 Jan 2024 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705947312;
	bh=5C6exGsza/X9DUjMWBVUbMQ8kIAdM/dB4GnTMkspNvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFH6ERSazTj7JSLmqipaSOie1Xtw42+N/ydXvMtTYFTdI/xdEmwl8spUQrD9xEteI
	 sJbHLiw+QOjxZU5e4ldpPhlW7guyekXTNG/U2KFDuhwUqTSoiMCAjsB1oNMenhqwG3
	 vxAJVbKuQPkxuclBO7fm1OmmcpMAUmSB72t68Y9DpEJ/rIQrvggqjGDAR71AxjbN5W
	 yn45wlO9Zcjv4p2RhIkV+FmCfp1I1T7qgPKngZGfM4QtJ+r5fQqbWOCPiEWz6OALVh
	 e+wgfqn9Vr2LbO/XqpfJf0JNrl3ETT6/5usALK9UfgSatJMVABZVYyOD0GYgJ81RGA
	 Dv8QWnwfvLxAw==
Date: Mon, 22 Jan 2024 18:15:07 +0000
From: Conor Dooley <conor@kernel.org>
To: marius.cristea@microchip.com
Cc: jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
	jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: adding support for PAC193X
Message-ID: <20240122-fernlike-resolute-b16772806147@spud>
References: <20240122084712.11507-1-marius.cristea@microchip.com>
 <20240122084712.11507-2-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qi0TL78qGZaNp8GQ"
Content-Disposition: inline
In-Reply-To: <20240122084712.11507-2-marius.cristea@microchip.com>


--qi0TL78qGZaNp8GQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Marius,

On Mon, Jan 22, 2024 at 10:47:11AM +0200, marius.cristea@microchip.com wrot=
e:
> From: Marius Cristea <marius.cristea@microchip.com>
>=20
> This is the device tree schema for iio driver for
> Microchip PAC193X series of Power Monitors with Accumulator.
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

I like how this is looking now. I have two minor comments that if you
resend for some other reason you could change, but otherwise:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  .../bindings/iio/adc/microchip,pac1934.yaml   | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,p=
ac1934.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> new file mode 100644
> index 000000000000..cd9cb2a71566
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1934.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1934.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1934 Power Monitors with Accumulator
> +
> +maintainers:
> +  - Marius Cristea <marius.cristea@microchip.com>
> +
> +description: |
> +  This device is part of the Microchip family of Power Monitors with
> +  Accumulator.
> +  The datasheet for PAC1931, PAC1932, PAC1933 and PAC1934 can be found h=
ere:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Produ=
ctDocuments/DataSheets/PAC1931-Family-Data-Sheet-DS20005850E.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pac1931
> +      - microchip,pac1932
> +      - microchip,pac1933
> +      - microchip,pac1934
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  slow-io-gpios:
> +    description: |

This...

> +      A GPIO used to trigger a change is sampling rate (lowering the chi=
p power
> +      consumption). If configured in SLOW mode, if this pin is forced hi=
gh,
> +      sampling rate is forced to eight samples/second. When it is forced=
 low,
> +      the sampling rate is 1024 samples/second unless a different sample=
 rate
> +      has been programmed.
> +
> +patternProperties:
> +  "^channel@[1-4]+$":
> +    type: object
> +    $ref: adc.yaml
> +    description: |

=2E..and this...

> +        Represents the external channels which are connected to the ADC.
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 1
> +          maximum: 4
> +
> +      shunt-resistor-micro-ohms:
> +        description: |

=2E..and this | are not needed here as you have no formatting to preserve.

> +          Value in micro Ohms of the shunt resistor connected between
> +          the SENSE+ and SENSE- inputs, across which the current is meas=
ured.
> +          Value is needed to compute the scaling of the measured current.
> +
> +    required:
> +      - reg
> +      - shunt-resistor-micro-ohms
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        pac193x: power-monitor@10 {

This "pac193x" label is not used and should be removed.

Thanks,
Conor.

> +            compatible =3D "microchip,pac1934";
> +            reg =3D <0x10>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            channel@1 {
> +                reg =3D <0x1>;
> +                shunt-resistor-micro-ohms =3D <24900000>;
> +                label =3D "CPU";
> +            };
> +
> +            channel@2 {
> +                reg =3D <0x2>;
> +                shunt-resistor-micro-ohms =3D <49900000>;
> +                label =3D "GPU";
> +            };
> +
> +            channel@3 {
> +                reg =3D <0x3>;
> +                shunt-resistor-micro-ohms =3D <75000000>;
> +                label =3D "MEM";
> +                bipolar;
> +            };
> +
> +            channel@4 {
> +                reg =3D <0x4>;
> +                shunt-resistor-micro-ohms =3D <100000000>;
> +                label =3D "NET";
> +                bipolar;
> +            };
> +        };
> +    };
> +
> +...
> --=20
> 2.34.1
>=20

--qi0TL78qGZaNp8GQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa6wqwAKCRB4tDGHoIJi
0q6hAP0QD1uLecPK8JtF9dahFAlvXtAIK2MF/bEG/+d2xCVPwAD+NitieK6tvevt
VhVPZLPjU6FN4abGu0j2yODLo75rmQg=
=CcoM
-----END PGP SIGNATURE-----

--qi0TL78qGZaNp8GQ--

