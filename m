Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18907A9E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjIUUBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIUUAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:00:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CCC6A71;
        Thu, 21 Sep 2023 10:22:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1F5C4E68B;
        Thu, 21 Sep 2023 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695303910;
        bh=dUqsLtz7RErLFb7snsLdraj0PB791g8LuxpGKzEg1NU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWIOlF7tYrfDESX6UEOkIxBDCRuDydgucMmdWxtLhQxwhRxGAQijO01PBJwJe9Lm5
         faRolhrgR1mGGZVNRYBR8R7zIP/hHyZDLSpiHMAu06rDAcdN/lGV0XCEGOZDcDYypt
         n2SiE/feWfNbP0ZdEbsDG2cLrWFhj5XSmyCzvdFDywobV3W3ZpebQhGHQR6bVLGw1W
         IZhLSfQW2iuQvJ/MzexxYeRo2557Tny/PIP382odeJ9exqV5c06VuxqpPT1XaR6pFd
         YdxaCi8ipI4WSQUnrpYOpMhmJS9OBRp36gE2oTlzaArJOG51ZdGO2X53eWe5zKFRRC
         41MEylVQ/+QJQ==
Date:   Thu, 21 Sep 2023 14:45:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: sc16is7xx: convert to YAML
Message-ID: <20230921-decorated-patronize-45285045adbf@spud>
References: <20230920152015.1376838-1-hugo@hugovil.com>
 <20230920152015.1376838-5-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lL5KnB+yCBLhonNx"
Content-Disposition: inline
In-Reply-To: <20230920152015.1376838-5-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lL5KnB+yCBLhonNx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Sep 20, 2023 at 11:20:15AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>=20
> Convert binding from text format to YAML.
>=20
> Additions to original text binding:
>   - add rs485 reference.
>=20
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../bindings/serial/nxp,sc16is7xx.txt         | 118 ----------------
>  .../bindings/serial/nxp,sc16is7xx.yaml        | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 118 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7x=
x.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7x=
x.yaml

> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml =
b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> new file mode 100644
> index 000000000000..508639e09e06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/nxp,sc16is7xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP SC16IS7xx advanced Universal Asynchronous Receiver-Transmitte=
r (UART)

nit, but my OCD was triggered - capitalise the a in "advanced"?

> +
> +maintainers:
> +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,sc16is740
> +      - nxp,sc16is741
> +      - nxp,sc16is750
> +      - nxp,sc16is752
> +      - nxp,sc16is760
> +      - nxp,sc16is762
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: Reference to the IC source clock.

You could probably drop this, if it only has one clock it's a bit
redundant.

> +  clock-frequency:
> +    description: |

This | should not be needed here, there's no formatting to preserve.

> +      When there is no clock provider visible to the platform, this
> +      is the source crystal or external clock frequency for the IC in Hz.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 80000000
> +
> +  gpio-controller:
> +    description: Marks the device node as a GPIO controller.
> +    type: boolean
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-line-names:
> +    minItems: 1
> +    maxItems: 8
> +
> +  nxp,irda-mode-ports:
> +    description: |
> +      An array that lists the indices of the port that should operate in=
 IrDA
> +      mode:
> +      0: port A
> +      1: port B
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      minimum: 0
> +      maximum: 1
> +
> +  nxp,modem-control-line-ports:
> +    description: |
> +      An array that lists the indices of the port that should have share=
d GPIO
> +      lines configured as modem control lines:
> +      0: port A
> +      1: port B
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      minimum: 0
> +      maximum: 1
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - $ref: /schemas/serial/serial.yaml#
> +  - $ref: /schemas/serial/rs485.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +oneOf:
> +  - required:
> +      - clocks
> +  - required:
> +      - clock-frequency
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    serial0: serial@51 {

These labels are not used and should be removed.

Otherwise, conversion looks aight to me.

Thanks,
Conor.

> +        compatible =3D "nxp,sc16is750";
> +        reg =3D <0x51>;
> +        clocks =3D <&clk20m>;
> +        interrupt-parent =3D <&gpio3>;
> +        interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +        gpio-controller;
> +        #gpio-cells =3D <2>;
> +    };
> +
> +    serial1: serial@53 {
> +        compatible =3D "nxp,sc16is752";
> +        reg =3D <0x53>;
> +        clocks =3D <&clk20m>;
> +        interrupt-parent =3D <&gpio3>;
> +        interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +        nxp,modem-control-line-ports =3D <1>; /* Port 1 as modem control=
 lines */
> +        gpio-controller; /* Port 0 as GPIOs */
> +        #gpio-cells =3D <2>;
> +    };
> +
> +    serial2: serial@54 {
> +        compatible =3D "nxp,sc16is752";
> +        reg =3D <0x54>;
> +        clocks =3D <&clk20m>;
> +        interrupt-parent =3D <&gpio3>;
> +        interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +        nxp,modem-control-line-ports =3D <0 1>; /* Ports 0 and 1 as mode=
m control lines */
> +    };
> --=20
> 2.30.2
>=20

--lL5KnB+yCBLhonNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQxI4QAKCRB4tDGHoIJi
0rUOAQDqC8IJoyx0QwtsfS2fIY40qUE9tMXBSZfJNKMMI7zVKgEA9+Aik4dyDCV5
l7HTGIZAHcY23n6LxU5QKQnBLg/hiAI=
=fCao
-----END PGP SIGNATURE-----

--lL5KnB+yCBLhonNx--
