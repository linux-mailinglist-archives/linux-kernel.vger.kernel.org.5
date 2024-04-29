Return-Path: <linux-kernel+bounces-161887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC9A8B52B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA30D281FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB14415E8B;
	Mon, 29 Apr 2024 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="azjBFXk8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Fyhcyrgz"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C570134BF;
	Mon, 29 Apr 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377455; cv=none; b=VpkHBE++eCv4fhMzgHt2jsaaCbndL9MpyHeeRSlbqLn9vpGe5I8Mo0LsggNO8xtvUQtT9XzRj7zfR6TQu/cGPNoMbVPCHWLyTWiaNuhs7SLnrZKv2iCZIk69D0N3l55CJbtyLsy13BJ3vbAQSGPPzy+MoF4aKaUOOrbYrzxx0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377455; c=relaxed/simple;
	bh=2Csj8vQ/o5Y1whqdjjnOMA73pdiy08ZXUx5FipTRmFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWau/GdsiV+wDQUWO/bcWq4Q1rSiion+fPawfyeDRN7ce0KG7mmoUPLhzwfjZqG3HG8nyIZpNqj32gsa+sD7oOdvmfmtd/Zkd1anmIjKwvpJHbRyRwmnQY52FK7mGzMA7FSfuMp8tsBXYbUp9xpq6VN0OzDqDXLwRt9jaGoSN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=azjBFXk8; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Fyhcyrgz reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714377451; x=1745913451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cNyy9Xymu93IargWw+Ntbl8DtdzKzOcj+rUjWJe0nlQ=;
  b=azjBFXk8ZHtMw48Sym05889JHh7WINh/a9BL+2fzTfmoW4G8HdUmaaHg
   vcIztRROXXqBUh4As6mN2jsU/f2ddHDhtXxeLQzf1ciOIc6i1U91/Lsb4
   zgc22aGAmt388drXDLq2tci2e+g461nA8QxlKGHGMm63yfCsABTpx5lGO
   S2Olr+6FpmhuD+kPiOVr4drhNQtghT/qWtMcwY2ogLSPaMQBxLNGLeB0I
   PQEqpDbidrazoJRBNzY/bFq3+i3xToFH937FLZYBcAXorXHPOJKCJYDzp
   E5vJImr5PO8yYcbI3OVFUMLvZnl6jVUXKZ5aHgluiAhn1gF5sJue3YNwL
   g==;
X-IronPort-AV: E=Sophos;i="6.07,239,1708383600"; 
   d="scan'208";a="36654817"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 Apr 2024 09:57:22 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 20C7F171759;
	Mon, 29 Apr 2024 09:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714377437;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cNyy9Xymu93IargWw+Ntbl8DtdzKzOcj+rUjWJe0nlQ=;
	b=FyhcyrgzvLH2lHCSx6khA5nJs/WJ6VIeeagdCSezB/6khMJtodYoA+f+xSiy2KpCxzx19Z
	SDCK2gzWgGQxoevkCZmPKtQAb0Ii5+8tBaPHEY3h6+ldsvvIjJdGUbyHOm0hkKkd9GwBQ1
	0CIiAuQ9F4cyX6U2BRvef9jxTXBQg3Y8MD59VnG7XDg/TH8sNY1fa40Q5HbUQiWzD6h/N1
	aG/Bar4hUXTf7RtHYiW+Zt6c+6Gh3Y+AuRm1U0G6M8H9kw0O5chBJQKtkDnOYYCttW+PJZ
	E6xYxeVIA8Qvhbv1aGm6dwAsHs89WOWlKK7s20MptRNOdmTomykLaCyTUQXOjQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: freescale: add i.MX95 basic dtsi
Date: Mon, 29 Apr 2024 09:57:19 +0200
Message-ID: <4938664.31r3eYUQgx@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240428-imx95-dts-v3-v3-2-765395f88b9f@nxp.com>
References: <20240428-imx95-dts-v3-v3-0-765395f88b9f@nxp.com> <20240428-imx95-dts-v3-v3-2-765395f88b9f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Peng,

thanks for your patch.

