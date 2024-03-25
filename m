Return-Path: <linux-kernel+bounces-117344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A447E88AA3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4378B1F288B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B033F9ED;
	Mon, 25 Mar 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Rcg6XqTn"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC821373;
	Mon, 25 Mar 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379651; cv=none; b=XIX8EMh4anA/MSF4cosN//SZqDa2qGCN6oL2Vss5E/6qIAp1yLWJrS6kSjbHzovXc3G9BeIAFVp4dO4nw35oYBh1nMSKVkML99hQgqaU7FM++d3r3Iijlm0tzN9cwrzShEKROrbyMiFaeY9LXzQPCzUCNpY+jogdI+rIQszC424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379651; c=relaxed/simple;
	bh=PzYgqO2j7ARM9Bcg4w9L6keBbuWdl2jRvP/eRb+K7mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iknnA+kcOANNOkmkq/qZpe9TWAAvEEAosMBYH1YtduxZa6eaGOpKM9sqjrtYCb3svo1cvVpkh7jXxKip6UWelbEf28vzhHgqkkSo/rKKfDxNt1pDqEnHUhvCmGCV9Gy443lYBWsH0tyjuNLhOD9t4rniCxuFVyQj1uOz78t/kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Rcg6XqTn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DE8767E4;
	Mon, 25 Mar 2024 16:13:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711379617;
	bh=PzYgqO2j7ARM9Bcg4w9L6keBbuWdl2jRvP/eRb+K7mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rcg6XqTnYwnClxCdZ69f0XzSzvHMRyj45uCqlXW7HJuUu7+RJUBldgOByGNnNP7Nu
	 ypsNnBWZvTy4Jxujkx/1mOi3vfocLG1ANA11nc4LLBn6/xrZ4sJM0AA9o20dT/b+aS
	 kfNFzcRTp7d8QWbY+bINUaPJEw65BNCAESCzvEQE=
Date: Mon, 25 Mar 2024 17:14:02 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Adam Ford <aford173@gmail.com>
Cc: Paul Elder <paul.elder@ideasonboard.com>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Marek Vasut <marex@denx.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Add DT nodes for the two ISPs
Message-ID: <20240325151402.GW18799@pendragon.ideasonboard.com>
References: <20231129093113.255161-1-paul.elder@ideasonboard.com>
 <20231129093113.255161-2-paul.elder@ideasonboard.com>
 <CAHCN7xLOu5qfxNihEYuSXxuxxH=S_+7nDkX1H=ziDW3QvaErQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xLOu5qfxNihEYuSXxuxxH=S_+7nDkX1H=ziDW3QvaErQA@mail.gmail.com>

Hi Adam,

On Wed, Mar 20, 2024 at 07:35:46AM -0500, Adam Ford wrote:
> On Wed, Nov 29, 2023 at 3:31 AM Paul Elder wrote:
> >
> > The ISP supports both CSI and parallel interfaces, where port 0
> > corresponds to the former and port 1 corresponds to the latter. Since
> > the i.MX8MP's ISPs are connected by the parallel interface to the CSI
> > receiver, set them both to port 1.
> >
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> 
> Paul, are you able to resend this now that the driver part has been
> merged into the main branch?
> 
> If you can't, I can resend it on your behalf.

I've just sent a v2, you're on CC.

> > ---
> >  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 50 +++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > index c9a610ba4836..25579d4c58f2 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> > @@ -1604,6 +1604,56 @@ isi_in_1: endpoint {
> >                                 };
> >                         };
> >
> > +                       isp_0: isp@32e10000 {
> > +                               compatible = "fsl,imx8mp-isp";
> > +                               reg = <0x32e10000 0x10000>;
> > +                               interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>,
> > +                                        <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
> > +                                        <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
> > +                               clock-names = "isp", "aclk", "hclk";
> > +                               assigned-clocks = <&clk IMX8MP_CLK_MEDIA_ISP>;
> > +                               assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_500M>;
> > +                               assigned-clock-rates = <500000000>;
> > +                               power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_ISP>;
> > +                               fsl,blk-ctrl = <&media_blk_ctrl 0>;
> > +                               status = "disabled";
> > +
> > +                               ports {
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +
> > +                                       port@1 {
> > +                                               reg = <1>;
> > +                                       };
> > +                               };
> > +                       };
> > +
> > +                       isp_1: isp@32e20000 {
> > +                               compatible = "fsl,imx8mp-isp";
> > +                               reg = <0x32e20000 0x10000>;
> > +                               interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> > +                               clocks = <&clk IMX8MP_CLK_MEDIA_ISP_ROOT>,
> > +                                        <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
> > +                                        <&clk IMX8MP_CLK_MEDIA_APB_ROOT>;
> > +                               clock-names = "isp", "aclk", "hclk";
> > +                               assigned-clocks = <&clk IMX8MP_CLK_MEDIA_ISP>;
> > +                               assigned-clock-parents = <&clk IMX8MP_SYS_PLL2_500M>;
> > +                               assigned-clock-rates = <500000000>;
> > +                               power-domains = <&media_blk_ctrl IMX8MP_MEDIABLK_PD_ISP>;
> > +                               fsl,blk-ctrl = <&media_blk_ctrl 1>;
> > +                               status = "disabled";
> > +
> > +                               ports {
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +
> > +                                       port@1 {
> > +                                               reg = <1>;
> > +                                       };
> > +                               };
> > +                       };
> > +
> >                         dewarp: dwe@32e30000 {
> >                                 compatible = "nxp,imx8mp-dw100";
> >                                 reg = <0x32e30000 0x10000>;

-- 
Regards,

Laurent Pinchart

