Return-Path: <linux-kernel+bounces-35639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554CD83947F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B7B1F237E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1716351D;
	Tue, 23 Jan 2024 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nypCMCh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F226281F;
	Tue, 23 Jan 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026615; cv=none; b=qzqt0WZbzbBBhz0scYfU20hH6OpFC+NMPdQOE0JBBEAmDrHqb9mTeEXxY9Uq+VoZCYtODTTNoIXLbn5Z720rL1uJolhrnlqhZ3zZlOdCblCxWUpTkWG3jK94PhNmC6vDcsagH6m7RDP0pB05En/IOmb4Z3VSGYSk1XCa/9XC588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026615; c=relaxed/simple;
	bh=FGEKPh5UgO+09RlhEkiGERyeV2Hwl3pBDJzoOdlKXRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCbDduSso8iBY8qp+6KnzTtdYfW5I7nhQWB5AbEcarCDVKwkTvSY3f8nXKK5qPjC1bKoKaBEvOp/baNFsTIn73wvrQ94GHLj846H/Ej0vawn1rI0sBnZqrVTw6gwNhq1YO4iArGKX/lvAMMNDFmw1UXVMkOOiweGyD7Gqvv4EAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nypCMCh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B3BC433C7;
	Tue, 23 Jan 2024 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706026614;
	bh=FGEKPh5UgO+09RlhEkiGERyeV2Hwl3pBDJzoOdlKXRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nypCMCh/Y0zwo8q4Chxsh1dGqTO7avqXDiKuQ+y1w6rGbJmU8kSgNv/URGXaTOwuA
	 ixLpHYaUFx+cYd4qqDGmlC+BMDlk2mtGYbqLWpj3KRBbNAN25c6F8F4vRSnTZrw9vw
	 p6afztS6oh/RtN7xl/LyIlHm0Jb0CQZdc+VMRB0gNDyHcWdOkJntZ0wU3+CJervcBJ
	 EqSFGNncw0XHtRzxtmQ5zUuVeAT/edlg87Uc7rq6wIaaxkTMg5Hs8f+IHQKDczcGfx
	 djJzSBNNfZD8auXVL6wd4g93cIoitvEeeXaOckLnsgG2R4PoZALYIKXdkc936GvJdL
	 OYRzKY+C2xRsQ==
Date: Tue, 23 Jan 2024 16:16:49 +0000
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
Subject: Re: [PATCH v8 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <20240123-curled-affront-e37d2d6b1826@spud>
References: <20240123081059.5746-1-kimseer.paller@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x20s1Wl4HrobLnOi"
Content-Disposition: inline
In-Reply-To: <20240123081059.5746-1-kimseer.paller@analog.com>


--x20s1Wl4HrobLnOi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 04:10:58PM +0800, Kim Seer Paller wrote:
> Dual microwave down converter module with input RF and LO frequency
> ranges from 0.5 to 32 GHz and an output IF frequency range from 0.1 to
> 8 GHz. It consists of a LNA, mixer, IF filter, DSA, and IF amplifier
> for each down conversion path.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the updates. One comment below that I missed previvously, but
is not worth a resend.


> ---
> V7 -> V8: Added adequate description for mixer mode property. Modified de=
scription
>           for switch gpio property.
> V6 -> V7: Changed RF path mode property to boolean.
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
>  .../bindings/iio/frequency/adi,admfm2000.yaml | 127 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,a=
dmfm2000.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admfm200=
0.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> new file mode 100644
> index 000000000000..2bcf4bbc12e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml
> @@ -0,0 +1,127 @@
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

If you do not have other devices to add to this binding, the enum: can be
become a const:

Cheers,
Conor.

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
> +          Enable mixer mode for the channel. It downconverts RF between =
5 GHz
> +          and 32 GHz to IF between 0.5 GHz and 8 GHz. If not present, th=
e channel
> +          is in direct IF mode which bypasses the mixer and downconverts=
 RF
> +          between 2 GHz and 8 GHz to IF between 0.5 GHz and 8 GHz.
> +        type: boolean
> +
> +      switch-gpios:
> +        description: |
> +          GPIOs to select the RF path for the channel. The same state of=
 CTRL-A
> +          and CTRL-B GPIOs is not permitted.
> +          CTRL-A   CTRL-B    CH1 Status        CH2 Status
> +          1        0         Direct IF mode    Mixer mode
> +          0        1         Mixer mode        Direct IF mode
> +
> +        items:
> +          - description: CTRL-A GPIO
> +          - description: CTRL-B GPIO
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
> base-commit: 7ed2632ec7d72e926b9e8bcc9ad1bb0cd37274bf
> --=20
> 2.34.1
>=20

--x20s1Wl4HrobLnOi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa/mcQAKCRB4tDGHoIJi
0rEpAPwIcfqFI+Vhdhdxdrd9q11kMB8IqDj1QeeysO8Lzl2LHgEA1EmmJQF+jt4E
S19/S8QxggnODO6zG1Cup05kHRoAhwA=
=HnaZ
-----END PGP SIGNATURE-----

--x20s1Wl4HrobLnOi--

