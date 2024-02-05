Return-Path: <linux-kernel+bounces-52139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1AF849486
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2692867CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683C11183;
	Mon,  5 Feb 2024 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OImmV+qq"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5463E10A13;
	Mon,  5 Feb 2024 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118018; cv=none; b=IXIRgOe0BeNyeKw82jLoILxVz4PvxbB/a7Q1RQivwXMw0XApcwcyqiGAJ8PWFLoPg6BwxlVJkDco7TSAAFOx3YLhNKn0XF06QEgacmAyWC95cU5LI6aLwq/KP9q/K1CkHmhkbabqQnxYfz+bqRLxCer/B5ORUX44Ya/6HeTNJSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118018; c=relaxed/simple;
	bh=kRT1iRva3jEctcJDdeC1pic3Z5WISrbP9tA2yXUngyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POMtrrq53+nz3gBVFKuKr031fVwcBXJt+kOVCrgKyzP840WQ6jiZ3zSNlF6VUKjtXKTXqFniaipBAvdaMu6dArxvalZiTSrWDZvL+rFKnp2dfjOusiXuWkrA+5XzJn3GAuG8i4/cFw47h6QuWW0Yw6kGIi2DCV/0tUFZXV3mZwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OImmV+qq; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707118016; x=1738654016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HoFc6DCxoaUD+73aoVDy20A8vyUJTHyM4bWOxf2XCbc=;
  b=OImmV+qqNcl6axv5BQpMBjXxIttDLbFAGVN4VY6I9ZO5ZHkOcN2Hp5P9
   gm0HSqOYKVB0DWi7SXQI7SgknV9MOPNNSd3RoVNBqniQXP5SrYZG7BamD
   h8wcpno1EKnEYDG8zw4dBlSLe356jq8JzBvF8C7eAyKeukVLGzkLAoiTJ
   rKsFyCwzN5XeRPoLIHdOS17dVfAgNTXJrr5R3bPtONE6BrnqvnE2Im3Ni
   5vzosBIXo/leBWL2rX84MUX6xI7LEmGaERhpYyTP1yy1Bv18w714nE7MN
   VwgTd0ay9Vq6ZRrCjNO+k0Xim7Dfffbhy+Y5ywr/Mi/ZL2I9+ybmQjszD
   A==;
X-IronPort-AV: E=Sophos;i="6.05,242,1701126000"; 
   d="scan'208";a="35238230"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Feb 2024 08:26:53 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 4B324280075;
	Mon,  5 Feb 2024 08:26:52 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-arm-kernel@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: marex@denx.de, frieder.schrempf@kontron.de, Lucas Stach <l.stach@pengutronix.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Catalin Marinas <catalin.marina
 s@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 06/12] arm64: dts: imx8mp: add HDMI irqsteer
Date: Mon, 05 Feb 2024 08:26:53 +0100
Message-ID: <2175280.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240203165307.7806-7-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-7-aford173@gmail.com>
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

Am Samstag, 3. Februar 2024, 17:52:46 CET schrieb Adam Ford:
> From: Lucas Stach <l.stach@pengutronix.de>
>=20
> The HDMI irqsteer is a secondary interrupt controller within the HDMI
> subsystem that maps all HDMI peripheral IRQs into a single upstream
> IRQ line.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> 5c54073de615..5e51a766f3d9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1399,6 +1399,19 @@ hdmi_blk_ctrl: blk-ctrl@32fc0000 {
>  						     "hdcp",=20
"hrv";
>  				#power-domain-cells =3D <1>;
>  			};
> +
> +			irqsteer_hdmi: interrupt-controller@32fc2000 {
> +				compatible =3D "fsl,imx-irqsteer";
> +				reg =3D <0x32fc2000 0x44>;
> +				interrupts =3D <GIC_SPI 43=20
IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-controller;
> +				#interrupt-cells =3D <1>;
> +				fsl,channel =3D <1>;
> +				fsl,num-irqs =3D <64>;
> +				clocks =3D <&clk IMX8MP_CLK_HDMI_APB>;
> +				clock-names =3D "ipg";
> +				power-domains =3D <&hdmi_blk_ctrl=20
IMX8MP_HDMIBLK_PD_IRQSTEER>;
> +			};

According to RM this block is part of HDMI_TX which is part of AIPS4, so it=
=20
should be below hsio_blk_ctrl.

Best regards,
Alexander

>  		};
>=20
>  		aips5: bus@30c00000 {


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



