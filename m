Return-Path: <linux-kernel+bounces-105439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B137D87DDDE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7051F213C2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA941C6B4;
	Sun, 17 Mar 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aohLG6+H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A41C680;
	Sun, 17 Mar 2024 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688729; cv=none; b=UwEE9rhf9k8Zvd0swacxUBQ9E+I6dH6le4McAhw0vwnvOi2X83qu0H2Guak4PsAu+b3eQxZ3zXy6ZqHWWZBd2NvLYeA/r1N3LJTlxbXrX1wogIyngVAGHx58v9doF+WmgzK9a1Z3zUKCeP1U3qYB2RL+feZN3lzUwUN67JGhnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688729; c=relaxed/simple;
	bh=7pTYg4neY3p4a4Eucf5XUJ2jnY24udS5Z7ZaC2XMr5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODfwZbmrbpINOPtKz8JLssoBmM84NG1+CeVbsH+zdjGyd897sP848aF9epEQ6TkoEFk7snJhKJ8to+xYkii9Fs38nAyoZ6T3E2RBT38giqY1nslClV07RhTUzTay4OKo1xIu0y2BasHo9fbCiK5CKqhD4VtRkpBGmCALttAbtvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aohLG6+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9280AC433C7;
	Sun, 17 Mar 2024 15:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710688729;
	bh=7pTYg4neY3p4a4Eucf5XUJ2jnY24udS5Z7ZaC2XMr5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aohLG6+HBu84r95klNM5SxVDvXwgCrhGVslsuhs4tJMW+oMEL7KaqVBwqSTU/frnb
	 QIhzVRbH6nSZ1Okc2ThoBAXWXrNx8gjWOdfX6MDFd2CWK8ohrt70QknEzIc9Cx2ACI
	 NyfIXCSyJhlTCi3Ne4u+c7rbXsyPprPWNPp9JTNJtZd0AOKL9j4abuvxK1kfYO0BcS
	 Skal6AJOwuO5bQJZqgEEkPku/VbZdB5t56+7ALRR37fhZW7uklRd6XnV3AkH/G00Et
	 66lMhqxAXmQO1Q8SXG4GNNt0hTC+5WvlTjMZmOnJnxo3ZM62YHtogZziJN4KJsrXBn
	 GgElVk0YpPs6w==
