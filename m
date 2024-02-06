Return-Path: <linux-kernel+bounces-55546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC8C84BDF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BAF1F2608E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886E1400B;
	Tue,  6 Feb 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUWRdJmm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A131426D;
	Tue,  6 Feb 2024 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246833; cv=none; b=PTYPy6/l3YgrJHpsRIYA0KfYWtIw3T7Wf4wMZjlM//E281OhAQaRV0sI3pGpkWmxhGY98YK3r9jugkXSgWXXWnLghvZDK+n9TSDMpkXJATE1GTggE/ShxW/Edjf7kRY2dti0rq15vnx4cX/PsLGp+qZhrZk1O8JSwTblks2+JcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246833; c=relaxed/simple;
	bh=onwe4EzjWJV+cq1TR1U2XS4PSciWcSYm51R+cgATKxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZYq3KeCV/G5mjbjWvBV5eAMGtWKx1koGgUSG5bF7gP3MvxlyLYhbTDyLn8gwpSQiZqCu5hRfwhSqXaQtcMoiNDWpAGWsz3n3yliURyQilTUWMVUFe4PfOGLfoTMlnBEebzGZfw1SA+gJU4z54WO6HJYMX1qp7emDNpdfZqjtFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUWRdJmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D86C433F1;
	Tue,  6 Feb 2024 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707246832;
	bh=onwe4EzjWJV+cq1TR1U2XS4PSciWcSYm51R+cgATKxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TUWRdJmmfYpoyDOvdrd19ja8t7fKgOAj477iqglAG8qNGVb3DNwkiqddTE6igRcX8
	 Go5y8kCEfPDR4/NHIFaWiBp9SVsbraKYg7m+ki0kwm0q0obx/JveYBH8D2vJMlNX+z
	 u4rJE5FeiS/UZxtilQApCp21T+0yZVKTy8n3QO9sQuQ3iwl0cVbgx552D6ZnXjOKTL
	 a9NL9AIftcriyaLGI5Kl5+fZuVTlgi0nGKx1jNAGBDWHYQ7CE0RGWZ+u2lP1kfYFgy
	 hblUlPwsiBPh3kEcS8XRcjH7NJlyyqnw7TsS5EPZJAkJWnUYPUvoA5OeC3xS65cm54
	 0jAdstILGEYZg==
Date: Tue, 6 Feb 2024 19:13:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <kernel@esmil.dk>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: add Milkv Mars board device
 tree
Message-ID: <20240206-magma-deem-2c88e45a545a@spud>
References: <20240131132600.4067-1-jszhang@kernel.org>
 <20240131132600.4067-7-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H4mv7uwP1RXcpRTP"
Content-Disposition: inline
In-Reply-To: <20240131132600.4067-7-jszhang@kernel.org>


--H4mv7uwP1RXcpRTP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 09:26:00PM +0800, Jisheng Zhang wrote:
> The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> The board features:
>=20
> - JH7110 SoC
> - 1/2/4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 3x USB 3.0 host port
> - 1x USB 2.0 host port
> - 1x M.2 E-Key
> - 1x eMMC slot
> - 1x MicroSD slot
> - 1x QSPI Flash
> - 1x 1Gbps Ethernet port
> - 1x HDMI port
> - 1x 2-lane DSI and 1x 4-lane DSI
> - 1x 2-lane CSI
>=20
> Add the devicetree file describing the currently supported features,
> namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Got a dtbs_check issue in the patchwork CI:

  +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rgmii-rxin-clo=
ck: 'clock-frequency' is a required property
  +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
  +arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dtb: gmac1-rmii-refin-clo=
ck: 'clock-frequency' is a required property
  +	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#

Can you fix that please? Also, I applied some patches the other day that
seem to conflict quite a bit with the common board dts patch. Would you
please do a rebase on top of that please?

Cheers,
Conor.

> ---
>  arch/riscv/boot/dts/starfive/Makefile         |  1 +
>  .../boot/dts/starfive/jh7110-milkv-mars.dts   | 35 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
>=20
> diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/=
starfive/Makefile
> index 0141504c0f5c..2fa0cd7f31c3 100644
> --- a/arch/riscv/boot/dts/starfive/Makefile
> +++ b/arch/riscv/boot/dts/starfive/Makefile
> @@ -8,5 +8,6 @@ DTC_FLAGS_jh7110-starfive-visionfive-2-v1.3b :=3D -@
>  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7100-beaglev-starlight.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7100-starfive-visionfive-v1.dtb
> =20
> +dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-milkv-mars.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.2a.dtb
>  dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.3b.dtb
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/ri=
scv/boot/dts/starfive/jh7110-milkv-mars.dts
> new file mode 100644
> index 000000000000..de600e799e7d
> --- /dev/null
> +++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +/dts-v1/;
> +#include "jh7110-visionfive2-mars-common.dtsi"
> +
> +/ {
> +	model =3D "Milk-V Mars";
> +	compatible =3D "milkv,mars", "starfive,jh7110";
> +};
> +
> +&gmac0 {
> +	starfive,tx-use-rgmii-clk;
> +	assigned-clocks =3D <&aoncrg JH7110_AONCLK_GMAC0_TX>;
> +	assigned-clock-parents =3D <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
> +};
> +
> +
> +&phy0 {
> +	motorcomm,tx-clk-adj-enabled;
> +	motorcomm,tx-clk-10-inverted;
> +	motorcomm,tx-clk-100-inverted;
> +	motorcomm,tx-clk-1000-inverted;
> +	motorcomm,rx-clk-drv-microamp =3D <3970>;
> +	motorcomm,rx-data-drv-microamp =3D <2910>;
> +	rx-internal-delay-ps =3D <1500>;
> +	tx-internal-delay-ps =3D <1500>;
> +};
> +
> +&mmc1 {
> +	disable-wp;
> +	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +};
> --=20
> 2.43.0
>=20

--H4mv7uwP1RXcpRTP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcKE7AAKCRB4tDGHoIJi
0ozhAQC7TY7fFtI+7Cw4EcbHg3iXLfPgEJADK1Liq8mObgwtEgD9G0Z1TigpDQda
rA37daVrT5yyYKio+Rl1uMG5ig+GVA4=
=5e08
-----END PGP SIGNATURE-----

--H4mv7uwP1RXcpRTP--

