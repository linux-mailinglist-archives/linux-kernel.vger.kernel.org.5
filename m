Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4050808ED5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443228AbjLGRPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjLGRPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:15:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0DF1709
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:15:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AC0C433C8;
        Thu,  7 Dec 2023 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701969328;
        bh=/NZy2kf75bJHAraLx4pRXvEeYyqAAqrTseqq1t9//Z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uryj+pFN/z19lqg/7cEn4xKACWxpDihfcbOk/XC7lpDOzL+WX5z5VlVKW/3cvc+s4
         NnYm2WFY7rSGpPSslqD1J6I3Wpr1chYU20ZNrbVvFkl2993ctJ7h/psl1WiexVzUjD
         8YGtfVufiZ5612U10APSlebah/U99YbyjvEdSPCgjfnElDbT0UYOawzzgTCkqdmJ2m
         ET+dOj3b6u51JOd/VhhorhTNoRSjmL4GcqgEbKzGpzxePYQSnCSqCXQbtGaITrMvcA
         hKG2dqxFyUBsO9mrBFlgazs0xmbU8WLuGrDy5M8ZlrJTb9Ehndy63JZSb5e9thcvci
         dhCJS1KngpLuQ==
Date:   Thu, 7 Dec 2023 17:15:23 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: dt-bindings: ov8856: decouple lanes and link
 frequency from driver
Message-ID: <20231207-antics-tummy-5316e38477de@spud>
References: <20231207142356.100453-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OSYC6STl8ciQnFnr"
Content-Disposition: inline
In-Reply-To: <20231207142356.100453-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OSYC6STl8ciQnFnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 03:23:56PM +0100, Krzysztof Kozlowski wrote:
> The data lanes and link frequency were set to match exiting Linux driver
> limitations, however bindings should be independent of chosen Linux
> driver support.
>=20
> Decouple these properties from the driver to match what is actually
> supported by the hardware.
>=20
> This also fixes DTS example:
>=20
>   ov8856.example.dtb: camera@10: port:endpoint:link-frequencies:0: [36000=
0000] is too short
>=20
> Fixes: 066a94e28a23 ("media: dt-bindings: media: Use graph and video-inte=
rfaces schemas")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Changes in v2:
> 1. Rework approach: decouple bindings from driver instead of fixing
>    DTS example (Sakari)

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../devicetree/bindings/media/i2c/ov8856.yaml | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Do=
cumentation/devicetree/bindings/media/i2c/ov8856.yaml
> index 57f5e48fd8e0..71102a71cf81 100644
> --- a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> +++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
> @@ -67,19 +67,22 @@ properties:
> =20
>          properties:
>            data-lanes:
> -            description: |-
> -              The driver only supports four-lane operation.
> -            items:
> -              - const: 1
> -              - const: 2
> -              - const: 3
> -              - const: 4
> +            oneOf:
> +              - items:
> +                  - const: 1
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +              - items:
> +                  - const: 1
> +                  - const: 2
> +                  - const: 3
> +                  - const: 4
> =20
>            link-frequencies:
>              description: Frequencies listed are driver, not h/w limitati=
ons.
> -            maxItems: 2
>              items:
> -              enum: [ 360000000, 180000000 ]
> +              enum: [ 1440000000, 720000000, 360000000, 180000000 ]
> =20
>          required:
>            - link-frequencies
> --=20
> 2.34.1
>=20

--OSYC6STl8ciQnFnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXH9qwAKCRB4tDGHoIJi
0hyzAP9aNR0uAwPrTbmO+v6W10FcAGLU1UTX15VyHl6zTw/+zwD7BNYOXpLbWO6V
oavXs+cccjna3l+eCE+iR8mzZg9kRgg=
=+455
-----END PGP SIGNATURE-----

--OSYC6STl8ciQnFnr--
