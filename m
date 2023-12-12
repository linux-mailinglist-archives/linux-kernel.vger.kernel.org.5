Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4292A80F37C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346594AbjLLQqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjLLQqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:46:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F5DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:46:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63EDC433C7;
        Tue, 12 Dec 2023 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702399565;
        bh=2kL9c8M3mF8X30k2wAmSgFfBnjox+ipfBtSSJWGmurA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjIL0QCYOiE/9Znph5//BdBjzkVDNmTeu1FZ8S8IXto25jVNQ5KFEImUMthV2aLss
         107WRCrvDwOTLhdHE48b6ne/CRKLk+vAdrTSvu705aVd6ZA7VSv/1LZk6w783PWW+G
         DOEvwBP5eeXhVGe19f9UxfGzggKuDrklxvME8UfGHdhYb//uY04YAJblizStzacaXe
         un8HMwQa3oaUbLMv3mmWvgv+GMqcwpdc5fAnKDS/DVGR8ydVHbFSMt1UayPrqlDoNe
         pQ036RBnPkxUbvyfAz5PhB1FqDlXcsSP3dnImqfTDPBwwKphQJqei6seW3oMwHPVOc
         M3/JFxL0swcKA==
Date:   Tue, 12 Dec 2023 16:46:00 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: watchdog: starfive,jh7100-wdt: Add
 compatible for JH8100
Message-ID: <20231212-reverb-daisy-4574734ae84f@spud>
References: <20231212031731.2498584-1-jisheng.teoh@starfivetech.com>
 <20231212031731.2498584-2-jisheng.teoh@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45NKaEISDIosDalY"
Content-Disposition: inline
In-Reply-To: <20231212031731.2498584-2-jisheng.teoh@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45NKaEISDIosDalY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 11:17:31AM +0800, Ji Sheng Teoh wrote:
> Add "starfive,jh8100-wdt" compatible string for StarFive's JH8100
> watchdog.
> Since JH8100 watchdog only has 1 reset signal, update binding
> document to support one reset for "starfive,jh8100-wdt" compatible.
>=20
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> ---
>  .../devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml       | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-w=
dt.yaml b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.ya=
ml
> index 68f3f6fd08a6..02572b16ac08 100644
> --- a/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/starfive,jh7100-wdt.yaml
> @@ -27,6 +27,7 @@ properties:
>      enum:
>        - starfive,jh7100-wdt
>        - starfive,jh7110-wdt
> +      - starfive,jh8100-wdt
> =20
>    reg:
>      maxItems: 1
> @@ -45,6 +46,7 @@ properties:
>        - const: core
> =20
>    resets:
> +    minItems: 1
>      items:
>        - description: APB reset
>        - description: Core reset

This relaxes the constraints for the existing devices, please add per
compatible constraints to avoid doing so.

--45NKaEISDIosDalY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiOSAAKCRB4tDGHoIJi
0r3IAQCDEjl1GeMZyWSMhCQ1LJweHvfTiZh3K9eeYofqlwRCQQEAl3IBywhY+TCc
ambGyaPu7HZyn/1K6rqqbBqODrS7qg4=
=45Jl
-----END PGP SIGNATURE-----

--45NKaEISDIosDalY--
