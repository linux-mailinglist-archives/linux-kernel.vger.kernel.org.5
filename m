Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72613778AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjHKKJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbjHKKI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:08:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE930CD;
        Fri, 11 Aug 2023 03:08:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45F2B66E26;
        Fri, 11 Aug 2023 10:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE266C433BB;
        Fri, 11 Aug 2023 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691748524;
        bh=jTLGNFFdzle1CYrnK/oXkobWpUEyBNF6m/UIsNJAaAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlLG8ncpx9zLh/JjXG37dja0xNnq9iuCOrbqr58eAbOvJAw9e6rFjm8J/MqV8nwvN
         towaV4/5TAsU+a9zrfd0qiJYbLtspqIQhQgOdUhju89VlQWRUyAErFAzXc+JWYElqU
         fqsGcVlF4HksnCjdh69a47mxO+DvQGuiSamQ00aKUvMPAX4NTnr4ixeFJNZ0kD3nrm
         L2/MbsCO5oFLTpDbIh8IFUGbTYLC8XgzTz5U8RVu5HeLcQxJm8ooYc3/y1bfbMsGxE
         yoj+0/sGS5ec1e0oKfwGNOfkCMbKepB0b1q//C5CcFkIJunahgRFL7ma7a7xbdYVXs
         9ga0pPSaN+FSA==
Date:   Fri, 11 Aug 2023 12:08:38 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mario Tesi <mario.tesi@st.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: imu: lsm6dsx: Support temperature and ism330dhc
Message-ID: <ZNYIpqz7EMDqISyX@lore-rh-laptop>
References: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bhhokxLNw1UQtA2T"
Content-Disposition: inline
In-Reply-To: <20230811-iio-spacex-lsm6ds0-v1-0-e953a440170d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bhhokxLNw1UQtA2T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The ISM330DHC is used in the SpaceX Starlink terminals which
> are running a realtime patched close-to-mainline Linux kernel so
> let's support it because why not.

Hi Linus,

this is cool, thx for working on this. Some comments in patch 1/2 and 2/2.

Regards,
Lorenzo

>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Linus Walleij (2):
>       iio: lsm6dsx: Support temperature channel
>       iio: imu: lsm6dsx: Add support for ism330dhc
>=20
>  drivers/iio/imu/st_lsm6dsx/Kconfig             |  8 +--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 26 ++++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  4 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 73 ++++++++++++++++++++=
++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  4 ++
>  6 files changed, 109 insertions(+), 11 deletions(-)
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230811-iio-spacex-lsm6ds0-33c9365e94bf
>=20
> Best regards,
> --=20
> Linus Walleij <linus.walleij@linaro.org>
>=20

--bhhokxLNw1UQtA2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZNYIowAKCRA6cBh0uS2t
rGDjAQCjnWMmxTARPSs6tcuNlSjey080HQuGR6uHvI8GF8h/HwD+KXuBjZE/JQeE
io0VH6UNp+M2hQEObOzhEMTjHPZNkQM=
=Oqml
-----END PGP SIGNATURE-----

--bhhokxLNw1UQtA2T--
