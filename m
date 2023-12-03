Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24738022B3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 12:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjLCLYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 06:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCLYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 06:24:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBA0C1
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 03:24:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08CD3C433C7;
        Sun,  3 Dec 2023 11:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701602675;
        bh=+hli562zk5dYtpGn2rXW8IygBpXXsf4LYyXt8bwX9bU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Os2huNSnaTDA7CdOUExN3Wa+xKx51n8bWFYxm8eA4gj0wytV/c0WPB6H57qGpiunV
         IGIL+3iWZwS+iFfByNCZ2BYUvdkh1/ULbjDpL2+Y+IjfZbM9EGEAyxvTHxH7A2fwxB
         Dtxue4iTcEw0BB1IUhPoVFJTq79bOKdAqANc5sul1Qlqt9hvpoqlrYOEElotWE60n/
         SBdJMGQRnkJF2fqJFpLq/1PGaSeDpBoEO86kaIOPMTZk/MJB0lwrcPntivqrAGrbMh
         4Xm/wLJVsmnxT6Cf3sxoZoi2XNZKfaR6tivXRGiidDicxnibhZIH/tmi0W3h39GIH6
         YHJ2SlnFznMLQ==
Date:   Sun, 3 Dec 2023 11:24:31 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, lars@metafoo.de, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: temperature: Add AMS AS6200
Message-ID: <20231203-wrecking-sneer-d34f19c39f04@spud>
References: <20231202041651.719963-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VO1eO5mEsXF2CF0y"
Content-Disposition: inline
In-Reply-To: <20231202041651.719963-1-alkuor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VO1eO5mEsXF2CF0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 11:16:50PM -0500, Abdel Alkuor wrote:
> as6200 is high accuracy temperature sensor of -/+ 0.4C degree

Is +/- 0.4 degrees really "high accuracy"?

> with a range between -40C to 125C degrees
>=20
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
> Changes in v2:
>   - Add vdd-supply
>=20
>  .../bindings/iio/temperature/ams,as6200.yaml  | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ams=
,as6200.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ams,as6200=
=2Eyaml b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> new file mode 100644
> index 000000000000..a1817795cdca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/ams,as6200.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/ams,as6200.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMS AS6200 Temperature Sensor
> +
> +maintainers:
> +  - Abdel Alkuor <alkuor@gmail.com>
> +
> +description: |

Please add the text from your commit message (although perhaps dropping
the "high accuracy" section) here.

Otherwise, this looks okay to me.

Thanks,
Conor.

> +  https://ams.com/documents/20143/36005/AS6200_DS000449_4-00.pdf
> +
> +properties:
> +  compatible:
> +    const: ams,as6200
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
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
> +        temperature-sensor@48 {
> +            compatible =3D "ams,as6200";
> +            reg =3D <0x48>;
> +            vdd-supply =3D <&vdd>;
> +            interrupt-parent =3D <&gpio1>;
> +            interrupts =3D <17 IRQ_TYPE_EDGE_BOTH>;
> +        };
> +    };
> +...
> --=20
> 2.34.1
>=20

--VO1eO5mEsXF2CF0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWxlbwAKCRB4tDGHoIJi
0vpyAQCfmd+i6NPXT2jdvO2gdFD/qBee+EWn0M4wbPRYUWeBFwEAiu4RIcctDI90
G7b23mXguq1l0mFtK5hAdkZjABenWAU=
=0u24
-----END PGP SIGNATURE-----

--VO1eO5mEsXF2CF0y--
