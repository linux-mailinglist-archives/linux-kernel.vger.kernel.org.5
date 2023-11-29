Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4E17FD972
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjK2OdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjK2OdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:33:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01826DD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:33:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8878EC433C8;
        Wed, 29 Nov 2023 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701268388;
        bh=nCUBip91VJPgVyaRslm47tg3WMaKjh0DptQ7V1+aaG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gKvcWnywP2uOCwGWoh/fP1tY3br+768+t7iK5/AZ4GIT9leS8LhJRzql7QKALNfgu
         RpMq1oALiCXCTkejzxvkSrRJQOXq0zFSK4VPIaje+KdTwntmUubIdIAUb/nRPVyo0p
         8QPYGbx3Q5TSc5ADZ2ylf2mOuQ3hP5EeFXfdpAhA+U/fQlrZ4RYWTt1J+DUrdXGBjT
         w5OwbXD+MRpy5MgC4KnKWrnbkW1p8+XXefb+Jc+qpKSB5yO5dFUAyDWV7tw2Jj/Gym
         +uQOWJuzDC9xhl8mCQEMU4yyTZSKba4BLEC86SIpz2m2yjOv1UtByqawi80aBojCUa
         tOM1QGWgSP2Cw==
Date:   Wed, 29 Nov 2023 14:33:03 +0000
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v8 1/4] dt-bindings: pwm: Add bindings for OpenCores PWM
 Controller
Message-ID: <20231129-chaplain-unseeing-e433ec830946@spud>
References: <20231129092732.43387-1-william.qiu@starfivetech.com>
 <20231129092732.43387-2-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sVewkJ1jWgEyqNJ1"
Content-Disposition: inline
In-Reply-To: <20231129092732.43387-2-william.qiu@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sVewkJ1jWgEyqNJ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 05:27:29PM +0800, William Qiu wrote:
> Add bindings for OpenCores PWM Controller.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/pwm/opencores,pwm.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/opencores,pwm.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/D=
ocumentation/devicetree/bindings/pwm/opencores,pwm.yaml
> new file mode 100644
> index 000000000000..133f2cd417f0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/opencores,pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OpenCores PWM controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description:
> +  OpenCores PTC ip core contains a PWM controller. When operating in PWM=
 mode,

nit: "The OpenCores PTC IP core"

> +  the PTC core generates binary signal with user-programmable low and hi=
gh
> +  periods. All PTC counters and registers are 32-bit.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - starfive,jh7100-pwm
> +              - starfive,jh7110-pwm
> +          - const: opencores,pwm-v1

properties:
  compatible:
    items:
      - enum:
          - starfive,jh7100-pwm
          - starfive,jh7110-pwm
      - const: opencores,pwm-v1

Please use this form here instead.

Otherwise, this looks good to me now.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm@12490000 {
> +        compatible =3D "starfive,jh7110-pwm", "opencores,pwm-v1";
> +        reg =3D <0x12490000 0x10000>;
> +        clocks =3D <&clkgen 181>;
> +        resets =3D <&rstgen 109>;
> +        #pwm-cells =3D <3>;
> +    };
> --=20
> 2.34.1
>=20
>=20

--sVewkJ1jWgEyqNJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWdLnwAKCRB4tDGHoIJi
0vPNAP4lxb47TExjCroRAbRfe1Mqkn9kvWfUqdQghEp5AktsygD/V4IHEgg4y71a
Q6fQO+IQS9o36EIZJ2aOmiys/FLW0gw=
=TUhN
-----END PGP SIGNATURE-----

--sVewkJ1jWgEyqNJ1--
