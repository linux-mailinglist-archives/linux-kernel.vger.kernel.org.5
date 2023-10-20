Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918B97D1336
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377813AbjJTPzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377756AbjJTPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:55:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFE4D8;
        Fri, 20 Oct 2023 08:55:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3C2C433C8;
        Fri, 20 Oct 2023 15:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697817317;
        bh=JslEm74PNuvaS9aYgnB/x1wmpt26tjbIUfcouSqB2f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyDAtWgw4uC6xSS+dMpivGIQjDJfi+oYCRMnMpFJYyUk7K9mlmu9P8WXVvkx/RQHN
         bXxOGQNFB5yNHFDwVrXdIy5Rut5Syo8ULUxP4avrMrFE2vl5o/h07/1Qw+FVB6e05r
         j9cmm28WZqlf47s+skQKnp2Zn3ILfI3M6yhQ0XyieDwkqODkMTr26LdoJo7R5Krfo/
         up9lyyMyNqFbJxFnp4ylFBxhwMX06sxt3+Tq+CFE8ucj5ZM0DwtmFsJh5zqqQMKo4N
         HkYlOh103CHTPpMdKZnsbKZ3Sh6hE1/LEejOZ6pjCXuuVQiaxX8DrDdors/n+VDHSJ
         +wHMITRCfux5Q==
Date:   Fri, 20 Oct 2023 16:55:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [RESEND PATCH v2] dt-bindings: mfd: armltd: Move Arm board
 syscon's to separate schema
Message-ID: <20231020-rockiness-droop-1a970663c407@spud>
References: <20231020142252.3113716-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0tFA3imV+0ln9Bep"
Content-Disposition: inline
In-Reply-To: <20231020142252.3113716-2-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0tFA3imV+0ln9Bep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 09:22:51AM -0500, Rob Herring wrote:
> The Arm Ltd board bindings are a bit unusual in that they define child
> nodes for various syscon's. The schemas are also incomplete as they lack
> constraints on having additional properties and some properties are
> missing. As the bindings for the different platforms only vary by
> compatibles, combine them into a single schema doc.
>=20
> Add the "arm,im-pd1-syscon" compatible which was not documented. Add
> "ranges", "#address-cells", and "#size-cells properties which were
> missing.
>=20
> With this, fix the error exposed in the register-bit-led binding.
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

In case the lack of tag from Krzysztof were impeding things, rather than
your email being borked:

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/arm/arm,integrator.yaml          | 39 -----------
>  .../devicetree/bindings/arm/arm,realview.yaml | 37 ----------
>  .../bindings/arm/arm,versatile.yaml           | 40 +++--------
>  .../bindings/leds/register-bit-led.yaml       |  2 +-
>  .../mfd/arm,dev-platforms-syscon.yaml         | 67 +++++++++++++++++++
>  5 files changed, 76 insertions(+), 109 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/arm,dev-platfor=
ms-syscon.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/arm,integrator.yaml b/=
Documentation/devicetree/bindings/arm/arm,integrator.yaml
> index 98ff5698ae1f..1bdbd1b7ee38 100644
> --- a/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> @@ -40,45 +40,6 @@ properties:
>          items:
>            - const: arm,integrator-sp
> =20
> -  core-module@10000000:
> -    type: object
> -    description: the root node in the Integrator platforms must contain
> -      a core module child node. They are always at physical address
> -      0x10000000 in all the Integrator variants.
> -    properties:
> -      compatible:
> -        items:
> -          - const: arm,core-module-integrator
> -          - const: syscon
> -          - const: simple-mfd
> -      reg:
> -        maxItems: 1
> -
> -    required:
> -      - compatible
> -      - reg
> -
> -patternProperties:
> -  "^syscon@[0-9a-f]+$":
> -    description: All Integrator boards must provide a system controller =
as a
> -      node in the root of the device tree.
> -    type: object
> -    properties:
> -      compatible:
> -        items:
> -          - enum:
> -              - arm,integrator-ap-syscon
> -              - arm,integrator-cp-syscon
> -              - arm,integrator-sp-syscon
> -          - const: syscon
> -      reg:
> -        maxItems: 1
> -
> -    required:
> -      - compatible
> -      - reg
> -
> -
>  required:
>    - compatible
>    - core-module@10000000
> diff --git a/Documentation/devicetree/bindings/arm/arm,realview.yaml b/Do=
cumentation/devicetree/bindings/arm/arm,realview.yaml
> index 8d3ed2e4ed31..d1bdee98f9af 100644
> --- a/Documentation/devicetree/bindings/arm/arm,realview.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,realview.yaml
> @@ -75,43 +75,6 @@ properties:
>          type: object
>          description: All RealView boards must provide a syscon system co=
ntroller
>            node inside the soc node.
> -        properties:
> -          compatible:
> -            oneOf:
> -              - items:
> -                  - const: arm,realview-eb11mp-revb-syscon
> -                  - const: arm,realview-eb-syscon
> -                  - const: syscon
> -                  - const: simple-mfd
> -              - items:
> -                  - const: arm,realview-eb11mp-revc-syscon
> -                  - const: arm,realview-eb-syscon
> -                  - const: syscon
> -                  - const: simple-mfd
> -              - items:
> -                  - const: arm,realview-eb-syscon
> -                  - const: syscon
> -                  - const: simple-mfd
> -              - items:
> -                  - const: arm,realview-pb1176-syscon
> -                  - const: syscon
> -                  - const: simple-mfd
> -              - items:
> -                  - const: arm,realview-pb11mp-syscon
> -                  - const: syscon
> -                  - const: simple-mfd
> -              - items:
> -                  - const: arm,realview-pba8-syscon
> -                  - const: syscon
> -                  - const: simple-mfd
> -              - items:
> -                  - const: arm,realview-pbx-syscon
> -                  - const: syscon
> -                  - const: simple-mfd
> -
> -        required:
> -          - compatible
> -          - reg
> =20
>      required:
>        - compatible
> diff --git a/Documentation/devicetree/bindings/arm/arm,versatile.yaml b/D=
ocumentation/devicetree/bindings/arm/arm,versatile.yaml
> index 13e52ba92060..7a3caf6af200 100644
> --- a/Documentation/devicetree/bindings/arm/arm,versatile.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,versatile.yaml
> @@ -14,6 +14,14 @@ description: |+
>    with various pluggable interface boards, in essence the Versatile PB v=
ersion
>    is a superset of the Versatile AB version.
> =20
> +  The root node in the Versatile platforms must contain a core module ch=
ild
> +  node. They are always at physical address 0x10000000 in all the Versat=
ile
> +  variants.
> +
> +  When fitted with the IB2 Interface Board, the Versatile AB will presen=
t an
> +  optional system controller node which controls the extra peripherals o=
n the
> +  interface board.
> +
>  properties:
>    $nodename:
>      const: '/'
> @@ -32,38 +40,6 @@ properties:
>          items:
>            - const: arm,versatile-pb
> =20
> -  core-module@10000000:
> -    type: object
> -    description: the root node in the Versatile platforms must contain
> -      a core module child node. They are always at physical address
> -      0x10000000 in all the Versatile variants.
> -    properties:
> -      compatible:
> -        items:
> -          - const: arm,core-module-versatile
> -          - const: syscon
> -          - const: simple-mfd
> -      reg:
> -        maxItems: 1
> -
> -    required:
> -      - compatible
> -      - reg
> -
> -patternProperties:
> -  "^syscon@[0-9a-f]+$":
> -    type: object
> -    description: When fitted with the IB2 Interface Board, the Versatile
> -      AB will present an optional system controller node which controls =
the
> -      extra peripherals on the interface board.
> -    properties:
> -      compatible:
> -        contains:
> -          const: arm,versatile-ib2-syscon
> -    required:
> -      - compatible
> -      - reg
> -
>  required:
>    - compatible
>    - core-module@10000000
> diff --git a/Documentation/devicetree/bindings/leds/register-bit-led.yaml=
 b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
