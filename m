Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256177F65D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjKWR4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWR43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:56:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A84189
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:56:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18489C433C7;
        Thu, 23 Nov 2023 17:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700762195;
        bh=lC5W7+Qr59rnhc4Jd20Dtf/HPxOyflR9v5IaOt+MbeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/B7Gq1PllfFYKi98tzgiIqm+eO8BZesekeW8ePGYfCsbyloLFTgwLYSMxT0530wP
         H+Ssfwp7bfx7zSXZXctFO9WA2fgL4RZtdO4hwFVdj1iS8t0ocJK8PDzdsrSGx/UgGg
         +uYFgEbpmzyah8WMmmzafyGLP5qVL3SLqobMJT9e+1kRv6bo9A45xCVRvSEEiclAEu
         rgTVTc4Gk3NQXt2cdrah+ibIjM9o1cXXnbOc6LDcLWz4fbWs8vbR/bdsCe2gUDlLkY
         rIPZ5h3uIJyKH1ayQ8BjtoS0oOo4Oq1n8NhuKi8G2pctnkhgv86pASLLIBJc6sL1ds
         iftxVyWj3Dl2Q==
Date:   Thu, 23 Nov 2023 17:56:30 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
Message-ID: <20231123-skeletal-smirk-390543e2d6ab@spud>
References: <20231122182351.63214-1-linux.amoon@gmail.com>
 <20231122182351.63214-2-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V1sQe/A91J5XE2J3"
Content-Disposition: inline
In-Reply-To: <20231122182351.63214-2-linux.amoon@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V1sQe/A91J5XE2J3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:53:46PM +0530, Anand Moon wrote:
> Add the binding example for the USB3.1 Genesys Logic GL3523
> integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> hub.
>=20
> Onboard USB hub supports USB 3.x and USB 2.0 peer controllers.
> which has a common reset pin and power supply.
> peer-hub phandle each peer controller with proper gpio reset
> and help each peer power on during initialization
> and power off during suspend.
>=20
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v4: Fix the description of peer-hub and update the commit message.
> Schematics of the Odroid N2+
> https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121=
=2Epdf
> V3: fix the dt_binding_check error, added new example for Genesys GL3523
> v2: added Genesys GL3523 binding
> v1: none
> ---
>  .../bindings/usb/genesys,gl850g.yaml          | 67 +++++++++++++++++--
>  1 file changed, 63 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/=
Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> index ee08b9c3721f..bc3b3f4c8473 100644
> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> @@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
>  maintainers:
>    - Icenowy Zheng <uwu@icenowy.me>
> =20
> -allOf:
> -  - $ref: usb-device.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -27,12 +24,48 @@ properties:
> =20
>    vdd-supply:
>      description:
> -      the regulator that provides 3.3V core power to the hub.
> +      phandle to the regulator that provides power to the hub.
> +
> +  peer-hub:

Should the property not be "peer-controller"? Your description refers to
them as such.

> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      onboard USB hub supports USB 3.x and USB 2.0 peer controllers.


> +      which has a common reset pin and power supply.
> +      peer-hub phandle each peer controller with proper gpio reset
> +      and help each peer power on during initialization
> +      and power off during suspend.

I generally hate to talk about non-native speakers grammar etc, but what
you have here is in need of a lot of improvement. The below is my
attempt to understand what you are trying to say:

"For onboard hubs that support USB 3.x and USB 2.0 controllers with
shared resets and power supplies, this property is used to identify
the controllers with which these are shared."

Also - this is one particular system, what prevents there being a hub
that has more than 2 controllers? Also, as you insist that this is
generic, and not just for genesys, should this not be defined in a
common location?

Cheers,
Conor.

> =20
>  required:
>    - compatible
>    - reg
> =20
> +allOf:
> +  - $ref: usb-device.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - usb5e3,608
> +    then:
> +      properties:
> +        peer-hub: false
> +        vdd-supply: false
> +        reset-gpios: true
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - usb5e3,610
> +              - usb5e3,620
> +    then:
> +      properties:
> +        peer-hub: true
> +        vdd-supply: true
> +        reset-gpios: true
> +
>  additionalProperties: false
> =20
>  examples:
> @@ -49,3 +82,29 @@ examples:
>              reset-gpios =3D <&pio 7 2 GPIO_ACTIVE_LOW>;
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    usb {
> +        dr_mode =3D "host";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        /* 2.0 hub on port 1 */
> +        hub_2_0: hub@1 {
> +            compatible =3D "usb5e3,610";
> +            reg =3D <1>;
> +            peer-hub =3D <&hub_3_0>;
> +            reset-gpios =3D <&gpio 20 GPIO_ACTIVE_LOW>;
> +            vdd-supply =3D <&vcc_5v>;
> +        };
> +
> +        /* 3.1 hub on port 4 */
> +        hub_3_0: hub@2 {
> +            compatible =3D "usb5e3,620";
> +            reg =3D <2>;
> +            peer-hub =3D <&hub_2_0>;
> +            reset-gpios =3D <&gpio 20 GPIO_ACTIVE_LOW>;
> +            vdd-supply =3D <&vcc_5v>;
> +        };
> +    };
> --=20
> 2.42.0
>=20

--V1sQe/A91J5XE2J3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+STgAKCRB4tDGHoIJi
0mwwAP9s9qmiSd8TgU4ApJa6D+1a7mUjwbwVn5y9j9brD7RfmgD/bZI//2gN6ZT9
CAdWofSmLE0P+12w0jvV05yM8LwnvQE=
=yviR
-----END PGP SIGNATURE-----

--V1sQe/A91J5XE2J3--
