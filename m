Return-Path: <linux-kernel+bounces-22096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E7F829923
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11151F2158E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA4847A6B;
	Wed, 10 Jan 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcvTS9li"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCB364AF;
	Wed, 10 Jan 2024 11:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC577C433C7;
	Wed, 10 Jan 2024 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704886286;
	bh=YijeE4lMHSCVvcttYBU3SInp/YKSJPvaHdxLhi+JtYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcvTS9liGZeeFspyq8/b0JP1ZkBzGDTEnjvFv15DiD0vtEfUNzgIeodJnmxMDN8U3
	 rpYqy5NlhOXHJU6Ik3NTqDlmO+slV461IW+8mVSp5niGHKBvMSktqvxS2hqTG83yYp
	 Wu/D1yXDI70WeKACfCWat8Rc4SdYV0mpTR0xCGPKImGfTcHj2Y6tFGEaTZQUnbD525
	 uRQjZAKcoRiV+ip19HJhkNyUEJ0ni65fbN8/DTiGHVpsPeF/ooL2i+EY8LSQkQ9a0k
	 3it3s8ZktOm2N2mV9Pa89bDBR/sX1N7OHYVkGk2rF5mGFQ1+pmEtAuLffIoVycpSGq
	 1FSG1BXbJ96ew==
Date: Wed, 10 Jan 2024 11:31:21 +0000
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
Subject: Re: [PATCH v2 4/6] riscv: add ISA extension parsing for Zacas
Message-ID: <20240110-creed-sturdily-c93c15fc6549@spud>
References: <20231220155723.684081-1-cleger@rivosinc.com>
 <20231220155723.684081-5-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ltx+3bcvQMB0flo+"
Content-Disposition: inline
In-Reply-To: <20231220155723.684081-5-cleger@rivosinc.com>


--ltx+3bcvQMB0flo+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 04:57:20PM +0100, Cl=E9ment L=E9ger wrote:
> Add parsing for Zacas ISA extension which was ratified recently in the
> riscv-zacas manual.
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
> index 3b31efe2f716..34f86424d743 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -85,6 +85,7 @@
>  #define RISCV_ISA_EXT_ZVFHMIN		70
>  #define RISCV_ISA_EXT_ZFA		71
>  #define RISCV_ISA_EXT_ZTSO		72
> +#define RISCV_ISA_EXT_ZACAS		73
> =20
>  #define RISCV_ISA_EXT_MAX		128
>  #define RISCV_ISA_EXT_INVALID		U32_MAX
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeatur=
e.c
> index 3eb48a0eecb3..9a9d915b5bb2 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -259,6 +259,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =3D {
>  	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
>  	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
>  	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
> +	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
> --=20
> 2.43.0
>=20

--ltx+3bcvQMB0flo+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ6ACQAKCRB4tDGHoIJi
0v55AQDZdKqZq0LPpzAGZXePq06kU+fz6HskHPlQ+h2crRlRAwEAsHn72UEtafAE
4seP9ykxgZVOQtsIOdfyUSSVCueHwwA=
=imzt
-----END PGP SIGNATURE-----

--ltx+3bcvQMB0flo+--

