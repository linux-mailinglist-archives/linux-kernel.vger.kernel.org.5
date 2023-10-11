Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223DC7C58F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjJKQPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbjJKQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:15:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8147F8F;
        Wed, 11 Oct 2023 09:15:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06ED6C433C8;
        Wed, 11 Oct 2023 16:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697040908;
        bh=wtQMMdHrnFggk0m06ilUhF5VMAOMImQU9UM40mHBiVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bs0AcPB4HUa9JKFIg7sdXg83lTzuhi2OLLs5zi4krsrYvKkFZflYBf5izlTEFYFOP
         YvFLiFb3wyNSQ6tsiAy8O8YdDaQto5/2ejA3/wlhLEJFh+DjPPnVsVn1yULSEB49cL
         VinmbeTTkJmHOe7f+Mw/vGKdY2McoxJ3LxjkVJEDbYjH4UgOQXIV1IQ6n5A7VWViqY
         2djutKm3XqC32xhSqUTRM9doqqD/yVJBsJ+r6B8RN+V0zz+D6STCXNDgzOAFWFbN9r
         j3syNlYhPWWm/HhBeiCYETIqLjcBcDEQeSTIRAcABeASEW/tgv7tTS0ie/ooyVKydW
         6qJwMIDqkj1tQ==
Date:   Wed, 11 Oct 2023 17:15:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: input: bindings for Adafruit Seesaw
 Gamepad
Message-ID: <20231011-powdering-recycled-71608e794eaa@spud>
References: <20231010184827.1213507-1-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="timCUOp0XhI+CNqU"
Content-Disposition: inline
In-Reply-To: <20231010184827.1213507-1-anshulusr@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--timCUOp0XhI+CNqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Oct 11, 2023 at 12:18:23AM +0530, Anshul Dalal wrote:
> Adds bindings for the Adafruit Seesaw Gamepad.
>=20
> The gamepad functions as an i2c device with the default address of 0x50
> and has an IRQ pin that can be enabled in the driver to allow for a rising
> edge trigger on each button press or joystick movement.
>=20
> Product page:
>   https://www.adafruit.com/product/5743
> Arduino driver:
>   https://github.com/adafruit/Adafruit_Seesaw
>=20
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> ---
>=20
> Changes for v4:
> - Fixed the URI for the id field
> - Added `interrupts` property
>=20
> Changes for v3:
> - Updated id field to reflect updated file name from previous version
> - Added `reg` property
>=20
> Changes for v2:
> - Renamed file to `adafruit,seesaw-gamepad.yaml`
> - Removed quotes for `$id` and `$schema`
> - Removed "Bindings for" from the description
> - Changed node name to the generic name "joystick"
> - Changed compatible to 'adafruit,seesaw-gamepad' instead of
>   'adafruit,seesaw_gamepad'
>=20
>  .../input/adafruit,seesaw-gamepad.yaml        | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adafruit,sees=
aw-gamepad.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/input/adafruit,seesaw-game=
pad.yaml b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.=
yaml
> new file mode 100644
> index 000000000000..e8e676006d2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/adafruit,seesaw-gamepad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Adafruit Mini I2C Gamepad with seesaw

Binding mostly looks good to me. My main question is what is a seesaw?

> +
> +maintainers:
> +  - Anshul Dalal <anshulusr@gmail.com>
> +
> +description: |
> +  Adafruit Mini I2C Gamepad
> +
> +    +-----------------------------+
> +    |   ___                       |
> +    |  /   \               (X)    |
> +    | |  S  |  __   __  (Y)   (A) |
> +    |  \___/  |ST| |SE|    (B)    |
> +    |                             |
> +    +-----------------------------+
> +
> +  S -> 10-bit percision bidirectional analog joystick
> +  ST -> Start
> +  SE -> Select
> +  X, A, B, Y -> Digital action buttons
> +
> +  Product page: https://www.adafruit.com/product/5743
> +  Arduino Driver: https://github.com/adafruit/Adafruit_Seesaw

I'm not really sure what the arduino driver has to do with the binding.
Why is a link to it more relevant than the freebsd driver, or the linux
driver etc? Is there info about how the pad works in the arduino driver

Otherwise, this seems good to me.

Thanks,
Conor.

> +
> +properties:
> +  compatible:
> +    const: adafruit,seesaw-gamepad
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      The gamepad's IRQ pin triggers a rising edge if interrupts are ena=
bled.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        joystick@50 {
> +            compatible =3D "adafruit,seesaw-gamepad";
> +            reg =3D <0x50>;
> +        };
> +    };
> --=20
> 2.42.0
>=20

--timCUOp0XhI+CNqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSbKBwAKCRB4tDGHoIJi
0uPyAP44XQzOQbflxL/UvrKTR2YMG9/YIVQXQK5aBzNTEXcMUAEA8xyeLKAOZtJx
HK4Pss8t1U8E5lZrti8sa9pDht76Bws=
=wvkn
-----END PGP SIGNATURE-----

--timCUOp0XhI+CNqU--
