Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEFC76D1EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbjHBP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbjHBP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F31E5B99;
        Wed,  2 Aug 2023 08:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB4D7619D9;
        Wed,  2 Aug 2023 15:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A9BC433CA;
        Wed,  2 Aug 2023 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690989917;
        bh=AeQuHnRz78kJXWkIoo7Eh5UjMQZv1MCQAnguSjPCWp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HG3XTVpU/reo5tH0XqL1tyoVb5nW1nI3xWwqPCRaw3dz/Qd6YFGLTA5qxT6svzXFs
         uv5S0jUqEBrX3BKGoC9ngSt0c355zMu2Wm3k+1IviuqFMRG2vSLUqvfbUSnH/rpBTD
         XFHbpkeo4mSfsiD59PdXaDsuuixkzP/mzzBoVVEGRIpcIttyTk1DZ5B6KHTfQyE20h
         UbhwG/96kNJtsrscg0gPrf+xg3CkUpAJLBk9xW2XF2TITBxeeaH63Ca8lv3G1hR2D6
         16wXcQvfhXg9vCpWdoRECW4eT/VIaGN5JboCNKGiGScodz72CLjabph6bONphpbxm0
         UjAVX5Rs+IXMw==
Date:   Wed, 2 Aug 2023 16:25:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: media: Add OV5642
Message-ID: <20230802-outreach-national-92083a670b58@spud>
References: <20230801234047.136099-1-festevam@denx.de>
 <20230801234047.136099-2-festevam@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gHHBdX6BD8VDI3dc"
Content-Disposition: inline
In-Reply-To: <20230801234047.136099-2-festevam@denx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gHHBdX6BD8VDI3dc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,=20

On Tue, Aug 01, 2023 at 08:40:47PM -0300, Fabio Estevam wrote:
> Add DT bindings for OmniVision OV5642 Image Sensor.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Thanks for doing this. It looks good to me, although I got a complaint
=66rom git while applying it locally:
Applying: dt-bindings: trivial-devices: Remove the OV5642 entry
Applying: dt-bindings: media: Add OV5642
/stuff/linux/.git/worktrees/linux-dt/rebase-apply/patch:119: trailing white=
space.
 =20
warning: 1 line adds whitespace errors.

I think you can probably squash both patches and add a
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
I have one minor comment below.

I also think it'd be good to CC the media folks though on this.

> ---
> Changes since v1:
> - Introduce ov5642.yaml (Conor).
>=20
>  .../bindings/media/i2c/ovti,ov5642.yaml       | 118 ++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov56=
42.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml=
 b/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml
> new file mode 100644
> index 000000000000..585b4fcf01b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5642.yaml
> @@ -0,0 +1,118 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Bindings are usually dual licensed. Is there a reason not to do so here?

Thanks,
Conor.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov5642.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OmniVision OV5642 Image Sensor
> +
> +maintainers:
> +  - Fabio Estevam <festevam@gmail.com>
> +
> +allOf:
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  compatible:
> +    const: ovti,ov5642
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description: XCLK Input Clock
> +
> +  clock-names:
> +    const: xclk
> +
> +  AVDD-supply:
> +    description: Analog voltage supply, 2.8V.
> +
> +  DVDD-supply:
> +    description: Digital core voltage supply, 1.5V.
> +
> +  DOVDD-supply:
> +    description: Digital I/O voltage supply, 1.8V.
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description: Reference to the GPIO connected to the powerdown pin, i=
f any.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: Reference to the GPIO connected to the reset pin, if an=
y.
> +
> +  rotation:
> +    enum:
> +      - 0
> +      - 180
> +
> +  port:
> +    description: Digital Output Port
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    additionalProperties: false
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          clock-lanes:
> +            const: 0
> +
> +          data-lanes:
> +            minItems: 1
> +            maxItems: 2
> +            items:
> +              enum: [1, 2]
> +
> +          bus-width:
> +            enum: [8, 10]
> +
> +          data-shift:
> +            enum: [0, 2]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      #include <dt-bindings/gpio/gpio.h>
> +
> +      i2c {
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +
> +          camera@3c {
> +              compatible =3D "ovti,ov5642";
> +              pinctrl-names =3D "default";
> +              pinctrl-0 =3D <&pinctrl_ov5642>;
> +              reg =3D <0x3c>;
> +              clocks =3D <&clk_ext_camera>;
> +              clock-names =3D "xclk";
> +              DOVDD-supply =3D <&vgen4_reg>;
> +              AVDD-supply =3D <&vgen3_reg>;
> +              DVDD-supply =3D <&vgen2_reg>;
> +              powerdown-gpios =3D <&gpio1 19 GPIO_ACTIVE_HIGH>;
> +              reset-gpios =3D <&gpio1 20 GPIO_ACTIVE_LOW>;
> + =20
> +              port {
> +                  /* Parallel bus endpoint */
> +                  ov5642_to_parallel: endpoint {
> +                      remote-endpoint =3D <&parallel_from_ov5642>;
> +                      bus-width =3D <8>;
> +                      data-shift =3D <2>; /* lines 9:2 are used */
> +                      hsync-active =3D <0>;
> +                      vsync-active =3D <0>;
> +                      pclk-sample =3D <1>;
> +                  };
> +              };
> +          };
> +      };
> --=20
> 2.34.1
>=20

--gHHBdX6BD8VDI3dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMp1WQAKCRB4tDGHoIJi
0l6VAP4zVL8T00BzoCqghCkMowfC+RZCTRVbPjlD+d761ELSjgD/fd6tr6BBM2iX
V2iocxEWEHbrtVHZ4m6x3sWqKDsvkgc=
=s1Hy
-----END PGP SIGNATURE-----

--gHHBdX6BD8VDI3dc--
