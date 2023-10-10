Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C2B7C0077
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjJJPgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbjJJPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:36:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47F2C9;
        Tue, 10 Oct 2023 08:35:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED1BC433C9;
        Tue, 10 Oct 2023 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952159;
        bh=GiaOPPDy4bW4X7nEWcj7MoZCeHaezgGt8naPNPK93zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8biabOl05FB1gUCz/EDVfI+FRtECFy1Tb+F1b2tGqzQzDwsVQcgNOV2vBw3drHnm
         iVtbzdxX3UZ+94nxIYjutSw3BrJmL1q52+WJL2VpijOdrse8/bQMryrqxCRNsRULF6
         O8Wkc9zuPeF86cCreJO9f3pwwozQDrhxPeBc4V+CG+CRK9/ru9ABQetD6/s4YhK5Yn
         dicqbnZ10X2FTwTZa9/FkJgQjKICMZEtAbuIHw87FXpZbzMwkvKHgvTur7/iJuZdi/
         1FnRClzfc8tkrePzTOxvbl4vscRu7aJKk30PG2OrbK7eYyYKiFyN893W9ZK8v2Pytt
         AifMIwyJxhkfA==
Date:   Tue, 10 Oct 2023 16:35:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, ezequiel@vanguardiasur.com.ar,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v7 1/3] media: dt-bindings: media: add bindings for
 Rockchip VIP
Message-ID: <20231010-roman-corrode-a68390d5f330@spud>
References: <cover.1696943295.git.mehdi.djait@bootlin.com>
 <a103d2e4e2c80a97a62574a782eba29f78731471.1696943295.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4l9OsQtFT88SXVQA"
Content-Disposition: inline
In-Reply-To: <a103d2e4e2c80a97a62574a782eba29f78731471.1696943295.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4l9OsQtFT88SXVQA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 03:15:04PM +0200, Mehdi Djait wrote:
> Add a documentation for the Rockchip Video Input Processor
> binding.
>=20
> The PX30 SoC is the only platform supported so far.
>=20
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  .../bindings/media/rockchip,px30-vip.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30=
-vip.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/rockchip,px30-vip.ya=
ml b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> new file mode 100644
> index 000000000000..41f0cd58372d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/rockchip,px30-vip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip VIP Camera Interface
> +
> +maintainers:
> +  - Mehdi Djait <mehdi.djait@bootlin.com>
> +
> +description: |-

The |- is not needed here, you've got no fancy formattting to preserve.

> +  Rockchip VIP is the Video Input Processor of the rockchip PX30 SoC. It
> +  receives the data from Camera sensor or CCIR656 encoder and transfers =
it into
> +  system main memory by AXI bus.
> +
> +properties:
> +  compatible:
> +    const: rockchip,px30-vip
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: ACLK
> +      - description: HCLK
> +      - description: PCLK
> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: pclk
> +
> +  resets:
> +    items:
> +      - description: AXI
> +      - description: AHB
> +      - description: PCLK IN
> +
> +  reset-names:
> +    items:
> +      - const: axi
> +      - const: ahb
> +      - const: pclkin
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description: A connection to a sensor or decoder

This description seems unneeded also.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/px30-cru.h>
> +    #include <dt-bindings/power/px30-power.h>
> +
> +    parent {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        vip@ff490000 {

This should be a generic node name.

> +            compatible =3D "rockchip,px30-vip";
> +            reg =3D <0x0 0xff490000 0x0 0x200>;
> +            interrupts =3D <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks =3D <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>;
> +            clock-names =3D "aclk", "hclk", "pclk";
> +            resets =3D <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_=
CIF_PCLKIN>;
> +            reset-names =3D "axi", "ahb", "pclkin";
> +            power-domains =3D <&power PX30_PD_VI>;

Blank line before child nodes please.

Otherwise, this looks mostly fine to me.

> +            port {
> +                endpoint {
> +                    remote-endpoint =3D <&tw9900_out>;
> +                };
> +            };
> +        };
> +    };
> +...
> --=20
> 2.41.0
>=20

--4l9OsQtFT88SXVQA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSVvWQAKCRB4tDGHoIJi
0tc5AP98ZFcwCG4lOs0Vnu/l5rmaIRtV2bVB/xqanyAy7JRp1AD/Z4+6tERcvRTL
dMHfwEobvX/z0gDzR4EemuU1fnenEAM=
=YQ+D
-----END PGP SIGNATURE-----

--4l9OsQtFT88SXVQA--
