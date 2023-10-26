Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451397D855E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjJZO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbjJZO5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:57:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50ED1B6;
        Thu, 26 Oct 2023 07:57:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91D4C433C7;
        Thu, 26 Oct 2023 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698332265;
        bh=xyyVuKjgPHJwvwoA8fYFBki6d1EK0uIm3y9Banv1u/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHvhtK/aRNgIAlFDeQ5pXe/pqhFhMlQ5+NaSgJ9G+fx+H1/rMPG7uaGqAfmETu3p/
         HGYu/0fOrSKCrp/45Ieig35+Oho+OgaCmlEBQJUWt2iRd/MK4Ebr9STKqZSWobgvOq
         8wGv27dTA5UssCZNt4S7v3sEV15rbCfIwdNXrJYYi/Fhzh2mdmOprwP1iVHurFdjJU
         Ewi/wksrv89+NpIitIdeOB4beCFg7l+J3YNVCKrweqbJosv0kg2SOG9Y6PgAHDAJOJ
         xmEH1ixz5LdBpV6gQXaeFBTNPdCbK7nr584TP/4TAU9bTclk7PHRCa1kGsb3j1uojw
         n8F41F6by14lg==
Date:   Thu, 26 Oct 2023 15:57:40 +0100
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
Subject: Re: [PATCH v2 1/1] dt-bindings: backlight: mp3309c: remove two
 required properties
Message-ID: <20231026-ride-sushi-bc53cbb4b7f3@spud>
References: <20231025155057.886823-1-f.suligoi@asem.it>
 <20231025155057.886823-2-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/Vkt+JkQXPkj1YDd"
Content-Disposition: inline
In-Reply-To: <20231025155057.886823-2-f.suligoi@asem.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Vkt+JkQXPkj1YDd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 05:50:57PM +0200, Flavio Suligoi wrote:
> The two properties:
>=20
> - max-brightness
> - default brightness
>=20
> are not really required, so they can be removed from the "required"
> section.
> The "max-brightness" is no longer used in the current version
> of the driver (it was used only in the first version).
> The "default-brightness", if omitted in the DT, is managed by the
> device driver, using a default value. This value depends on the dimming
> mode used:
>=20
> - for the "analog mode", via I2C commands, this value is fixed by
>   hardware (=3D31)
> - while in case of pwm mode the default used is the last value of the
>   brightness-levels array.
>=20
> Also the brightness-levels array is not required:
>=20
> - in "analog mode", via I2C commands, the brightness-level array is
>   fixed by hardware (0..31).;
> - in pwm dimming mode, the driver uses a default array of 0..255 and
>   the "default-brightness" is the last one, which is "255"
>=20

> NOTE: there are no compatibility problems with the previous version,
>       since the device driver has not yet been included in any kernel.
>       Only this dt-binding yaml file is already included in the
>       "for-backlight-next" branch of the "backlight" kernel repository.
>       No developer may have used it.

I'd argue
Fixes: 02c4e661658f ("dt-bindings: backlight: Add MPS MP3309C")
but that's up to Lee.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Other changes:
>=20
> - improve the backlight working mode description, in the "description"
>   section
> - update the example, removing the "max-brightness" and introducing the
>   "brightess-levels" property
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

--/Vkt+JkQXPkj1YDd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTp+ZAAKCRB4tDGHoIJi
0jLIAP0fHHjeh6jiK5VuLSWd/SvLMmcc11B0WSLsseVmouZZEAEAkqIV2yujMyoq
OL89RHu42wMABF/rP+Z3jf3qAUcMcgc=
=mViE
-----END PGP SIGNATURE-----

--/Vkt+JkQXPkj1YDd--
