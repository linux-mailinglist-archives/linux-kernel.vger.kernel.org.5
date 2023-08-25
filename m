Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FBF788C60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbjHYPVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbjHYPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E54E2121;
        Fri, 25 Aug 2023 08:21:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 242AF63962;
        Fri, 25 Aug 2023 15:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7806AC433C8;
        Fri, 25 Aug 2023 15:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692976872;
        bh=nDviS9HsAv0tkzmQ79o/c/ExUauj2KyIQAmBYZo4VOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1VGvFh3GHfqixzp+I2NJIVjntmd8evAuvYM3DOVK2J5VmvpprIMxfR2rt+ocIjRJ
         5iaZdujV+t6geQGJ5F5F56fP/rVPo8faFC21YiERGKk5iKnyk59+fKq1+66uIqrnnS
         Xdp/vRu3QaUD4fN7lyAXkfvTxuzs6BO9kItQSQhBDaJKSWOxTVJf9V1B5XA2Dodbus
         dS1zxhzOILAmJ6Y80HZ/7ffKdgAGMwMjyeY+mAcLBFK0nXeIwQS4VEnaHDo+bua1uI
         la4P6BmHm7y3dQw8s7ANV5RypO0jreBS4b5HO5pYgbikt6HSx8ajHv11Fky5DGQPMZ
         eOSqCorq2x9IA==
Date:   Fri, 25 Aug 2023 16:21:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: correct minimum number
 of clocks
Message-ID: <20230825-strut-hurried-c3a697851b68@spud>
References: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZNWDsuAgtxaqtp9A"
Content-Disposition: inline
In-Reply-To: <20230825135503.282135-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZNWDsuAgtxaqtp9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2023 at 03:55:02PM +0200, Krzysztof Kozlowski wrote:
> In the TXT binding before conversion, the "xo" clock was listed as
> optional.  Conversion kept it optional in "clock-names", but not in
> "clocks".  This fixes dbts_check warnings like:
>=20
>   qcom-sdx65-mtp.dtb: mmc@8804000: clocks: [[13, 59], [13, 58]] is too sh=
ort
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings to ya=
ml")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Docum=
entation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 80141eb7fc6b..10f34aa8ba8a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -69,7 +69,7 @@ properties:
>      maxItems: 4
> =20
>    clocks:
> -    minItems: 3
> +    minItems: 2
>      items:
>        - description: Main peripheral bus clock, PCLK/HCLK - AHB Bus clock
>        - description: SDC MMC clock, MCLK
> --=20
> 2.34.1
>=20

--ZNWDsuAgtxaqtp9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZOjG5AAKCRB4tDGHoIJi
0giUAQDP0J2VGCvYJbWzw6NE42utrM2bU44XWNLv1LGnLLFE3wD+Mh6DsbRpHdnx
dyRzV3v06uiDJWyquL8G9cn3F/maXw0=
=c5cy
-----END PGP SIGNATURE-----

--ZNWDsuAgtxaqtp9A--
