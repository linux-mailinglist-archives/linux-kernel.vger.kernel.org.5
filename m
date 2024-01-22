Return-Path: <linux-kernel+bounces-32648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122EE835E70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27BF288E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FD439AF0;
	Mon, 22 Jan 2024 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSIKnsBC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996A03A1A7;
	Mon, 22 Jan 2024 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916672; cv=none; b=WOQ2Qb7o0MsXzvkifQewkgO+2IMfeZFgIjqW0b5rDDh9OF7QJzD4/5ovw4dJPgY6UgbZ021h6cbqqiCykCOPQs0aUyRRZ0ykX+ORYEpBOZXHD1DQxhB2mNkd/y0neicNwlbBJttDu1S2BGwhSEc4QPBzaEX47tQtsmQErfI1pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916672; c=relaxed/simple;
	bh=GY6PcmbIF9Qpqroe0TsnpiA3WkmL1RQflcaVlhKawjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vc9IYQ6G/f+UsfqzCRwVCLcjRq4gi2go41Wq2GkEpi1XCAFFk5QeiNGnUAra8GD1TIHwUuKfvbyh4gCHnPPXYCS1beNu9dZCzGRgKapjMKQHxJiaW6sh0wnoW+SPTpFLpMO4Nd83z0f81ipmMYx3DOmGt3eFnmVYh6Qsb5RLw50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSIKnsBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A31EC43394;
	Mon, 22 Jan 2024 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705916672;
	bh=GY6PcmbIF9Qpqroe0TsnpiA3WkmL1RQflcaVlhKawjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSIKnsBC6To/LxdrtsvvyRhyZLag8inXq4kjp/1CGvM/xmUZ3hPFUYKgt3xSFji5P
	 sla7RIsjwi3FQjm8Zt8kXVYLO68TXIr3eL60+8maoETczAeYK/z6CjmlZS7IfZQ0wJ
	 b0ZWzeN+e6rSMOotVhnrYpCGFNSoCaox3ImLvrHM67E3TUPIWTkdYBSpIBMXKxEyzw
	 Xw1ROns0JJW0goJ1yT7brddSw4tBuFUarJp7WwzMqmX341h3hIjBbPrNHKfwHQiNCu
	 ci21KaTeWMKSucBGc4eq5qTAdV5r6BSNwTi5/kt/2/Xe7ZTzUNE1RddVlCGwUH8vB8
	 6QqKbyWPwOdzA==
Date: Mon, 22 Jan 2024 09:44:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Crt Mori <cmo@melexis.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <20240122-legible-fossil-25349ef9ad6c@spud>
References: <20240122090228.28363-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DdGHYOPWa0l7wFu5"
Content-Disposition: inline
In-Reply-To: <20240122090228.28363-1-kimseer.paller@analog.com>


--DdGHYOPWa0l7wFu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 05:02:27PM +0800, Kim Seer Paller wrote:
> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
> V6 -> V7: Changed RF path mode property to boolean.

In the process, the description went from attempting to explain what the
property did to the perfunctory "enable mixer mode". Can you please add
an adequate description of the property that covers what happens when
the property is omitted and what "mixer mode" actually does?

> V5 -> V6: Moved array of switch and attenuation GPIOs to the channel node.
>           Changed pin coords with friendly names. Removed Reviewed-by tag.
> V4 -> V5: Added Reviewed-by tag.
> V3 -> V4: Updated the description of the properties with multiple entries=
 and
>           defined the order.
> V2 -> V3: Adjusted indentation to resolve wrong indentation warning.=20
>           Changed node name to converter. Updated the descriptions to cla=
rify
>           the properties.
> V1 -> V2: Removed '|' after description. Specified the pins connected to
>           the GPIOs. Added additionalProperties: false. Changed node name=
 to gpio.
>           Aligned < syntax with the previous syntax in the examples.
>=20
>  .../bindings/iio/frequency/adi,admfm2000.yaml | 124 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,a=
dmfm2000.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm200=
0.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> new file mode 100644
> index 000000000000..9e716f59d678
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> @@ -0,0 +1,124 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2024 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,admfm2000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADMFM2000 Dual Microwave Down Converter
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description:
> +  Dual microwave down converter module with input RF and LO frequency ra=
nges
> +  from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
> +  It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each=
 down
