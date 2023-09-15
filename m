Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C2E7A216F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbjIOOui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjIOOuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:50:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB65B1FD2;
        Fri, 15 Sep 2023 07:50:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F84DC433C8;
        Fri, 15 Sep 2023 14:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694789431;
        bh=+7a/yilTLV3BMiTCUiFOpBcqKwXaHi/uJzXAg9+YPtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwpEnu7H/3Yo77ctlj+KSVShzHRotD5z4emCwm2QBSN0l8eFaqEk5iFeAE/Q7kNwG
         7QY7O7QpiyMGsgi/21vOWy8FLlOrvw1XbCO5kWdp8sk48gXvhME8PIOhiwahTs4LDg
         o3PBuISTzKbilibvTjOtXzUfiSkGSkZqHs+dSlQMqbzbpUEOcvzmmMNj1O6DuvLzB/
         KA3p0HRCYWvMoJHBNYWWh2oGyct8Ygv/p+vhER6EZlg7b1mqUasuBxlW7hixy9Lypv
         cbjVEqtXAQ/nX+il78lIg2QeF4Hz2M/2XRU+fCmFVlW9FMFkABmw46/VCxZHD+gGC+
         ZoqKPqnOP27xg==
Date:   Fri, 15 Sep 2023 15:50:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Cc:     patrick@stwcx.xyz, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: add MAX31790
Message-ID: <20230915-quench-left-8fbc1ca3b1da@spud>
References: <20230915062926.2460502-1-Delphine_CC_Chiu@wiwynn.com>
 <20230915062926.2460502-3-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j20GgGeCJk1fE9k9"
Content-Disposition: inline
In-Reply-To: <20230915062926.2460502-3-Delphine_CC_Chiu@wiwynn.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j20GgGeCJk1fE9k9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Fri, Sep 15, 2023 at 02:29:24PM +0800, Delphine CC Chiu wrote:
> Add dt-bindings for the MAXIM MAX31790.
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
> Changelog:
> v2 - Add dt-bindings for the MAXIM MAX31790.
> ---
>  .../bindings/hwmon/maxim,max31790.yaml        | 59 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max3179=
0.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml =
b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> new file mode 100644
> index 000000000000..2bd455b36b3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim max31790
> +
> +maintainers:
> +  - Delphine CC Chiu  <Delphine_CC_Chiu@wiwynn.com>
> +
> +description: |
> +  The MAX31790 controls the speeds of up to six fans using
> +  six independent PWM outputs. The desired fan speeds (or PWM duty cycle=
s)
> +  are written through the I2C	interface.
> +  The outputs drive =E2=80=9C4-wire=E2=80=9D fans directly, or can be us=
ed to modulate
> +  the fan=E2=80=99s power terminals using an external pass transistor.
> +
> +  Datasheets:
> +    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max31790
> +
> +  reg:
> +    maxItems: 1
> +
> +  pwm-as-tach:

I don't see any other users of this in-tree, so you'd need a vendor
prefix. That said, I'm once bitten, twice shy about fan related
properties in hwmon, so I would definitely like Rob to comment on this
whole binding.

> +    description: |
> +      There are 6 PWM output channel in MAX31790 that allows to be confi=
gured
> +      as a TACH input by setting the Fan Configuration register.
> +      Config PWM output channels in the array as tachometer inputs.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      enum: [1, 2, 3, 4, 5, 6]
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
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      pwm@20 {
> +        compatible =3D "maxim,max31790";
> +        reg =3D <0x20>;
> +        pwm-as-tach =3D <2 5>;

This would be <2>, <5>; no?

> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8fdd0d03907..97e13b6bf51d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1371,6 +1371,12 @@ F:	Documentation/devicetree/bindings/hwmon/adi,max=
31760.yaml
>  F:	Documentation/hwmon/max31760.rst
>  F:	drivers/hwmon/max31760.c
> =20
> +ANALOG DEVICES INC MAX31790 DRIVER
> +M:	Delphine CC Chiu  <Delphine_CC_Chiu@wiwynn.com>
> +S:	Odd Fixes

This is a pretty odd status for something you're newly adding.
How come it's not going to be maintained?

Thanks,
Conor.


--j20GgGeCJk1fE9k9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQRvMwAKCRB4tDGHoIJi
0i3ZAP98nZfLp3xX8XszvOrnl9Qt3XVP8P1i2pSLZPHZs0B3TAD/XGC0hnOt22Oj
sm+07JZPIK/YS2QOTChE8LW5bR5NlAM=
=iyxw
-----END PGP SIGNATURE-----

--j20GgGeCJk1fE9k9--
