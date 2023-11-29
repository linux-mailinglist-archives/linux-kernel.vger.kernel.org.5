Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B6E7FD0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjK2I2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2I2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:28:48 -0500
Received: from mail-m17207.xmail.ntesmail.com (mail-m17207.xmail.ntesmail.com [45.195.17.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0105919B0;
        Wed, 29 Nov 2023 00:28:53 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=Qq6K9775/nBsiVQJ4BXZyTcD+50uTadoc3TZZYEurfENxFZWeUb6lsMbFlNQp19V2GWZYA4CR7hxCQq3OvlIcAU0vPsd4ja89GOqSDcbXGJKP4X37H5560HXSOmA0wNL7k8Zx7j62d7Jjn8f/YsuEsW8GUfnrtAFFvW5iYDHnQY=;
        c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
        bh=aGpoJTy0YujP1OdkZ9q++euEDnLzMZVFRb/6ZJxkj40=;
        h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.141] (unknown [58.22.7.114])
        by mail-m12779.qiye.163.com (Hmail) with ESMTPA id 934D97801C2;
        Wed, 29 Nov 2023 16:28:19 +0800 (CST)
Message-ID: <40b9e4cf-620c-4c7c-8e70-8959dec755c8@rock-chips.com>
Date:   Wed, 29 Nov 2023 16:28:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] drm/rockchip: vop2: Add support for rk3588
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>, Andy Yan <andyshrk@163.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com
References: <20231122125316.3454268-1-andyshrk@163.com>
 <20231122125544.3454918-1-andyshrk@163.com>
 <20231127111937.GW3359458@pengutronix.de>
From:   Andy Yan <andy.yan@rock-chips.com>
In-Reply-To: <20231127111937.GW3359458@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0waS1YYHRhOSR1IQkxLH0xVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
        kG
X-HM-Tid: 0a8c1a317c5cb24fkuuu934d97801c2
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxg6SAw5Pzw#LBNRVhRPUTEw
        Sz4wCyxVSlVKTEtKSU9NTktLTktDVTMWGhIXVRoVHwJVAhoVOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBT0lNSjcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

On 11/27/23 19:19, Sascha Hauer wrote:
> Hi Andy,
>
> Looks good overall, two small things inside.
>
> On Wed, Nov 22, 2023 at 08:55:44PM +0800, Andy Yan wrote:
>>   
>> +#define vop2_output_if_is_hdmi(x)	(x == ROCKCHIP_VOP2_EP_HDMI0 || x == ROCKCHIP_VOP2_EP_HDMI1)
>> +#define vop2_output_if_is_dp(x)		(x == ROCKCHIP_VOP2_EP_DP0 || x == ROCKCHIP_VOP2_EP_DP1)
>> +#define vop2_output_if_is_edp(x)	(x == ROCKCHIP_VOP2_EP_EDP0 || x == ROCKCHIP_VOP2_EP_EDP1)
>> +#define vop2_output_if_is_mipi(x)	(x == ROCKCHIP_VOP2_EP_MIPI0 || x == ROCKCHIP_VOP2_EP_MIPI1)
>> +#define vop2_output_if_is_lvds(x)	(x == ROCKCHIP_VOP2_EP_LVDS0 || x == ROCKCHIP_VOP2_EP_LVDS1)
>> +#define vop2_output_if_is_dpi(x)	(x == ROCKCHIP_VOP2_EP_RGB0)
> Not that it matters in practice here, but you should add braces around
> the x argument in the macros usage, i.e. ((x) == ROCKCHIP_VOP2_EP_RGB0)
Okay , will do.
>> +static unsigned long rk3588_set_intf_mux(struct vop2_video_port *vp, int id, u32 polflags)
>> +{
>> +	struct vop2 *vop2 = vp->vop2;
>> +	int dclk_core_div, dclk_out_div, if_pixclk_div, if_dclk_div;
>> +	unsigned long clock;
>> +	u32 die, dip, div, vp_clk_div, val;
>> +
>> +	clock = rk3588_calc_cru_cfg(vp, id, &dclk_core_div, &dclk_out_div,
>> +				    &if_pixclk_div, &if_dclk_div);
>> +	if (!clock)
>> +		return 0;
>> +
>> +	vp_clk_div = FIELD_PREP(RK3588_VP_CLK_CTRL__DCLK_CORE_DIV, dclk_core_div);
>> +	vp_clk_div |= FIELD_PREP(RK3588_VP_CLK_CTRL__DCLK_OUT_DIV, dclk_out_div);
>> +
>> +	die = vop2_readl(vop2, RK3568_DSP_IF_EN);
>> +	dip = vop2_readl(vop2, RK3568_DSP_IF_POL);
>> +	div = vop2_readl(vop2, RK3568_DSP_IF_CTRL);
>> +
>> +	switch (id) {
>> +	case ROCKCHIP_VOP2_EP_HDMI0:
>> +		div |= FIELD_PREP(RK3588_DSP_IF_EDP_HDMI0_DCLK_DIV, if_dclk_div);
> you should clear the bits of a mask before setting them again. The same
> goes for several other bits modified in this switch/case.


Thanks for catching this, will fixed in next version.

>
>> +		div |= FIELD_PREP(RK3588_DSP_IF_EDP_HDMI0_PCLK_DIV, if_pixclk_div);
>> +		die &= ~RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX;
>> +		die |= RK3588_SYS_DSP_INFACE_EN_HDMI0 |
>> +			    FIELD_PREP(RK3588_SYS_DSP_INFACE_EN_EDP_HDMI0_MUX, vp->id);
>> +		val = rk3588_get_hdmi_pol(polflags);
>> +		regmap_write(vop2->vop_grf, RK3588_GRF_VOP_CON2, HIWORD_UPDATE(1, 1, 1));
>> +		regmap_write(vop2->vo1_grf, RK3588_GRF_VO1_CON0, HIWORD_UPDATE(val, 6, 5));
>> +		break;
> Sascha
>
