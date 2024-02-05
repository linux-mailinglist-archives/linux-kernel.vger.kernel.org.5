Return-Path: <linux-kernel+bounces-52142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E1084948D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CAA1C20BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7557510A13;
	Mon,  5 Feb 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ez0BbGCl"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD0411705;
	Mon,  5 Feb 2024 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118196; cv=none; b=D1bnaN8dnXd2nabydae58+/rbZYgGzimPuzbZqQQAeS48e8vhLBMpVXG5ddEJqVfbhd8QqEMhfGd07WFqeO20D9PTYnzpFSyJ+pvCF0llioFYDdrGLIYDB23dnIFdW4B7Udc+8p8YjTa+/qBT3t5Ki/hNICKPrkCX+F7lbO1LfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118196; c=relaxed/simple;
	bh=IZhvgO+aMRZPJo3UKnzKhTXhsS/DTCtJV35t4nGc0Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwkqkZ7nYuwfiqKNtGV3k1AJLt9I3Rmbi7CPE9lYhXV8p7yn5LRD/XPDjTEKA7/Hw6B9dykqbDE/Qi2XqFqarH8j+hgpoKUeEqTVY1Hbma1jwBePFZzB4tZebg58k3ocSOAHRXOC9hwyPbeR4rZKAEqUGyQKX+tt4FW/9D5F+iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ez0BbGCl; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707118193; x=1738654193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZcmn/OIlR5Udu+W3cVR16fsRHqzu2hvYW43r3YLp2A=;
  b=ez0BbGCll9Pen/7SdqNedzo81X3zfnt1bSR84I9noy31uo+1nBBgZCn4
   /mK0cd4alngDlhceZRSF4X1DFnHNVYomrVtn57EiJ4qYQmmoirx99d5ja
   3Fhqc7d414JUqcdx9EMAhwe5kewkdQC8KCoUa53cLRBTW7G1YDy2TOgNU
   nxGwOZur9u23XT0tAmgfZ2Yf/Gr/sYDYZ1CkV3d5/InPVaBNHx9y+UDoD
   jMLJKFHb7w73RgjQQ1tBBKtCo320OFXG1sJV6uwInHPQdwDbkdzOWadql
   vCVjImLGxy02yFRGxUqa2LwOYTr6DRRCVGNaw+NFVi7kiI8PmanejFpqa
   A==;
X-IronPort-AV: E=Sophos;i="6.05,242,1701126000"; 
   d="scan'208";a="35238305"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Feb 2024 08:29:50 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 013B7280075;
	Mon,  5 Feb 2024 08:29:49 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-arm-kernel@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: marex@denx.de, frieder.schrempf@kontron.de, Lucas Stach <l.stach@pengutronix.de>, Adam Ford <aford173@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
  Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Liu Ying <victor.liu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V8 11/12] arm64: dts: imx8mp: add HDMI display pipeline
Date: Mon, 05 Feb 2024 08:29:50 +0100
Message-ID: <2924284.e9J7NaK4W3@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240203165307.7806-12-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com> <20240203165307.7806-12-aford173@gmail.com>
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

