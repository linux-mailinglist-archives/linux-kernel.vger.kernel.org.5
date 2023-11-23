Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7946B7F65A7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 18:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjKWRmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 12:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345733AbjKWRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 12:42:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D4A10C2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 09:42:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9AFC433C8;
        Thu, 23 Nov 2023 17:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700761343;
        bh=mnNDN6CYqckEVI/ixOmZ/CDaSGqUiwp2ZxM10WlAlTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SdLGsha9Z3ZYeiXs3nNe1pXNrngi9T51dttbfioVnWqXhZ0wCnD7lMr2Kr5+JdKPq
         v8Pm+dpyadazac8WxzdDQLqjEjwEBduOTyD5G/+OVFiJau8Yde78785cojbRtP4Ubi
         TG3ulvTP6VP6CzgHki9hFAZNPSVELzO08XEFFGv2YuL6gOtCeAJnXYjUrSSsnDqakM
         z1GurtZnkWZSx3leWQOZSxudwEivBQxW3R9QvGuRv/JSIdEtksyQ3KJap37AR6XYdP
         TTUPhwHvziKRz5/4DwUq/XUkOhf31WTZPDCDCK/qiDQ1jQauQEQGhfHGSsLNjzeB5y
         cvoiNiFvdCRKw==
Date:   Thu, 23 Nov 2023 17:42:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Griffin <peter.griffin@linaro.org>,
        semen.protsenko@linaro.org, Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: samsung: use Exynos7 fallbacks
 for newer wake-up controllers
Message-ID: <20231123-matador-purifier-282af21fa605@spud>
References: <20231122200407.423264-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="82fCaaroElEuq5wK"
Content-Disposition: inline
In-Reply-To: <20231122200407.423264-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82fCaaroElEuq5wK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 09:04:05PM +0100, Krzysztof Kozlowski wrote:
> Older ARM8 SoCs like Exynos5433, Exynos7 and Exynos7885 have the pin
> controller with wake-up interrupts muxed, thus the wake-up interrupt
> controller device node has interrupts property, while its pin banks
> might not (because they are muxed by the wake-up controller).
>=20
> Newer SoCs like Exynos850 and ExynosAutov9 do not used muxed wake-up
> interrupts:
> 1. Wake-up interrupt controller device node has no interrupts,
> 2. Its pin banks have interrupts (since there is no muxing).
>=20
> Their programming interface is however still compatible with Exynos7,
> thus change the bindings to express this: retain compatibility with
> Exynos7 and add new compatibility fallback of Exynos850 in newer
> designs.
>=20
> No driver changes are needed.  This is necessary only to properly
> describe DTS.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--82fCaaroElEuq5wK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV+O+gAKCRB4tDGHoIJi
0sYPAP9S2c9HnHdR7ZzPqfIZ5CHHzWUQV1qnq1mzNcTcecSR0AD/QMDe/sPPOH49
h8Cm2Kf0XSlSjwBeb59N0W7HWXxi+AM=
=QhNP
-----END PGP SIGNATURE-----

--82fCaaroElEuq5wK--
