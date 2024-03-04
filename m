Return-Path: <linux-kernel+bounces-90279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9C186FCD1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD152823BD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA491B95C;
	Mon,  4 Mar 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ZtaNkAYo"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AC31B7E8;
	Mon,  4 Mar 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543528; cv=none; b=s1SCJWP9+Hd5Abrq7y7wahz+xKpQwTi8WbSmMu6DbiqDmEptRgapeHqDUHu8wji7py0XlWHIhfOdvTfoRMlJFwrc3Q+HerVqNYKNQmKP+8JuibrNrUR4eU7LHOv3W8vN1WNGP9n6jpcQ3PVHn4WQDV8d/luPZbhJ+OvtDI1Y314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543528; c=relaxed/simple;
	bh=fC8sKkBs7GE4sHdOuIW0zqhWGl2e7aLtrNEvA/GFT88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQh3nm0qcnle0v+h3FlfZfrTB72eBsHby9Y2FgJ6u/cJfpo7wOj4i3PqfqvuHVjPkPYFXqGTVTgmuVWWelvnfFYJQet0j2djaO8hjnpvOdMHL0ZuUxgE4kK+WYaXO1823y7stsvgPvX1ao9YHOfe0hq3lX3PYrDKjDxZhysMd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ZtaNkAYo; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709543525; x=1741079525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nbX+hWAcORuUJGtFt2cByM1P4IXCj3Ob/hyO09aRE3k=;
  b=ZtaNkAYo/Fj6+BnffXAeVTgkpOoCWpKnovaYzq104KHpjHr4A+sNHZIR
   yEYLs/QoNyCOnE9/L+drGILrEBqdBHHjQB4iqC/bWLOmiJ3DAIa2E++Xe
   5e6ZRE6TAKMfHEHW2ErJNSwaJWmHH+Fs+EK/mmq9t5XFVxtxZLYH+Cn66
   NStWlfI9jpB8j8XoxmoTF+XB2iIk4BIXDjvV6StzU1mPkmLmMzRADz67O
   TtLsEbBDpcnr6alN8f2R+6iw5JMEYY8PtkAInA3GE4RpehXL/RzIe/o9F
   sHleNyg0j2VbY1Eg29iFwmEZu6QrZYk1VBnKfc9pDzVC0Y+j+DfkQ9xzu
   Q==;
X-IronPort-AV: E=Sophos;i="6.06,203,1705359600"; 
   d="scan'208";a="35711019"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Mar 2024 10:11:56 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 68946280071;
	Mon,  4 Mar 2024 10:11:56 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: imx8: add cm40 subsystem dtsi
Date: Mon, 04 Mar 2024 10:11:57 +0100
Message-ID: <5761273.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240302-m4_lpuart-v2-1-89a5952043b6@nxp.com>
References: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com> <20240302-m4_lpuart-v2-1-89a5952043b6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Frank,

thanks for the update.

Am Samstag, 2. M=E4rz 2024, 17:27:44 CET schrieb Frank Li:
> From: Dong Aisheng <aisheng.dong@nxp.com>
>=20
> Add cm40 subsystem dtsi.
>=20
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 67 +++++++++++++++++++=
++++++
>  arch/arm64/boot/dts/freescale/imx8dxl.dtsi      |  2 +
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |  1 +
>  3 files changed, 70 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi b/arch/arm64=
/boot/dts/freescale/imx8-ss-cm40.dtsi
> new file mode 100644
> index 0000000000000..68043ab74e765
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019 NXP
> + *	Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#include <dt-bindings/firmware/imx/rsrc.h>
> +
> +cm40_ipg_clk: clock-cm40-ipg {
> +	compatible =3D "fixed-clock";
> +	#clock-cells =3D <0>;
> +	clock-frequency =3D <132000000>;
> +	clock-output-names =3D "cm40_ipg_clk";
> +};
> +
> +cm40_subsys: bus@34000000 {
> +	compatible =3D "simple-bus";
> +	interrupt-parent =3D <&cm40_intmux>;

I would have put that below ranges, but it might be just personal preferenc=
e.

> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	ranges =3D <0x34000000 0x0 0x34000000 0x4000000>;
> +
> +	cm40_i2c: i2c@37230000 {
> +		compatible =3D "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> +		reg =3D <0x37230000 0x1000>;
> +		interrupts =3D <9 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&cm40_i2c_lpcg 0>,
> +			 <&cm40_i2c_lpcg 1>;
> +		clock-names =3D "per", "ipg";
> +		assigned-clocks =3D <&clk IMX_SC_R_M4_0_I2C IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		power-domains =3D <&pd IMX_SC_R_M4_0_I2C>;
> +		status =3D "disabled";
> +	};
> +
> +	cm40_intmux: intmux@37400000 {
> +		compatible =3D "fsl,imx-intmux";
> +		reg =3D <0x37400000 0x1000>;
> +		interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		interrupt-parent =3D <&gic>;

Please put this above interrupt property, you are mixing interrupt
properties of the device itself with interrupt-controller properties.

With these things addressed:
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> +		#interrupt-cells =3D <2>;
> +		clocks =3D <&cm40_ipg_clk>;
> +		clock-names =3D "ipg";
> +		power-domains =3D <&pd IMX_SC_R_M4_0_INTMUX>;
> +		status =3D "disabled";
> +	};
> +
> +	cm40_i2c_lpcg: clock-controller@37630000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x37630000 0x1000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_M4_0_I2C IMX_SC_PM_CLK_PER>,
> +			 <&cm40_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> +		clock-output-names =3D "cm40_lpcg_i2c_clk",
> +				     "cm40_lpcg_i2c_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_M4_0_I2C>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi b/arch/arm64/boot=
/dts/freescale/imx8dxl.dtsi
> index a0674c5c55766..9d49c75a26222 100644
> --- a/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl.dtsi
> @@ -5,6 +5,7 @@
> =20
>  #include <dt-bindings/clock/imx8-clock.h>
>  #include <dt-bindings/dma/fsl-edma.h>
> +#include <dt-bindings/clock/imx8-lpcg.h>
>  #include <dt-bindings/firmware/imx/rsrc.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -231,6 +232,7 @@ xtal24m: clock-xtal24m {
>  	};
> =20
>  	/* sorted in register address */
> +	#include "imx8-ss-cm40.dtsi"
>  	#include "imx8-ss-adma.dtsi"
>  	#include "imx8-ss-conn.dtsi"
>  	#include "imx8-ss-ddr.dtsi"
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot=
/dts/freescale/imx8qxp.dtsi
> index 10e16d84c0c3b..0313f295de2e9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -317,6 +317,7 @@ map0 {
>  	/* sorted in register address */
>  	#include "imx8-ss-img.dtsi"
>  	#include "imx8-ss-vpu.dtsi"
> +	#include "imx8-ss-cm40.dtsi"
>  	#include "imx8-ss-gpu0.dtsi"
>  	#include "imx8-ss-adma.dtsi"
>  	#include "imx8-ss-conn.dtsi"
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