> +  conversion path.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,admfm2000
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-1]$":
> +    type: object
> +    description: Represents a channel of the device.
> +
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        description:
> +          The channel number.
> +        minimum: 0
> +        maximum: 1
> +
> +      adi,mixer-mode:
> +        description:
> +          Enable mixer mode.
> +        type: boolean
> +
> +      switch-gpios:
> +        description: |
> +          GPIOs to select the RF path for the channel.
> +          SW-CH1   CTRL-A   CTRL-B
> +          SW-CH2   CTRL-A   CTRL-B    CH1 Status        CH2 Status
> +                   1        0         Direct IF mode    Mixer mode
> +                   0        1         Mixer mode        Direct IF mode

I cannot make sense of this table you have here, the double header row
you have going on is hard to follow. There's also no mention here of
what happens when both GPIOs are 0 or both GPIO are 1. Are these
configurations permitted?

Thanks,
Conor

> +        items:
> +          - description: SW-CH-CTRL-A GPIO
> +          - description: SW-CH-CTRL-B GPIO
> +
> +      attenuation-gpios:
> +        description: |
> +          Choice of attenuation:
> +          DSA-V4  DSA-V3  DSA-V2  DSA-V1  DSA-V0
> +          1       1       1       1       1        0 dB
> +          1       1       1       1       0        -1 dB
> +          1       1       1       0       1        -2 dB
> +          1       1       0       1       1        -4 dB
> +          1       0       1       1       1        -8 dB
> +          0       1       1       1       1        -16 dB
> +          0       0       0       0       0        -31 dB
> +
> +        items:
> +          - description: DSA-V0 GPIO
> +          - description: DSA-V1 GPIO
> +          - description: DSA-V2 GPIO
> +          - description: DSA-V3 GPIO
> +          - description: DSA-V4 GPIO
> +
> +    required:
> +      - reg
> +      - switch-gpios
> +      - attenuation-gpios
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    converter {
> +      compatible =3D "adi,admfm2000";
> +
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      channel@0 {
> +        reg =3D <0>;
> +        switch-gpios =3D <&gpio 1 GPIO_ACTIVE_LOW>,
> +                       <&gpio 2 GPIO_ACTIVE_HIGH>;
> +
> +        attenuation-gpios =3D <&gpio 17 GPIO_ACTIVE_LOW>,
> +                            <&gpio 22 GPIO_ACTIVE_LOW>,
> +                            <&gpio 23 GPIO_ACTIVE_LOW>,
> +                            <&gpio 24 GPIO_ACTIVE_LOW>,
> +                            <&gpio 25 GPIO_ACTIVE_LOW>;
> +      };
> +
> +      channel@1 {
> +        reg =3D <1>;
> +        adi,mixer-mode;
> +        switch-gpios =3D <&gpio 3 GPIO_ACTIVE_LOW>,
> +                       <&gpio 4 GPIO_ACTIVE_HIGH>;
> +
> +        attenuation-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW>,
> +                            <&gpio 5 GPIO_ACTIVE_LOW>,
> +                            <&gpio 6 GPIO_ACTIVE_LOW>,
> +                            <&gpio 16 GPIO_ACTIVE_LOW>,
> +                            <&gpio 26 GPIO_ACTIVE_LOW>;
> +      };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..1f7cd2e848de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1267,6 +1267,13 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
>  F:	drivers/hwmon/adm1177.c
> =20
> +ANALOG DEVICES INC ADMFM2000 DRIVER
> +M:	Kim Seer Paller <kimseer.paller@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> +
>  ANALOG DEVICES INC ADMV1013 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
>=20
> base-commit: 32f764943a21c1af01016bbcd43605220c076262
> --=20
> 2.34.1
>=20

--DdGHYOPWa0l7wFu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa44+gAKCRB4tDGHoIJi
0qisAPwMwctZVDw9EdQ92qtmhR06/ekIInIZXwJnSRJqBk6CBwEA5o1YOH31YODB
F0KjOJ2VekhBXxINzjV3lW0nBfCGBQo=
=JMs7
-----END PGP SIGNATURE-----

--DdGHYOPWa0l7wFu5--

