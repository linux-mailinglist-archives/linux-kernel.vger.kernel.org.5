Return-Path: <linux-kernel+bounces-86524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B5A86C687
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0746328299B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F3E63518;
	Thu, 29 Feb 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="gOuDSN94"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8554634FA;
	Thu, 29 Feb 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201585; cv=none; b=kvrxbs2nCzkiMQIzHGmF/p2yTZ/+nfmyXMrxB1ZTfj2Y8X8XUIN3dcxQTrAUwAGE7tgfuAlkkKmr7U8bGkYVr3g9ij7sDzphw3Ep4+KB83XGw+VAp1jJkhw09u+5DBxukUgGte9BEKdVrvrNBYoxquihUZZJ7iWPf9HEKVqCmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201585; c=relaxed/simple;
	bh=3Y0napQcok6yYFzvKZKXvC27C5ldIaWsvbr5C99snto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/aXKLzHKGuB5ViEjIBaqFyf0mxmEoNziLmQk7yxbCbv/qGNVShDuG6OD9R0fFsqkZFfnLLuKyfVVvwucwuYqdkGSQRwhXZSePdcEHKCs8qIfApt39XEV2wXv7FNt9ykB4LG1IJ1CCDoVS4lyHC0PFVsTJp4gEtx/dBWM4cX9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=gOuDSN94; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1709201583; x=1740737583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0tG9nzHcCDklSXmw5EvPC2Z+AwV2Whi6F5Gzi5EvOI=;
  b=gOuDSN94gLoT5fhWbf9HkSqfW/mjU2WxbYD1ZijHkjAbu4Rp0t7foYlp
   ZK/3XpyBSSWxL4iqXJpBp0TPkEtwt5AYvvMkjCmIrWxYxyQfc0A2Oi156
   4vv2udDUCCvvkTOVWngdhJYTuV27bbj3le7kqevmlTjpf3pZmRsq4XK7H
   XQXoRBfNgX/ytwl4C2Qhay+Q6uauWdfgE5TGMtz7G+HQYl07brfTS3fdJ
   ifjoEhWCnlJgOzfV9HHCzjf9lNF/FwwBKuYoSb007Oj0VYf4wJUnF/AOa
   Wwh/oSUuqHHi7V/12GYAzQgPUQItojuyYbDWejxH6jcu2RbTZ3prQohhq
   A==;
X-IronPort-AV: E=Sophos;i="6.06,194,1705359600"; 
   d="scan'208";a="35661153"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Feb 2024 11:12:45 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id EA6ED280071;
	Thu, 29 Feb 2024 11:12:39 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 2/4] arm64: dts: imx8dxl: add lpuart device in cm40 subsystem
Date: Thu, 29 Feb 2024 11:12:39 +0100
Message-ID: <1889315.CQOukoFCf9@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240228-m4_lpuart-v1-2-9e6947be15e7@nxp.com>
References: <20240228-m4_lpuart-v1-0-9e6947be15e7@nxp.com> <20240228-m4_lpuart-v1-2-9e6947be15e7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Frank,

thanks for the patch.

Am Mittwoch, 28. Februar 2024, 20:54:58 CET schrieb Frank Li:
> From: Alice Guo <alice.guo@nxp.com>
>=20
> Adding lpuart device in cm40 subsystem.
>=20
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi | 25 +++++++++++++++++++=
++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi b/arch/arm64=
/boot/dts/freescale/imx8-ss-cm40.dtsi
> index b1d626862ddf8..ecca5ada224b7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-cm40.dtsi
> @@ -64,4 +64,29 @@ cm40_intmux: intmux@37400000 {
>  		power-domains =3D <&pd IMX_SC_R_M4_0_INTMUX>;
>  		status =3D "disabled";
>  	};
> +
> +	cm40_lpuart: serial@37220000 {
> +		compatible =3D "fsl,imx8qxp-lpuart";
> +		reg =3D <0x37220000 0x1000>;
> +		interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-parent =3D <&cm40_intmux>;

With interrupt-parent set in Patch 1 for the whole subsystem, this line
is not needed anymore.

Best regards,
Alexander

> +		clocks =3D <&cm40_uart_lpcg 1>, <&cm40_uart_lpcg 0>;
> +		clock-names =3D "ipg", "baud";
> +		assigned-clocks =3D <&clk IMX_SC_R_M4_0_UART IMX_SC_PM_CLK_PER>;
> +		assigned-clock-rates =3D <24000000>;
> +		power-domains =3D <&pd IMX_SC_R_M4_0_UART>;
> +		status =3D "disabled";
> +	};
> +
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
>  };
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



