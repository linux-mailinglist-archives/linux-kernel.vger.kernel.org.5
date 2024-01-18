Return-Path: <linux-kernel+bounces-30592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B01832158
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE71B21A60
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9B31758;
	Thu, 18 Jan 2024 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNbE/DSA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35482E848
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705615549; cv=none; b=qNWrkPlNPWtiVotUhh8CMC5yeD/UZ6LruN0QzjS4TKauTix6OPqEol1WLNsJ/nZsqNzhH+jlUi8T0EL5c+k+WhGpmgMA9WKRW3+JeSJJSnBf+BVnoNUUA5XD8u5qVsVuQw6flis+g4pucZS1A88UAaC/7gv7jgojtY+InFCqJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705615549; c=relaxed/simple;
	bh=Q+pX89EmEj04h50yCe1VL5XHOahd2MD8MrvKmiempYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVRK5woQnR7hqgtdEuv/HF98n2WkZK5Fern+RsMEI1gLF7jpjaPDViaBZjSB2BUYi5ISdEpmxESrsQQz5v56075OzWh3ADujQ4HJSquiJdZR3LimhrWjBKYVKfVm1ZpLF+mc+fgm/LUVxIjUEj5nEw8OtblKEcw316+MY+HhTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNbE/DSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F037FC433F1;
	Thu, 18 Jan 2024 22:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705615548;
	bh=Q+pX89EmEj04h50yCe1VL5XHOahd2MD8MrvKmiempYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNbE/DSA1PztMn+pO4MdBoIICDaUBsbIzCzZ5Ac2UfyLf55lezcOOFY7ENy72YJpg
	 MhPRW9MlcVv7fNBgw8f79OkTk1f2hhznZ8mRS7I5NCTZRGNvj2y1PnpA+zat0ixpY/
	 sbc2viqRM4rc3odbhaV1BzoU4sBZInarilSrdEbWjZFc7tbpJetoB+mWJO0Q/tAbZI
	 UNWoim7wx/kNmm1Zm063ZwaptO0ZqPIWd/CKQhmdFfA+h+1WjdL+s4eqmhyBNlxuEX
	 /Jv6nGR599BKQcVdICb/tSbvW2QUlRMAEdpquDX94FkGKC2XeF01l2KIzUfCdYzYLL
	 24vWRWGr/YFHg==
Date: Thu, 18 Jan 2024 22:05:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: lib: Support csum on GCC <11
Message-ID: <20240118-museum-ample-11d649f95de8@spud>
References: <20240118-csum_remove_output_operands_asm_goto-v1-1-47c672bb9d4b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pl1prUg+ekIn2nNV"
Content-Disposition: inline
In-Reply-To: <20240118-csum_remove_output_operands_asm_goto-v1-1-47c672bb9d4b@rivosinc.com>


--pl1prUg+ekIn2nNV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 01:53:59PM -0800, Charlie Jenkins wrote:
> The OutputOperands field for asm goto statements is only supported
> starting from GCC 11. Split the asm goto to remove the use of this
> feature.
>=20
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: a04c192eabfb ("riscv: Add checksum library")
> ---
> The OutputOperands field for asm goto statements is only supported
> starting from GCC 11. Split the asm goto to remove the use of this
> feature.

Maybe this is a super naive question, but is it possible to just not
use the custom csum code for gcc older than 11?

> ---
>  arch/riscv/lib/csum.c | 42 ++++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
> index 06ce8e7250d9..23be289f52b6 100644
> --- a/arch/riscv/lib/csum.c
> +++ b/arch/riscv/lib/csum.c
> @@ -177,22 +177,35 @@ do_csum_with_alignment(const unsigned char *buff, i=
nt len)
>  				  : no_zbb);
> =20
>  #ifdef CONFIG_32BIT
> -		asm_volatile_goto(".option push			\n\
> +		/*
> +		 * OutputOperands in asm goto is not supported until GCC 11, so
> +		 * this asm has to be split to be compatible.
> +		 */
> +		asm (".option push				\n\
>  		.option arch,+zbb				\n\
>  			rori	%[fold_temp], %[csum], 16	\n\
>  			andi	%[offset], %[offset], 1		\n\
>  			add	%[csum], %[fold_temp], %[csum]	\n\
> -			beq	%[offset], zero, %l[end]	\n\
> -			rev8	%[csum], %[csum]		\n\
>  		.option pop"
>  			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp)
> -			: [offset] "r" (offset)
> -			:
> -			: end);
> +			: [offset] "r" (offset));
> +
> +		if (offset =3D=3D 0)
> +			goto end;
> +
> +		asm (".option push				\n\
> +		.option arch, +zbb				\n\
> +			rev8	%[csum], %[csum]		\n\
> +		.option pop"
> +			: [csum] "+r" (csum));
> =20
>  		return (unsigned short)csum;
>  #else /* !CONFIG_32BIT */
> -		asm_volatile_goto(".option push			\n\
> +		/*
> +		 * OutputOperands in asm goto is not supported until GCC 11, so
> +		 * this asm has to be split to be compatible.
> +		 */
> +		asm (".option push				\n\
>  		.option arch,+zbb				\n\
>  			rori	%[fold_temp], %[csum], 32	\n\
>  			add	%[csum], %[fold_temp], %[csum]	\n\
> @@ -200,13 +213,18 @@ do_csum_with_alignment(const unsigned char *buff, i=
nt len)
>  			roriw	%[fold_temp], %[csum], 16	\n\
>  			addw	%[csum], %[fold_temp], %[csum]	\n\
>  			andi	%[offset], %[offset], 1		\n\
> -			beq	%[offset], zero, %l[end]	\n\
> -			rev8	%[csum], %[csum]		\n\
>  		.option pop"
>  			: [csum] "+r" (csum), [fold_temp] "=3D&r" (fold_temp)
> -			: [offset] "r" (offset)
> -			:
> -			: end);
> +			: [offset] "r" (offset));
> +
> +		if (offset =3D=3D 0)
> +			goto end;
> +
> +		asm (".option push				\n\
> +		.option arch, +zbb				\n\
> +			rev8	%[csum], %[csum]		\n\
> +		.option pop"
> +			: [csum] "+r" (csum));
> =20
>  		return (csum << 16) >> 48;
>  #endif /* !CONFIG_32BIT */
>=20
> ---
> base-commit: 080c4324fa5e81ff3780206a138223abfb57a68e
> change-id: 20240118-csum_remove_output_operands_asm_goto-49922c141ce7
> --=20
> - Charlie
>=20
>=20

--pl1prUg+ekIn2nNV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZamguAAKCRB4tDGHoIJi
0piAAP43AO2qeJIkMIMNCYDRVUHlOx4Fd4fKJBeaGX7Pc1EjlQD+Klh3LfS4rMLi
BXwU/T016C4F2KPCyItXgiwTbGy4SwU=
=Yi8l
-----END PGP SIGNATURE-----

--pl1prUg+ekIn2nNV--

