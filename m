Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B607D135F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377847AbjJTP7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377832AbjJTP7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:59:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F56D7;
        Fri, 20 Oct 2023 08:59:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B7BC433C8;
        Fri, 20 Oct 2023 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697817568;
        bh=97TU/jnZR5ds5vVT0qQ3AnubifvbhIl0MYkUouOlAjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QCIvmeICsJHB/mYYfl5qWvYmPIzGXKDYJ/6Ac38yi8yHQSdluiJXZom2LH+4tSrdZ
         xDHLWg6HTkERNpXtwaGb3IyJzXcWLQ9/gGNm4jTapf36NhR2KWbyA+DVI7Blf80WgH
         U/v8BECmFbk1y3W/MZTkGhAIEeKRMNKqcZO5qgx5fNmqec2Ccf9G9wQX+iUh7syCEO
         ekfnRHZdVxo2mfaWcXomrnNRIp6Ng4mon9PerTUUls4oQzxYuDsQj/5YSuWSOOCXF0
         12FtW5YXtvdQTaXC4MtMrpZIt27Rlhtk3nW7vGfWIQJfguzfu8Sm+nWdNyQt5TIrdu
         kBiMioX0FuJsw==
Date:   Fri, 20 Oct 2023 16:59:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: backlight: mp3309c: remove two required
 properties
Message-ID: <20231020-moonrise-senate-86d0edb2d404@spud>
References: <20231020135434.2598578-1-f.suligoi@asem.it>
 <20231020135434.2598578-2-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MS8zv6ItXa/c4PSq"
Content-Disposition: inline
In-Reply-To: <20231020135434.2598578-2-f.suligoi@asem.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MS8zv6ItXa/c4PSq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Fri, Oct 20, 2023 at 03:54:33PM +0200, Flavio Suligoi wrote:
> The two properties:
>=20
> - max-brightness
> - default brightness
>=20
> are not really required, so they can be removed from the "required"
> section.

Why are they not required? You need to provide an explanation.

> Other changes:
>=20
> - improve the backlight working mode description, in the "description"
>   section

> - update the example, removing the "max-brightness" and introducing the
>   "brightess-levels" property

Why is this more useful?

Cheers,
Conor.

>=20
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>  .../bindings/leds/backlight/mps,mp3309c.yaml           | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c=
=2Eyaml b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
> index 4191e33626f5..527a37368ed7 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
> @@ -14,8 +14,8 @@ description: |
>    programmable switching frequency to optimize efficiency.
>    It supports two different dimming modes:
> =20
> -  - analog mode, via I2C commands (default)
> -  - PWM controlled mode.
> +  - analog mode, via I2C commands, as default mode (32 dimming levels)
> +  - PWM controlled mode (optional)
> =20
>    The datasheet is available at:
>    https://www.monolithicpower.com/en/mp3309c.html
> @@ -50,8 +50,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - max-brightness
> -  - default-brightness
> =20
>  unevaluatedProperties: false
> =20
> @@ -66,8 +64,8 @@ examples:
>              compatible =3D "mps,mp3309c";
>              reg =3D <0x17>;
>              pwms =3D <&pwm1 0 3333333 0>; /* 300 Hz --> (1/f) * 1*10^9 */
> -            max-brightness =3D <100>;
> -            default-brightness =3D <80>;
> +            brightness-levels =3D <0 4 8 16 32 64 128 255>;
> +            default-brightness =3D <6>;
>              mps,overvoltage-protection-microvolt =3D <24000000>;
>          };
>      };
> --=20
> 2.34.1
>=20

--MS8zv6ItXa/c4PSq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTKj2wAKCRB4tDGHoIJi
0h3oAQDiYRQgj//gRS3WJkhCjXAo1MV7AiztEk/V8hUK9kBEWQEAi0UKA0/tVacJ
Rnh8+uI+acOi2u2QOnHfJRUBVK5PiQk=
=7rd9
-----END PGP SIGNATURE-----

--MS8zv6ItXa/c4PSq--
