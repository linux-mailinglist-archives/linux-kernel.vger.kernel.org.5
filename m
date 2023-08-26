Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE178955F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjHZJnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjHZJna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:43:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149AFE7A;
        Sat, 26 Aug 2023 02:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A74FD62354;
        Sat, 26 Aug 2023 09:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA834C433C7;
        Sat, 26 Aug 2023 09:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693042991;
        bh=w4am/4JAWICl0+CM2N3F7pWomtDuzhla+/3J5rQhiMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugs14BCGUAJYiqi35vosJIaFDHIaOTqD34R3p705yf5BbqxkZjr7MczjUlnsknhJe
         JA8S5lys6EJh8H4AFrH7cj/LSSmuyeKfLMCr10HlnPyMIVrL/OjukYC+dvr5J0NChR
         eeEYu16i0DP+H7cEMSZiBkMM8JIokjkY5h/vgtAZZyfURhKzuVQrT5BXYNgBCDiofP
         AYX3C5S8NrEv3JGUmLsC9VBC0yJSJyYL20HVcSmN8BKWpua7pAbZgsIWOMud0VGLF2
         7tpvU9/jThTvjGDP/l6+Fb4CFWNkHcNroMonL/TdgVQSEEDk6wy+sltiB6dFRSX31u
         WD26DX7li0EfA==
Date:   Sat, 26 Aug 2023 10:43:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: amlogic,meson-nand: drop unneeded
 quotes
Message-ID: <20230826-undercoat-unworldly-7f2dc4c29cce@spud>
References: <20230826093852.9334-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3Pe3eE9k3gd9AmCP"
Content-Disposition: inline
In-Reply-To: <20230826093852.9334-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Pe3eE9k3gd9AmCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 26, 2023 at 11:38:52AM +0200, Krzysztof Kozlowski wrote:
> Drop unneeded quotes over simple string values to fix recently enabled
> yamllint warning:
>=20
>   [error] string value is redundantly quoted with any quotes (quoted-stri=
ngs)
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yam=
l b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 1c79815e1f7f..57b6957c8415 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -67,8 +67,8 @@ patternProperties:
>      unevaluatedProperties: false
> =20
>      dependencies:
> -      nand-ecc-strength: ['nand-ecc-step-size']
> -      nand-ecc-step-size: ['nand-ecc-strength']
> +      nand-ecc-strength: [nand-ecc-step-size]
> +      nand-ecc-step-size: [nand-ecc-strength]

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--3Pe3eE9k3gd9AmCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOnJKQAKCRB4tDGHoIJi
0tmIAQCqkCDtBMSX2SeEUQNybarIOacjn8MxbYP0QEVx3FwFYwEA/pe8aKWZFXpT
/0efo5eoP4xpSQJyVaXB3RvpgiPHmAc=
=pOjg
-----END PGP SIGNATURE-----

--3Pe3eE9k3gd9AmCP--
