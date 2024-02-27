Return-Path: <linux-kernel+bounces-82815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F53868A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661F41F244E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175154F94;
	Tue, 27 Feb 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="qSbAZTdu"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C676A54BC8;
	Tue, 27 Feb 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019741; cv=none; b=S8U9VGrEm+w0sYBIpbF4LF89mn//A6FuCi/g0HD4m/py1UrncTdl8ffd4I4dzUjtgoZj9hBlWlUO1/ZrCO2DKij8nza7q4RIJTqZgUNvLOg0m/BmwIV62vd10zbPjzLXgPJF5atIC/z/0kvYZNF+bxnnx7juV+g6njJLilaTbIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019741; c=relaxed/simple;
	bh=HCCpPHfruMmNeDtopT91uaAx5seHuRXfQsl6Lt75Otw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdDzo1dxltsPh/P7pnl23madvsoPMU2TWQ16bn9RvP9wXHg5Wsey65UZuSftAdAC0UCePbDkl+r5CZ612Hqn7VZAZuP7kG0fd5yYpCfD1cQtzS7q9jggcOwQ4j84rwpxzOoTA35e+rL0Z0eu8ENVdi2tyrqzeMgJMcxFLKJVnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=qSbAZTdu; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709019738; x=1740555738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r7JmSYlxsh14XOEmR0NelO63VSvY9OUGMgbj0LvjGzc=;
  b=qSbAZTdupncGrlP7Z2kl2rr5zpC7wnPbIGNadsdCX6WQflZjtTKtWsGK
   +EoUM2f4jInTxOhkqIpQr3r6QDnjL2fJUrehToEAMcEiF7mp9gf0RpKTJ
   3FmyAe2xi29C7tSYcZEH3M54KvueipPjH4ema8phmTvOQXN7csdXLyk4D
   9vOEFU5XvnCmRd71Vr0R+rX+O3L3bVyDQmM+2Nru2X4CnJQQtwqPqL/mi
   G1JyacwbI0evswrgIlxUjCgABsaqOpGZLj3NES93VeVQA3z4DhIg9a1hx
   BXnWtsDKT2vBs6QyQw3kinTGseQakaCQRiBIUZhMr/WVPa5bE/yOExu8l
   w==;
X-IronPort-AV: E=Sophos;i="6.06,187,1705359600"; 
   d="scan'208";a="35608425"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Feb 2024 08:42:15 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 28495280075;
	Tue, 27 Feb 2024 08:42:15 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 3/3] arm64: dts: imx8qm-mek: add flexspi0 support
Date: Tue, 27 Feb 2024 08:42:15 +0100
Message-ID: <12393206.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240226203358.275986-3-Frank.Li@nxp.com>
References: <20240226203358.275986-1-Frank.Li@nxp.com> <20240226203358.275986-3-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

Am Montag, 26. Februar 2024, 21:33:57 CET schrieb Frank Li:
> Add flexspi0 support for imx8qm-mek board.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/bo=
ot/dts/freescale/imx8qm-mek.dts
> index 800dcb67642b1..7077e394e855b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -101,6 +101,23 @@ spidev0: spi@0 {
>  	};
>  };
> =20
> +&flexspi0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_flexspi0>;
> +	nxp,fspi-dll-slvdly =3D <4>;
> +	status =3D "okay";
> +
> +	flash0: mt35xu512aba@0 {
> +		reg =3D <0>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;

Using '#address-cells' and '#size-cells' in mtd (and thus spi-nor )
is deprecated, please refer to Documentation/devicetree/bindings/mtd/mtd.ya=
ml.

You need to add a partitions subnode instead:
> partitions {
> 	compatible =3D "fixed-partitions";
> 	#address-cells =3D <1>;
> 	#size-cells =3D <1>;
> };

Best regards,
Alexander

> +		compatible =3D "jedec,spi-nor";
> +		spi-max-frequency =3D <133000000>;
> +		spi-tx-bus-width =3D <8>;
> +		spi-rx-bus-width =3D <8>;
> +	};
> +};
> +
>  &fec1 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_fec1>;
> @@ -199,6 +216,27 @@ IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
>  		>;
>  	};
> =20
> +	pinctrl_flexspi0: flexspi0grp {
> +		fsl,pins =3D <
> +			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021
> +			IMX8QM_QSPI0A_DATA1_LSIO_QSPI0A_DATA1     0x06000021
> +			IMX8QM_QSPI0A_DATA2_LSIO_QSPI0A_DATA2     0x06000021
> +			IMX8QM_QSPI0A_DATA3_LSIO_QSPI0A_DATA3     0x06000021
> +			IMX8QM_QSPI0A_DQS_LSIO_QSPI0A_DQS         0x06000021
> +			IMX8QM_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B     0x06000021
> +			IMX8QM_QSPI0A_SS1_B_LSIO_QSPI0A_SS1_B     0x06000021
> +			IMX8QM_QSPI0A_SCLK_LSIO_QSPI0A_SCLK       0x06000021
> +			IMX8QM_QSPI0B_SCLK_LSIO_QSPI0B_SCLK       0x06000021
> +			IMX8QM_QSPI0B_DATA0_LSIO_QSPI0B_DATA0     0x06000021
> +			IMX8QM_QSPI0B_DATA1_LSIO_QSPI0B_DATA1     0x06000021
> +			IMX8QM_QSPI0B_DATA2_LSIO_QSPI0B_DATA2     0x06000021
> +			IMX8QM_QSPI0B_DATA3_LSIO_QSPI0B_DATA3     0x06000021
> +			IMX8QM_QSPI0B_DQS_LSIO_QSPI0B_DQS         0x06000021
> +			IMX8QM_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B     0x06000021
> +			IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
> +		>;
> +	};
> +
>  	pinctrl_lpuart0: lpuart0grp {
>  		fsl,pins =3D <
>  			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



