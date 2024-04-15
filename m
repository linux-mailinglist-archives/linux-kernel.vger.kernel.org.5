Return-Path: <linux-kernel+bounces-145558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2CB8A57D8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7041C20E75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775E2823B5;
	Mon, 15 Apr 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qMt0OftN"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AB811FF;
	Mon, 15 Apr 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198933; cv=none; b=R6ryiYsbQyt2L5dw+sB25gnbOTfGBTys9k1nemXBiH8HfFUmW/xnp1MUi/YSpb532j94jsAI8SeNA8STk46YA8rds4zMEpltFTjXR0loHgrlYQjmPGlMeT82mkwqIP9OrZc8DYCHGjO64j/ytIVC9LUesckyyRXUJUhzOqKNZo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198933; c=relaxed/simple;
	bh=zQ3mUcQ0V6TVm4bmNvVE8F5YpgKPg13IqXSQF1upC+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7t81xjJGRbJMVXEsMtxRNyCgQgJL+1cHC0+qUy3lBUcYTR+n4hfUpqrjVkNDE/94bM2ltmnt0TlIeT6VXqkr5xJ+a/8Tglq4uVPwIzMG/ybDRrBlEJuww/GVYsdDxJUtavGxziJS7E3sQSjHZF0SmjyZOjJP/U6pcDf6xHtZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qMt0OftN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 773645B2;
	Mon, 15 Apr 2024 18:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713198883;
	bh=zQ3mUcQ0V6TVm4bmNvVE8F5YpgKPg13IqXSQF1upC+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMt0OftNV/lrYtTYmBIaTowedeajRbC1r6L/70Ft/lYOh2o6DAz2ELDoSepJfngxJ
	 Ely6YUfACt5adqQVUbhOz9mencaqicN3KLH36lC6U3d5Gfwu8CgCojoWr505RhqEND
	 JCNgA83TsjBUjMMToEPPpfLIysEuZUMA8LaTlxg8=
Date: Mon, 15 Apr 2024 19:35:20 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Christopher Obbard <chris.obbard@collabora.com>,
	linux-kernel@vger.kernel.org,
	Daniel Scally <dan.scally@ideasonboard.com>, kernel@collabora.com,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/1] arm64: dts: imx8mp-debix-model-a: Add HDMI output
 support
Message-ID: <20240415163520.GA22954@pendragon.ideasonboard.com>
References: <20240415114135.25473-1-chris.obbard@collabora.com>
 <20240415114135.25473-2-chris.obbard@collabora.com>
 <171319369093.2333277.9109576229211275635@ping.linuxembedded.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <171319369093.2333277.9109576229211275635@ping.linuxembedded.co.uk>

On Mon, Apr 15, 2024 at 04:08:10PM +0100, Kieran Bingham wrote:
> Hi Chris,
> 
> 
> Quoting Christopher Obbard (2024-04-15 12:41:27)
> > Enable the HDMI output on the Debix Model A SBC, using the HDMI encoder
> > present in the i.MX8MP SoC.
> 
> Aha, you beat me to it. I have a commit locally (Dated 2022-09-06) but
> not sent because I didn't realise the HDMI support finally got upstream
> \o/
> 
> > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > ---
> > 
> >  .../dts/freescale/imx8mp-debix-model-a.dts    | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > index 2c19766ebf09..29529c2ecac9 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > @@ -20,6 +20,18 @@ chosen {
> >                 stdout-path = &uart2;
> >         };
> >  
> > +       hdmi-connector {
> > +               compatible = "hdmi-connector";
> > +               label = "hdmi";
> > +               type = "a";
> > +
> > +               port {
> > +                       hdmi_connector_in: endpoint {
> > +                               remote-endpoint = <&hdmi_tx_out>;
> > +                       };
> > +               };
> > +       };
> > +
> 
> Interesting. My patch missed this. But it looks correct.
> 
> >         leds {
> >                 compatible = "gpio-leds";
> >                 pinctrl-names = "default";
> > @@ -94,6 +106,28 @@ ethphy0: ethernet-phy@0 { /* RTL8211E */
> >         };
> >  };
> >  
> > +&hdmi_pvi {
> > +       status = "okay";
> > +};
> > +
> > +&hdmi_tx {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_hdmi>;
> > +       status = "okay";
> > +
> > +       ports {
> > +               port@1 {
> > +                       hdmi_tx_out: endpoint {
> > +                               remote-endpoint = <&hdmi_connector_in>;
> > +                       };
> > +               };
> > +       };
> > +};
> > +
> > +&hdmi_tx_phy {
> > +       status = "okay";
> > +};
> > +
> >  &i2c1 {
> >         clock-frequency = <400000>;
> >         pinctrl-names = "default";
> > @@ -241,6 +275,10 @@ &i2c6 {
> >         status = "okay";
> >  };
> >  
> > +&lcdif3 {
> > +       status = "okay";
> > +};
> > +
> 
> Except for the addition of the connector, the above matches my patch to
> here.
> 
> >  &snvs_pwrkey {
> >         status = "okay";
> >  };
> 
> But in my patch I have the following hunk here: (I haven't checked to
> see if this still applies on mainline, so take with a pinch of salt if
> it's not there!)
> 
> 
>  &iomuxc {
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_hog>;
> -
> -	pinctrl_hog: hoggrp {
> -		fsl,pins = <
> -			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL					0x400001c3
> -			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA					0x400001c3
> -			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD						0x40000019
> -			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC						0x40000019
> -		>;
> -	};
> 
>  	pinctrl_eqos: eqosgrp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC							0x3
>  			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO						0x3
> 
> 
> > @@ -358,6 +396,15 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16                              0x19
> >                 >;
> >         };
> >  
> > +       pinctrl_hdmi: hdmigrp {
> > +               fsl,pins = <
> > +                       MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL                     0x400001c3
> > +                       MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA                     0x400001c3
> > +                       MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD                         0x40000019
> > +                       MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC                         0x40000019
> > +               >;
> > +       };
> > +
> 
> And my addition here is :
> 
> 
> +	pinctrl_hdmi: hdmigrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c3
> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c3
> +			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x19
> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x19
> +		>;
> +	};
> +
> 
> 
> I haven't looked into what the 0x40000000 does yet, but just
> highlighting the difference from the version I've been using to make use
> of HDMI so far.
> 
> Does anyone else know the impact here? Otherwise I'll try to find time
> to check this later. (For some undefined term of later...)

In drivers/pinctrl/freescale/pinctrl-imx.c,

#define IMX_NO_PAD_CTL  0x80000000      /* no pin config need */
#define IMX_PAD_SION 0x40000000         /* set SION */

The SION (Software Input ON) bit forces the input path active for the
pin. This can be used, for instance, to capture through GPIO the value
of a pin driven by a module. I'm not sure that's needed here.

> >         pinctrl_i2c1: i2c1grp {
> >                 fsl,pins = <
> >                         MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL                                 0x400001c2

-- 
Regards,

Laurent Pinchart

