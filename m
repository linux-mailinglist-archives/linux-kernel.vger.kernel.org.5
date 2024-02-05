Return-Path: <linux-kernel+bounces-52137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA70184947F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A63E1F26A6A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FE9111A0;
	Mon,  5 Feb 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="nR6YSYm4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BD810A09;
	Mon,  5 Feb 2024 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117985; cv=none; b=eqxmIvKSQ7n6rpElnLZFdabP3GBjmGtPSyj9PtJehX1iV+2rn6Xes/hyR0/N/ih5s/Cn2dNahKR8R9MQqSJWXKWRXmCGQ4R8ZpKJEloyb3/AK3jzPp6A4RZ0w3Exzvlku7IeTm3x5YBtzfEJDTEWGwC4G4tJZY+Hf9q2H6CS3fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117985; c=relaxed/simple;
	bh=Q+fwbhbMlKHhMitPR4R0nMk4ON6qTL2AQj8+Stati4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HROMNQATNi/4zgY1iP2AHunN7v4yHKHyNRHWbqO8r3SoSoDS5wMju6C2xnpsxWQ6uxGPgConHNZxSn7A++WtwoBhNPLe2WnkgSWMjegJiv3uzZmsGS4lOnAYIRKNA4tpOiWsWXBdFMCOfQ+2AYDh043IVNTzJf6dO6qoWk2fw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=nR6YSYm4; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707117982; x=1738653982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hE8uVdU3UQ72lERu+ClYubt3YSUrQtm3/4DPzSloaCY=;
  b=nR6YSYm4s0JDmo0/U/NIscL9OHt1oZROgtYTq3Rm9hhPNKDztlsg9e51
   +8XKqFIKiR04Bt+cPejvHgiYl/fRmrfPSysRjVCWQbRg+WXNNPuU/CD0H
   Scey+RzESsVoPGGHtGd7DSKvz2LJlWQYfJ/+dGKiaOQyGroKTf03ohHmE
   WW5LV8k/Th8RTAq8whwdcRIHcoX7FNBunpUtwSV/ETFbZDS/mqsokX2xS
   TlVjoCD9fPM7JxtWzTYTUGmyuwz4+KAui80wEFI6WoBM1s6MFAYUp4iaq
   XEoE9jpkc7SZGvqxTomBSf3waeENrulrj8Ii/Y/OpoROQzxobLxsoHLcQ
   A==;
X-IronPort-AV: E=Sophos;i="6.05,242,1701126000"; 
   d="scan'208";a="35238211"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Feb 2024 08:26:12 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id DF27C280075;
	Mon,  5 Feb 2024 08:26:11 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-arm-kernel@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: marex@denx.de, frieder.schrempf@kontron.de, Lucas Stach <l.stach@pengutronix.de>, Adam Ford <aford173@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
  Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 05/12] arm64: dts: imx8mp: add HDMI power-domains
Date: Mon, 05 Feb 2024 08:26:12 +0100
Message-ID: <1880028.tdWV9SEqCh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240203165307.7806-6-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-6-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Adam,

thanks for working on this.

Am Samstag, 3. Februar 2024, 17:52:45 CET schrieb Adam Ford:
> From: Lucas Stach <l.stach@pengutronix.de>
>=20
> This adds the PGC and HDMI blk-ctrl nodes providing power control for
> HDMI subsystem peripherals.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> V2:  Add missing power-domains hdcp and hrv
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 38 +++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> 76c73daf546b..5c54073de615 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -836,6 +836,23 @@ pgc_mediamix: power-domain@10 {
>  							 <&clk=20
IMX8MP_CLK_MEDIA_APB_ROOT>;
>  					};
>=20
> +					pgc_hdmimix: power-
domains@14 {

As per Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml the node=
=20
should be called power-domain@.

> +						#power-domain-
cells =3D <0>;
> +						reg =3D=20
<IMX8MP_POWER_DOMAIN_HDMIMIX>;
> +						clocks =3D <&clk=20
IMX8MP_CLK_HDMI_ROOT>,
> +							 <&clk=20
IMX8MP_CLK_HDMI_APB>;
> +						assigned-clocks =3D=20
<&clk IMX8MP_CLK_HDMI_AXI>,
> +							=09
  <&clk IMX8MP_CLK_HDMI_APB>;
> +						assigned-clock-
parents =3D <&clk IMX8MP_SYS_PLL2_500M>,
> +							=09
	 <&clk IMX8MP_SYS_PLL1_133M>;
> +						assigned-clock-
rates =3D <500000000>, <133000000>;
> +					};
> +
> +					pgc_hdmi_phy: power-
domains@15 {

As per Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml the node=
=20
should be called power-domain@.

> +						#power-domain-
cells =3D <0>;
> +						reg =3D=20
<IMX8MP_POWER_DOMAIN_HDMI_PHY>;
> +					};
> +
>  					pgc_mipi_phy2: power-
domain@16 {
>  						#power-domain-
cells =3D <0>;
>  						reg =3D=20
<IMX8MP_POWER_DOMAIN_MIPI_PHY2>;
> @@ -1361,6 +1378,27 @@ eqos: ethernet@30bf0000 {
>  				intf_mode =3D <&gpr 0x4>;
>  				status =3D "disabled";
>  			};
> +
> +			hdmi_blk_ctrl: blk-ctrl@32fc0000 {
> +				compatible =3D "fsl,imx8mp-hdmi-blk-
ctrl", "syscon";
> +				reg =3D <0x32fc0000 0x23c>;
> +				clocks =3D <&clk IMX8MP_CLK_HDMI_APB>,
> +					 <&clk=20
IMX8MP_CLK_HDMI_ROOT>,
> +					 <&clk=20
IMX8MP_CLK_HDMI_REF_266M>,
> +					 <&clk IMX8MP_CLK_HDMI_24M>,
> +					 <&clk=20
IMX8MP_CLK_HDMI_FDCC_TST>;
> +				clock-names =3D "apb", "axi",=20
"ref_266m", "ref_24m", "fdcc";
> +				power-domains =3D <&pgc_hdmimix>,=20
<&pgc_hdmimix>,
> +						<&pgc_hdmimix>,=20
<&pgc_hdmimix>,
> +						<&pgc_hdmimix>,=20
<&pgc_hdmimix>,
> +						<&pgc_hdmimix>,=20
<&pgc_hdmi_phy>,
> +						<&pgc_hdmimix>,=20
<&pgc_hdmimix>;
> +				power-domain-names =3D "bus",=20
"irqsteer", "lcdif",
> +						     "pai", "pvi",=20
"trng",
> +						     "hdmi-tx",=20
"hdmi-tx-phy",
> +						     "hdcp",=20
"hrv";
> +				#power-domain-cells =3D <1>;
> +			};
>  		};
>=20

According to RM this block is part of AIPS4, so it should be below=20
hsio_blk_ctrl.

Best regards,
Alexander

>  		aips5: bus@30c00000 {


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



