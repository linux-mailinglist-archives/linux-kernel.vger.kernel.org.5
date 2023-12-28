Return-Path: <linux-kernel+bounces-12684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0586281F8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338741C22482
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E14882D;
	Thu, 28 Dec 2023 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPXC8vsA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0A8485;
	Thu, 28 Dec 2023 13:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3977C433C7;
	Thu, 28 Dec 2023 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703770567;
	bh=bFpxYHW+l52Yon/qnLqsK7by+x6JrUkDWpOTaKXGCuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPXC8vsA4C2uEmnk6veULjxQjJ5cBGEFMRtQM3NaK5BnN9GzktRORK+VB0UMuZWJA
	 ruk1McP+5Zjei1gfrZv7E0/cBH6M+C5+EYMv4jxP3NEiKkVWxAb7AyF0eTjZyPmS3L
	 YXh5PmNJV2CA7VFA14KitatLEhlJ7yTTel1v0ICnYPbcfFKtiQJIwthOwy1svDaLTo
	 L053ziUbt703sWy4MZbHl5ErQk6Vvun6VF9F1SJQMD91zIZTh4vfcLdoRuKbqTaLIE
	 XJ+WhHTL4Qa0M598ffFH7gIP1AeUMOUPy5MYbye3EpdHYbDJwzx/JI7Uyxs+xV+EPy
	 wNsA48b/r7BNA==
Date: Thu, 28 Dec 2023 13:36:02 +0000
From: Conor Dooley <conor@kernel.org>
To: AnnanLiu <annan.liu.xdu@outlook.com>
Cc: chao.wei@sophgo.com, unicorn_wang@outlook.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: add timer dt node for CV1800
Message-ID: <20231228-distill-heave-ebda9ee53576@spud>
References: <DM6PR20MB23167E08FCA546D6C1899CB1AB9EA@DM6PR20MB2316.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PedUr4prEc/4tkOE"
Content-Disposition: inline
In-Reply-To: <DM6PR20MB23167E08FCA546D6C1899CB1AB9EA@DM6PR20MB2316.namprd20.prod.outlook.com>


--PedUr4prEc/4tkOE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 09:06:54PM +0800, AnnanLiu wrote:
> Add the timer device tree node to CV1800 SoC.

> This patch depends on the clk driver and reset driver.
> Clk driver link:
> https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1PR2=
0MB4953.namprd20.prod.outlook.com/
> Reset driver link:
> https://lore.kernel.org/all/20231113005503.2423-1-jszhang@kernel.org/

FYI, this stuff should be under the --- line.

If there's nothing else wrong with this commit, I can fix this while
applying.

Cheers,
Conor.

>=20
> Signed-off-by: AnnanLiu <annan.liu.xdu@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 72 +++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dt=
s/sophgo/cv1800b.dtsi
> index aec6401a467b..34a1647cc51b 100644
> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> @@ -113,6 +113,78 @@ plic: interrupt-controller@70000000 {
>  			riscv,ndev =3D <101>;
>  		};
> =20
> +		timer0: timer@030a0000 {
> +			compatible =3D "snps,dw-apb-timer";
> +			reg =3D <0x030a0000 0x14>;
> +			interrupts =3D <79 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc>;
> +			resets =3D <&rst RST_TIMER0>;
> +			status =3D "disabled";
> +		};
> +
> +		timer1: timer@030a0014 {
> +			compatible =3D "snps,dw-apb-timer";
> +			reg =3D <0x030a0014 0x14>;
> +			interrupts =3D <80 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc>;
> +			resets =3D <&rst RST_TIMER1>;
> +			status =3D "disabled";
> +		};
> +
> +		timer2: timer@030a0028 {
> +			compatible =3D "snps,dw-apb-timer";
> +			reg =3D <0x030a0028 0x14>;
> +			interrupts =3D <81 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc>;
> +			resets =3D <&rst RST_TIMER2>;
> +			status =3D "disabled";
> +		};
> +
> +		timer3: timer@030a003c {
> +			compatible =3D "snps,dw-apb-timer";
> +			reg =3D <0x030a003c 0x14>;
> +			interrupts =3D <82 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc>;
> +			resets =3D <&rst RST_TIMER3>;
> +			status =3D "disabled";
> +		};
> +
> +		timer4: timer@030a0050 {
> +			compatible =3D "snps,dw-apb-timer";
> +			reg =3D <0x030a0050 0x14>;
> +			interrupts =3D <83 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc>;
> +			resets =3D <&rst RST_TIMER4>;
> +			status =3D "disabled";
> +		};
> +
> +		timer5: timer@30a0064 {
> +			compatible =3D "snps,dw-apb-timer";
> +			reg =3D <0x030a0064 0x14>;
> +			interrupts =3D <84 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc>;
> +			resets =3D <&rst RST_TIMER5>;
> +			status =3D "disabled";
> +		};
> +
> +		timer6: timer@030a0078 {
> +			compatible =3D "snps,dw-apb-timer";
> +			reg =3D <0x030a0078 0x14>;
> +			interrupts =3D <85 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc>;
> +			resets =3D <&rst RST_TIMER6>;
> +			status =3D "disabled";
> +		};
> +
> +		timer7: timer@030a008c {
> +			compatible =3D "snps,dw-apb-timer";
> +			reg =3D <0x030a008c 0x14>;
> +			interrupts =3D <86 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&osc>;
> +			resets =3D <&rst RST_TIMER7>;
> +			status =3D "disabled";
> +		};
> +
>  		clint: timer@74000000 {
>  			compatible =3D "sophgo,cv1800b-clint", "thead,c900-clint";
>  			reg =3D <0x74000000 0x10000>;
> --=20
> 2.34.1
>=20

--PedUr4prEc/4tkOE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZY15vgAKCRB4tDGHoIJi
0mo0AQCGttIjbdlNdLMJ5uVxoE+C9lVMfy8EQmXeaQrdch+F9QEAzVg8Yq6JN7Qd
0qJbqKr0Sqd+51fwghslIbPvgoKSYgo=
=45y3
-----END PGP SIGNATURE-----

--PedUr4prEc/4tkOE--

