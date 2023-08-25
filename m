Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579DC788C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbjHYPaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240731AbjHYPaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:30:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D12134;
        Fri, 25 Aug 2023 08:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5875C66207;
        Fri, 25 Aug 2023 15:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D577FC433C8;
        Fri, 25 Aug 2023 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692977397;
        bh=0ggVuMGhqYH1cp2j3btub6fTuSWhGgHPLeFVcSFRoDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y10PnyFmzviS9TyyOQj12lW79gVpBz6ARtYpp2h/FCMxmk+FNou0ZnU49QYbgICoM
         gCMEGqHy+0vG8Il2wFg24rLOmGTo3LrmU52mhgLOgU3NJUErPLFnULIPtBKK7+BLEs
         h46t94uTWt8Pr3YFjmxKNLOj0IfsETpbuuZ0LyehE2ev7Ut5BJoNh2/cwWv3PNPy6A
         uP2OwfJhY7eP1co6zUnNO1IbxX6XPjHMP4soqwkKijcqp3zK0y/zxnwHKuYVBb0Q14
         spMD/YUtdQfp/pSlY7+iq8mIJsPc3TZbhjwpspLi9gAHzhrZGauh6o4tSMa9Cydhcl
         YKEL4kj/QVKZw==
Date:   Fri, 25 Aug 2023 16:29:53 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mmc: sdhci-msm: allow flexible order of
 optional clocks
Message-ID: <20230825-oversight-dense-8dcf05e38f75@spud>
References: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
 <20230825135503.282135-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wgni+GN1Xz9sorEc"
Content-Disposition: inline
In-Reply-To: <20230825135503.282135-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wgni+GN1Xz9sorEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 03:55:03PM +0200, Krzysztof Kozlowski wrote:
> The Qualcomm SDHCI controller lists optional clocks, but still expects
> fixed order of them and does not allow to skip such clocks if further
> one in the list is needed.  These optional clocks are truly optional,
> so we need to allow the list to have different orders.  The clocks are:
>  - ice: used for Inline Crypto Engine, which is actually separate block
>    and merging it with SDHCI is not a requirement,
>  - bus: clock for SDCC bus frequency voting,
>  - cal and sleep: used for RCLK delay calibration and required for
>    certain platforms for such calibration (as expressed in original
>    commit 4946b3af5e8e ("mmc: sdhci-msm: Enable delay circuit
>    calibration clocks")).  Only MSM8974pro has these clocks.
>=20
> Relaxing the order fixes dtbs_check warnings:
>=20
>   qcom-msm8974pro-fairphone-fp2.dtb: mmc@f9824900: clock-names:3: 'ice' w=
as expected
>   qcom-msm8974pro-fairphone-fp2.dtb: mmc@f9824900: clock-names:4: 'bus' w=
as expected
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Docum=
entation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 10f34aa8ba8a..69a213965089 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -85,10 +85,10 @@ properties:
>        - const: iface
>        - const: core
>        - const: xo
> -      - const: ice
> -      - const: bus
> -      - const: cal
> -      - const: sleep
> +      - enum: [ice, bus, cal, sleep]
> +      - enum: [ice, bus, cal, sleep]
> +      - enum: [ice, bus, cal, sleep]
> +      - enum: [ice, bus, cal, sleep]
> =20
>    dma-coherent: true
> =20
> --=20
> 2.34.1
>=20

--Wgni+GN1Xz9sorEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOjI8QAKCRB4tDGHoIJi
0hBoAPwNVRd3Iq0LZOhIfBYprVsRhjFwSd/8CLf0oEkOZxdgVAEAmG5bfnGOtU/X
XH5fgMkAL4FTG3RdUc7O6yWW2/BvTgU=
=nUSu
-----END PGP SIGNATURE-----

--Wgni+GN1Xz9sorEc--
