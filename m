Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4CE7D9AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbjJ0ODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345943AbjJ0ODR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:03:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECAC0;
        Fri, 27 Oct 2023 07:03:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC91AC433C8;
        Fri, 27 Oct 2023 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698415395;
        bh=I8Lf1lGqEIBiRLLQKY+WAnwAUTOu+8uX5WfQ5AedY3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6qs5A2IS8RYWjkZkmBdOFmRpzRDPB4vGqqJNRgnXGIwr90Z77tdwFfC6PPsP6N+P
         AsUBtmX/jZFnaed61069Xbm1DBc5RlKrvqJFOnjSaUwU185VsBEgW1OI8zCPIDHooP
         rLEP9pnL5HTE2fo2nOwDroZEOj+oivRU9/3lUNhIiNEt6FSVItekn6hwDbKzR/HrIM
         rXuXfwK3wYqrTgOtB2P9HfYR9yqBSVMA4nHzXS2fW9m/i7NDfXkUf+UJuWLX7Bs+3w
         EJpijWkb4VZKW0S0pb+ukZaxCDd1osapre6lYpnvK6eQs7wDzJ62ltSuOeBh3u/gPM
         /70zy5P2bVLtA==
Date:   Fri, 27 Oct 2023 15:03:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] dt-bindings: watchdog: Add support for Amlogic C3
 and S4 SoCs
Message-ID: <20231027-dandy-remote-7cdbb721f95c@spud>
References: <20231027104358.342861-1-huqiang.qin@amlogic.com>
 <20231027104358.342861-2-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oM/wQgfGbne7U64P"
Content-Disposition: inline
In-Reply-To: <20231027104358.342861-2-huqiang.qin@amlogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oM/wQgfGbne7U64P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 06:43:56PM +0800, Huqiang Qin wrote:
> Update dt-binding document for watchdog of Amlogic C3 and S4 SoCs.
>=20
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../bindings/watchdog/amlogic,meson-gxbb-wdt.yaml    | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxb=
b-wdt.yaml b/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-=
wdt.yaml
> index 443e2e7ab467..69845ec32e81 100644
> --- a/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.y=
aml
> +++ b/Documentation/devicetree/bindings/watchdog/amlogic,meson-gxbb-wdt.y=
aml
> @@ -15,9 +15,15 @@ allOf:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - amlogic,meson-gxbb-wdt
> -      - amlogic,t7-wdt
> +    oneOf:
> +      - enum:
> +          - amlogic,meson-gxbb-wdt
> +          - amlogic,t7-wdt
> +      - items:
> +          - enum:
> +              - amlogic,c3-wdt
> +              - amlogic,s4-wdt
> +          - const: amlogic,t7-wdt
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.42.0
>=20
>=20

--oM/wQgfGbne7U64P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTvDHgAKCRB4tDGHoIJi
0qcvAP9SGLIcv30IzHPU1l4xfEzLR3YQ9/vjV8fAu2jJcj0fDwEAm6Yhi73ZKy1E
vjagBd0uQzS1m25Urmv+KT1LmSVVKQY=
=qbQP
-----END PGP SIGNATURE-----

--oM/wQgfGbne7U64P--
