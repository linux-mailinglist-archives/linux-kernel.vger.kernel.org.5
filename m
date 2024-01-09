Return-Path: <linux-kernel+bounces-21147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D8828ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920431F248B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BF63A8EA;
	Tue,  9 Jan 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZMv47Ml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB139FF9;
	Tue,  9 Jan 2024 17:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7E2C43390;
	Tue,  9 Jan 2024 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704820304;
	bh=dEsLpeu8K7OJiF7pWVy1b5UFsknF7a9l6+xqZcW0nL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZMv47MlGOGybA+uvmyMnlVNp+q60K69Fhnp2Rq08EiHqdoZMpoHlNv2U8C9UBre0
	 uqHi08hKrD3vXddbNyI2wH4cD794ha3SIGaR3GfGCmKaV0RhBWRp41plsWMHXp68bo
	 hYzzqbNWsf731KM9JBt/y3Vnsb648R4JztRX18/+KT6rlZtU8VpgMP5bh4t6q1Mdmv
	 JUMGDq5nXXzejiQbeps0d3QQC+0Qz0Dlwmx52hAmjY2+hnVQeBfrHFCiaFBrII4//a
	 3JzbXLF48ag9TjxMOVSGfhQkWGVbC1om2zXUPBmDm4kb4fdGdU6dHTS6huLP3OfzBS
	 wvrw0lvatFOfg==
Date: Tue, 9 Jan 2024 17:11:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	Joel Stanley <joel@jms.id.au>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] tpm: tis-i2c: Add more compatible strings
Message-ID: <20240109-saddling-nintendo-c7fbb46bb0dd@spud>
References: <20231214144954.3833998-1-ninad@linux.ibm.com>
 <20231214144954.3833998-2-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZxiYjKSulZMuNBQt"
Content-Disposition: inline
In-Reply-To: <20231214144954.3833998-2-ninad@linux.ibm.com>


--ZxiYjKSulZMuNBQt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 08:49:53AM -0600, Ninad Palsule wrote:
> From: Joel Stanley <joel@jms.id.au>
>=20
> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>=20
> https://www.nuvoton.com/products/cloud-computing/security/trusted-platfor=
m-module-tpm/
>=20
> Add a compatible string for it, and the generic compatible.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

I don't understand why you broke this series up and dropped patches.
NAK, these compatibles are not documented.

Cheers,
Conor.

> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> index a897402cc36a..9511c0d50185 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>  #ifdef CONFIG_OF
>  static const struct of_device_id of_tis_i2c_match[] =3D {
>  	{ .compatible =3D "infineon,slb9673", },
> +	{ .compatible =3D "nuvoton,npct75x", },
> +	{ .compatible =3D "tcg,tpm-tis-i2c", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> --=20
> 2.39.2
>=20

--ZxiYjKSulZMuNBQt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ1+TAAKCRB4tDGHoIJi
0m0QAPoD8jO8sBqNJ8Yjtkt0nD8c8slMnCPmNUOEQCd+wj5foAD/Rm9ZJAaubHBn
0nZRgQCZxzJ4E/TTJamUTHT07B5MXgg=
=YR2U
-----END PGP SIGNATURE-----

--ZxiYjKSulZMuNBQt--

