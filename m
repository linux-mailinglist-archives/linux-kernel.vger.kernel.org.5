Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28A27A0794
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbjINOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjINOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:42:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228E71BE1;
        Thu, 14 Sep 2023 07:42:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801DBC433C7;
        Thu, 14 Sep 2023 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694702525;
        bh=O9w4R0Iu6/XNvjfu2aj/DjJkGOobrTu4cV0g3uZvCyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ed497R3ieIebv7g5fw/xSOgE3pjwdUxNHnBc/LRisrd3WOhjfXkVlP1xUfG6GZ1dh
         yhMvzh0fLaKCjCh9EIfdwFf5u+um7WgmHDVhRcKGUU8HNwl3JZqr4ynQ08IuGfWizT
         TK+ihlUxtec6fRDNTjfobbb5uPVC+wIxfXiOsu0rKFDCdIsGCjMC8v5JkXv0uWl9Q+
         kPvHCkw3F4uvq3l8umHhUpVRUnhHc646iJA50d96tmNV8KJ3Mrgf74hC0AkTtpa1cy
         AXDOAs05ebD2GTWCm/eg+6nwKZXz5cn0jjAxYqNt1bcv43PD4BVh4C7CVkkXZUq4mr
         7UI9/X2DP/L+Q==
Date:   Thu, 14 Sep 2023 15:42:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] dt-bindings: hwmon: Add possible new properties
 to max31827 bindings
Message-ID: <20230914-qualify-ragweed-b06b7b7923c9@spud>
References: <20230914075948.208046-1-daniel.matyas@analog.com>
 <20230914075948.208046-2-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="71snxAjsMqH/MtRQ"
Content-Disposition: inline
In-Reply-To: <20230914075948.208046-2-daniel.matyas@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--71snxAjsMqH/MtRQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 10:59:45AM +0300, Daniel Matyas wrote:
> These modify the corresponding bits in the configuration register.
>=20
> adi,comp-int is a hardware property, because it affects the behavior
> of the interrupt signal and whatever it is connected to.
>=20
> adi,timeout-enable is a hardware property, because it affects i2c
> bus operation.
>=20
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>=20
> v2 -> v3: Changed commit subject and message
>=20
> v1 -> v2: Added adi,timeout-enable property to binding. Fixed
> dt_binding_check errors.
>=20
>  .../bindings/hwmon/adi,max31827.yaml          | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/=
Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> index 2dc8b07b4d3b..6bde71bdb8dd 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> @@ -32,6 +32,37 @@ properties:
>        Must have values in the interval (1.6V; 3.6V) in order for the dev=
ice to
>        function correctly.
> =20
> +  adi,comp-int:
> +    description:
> +      If present interrupt mode is used. If not present comparator mode =
is used
> +      (default).
> +    type: boolean
> +
> +  adi,alrm-pol:

Characters are not at a premium, is there a reason not to use the full
words? "flt-q" in particular would be quite cryptic if I saw it in a
dts.

> +    description:
> +      Sets the alarms active state.
> +            - 0 =3D active low
> +            - 1 =3D active high
> +      For max31827 and max31828 the default alarm polarity is low. For m=
ax31829
> +      it is high.

This constraint can be expressed in the binding, rather than in free
form text like done here. Ditto below.

Thanks,
Conor.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  adi,flt-q:
> +    description:
> +      Select how many consecutive temperature faults must occur before
> +      overtemperature or undertemperature faults are indicated in the
> +      corresponding status bits.
> +      For max31827 default fault queue is 1. For max31828 and max31829 i=
t is 4.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8]
> +
> +  adi,timeout-enable:
> +    description:
> +      Enables timeout. Bus timeout resets the I2C-compatible interface w=
hen SCL
> +      is low for more than 30ms (nominal).
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> @@ -49,6 +80,10 @@ examples:
>              compatible =3D "adi,max31827";
>              reg =3D <0x42>;
>              vref-supply =3D <&reg_vdd>;
> +            adi,comp-int;
> +            adi,alrm-pol =3D <0>;
> +            adi,flt-q =3D <1>;
> +            adi,timeout-enable;
>          };
>      };
>  ...
> --=20
> 2.34.1
>=20

--71snxAjsMqH/MtRQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQMbuQAKCRB4tDGHoIJi
0gqiAQDbZmcqv2uLoYCOMuAvkhjjcMC3XJyStjoO3fVxrPd9BQEA4h/jctruYGgi
yrh/mEKmKTQtA3z6WR3RqxXxaJ2mowA=
=RMiX
-----END PGP SIGNATURE-----

--71snxAjsMqH/MtRQ--
