Return-Path: <linux-kernel+bounces-61393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AB8511CE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DDD1F275BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9D838FAA;
	Mon, 12 Feb 2024 11:07:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B7A38FA1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736051; cv=none; b=jx0UNIW7cZbVwQKJBdhpJWgd65eke7IxSrk7U8Wv1/WHXOnzc0jEvZGGuJrsm9X45BguUNchhJGQb3L2uEr2EWuyvPXL1ziYSy1r8zvdpak3mJrSqJWsnOhbqnORkknyEOnzTiAYQW8RSZUP7w5RnICfm9zy7DTK2e+hiqRV5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736051; c=relaxed/simple;
	bh=CJYpcUz/mDIle68G32xKDYs2BkutrIVbb99+jmtLCqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0/Go8x9iLx3rQdQqffMV6k5IhJrQelpTtUu+Y7JluAwnZAKH4uUYgzp1YWC6ZLjdmXWW37WASwQQvw3XBe6BzvA6vKVhrs5VYJgkDGXwHxhxuahGu8qNUNWXSeNRn+gz09CNvCoLkdJQsyRpksz2OeEl6WHc68fkcxyDS3YitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rhi@pengutronix.de>)
	id 1rZU9T-0001Ye-Gl; Mon, 12 Feb 2024 12:07:07 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rhi@pengutronix.de>)
	id 1rZU9T-000Gmu-1w; Mon, 12 Feb 2024 12:07:07 +0100
Received: from rhi by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rhi@pengutronix.de>)
	id 1rZU9S-005YSa-36;
	Mon, 12 Feb 2024 12:07:06 +0100
Date: Mon, 12 Feb 2024 12:07:06 +0100
From: Roland Hieber <rhi@pengutronix.de>
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: MXSFB error: -ENODEV: Cannot connect bridge
Message-ID: <20240212110706.ibrreoj2wgzhltyw@pengutronix.de>
References: <34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rhi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2024 at 12:58:02PM -0300, Hiago De Franco wrote:
> Hello all,
> 
> while doing some tests with kernel v6.8-rc3 and Colibri iMX7D, we
> noticed the following error:
> 
> [    0.432547] mxsfb 30730000.lcdif: error -ENODEV: Cannot connect bridge
> 
> This was introduced by commit edbbae7fba495284f72f05768696572691231558
> ("ARM: dts: imx7: add MIPI-DSI support"). This patch is routing the
> lcdif to the mipi_dsi_in_lcdif endpoint, however we do not have the DSI
> pins available in our edge connector. Instead, we use the parallel RGB
> LCD interface directly with, as example, an external LVDS transmitter:
> 
> &lcdif {
> ...
> 	status = "disabled";
> 
> 	port {
> 		lcdif_out: endpoint {
> 			remote-endpoint = <&lcd_panel_in>;
> 		};
> 	};
> };
> 
> By applying the following patch, the issue is gone and the LVDS works
> again:
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
> index ebf7befcc11e..9c81c6baa2d3 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
> @@ -834,16 +834,6 @@ lcdif: lcdif@30730000 {
>  					<&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>;
>  				clock-names = "pix", "axi";
>  				status = "disabled";
> -
> -				port {
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					lcdif_out_mipi_dsi: endpoint@0 {
> -						reg = <0>;
> -						remote-endpoint = <&mipi_dsi_in_lcdif>;
> -					};
> -				};
>  			};
>  
>  			mipi_csi: mipi-csi@30750000 {
> @@ -895,22 +885,6 @@ mipi_dsi: dsi@30760000 {
>  				samsung,esc-clock-frequency = <20000000>;
>  				samsung,pll-clock-frequency = <24000000>;
>  				status = "disabled";
> -
> -				ports {
> -					#address-cells = <1>;
> -					#size-cells = <0>;
> -
> -					port@0 {
> -						reg = <0>;
> -						#address-cells = <1>;
> -						#size-cells = <0>;
> -
> -						mipi_dsi_in_lcdif: endpoint@0 {
> -							reg = <0>;
> -							remote-endpoint = <&lcdif_out_mipi_dsi>;
> -						};
> -					};
> -				};
>  			};
>  		};
> 
> I would like to know your opinion about this patch before sending it,
> does it makes sense for you? I understand that routing to endpoint
> should be done in the SoM device tree, so we are free to rout other
> endpoint without issues.

As far as I understood, the LCDIF -> DSI connection is always present in
the SoC. Can you overwrite the routing in your dts like this:?

    &lcdif_out_mipi_dsi {
        remote-endpoint = <&lcd_panel_in>;
    };

I'm not sure what is the best default solution here for imx7s.dtsi. Also
the labels don't work out in that case, this could be improved.

Regards,
 
 - Roland

-- 
Roland Hieber, Pengutronix e.K.          | r.hieber@pengutronix.de     |
Steuerwalder Str. 21                     | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686         | Fax:   +49-5121-206917-5555 |

