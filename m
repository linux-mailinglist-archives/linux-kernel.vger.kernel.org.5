Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFAE7A607B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjISLAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjISLAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:00:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457EB114;
        Tue, 19 Sep 2023 04:00:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917D4C433C8;
        Tue, 19 Sep 2023 11:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695121235;
        bh=ozaaNy4A2j0mALWUaebh6QEMAgfZg8sTwwxTOEiQSmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pgRh1Q2aQOq7MkEWZtc6silnhIXVu7ssk1lrCtjWGpOId4D15+051Hs3CCNp6B5dJ
         6rULnREK+E9yR50coftq4rcIfbH+Z8G/yN094LrU6ZswWL5i50UJOdNZI8+g/fG8EA
         F4tLJfJpr1wD9KVw9/gLot3EbTYRvFaGOm6B3I/GjOqYFYPqMyEP90DSrIMorYqoF0
         ADJu1688mVobT6eH3ZbXIjj3u7XmTMj4DcfNNU+KHnn+odTMko6ZHsKsDB+6053q39
         x7w7X+MZIB/XbNHODn7DuLQOaZmYlqjmBPGXuGfPlSXgD4HtqMowGWBs+Q+x/8cpdh
         I7CnvXsPLBQEQ==
Date:   Tue, 19 Sep 2023 12:00:30 +0100
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
Subject: Re: [PATCH v4 3/7] dt-bindings: hwmon: Add possible new properties
 to max31827 bindings
Message-ID: <20230919-f2858c937249f5c6746d416b@fedora>
References: <20230919093456.10592-1-daniel.matyas@analog.com>
 <20230919093456.10592-3-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+bnDgX8rN5Rak+ZZ"
Content-Disposition: inline
In-Reply-To: <20230919093456.10592-3-daniel.matyas@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+bnDgX8rN5Rak+ZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Sep 19, 2023 at 12:34:51PM +0300, Daniel Matyas wrote:
> These modify the corresponding bits in the configuration register.
>=20
> adi,comp-int is a hardware property, because it affects the behavior
> of the interrupt signal and whatever it is connected to.
>=20
> adi,timeout-enable is a hardware property, because it affects i2c
> bus operation.
>=20
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>

Thanks for the updates. This looks okay to me now.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>=20
> v3 -> v4: Changed property names (adi,flt-q =3D adi,fault-q; adi,alrm-pol
> =3D adi,alarm-pol). Expressed default values in binding.
>=20
> v2 -> v3: Changed commit subject and message
>=20
> v1 -> v2: Added adi,timeout-enable property to binding. Fixed
> dt_binding_check errors.
>=20
>  .../bindings/hwmon/adi,max31827.yaml          | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/=
Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> index 2dc8b07b4d3b..f60e06ab7d0a 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> @@ -32,6 +32,68 @@ properties:
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
> +  adi,alarm-pol:
> +    description:
> +      Sets the alarms active state.
> +            - 0 =3D active low
> +            - 1 =3D active high
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  adi,fault-q:
> +    description:
> +      Select how many consecutive temperature faults must occur before
> +      overtemperature or undertemperature faults are indicated in the
> +      corresponding status bits.
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
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,max31829
> +
> +    then:
> +      properties:
> +        adi,alarm-pol:
> +          default: 1
> +
> +    else:
> +      properties:
> +        adi,alarm-pol:
> +          default: 0
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,max31827
> +
> +    then:
> +      properties:
> +        adi,fault-q:
> +          default: 1
> +
> +    else:
> +      properties:
> +        adi,fault-q:
> +          default: 4
> +
> +
>  required:
>    - compatible
>    - reg
> @@ -49,6 +111,10 @@ examples:
>              compatible =3D "adi,max31827";
>              reg =3D <0x42>;
>              vref-supply =3D <&reg_vdd>;
> +            adi,comp-int;
> +            adi,alarm-pol =3D <0>;
> +            adi,fault-q =3D <1>;
> +            adi,timeout-enable;
>          };
>      };
>  ...
> --=20
> 2.34.1
>=20

--+bnDgX8rN5Rak+ZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQl/SwAKCRB4tDGHoIJi
0lIhAQDC5V+WeEqVcdnL49Hgv0BWfJn95IGYtTsh6LaOMhVwqgEA/vjkH07s3R7P
N+WNivHH24dE+u4jHH20ugjnxuDoegY=
=JfNV
-----END PGP SIGNATURE-----

--+bnDgX8rN5Rak+ZZ--
