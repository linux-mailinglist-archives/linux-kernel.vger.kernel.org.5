Return-Path: <linux-kernel+bounces-165499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DBF8B8D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56E6B2418C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F09B5024E;
	Wed,  1 May 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQRo45x6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EEB12D76E;
	Wed,  1 May 2024 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714577871; cv=none; b=dSoPOzycZsjC520Fh9GL3+ASkma3Dz0fG0zjpEziRt/QTeaU61/qMCXN7gi0cuV55Zqne7uKOxmGm9x0Wq+1dPQZoZv4/SdftfWdlkGxhkf6wk6T9ZAb2xZDlEqwjdB67gKNL+NIuySe13abq/GRsAHIE4as2drhJgc/V9Xo4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714577871; c=relaxed/simple;
	bh=tOaXeYboyg42eCPqOMwORm62P596gWjbt6g51zfe0Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rusBVnOAJn7TLFZSmNP4+u9Z0wSPB+dUosIcldYNLzAzjCTGdHv0WtUMbab+BHBKq81yFWCZZTkdu/0nLGBMrLi1rFou78tborMkLr0HgDc15/tNf5I7LrD3kCDy2hb8WkJP8S6SW3eWwu0BkUSQmB0QP8EarSeCIS5PgbkJoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQRo45x6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D043C072AA;
	Wed,  1 May 2024 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714577871;
	bh=tOaXeYboyg42eCPqOMwORm62P596gWjbt6g51zfe0Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQRo45x6cv1XiZVauPVHrKv0tMy1MzUFsbyTNl1CZlAdqI42DWLtymOOv4AJvNvsa
	 PnbUiil5j3X15lAmFo/7elGuJcr2ajnhDlrJNvH9fGPavZMnj7yz1uaNbyiJXgzia1
	 B5SVlYxOXbBxyJFW2aoBftzdWN6dppGsVIZ6ffX2+Ymb2g/jrj0pjNHguV0KhvlvBy
	 uZjLYorjD+GfHoa4qBSYq5ZZULSjLrvOhhY98/8tCU+4/y4266k3m5qK3URa3WD8qn
	 2KMw5sn+yaQ3xFoHHMEdC7oNcAocEPYe7X7hyZKeIkjYKCQK4ZVyS7es7gYfjEILsL
	 3a7Bqp4ohEmUA==
Date: Wed, 1 May 2024 16:37:47 +0100
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: microchip: add pac1934 power-monitor to
 icicle
Message-ID: <20240501-throwing-squeegee-7c3697167309@spud>
References: <20240501-spearman-primary-17df3c21c770@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+MZcxOM3iSq3hzNf"
Content-Disposition: inline
In-Reply-To: <20240501-spearman-primary-17df3c21c770@spud>


--+MZcxOM3iSq3hzNf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 04:36:31PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> The binding for this landed in v6.9, add the description. In the
> off-chance that there were people carrying local patches for this based
> on the driver shipped on the Microchip website (or vendor kernel) both
> the binding and sysfs filenames changed during upstreaming.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: linux-riscv@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

I thought I send this out last week, but I could not find the patch on
either lore or patchwork when I went to apply it today, so I must not
have...

> ---
>  .../boot/dts/microchip/mpfs-icicle-kit.dts    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/ris=
cv/boot/dts/microchip/mpfs-icicle-kit.dts
> index 222a39d90f85..f80df225f72b 100644
> --- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
> @@ -100,6 +100,38 @@ &i2c0 {
> =20
>  &i2c1 {
>  	status =3D "okay";
> +
> +	power-monitor@10 {
> +		compatible =3D "microchip,pac1934";
> +		reg =3D <0x10>;
> +
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		channel@1 {
> +			reg =3D <0x1>;
> +			shunt-resistor-micro-ohms =3D <10000>;
> +			label =3D "VDDREG";
> +		};
> +
> +		channel@2 {
> +			reg =3D <0x2>;
> +			shunt-resistor-micro-ohms =3D <10000>;
> +			label =3D "VDDA25";
> +		};
> +
> +		channel@3 {
> +			reg =3D <0x3>;
> +			shunt-resistor-micro-ohms =3D <10000>;
> +			label =3D "VDD25";
> +		};
> +
> +		channel@4 {
> +			reg =3D <0x4>;
> +			shunt-resistor-micro-ohms =3D <10000>;
> +			label =3D "VDDA_REG";
> +		};
> +	};
>  };
> =20
>  &i2c2 {
> --=20
> 2.43.0
>=20

--+MZcxOM3iSq3hzNf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjJhywAKCRB4tDGHoIJi
0vfCAQDUQJl/9kA+o/1f2k4AfVeR23NVv5bpvBhPTJlsCaqglgD/UwU8NzXpVJ/v
GvE592tD3NfALiCT5CbMseoQWp0xugY=
=iZ82
-----END PGP SIGNATURE-----

--+MZcxOM3iSq3hzNf--

