Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C710A751901
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbjGMGp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbjGMGpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:45:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198401998;
        Wed, 12 Jul 2023 23:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EE8761A34;
        Thu, 13 Jul 2023 06:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70414C433C7;
        Thu, 13 Jul 2023 06:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689230749;
        bh=QdqoMXXDocWFm5bXrCU/+PhGlp5BHVUakp74/t5bQw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UpKOhloDcMQEfbql1x8e+dg+Li4h6ErUzD4oD1xqZyEbvIMZ7rnXO91uLPFxxsHU8
         g1mk+VbaYE/8VDqZ09QcJWesrwdxL0M5Ms0ubcMoeMgYAKYlSa4uYK3GFN1hMkt47r
         5p72Br7Z9XNhs1wcFu5/wPwfQOlKt9WRBVVJDvg0MvkTTR5iziImCACay+s/sb9hw/
         jWuKIuyHz1gQTkhe1U+bpdHPJzIT5bEwX/pm7wXOzLpGv0dmb6sRYk3s9q9nP3hozM
         ZhamJNGfoB9ekD3gRbwOx4eqhhSU//dKRqtgI4EFvA2odb3fDXPVSnfH0VUUE3DiH9
         QRn6Y/zHofvHQ==
Date:   Thu, 13 Jul 2023 08:45:44 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Alejandro Tafalla <atafalla@dnyon.com>
Cc:     jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [RESEND PATCH v2] iio: imu: lsm6dsx: Fix mount matrix retrieval
Message-ID: <ZK+dmF9juAnj5YYr@lore-desk>
References: <4847336.31r3eYUQgx@alexbook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AQXm/7OLTLW6eLTI"
Content-Disposition: inline
In-Reply-To: <4847336.31r3eYUQgx@alexbook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AQXm/7OLTLW6eLTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 13, Alejandro Tafalla wrote:
> The function lsm6dsx_get_acpi_mount_matrix should return an error when AC=
PI
> support is not enabled to allow executing iio_read_mount_matrix in the
> probe function.
>=20
> Fixes: dc3d25f22b88 ("iio: imu: lsm6dsx: Add ACPI mount matrix retrieval")
>=20
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
> Changes in v2:
> - Use of error codes instead of true/false
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 6a18b363cf73..1a4752c95601 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(struct dev=
ice *dev,
>  static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
>  					  struct iio_mount_matrix *orientation)
>  {
> -	return false;
> +	return -EOPNOTSUPP;
>  }
> =20
>  #endif
> @@ -2767,11 +2767,11 @@ int st_lsm6dsx_probe(struct device *dev, int irq,=
 int hw_id,
>  	}
> =20
>  	err =3D lsm6dsx_get_acpi_mount_matrix(hw->dev, &hw->orientation);
> -	if (err) {
> +	if (err =3D=3D -EOPNOTSUPP)

why do you need this extra check? According to the previous codebase, even =
if
lsm6dsx_get_acpi_mount_matrix() fails we want to fallback to
iio_read_mount_matrix(), right?

Regards,
Lorenzo

>  		err =3D iio_read_mount_matrix(hw->dev, &hw->orientation);
> -		if (err)
> -			return err;
> -	}
> +
> +	if (err)
> +		return err;
> =20
>  	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
>  		if (!hw->iio_devs[i])
> --=20
> 2.41.0
>=20
>=20
>=20
>=20
>=20
>=20
>=20

--AQXm/7OLTLW6eLTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZK+dmAAKCRA6cBh0uS2t
rF/sAQCLa9z1VQ+pJmnDyrf/ZO2ICFgjaUS1iye/28z/ZhkLPAEAtOSPoVSeW06l
1tAOk/TsiJWcW/3gXq/ncQBrp8/qKA8=
=pvG7
-----END PGP SIGNATURE-----

--AQXm/7OLTLW6eLTI--
