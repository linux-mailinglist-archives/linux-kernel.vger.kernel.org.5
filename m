Return-Path: <linux-kernel+bounces-145428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EF68A560A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305C7282B65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75A762E0;
	Mon, 15 Apr 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JufAHYJR"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01C82119;
	Mon, 15 Apr 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193702; cv=none; b=LclPhULAewdU+SYaQzi2AFQ9hd/sG/ybn8G5lDu9D+ekXQeeKUgV2aPpYLkqW5FfSoEcgob9+tT9Z/S72pVexWgdnKkDKi1DP/hcA4xCRVoQuvzWq3qbNE2PjGM2FIH0+LvDzymxTU65v8s12iFmMLKWCgvSzEDJyO5VOBF0cUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193702; c=relaxed/simple;
	bh=hWHk3OAeDSHeXmmwsMo6Ie1UzYURq55JZzQuZwoHz+s=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=oRnTzfWC2WevrU8Vp5URsAyZ5iHv+W7d7zcC5XwjW42YWf2nMIMONIzHHirKKdmywT1Ozn52hBiEKFKJ6ct6uq2T3tkq2D6GvKJyj3V8oIgUENN8GkNr3Vi5+k8qzmudxYtONvofYM6YVq2GOk0oL1erDGwMjeBYeBxQgz1mXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JufAHYJR; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EC61B236;
	Mon, 15 Apr 2024 17:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713193648;
	bh=hWHk3OAeDSHeXmmwsMo6Ie1UzYURq55JZzQuZwoHz+s=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=JufAHYJRV5XwyCZiGltge2oCI08BK+ysqi+YSMdQnzRgNLHulH5BbqXcuni2QkdnR
	 PrSf7TFQaGxzbY4p8yPYQDdD++K83lG6IkfxZ1Rppnz+ResPyrf2vrvxYZE7oOwjOo
	 gJa5u1GSWEpAvoWHJp04t2AxpcQ+GNe9UKG/bJCU=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415114135.25473-2-chris.obbard@collabora.com>
References: <20240415114135.25473-1-chris.obbard@collabora.com> <20240415114135.25473-2-chris.obbard@collabora.com>
Subject: Re: [PATCH v1 1/1] arm64: dts: imx8mp-debix-model-a: Add HDMI output support
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, kernel@collabora.com, Christopher Obbard <chris.obbard@collabora.com>, Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
To: Christopher Obbard <chris.obbard@collabora.com>, linux-kernel@vger.kernel.org
Date: Mon, 15 Apr 2024 16:08:10 +0100
Message-ID: <171319369093.2333277.9109576229211275635@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Hi Chris,


Quoting Christopher Obbard (2024-04-15 12:41:27)
> Enable the HDMI output on the Debix Model A SBC, using the HDMI encoder
> present in the i.MX8MP SoC.

Aha, you beat me to it. I have a commit locally (Dated 2022-09-06) but
not sent because I didn't realise the HDMI support finally got upstream
\o/

> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
>=20
>  .../dts/freescale/imx8mp-debix-model-a.dts    | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arc=
h/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> index 2c19766ebf09..29529c2ecac9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> @@ -20,6 +20,18 @@ chosen {
>                 stdout-path =3D &uart2;
>         };
> =20
> +       hdmi-connector {
> +               compatible =3D "hdmi-connector";
> +               label =3D "hdmi";
> +               type =3D "a";
> +
> +               port {
> +                       hdmi_connector_in: endpoint {
> +                               remote-endpoint =3D <&hdmi_tx_out>;
> +                       };
> +               };
> +       };
> +

Interesting. My patch missed this. But it looks correct.


>         leds {
>                 compatible =3D "gpio-leds";
>                 pinctrl-names =3D "default";
> @@ -94,6 +106,28 @@ ethphy0: ethernet-phy@0 { /* RTL8211E */
>         };
>  };
> =20
> +&hdmi_pvi {
> +       status =3D "okay";
> +};
> +
> +&hdmi_tx {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_hdmi>;
> +       status =3D "okay";
> +
> +       ports {
> +               port@1 {
> +                       hdmi_tx_out: endpoint {
> +                               remote-endpoint =3D <&hdmi_connector_in>;
> +                       };
> +               };
> +       };
> +};
> +
> +&hdmi_tx_phy {
> +       status =3D "okay";
> +};
> +
>  &i2c1 {
>         clock-frequency =3D <400000>;
>         pinctrl-names =3D "default";
> @@ -241,6 +275,10 @@ &i2c6 {
>         status =3D "okay";
>  };
> =20
> +&lcdif3 {
> +       status =3D "okay";
> +};
> +

Except for the addition of the connector, the above matches my patch to
here.


>  &snvs_pwrkey {
>         status =3D "okay";
>  };


But in my patch I have the following hunk here: (I haven't checked to
see if this still applies on mainline, so take with a pinch of salt if
it's not there!)


 &iomuxc {
 	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&pinctrl_hog>;
-
-	pinctrl_hog: hoggrp {
-		fsl,pins =3D <
-			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL					0x400001c3
-			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA					0x400001c3
-			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD						0x40000019
-			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC						0x40000019
-		>;
-	};

 	pinctrl_eqos: eqosgrp {
 		fsl,pins =3D <
 			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC							0x3
 			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO						0x3




> @@ -358,6 +396,15 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16               =
               0x19
>                 >;
>         };
> =20
> +       pinctrl_hdmi: hdmigrp {
> +               fsl,pins =3D <
> +                       MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL      =
               0x400001c3
> +                       MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA      =
               0x400001c3
> +                       MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD          =
               0x40000019
> +                       MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC          =
               0x40000019
> +               >;
> +       };
> +

And my addition here is :


+	pinctrl_hdmi: hdmigrp {
+		fsl,pins =3D <
+			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c3
+			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c3
+			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x19
+			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x19
+		>;
+	};
+


I haven't looked into what the 0x40000000 does yet, but just
highlighting the difference from the version I've been using to make use
of HDMI so far.

Does anyone else know the impact here? Otherwise I'll try to find time
to check this later. (For some undefined term of later...)

--
Kieran


>         pinctrl_i2c1: i2c1grp {
>                 fsl,pins =3D <
>                         MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL                  =
               0x400001c2
> --=20
> 2.43.0
>

