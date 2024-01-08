Return-Path: <linux-kernel+bounces-19899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68914827667
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097A3B213B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3EF54BCA;
	Mon,  8 Jan 2024 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMTO9m5j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B86B54725;
	Mon,  8 Jan 2024 17:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C6BC433C7;
	Mon,  8 Jan 2024 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704735264;
	bh=WxF3mMEMLyJMj2C6OKuTs7PD9Vj4XTLWmmz+TPw4bh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMTO9m5jCUZETuKErYC+dV7OLZJ+YU4xfDxmzZiT58AzrzQQ9lIAx5+fwI7pfZFLv
	 qjZ4HVEJzOmsn6XaBD910G62BsXIy/BDmmbj2K8ic1r049YzHl3wggXHNqL/ghQcHE
	 7N7o97BvHDTIUyIVv77sZh+tusVjRUNIqf3hy967MLWxQr+O0OgGwzg0YbjowKS3VF
	 dTYMO5I3buWvcTk5GrQTQGD3JAwAehjIc3mFgy41AFSPdkdehALdnhCMex7BkSzvMs
	 OHC5W3Bq4MM0n0F/VnYEnDtwyF4BmhmJRxUaPzIWNe8S+56BZJwH5JBJS5pgGFa30U
	 KnM9gSl54vojQ==
Date: Mon, 8 Jan 2024 17:34:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Drew Fustini <dfustini@baylibre.com>
Subject: Re: [PATCH v2 3/8] riscv: dts: thead: Add TH1520 pin control nodes
Message-ID: <20240108-majorette-overtly-4ec65d0a15e9@spud>
References: <20240103132852.298964-1-emil.renner.berthing@canonical.com>
 <20240103132852.298964-4-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8Qj2RGfy2RprKGUu"
Content-Disposition: inline
In-Reply-To: <20240103132852.298964-4-emil.renner.berthing@canonical.com>


--8Qj2RGfy2RprKGUu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2024 at 02:28:40PM +0100, Emil Renner Berthing wrote:
> Add nodes for pin controllers on the T-Head TH1520 RISC-V SoC.
>=20
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
>  .../boot/dts/thead/th1520-beaglev-ahead.dts   |  4 ++++
>  .../dts/thead/th1520-lichee-module-4a.dtsi    |  4 ++++
>  arch/riscv/boot/dts/thead/th1520.dtsi         | 24 +++++++++++++++++++
>  3 files changed, 32 insertions(+)
>=20
> diff --git a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts b/arch/ri=
scv/boot/dts/thead/th1520-beaglev-ahead.dts
> index 70e8042c8304..6c56318a8705 100644
> --- a/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> +++ b/arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts
> @@ -44,6 +44,10 @@ &osc_32k {
>  	clock-frequency =3D <32768>;
>  };
> =20
> +&aonsys_clk {
> +	clock-frequency =3D <73728000>;
> +};
> +
>  &apb_clk {
>  	clock-frequency =3D <62500000>;
>  };
> diff --git a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi b/arc=
h/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> index a802ab110429..9865925be372 100644
> --- a/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520-lichee-module-4a.dtsi
> @@ -25,6 +25,10 @@ &osc_32k {
>  	clock-frequency =3D <32768>;
>  };
> =20
> +&aonsys_clk {
> +	clock-frequency =3D <73728000>;
> +};
> +
>  &apb_clk {
>  	clock-frequency =3D <62500000>;
>  };
> diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/=
thead/th1520.dtsi
> index ba4d2c673ac8..e65a306ff575 100644
> --- a/arch/riscv/boot/dts/thead/th1520.dtsi
> +++ b/arch/riscv/boot/dts/thead/th1520.dtsi
> @@ -134,6 +134,12 @@ osc_32k: 32k-oscillator {
>  		#clock-cells =3D <0>;
>  	};
> =20
> +	aonsys_clk: aonsys-clk {
> +		compatible =3D "fixed-clock";
> +		clock-output-names =3D "aonsys_clk";
> +		#clock-cells =3D <0>;
> +	};

Did this stuff sneak into this commit accidentally?

--8Qj2RGfy2RprKGUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZwyGgAKCRB4tDGHoIJi
0rwgAP97KBxIGWgOemMO6hdqRmD/8ZxeJ0E6JqevM07cpZ+KvgD/UbJ+65Y7gDdm
xrA0pClmQVdKxcDVsF7lpqNgBw4K4As=
=LWOW
-----END PGP SIGNATURE-----

--8Qj2RGfy2RprKGUu--

