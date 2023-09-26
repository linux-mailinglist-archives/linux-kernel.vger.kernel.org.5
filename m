Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787097AED99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjIZNED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjIZNEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:04:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55CC9;
        Tue, 26 Sep 2023 06:03:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3616EC433C8;
        Tue, 26 Sep 2023 13:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695733435;
        bh=wfl6PSkicMbQ19c5+7nPo++8qzhAyuUvd4GKwLBD9XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxggefr0ckrs614BmCsTYWKfD6fRHT3XyJsneL9S428wOL+x8Ryg2688/A+pP/fph
         l3A+u1eNBFLOYKus+axL/QYYfkvHyEql29DwkZabkyMSCuwRQoFB/CN+XzxFPc1xsH
         ocJa27AGeX4qm3Kyn9/4AI6bPuL+ggm7eqopexPmPjPOqiNBog9x6P9NdQIFDFA3Sv
         HR6FKgUq7KSd5s33NWHxkIbfFYmYJbpmBnM+0gnZstUjc8+m9VHVKAdXz9lz1OlmEQ
         kf/Xng3D8F7TRdExhkjJm4R3v7TXmRPT4m2L3gtQoSMXO1SxDIukLV1wAzfnl/IiFM
         8P9YOTTTMAHZQ==
Date:   Tue, 26 Sep 2023 14:03:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: Add missing unevaluatedProperties on
 child node schemas
Message-ID: <20230926-untying-booting-7744376e955b@spud>
References: <20230925212803.1976803-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9nLnT1SikReH0C+P"
Content-Disposition: inline
In-Reply-To: <20230925212803.1976803-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9nLnT1SikReH0C+P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 04:27:58PM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml    | 1 +
>  .../devicetree/bindings/media/i2c/toshiba,tc358746.yaml         | 2 ++
>  Documentation/devicetree/bindings/media/samsung,fimc.yaml       | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml=
 b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> index ffccf5f3c9e3..642f9b15d359 100644
> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx415.yaml
> @@ -54,6 +54,7 @@ properties:
> =20
>    port:
>      $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> =20
>      properties:
>        endpoint:
> diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746=
=2Eyaml b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> index c5cab549ee8e..1c476b635b69 100644
> --- a/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> @@ -69,6 +69,7 @@ properties:
>      properties:
>        port@0:
>          $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description: Input port
> =20
>          properties:
> @@ -89,6 +90,7 @@ properties:
> =20
>        port@1:
>          $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description: Output port
> =20
>          properties:
> diff --git a/Documentation/devicetree/bindings/media/samsung,fimc.yaml b/=
Documentation/devicetree/bindings/media/samsung,fimc.yaml
> index 79ff6d83a9fd..b3486c38a05b 100644
> --- a/Documentation/devicetree/bindings/media/samsung,fimc.yaml
> +++ b/Documentation/devicetree/bindings/media/samsung,fimc.yaml
> @@ -57,6 +57,7 @@ properties:
>      patternProperties:
>        "^port@[01]$":
>          $ref: /schemas/graph.yaml#/$defs/port-base
> +        unevaluatedProperties: false
>          description:
>            Camera A and camera B inputs.
> =20
> --=20
> 2.40.1
>=20

--9nLnT1SikReH0C+P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRLWtQAKCRB4tDGHoIJi
0pKXAP4vPFXRlytem7/2OyutY69usbQYIokQoAx4XzrGl7bAlgEA9dHgJjs1i5fJ
6g53rKEgA61fFIafEo7ysNfDZs3qjQU=
=VkdZ
-----END PGP SIGNATURE-----

--9nLnT1SikReH0C+P--