> index ed26ec19ecbd..20930d327ae9 100644
> --- a/Documentation/devicetree/bindings/leds/register-bit-led.yaml
> +++ b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
> @@ -60,7 +60,7 @@ examples:
>    - |
> =20
>      syscon@10000000 {
> -        compatible =3D "arm,realview-pb1176-syscon", "syscon";
> +        compatible =3D "arm,realview-pb1176-syscon", "syscon", "simple-m=
fd";
>          reg =3D <0x10000000 0x1000>;
>          #address-cells =3D <1>;
>          #size-cells =3D <1>;
> diff --git a/Documentation/devicetree/bindings/mfd/arm,dev-platforms-sysc=
on.yaml b/Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.ya=
ml
> new file mode 100644
> index 000000000000..46b164ae0831
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/arm,dev-platforms-syscon.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/arm,dev-platforms-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Arm Ltd Developer Platforms System Controllers
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  The Arm Ltd Integrator, Realview, and Versatile families of developer
> +  platforms are contain various system controller blocks. Often these bl=
ocks
> +  are part of a daughterboard or motherboard module.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - arm,integrator-ap-syscon
> +              - arm,integrator-cp-syscon
> +              - arm,integrator-sp-syscon
> +              - arm,im-pd1-syscon
> +          - const: syscon
> +      - items:
> +          - enum:
> +              - arm,core-module-integrator
> +              - arm,integrator-ap-syscon
> +              - arm,integrator-cp-syscon
> +              - arm,integrator-sp-syscon
> +              - arm,realview-eb-syscon
> +              - arm,realview-pb1176-syscon
> +              - arm,realview-pb11mp-syscon
> +              - arm,realview-pba8-syscon
> +              - arm,realview-pbx-syscon
> +              - arm,versatile-ib2-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - enum:
> +              - arm,realview-eb11mp-revb-syscon
> +              - arm,realview-eb11mp-revc-syscon
> +          - const: arm,realview-eb-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties:
> +  type: object
> +
> +...
> --=20
> 2.42.0
>=20

--0tFA3imV+0ln9Bep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTKi4AAKCRB4tDGHoIJi
0j2cAPwLD6sIlzJ86DBUtwb2UgPLvmFt7EwN+ePp07GGbvosTQD/WBEQMZpog1TC
aeqP0EmQ8vb/tq+YZJEsPKxE80qYUgY=
=J1Fe
-----END PGP SIGNATURE-----

--0tFA3imV+0ln9Bep--