Am Sonntag, 28. April 2024, 14:22:20 CEST schrieb Peng Fan (OSS):
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX95 features 6 A55 Cores, ARM Mali GPU, ISP, ML acceleration NPU,
> and Edgelock secure enclave security. This patch is to add a minimal
> dtsi, with cpu cores, coresight, scmi, gic, uart, mu, sdhc, lpi2c added.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-clock.h |  187 +++++
>  arch/arm64/boot/dts/freescale/imx95-power.h |   55 ++
>  arch/arm64/boot/dts/freescale/imx95.dtsi    | 1152 +++++++++++++++++++++=
++++++
>  3 files changed, 1394 insertions(+)
>=20
> [snip]
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/d=
ts/freescale/imx95.dtsi
> new file mode 100644
> index 000000000000..f52023ec7f0c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> [snip]
> +	soc {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +
> +		aips2: bus@42000000 {
> +			compatible =3D "fsl,aips-bus", "simple-bus";
> +			reg =3D <0x0 0x42000000 0x0 0x800000>;
> +			ranges =3D <0x42000000 0x0 0x42000000 0x8000000>,
> +				 <0x28000000 0x0 0x28000000 0x10000000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			mu7: mailbox@42430000 {
> +				compatible =3D "fsl,imx95-mu";
> +				reg =3D <0x42430000 0x10000>;
> +				interrupts =3D <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				#mbox-cells =3D <2>;
> +				status =3D "disabled";
> +			};
> +
> +			mu8: mailbox@42730000 {

Please sort all nodes by address.

> +				compatible =3D "fsl,imx95-mu";
> +				reg =3D <0x42730000 0x10000>;
> +				interrupts =3D <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				#mbox-cells =3D <2>;
> +				status =3D "disabled";
> +			};
> +
> +			wdog3: watchdog@42490000 {
> +				compatible =3D "fsl,imx93-wdt";
> +				reg =3D <0x42490000 0x10000>;
> +				interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				timeout-sec =3D <40>;
> +				fsl,ext-reset-output;

Isn't this board specific?

> +				status =3D "disabled";
> +			};
> +
> +			tpm3: pwm@424e0000 {
> +				compatible =3D "fsl,imx7ulp-pwm";
> +				reg =3D <0x424e0000 0x1000>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +				#pwm-cells =3D <3>;
> +				status =3D "disabled";
> +			};
> [snip]
> +		};
> +
> +		aips3: bus@42800000 {
> +			compatible =3D "fsl,aips-bus", "simple-bus";
> +			reg =3D <0 0x42800000 0 0x800000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges =3D <0x42800000 0x0 0x42800000 0x800000>;
> +
> +			usdhc1: mmc@42850000 {
> +				compatible =3D "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
> +				reg =3D <0x42850000 0x10000>;
> +				interrupts =3D <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +					 <&scmi_clk IMX95_CLK_WAKEUPAXI>,
> +					 <&scmi_clk IMX95_CLK_USDHC1>;
> +				clock-names =3D "ipg", "ahb", "per";
> +				assigned-clocks =3D <&scmi_clk IMX95_CLK_USDHC1>;
> +				assigned-clock-parents =3D <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
> +				assigned-clock-rates =3D <400000000>;
> +				bus-width =3D <8>;
> +				fsl,tuning-start-tap =3D <1>;
> +				fsl,tuning-step=3D <2>;

Isn't this board specific? Or is there a hardware limitation?

> +				status =3D "disabled";
> +			};
> +
> +			usdhc2: mmc@42860000 {
> +				compatible =3D "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
> +				reg =3D <0x42860000 0x10000>;
> +				interrupts =3D <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +					 <&scmi_clk IMX95_CLK_WAKEUPAXI>,
> +					 <&scmi_clk IMX95_CLK_USDHC2>;
> +				clock-names =3D "ipg", "ahb", "per";
> +				assigned-clocks =3D <&scmi_clk IMX95_CLK_USDHC2>;
> +				assigned-clock-parents =3D <&scmi_clk IMX95_CLK_SYSPLL1_PFD1>;
> +				assigned-clock-rates =3D <200000000>;

Why is usdhc2 only 200 MHz but usdhc1 400 MHz?

> +				bus-width =3D <4>;
> +				fsl,tuning-start-tap =3D <1>;
> +				fsl,tuning-step=3D <2>;

Isn't this board specific? Or is there a hardware limitation?

> +				status =3D "disabled";
> +			};
> +
> +			usdhc3: mmc@428b0000 {
> +				compatible =3D "fsl,imx95-usdhc", "fsl,imx8mm-usdhc";
> +				reg =3D <0x428b0000 0x10000>;
> +				interrupts =3D <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +					 <&scmi_clk IMX95_CLK_WAKEUPAXI>,
> +					 <&scmi_clk IMX95_CLK_USDHC3>;
> +				clock-names =3D "ipg", "ahb", "per";

No need to configure IMX95_CLK_USDHC3?

> +				bus-width =3D <4>;
> +				fsl,tuning-start-tap =3D <1>;
> +				fsl,tuning-step=3D <2>;
> +				status =3D "disabled";
> +			};
> +		};
> +
> +		gpio2: gpio@43810000 {
> +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg =3D <0x0 0x43810000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +			interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +			clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +			clock-names =3D "gpio", "port";
> +		};
> +
> +		gpio3: gpio@43820000 {
> +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg =3D <0x0 0x43820000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +			interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +			clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +			clock-names =3D "gpio", "port";
> +		};
> +
> +		gpio4: gpio@43840000 {
> +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg =3D <0x0 0x43840000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +			interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +			clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +			clock-names =3D "gpio", "port";
> +		};
> +
> +		gpio5: gpio@43850000 {
> +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg =3D <0x0 0x43850000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +			interrupts =3D <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +			clocks =3D <&scmi_clk IMX95_CLK_BUSWAKEUP>,
> +				 <&scmi_clk IMX95_CLK_BUSWAKEUP>;
> +			clock-names =3D "gpio", "port";
> +		};
> +
> +		aips1: bus@44000000 {
> +			compatible =3D "fsl,aips-bus", "simple-bus";
> +			reg =3D <0x0 0x44000000 0x0 0x800000>;
> +			ranges =3D <0x44000000 0x0 0x44000000 0x800000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			mu1: mailbox@44220000 {
> +				compatible =3D "fsl,imx95-mu";
> +				reg =3D <0x44220000 0x10000>;
> +				interrupts =3D <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> +				#mbox-cells =3D <2>;
> +				status =3D "disabled";
> +			};
> +
> +			mu2: mailbox@445b0000 {
> +				compatible =3D "fsl,imx95-mu";
> +				reg =3D <0x445b0000 0x1000>;
> +				ranges;
> +				interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				#mbox-cells =3D <2>;
> +
> +				sram0: sram@445b1000 {
> +					compatible =3D "mmio-sram";
> +					reg =3D <0x445b1000 0x400>;
> +					ranges =3D <0x0 0x445b1000 0x400>;
> +					#address-cells =3D <1>;
> +					#size-cells =3D <1>;
> +
> +					scmi_buf0: scmi-sram-section@0 {
> +						compatible =3D "arm,scmi-shmem";
> +						reg =3D <0x0 0x80>;
> +					};
> +
> +					scmi_buf1: scmi-sram-section@80 {
> +						compatible =3D "arm,scmi-shmem";
> +						reg =3D <0x80 0x80>;
> +					};
> +				};

I guess this MU depends on the system manager firmware, no?

> +			};
> +
> +			mu3: mailbox@445d0000 {
> +				compatible =3D "fsl,imx95-mu";
> +				reg =3D <0x445d0000 0x10000>;
> +				interrupts =3D <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> +				#mbox-cells =3D <2>;
> +				status =3D "disabled";
> +			};
> +
> +			mu4: mailbox@445f0000 {
> +				compatible =3D "fsl,imx95-mu";
> +				reg =3D <0x445f0000 0x10000>;
> +				interrupts =3D <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> +				#mbox-cells =3D <2>;
> +				status =3D "disabled";
> +			};
> +
> +			mu6: mailbox@44630000 {
> +				compatible =3D "fsl,imx95-mu";
> +				reg =3D <0x44630000 0x10000>;
> +				interrupts =3D <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> +				#mbox-cells =3D <2>;
> +				status =3D "disabled";
> +			};
> +
> +			tpm1: pwm@44310000 {
> +				compatible =3D "fsl,imx7ulp-pwm";
> +				reg =3D <0x44310000 0x1000>;
> +				clocks =3D <&scmi_clk IMX95_CLK_BUSAON>;
> +				#pwm-cells =3D <3>;
> +				status =3D "disabled";
> +			};
> +
> +			tpm2: pwm@44320000 {
> +				compatible =3D "fsl,imx7ulp-pwm";
> +				reg =3D <0x44320000 0x1000>;
> +				clocks =3D <&scmi_clk IMX95_CLK_TPM2>;
> +				#pwm-cells =3D <3>;
> +				status =3D "disabled";
> +			};
> +
> +			lpi2c1: i2c@44340000 {
> +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg =3D <0x44340000 0x10000>;
> +				interrupts =3D <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C1>,
> +					 <&scmi_clk IMX95_CLK_BUSAON>;
> +				clock-names =3D "per", "ipg";
> +				status =3D "disabled";
> +			};
> +
> +			lpi2c2: i2c@44350000 {
> +				compatible =3D "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
> +				reg =3D <0x44350000 0x10000>;
> +				interrupts =3D <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_LPI2C2>,
> +					 <&scmi_clk IMX95_CLK_BUSAON>;
> +				clock-names =3D "per", "ipg";
> +				status =3D "disabled";
> +			};
> +
> +			lpspi1: spi@44360000 {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg =3D <0x44360000 0x10000>;
> +				interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI1>,
> +					 <&scmi_clk IMX95_CLK_BUSAON>;
> +				clock-names =3D "per", "ipg";
> +				status =3D "disabled";
> +			};
> +
> +			lpspi2: spi@44370000 {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <0>;
> +				compatible =3D "fsl,imx95-spi", "fsl,imx7ulp-spi";
> +				reg =3D <0x44370000 0x10000>;
> +				interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_LPSPI2>,
> +					 <&scmi_clk IMX95_CLK_BUSAON>;
> +				clock-names =3D "per", "ipg";
> +				status =3D "disabled";
> +			};
> +
> +			lpuart1: serial@44380000 {
> +				compatible =3D "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg =3D <0x44380000 0x1000>;
> +				interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_LPUART1>;
> +				clock-names =3D "ipg";
> +				status =3D "disabled";
> +			};
> +
> +			lpuart2: serial@44390000 {
> +				compatible =3D "fsl,imx95-lpuart", "fsl,imx8ulp-lpuart",
> +					     "fsl,imx7ulp-lpuart";
> +				reg =3D <0x44390000 0x1000>;
> +				interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_LPUART2>;
> +				clock-names =3D "ipg";
> +				status =3D "disabled";
> +			};
> +
> +			adc1: adc@44530000 {
> +				compatible =3D "nxp,imx93-adc";
> +				reg =3D <0x44530000 0x10000>;
> +				interrupts =3D <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&scmi_clk IMX95_CLK_ADC>;
> +				clock-names =3D "ipg";
> +				status =3D "disabled";
> +			};

Please sort the nodes by address.

> +		};
> +
> +		aips4: bus@49000000 {
> +			compatible =3D "fsl,aips-bus", "simple-bus";
> +			reg =3D <0x0 0x49000000 0x0 0x800000>;
> +			ranges =3D <0x49000000 0x0 0x49000000 0x800000>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +
> +			smmu: iommu@490d0000 {
> +				compatible =3D "arm,smmu-v3";
> +				reg =3D <0x490d0000 0x100000>;
> +				interrupts =3D <GIC_SPI 325 IRQ_TYPE_EDGE_RISING>,
> +					     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
> +					     <GIC_SPI 334 IRQ_TYPE_EDGE_RISING>,
> +					     <GIC_SPI 326 IRQ_TYPE_EDGE_RISING>;
> +				interrupt-names =3D "eventq", "gerror", "priq", "cmdq-sync";
> +				#iommu-cells =3D <1>;
> +				status =3D "disabled";
> +			};
> +		};
> +
> +		gpio1: gpio@47400000 {
> +			compatible =3D "fsl,imx95-gpio", "fsl,imx8ulp-gpio";
> +			reg =3D <0x0 0x47400000 0x0 0x1000>;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells =3D <2>;
> +			clocks =3D <&scmi_clk IMX95_CLK_M33>,
> +				 <&scmi_clk IMX95_CLK_M33>;
> +			clock-names =3D "gpio", "port";
> +			status =3D "disabled";

I'm wondering of there should be a comment here that gpio1 usually is under
exclusive control of SM.

> +		};
> +
> +		elemu0: mailbox@47520000 {
> +			compatible =3D "fsl,imx95-mu-ele";
> +			reg =3D <0x0 0x47520000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <2>;
> +			status =3D "disabled";
> +		};
> +
> +		elemu1: mailbox@47530000 {
> +			compatible =3D "fsl,imx95-mu-ele";
> +			reg =3D <0x0 0x47530000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <2>;
> +			status =3D "disabled";
> +		};
> +
> +		elemu2: mailbox@47540000 {
> +			compatible =3D "fsl,imx95-mu-ele";
> +			reg =3D <0x0 0x47540000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <2>;
> +			status =3D "disabled";
> +		};
> +
> +		elemu3: mailbox@47550000 {
> +			compatible =3D "fsl,imx95-mu-ele";
> +			reg =3D <0x0 0x47550000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <2>;
> +		};
> +
> +		elemu4: mailbox@47560000 {
> +			compatible =3D "fsl,imx95-mu-ele";
> +			reg =3D <0x0 0x47560000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <2>;
> +			status =3D "disabled";
> +		};
> +
> +		elemu5: mailbox@47570000 {
> +			compatible =3D "fsl,imx95-mu-ele";
> +			reg =3D <0x0 0x47570000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <2>;
> +			status =3D "disabled";
> +		};
> +
> +		v2x_mu: mailbox@47350000 {
> +			compatible =3D "fsl,imx95-mu-v2x";
> +			reg =3D <0x0 0x47350000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <2>;
> +		};
> +
> +		v2x_mu6: mailbox@47320000 {
> +			compatible =3D "fsl,imx95-mu-v2x";
> +			reg =3D <0x0 0x47320000 0x0 0x10000>;
> +			interrupts =3D <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <2>;
> +		};

Please sort nodes by address.

Best regards,
Alexander

> +	};
> +};
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



