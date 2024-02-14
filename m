Return-Path: <linux-kernel+bounces-65083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C602854791
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB5D1C22B66
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851F718C28;
	Wed, 14 Feb 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="oAl2KAv9"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0C18638;
	Wed, 14 Feb 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907963; cv=none; b=auQK4CbBVCtnFxXyaFNxp7Qz0o6RDtewRKcYAHt0T6PquO2ULtDHtwCdlE/EgNQBWUXplcRtB7G6MUgCC57lm3IJxFQjBHFcjGT+yZcoR9wcE8mFWTjyO2CDKFVlxjoMhrjSSh+O+SJd/w1Gsvq9r0QSwAtl+iMSNo7q/PRjnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907963; c=relaxed/simple;
	bh=aBaw8zzSOYKdXSP4WFB7oN6QAraRJxc+J8ue3z3jQPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4Dd9WQrhoMgBg4BXPSOrdBflCnsSl+eNtQ0IlrT1ydpd47KQ0jmiQRJ7yjZRbP6+Xh9yXwwvlMLGCUVjBesrE114cg28Lwo5rtp5NYF9FEOeK4pdoq7SjpU2i5oQEUHP5D5vg8uOHeXPTtIg0fp/9Lah9HRYuqjC22uiH+HZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=oAl2KAv9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id EEE8120272;
	Wed, 14 Feb 2024 11:52:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707907951;
	bh=3piN2479mTbGHmItuCrKboZS6ZZmmMJocdeKlE4lYoE=; h=From:To:Subject;
	b=oAl2KAv9Kq22FWnYKpuVm7S8yQAERPms1HXNxtnhCAb1VQsKEm6h+7T4DoHJJ83p+
	 Pr/E70uV1Q4fDGsd5DmS1l3z9qS5LELsTRZ0rGOUlAghjM2qvRi2iLGQnle0ANkJdR
	 ZHtgIMsf479bU24I5iHEXsJpqRwRsI2/9GjWLsAFD539zRjjzOYXhxTOyaxEojcSSN
	 wUzHKVPplmA5iYL5xyGZipDc0nOVO5ID5rIWB7gZ25qMylzIuo9C61U1htvN2BL+b9
	 JxI6Wu6H+V9L1R34yQyfU4Fcbm6rWXls6lqLsFPUQ484YJQGC6rPsqXtmFkGAYPihJ
	 SEIXw8b8X/2Fg==
Date: Wed, 14 Feb 2024 11:52:23 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Roland Hieber <rhi@pengutronix.de>,
	Linux Regressions <regressions@lists.linux.dev>
Cc: Hiago De Franco <hiagofranco@gmail.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: MXSFB error: -ENODEV: Cannot connect bridge
Message-ID: <20240214105223.GA78582@francesco-nb>
References: <34yzygh3mbwpqr2re7nxmhyxy3s7qmqy4vhxvoyxnoguktriur@z66m7gvpqlia>
 <20240212110706.ibrreoj2wgzhltyw@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212110706.ibrreoj2wgzhltyw@pengutronix.de>

+ Linux regression.

This is a regression on v6.8-rc1.

On Mon, Feb 12, 2024 at 12:07:06PM +0100, Roland Hieber wrote:
> On Thu, Feb 08, 2024 at 12:58:02PM -0300, Hiago De Franco wrote:
> > Hello all,
> > 
> > while doing some tests with kernel v6.8-rc3 and Colibri iMX7D, we
> > noticed the following error:
> > 
> > [    0.432547] mxsfb 30730000.lcdif: error -ENODEV: Cannot connect bridge
> > 
> > This was introduced by commit edbbae7fba495284f72f05768696572691231558
> > ("ARM: dts: imx7: add MIPI-DSI support"). This patch is routing the
> > lcdif to the mipi_dsi_in_lcdif endpoint, however we do not have the DSI
> > pins available in our edge connector. Instead, we use the parallel RGB
> > LCD interface directly with, as example, an external LVDS transmitter:
> > 
> > &lcdif {
> > ...
> > 	status = "disabled";
> > 
> > 	port {
> > 		lcdif_out: endpoint {
> > 			remote-endpoint = <&lcd_panel_in>;
> > 		};
> > 	};
> > };
> > 
> > By applying the following patch, the issue is gone and the LVDS works
> > again:
> > 
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
> > index ebf7befcc11e..9c81c6baa2d3 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/imx7s.dtsi
> > @@ -834,16 +834,6 @@ lcdif: lcdif@30730000 {
> >  					<&clks IMX7D_LCDIF_PIXEL_ROOT_CLK>;
> >  				clock-names = "pix", "axi";
> >  				status = "disabled";
> > -
> > -				port {
> > -					#address-cells = <1>;
> > -					#size-cells = <0>;
> > -
> > -					lcdif_out_mipi_dsi: endpoint@0 {
> > -						reg = <0>;
> > -						remote-endpoint = <&mipi_dsi_in_lcdif>;
> > -					};
> > -				};
> >  			};
> >  
> >  			mipi_csi: mipi-csi@30750000 {
> > @@ -895,22 +885,6 @@ mipi_dsi: dsi@30760000 {
> >  				samsung,esc-clock-frequency = <20000000>;
> >  				samsung,pll-clock-frequency = <24000000>;
> >  				status = "disabled";
> > -
> > -				ports {
> > -					#address-cells = <1>;
> > -					#size-cells = <0>;
> > -
> > -					port@0 {
> > -						reg = <0>;
> > -						#address-cells = <1>;
> > -						#size-cells = <0>;
> > -
> > -						mipi_dsi_in_lcdif: endpoint@0 {
> > -							reg = <0>;
> > -							remote-endpoint = <&lcdif_out_mipi_dsi>;
> > -						};
> > -					};
> > -				};
> >  			};
> >  		};
> > 
> > I would like to know your opinion about this patch before sending it,
> > does it makes sense for you? I understand that routing to endpoint
> > should be done in the SoM device tree, so we are free to rout other
> > endpoint without issues.
> 
> As far as I understood, the LCDIF -> DSI connection is always present in
> the SoC. Can you overwrite the routing in your dts like this:?
> 
>     &lcdif_out_mipi_dsi {
>         remote-endpoint = <&lcd_panel_in>;
>     };
> 
> I'm not sure what is the best default solution here for imx7s.dtsi. Also
> the labels don't work out in that case, this could be improved.

For sure for something to be defined a solution it should not introduce
regressions :-)

This commit makes other boards not work anymore, specifically this
reports is about colibri-imx7.

With that said, the following patch solves the issue

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
index 9fe51884af79..966ad13e7c78 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi
@@ -536,12 +536,15 @@ &lcdif {
        status = "disabled";

        port {
-               lcdif_out: endpoint {
+               lcdif_out: endpoint@0 {
+                       reg = <0>;
                        remote-endpoint = <&lcd_panel_in>;
                };
        };
 };

+/delete-node/ &mipi_dsi_in_lcdif;
+
 /* Colibri PWM<A> */
 &pwm1 {
        pinctrl-names = "default";


However, ... I do not really like the delete node, but it's required to
prevent this error:

arch/arm/boot/dts/nxp/imx/imx7s.dtsi:908.37-911.9: Warning (graph_endpoint): /soc/bus@30400000/dsi@30760000/ports/port@0/endpoint@0: graph connection to node '/soc/bus@30400000/lcdif@30730000/port/endpoint@0' is not bidirectional

With that said, unless you have a better solution I would just send a
revert for your change.

Francesco


