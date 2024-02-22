Return-Path: <linux-kernel+bounces-76078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3085F2A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE199B2226E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62215199AD;
	Thu, 22 Feb 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kBRuk0xG"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694861862A;
	Thu, 22 Feb 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589958; cv=none; b=tEpD1etC+n5mMTkfdztPPb0PT3h27Z5OjN5tWY9AontRv0xwU88zrcKanwi/zb35DN0sINHkklyC3LGxdeQJ/EDz9plXfO7Wf31vJg1mLcH8GyIv1ytB95xDq8hpbozCHihJJlm/dOFJ/hKdmO+UegKWMBmIiJs1EkBQkalL8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589958; c=relaxed/simple;
	bh=Ny1htodYHeVyWUPdhR/T5G2WLZQaM6SbQ8uB6xWNbJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pec/YWutx7RBGz8+P9X7V17OY7IrjDgA8/t20L+AgzABxJzZbiD8mDzVmoCXz2mM/K9A9zOdRB3ZjdDCiepnzGaFRRNbXSx/fbNOfPoQ27pH1H4Qd+11xS9k57lEtPwgWvxS8CotNFDSsFFQOIWksvYuTFfSTskOIY+iX06OxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kBRuk0xG; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1AA7240002;
	Thu, 22 Feb 2024 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708589952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SC+AXNTWiEuwN1cNmfVZqIbghyjFU4JFmVJRHzXCRxg=;
	b=kBRuk0xGHshBTSwtsfyEB3UzGAtnHGhhjHF7yXUTTHNfKcQ92o+uWXHcNhm7IOxK12n8KW
	Hkp6KV0izPKXCGL5kEUMlyZzWkOH+uAXK61frnJvQt78kry6/DLNKh8dJ6xQjbHuNZQG/Z
	npHWymGqlxRIVI/NFSBhF1cgX8WipJz7LP98TaHNqaX+yZT81B2n+LbFpMCZZkcV2PhjB4
	3dFMpHWuNUEWvsYGeSp7g8X6dsNJECm1eI/mJKM/B7Oy7wnpc3ivRfAibD+Lg67aOEcBLP
	i73UdigSFwKrcbgcBiUohi0Gro+2KW3KQKCFuWJIg4UZ31zeUJ6raSx8wDLq1Q==
Date: Thu, 22 Feb 2024 09:19:06 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>, Marek Vasut
 <marex@denx.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 5/6] arm64: dts: imx8mp: add HDMI display pipeline
Message-ID: <20240222091906.1bd13c03@booty>
In-Reply-To: <20240218041649.1209173-6-aford173@gmail.com>
References: <20240218041649.1209173-1-aford173@gmail.com>
	<20240218041649.1209173-6-aford173@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Adam,

On Sat, 17 Feb 2024 22:16:43 -0600
Adam Ford <aford173@gmail.com> wrote:

> From: Lucas Stach <l.stach@pengutronix.de>
> 
> This adds the DT nodes for all the peripherals that make up the
> HDMI display pipeline.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> V5:  No change
> 
> V3:  Re-ordered the HDMI parts to properly come after irqstree_hdmi
>      inside AIPS4.  Change size of LCDIF3 and PVI to match TRM sizes
>      of 4KB.
> 
> V2:  I took this from Lucas' original submission with the following:
>      Removed extra clock from HDMI-TX since it is now part of the
>      power domain
>      Added interrupt-parent to PVI
>      Changed the name of the HDMI tranmitter to fsl,imx8mp-hdmi-tx
>      Added ports to HDMI-tx
> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 94 +++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index cbb15ded4a74..433ea4ae6a16 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1940,6 +1940,100 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
>  				clock-names = "ipg";
>  				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_IRQSTEER>;
>  			};
> +
> +			hdmi_pvi: display-bridge@32fc4000 {
> +				compatible = "fsl,imx8mp-hdmi-pvi";
> +				reg = <0x32fc4000 0x1000>;
> +				interrupt-parent = <&irqsteer_hdmi>;
> +				interrupts = <12>;
> +				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PVI>;

After a small annoyance in my testing I realized here there should be:

  status = "disabled";

> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +						pvi_from_lcdif3: endpoint {
> +							remote-endpoint = <&lcdif3_to_pvi>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						pvi_to_hdmi_tx: endpoint {
> +							remote-endpoint = <&hdmi_tx_from_pvi>;
> +						};
> +					};
> +				};
> +			};
> +
> +			lcdif3: display-controller@32fc6000 {
> +				compatible = "fsl,imx8mp-lcdif";
> +				reg = <0x32fc6000 0x1000>;
> +				interrupt-parent = <&irqsteer_hdmi>;
> +				interrupts = <8>;
> +				clocks = <&hdmi_tx_phy>,
> +					 <&clk IMX8MP_CLK_HDMI_APB>,
> +					 <&clk IMX8MP_CLK_HDMI_ROOT>;
> +				clock-names = "pix", "axi", "disp_axi";
> +				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_LCDIF>;

Here as well:

  status = "disabled";

With those fixed you can add my:

 Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

