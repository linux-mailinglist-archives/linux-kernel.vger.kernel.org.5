Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79FD80F3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjLLRFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjLLRFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:05:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C89A8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:05:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEB1C433C8;
        Tue, 12 Dec 2023 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702400720;
        bh=fgV/ueNCtkTrCI5wjYcDbyfn6cdCjZFdcNhi/pc5XFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGwTmpLszqMAvT1evkp2WwFB1pDOGD7rISsvdX5xDl5WWqzXBLn+JuMwv3tU4N/Ai
         vsuXfs9GuU9Fnyf3Gs0qJv9usvlHPRdQXM3k0/2BMsCYT/Y4XDHY1AybP0RpcfV0OM
         AKjmZJMosm46YCKHmSyUtGxgvfdVfPiMnJbeGmNll4RnItyAFNGM0MJUL5OVXFbXp+
         Oupnz3bcVAj2fhVNuO3qDuDZLot8Qwsbx4hReJRayWmhoquRaW/uKIDojvK8k4Ru3q
         MycgSsg6L8ckbaWCFIWCYK9ZI8Fbh4NAgAY7dAXtT7BiAX59JOLdkmL4bvZkrXZCW5
         frUwGUQR+GWBw==
Date:   Tue, 12 Dec 2023 17:05:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: synopsys-dw-mshc: add iommus for Intel
 SocFPGA
Message-ID: <20231212-situation-catapult-31deb18f55e6@spud>
References: <20231209171013.249972-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2mllp56Yojhimxyx"
Content-Disposition: inline
In-Reply-To: <20231209171013.249972-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2mllp56Yojhimxyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 06:10:13PM +0100, Krzysztof Kozlowski wrote:
> The DW MSHC node in Intel SocFPGA ARM64 DTS has iommus property, so
> allow it to silence dtbs_check warnings:
>=20
>   socfpga_n5x_socdk.dtb: mmc@ff808000: Unevaluated properties are not all=
owed ('iommus' was unexpected)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> I assume the DTS represents the hardware, thus iommus is real.

Assuming it is in fact real,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml =
b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index b13b5166d20a..a6292777e376 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -35,6 +35,9 @@ properties:
>        - const: biu
>        - const: ciu
> =20
> +  iommus:
> +    maxItems: 1
> +
>    altr,sysmgr-syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      items:
> @@ -62,6 +65,7 @@ allOf:
>          altr,sysmgr-syscon: true
>      else:
>        properties:
> +        iommus: false
>          altr,sysmgr-syscon: false
> =20
>  required:
> --=20
> 2.34.1
>=20

--2mllp56Yojhimxyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiSzAAKCRB4tDGHoIJi
0guKAP9KpXptHIwPy8y65zTLRaA5ROCdUPXQxch5VszAJOa7WgEAxqSaZF2RNUAA
Q44AUjPOny9XxYcpphYjYaoX3kr8Tg0=
=rnlC
-----END PGP SIGNATURE-----

--2mllp56Yojhimxyx--
