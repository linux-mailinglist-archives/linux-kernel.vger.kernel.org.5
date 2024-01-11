Return-Path: <linux-kernel+bounces-23712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1282B0A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13411F24C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113373D3A2;
	Thu, 11 Jan 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JzGLRDSw"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30A3AC10;
	Thu, 11 Jan 2024 14:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1704983192; x=1736519192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u07jgQAZPh+ETepT/rWlofkLPq/+1wSCR8nHmur/QDA=;
  b=JzGLRDSwzcVmwpNRtellzuPRao3wOdqfqm2IM6Bgej5PM+xVbJeWWjuT
   HnrH72ezEzYKYNcUBvo4L1fuADjeqP4TWWReOzVFcFEPzylPtsPCb9+Ds
   ms4oYpiuhZCweFlMiybmZY3WA1LVuR9rzr4eRvJh2YtXTbyoU3ax/AlP6
   P7Pz9cH51ljMSuZenkoCeME9ygcxrFN8kC0k3aHHzDgGgvrzKAh11ks2I
   ABaGegj+6eGSFeB/xChG38veO3dtYQvnJ7M+uf58ulO6b6AjETAswIkrE
   80VmGl1j6XOqCMK9HRT+oXnJO1HF4FSTvpnDXvOzdKWbexejUQbQkkqiU
   w==;
X-IronPort-AV: E=Sophos;i="6.04,186,1695679200"; 
   d="scan'208";a="34853706"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 11 Jan 2024 15:26:29 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9698B280075;
	Thu, 11 Jan 2024 15:26:29 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: bartosz.golaszewski@linaro.org, linus.walleij@linaro.org, Hector Palacios <hector.palacios@digi.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, haibo.chen@nxp.com, peng.fan@nxp.com, hector.palacios@digi.com
Subject: Re: [PATCH 2/2] arm64: dts: imx93: specify available 'ngpios' per GPIO port
Date: Thu, 11 Jan 2024 15:26:29 +0100
Message-ID: <4330477.ejJDZkT8p0@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240111131904.1491496-3-hector.palacios@digi.com>
References: <20240111131904.1491496-1-hector.palacios@digi.com> <20240111131904.1491496-3-hector.palacios@digi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 11. Januar 2024, 14:19:04 CET schrieb Hector Palacios:
> According to NXP HRM for i.MX93, the following GPIO pins are available:
> - GPIO1: 16 pins (0..15)
> - GPIO2: 30 pins (0..29)
> - GPIO3: 32 pins (0..31)
> - GPIO4: 30 pins (0..29)
>=20
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi
> b/arch/arm64/boot/dts/freescale/imx93.dtsi index 34c0540276d1..7eb2cab7c7=
49
> 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -970,6 +970,7 @@ gpio2: gpio@43810000 {
>  				 <&clk IMX93_CLK_GPIO2_GATE>;
>  			clock-names =3D "gpio", "port";
>  			gpio-ranges =3D <&iomuxc 0 4 30>;
> +			ngpios =3D <30>;
>  		};
>=20
>  		gpio3: gpio@43820000 {
> @@ -986,6 +987,7 @@ gpio3: gpio@43820000 {
>  			clock-names =3D "gpio", "port";
>  			gpio-ranges =3D <&iomuxc 0 84 8>, <&iomuxc 8 66=20
18>,
>  				      <&iomuxc 26 34 2>, <&iomuxc 28 0=20
4>;
> +			ngpios =3D <32>;
>  		};
>=20
>  		gpio4: gpio@43830000 {
> @@ -1001,6 +1003,7 @@ gpio4: gpio@43830000 {
>  				 <&clk IMX93_CLK_GPIO4_GATE>;
>  			clock-names =3D "gpio", "port";
>  			gpio-ranges =3D <&iomuxc 0 38 28>, <&iomuxc 28 36=20
2>;
> +			ngpios =3D <30>;
>  		};
>=20
>  		gpio1: gpio@47400000 {
> @@ -1016,6 +1019,7 @@ gpio1: gpio@47400000 {
>  				 <&clk IMX93_CLK_GPIO1_GATE>;
>  			clock-names =3D "gpio", "port";
>  			gpio-ranges =3D <&iomuxc 0 92 16>;
> +			ngpios =3D <16>;
>  		};
>=20
>  		ocotp: efuse@47510000 {

This leads to warnings upon dtbs_check, e.g.
arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dtb: gpio@43810000:=
=20
'ngpios' does not match any of the regexes: '^.+-hog(-[0-9]+)?$', 'pinctrl-
[0-9]+'
  from schema $id: http://devicetree.org/schemas/gpio/gpio-vf610.yaml#

Please address this as well.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



