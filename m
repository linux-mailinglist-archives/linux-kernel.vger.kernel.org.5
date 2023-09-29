Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D987B34E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbjI2O1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjI2O1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:27:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459D31A8;
        Fri, 29 Sep 2023 07:27:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB05C433C7;
        Fri, 29 Sep 2023 14:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695997629;
        bh=UQ6oQU3g9esk983G3d2F4i53nKTP2haEycF4QbnPhWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kt3NxYX359IxuRGHEF8siCj7BsALwXJ+HAmcHJhlI+Mwvah5t/eTgow4mNwazhxMs
         doT0J1cdoj8seH1qCgBZdWh+sSSe44AYzuYDqJ4QEojUb8C8ZFNM8VUHrIDdOnJTTk
         vqcAD5XSoBYyj45BdQxPw1LD1zv5hpx6Fxi1Wh9Rn9g8g92iT/Gk4DWyJtRZzFo9wy
         sLBFuAAd+0gyOa7OX8bgifUyUIha9ZQv5SXG16Y1PWbjsuB9r9glGA5hI1FNDO2iwD
         tGeqo2Tb8P8V4v9FTJBigE2c6N9WNDRG7b0CHggMGgc8P9Q68jDmJkA0kgQ6/6U9XA
         lUUMeH5PzGfCQ==
Date:   Fri, 29 Sep 2023 15:27:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: Add KX132ACR-LBZ accelerometer
Message-ID: <20230929-cognitive-lunar-0d93abe00e7a@spud>
References: <cover.1695879676.git.mazziesaccount@gmail.com>
 <5c9e03ffad5e6e5970d6e71fb02eab4b652e109f.1695879676.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7iv7Fv6rLC7l1irA"
Content-Disposition: inline
In-Reply-To: <5c9e03ffad5e6e5970d6e71fb02eab4b652e109f.1695879676.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7iv7Fv6rLC7l1irA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 11:45:21AM +0300, Matti Vaittinen wrote:
> ROHM KX132ACR-LBZ is an accelerometer for industrial applications. It
> has a subset of KX022A functionalities, dropping support for tap, free
> fall and tilt detection engines. Also, the register interface is an exact
> subset of what is found on KX022A.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Extend the kionix,kx022a.yaml file to support the KX132ACR-LBZ device
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/kionix,kx022a.yaml   | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.ya=
ml b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> index 034b69614416..66ea894dbe55 100644
> --- a/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/kionix,kx022a.yaml
> @@ -4,21 +4,23 @@
>  $id: http://devicetree.org/schemas/iio/accel/kionix,kx022a.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: ROHM/Kionix KX022A and KX132-1211 Accelerometers
> +title: ROHM/Kionix KX022A, KX132-1211 and KX132ACR-LBZ Accelerometers
> =20
>  maintainers:
>    - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
> -  KX022A and KX132-1211 are 3-axis accelerometers supporting +/- 2G, 4G,=
 8G and
> -  16G ranges, variable output data-rates and a hardware-fifo buffering.
> -  KX022A and KX132-1211 can be accessed either via I2C or SPI.
> +  KX022A, KX132ACR-LBZ and KX132-1211 are 3-axis accelerometers supporti=
ng
> +  +/- 2G, 4G, 8G and 16G ranges, variable output data-rates and a
> +  hardware-fifo buffering. These accelerometers can be accessed either
> +  via I2C or SPI.
> =20
>  properties:
>    compatible:
>      enum:
>        - kionix,kx022a
>        - kionix,kx132-1211
> +      - rohm,kx132acr-lbz
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.41.0
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20



--7iv7Fv6rLC7l1irA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRbeuQAKCRB4tDGHoIJi
0hIyAQCZKh2jezPaE6cHGzvo+WAxGa9bRqvutsE1E1UYhq1ERAD/Shmli5Uv85uc
Znz8bXVz3b0W0B8g9Vm5uaBQ2UY3ag4=
=SqZD
-----END PGP SIGNATURE-----

--7iv7Fv6rLC7l1irA--
