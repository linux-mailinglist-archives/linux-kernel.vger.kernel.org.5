Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311117F068C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 14:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjKSNro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 08:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKSNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 08:47:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5EB8F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 05:47:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61880C433C7;
        Sun, 19 Nov 2023 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700401658;
        bh=U1/crVe3cQalV1pEqgbYT0Du0EuyIuAjyAUdOqkkcSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pz/2EA2/Cop43Hoq7PHwPpLlcgrslPh04hOYxhAs11kufyTELWKXFkMo8AvH4cDDH
         WJPOcsDP7hbVp4OtC8fs4M8W/VC1lw1zEj8pqiaFnn/QCSbX7Fd0rAsAHffXiOMJWN
         q6AL8FuU3Wr7MacoKEjDIAhVy1ApfwiGvQkcVfImxgRzc4kV8wizDRSypZt1KiAaVh
         gnb5KZQYrcZkVrHfKvq4Y0BLy6xJcpfO9MnvZo2jtP+a59UHuQEls3MPECpfglat48
         tlY+BY0v05tiaEn5gvVfdajQWnPuVtMQ0liBXYHezZMJB9QfRQNbI6JC5C44Cd7B0G
         T7ay90OQDJVmw==
Date:   Sun, 19 Nov 2023 13:47:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add MCP4821
Message-ID: <20231119-surpass-cheer-9dc3838b766f@spud>
References: <20231117073040.685860-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Xr+UPjWgGaRG4h0+"
Content-Disposition: inline
In-Reply-To: <20231117073040.685860-1-anshulusr@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xr+UPjWgGaRG4h0+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 01:00:37PM +0530, Anshul Dalal wrote:
> Adds support for MCP48xx series of DACs.
>=20
> Datasheet:
>   [MCP48x1] https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
>   [MCP48x2] https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
>=20
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/iio/dac/microchip,mcp4821.yaml   | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,m=
cp4821.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.=
yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> new file mode 100644
> index 000000000000..904de15300bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp4821.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP4821 and similar DACs
> +
> +description: |
> +  Supports MCP48x1 (single channel) and MCP48x2 (dual channel) series of=
 DACs.
> +  Device supports simplex communication over SPI in Mode 0,1 and Mode 1,=
1.
> +
> +  +---------+--------------+-------------+
> +  | Device  |  Resolution  |   Channels  |
> +  |---------|--------------|-------------|
> +  | MCP4801 |     8-bit    |      1      |
> +  | MCP4811 |    10-bit    |      1      |
> +  | MCP4821 |    12-bit    |      1      |
> +  | MCP4802 |     8-bit    |      2      |
> +  | MCP4812 |    10-bit    |      2      |
> +  | MCP4822 |    12-bit    |      2      |
> +  +---------+--------------+-------------+
> +
> +  Datasheet:
> +    MCP48x1: https://ww1.microchip.com/downloads/en/DeviceDoc/22244B.pdf
> +    MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.=
pdf
> +
> +maintainers:
> +  - Anshul Dalal <anshulusr@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp4801
> +      - microchip,mcp4811
> +      - microchip,mcp4821
> +      - microchip,mcp4802
> +      - microchip,mcp4812
> +      - microchip,mcp4822
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@0 {
> +            compatible =3D "microchip,mcp4821";
> +            reg =3D <0>;
> +            vdd-supply =3D <&vdd_regulator>;
> +        };
> +    };
> --=20
> 2.42.1
>=20

--Xr+UPjWgGaRG4h0+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVoR9QAKCRB4tDGHoIJi
0p8QAQC38yhdhXb1PcvkIA/pVY7NY6OGkiJqdumywpDJyqsDRgD/XP0qyWMwaURl
9zBPIfcRCjAD7KXqB6d6YTYsZ5L1Jg8=
=VZnd
-----END PGP SIGNATURE-----

--Xr+UPjWgGaRG4h0+--
