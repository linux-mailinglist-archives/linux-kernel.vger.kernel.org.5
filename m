Return-Path: <linux-kernel+bounces-22098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088BE82992F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A97283040
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0744247A6B;
	Wed, 10 Jan 2024 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRByQrTh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E2481A0;
	Wed, 10 Jan 2024 11:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ABBC433C7;
	Wed, 10 Jan 2024 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704886334;
	bh=X9QbxNBN6JyW1oeyEZmWRgibEZdnoLhcaRrM0O9CHk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRByQrTh7LUjUhEU7sOl3vvSeW1RpOIERkA8IwQlyQLSqQxmn3qJLcaQ+P5ZKa288
	 st8wEViJt9CzoVWOHucgOo5i+iuAk6vhSFhVUUpGOan8DcM+Gmybn/VlH9YJeS4zkP
	 lCI6bb/2npds4NSzVmDfaULwF7pMQAgBQkkIoDU2fNdt6Li8IXmf8DZLJ5tyOF10eF
	 hpb2qAGCeHQaHyyhSdCRAKJeAze3PbCB5IcLnN03LBY6f82TjZxAz/CsKvCtj0yGQ+
	 oN8xSJRdro3ixG21D0cSHQgm/SD9BlGc2GlfXjWAjs1GJ66kCqZpApZV+Jj5thSkNA
	 Da7fp4EBb42PA==
Date: Wed, 10 Jan 2024 11:32:09 +0000
From: Conor Dooley <conor@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Robbin Ehn <rehn@rivosinc.com>,
	Gianluca Guida <gianluca@rivosinc.com>
Subject: Re: [PATCH v2 1/6] riscv: add ISA extension parsing for Ztso
Message-ID: <20240110-childish-magnetic-75dacb4fb265@spud>
References: <20231220155723.684081-1-cleger@rivosinc.com>
 <20231220155723.684081-2-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rEohnyKvwS23qCv0"
Content-Disposition: inline
In-Reply-To: <20231220155723.684081-2-cleger@rivosinc.com>


--rEohnyKvwS23qCv0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 04:57:17PM +0100, Cl=E9ment L=E9ger wrote:
> Add support to parse the Ztso string in the riscv,isa string. The
> bindings already supports it but not the ISA parsing code.
>=20
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  arch/riscv/include/asm/hwcap.h | 1 +
>  arch/riscv/kernel/cpufeature.c | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwca=
p.h
> index 2438d4685da6..3b31efe2f716 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -84,6 +84,7 @@
>  #define RISCV_ISA_EXT_ZVFH		69
>  #define RISCV_ISA_EXT_ZVFHMIN		70
>  #define RISCV_ISA_EXT_ZFA		71
> +#define RISCV_ISA_EXT_ZTSO		72
> =20
>  #define RISCV_ISA_EXT_MAX		128
>  #define RISCV_ISA_EXT_INVALID		U32_MAX
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index dc0ab3e97cd2..3eb48a0eecb3 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -279,6 +279,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
>  	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
>  	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> +	__RISCV_ISA_EXT_DATA(ztso, RISCV_ISA_EXT_ZTSO),
>  	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
>  	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
>  	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
> --=20
> 2.43.0
>=20

--rEohnyKvwS23qCv0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ6AOQAKCRB4tDGHoIJi
0gi6AQDMTvHshgmIxeYYvER5QNLkJGGnk9Du0Z4e5q/5yAhdnwD7BDk5kOnuXzyq
U0LrzFyiX6cUknwFyCuN0/arBBh3zgY=
=J7XO
-----END PGP SIGNATURE-----

--rEohnyKvwS23qCv0--

