Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4C7EC578
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344069AbjKOOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344040AbjKOOjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:39:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E695
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:38:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14A5C433C8;
        Wed, 15 Nov 2023 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700059137;
        bh=V6YbwlGcrf2Z9pv+riw05AJ1AB+MKCO/JbUd36Barhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCHf3pqhF4URY84pt75400f8LCvqCFX9rOe1/AJnXhtMQQYT0KHbR4ow9znYb58lx
         JmcfqiDM8oTaMGjZPmLodk6uwmKBauUUrk91Wo3fDSTpmnfUHsIoLoNgt536vSprve
         CBk56G0MBPrhaDxO/zt5Kaw9khOJiAENffeXtryF6cLWyb7rJamSLh4WMOjBPSM1ho
         cL3vzpvromKAMWA9+rR7s1VjI8fbHbxP6ZQrbFXDan8nX1C5BbSjFe7KXGgFNOlAGf
         tzB9NT+Hk6oNGAlM8KiXkTqqq78emc5aQjWj5to/KieCytTXdSngjnPmd0tlqNkbU+
         4MmvO85fN9CZQ==
Date:   Wed, 15 Nov 2023 14:38:54 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: trivial-devices: add aosong,ags02ma
Message-ID: <20231115-stability-arrive-e0458f6f7b0f@squawk>
References: <20231115125810.1394854-1-anshulusr@gmail.com>
 <20231115125810.1394854-2-anshulusr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1U46IvZoQyzS/ftn"
Content-Disposition: inline
In-Reply-To: <20231115125810.1394854-2-anshulusr@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1U46IvZoQyzS/ftn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 06:28:07PM +0530, Anshul Dalal wrote:
> Add bindings for Aosong AGS02MA TVOC sensor.
>=20
> The sensor communicates over i2c with the default address 0x1a.
> TVOC values can be read in the units of ppb and ug/m^3 at register 0x00.
>=20
> Datasheet:
>   https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> Product-Page:
>   http://www.aosong.com/m/en/products-33.html
>=20
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> ---
>=20
> Changes for v2:
> - Removed device from trivial-devices

Your $subject still says "trivial-devices" though, so please fix that in
your next submission.

> - Added standalone binding with vdd-supply property
> ---
>  .../bindings/iio/chemical/aosong,ags02ma.yaml | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/aosong=
,ags02ma.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/chemical/aosong,ags02m=
a.yaml b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
> new file mode 100644
> index 000000000000..4a0278c6318c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/chemical/aosong,ags02ma.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/chemical/aosong,ags02ma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aosong AGS02MA VOC Sensor
> +
> +description: |
> +  AGS02MA is an TVOC (Total Volatile Organic Compounds) i2c sensor with =
default
> +  address of 0x1a.
> +
> +  Datasheet:
> +    https://asairsensors.com/wp-content/uploads/2021/09/AGS02MA.pdf
> +
> +maintainers:
> +  - Anshul Dalal <anshulusr@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aosong,ags02ma
> +      - asair,ags02ma

Why do you have two compatibles for the same device? Please document and
use only one of these. The aoson website says:
"Guangzhou ASAIR Electronic Co., Ltd"
so I suspect "asair" is a more apt vendor prefix.


Thanks,
Conor.

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
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        light-sensor@1a {
> +            compatible =3D "aosong,ags02ma";
> +            reg =3D <0x1a>;
> +            vdd-supply =3D <&vdd_regulator>;
> +        };
> +    };
> --=20
> 2.42.0
>=20

--1U46IvZoQyzS/ftn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVTX6AAKCRB4tDGHoIJi
0p8YAP97yIsknJKuaKNoFLpkjtdd7KHr4eWGOq6p5+3kJSLLdQEArd6XtnHdgfui
DfxPLrSxiaGIQHzHgjrlBCnSVV4pLAU=
=f488
-----END PGP SIGNATURE-----

--1U46IvZoQyzS/ftn--
