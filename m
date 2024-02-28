Return-Path: <linux-kernel+bounces-84816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF8086ABF0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9993B2134A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CD8381A4;
	Wed, 28 Feb 2024 10:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDeUbWqL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298F364A1;
	Wed, 28 Feb 2024 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115138; cv=none; b=BzXrLOTlgm1ZQgo0SoefhCGcXx/TNjwNY98XbQV2qvGqBs2r770QpXQekrfWB7hjewnYaeB9z0YQApOS47iUH+M2YXVCfySMEDpiT5fbogKyEoCNxbSv7cUr2E/fk5PNANYSwmYbX8JNIHcHmO92Is/+aQt8/RAcdIO7T4O6fQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115138; c=relaxed/simple;
	bh=SjeV4gq8axgBTGcvjKkuyl4z96MDTwhCe9RbzzE6oRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+9nbMherX1xqrU5GodBYCsHFLAMEhnxPwLF47FsIF5XBKmQp52fKSUjXMeRSUMS2DPW0Cbx3nPBwVWXfB+CqP4ttYT10CDnwPKxyOr1XdSN7nQR+LptAUGUo3swvcMD/VPH8/06lAZ4EooSkpLSf60q1c+2N2j+p3LBtlfpG5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDeUbWqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E21C433F1;
	Wed, 28 Feb 2024 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709115138;
	bh=SjeV4gq8axgBTGcvjKkuyl4z96MDTwhCe9RbzzE6oRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FDeUbWqL0ZTfHwKjTeYjmKki5DdyY7jdLCVq2yvRjHfMi+r1Xy36SYjIRIfA/ZJUv
	 irtXowHrs38LdQHhbbwci0ZxsEKYlQ2xU4ZNVX8jdXwueVx4FT2viljWDFcHoXdBkR
	 m9gJSvxkrjmDZ0TEVh+tWEMTSnYnB0YT9EDAkR1DM4b7nDC/EDrEf/19oXrEHmRzmz
	 4SY6EaTIgfS9ZZ9MEK9TcJtDdeHDLpGTTy7UkKQk6wujOq+lG1sGAoLHQ32UuIITnY
	 SHLFPWkqsiB/9hVJTkYTQpweKadedjzTy/eZSmNDeXAiY+OAcbZrfZV02nnsSiJZeY
	 prSeGGXArxXDQ==
Date: Wed, 28 Feb 2024 10:12:14 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	Stefan O'Rear <sorear@fastmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH -fixes v4 2/3] riscv: Add a custom ISA extension for the
 [ms]envcfg CSR
Message-ID: <20240228-goldsmith-shrine-97fc4610e0bc@spud>
References: <20240228065559.3434837-1-samuel.holland@sifive.com>
 <20240228065559.3434837-3-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="89TWk6vKMP9NHwwH"
Content-Disposition: inline
In-Reply-To: <20240228065559.3434837-3-samuel.holland@sifive.com>


--89TWk6vKMP9NHwwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:55:34PM -0800, Samuel Holland wrote:
> The [ms]envcfg CSR was added in version 1.12 of the RISC-V privileged
> ISA (aka S[ms]1p12). However, bits in this CSR are defined by several
> other extensions which may be implemented separately from any particular
> version of the privileged ISA (for example, some unrelated errata may
> prevent an implementation from claiming conformance with Ss1p12). As a
> result, Linux cannot simply use the privileged ISA version to determine
> if the CSR is present. It must also check if any of these other
> extensions are implemented. It also cannot probe the existence of the
> CSR at runtime, because Linux does not require Sstrict, so (in the
> absence of additional information) it cannot know if a CSR at that
> address is [ms]envcfg or part of some non-conforming vendor extension.
>=20
> Since there are several standard extensions that imply the existence of
> the [ms]envcfg CSR, it becomes unwieldy to check for all of them
> wherever the CSR is accessed. Instead, define a custom Xlinuxenvcfg ISA
> extension bit that is implied by the other extensions and denotes that
> the CSR exists as defined in the privileged ISA, containing at least one
> of the fields common between menvcfg and senvcfg.

> This extension does not need to be parsed from the devicetree or ISA
> string because it can only be implemented as a subset of some other
> standard extension.

NGL, every time I look at the superset stuff I question whether or not
it is a good implementation, but it is nice to see that it at least
makes the creation of quasi-extension flags like this straightforward.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


>=20
> Cc: <stable@vger.kernel.org> # v6.7+
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
> Changes in v4:
>  - New patch for v4
>=20
>  arch/riscv/include/asm/hwcap.h |  2 ++
>  arch/riscv/kernel/cpufeature.c | 14 ++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 5340f818746b..1f2d2599c655 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -81,6 +81,8 @@
>  #define RISCV_ISA_EXT_ZTSO		72
>  #define RISCV_ISA_EXT_ZACAS		73
> =20
> +#define RISCV_ISA_EXT_XLINUXENVCFG	127
> +
>  #define RISCV_ISA_EXT_MAX		128
>  #define RISCV_ISA_EXT_INVALID		U32_MAX
> =20
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index c5b13f7dd482..dacffef68ce2 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -201,6 +201,16 @@ static const unsigned int riscv_zvbb_exts[] =3D {
>  	RISCV_ISA_EXT_ZVKB
>  };
> =20
> +/*
> + * While the [ms]envcfg CSRs were not defined until version 1.12 of the =
RISC-V
> + * privileged ISA, the existence of the CSRs is implied by any extension=
 which
> + * specifies [ms]envcfg bit(s). Hence, we define a custom ISA extension =
for the
> + * existence of the CSR, and treat it as a subset of those other extensi=
ons.
> + */
> +static const unsigned int riscv_xlinuxenvcfg_exts[] =3D {
> +	RISCV_ISA_EXT_XLINUXENVCFG
> +};
> +
>  /*
>   * The canonical order of ISA extension names in the ISA string is defin=
ed in
>   * chapter 27 of the unprivileged specification.
> @@ -250,8 +260,8 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(c, RISCV_ISA_EXT_c),
>  	__RISCV_ISA_EXT_DATA(v, RISCV_ISA_EXT_v),
>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> -	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> -	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> +	__RISCV_ISA_EXT_SUPERSET(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvc=
fg_exts),
> +	__RISCV_ISA_EXT_SUPERSET(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvc=
fg_exts),
>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>  	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> --=20
> 2.43.1
>=20

--89TWk6vKMP9NHwwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZd8G/gAKCRB4tDGHoIJi
0lSVAQD2pgTYFd8WHckkvmBwiRxHU2gH6XrQ/xUjopf2SNAXOQD/UxgKdys+eRaA
Pe6taFBtc5LYaTJUWzGwhcdKp817lgU=
=FMqA
-----END PGP SIGNATURE-----

--89TWk6vKMP9NHwwH--

