Return-Path: <linux-kernel+bounces-39016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B604383C9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671521F22138
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB880136664;
	Thu, 25 Jan 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffDXEQ6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED358131723;
	Thu, 25 Jan 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202780; cv=none; b=YoN+9+4y6yDjNETBMUSL6axeU3AT3Rc7St/P1Y/njhYgF4X3nUgh1SFeE8P2QZnT0saLnTiGCr7QLEDkvBPo++nzPn4xJbahntsopYaWHqAxlkZZcKyO0afCOCwsnM7uvfngagm0ykIm8SbwCC70psY+y5Emij7z6IRvxNB+Hqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202780; c=relaxed/simple;
	bh=P8twLiBk8195NVVkVBNtmDPSljomu/5qIfayjD6vnKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGvlR5j/3IurDou94xphbNSBpnyelrjjgYe4GJlXWE5dw4+B5qtEatmYDOHxamZTLCpEa2kgW9he0epXZFDKKOE26YYq0jWCMdDN2y/GMT7dLPFKdM8Q60Iwi4AYrT0HSAVZqVbrtsjabY2pDH8osdZ942xK/ZRYuSEtWhY7Ewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffDXEQ6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020FAC433F1;
	Thu, 25 Jan 2024 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706202779;
	bh=P8twLiBk8195NVVkVBNtmDPSljomu/5qIfayjD6vnKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffDXEQ6xe5Oc09Q0Ks5MWZFNjI/ryOga9U0VvRre4UlZEsa4bu1C1FXVa6Kf3v4qP
	 P8E/TALOBWSYRQd5NsV2L5zUqy4jO7BVVip0OWlmeyLMgqtw55dnQGKSOpNFTFMqqR
	 Fp8KqNxBzSziJSwDZdZEx7JJUL12SiHu9misY+GkRJBqdgG1zwLfsSeOWHkTeFNexM
	 Ahi5B3AJZf0vRBV3NRRn4YuJ5SB+VZqA0fRwsWGfJVi2hH8UJ7JFTSwvnye1xjr+BO
	 yg5sTt5RbpjbV9x6hUkNkW1WDlzfJIZqyudzyT/UtsrbgL+5xT0If1FURMZAkirwTy
	 Pc9SwmnCEFYtA==
Date: Thu, 25 Jan 2024 17:12:54 +0000
From: Conor Dooley <conor@kernel.org>
To: AnnanLiu <annan.liu.xdu@outlook.com>
Cc: chao.wei@sophgo.com, unicorn_wang@outlook.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: sophgo: add timer dt node for CV1800
Message-ID: <20240125-rosy-folk-976dd297e32f@spud>
References: <DM6PR20MB23167ABF18C1F004A5710D4FAB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U7ZAB6TpsVs6HOXN"
Content-Disposition: inline
In-Reply-To: <DM6PR20MB23167ABF18C1F004A5710D4FAB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>


--U7ZAB6TpsVs6HOXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 05:46:23PM +0800, AnnanLiu wrote:
> Add the timer device tree node to CV1800 SoC.
>=20
> Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
> ---
> This patch depends on the clk driver and reset driver.
> Clk driver link:
> https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR2=
0MB4953.namprd20.prod.outlook.com/
> Reset driver link:
> https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/
>=20
> Changes since v1:
> - Change the status of the timer from disabled to okay.
> v1 link:
> https://lore.kernel.org/all/DM6PR20MB23167E08FCA546D6C1899CB1AB9EA@DM6PR2=
0MB2316.namprd20.prod.outlook.com/
>=20
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 73 +++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dt=
s/sophgo/cv1800b.dtsi
> index aec6401a467b..aef7970af2b8 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0 OR MIT)
>  /*
>   * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + * Copyright (C) 2024 Annan Liu <annan.liu.xdu@outlook.com>
>   */
> =20
>  #include <dt-bindings/interrupt-controller/irq.h>
> @@ -113,6 +114,78 @@ plic: interrupt-controller@70000000 {
>  			riscv,ndev =3D <101>;
>  		};
> =20
> +		timer0: timer@030a0000 {
> +			compatible =3D "snps,dw-apb-timer";
> +			reg =3D <0x030a0000 0x14>;
> +			interrupts =3D <79 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc>;
> +			resets =3D <&rst RST_TIMER0>;
> +			status =3D "okay";

Do these really have no interface clock? I'd expect something that
is almost certainly sitting on a apb (or similar) interface to have one.

Thanks,
Conor.

--U7ZAB6TpsVs6HOXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKWlgAKCRB4tDGHoIJi
0vpGAP9NN4LPvUxivpiccMxrAPRFKuRn7nj+iQE9H6tZd0YdzAEAjWezQmZEkdEt
fL6gE5liQ4NsH5TG4cdJc7SJ9zAU2gk=
=yJSK
-----END PGP SIGNATURE-----

--U7ZAB6TpsVs6HOXN--

