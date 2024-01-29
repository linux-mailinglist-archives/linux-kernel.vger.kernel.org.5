Return-Path: <linux-kernel+bounces-43011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E628840A3C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE6282DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA43115444E;
	Mon, 29 Jan 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gi4yF32n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB60154435;
	Mon, 29 Jan 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542807; cv=none; b=Uu2teIwzT4IC1GgXsu3txWAxRssxpMKIKSFym7Gx1jMV/tQCt1m295EW+BM0QpTke+LS67HJZR+/0Oux6P0a4FRf5HFJyg1jtqiUfLcv+lYXExArAWmRqeBHkqVeAoSstD+VFr4t+diV4efcXytVwVj1yS6i+9FsbVwLVI8HECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542807; c=relaxed/simple;
	bh=S/WbJSjcNsxsM1bxIGAGLA6NqY3K/ht9T73+RySJp+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htkGSzU2OuU587p0Rc1XnoJH9TNXEcJyW+z1ARJlCmfnZ1KEhl3I7PgVHQAX5AVmEhvl8jlGfMo8KEB2lQdQuk5mDpWIlU++SBmKtBa430RFxFMKwyCF/1bTW1cwCxrzwFeOPMzuHwpzbCwPBk4NvVu24T8jV+ThTm+/XB1Zt8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi4yF32n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C35C433F1;
	Mon, 29 Jan 2024 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706542806;
	bh=S/WbJSjcNsxsM1bxIGAGLA6NqY3K/ht9T73+RySJp+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gi4yF32nXjnfqhkQSWcpjlBwC3WGLPuNC5/04kXSNajIV6f/mZCRKoLznztTQSSzg
	 ETpJgSPYsrnUk65F9a1C9g7qgWNF/3QhqvJ96MBTp1zjhopi73bp3HRDDPQTB+29nW
	 JDBdZi1eXt71WMkSV9HPpgGPgytlsUzgIIpjVENvJr2qGDaTiyvs0XaXhuKoxTNvNS
	 ev85SWovM7bH+qlVvgUwsu7xezJshQzZyWkwXfiqB6OAfUKIhZ0den+NZp9/rudpmf
	 ejm4tg/brzUOmafXZTuHa4SaY8hMbv5wZZ/dyk4IkoCmIeV2SOLLCNriX708hB2MBq
	 rF6bLtW6N/h1Q==
Date: Mon, 29 Jan 2024 15:40:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Yixun Lan <dlan@gentoo.org>, Chao Wei <chao.wei@sophgo.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: dts: sophgo: cv18xx: Add spi devices
Message-ID: <20240129-equation-untaken-5892c9dbfe19@spud>
References: <20240129030115.GB1097489@ofsar>
 <IA1PR20MB49532962D49F119F355EC55ABB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HjsU6dV8a1MXSl2a"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49532962D49F119F355EC55ABB7E2@IA1PR20MB4953.namprd20.prod.outlook.com>


--HjsU6dV8a1MXSl2a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:47:18AM +0800, Inochi Amaoto wrote:
> >Hi Inochi Amaoto
> >
> >On 10:26 Mon 29 Jan     , Inochi Amaoto wrote:
> >> Add spi devices for the CV180x, CV181x and SG200x soc.
> >>
> >> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> >> ---
> >>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi | 44 ++++++++++++++++++++++++++
> >>  1 file changed, 44 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/=
dts/sophgo/cv18xx.dtsi
> >> index 7c88cbe8e91d..e66f9e9feb48 100644
> >> --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> >> +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> >> @@ -176,6 +176,50 @@ uart3: serial@4170000 {
> >>  			status =3D "disabled";
> >>  		};
> >>
> >> +		spi0: spi@4180000 {
> >> +			compatible =3D "snps,dw-apb-ssi";
> >> +			reg =3D <0x04180000 0x10000>;
> >> +			interrupts =3D <54 IRQ_TYPE_LEVEL_HIGH>;
> >> +			clocks =3D <&clk CLK_SPI>, <&clk CLK_APB_SPI0>;
> >> +			clock-names =3D "ssi_clk", "pclk";
> >..
> >> +			#address-cells =3D <1>;
> >> +			#size-cells =3D <0>;
> >I'd suggest moving those two above 'interrupts' property
> >
> >there is an ongoing discussion here..

Not super important to point out, but this discussion isn't "ongoing",
it was merged into 6.8-rc1:
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

Cheers,
Conor.

> >https://lore.kernel.org/all/20231203174622.18402-1-krzysztof.kozlowski@l=
inaro.org/
> >
>=20
> Thanks for this info. I will take care of it.

--HjsU6dV8a1MXSl2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfG0QAKCRB4tDGHoIJi
0uh/AP9tS/09PvuQHf275Eg3w7Kt/uYP4Vse2KC76XI/LWPxpQEA9CLH7XiXhA8T
HObam60nr8K07ePBQDQuL6+9hNw9hQU=
=6YN8
-----END PGP SIGNATURE-----

--HjsU6dV8a1MXSl2a--

