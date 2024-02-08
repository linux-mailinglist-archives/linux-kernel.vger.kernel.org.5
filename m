Return-Path: <linux-kernel+bounces-58513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3804D84E766
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91692B287B2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D58A82874;
	Thu,  8 Feb 2024 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5RpU4VI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F45823D3;
	Thu,  8 Feb 2024 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415566; cv=none; b=Cbxu/XVMTogNoW2k3h2LsfT44ATGe0f7mSMXDn5dGpqz9gNn6hffrLjzvDKxh7Dm7mhbsP9iSq8gYCbS5Jm+oJGJN/5e9GCIRvzaPT0FXN8d3Sguge0H53LyVppAPzhsPYaEshr52giSTiKIZbLNu+10IY7n2mrdow46Djol5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415566; c=relaxed/simple;
	bh=hqvkF9dnNpRgCDeLYkAneJkPZsqq7JqWBH72hn0ndQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KExaPkSqkeVRFMeR+/q6LM2wVu95B1U7Om09QxRPvXIK8aPsq/dI0TFi8QZwwruj6+efBgThQoyB6kozBHT1Kb45+tjxvksmK2eWhfIGtKKQAAh4j+4xDb74ER5T6F9iN9yjsc1UOQ5wARDgsDe5lIuR6f3locnDDi9gto70Pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5RpU4VI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AC0C433C7;
	Thu,  8 Feb 2024 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707415565;
	bh=hqvkF9dnNpRgCDeLYkAneJkPZsqq7JqWBH72hn0ndQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5RpU4VIumk997ngWQcXBdRXQf2W0sgEXtilvYS8L+EjP8OSbkqZn37z48ETEUT+b
	 g3XH96nE0oqPkVkG9hA2u58AQF1hwrQ/tObDkmw/kohAigr8xxy7WAqe9iOG3mBm6j
	 M0H6MleRugwRMsfuDo0xIS4oIZM365DGkaxEA+f/KGI0RNQqHQYx3PvckJdwQsrP5S
	 PIpbPgXeaqG1Np8xVHc2stGW4VcIVtebUMTJIGPv8AJQ99C4A0a2hcLkctrLysn7yp
	 WiLH6f16vWWR+cekcV7jRNtlOCgx6SaFMv+/a1L/qNJoGb5AOb9cvWIHKYykVJVRET
	 y6qPr7k2VpWIw==
Date: Thu, 8 Feb 2024 18:06:00 +0000
From: Conor Dooley <conor@kernel.org>
To: gabriel.fernandez@foss.st.com
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/4] dt-bindings: stm32: update DT bingding for
 stm32mp25
Message-ID: <20240208-syndrome-storeroom-5cc8bdd07c05@spud>
References: <20240208142301.155698-1-gabriel.fernandez@foss.st.com>
 <20240208142301.155698-3-gabriel.fernandez@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U+b4zsPBBef9S2kx"
Content-Disposition: inline
In-Reply-To: <20240208142301.155698-3-gabriel.fernandez@foss.st.com>


--U+b4zsPBBef9S2kx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 03:22:59PM +0100, gabriel.fernandez@foss.st.com wro=
te:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> Now RCC driver use '.index' of clk_parent_data struct to define a parent.

The RCC driver in linux might have stopped using the names, but they
were a required property that could be replied upon by other software
too. Have you checked U-Boot or *BSD etc to make sure clock-names are
not used there?

Thanks,
Conor.

