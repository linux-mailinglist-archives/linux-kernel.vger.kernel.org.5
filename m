Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963F77C73EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379555AbjJLRP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344113AbjJLRPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:15:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7369B8;
        Thu, 12 Oct 2023 10:15:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4415EC433C7;
        Thu, 12 Oct 2023 17:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697130952;
        bh=8B3mEtytGQ+9P80dsC6mkeTmemAtP8wbmzaGzdq4EJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNiv9Xw1pfSgZ32ckrZdEsMpW/dLxy6OQ9kjwLXyXSCLCsKNI0dWOu7x58IXC7xvR
         KC4xYBnN1xD0HrRtJZh0n+I5MmmhAFlVijHTwGuGLcLvN2EY52xDrWjWa+XFQc3uSo
         SHnL7bKHIlI9ObROkvmIu3+n5ySSNG+G9T34lZs+f5vervcqw25HZA1j99ikHduqOP
         K0x1K3r7TO1G4dHZAEbDwKOKhRh1+YsVPgo8ATF+1RQd1LSLhx06QmtIdk47VNncLz
         s0RXoLtay9qIgBeI2g/XVoCvfDUdyxCKiBx+wPjvjiDeMjDRqO5KfDqRIiXchZb2Ui
         h2LMRvCgvFX7g==
Date:   Thu, 12 Oct 2023 18:15:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: media: i2c: add galaxycore,gc2145
 dt-bindings
Message-ID: <20231012-marrow-bladder-9efc4354e9bd@spud>
References: <20231011175735.1824782-1-alain.volmat@foss.st.com>
 <20231011175735.1824782-3-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="noVBr97ToKNg5osG"
Content-Disposition: inline
In-Reply-To: <20231011175735.1824782-3-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--noVBr97ToKNg5osG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 07:57:29PM +0200, Alain Volmat wrote:
> Introduction of the Galaxy Core GC2145 XVGA CMOS camera sensor.
>=20
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>

This seems okay to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Thanks,
Conor.

> ---
>  .../bindings/media/i2c/galaxycore,gc2145.yaml | 104 ++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycor=
e,gc2145.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc214=
5.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> new file mode 100644
> index 000000000000..94d194cf5452
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> @@ -0,0 +1,104 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/galaxycore,gc2145.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Galaxy Core 1/5'' UXGA CMOS Image Sensor
> +
> +maintainers:
> +  - Alain Volmat <alain.volmat@foss.st.com>
> +
> +description:
> +  The Galaxy Core GC2145 is a high quality 2 Mega CMOS image sensor, for=
 mobile
> +  phone camera applications and digital camera products. GC2145 incorpor=
ates a
> +  1616V x 1232H active pixel array, on-chip 10-bit ADC, and image signal
> +  processor. It is programmable through an I2C interface. Image data is =
sent
> +  either through a parallel interface or through MIPI CSI-2.
> +
> +allOf:
> +  - $ref: ../video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: galaxycore,gc2145
> +
> +  reg:
> +    const: 0x3c
> +
> +  clocks:
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  iovdd-supply:
> +    description: Power Supply for I/O circuits (1.7 - 3V).
> +
> +  avdd-supply:
> +    description: Power for analog circuit/sensor array (2.7 - 3V).
> +
> +  dvdd-supply:
> +    description: Power for digital core (1.7 - 1.9V).
> +
> +  orientation: true
> +
> +  rotation: true
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +    required:
> +      - endpoint
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - powerdown-gpios
> +  - reset-gpios
> +  - iovdd-supply
> +  - avdd-supply
> +  - dvdd-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        camera@3c {
> +            compatible =3D "galaxycore,gc2145";
> +            reg =3D <0x3c>;
> +            clocks =3D <&clk_ext_camera>;
> +            iovdd-supply =3D <&scmi_v3v3_sw>;
> +            avdd-supply =3D <&scmi_v3v3_sw>;
> +            dvdd-supply =3D <&scmi_v3v3_sw>;
> +            powerdown-gpios =3D <&mcp23017 3 (GPIO_ACTIVE_LOW | GPIO_PUS=
H_PULL)>;
> +            reset-gpios =3D <&mcp23017 4 (GPIO_ACTIVE_LOW | GPIO_PUSH_PU=
LL)>;
> +
> +            port {
> +                endpoint {
> +                    remote-endpoint =3D <&mipid02_0>;
> +                    data-lanes =3D <1 2>;
> +                };
> +            };
> +        };
> +    };
> +
> +...
> --=20
> 2.25.1
>=20

--noVBr97ToKNg5osG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgpwwAKCRB4tDGHoIJi
0lRiAQCnJJxKQjT/BHIQ2uhbewNOGqJKgULV2cuD6zhX9Qg8bgEAgENNN/SEhBsh
lglB9jAXyAFQwNLjBTvEjI6s7S29rQQ=
=N/2r
-----END PGP SIGNATURE-----

--noVBr97ToKNg5osG--
