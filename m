Return-Path: <linux-kernel+bounces-82866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F021E868ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE1F1C216E3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FFB12FB18;
	Tue, 27 Feb 2024 08:33:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1E7B3D3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 08:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022815; cv=none; b=KIeegvXqwXOTE2Q1YUHmnDu7iwyeQd98HTFUdmj+0eTE5+QTmC0/DlWvbeiooHJuREhchhaQr2zTH+W0I+d9m0bQ/JzmbFkQw7NlBRkQx55xLHxkMYZZxmjIFzAbIsxjWoPD/+CclpAs3MtrWaR90WnRxigtDNGOnAer4MrlXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022815; c=relaxed/simple;
	bh=rW7fAbIhtIRH6uFf53KwWwv4BvDxmE1+BtDpctFXvJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcHg0ELTaKxfkLlDBdjgxqcsJl/X3gyTEu1vSSYFhGrpg0U2hDqDcb6fGlZ+9/BWwkFYaz+mXFhKVU7oTClg9riAgKqk4wN6hH06Bf5NdKNfZXHD/7hUGEAL0cMeEgORfIKkvM/pW6j9jbWTuXUS8EJwGYYUUU5EK223Oq4J68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1resta-0001UR-RL; Tue, 27 Feb 2024 09:33:02 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1restZ-0039fx-Ie; Tue, 27 Feb 2024 09:33:01 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1restZ-00AXPK-1V;
	Tue, 27 Feb 2024 09:33:01 +0100
Date: Tue, 27 Feb 2024 09:33:01 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>,
	aford@beaconembedded.com, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	devicetree@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH V6 5/6] arm64: dts: imx8mp: add HDMI display pipeline
Message-ID: <20240227083301.4saxxuv4n6aoqnl6@pengutronix.de>
References: <20240226234532.80114-1-aford173@gmail.com>
 <20240226234532.80114-6-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226234532.80114-6-aford173@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Adam,

thanks a lot for pushing this topic.

On 24-02-26, Adam Ford wrote:
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
> V6:  Make LCDIF3 disabled by default
> 
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
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 95 +++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> index 18bfa7d9aa7f..637b0265b0f1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1940,6 +1940,101 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
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

this node should be 'status = "disabled";' as reported by Luca else this
node will EPROBE_DEFER. With that beeing fixed you can add my:

Tested-by: Marco Felsch <m.felsch@pengutronix.de>

Regards,
  Marco

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
> +				status = "disabled";
> +
> +				port {
> +					lcdif3_to_pvi: endpoint {
> +						remote-endpoint = <&pvi_from_lcdif3>;
> +					};
> +				};
> +			};
> +
> +			hdmi_tx: hdmi@32fd8000 {
> +				compatible = "fsl,imx8mp-hdmi-tx";
> +				reg = <0x32fd8000 0x7eff>;
> +				interrupt-parent = <&irqsteer_hdmi>;
> +				interrupts = <0>;
> +				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
> +					 <&clk IMX8MP_CLK_HDMI_REF_266M>,
> +					 <&clk IMX8MP_CLK_32K>,
> +					 <&hdmi_tx_phy>;
> +				clock-names = "iahb", "isfr", "cec", "pix";
> +				assigned-clocks = <&clk IMX8MP_CLK_HDMI_REF_266M>;
> +				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>;
> +				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
> +				reg-io-width = <1>;
> +				status = "disabled";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@0 {
> +						reg = <0>;
> +
> +						hdmi_tx_from_pvi: endpoint {
> +							remote-endpoint = <&pvi_to_hdmi_tx>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						/* Point endpoint to the HDMI connector */
> +					};
> +				};
> +			};
> +
> +			hdmi_tx_phy: phy@32fdff00 {
> +				compatible = "fsl,imx8mp-hdmi-phy";
> +				reg = <0x32fdff00 0x100>;
> +				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
> +					 <&clk IMX8MP_CLK_HDMI_24M>;
> +				clock-names = "apb", "ref";
> +				assigned-clocks = <&clk IMX8MP_CLK_HDMI_24M>;
> +				assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
> +				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX_PHY>;
> +				#clock-cells = <0>;
> +				#phy-cells = <0>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		pcie: pcie@33800000 {
> -- 
> 2.43.0
> 
> 
> 

