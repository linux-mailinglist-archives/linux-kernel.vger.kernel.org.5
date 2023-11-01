Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958C07DE3BF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjKAPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbjKAPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:31:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2721EFD;
        Wed,  1 Nov 2023 08:31:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EECFC433C9;
        Wed,  1 Nov 2023 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698852692;
        bh=vjjyywND5E0nGl8R6otdVK2p1h8xHUttV9JxvhMw878=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hCvUC4gooypOVIelQeuOF2Z9IIDRyuY+Cf8nEkEOluf0G9488v61ELQV747tB4wGo
         +UqslL1TieSfwYfJDZMPoPohWIbl0Xyd1Hg6gWyX5XYUtD+wMcyo7/ix4UAYjtJeEG
         CCN1PbZgdC905Gc3IT7NRcP/IvCx81Ww0ix36mwfJtxV8tgyXaXwl8iOJM54WSFqdX
         DgO7Rv+hl98L86RtN/ZpNtZAgBd0xNKIUZsh9ZBakBK/3HbINvB4H6+iFXq25vKFBt
         0VkjtkCSC1O+zJkzMdemMI83Fpf55fiEQErGNi5TOap2TNewCCDZi4coQqrnCp6i8w
         a01LwcbOCiwtQ==
Date:   Wed, 1 Nov 2023 15:31:28 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com, kernel@sberdevices.ru,
        rockosov@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 11/11] dt-bindings: leds: aw200xx: fix led pattern and
 add reg constraints
Message-ID: <20231101-subzero-grimace-52a10da6a445@spud>
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
 <20231101142445.8753-12-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1xbOXPLYaVpKggRe"
Content-Disposition: inline
In-Reply-To: <20231101142445.8753-12-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1xbOXPLYaVpKggRe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 05:24:45PM +0300, Dmitry Rokosov wrote:
> AW200XX controllers have the capability to declare more than 0xf LEDs,
> therefore, it is necessary to accept LED names using an appropriate
> regex pattern.
>=20
> The register offsets can be adjusted within the specified range, with
> the maximum value corresponding to the highest number of LEDs that can
> be connected to the controller.
>=20
> Fixes: e338a05e76ca ("dt-bindings: leds: Add binding for AW200xx")
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

You did correctly guess what I was getting at on the previous version.
Apologies for not replying - I got sick and things probably fell a bit
through the cracks.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  .../bindings/leds/awinic,aw200xx.yaml         | 64 +++++++++++++++++--
>  1 file changed, 58 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b=
/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> index 67c1d960db1d..ba4511664fb8 100644
> --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> @@ -45,17 +45,12 @@ properties:
>      maxItems: 1
> =20
>  patternProperties:
> -  "^led@[0-9a-f]$":
> +  "^led@[0-9a-f]+$":
>      type: object
>      $ref: common.yaml#
>      unevaluatedProperties: false
> =20
>      properties:
> -      reg:
> -        description:
> -          LED number
> -        maxItems: 1
> -
>        led-max-microamp:
>          default: 9780
>          description: |
> @@ -69,6 +64,63 @@ patternProperties:
>            where max-current-switch-number is determinated by led configu=
ration
>            and depends on how leds are physically connected to the led dr=
iver.
> =20
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: awinic,aw20036
> +    then:
> +      patternProperties:
> +        "^led@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              items:
> +                minimum: 0
> +                maximum: 36
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: awinic,aw20054
> +    then:
> +      patternProperties:
> +        "^led@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              items:
> +                minimum: 0
> +                maximum: 54
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: awinic,aw20072
> +    then:
> +      patternProperties:
> +        "^led@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              items:
> +                minimum: 0
> +                maximum: 72
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: awinic,aw20108
> +    then:
> +      patternProperties:
> +        "^led@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              items:
> +                minimum: 0
> +                maximum: 108
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.36.0
>=20

--1xbOXPLYaVpKggRe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUJvTwAKCRB4tDGHoIJi
0qfBAQC7asF9LbGsYBe+8Gmm6D5cOPSXw2/cpSRRTNuss80nbwEAoP0kiiUoAaTk
3Yv6Js+KjIequ9AYtOpNeVYxTdENRQg=
=nWPC
-----END PGP SIGNATURE-----

--1xbOXPLYaVpKggRe--