Am Samstag, 3. Februar 2024, 17:52:51 CET schrieb Adam Ford:
> From: Lucas Stach <l.stach@pengutronix.de>
>=20
> This adds the DT nodes for all the peripherals that make up the
> HDMI display pipeline.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>=20
> ---
> V2:  I took this from Lucas' original submission with the following:
>      Removed extra clock from HDMI-TX since it is now part of the
>      power domain
>      Added interrupt-parent to PVI
>      Changed the name of the HDMI tranmitter to fsl,imx8mp-hdmi-tx
>      Added ports to HDMI-tx
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 94 +++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mp.dtsi index
> 5e51a766f3d9..e84b4f40e570 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1412,6 +1412,100 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
>  				clock-names =3D "ipg";
>  				power-domains =3D <&hdmi_blk_ctrl=20
IMX8MP_HDMIBLK_PD_IRQSTEER>;
>  			};
> +
> +			hdmi_pvi: display-bridge@32fc4000 {
> +				compatible =3D "fsl,imx8mp-hdmi-pvi";
> +				reg =3D <0x32fc4000 0x40>;
> +				interrupt-parent =3D <&irqsteer_hdmi>;
> +				interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH>;

irqsteer_hdmi has #interrupt-cells =3D <1>, so IRQ flags should be removed.=
=20
dtbs_check also warns about this.

> +				power-domains =3D <&hdmi_blk_ctrl=20
IMX8MP_HDMIBLK_PD_PVI>;
> +
> +				ports {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +
> +					port@0 {
> +						reg =3D <0>;
> +						pvi_from_lcdif3:=20
endpoint {
> +							remote-
endpoint =3D <&lcdif3_to_pvi>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg =3D <1>;
> +						pvi_to_hdmi_tx:=20
endpoint {
> +							remote-
endpoint =3D <&hdmi_tx_from_pvi>;
> +						};
> +					};
> +				};
> +			};
> +
> +			lcdif3: display-controller@32fc6000 {
> +				compatible =3D "fsl,imx8mp-lcdif";
> +				reg =3D <0x32fc6000 0x238>;
> +				interrupts =3D <8 IRQ_TYPE_LEVEL_HIGH>;

irqsteer_hdmi has #interrupt-cells =3D <1>, so IRQ flags should be removed.=
=20
dtbs_check also warns about this.

> +				interrupt-parent =3D <&irqsteer_hdmi>;
> +				clocks =3D <&hdmi_tx_phy>,
> +					 <&clk IMX8MP_CLK_HDMI_APB>,
> +					 <&clk=20
IMX8MP_CLK_HDMI_ROOT>;
> +				clock-names =3D "pix", "axi",=20
"disp_axi";
> +				power-domains =3D <&hdmi_blk_ctrl=20
IMX8MP_HDMIBLK_PD_LCDIF>;
> +
> +				port {
> +					lcdif3_to_pvi: endpoint {
> +						remote-endpoint =3D=20
<&pvi_from_lcdif3>;
> +					};
> +				};
> +			};
> +
> +			hdmi_tx: hdmi@32fd8000 {
> +				compatible =3D "fsl,imx8mp-hdmi-tx";
> +				reg =3D <0x32fd8000 0x7eff>;
> +				interrupts =3D <0 IRQ_TYPE_LEVEL_HIGH>;

irqsteer_hdmi has #interrupt-cells =3D <1>, so IRQ flags should be removed.=
=20
dtbs_check also warns about this.

> +				interrupt-parent =3D <&irqsteer_hdmi>;
> +				clocks =3D <&clk IMX8MP_CLK_HDMI_APB>,
> +					 <&clk=20
IMX8MP_CLK_HDMI_REF_266M>,
> +					 <&clk IMX8MP_CLK_32K>,
> +					 <&hdmi_tx_phy>;
> +				clock-names =3D "iahb", "isfr", "cec",=20
"pix";
> +				assigned-clocks =3D <&clk=20
IMX8MP_CLK_HDMI_REF_266M>;
> +				assigned-clock-parents =3D <&clk=20
IMX8MP_SYS_PLL1_266M>;
> +				power-domains =3D <&hdmi_blk_ctrl=20
IMX8MP_HDMIBLK_PD_HDMI_TX>;
> +				reg-io-width =3D <1>;
> +				status =3D "disabled";
> +
> +				ports {
> +					#address-cells =3D <1>;
> +					#size-cells =3D <0>;
> +
> +					port@0 {
> +						reg =3D <0>;
> +
> +						hdmi_tx_from_pvi:=20
endpoint {
> +							remote-
endpoint =3D <&pvi_to_hdmi_tx>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg =3D <1>;
> +						/* Point endpoint=20
to the HDMI connector */
> +					};
> +				};
> +			};
> +
> +			hdmi_tx_phy: phy@32fdff00 {
> +				compatible =3D "fsl,imx8mp-hdmi-phy";
> +				reg =3D <0x32fdff00 0x100>;
> +				clocks =3D <&clk IMX8MP_CLK_HDMI_APB>,
> +					 <&clk IMX8MP_CLK_HDMI_24M>;
> +				clock-names =3D "apb", "ref";
> +				assigned-clocks =3D <&clk=20
IMX8MP_CLK_HDMI_24M>;
> +				assigned-clock-parents =3D <&clk=20
IMX8MP_CLK_24M>;
> +				power-domains =3D <&hdmi_blk_ctrl=20
IMX8MP_HDMIBLK_PD_HDMI_TX_PHY>;
> +				#clock-cells =3D <0>;
> +				#phy-cells =3D <0>;
> +				status =3D "disabled";
> +			};

According to RM these blocks are part of AIPS4, so it should be below=20
hsio_blk_ctrl.

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



