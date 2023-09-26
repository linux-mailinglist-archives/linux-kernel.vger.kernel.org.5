Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743A97AEDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjIZN0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjIZNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:25:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1182B4;
        Tue, 26 Sep 2023 06:25:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57EDC433C8;
        Tue, 26 Sep 2023 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695734751;
        bh=Ad5HUhPEQj40kGgmNxNGQfjNC2SztcpqDvyMP2qHtaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e+UEasE7mJB5wVg49Yb7RoUWryT/uylyMtAIlEBr/Q7wavS9BKub+GBa+bzvXWfYm
         1hCu1ptxSPAIFwybbWRUjMNEUokd9C6QeBSYIzgtmZJq/PsYxnid57yCjR0jY87b0j
         qcR8MQ2yoFmWdSKLhtsHiZyNVIS+HVOr6+0ZZLIlOvDKwaRy36nEio3Gil47bRhwuu
         oSP0nlsIlyr9E+EX7OOdAZO+yNbQnAtjiSuazJDlNl+wgSNb68Uyz7HcE8KdOD+E/0
         xObc2w+mcved+DxIOu8goWySwQb6svG4YLgTPxS9AUVd09UA+XBPiWYl2sc1cmfbo7
         tFY/36EwU8V+A==
Date:   Tue, 26 Sep 2023 14:25:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign slot for imx
 jpeg encoder/decoder
Message-ID: <20230926-slackness-target-b74e33ab1031@spud>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7eY7R+Myp0ZzWp6O"
Content-Disposition: inline
In-Reply-To: <20230926101000.13392-2-ming.qian@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7eY7R+Myp0ZzWp6O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 26, 2023 at 06:10:00PM +0800, Ming Qian wrote:
> There are total 4 slots available in the IP, and we only need to use one
> slot in one os, assign a single slot, configure interrupt and power
> domain only for 1 slot, not for the all 4 slots.
>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
> v4
> - improve commit message

> - don't make an ABI break

What does this mean? Can you please try to explain things a bit more
clearly in your changelogs?

Also, where is the code that actually makes use of these properties?

> v3
> - add vender prefix, change property slot to nxp,slot
> - add type for property slot
>=20
>  .../bindings/media/nxp,imx8-jpeg.yaml         | 45 +++++++++----------
>  1 file changed, 21 insertions(+), 24 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b=
/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> index 3d9d1db37040..4bcfc815c894 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -32,19 +32,26 @@ properties:
>      maxItems: 1
> =20
>    interrupts:
> -    description: |
> -      There are 4 slots available in the IP, which the driver may use
> -      If a certain slot is used, it should have an associated interrupt
> -      The interrupt with index i is assumed to be for slot i
> -    minItems: 1               # At least one slot is needed by the driver
> -    maxItems: 4               # The IP has 4 slots available for use
> +    description:
> +      Interrupt number for slot
> +    maxItems: 1

So, what happens to users that already exist that have 2, 3 or 4
interrupts? Your commit message says:
> There are total 4 slots available in the IP, and we only need to use one
> slot in one os, assign a single slot, configure interrupt and power
> domain only for 1 slot, not for the all 4 slots.

Note that "only need to use one" doesn't mean that a user might not
want to use more than one. Is it possible to use more than one slot?

Also, if the interrupt numbers map 1:1 to slots, as the previous binding
states, why do you even need this new "nxp,slot" property?

Thanks,
Conor.

> =20
>    power-domains:
>      description:
>        List of phandle and PM domain specifier as documented in
>        Documentation/devicetree/bindings/power/power_domain.txt
> -    minItems: 2               # Wrapper and 1 slot
> -    maxItems: 5               # Wrapper and 4 slots
> +    minItems: 1               # VPUMIX
> +    maxItems: 2               # Wrapper and 1 slot
> +
> +  nxp,slot:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Integer number of slot index used. There are 4 slots available in =
the IP,
> +      and driver can use a certain slot, it should have an associated in=
terrupt
> +      and power-domain. In theory, it supports 4 os or vm. If not specif=
ied, 0
> +      is used by default.
> +    minimum: 0
> +    maximum: 3
> =20
>  required:
>    - compatible
> @@ -62,28 +69,18 @@ examples:
>      jpegdec: jpegdec@58400000 {
>          compatible =3D "nxp,imx8qxp-jpgdec";
>          reg =3D <0x58400000 0x00050000 >;
> -        interrupts =3D <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
> -                     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
> -                     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
> -                     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupts =3D <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
>          power-domains =3D <&pd IMX_SC_R_MJPEG_DEC_MP>,
> -                        <&pd IMX_SC_R_MJPEG_DEC_S0>,
> -                        <&pd IMX_SC_R_MJPEG_DEC_S1>,
> -                        <&pd IMX_SC_R_MJPEG_DEC_S2>,
> -                        <&pd IMX_SC_R_MJPEG_DEC_S3>;
> +                        <&pd IMX_SC_R_MJPEG_DEC_S0>;
> +        nxp,slot =3D <0>;
>      };
> =20
>      jpegenc: jpegenc@58450000 {
>          compatible =3D "nxp,imx8qm-jpgenc", "nxp,imx8qxp-jpgenc";
>          reg =3D <0x58450000 0x00050000 >;
> -        interrupts =3D <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
> -                     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
> -                     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
> -                     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupts =3D <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
>          power-domains =3D <&pd IMX_SC_R_MJPEG_ENC_MP>,
> -                        <&pd IMX_SC_R_MJPEG_ENC_S0>,
> -                        <&pd IMX_SC_R_MJPEG_ENC_S1>,
> -                        <&pd IMX_SC_R_MJPEG_ENC_S2>,
> -                        <&pd IMX_SC_R_MJPEG_ENC_S3>;
> +                        <&pd IMX_SC_R_MJPEG_ENC_S0>;
> +        nxp,slot =3D <0>;
>      };
>  ...
> --=20
> 2.38.1
>=20

--7eY7R+Myp0ZzWp6O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRLb2QAKCRB4tDGHoIJi
0rLVAP490xhNnzsc7JCNkZo8y8ijcSPOgsQTTnBa/itMeZP5VQEA9H77egyoeeCt
VfvJ/btIc+SD/849pirq+9fKnia3Dw4=
=VyRg
-----END PGP SIGNATURE-----

--7eY7R+Myp0ZzWp6O--
