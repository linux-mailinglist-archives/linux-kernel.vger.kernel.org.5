Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1D7F9E67
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjK0LTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbjK0LTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:19:45 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6AD135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 03:19:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1r7ZeO-0000ed-Kg; Mon, 27 Nov 2023 12:19:40 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1r7ZeL-00BvgR-89; Mon, 27 Nov 2023 12:19:37 +0100
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1r7ZeL-00459o-52; Mon, 27 Nov 2023 12:19:37 +0100
Date:   Mon, 27 Nov 2023 12:19:37 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Andy Yan <andyshrk@163.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 10/12] drm/rockchip: vop2: Add support for rk3588
Message-ID: <20231127111937.GW3359458@pengutronix.de>
References: <20231122125316.3454268-1-andyshrk@163.com>
 <20231122125544.3454918-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122125544.3454918-1-andyshrk@163.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Looks good overall, two small things inside.

On Wed, Nov 22, 2023 at 08:55:44PM +0800, Andy Yan wrote:
>  
> +#define vop2_output_if_is_hdmi(x)	(x == ROCKCHIP_VOP2_EP_HDMI0 || x == ROCKCHIP_VOP2_EP_HDMI1)
> +#define vop2_output_if_is_dp(x)		(x == ROCKCHIP_VOP2_EP_DP0 || x == ROCKCHIP_VOP2_EP_DP1)
> +#define vop2_output_if_is_edp(x)	(x == ROCKCHIP_VOP2_EP_EDP0 || x == ROCKCHIP_VOP2_EP_EDP1)
> +#define vop2_output_if_is_mipi(x)	(x == ROCKCHIP_VOP2_EP_MIPI0 || x == ROCKCHIP_VOP2_EP_MIPI1)
> +#define vop2_output_if_is_lvds(x)	(x == ROCKCHIP_VOP2_EP_LVDS0 || x == ROCKCHIP_VOP2_EP_LVDS1)
> +#define vop2_output_if_is_dpi(x)	(x == ROCKCHIP_VOP2_EP_RGB0)

Not that it matters in practice here, but you should add braces around
the x argument in the macros usage, i.e. ((x) == ROCKCHIP_VOP2_EP_RGB0)

> +static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32 polflags)
> +{
> +	struct vop2 *vop2 = vp->vop2;
> +	int dclk_core_div, dclk_out_div, if_pixclk_div, if_dclk_div;
> +	unsigned long clock;
> +	u32 die, dip, div, vp_clk_div, val;
> +
> +	clock = rk3588_calc_cru_cfg(vp, id, &dclk_core_div, &dclk_out_div,
> +				    &if_pixclk_div, &if_dclk_div);
> +	if (!clock)
> +		return 0;
> +
> +	vp_clk_div = FIELD_PREP(RK3588_VP_CLK_CTRL__DCLK_CORE_DIV, dclk_core_div);
> +	vp_clk_div |= FIELD_PREP(RK3588_VP_CLK_CTRL__DCLK_OUT_DIV, dclk_out_div);
> +
> +	die = vop2_readl(vop2, RK3568_DSP_IF_EN);
> +	dip = vop2_readl(vop2, RK3568_DSP_IF_POL);
> +	div = vop2_readl(vop2, RK3568_DSP_IF_CTRL);
> +
> +	switch (id) {
> +	case ROCKCHIP_VOP2_EP_HDMI0:
> +		div |= FIELD_PREP(RK3588_DSP_IF_EDP_HDMI0_DCLK_DIV, if_dclk_div);

you should clear the bits of a mask before setting them again. The same
goes for several other bits modified in this switch/case.

> +		div |= FIELD_PREP(RK3588_DSP_IF_EDP_HDMI0_PCLK_DIV, if_pixclk_div);
> +		die &= ~RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX;
> +		die |= RK3588_SYS_DSP_INFACE_EN_HDMI0 |
> +			    FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX, vp->id);
> +		val = rk3588_get_hdmi_pol(polflags);
> +		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 1, 1));
> +		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0, HIWORD_UPDATE(val, 6, 5));
> +		break;

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
