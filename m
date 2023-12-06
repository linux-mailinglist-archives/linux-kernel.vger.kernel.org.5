Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF909807042
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378171AbjLFMxS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 07:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:53:16 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B2FA;
        Wed,  6 Dec 2023 04:53:20 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id F1B7080C5;
        Wed,  6 Dec 2023 20:53:13 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 20:53:13 +0800
Received: from [192.168.1.115] (180.164.60.184) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 6 Dec
 2023 20:53:13 +0800
Message-ID: <ed66711a-4c24-40d1-8361-40325ae915f5@starfivetech.com>
Date:   Wed, 6 Dec 2023 20:53:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 4/6] drm/vs: Add KMS crtc&plane
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Shengyang Chen <shengyang.chen@starfivetech.com>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "suijingfeng@loongson.cn" <suijingfeng@loongson.cn>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
 <20231204123315.28456-5-keith.zhao@starfivetech.com>
 <o4ica2jg2rqfx6znir6j7mkoojoqzejjuqvlwcnehanw5mvop6@a3t6vi7c55tz>
From:   Keith Zhao <keith.zhao@starfivetech.com>
In-Reply-To: <o4ica2jg2rqfx6znir6j7mkoojoqzejjuqvlwcnehanw5mvop6@a3t6vi7c55tz>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/6 16:55, Maxime Ripard wrote:
> On Mon, Dec 04, 2023 at 08:33:13PM +0800, Keith Zhao wrote:
>> +static const struct vs_plane_info dc_hw_planes_rev0[PLANE_NUM] = {
>> +	{
>> +		.name			= "Primary",
>> +		.id			= PRIMARY_PLANE_0,
>> +		.type			= DRM_PLANE_TYPE_PRIMARY,
>> +		.num_formats		= ARRAY_SIZE(primary_overlay_format0),
>> +		.formats		= primary_overlay_format0,
>> +		.num_modifiers		= ARRAY_SIZE(format_modifier0),
>> +		.modifiers		= format_modifier0,
>> +		.min_width		= 0,
>> +		.min_height		= 0,
>> +		.max_width		= 4096,
>> +		.max_height		= 4096,
>> +		.rotation		= DRM_MODE_ROTATE_0 |
>> +					  DRM_MODE_ROTATE_90 |
>> +					  DRM_MODE_ROTATE_180 |
>> +					  DRM_MODE_ROTATE_270 |
>> +					  DRM_MODE_REFLECT_X |
>> +					  DRM_MODE_REFLECT_Y,
>> +		.blend_mode		= BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>> +					  BIT(DRM_MODE_BLEND_PREMULTI) |
>> +					  BIT(DRM_MODE_BLEND_COVERAGE),
>> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) |
>> +					  BIT(DRM_COLOR_YCBCR_BT2020),
>> +		.degamma_size		= DEGAMMA_SIZE,
>> +		.min_scale		= FRAC_16_16(1, 3),
>> +		.max_scale		= FRAC_16_16(10, 1),
>> +		.zpos			= 0,
>> +		.watermark		= true,
>> +		.color_mgmt		= true,
>> +		.roi			= true,
>> +	},
>> +	{
>> +		.name			= "Overlay",
>> +		.id			= OVERLAY_PLANE_0,
>> +		.type			= DRM_PLANE_TYPE_OVERLAY,
>> +		.num_formats		= ARRAY_SIZE(primary_overlay_format0),
>> +		.formats		= primary_overlay_format0,
>> +		.num_modifiers		= ARRAY_SIZE(format_modifier0),
>> +		.modifiers		= format_modifier0,
>> +		.min_width		= 0,
>> +		.min_height		= 0,
>> +		.max_width		= 4096,
>> +		.max_height		= 4096,
>> +		.rotation		= DRM_MODE_ROTATE_0 |
>> +					  DRM_MODE_ROTATE_90 |
>> +					  DRM_MODE_ROTATE_180 |
>> +					  DRM_MODE_ROTATE_270 |
>> +					  DRM_MODE_REFLECT_X |
>> +					  DRM_MODE_REFLECT_Y,
>> +		.blend_mode		= BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>> +					  BIT(DRM_MODE_BLEND_PREMULTI) |
>> +					  BIT(DRM_MODE_BLEND_COVERAGE),
>> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) |
>> +					  BIT(DRM_COLOR_YCBCR_BT2020),
>> +		.degamma_size		= DEGAMMA_SIZE,
>> +		.min_scale		= FRAC_16_16(1, 3),
>> +		.max_scale		= FRAC_16_16(10, 1),
>> +		.zpos			= 1,
>> +		.watermark		= true,
>> +		.color_mgmt		= true,
>> +		.roi			= true,
>> +	},
>> +	{
>> +		.name			= "Overlay_1",
>> +		.id			= OVERLAY_PLANE_1,
>> +		.type			= DRM_PLANE_TYPE_OVERLAY,
>> +		.num_formats		= ARRAY_SIZE(primary_overlay_format0),
>> +		.formats		= primary_overlay_format0,
>> +		.num_modifiers		= ARRAY_SIZE(secondary_format_modifiers),
>> +		.modifiers		= secondary_format_modifiers,
>> +		.min_width		= 0,
>> +		.min_height		= 0,
>> +		.max_width		= 4096,
>> +		.max_height		= 4096,
>> +		.rotation		= 0,
>> +		.blend_mode		= BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>> +					  BIT(DRM_MODE_BLEND_PREMULTI) |
>> +					  BIT(DRM_MODE_BLEND_COVERAGE),
>> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) |
>> +					  BIT(DRM_COLOR_YCBCR_BT2020),
>> +		.degamma_size		= DEGAMMA_SIZE,
>> +		.min_scale		= DRM_PLANE_NO_SCALING,
>> +		.max_scale		= DRM_PLANE_NO_SCALING,
>> +		.zpos			= 2,
>> +		.watermark		= true,
>> +		.color_mgmt		= true,
>> +		.roi			= true,
>> +	},
>> +	{
>> +		.name			= "Primary_1",
>> +		.id			= PRIMARY_PLANE_1,
>> +		.type			= DRM_PLANE_TYPE_PRIMARY,
>> +		.num_formats		= ARRAY_SIZE(primary_overlay_format0),
>> +		.formats		= primary_overlay_format0,
>> +		.num_modifiers		= ARRAY_SIZE(format_modifier0),
>> +		.modifiers		= format_modifier0,
>> +		.min_width		= 0,
>> +		.min_height		= 0,
>> +		.max_width		= 4096,
>> +		.max_height		= 4096,
>> +		.rotation		= DRM_MODE_ROTATE_0 |
>> +					  DRM_MODE_ROTATE_90 |
>> +					  DRM_MODE_ROTATE_180 |
>> +					  DRM_MODE_ROTATE_270 |
>> +					  DRM_MODE_REFLECT_X |
>> +					  DRM_MODE_REFLECT_Y,
>> +		.blend_mode		= BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>> +					  BIT(DRM_MODE_BLEND_PREMULTI) |
>> +					  BIT(DRM_MODE_BLEND_COVERAGE),
>> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) |
>> +					  BIT(DRM_COLOR_YCBCR_BT2020),
>> +		.degamma_size		= DEGAMMA_SIZE,
>> +		.min_scale		= FRAC_16_16(1, 3),
>> +		.max_scale		= FRAC_16_16(10, 1),
>> +		.zpos			= 3,
>> +		.watermark		= true,
>> +		.color_mgmt		= true,
>> +		.roi			= true,
>> +	},
>> +	{
>> +		.name			= "Overlay_2",
>> +		.id			= OVERLAY_PLANE_2,
>> +		.type			= DRM_PLANE_TYPE_OVERLAY,
>> +		.num_formats		= ARRAY_SIZE(primary_overlay_format0),
>> +		.formats		= primary_overlay_format0,
>> +		.num_modifiers		= ARRAY_SIZE(format_modifier0),
>> +		.modifiers		= format_modifier0,
>> +		.min_width		= 0,
>> +		.min_height		= 0,
>> +		.max_width		= 4096,
>> +		.max_height		= 4096,
>> +		.rotation		= DRM_MODE_ROTATE_0 |
>> +					  DRM_MODE_ROTATE_90 |
>> +					  DRM_MODE_ROTATE_180 |
>> +					  DRM_MODE_ROTATE_270 |
>> +					  DRM_MODE_REFLECT_X |
>> +					  DRM_MODE_REFLECT_Y,
>> +		.blend_mode		= BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>> +					  BIT(DRM_MODE_BLEND_PREMULTI) |
>> +					  BIT(DRM_MODE_BLEND_COVERAGE),
>> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) |
>> +					  BIT(DRM_COLOR_YCBCR_BT2020),
>> +		.degamma_size		= DEGAMMA_SIZE,
>> +		.min_scale		= FRAC_16_16(1, 3),
>> +		.max_scale		= FRAC_16_16(10, 1),
>> +		.zpos			= 4,
>> +		.watermark		= true,
>> +		.color_mgmt		= true,
>> +		.roi			= true,
>> +	},
>> +	{
>> +		.name			= "Overlay_3",
>> +		.id			= OVERLAY_PLANE_3,
>> +		.type			= DRM_PLANE_TYPE_OVERLAY,
>> +		.num_formats		= ARRAY_SIZE(primary_overlay_format0),
>> +		.formats		= primary_overlay_format0,
>> +		.num_modifiers		= ARRAY_SIZE(secondary_format_modifiers),
>> +		.modifiers		= secondary_format_modifiers,
>> +		.min_width		= 0,
>> +		.min_height		= 0,
>> +		.max_width		= 4096,
>> +		.max_height		= 4096,
>> +		.rotation		= 0,
>> +		.blend_mode		= BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>> +					  BIT(DRM_MODE_BLEND_PREMULTI) |
>> +					  BIT(DRM_MODE_BLEND_COVERAGE),
>> +		.color_encoding		= BIT(DRM_COLOR_YCBCR_BT709) |
>> +					  BIT(DRM_COLOR_YCBCR_BT2020),
>> +		.degamma_size		= DEGAMMA_SIZE,
>> +		.min_scale		= DRM_PLANE_NO_SCALING,
>> +		.max_scale		= DRM_PLANE_NO_SCALING,
>> +		.zpos			= 5,
>> +		.watermark		= true,
>> +		.color_mgmt		= true,
>> +		.roi			= true,
>> +	},
>> +	{
>> +		.name			= "Cursor",
>> +		.id			= CURSOR_PLANE_0,
>> +		.type			= DRM_PLANE_TYPE_CURSOR,
>> +		.num_formats		= ARRAY_SIZE(cursor_formats),
>> +		.formats		= cursor_formats,
>> +		.num_modifiers		= 0,
>> +		.modifiers		= NULL,
>> +		.min_width		= 32,
>> +		.min_height		= 32,
>> +		.max_width		= 64,
>> +		.max_height		= 64,
>> +		.rotation		= 0,
>> +		.degamma_size		= 0,
>> +		.min_scale		= DRM_PLANE_NO_SCALING,
>> +		.max_scale		= DRM_PLANE_NO_SCALING,
>> +		.zpos			= 255,
>> +		.watermark		= false,
>> +		.color_mgmt		= false,
>> +		.roi			= false,
>> +	},
>> +	{
>> +		.name			= "Cursor_1",
>> +		.id			= CURSOR_PLANE_1,
>> +		.type			= DRM_PLANE_TYPE_CURSOR,
>> +		.num_formats		= ARRAY_SIZE(cursor_formats),
>> +		.formats		= cursor_formats,
>> +		.num_modifiers		= 0,
>> +		.modifiers		= NULL,
>> +		.min_width		= 32,
>> +		.min_height		= 32,
>> +		.max_width		= 64,
>> +		.max_height		= 64,
>> +		.rotation		= 0,
>> +		.degamma_size		= 0,
>> +		.min_scale		= DRM_PLANE_NO_SCALING,
>> +		.max_scale		= DRM_PLANE_NO_SCALING,
>> +		.zpos			= 255,
>> +		.watermark		= false,
>> +		.color_mgmt		= false,
>> +		.roi			= false,
>> +	},
>> +};
>> +
>> +static const struct vs_dc_info dc8200_info = {
>> +	.name			= "DC8200",
>> +	.panel_num		= 2,
>> +	.plane_num		= 8,
>> +	.planes			= dc_hw_planes_rev0,
>> +	.layer_num		= 6,
>> +	.max_bpc		= 10,
>> +	.color_formats		= DRM_COLOR_FORMAT_RGB444 |
>> +				  DRM_COLOR_FORMAT_YCBCR444 |
>> +				  DRM_COLOR_FORMAT_YCBCR422 |
>> +				  DRM_COLOR_FORMAT_YCBCR420,
>> +	.gamma_size		= GAMMA_EX_SIZE,
>> +	.gamma_bits		= 12,
>> +	.pitch_alignment	= 128,
>> +	.pipe_sync		= false,
>> +	.background		= true,
>> +	.panel_sync		= true,
>> +	.cap_dec		= true,
>> +};
> 
> I really think that entire thing is to workaround a suboptimal device
> tree binding. You should have two CRTCs in the device tree, you'll probe
> twice, and you won't get to do that whole dance.
> 

