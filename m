Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F3775B983
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGTV2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGTV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3316319B6;
        Thu, 20 Jul 2023 14:27:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7BD761C67;
        Thu, 20 Jul 2023 21:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6510C433C7;
        Thu, 20 Jul 2023 21:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689888477;
        bh=GiZxqdFhUBzLZIYlG2ofAIkeWaJC+l5yaX+/Yxnkjr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ce8Vhq0qUOr9RPO3dTAlf6nZ6F53qNqdE3Wiyc2mJqLhIYnreH4P1s0Zh9sZove5R
         vWKD3isIuXsRcV6cwhLW6DSVYTjoByb5pOjk32OhoFDW4J4U5/0a+1JlIk/tRrSB1T
         RSMwDXmXksgcplg+79DwjGadRhDyUN6ykv11ibrPmw0i7pz+ssQAqAR46CIaa4NgDm
         Jfmr1s1pARcfm7ZjlbZ6Hq2MiSQ4PbY5AD+GCVMpITmikyqlBm3P1YA2OMe6m6a0QI
         VAHA/N8d825p9hSvD3ocTKMUf5nbZdLr7yCkEf4fh0F6eY8CxDuZUVeB+W1LnI3Uuz
         SopjigKOLQ0GQ==
Date:   Thu, 20 Jul 2023 23:27:53 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alejandro Tafalla <atafalla@dnyon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: lsm6dsx: Fix mount matrix retrieval
Message-ID: <ZLmm2fSt1wkttdLC@lore-desk>
References: <20230714153132.27265-1-atafalla@dnyon.com>
 <20230715183515.56deaa1d@jic23-huawei>
 <3017278.mvXUDI8C0e@alexpc>
 <20230720194037.60d109d7@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y2fYAN+68DKxwuRL"
Content-Disposition: inline
In-Reply-To: <20230720194037.60d109d7@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y2fYAN+68DKxwuRL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 20, Jonathan Cameron wrote:
> Alejandro Tafalla <atafalla@dnyon.com> wrote:
>=20
> > On s=E1bado, 15 de julio de 2023 19:35:15 (CEST) Jonathan Cameron wrote:
> > > On Fri, 14 Jul 2023 17:31:26 +0200
> > >=20
> > > Alejandro Tafalla <atafalla@dnyon.com> wrote: =20
> > > > The function lsm6dsx_get_acpi_mount_matrix should return an error w=
hen
> > > > ACPI
> > > > support is not enabled to allow executing iio_read_mount_matrix in =
the
> > > > probe function.
> > > >=20
> > > > Fixes: dc3d25f22b88 ("iio: imu: lsm6dsx: Add ACPI mount matrix retr=
ieval") =20
> > >=20
> > > I can fix it up whilst applying if no other issues, but there must no=
t be
> > > a blank line here.  All tags need to be in a single block for some to=
oling
> > > that is used with the kernel tree (and some of the checking scripts w=
arn
> > > about this so it won't get applied with the blank line here). =20
> >=20
> > Okay, i'll keep it in mind for new patches. Thank you.
> Np.
>=20
> Just waiting for Lorenzo to have time to take a final look.

I am fine with this patch.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Jonathan
>=20
> > >  =20
> > > > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > > > ---
> > > > Changes in v3:
> > > > - Removed unneeded check for err =3D=3D -EOPNOTSUPP.
> > > >=20
> > > > Changes in v2:
> > > > - Use of error codes instead of true/false
> > > >=20
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c index
> > > > 6a18b363cf73..b6e6b1df8a61 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -2687,7 +2687,7 @@ static int lsm6dsx_get_acpi_mount_matrix(stru=
ct
> > > > device *dev,>=20
> > > >  static int lsm6dsx_get_acpi_mount_matrix(struct device *dev,
> > > > =20
> > > >  					  struct  =20
> > iio_mount_matrix *orientation)
> > > > =20
> > > >  {
> > > >=20
> > > > -	return false;
> > > > +	return -EOPNOTSUPP;
> > > >=20
> > > >  }
> > > > =20
> > > >  #endif =20
> >=20
> >=20
> >=20
> >=20
>=20

--y2fYAN+68DKxwuRL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZLmm2QAKCRA6cBh0uS2t
rJFvAQC3UVCsDZpMgmZ/apRNUCscBwoIAaqeVlN4wDQ9J06BfQEA4Z1+bilmYBBH
vYXxrtZWH9h6pt7K0cRNDJarMftP6Q4=
=2+j6
-----END PGP SIGNATURE-----

--y2fYAN+68DKxwuRL--
