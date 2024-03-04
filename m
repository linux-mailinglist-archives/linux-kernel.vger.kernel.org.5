Return-Path: <linux-kernel+bounces-90280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8286FCD3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E215F1C222B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8BB20B3E;
	Mon,  4 Mar 2024 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="cLGPWTyT"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3B51B802;
	Mon,  4 Mar 2024 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543532; cv=none; b=VSzjOVC4zs8CJdtPL2voI0VU9Qg7cqya50qOc4MjShMTDJ26SyHAmVrX6yYnzeX6EG1+igQQfh7FYaJwcx9+EKbJI2UH9HiQGTwiZ0Bpt6AQNF6bgZ+GQTRuqUMk2xfWBIR3nXgGC77bA6iwjMCl5B/1gXDyaKiBuNIKX3XKlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543532; c=relaxed/simple;
	bh=SXQdHBzDn6lNhNR2jRKyU6m0hP/iQLlkGyx6cM7QnjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWGI+F95cToY0/wG8nk5ECqXDwnpD2hpXanNHyNsvSLKyPtEHUZzx3p6Sc1EPZL9iBbymBHBcXoWMuqifog6HkMJaPGL80rFC6z/ADPREhtBEpYj7ojnkcOWSGOgo8ZDD0BV84gZwIjWP/kgoZXKwrP7ol6sgMWTNCshrQ7hmQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=cLGPWTyT; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709543529; x=1741079529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8o4rUALbnNNyVSdf0MmmAYmT6lll+Rib3jtEkEHDq+I=;
  b=cLGPWTyTSdkXYUoAmaM9ldCECgZaQr//fwXqozomNvt5pBnx4MHvScOL
   lT6sT5yrUjAXxaoOLU2ckOBGWLT3bn46U8tqycAjpTo3IaySbDqNwcCHO
   x+LFecR5kBzeDxdVX5u+KsLsOkjowVvYpIqOY9GDMKBlNTTe3Iom8Z4fq
   ucxG67OG0dT51Xyc5Ir1/OfZv0ollxdFyNy+XJoED5FUuFQq7LZxLP3E7
   7CLNStQSqPR2MSkvX+Fh0s1mfIvL5lvy/9B4Wn+KZgdyr8WB47T9xWEzT
   ybLCM47eASTJE/VUbn9Js1fmOvQAFuzGBQ1V8QTHFMvPI212G2dN3Ndsm
   Q==;
X-IronPort-AV: E=Sophos;i="6.06,203,1705359600"; 
   d="scan'208";a="35711027"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 Mar 2024 10:12:03 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 322E7280071;
	Mon,  4 Mar 2024 10:12:03 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: imx8dxl: add lpuart device in cm40 subsystem
Date: Mon, 04 Mar 2024 10:12:04 +0100
Message-ID: <6024754.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240302-m4_lpuart-v2-2-89a5952043b6@nxp.com>
References: <20240302-m4_lpuart-v2-0-89a5952043b6@nxp.com> <20240302-m4_lpuart-v2-2-89a5952043b6@nxp.com>
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

Am Samstag, 2. M=E4rz 2024, 17:27:45 CET schrieb Frank Li:
> From: Alice Guo <alice.guo@nxp.com>
>=20
> Add lpuart device in cm40 subsystem.
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 24 +++++++++++++++++++=
+++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi b/arch/arm64=
/boot/dts/freescale/imx8-ss-cm40.dtsi
> index 68043ab74e765..b6af85b20ddd7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
> @@ -20,6 +20,18 @@ cm40_subsys: bus@34000000 {
>  	#size-cells =3D <1>;
>  	ranges =3D <0x34000000 0x0 0x34000000 0x4000000>;
> =20
> +	cm40_lpuart: serial@37220000 {
> +		compatible =3D "fsl,imx8qxp-lpuart";
> +		reg =3D <0x37220000 0x1000>;
> +		interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks =3D <&cm40_uart_lpcg 1>, <&cm40_uart_lpcg 0>;
> +		clock-names =3D "ipg", "baud";
> +		assigned-clocks =3D <&clk IMX_SC_R_M4_0_UART IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		power-domains =3D <&pd IMX_SC_R_M4_0_UART>;
> +		status =3D "disabled";
> +	};
> +
>  	cm40_i2c: i2c@37230000 {
>  		compatible =3D "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
>  		reg =3D <0x37230000 0x1000>;
> @@ -53,6 +65,18 @@ cm40_intmux: intmux@37400000 {
>  		status =3D "disabled";
>  	};
> =20
> +	cm40_uart_lpcg: clock-controller@37620000 {
> +		compatible =3D "fsl,imx8qxp-lpcg";
> +		reg =3D <0x37620000 0x1000>;
> +		#clock-cells =3D <1>;
> +		clocks =3D <&clk IMX_SC_R_M4_0_UART IMX_SC_PM_CLK_PER>,
> +			 <&cm40_ipg_clk>;
> +		clock-indices =3D <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_1>;
> +		clock-output-names =3D "cm40_lpcg_uart_clk",
> +				     "cm40_lpcg_uart_ipg_clk";
> +		power-domains =3D <&pd IMX_SC_R_M4_0_UART>;
> +	};
> +
>  	cm40_i2c_lpcg: clock-controller@37630000 {
>  		compatible =3D "fsl,imx8qxp-lpcg";
>  		reg =3D <0x37630000 0x1000>;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