i got you means “two CRTCs in the device tree，probe twice"
maybe also I can split the common ctrc helper fun into 2 , 

current the driver probe once and map 2 port as ctrc node ,

> 
>> +struct dc_hw_plane_reg {
>> +	u32 y_address;
>> +	u32 u_address;
>> +	u32 v_address;
>> +	u32 y_stride;
>> +	u32 u_stride;
>> +	u32 v_stride;
>> +	u32 size;
>> +	u32 top_left;
>> +	u32 bottom_right;
>> +	u32 scale_factor_x;
>> +	u32 scale_factor_y;
>> +	u32 h_filter_coef_index;
>> +	u32 h_filter_coef_data;
>> +	u32 v_filter_coef_index;
>> +	u32 v_filter_coef_data;
>> +	u32 init_offset;
>> +	u32 color_key;
>> +	u32 color_key_high;
>> +	u32 clear_value;
>> +	u32 color_table_index;
>> +	u32 color_table_data;
>> +	u32 scale_config;
>> +	u32 water_mark;
>> +	u32 degamma_index;
>> +	u32 degamma_data;
>> +	u32 degamma_ex_data;
>> +	u32 src_global_color;
>> +	u32 dst_global_color;
>> +	u32 blend_config;
>> +	u32 roi_origin;
>> +	u32 roi_size;
>> +	u32 yuv_to_rgb_coef0;
>> +	u32 yuv_to_rgb_coef1;
>> +	u32 yuv_to_rgb_coef2;
>> +	u32 yuv_to_rgb_coef3;
>> +	u32 yuv_to_rgb_coef4;
>> +	u32 yuv_to_rgb_coefd0;
>> +	u32 yuv_to_rgb_coefd1;
>> +	u32 yuv_to_rgb_coefd2;
>> +	u32 y_clamp_bound;
>> +	u32 uv_clamp_bound;
>> +	u32 rgb_to_rgb_coef0;
>> +	u32 rgb_to_rgb_coef1;
>> +	u32 rgb_to_rgb_coef2;
>> +	u32 rgb_to_rgb_coef3;
>> +	u32 rgb_to_rgb_coef4;
>> +};
> 
> That's your plane state.
> 
>> +struct dc_hw_fb {
>> +	u32 y_address;
>> +	u32 u_address;
>> +	u32 v_address;
>> +	u32 clear_value;
>> +	u32 water_mark;
>> +	u16 y_stride;
>> +	u16 u_stride;
>> +	u16 v_stride;
>> +	u16 width;
>> +	u16 height;
>> +	u8	format;
>> +	u8	tile_mode;
>> +	u8	rotation;
>> +	u8	yuv_color_space;
>> +	u8	swizzle;
>> +	u8	uv_swizzle;
>> +	u8	zpos;
>> +	u8	display_id;
>> +	bool	clear_enable;
>> +	bool	dec_enable;
>> +	bool	enable;
>> +	bool	dirty;
>> +};
> 
> Your framebuffer
> 
>> +struct dc_hw_scale {
>> +	u32 scale_factor_x;
>> +	u32 scale_factor_y;
>> +	bool	enable;
>> +	bool	dirty;
>> +};
>> +
>> +struct dc_hw_position {
>> +	u16 start_x;
>> +	u16 start_y;
>> +	u16 end_x;
>> +	u16 end_y;
>> +	bool	dirty;
>> +};
>> +
>> +struct dc_hw_blend {
>> +	u8	alpha;
>> +	u8	blend_mode;
>> +	bool	dirty;
>> +};
>> +
>> +struct dc_hw_colorkey {
>> +	u32 colorkey;
>> +	u32 colorkey_high;
>> +	u8	transparency;
>> +	bool dirty;
>> +};
> 
> Your CRTC state.
> 
>> +struct dc_hw_roi {
>> +	u16 x;
>> +	u16 y;
>> +	u16 width;
>> +	u16 height;
>> +	bool enable;
>> +	bool dirty;
>> +};
>> +
>> +struct dc_hw_cursor {
>> +	u32 address;
>> +	u16 x;
>> +	u16 y;
>> +	u16 hot_x;
>> +	u16 hot_y;
>> +	u8	size;
>> +	u8	display_id;
>> +	bool	enable;
>> +	bool	dirty;
>> +};
>> +
>> +struct dc_hw_display {
>> +	u32 bus_format;
>> +	u16 h_active;
>> +	u16 h_total;
>> +	u16 h_sync_start;
>> +	u16 h_sync_end;
>> +	u16 v_active;
>> +	u16 v_total;
>> +	u16 v_sync_start;
>> +	u16 v_sync_end;
>> +	u8	id;
>> +	bool	h_sync_polarity;
>> +	bool	v_sync_polarity;
>> +	bool	enable;
>> +};
> 
> Your display mode.
> 
> Really, you have the huge majority of those informations already
> available, there's no need to duplicate it. And chances are you'll
> create bugs in the process.
> Maxime
ok let me try it, 
This will be another relatively big change.

