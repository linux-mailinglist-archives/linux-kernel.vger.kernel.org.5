Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3044779D74E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbjILRLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236653AbjILRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:11:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1C210D9;
        Tue, 12 Sep 2023 10:11:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AF0C433C8;
        Tue, 12 Sep 2023 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694538697;
        bh=K6ujrGAxc6bLs1J/Thn8Dd/Rjofr6FM6gvQYymz/WYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRGa/mdd4iQg/yWCh58/qb7FKBECU7PHMviCpZYG2k7ZVqdqUWXnI5OsRtSZY1D9C
         mEQBFnUI+3mWCLlKn2M+Y5Fn9SBWP2yChfBc+iEDrJUTW5vBVyRi1/sGnNd7CM81u2
         pZnkd8LMEBsuWeeyxrXn+Gzbxdlf2cI3DH4/QL8aLuqrCX/m5jDv8+30liiohICNOs
         WWEPRHVxMtQMKeMGbm+pgvyJCeqpHpbEkioYtoPLz049YvfAOUMz7wDuWnTXx3ctFF
         kpq4w9AaV6nLRfqoxgy6VNLubwOwYpel54C8dTLlG0h+5aWhOqV4lEKdPHWzjthxd3
         WeZToxgbHEwtQ==
Date:   Tue, 12 Sep 2023 18:11:33 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: Mention GPIO triggers
Message-ID: <20230912-squeamish-legal-424d4f8a3453@spud>
References: <20230912-gpio-led-trigger-dt-v1-0-1b50e3756dda@linaro.org>
 <20230912-gpio-led-trigger-dt-v1-1-1b50e3756dda@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dtprEHGdUyw2Qv/N"
Content-Disposition: inline
In-Reply-To: <20230912-gpio-led-trigger-dt-v1-1-1b50e3756dda@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dtprEHGdUyw2Qv/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 03:44:30PM +0200, Linus Walleij wrote:
> We reuse the trigger-sources phandle to just point to
> GPIOs we may want to use as LED triggers.
>=20
> Example:
>=20
> gpio: gpio@0 {
>     compatible "my-gpio";
>     gpio-controller;
>     #gpio-cells =3D <2>;
>     interrupt-controller;
>     #interrupt-cells =3D <2>;
>     #trigger-source-cells =3D <2>;
> };
>=20
> leds {
>     compatible =3D "gpio-leds";
>     led-my-gpio {
>         label =3D "device:blue:myled";
>         gpios =3D <&gpio 0 GPIO_ACTIVE_HIGH>;
>         default-state =3D "off";
>         linux,default-trigger =3D "gpio";
>         trigger-sources =3D <&gpio 1 GPIO_ACTIVE_HIGH>;
>     };
> };
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documen=
tation/devicetree/bindings/leds/common.yaml
> index 5fb7007f3618..b42950643b9d 100644
> --- a/Documentation/devicetree/bindings/leds/common.yaml
> +++ b/Documentation/devicetree/bindings/leds/common.yaml
> @@ -191,6 +191,8 @@ properties:
>        each of them having its own LED assigned (assuming they are not
>        hardwired). In such cases this property should contain phandle(s) =
of
>        related source device(s).
> +      Another example is a GPIO line that will be monitored and mirror t=
he
> +      state of the line (with or without inversion flags) to the LED.
>        In many cases LED can be related to more than one device (e.g. one=
 USB LED
>        vs. multiple USB ports). Each source should be represented by a no=
de in
>        the device tree and be referenced by a phandle and a set of phandle
>=20

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--dtprEHGdUyw2Qv/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQCbxAAKCRB4tDGHoIJi
0jR+AP4+jmFjuVM/kMEexCYC/xCeNWS4H6kBNsQozxT46NucvQEAzVuZw7tsRPe1
DS1rf3XkxHkfNv9BeZiDam9yoVAieQY=
=2ggV
-----END PGP SIGNATURE-----

--dtprEHGdUyw2Qv/N--
