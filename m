Return-Path: <linux-kernel+bounces-92904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A328727D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E141F29099
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FA68664F;
	Tue,  5 Mar 2024 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkxCNDdW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB365C601;
	Tue,  5 Mar 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667704; cv=none; b=YB6qvGElzLsaxJrwaLxDM5WkwBrtHp2AIivwWtUi7VwdTZW4X81RB8bqfdB62DyeX4ChtwoDOVImxQ1Rs30t8DfA7DkWpxWQ/huvhDLotAkt99bw65iaTLwb724dyL3i2puVwr0Pfhg2AveYFzWbqzKUilHSFGPclYS5GtSYd4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667704; c=relaxed/simple;
	bh=wx1vWKZbAWVZSBpFlLvwCrtdSU8zvPw7WcOO3aQorXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgHTnUgoOUTAWz9W/yGd0gi84yVe5jK6Iwb5w7US8DG5NhxnxtNeLmiYq12i+V1VDVFiXaN3faYApMnEtiZECrULhaNruMK1btU+utGI3PFimWlS+oPdkygI82Frb4tlEEuFqzUTy32n6VxReR2jyFrLwsqNw1Rk88aLRjTL9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkxCNDdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6429DC433C7;
	Tue,  5 Mar 2024 19:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709667704;
	bh=wx1vWKZbAWVZSBpFlLvwCrtdSU8zvPw7WcOO3aQorXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkxCNDdWaI8fYdtiueCuY22sD6XWNp7UAhWO4qb0KMMbbj+ZtysXrjTvEvH75LftA
	 /aDgMERyiV7U8cfIcRKbs3nkdFQyVi+3+5w2fMrxzdBRDQuACmS4wfKFRviKpPqRpY
	 fvTJ5HT/tkPt1714aoPBXCNSa7roZA6GDeeTIDc2t+cv7z5NdVmEcIee7WulB9ftIG
	 MAx0iZv9/KDOcUvDqhMRwzcCWm2OXvn0Umnx4pxLkMedzNRlmh9M+rVDj+HEuuxkGs
	 KpUq8vi+oOoDLrEeoqovutliIwVxs/FBLihbPfnQL5E/hZhH/qr3bJN+2zKb/g6qdL
	 jROjWWlBUTCaw==
Date: Tue, 5 Mar 2024 19:41:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: ganboing@gmail.com, kernel@esmil.dk, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, lee@kernel.org,
	andre.przywara@arm.com, jernej.skrabec@gmail.com,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: starfive: Remove PMIC interrupt info for
 Visionfive 2 board
Message-ID: <20240305-macarena-fiber-f2460d371150@spud>
References: <TY3P286MB2611C5F5833F3E3E1AE838CA98222@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iNSctF24dp3Ivm4K"
Content-Disposition: inline
In-Reply-To: <TY3P286MB2611C5F5833F3E3E1AE838CA98222@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>


--iNSctF24dp3Ivm4K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2024 at 01:11:50AM +0800, Shengyu Qu wrote:
> Since commit b2cb2ae22278f1918f7526b89760ee00b4a81393 ("mfd: axp20x:
> Generalise handling without interrupt"), interrupt info part for the
> AXP15060 PMIC is not needed anymore for Statfive Visionfive 2 board.
> And this would cause kernel to try to enable interrupt line 0, which is
> not expected. So delete this part from device tree.

interrupt-controller/#interrupt-cells are required properties, you can't
delete them. If you ran dtbs_check you'd see that it complains about
this patch.

If you just remove the interrupts property, what happens?

> Cc: stable@vger.kernel.org
> Fixes: b2cb2ae22278 ("mfd: axp20x: Generalise handling without interrupt")

This Fixes tag cannot be right, a dts patch cannot fix a driver. The dts
patch that incorrectly said this used interrupt 0 is what should be in the
Fixes tag.

Thanks,
Conor.

> Reported-by: Bo Gan <ganboing@gmail.com>

Closes: https://lore.kernel.org/linux-riscv/c8b6e960-2459-130f-e4e4-7c9c2eb=
aa6d3@gmail.com/

> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dt=
si b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index b89e9791efa7..6bebabe3fa37 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -189,9 +189,6 @@ &i2c5 {
>  	axp15060: pmic@36 {
>  		compatible =3D "x-powers,axp15060";
>  		reg =3D <0x36>;
> -		interrupts =3D <0>;
> -		interrupt-controller;
> -		#interrupt-cells =3D <1>;
> =20
>  		regulators {
>  			vcc_3v3: dcdc1 {
> --=20
> 2.39.2
>=20

--iNSctF24dp3Ivm4K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZed1cgAKCRB4tDGHoIJi
0ldpAQDM6/MJ6AW3Mku853cAfxzI/uGgUrvTKPGEQmOoeYSTLgEA/Ze1f6KSz1ll
cylgQrIF7PnaEETKgv8q78LqOM8sbAs=
=02ei
-----END PGP SIGNATURE-----

--iNSctF24dp3Ivm4K--