> The majority of parents are SCMI clocks, then dt-bindings must be fixed.
>=20
> Fixes: b5be49db3d47 ("dt-bindings: stm32: add clocks and reset binding fo=
r stm32mp25 platform")
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>  .../bindings/clock/st,stm32mp25-rcc.yaml      | 171 ++++++++++++++++--
>  1 file changed, 155 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yam=
l b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
> index 7732e79a42b9..57bd4e7157bd 100644
> --- a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
> @@ -38,22 +38,87 @@ properties:
>        - description: CK_SCMI_MSI Low Power Internal oscillator (~ 4 MHz =
or ~ 16 MHz)
>        - description: CK_SCMI_LSE Low Speed External oscillator (32 KHz)
>        - description: CK_SCMI_LSI Low Speed Internal oscillator (~ 32 KHz)
> -
> -  clock-names:
> -    items:
> -      - const: hse
> -      - const: hsi
> -      - const: msi
> -      - const: lse
> -      - const: lsi
> -
> +      - description: CK_SCMI_HSE_DIV2 CK_SCMI_HSE divided by 2 (coud be =
gated)
> +      - description: CK_SCMI_ICN_HS_MCU High Speed interconnect bus clock
> +      - description: CK_SCMI_ICN_LS_MCU Low Speed interconnect bus clock
> +      - description: CK_SCMI_ICN_SDMMC SDMMC interconnect bus clock
> +      - description: CK_SCMI_ICN_DDR DDR interconnect bus clock
> +      - description: CK_SCMI_ICN_DISPLAY Display interconnect bus clock
> +      - description: CK_SCMI_ICN_HSL HSL interconnect bus clock
> +      - description: CK_SCMI_ICN_NIC NIC interconnect bus clock
> +      - description: CK_SCMI_ICN_VID Video interconnect bus clock
> +      - description: CK_SCMI_FLEXGEN_07 flexgen clock 7
> +      - description: CK_SCMI_FLEXGEN_08 flexgen clock 8
> +      - description: CK_SCMI_FLEXGEN_09 flexgen clock 9
> +      - description: CK_SCMI_FLEXGEN_10 flexgen clock 10
> +      - description: CK_SCMI_FLEXGEN_11 flexgen clock 11
> +      - description: CK_SCMI_FLEXGEN_12 flexgen clock 12
> +      - description: CK_SCMI_FLEXGEN_13 flexgen clock 13
> +      - description: CK_SCMI_FLEXGEN_14 flexgen clock 14
> +      - description: CK_SCMI_FLEXGEN_15 flexgen clock 15
> +      - description: CK_SCMI_FLEXGEN_16 flexgen clock 16
> +      - description: CK_SCMI_FLEXGEN_17 flexgen clock 17
> +      - description: CK_SCMI_FLEXGEN_18 flexgen clock 18
> +      - description: CK_SCMI_FLEXGEN_19 flexgen clock 19
> +      - description: CK_SCMI_FLEXGEN_20 flexgen clock 20
> +      - description: CK_SCMI_FLEXGEN_21 flexgen clock 21
> +      - description: CK_SCMI_FLEXGEN_22 flexgen clock 22
> +      - description: CK_SCMI_FLEXGEN_23 flexgen clock 23
> +      - description: CK_SCMI_FLEXGEN_24 flexgen clock 24
> +      - description: CK_SCMI_FLEXGEN_25 flexgen clock 25
> +      - description: CK_SCMI_FLEXGEN_26 flexgen clock 26
> +      - description: CK_SCMI_FLEXGEN_27 flexgen clock 27
> +      - description: CK_SCMI_FLEXGEN_28 flexgen clock 28
> +      - description: CK_SCMI_FLEXGEN_29 flexgen clock 29
> +      - description: CK_SCMI_FLEXGEN_30 flexgen clock 30
> +      - description: CK_SCMI_FLEXGEN_31 flexgen clock 31
> +      - description: CK_SCMI_FLEXGEN_32 flexgen clock 32
> +      - description: CK_SCMI_FLEXGEN_33 flexgen clock 33
> +      - description: CK_SCMI_FLEXGEN_34 flexgen clock 34
> +      - description: CK_SCMI_FLEXGEN_35 flexgen clock 35
> +      - description: CK_SCMI_FLEXGEN_36 flexgen clock 36
> +      - description: CK_SCMI_FLEXGEN_37 flexgen clock 37
> +      - description: CK_SCMI_FLEXGEN_38 flexgen clock 38
> +      - description: CK_SCMI_FLEXGEN_39 flexgen clock 39
> +      - description: CK_SCMI_FLEXGEN_40 flexgen clock 40
> +      - description: CK_SCMI_FLEXGEN_41 flexgen clock 41
> +      - description: CK_SCMI_FLEXGEN_42 flexgen clock 42
> +      - description: CK_SCMI_FLEXGEN_43 flexgen clock 43
> +      - description: CK_SCMI_FLEXGEN_44 flexgen clock 44
> +      - description: CK_SCMI_FLEXGEN_45 flexgen clock 45
> +      - description: CK_SCMI_FLEXGEN_46 flexgen clock 46
> +      - description: CK_SCMI_FLEXGEN_47 flexgen clock 47
> +      - description: CK_SCMI_FLEXGEN_48 flexgen clock 48
> +      - description: CK_SCMI_FLEXGEN_49 flexgen clock 49
> +      - description: CK_SCMI_FLEXGEN_50 flexgen clock 50
> +      - description: CK_SCMI_FLEXGEN_51 flexgen clock 51
> +      - description: CK_SCMI_FLEXGEN_52 flexgen clock 52
> +      - description: CK_SCMI_FLEXGEN_53 flexgen clock 53
> +      - description: CK_SCMI_FLEXGEN_54 flexgen clock 54
> +      - description: CK_SCMI_FLEXGEN_55 flexgen clock 55
> +      - description: CK_SCMI_FLEXGEN_56 flexgen clock 56
> +      - description: CK_SCMI_FLEXGEN_57 flexgen clock 57
> +      - description: CK_SCMI_FLEXGEN_58 flexgen clock 58
> +      - description: CK_SCMI_FLEXGEN_59 flexgen clock 59
> +      - description: CK_SCMI_FLEXGEN_60 flexgen clock 60
> +      - description: CK_SCMI_FLEXGEN_61 flexgen clock 61
> +      - description: CK_SCMI_FLEXGEN_62 flexgen clock 62
> +      - description: CK_SCMI_FLEXGEN_63 flexgen clock 63
> +      - description: CK_SCMI_ICN_APB1 Peripheral bridge 1
> +      - description: CK_SCMI_ICN_APB2 Peripheral bridge 2
> +      - description: CK_SCMI_ICN_APB3 Peripheral bridge 3
> +      - description: CK_SCMI_ICN_APB4 Peripheral bridge 4
> +      - description: CK_SCMI_ICN_APBDBG Peripheral bridge for degub
> +      - description: CK_SCMI_TIMG1 Peripheral bridge for timer1
> +      - description: CK_SCMI_TIMG2 Peripheral bridge for timer2
> +      - description: CK_SCMI_PLL3 PLL3 clock
> +      - description: clk_dsi_txbyte DSI byte clock
>  required:
>    - compatible
>    - reg
>    - '#clock-cells'
>    - '#reset-cells'
>    - clocks
> -  - clock-names
> =20
>  additionalProperties: false
> =20
> @@ -66,11 +131,85 @@ examples:
>          reg =3D <0x44200000 0x10000>;
>          #clock-cells =3D <1>;
>          #reset-cells =3D <1>;
> -        clock-names =3D "hse", "hsi", "msi", "lse", "lsi";
> -        clocks =3D <&scmi_clk CK_SCMI_HSE>,
> -                 <&scmi_clk CK_SCMI_HSI>,
> -                 <&scmi_clk CK_SCMI_MSI>,
> -                 <&scmi_clk CK_SCMI_LSE>,
> -                 <&scmi_clk CK_SCMI_LSI>;
> +        clocks =3D  <&scmi_clk CK_SCMI_HSE>,
> +                  <&scmi_clk CK_SCMI_HSI>,
> +                  <&scmi_clk CK_SCMI_MSI>,
> +                  <&scmi_clk CK_SCMI_LSE>,
> +                  <&scmi_clk CK_SCMI_LSI>,
> +                  <&scmi_clk CK_SCMI_HSE_DIV2>,
> +                  <&scmi_clk CK_SCMI_ICN_HS_MCU>,
> +                  <&scmi_clk CK_SCMI_ICN_LS_MCU>,
> +                  <&scmi_clk CK_SCMI_ICN_SDMMC>,
> +                  <&scmi_clk CK_SCMI_ICN_DDR>,
> +                  <&scmi_clk CK_SCMI_ICN_DISPLAY>,
> +                  <&scmi_clk CK_SCMI_ICN_HSL>,
> +                  <&scmi_clk CK_SCMI_ICN_NIC>,
> +                  <&scmi_clk CK_SCMI_ICN_VID>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_07>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_08>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_09>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_10>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_11>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_12>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_13>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_14>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_15>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_16>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_17>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_18>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_19>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_20>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_21>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_22>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_23>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_24>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_25>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_26>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_27>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_28>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_29>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_30>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_31>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_32>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_33>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_34>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_35>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_36>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_37>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_38>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_39>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_40>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_41>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_42>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_43>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_44>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_45>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_46>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_47>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_48>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_49>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_50>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_51>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_52>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_53>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_54>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_55>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_56>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_57>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_58>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_59>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_60>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_61>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_62>,
> +                  <&scmi_clk CK_SCMI_FLEXGEN_63>,
> +                  <&scmi_clk CK_SCMI_ICN_APB1>,
> +                  <&scmi_clk CK_SCMI_ICN_APB2>,
> +                  <&scmi_clk CK_SCMI_ICN_APB3>,
> +                  <&scmi_clk CK_SCMI_ICN_APB4>,
> +                  <&scmi_clk CK_SCMI_ICN_APBDBG>,
> +                  <&scmi_clk CK_SCMI_TIMG1>,
> +                  <&scmi_clk CK_SCMI_TIMG2>,
> +                  <&scmi_clk CK_SCMI_PLL3>,
> +                  <&clk_dsi_txbyte>;
>      };
>  ...
> --=20
> 2.25.1
>=20

--U+b4zsPBBef9S2kx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUYCAAKCRB4tDGHoIJi
0jxCAP9qu/D5/Sbp4Pdur4cH60nHjyr3QhngzLE+0p8NlhkbAAD+IrVdM8YcTxZq
x1gA9Qobs28ERv9BQYUsnqSKq9Qkxg0=
=zDJz
-----END PGP SIGNATURE-----

--U+b4zsPBBef9S2kx--