Date: Sun, 17 Mar 2024 15:18:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sakari.ailus@iki.fi
Subject: Re: [PATCH v5 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2
 Deserializer
Message-ID: <20240317-petty-backache-b10d0fde62cf@spud>
References: <20240313094922.311743-1-julien.massot@collabora.com>
 <20240313094922.311743-3-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V1m849K/NnwfOyE3"
Content-Disposition: inline
In-Reply-To: <20240313094922.311743-3-julien.massot@collabora.com>


--V1m849K/NnwfOyE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:49:20AM +0100, Julien Massot wrote:
> Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.
>=20
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
> Change since v4:
>  - Add compatible for MAX96714 and use it as a fallback for MAX96714F
>  - Remove extra '|' for decriptions
>  - Reference 'i2c-gate' instead of 'i2c-controller'
>=20
> Change since v3:
>  - Renamed file to maxim,max96714.yaml dropped the 'f' suffix
>  - Removed mention to C-PHY since it's not supported by MAX96714 deserial=
izers
>  - Removed bus-type requirement on CSI endpoint since the device only sup=
port D-PHY
>  - Removed the clock-lanes property in the dt example
>=20
> Change since v2:
>  - remove reg description
>  - rename enable gpio to powerdown
>  - use generic node name: i2c, serializer, deserializer
> ---
>  .../bindings/media/i2c/maxim,max96714.yaml    | 176 ++++++++++++++++++
>  1 file changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/maxim,max=
96714.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/maxim,max96714.y=
aml b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
> new file mode 100644
> index 000000000000..59b116092834
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/maxim,max96714.yaml
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2024 Collabora Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/maxim,max96714.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX96714 GMSL2 to CSI-2 Deserializer
> +
> +maintainers:
> +  - Julien Massot <julien.massot@collabora.com>
> +
> +description:
> +  The MAX96714 deserializer converts GMSL2 serial inputs into MIPI
> +  CSI-2 D-PHY formatted output. The device allows the GMSL2 link to
> +  simultaneously transmit bidirectional control-channel data while forwa=
rd
> +  video transmissions are in progress. The MAX96714 can connect to one
> +  remotely located serializer using industry-standard coax or STP
> +  interconnects. The device cans operate in pixel or tunnel mode. In pix=
el mode
> +  the MAX96714 can select individual video stream, while the tunnel mode=
 forward all
> +  the MIPI data received by the serializer.
> +
> +  The GMSL2 serial link operates at a fixed rate of 3Gbps or 6Gbps in the
> +  forward direction and 187.5Mbps in the reverse direction.
> +  MAX96714F only supports a fixed rate of 3Gbps in the forward direction.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - maxim,max96714

There's only once device here, make it const rather than enum.

> +      - items:
> +          - enum:
> +              - maxim,max96714f
> +          - const: maxim,max96714 # fallback for 'f' variant

Drop the comment btw, it doesn't make sense given you have an enum that
will allow for more devices and it being a fallback is obvious. That
said, given what you told me on the last version
| Yes there are a few differences visible to the software, for example the=
=20
| GMSL
| link rate since MAX96714 support 6 and 3 Gbps, while MAX96714F only=20
| supports 3Gbps.
| the registers map is the same, but a few values are not possible with=20
| the 'f' version.
I don't think your ordering here is correct. The 96714 should fall back
to the 96714f, not the opposite that you have here, as the f is the
version which supports fewer features.

I think this should be:

oneOf:
  - const: maxim,max96714f
  - items:
      - enum:
          - maxim,max96714
      - const: maxim,max96714f

Cheers,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description:
> +      Specifier for the GPIO connected to the PWDNB pin.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        unevaluatedProperties: false
> +        description: GMSL Input
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +            description:
> +              Endpoint for GMSL2-Link port.
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
> +        description: CSI-2 Output port
> +
> +        properties:
> +          endpoint:
> +            $ref: /schemas/media/video-interfaces.yaml#
> +            unevaluatedProperties: false
> +
> +            properties:
> +              data-lanes:
> +                minItems: 1
> +                maxItems: 4
> +
> +              lane-polarities:
> +                minItems: 1
> +                maxItems: 5
> +
> +              link-frequencies:
> +                maxItems: 1
> +
> +            required:
> +              - data-lanes
> +
> +    required:
> +      - port@1
> +
> +  i2c-gate:
> +    $ref: /schemas/i2c/i2c-gate.yaml
> +    unevaluatedProperties: false
> +    description:
> +      The MAX96714 will pass through and forward the I2C requests from t=
he
> +      incoming I2C bus over the GMSL2 link. Therefore it supports an i2c=
-gate
> +      subnode to configure a serializer.
> +
> +  port0-poc-supply:
> +    description: Regulator providing Power over Coax for the GMSL port
> +
> +required:
> +  - compatible
> +  - reg
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/media/video-interfaces.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        deserializer@28 {
> +            compatible =3D "maxim,max96714f", "maxim,max96714";
> +            reg =3D <0x28>;
> +            powerdown-gpios =3D <&main_gpio0 37 GPIO_ACTIVE_LOW>;
> +
> +            ports {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +                port@0 {
> +                    reg =3D <0>;
> +                    max96714_gmsl_in: endpoint {
> +                        remote-endpoint =3D <&max96917f_gmsl_out>;
> +                    };
> +                };
> +
> +                port@1 {
> +                    reg =3D <1>;
> +                    max96714_csi_out: endpoint {
> +                        data-lanes =3D <1 2 3 4>;
> +                        link-frequencies =3D /bits/ 64 <400000000>;
> +                        remote-endpoint =3D <&csi_in>;
> +                    };
> +                };
> +            };
> +
> +            i2c-gate {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                serializer@40 {
> +                    compatible =3D "maxim,max96717f", "maxim,max96717";
> +                    reg =3D <0x40>;
> +                    gpio-controller;
> +                    #gpio-cells =3D <2>;
> +                    #clock-cells =3D <0>;
> +
> +                    ports {
> +                        #address-cells =3D <1>;
> +                        #size-cells =3D <0>;
> +
> +                        port@0 {
> +                            reg =3D <0>;
> +                            max96717f_csi_in: endpoint {
> +                                bus-type =3D <MEDIA_BUS_TYPE_CSI2_DPHY>;
> +                                data-lanes =3D <1 2>;
> +                                lane-polarities =3D <1 0 1>;
> +                                remote-endpoint =3D <&sensor_out>;
> +                            };
> +                        };
> +
> +                        port@1 {
> +                            reg =3D <1>;
> +                            max96917f_gmsl_out: endpoint {
> +                                remote-endpoint =3D <&max96714_gmsl_in>;
> +                            };
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...
> --=20
> 2.44.0
>=20

--V1m849K/NnwfOyE3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZfcJ1QAKCRB4tDGHoIJi
0sDBAP9GEUPIFsPY6//epmj9GOulmny5jElBVcYVxjogXV215QD+MwDcMQOYPQfM
NU6k9TMsTfO8dx/JMAgXdL1rLXJQDw4=
=HOwF
-----END PGP SIGNATURE-----

--V1m849K/NnwfOyE3--

