Return-Path: <linux-kernel+bounces-56637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B184CD0F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88750286880
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354B02030F;
	Wed,  7 Feb 2024 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nqeMgcuy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4776C99;
	Wed,  7 Feb 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316959; cv=none; b=rgyHc8EC1DZw5TPyKV7Pnx6G9IF5JtA56pXMeHiFjwaq2+KAdoWOfY6fJyhxH71Rpa+yotRIkpePNoSQDyyIbax718wCVJyaDoF6vPRvOo4Acdx6ItgrzhodjwpKefAnVmVYXk+B6F9zFT1RrJAmEN80qM5jEaLLkDTv8VfyI0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316959; c=relaxed/simple;
	bh=kuERJraCKv9ZhGewJ2NiUH0D14LvqIopll4/IHjU9qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2tSQEqORGuukyFDKjG+oBvM31PkpBSBd/3w6BHfy0o5oMCFxbysK/0nbhocNVpTCJWcl4tSG1yZ1l2aem7ECDV102jyf61M75nYCm+8w5V9DEprKlEZhMKBsKLXgS+RcWp/swYrv7rmI7pAD5P8r+Th9tOW0DTOlAoos02e3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nqeMgcuy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707316954;
	bh=kuERJraCKv9ZhGewJ2NiUH0D14LvqIopll4/IHjU9qc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nqeMgcuyuPSrSJhnRD5HiTpzAfi+DG0BAcmfGih/fsOnH8xFLT/NJtJnxbXIO4uF3
	 KFLZzsFx3T32OY8YpJCyjKWhyjGvdfdVCl2LREqYVrCwV/iflM8+oVg8aFhkq5m0NA
	 2hcriGFVC30C1s6gHfmEsIoRHlEAGsPln8HLRfBhLgnFvquU1e3ICfRuLGNaYwJZpM
	 ogf2Mtzv/DKBLrQMv/HP1mpEjuGiChNfgC6L30kyUnB/VPTGmZBZMcHWm+e1CZ/YOl
	 JW87CYUiNa8XQdDEAwf+5zyG24QrPRF/yq/mylbIDA26n3PslmGrF3XxHd7UayUDbo
	 C6tdB+uL4ACcg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE3D23782072;
	Wed,  7 Feb 2024 14:42:32 +0000 (UTC)
Message-ID: <21370bd8-502b-4b4e-8c9b-6d13c60685d5@collabora.com>
Date: Wed, 7 Feb 2024 15:42:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] media: i2c: Add GC08A3 image sensor driver
Content-Language: en-US
To: Zhi Mao <zhi.mao@mediatek.com>, mchehab@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, sakari.ailus@linux.intel.com
Cc: laurent.pinchart@ideasonboard.com, shengnan.wang@mediatek.com,
 yaya.chang@mediatek.com, 10572168@qq.com,
 Project_Global_Chrome_Upstream_Group@mediatek.com, yunkec@chromium.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, jacopo.mondi@ideasonboard.com,
 hverkuil-cisco@xs4all.nl, heiko@sntech.de, jernej.skrabec@gmail.com,
 macromorgan@hotmail.com, linus.walleij@linaro.org, hdegoede@redhat.com,
 tomi.valkeinen@ideasonboard.com, gerald.loacker@wolfvision.net,
 andy.shevchenko@gmail.com, bingbu.cao@intel.com,
 dan.scally@ideasonboard.com, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240204061538.2105-1-zhi.mao@mediatek.com>
 <20240204061538.2105-3-zhi.mao@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240204061538.2105-3-zhi.mao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/02/24 07:15, Zhi Mao ha scritto:
> Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>   drivers/media/i2c/Kconfig  |   10 +
>   drivers/media/i2c/Makefile |    1 +
>   drivers/media/i2c/gc08a3.c | 1448 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 1459 insertions(+)
>   create mode 100644 drivers/media/i2c/gc08a3.c
> 
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index 56f276b920ab..e4da68835683 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -70,6 +70,16 @@ config VIDEO_GC0308
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called gc0308.
>   
> +config VIDEO_GC08A3
> +	tristate "GalaxyCore gc08a3 sensor support"
> +	select V4L2_CCI_I2C
> +	help
> +	  This is a Video4Linux2 sensor driver for the GalaxyCore gc08a3
> +	  camera.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called gc08a3.
> +
>   config VIDEO_GC2145
>   	select V4L2_CCI_I2C
>   	tristate "GalaxyCore GC2145 sensor support"
> diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> index dfbe6448b549..b82e99ca7578 100644
> --- a/drivers/media/i2c/Makefile
> +++ b/drivers/media/i2c/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_VIDEO_DW9768) += dw9768.o
>   obj-$(CONFIG_VIDEO_DW9807_VCM) += dw9807-vcm.o
>   obj-$(CONFIG_VIDEO_ET8EK8) += et8ek8/
>   obj-$(CONFIG_VIDEO_GC0308) += gc0308.o
> +obj-$(CONFIG_VIDEO_GC08A3) += gc08a3.o
>   obj-$(CONFIG_VIDEO_GC2145) += gc2145.o
>   obj-$(CONFIG_VIDEO_HI556) += hi556.o
>   obj-$(CONFIG_VIDEO_HI846) += hi846.o
> diff --git a/drivers/media/i2c/gc08a3.c b/drivers/media/i2c/gc08a3.c
> new file mode 100644
> index 000000000000..3fc7fffb815c
> --- /dev/null
> +++ b/drivers/media/i2c/gc08a3.c
> @@ -0,0 +1,1448 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * gc08a3.c - gc08a3 sensor driver
> + *
> + * Copyright 2023 MediaTek
> + *
> + * Zhi Mao <zhi.mao@mediatek.com>
> + */
> +

.snip..

> +
> +static const struct gc08a3_link_freq_config gc08a3_link_freq_336m_configs = {
> +	.reg_list = {
> +		.num_of_regs = ARRAY_SIZE(mode_table_common),
> +		.regs = mode_table_common,
> +	}
> +};
> +
> +static const struct gc08a3_link_freq_config gc08a3_link_freq_207m_configs = {
> +	.reg_list = {
> +		.num_of_regs = ARRAY_SIZE(mode_table_common),
> +		.regs = mode_table_common,
> +	}
> +};
> +

Since you're documenting this structure anyway, why not kerneldoc? :-)

> +struct gc08a3_mode {
> +	u32 width;
> +	u32 height;
> +	const struct gc08a3_reg_list reg_list;
> +
> +	u32 hts; /* Horizontal timining size */
> +	u32 vts_def; /* Default vertical timining size */
> +	u32 vts_min; /* Min vertical timining size */
> +	u32 max_framerate;
> +	const struct gc08a3_link_freq_config *link_freq_configs;
> +};
> +
> +/*
> + * Declare modes in order, from biggest
> + * to smallest height.
> + */

one line is enough for this comment.

> +static const struct gc08a3_mode gc08a3_modes[] = {
> +	{
> +		.width = GC08A3_NATIVE_WIDTH,
> +		.height = GC08A3_NATIVE_HEIGHT,
> +		.reg_list = {
> +			.num_of_regs = ARRAY_SIZE(mode_3264x2448),
> +			.regs = mode_3264x2448,
> +		},
> +		.link_freq_configs = &gc08a3_link_freq_336m_configs,
> +
> +		.hts = GC08A3_HTS_30FPS,
> +		.vts_def = GC08A3_VTS_30FPS,
> +		.vts_min = GC08A3_VTS_30FPS_MIN,
> +		.max_framerate = 300,
> +	},
> +	{
> +		.width = 1920,
> +		.height = 1080,
> +		.reg_list = {
> +			.num_of_regs = ARRAY_SIZE(mode_1920x1080),
> +			.regs = mode_1920x1080,
> +		},
> +		.link_freq_configs = &gc08a3_link_freq_207m_configs,
> +
> +		.hts = GC08A3_HTS_60FPS,
> +		.vts_def = GC08A3_VTS_60FPS,
> +		.vts_min = GC08A3_VTS_60FPS_MIN,
> +		.max_framerate = 600,
> +	},
> +};
> +
> +static u64 to_pixel_rate(u32 f_index)
> +{
> +	u64 pixel_rate = link_freq_menu_items[f_index] * 2 * GC08A3_DATA_LANES;
> +
> +	do_div(pixel_rate, GC08A3_RGB_DEPTH);

The divisor is (less than) 32 bits and the dividend is always 64 bits: that will
break on builds for 32-bits CPUs.

Just do....

	return div_u64(pixel_rate, GB08A3_RGB_DEPTH);

> +
> +	return pixel_rate;
> +}
> +
> +static int gc08a3_identify_module(struct gc08a3 *gc08a3)
> +{
> +	struct i2c_client *client = v4l2_get_subdevdata(&gc08a3->sd);
> +	u64 val = 0;

u64 val;

> +	int ret;
> +

Either log here or in the probe function, otherwise it's just redudant.

> +	ret = cci_read(gc08a3->regmap, GC08A3_REG_CHIP_ID, &val, NULL);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"failed to read chip id: 0x%x", GC08A3_CHIP_ID);
> +		return ret;
> +	}
> +
> +	if (val != GC08A3_CHIP_ID) {
> +		dev_err(&client->dev, "chip id mismatch: 0x%x!=0x%llx",
> +			GC08A3_CHIP_ID, val);
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline struct gc08a3 *to_gc08a3(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct gc08a3, sd);
> +}
> +

.snip..

> +
> +static int gc08a3_update_cur_mode_controls(struct gc08a3 *gc08a3,
> +					   const struct gc08a3_mode *mode)
> +{
> +	s64 exposure_max, h_blank;
> +	int ret = 0;
> +
> +	ret = __v4l2_ctrl_modify_range(gc08a3->vblank,
> +				       mode->vts_min - mode->height,
> +				       GC08A3_VTS_MAX - mode->height, 1,
> +				       mode->vts_def - mode->height);
> +	if (ret)
> +		dev_err(gc08a3->dev, "VB ctrl range update failed\n");
> +
> +	h_blank = mode->hts - mode->width;
> +	ret = __v4l2_ctrl_modify_range(gc08a3->hblank, h_blank, h_blank, 1,
> +				       h_blank);
> +	if (ret)
> +		dev_err(gc08a3->dev, "HB ctrl range update failed\n");
> +
> +	exposure_max = mode->vts_def - GC08A3_EXP_MARGIN;
> +	ret = __v4l2_ctrl_modify_range(gc08a3->exposure, GC08A3_EXP_MIN,
> +				       exposure_max, GC08A3_EXP_STEP,
> +				       exposure_max);
> +	if (ret)
> +		dev_err(gc08a3->dev, "exposure ctrl range update failed\n");

No. You're not returning anywhere for error. That's not okay.
Besides...

	if (ret) {
		dev_err..
		return ret;
	}

	return 0;

> +
> +	return ret;
> +}
> +
> +static void gc08a3_update_pad_format(struct gc08a3 *gc08a3,
> +				     const struct gc08a3_mode *mode,
> +				     struct v4l2_mbus_framefmt *fmt)
> +{
> +	fmt->width = mode->width;
> +	fmt->height = mode->height;
> +	fmt->code = GC08A3_MBUS_CODE;
> +	fmt->field = V4L2_FIELD_NONE;
> +	fmt->colorspace = V4L2_COLORSPACE_SRGB;
> +	fmt->ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(fmt->colorspace);
> +	fmt->quantization =
> +		V4L2_MAP_QUANTIZATION_DEFAULT(true,
> +					      fmt->colorspace,
> +					      fmt->ycbcr_enc);
> +	fmt->xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(fmt->colorspace);
> +}
> +
> +static int gc08a3_set_format(struct v4l2_subdev *sd,
> +			     struct v4l2_subdev_state *state,
> +			     struct v4l2_subdev_format *fmt)
> +{
> +	struct gc08a3 *gc08a3 = to_gc08a3(sd);
> +	struct v4l2_mbus_framefmt *mbus_fmt;
> +	struct v4l2_rect *crop;
> +	const struct gc08a3_mode *mode;
> +
> +	mode = v4l2_find_nearest_size(gc08a3_modes, ARRAY_SIZE(gc08a3_modes),
> +				      width, height, fmt->format.width,
> +				      fmt->format.height);
> +
> +	/*update crop info to subdev state*/
> +	crop = v4l2_subdev_state_get_crop(state, 0);
> +	crop->width = mode->width;
> +	crop->height = mode->height;
> +
> +	/*update fmt info to subdev state*/
> +	gc08a3_update_pad_format(gc08a3, mode, &fmt->format);
> +	mbus_fmt = v4l2_subdev_state_get_format(state, 0);
> +	*mbus_fmt = fmt->format;
> +
> +	if (fmt->which == V4L2_SUBDEV_FORMAT_TRY)
> +		return 0;
> +
> +	gc08a3->cur_mode = mode;
> +	gc08a3_update_cur_mode_controls(gc08a3, mode);
> +
> +	return 0;
> +}
> +
> +static int gc08a3_get_selection(struct v4l2_subdev *sd,
> +				struct v4l2_subdev_state *state,
> +				struct v4l2_subdev_selection *sel)
> +{
> +	struct gc08a3 *gc08a3 = to_gc08a3(sd);
> +
> +	switch (sel->target) {
> +	case V4L2_SEL_TGT_CROP:
> +		sel->r = *v4l2_subdev_state_get_crop(state, 0);
> +		break;
> +	case V4L2_SEL_TGT_CROP_BOUNDS:
> +		sel->r.top = 0;
> +		sel->r.left = 0;
> +		sel->r.width = GC08A3_NATIVE_WIDTH;
> +		sel->r.height = GC08A3_NATIVE_HEIGHT;
> +		break;
> +	case V4L2_SEL_TGT_CROP_DEFAULT:
> +		if (gc08a3->cur_mode->width == GC08A3_NATIVE_WIDTH) {
> +			sel->r.top = 0;
> +			sel->r.left = 0;
> +			sel->r.width = gc08a3_modes[0].width;
> +			sel->r.height = gc08a3_modes[0].height;
> +		} else {
> +			sel->r.top = 0;
> +			sel->r.left = 0;
> +			sel->r.width = gc08a3_modes[1].width;
> +			sel->r.height = gc08a3_modes[1].height;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gc08a3_init_state(struct v4l2_subdev *sd,
> +			     struct v4l2_subdev_state *state)
> +{
> +	struct v4l2_subdev_format fmt = {
> +		.which = V4L2_SUBDEV_FORMAT_TRY,
> +		.pad = 0,
> +		.format = {
> +			.code = GC08A3_MBUS_CODE,
> +			.width = gc08a3_modes[0].width,
> +			.height = gc08a3_modes[0].height,
> +		},
> +	};
> +
> +	gc08a3_set_format(sd, state, &fmt);
> +
> +	return 0;
> +}
> +
> +static int gc08a3_set_ctrl_hflip(struct gc08a3 *gc08a3, u32 ctrl_val)
> +{
> +	int ret;
> +	u64 val;
> +
> +	ret = cci_read(gc08a3->regmap, GC08A3_FLIP_REG, &val, NULL);
> +	if (ret) {
> +		dev_err(gc08a3->dev, "read hflip register failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	val = ctrl_val ? (val | GC08A3_FLIP_H_MASK) :
> +			   (val & ~GC08A3_FLIP_H_MASK);
> +	ret = cci_write(gc08a3->regmap, GC08A3_FLIP_REG, val, NULL);
> +	if (ret < 0)
> +		dev_err(gc08a3->dev, "Error %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int gc08a3_set_ctrl_vflip(struct gc08a3 *gc08a3, u32 ctrl_val)
> +{
> +	int ret;
> +	u64 val;
> +
> +	ret = cci_read(gc08a3->regmap, GC08A3_FLIP_REG, &val, NULL);
> +	if (ret) {
> +		dev_err(gc08a3->dev, "read vflip register failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	val = ctrl_val ? (val | GC08A3_FLIP_V_MASK) :
> +			   (val & ~GC08A3_FLIP_V_MASK);
> +	ret = cci_write(gc08a3->regmap, GC08A3_FLIP_REG, val, NULL);
> +	if (ret < 0)
> +		dev_err(gc08a3->dev, "Error %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int gc08a3_test_pattern(struct gc08a3 *gc08a3, u32 pattern_menu)
> +{
> +	u32 pattern = 0;
> +	int ret;

ret not initialized is ok here;

> +
> +	if (pattern_menu) {
> +		switch (pattern_menu) {
> +		case 1:
> +			pattern = 0x00;
> +			break;
> +		case 2:
> +			pattern = 0x10;
> +			break;
> +		case 3:
> +		case 4:
> +		case 5:
> +		case 6:
> +		case 7:
> +			pattern = pattern_menu + 1;
> +			break;
> +		}
> +
> +		ret = cci_write(gc08a3->regmap, GC08A3_REG_TEST_PATTERN_EN,
> +				GC08A3_TEST_PATTERN_EN, NULL);
> +		if (ret)
> +			return ret;
> +
> +		ret = cci_write(gc08a3->regmap, GC08A3_REG_TEST_PATTERN_IDX,
> +				pattern, NULL);

if (ret)
	return ret;

> +
> +	} else {
> +		ret = cci_write(gc08a3->regmap, GC08A3_REG_TEST_PATTERN_EN,
> +				0x00, NULL);

if (ret)
	return ret;

> +	}
> +

	return 0;

> +	return ret;
> +}
> +
> +static int gc08a3_set_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct gc08a3 *gc08a3 =
> +		container_of(ctrl->handler, struct gc08a3, ctrls);
> +	int ret = 0;

int ret;

> +	s64 exposure_max;
> +
> +	if (ctrl->id == V4L2_CID_VBLANK) {
> +		/* Update max exposure while meeting expected vblanking */
> +		exposure_max = gc08a3->cur_mode->height + ctrl->val -
> +			       GC08A3_EXP_MARGIN;
> +		__v4l2_ctrl_modify_range(gc08a3->exposure,
> +					 gc08a3->exposure->minimum,
> +					 exposure_max, gc08a3->exposure->step,
> +					 exposure_max);
> +	}
> +
> +	/*
> +	 * Applying V4L2 control value only happens
> +	 * when power is on for streaming
> +	 */
> +	if (!pm_runtime_get_if_in_use(gc08a3->dev))
> +		return 0;
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_EXPOSURE:
> +		ret = cci_write(gc08a3->regmap, GC08A3_EXP_REG,
> +				ctrl->val, NULL);
> +		break;
> +
> +	case V4L2_CID_ANALOGUE_GAIN:
> +		ret = cci_write(gc08a3->regmap, GC08A3_AGAIN_REG,
> +				ctrl->val, NULL);
> +		break;
> +
> +	case V4L2_CID_VBLANK:
> +		ret = cci_write(gc08a3->regmap, GC08A3_FRAME_LENGTH_REG,
> +				gc08a3->cur_mode->height + ctrl->val, NULL);
> +		break;
> +
> +	case V4L2_CID_HFLIP:
> +		ret = gc08a3_set_ctrl_hflip(gc08a3, ctrl->val);
> +		break;
> +
> +	case V4L2_CID_VFLIP:
> +		ret = gc08a3_set_ctrl_vflip(gc08a3, ctrl->val);
> +		break;
> +
> +	case V4L2_CID_TEST_PATTERN:
> +		ret = gc08a3_test_pattern(gc08a3, ctrl->val);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	pm_runtime_put(gc08a3->dev);

if (ret)
	return ret;

return 0;

> +
> +	return ret;
> +}
> +

..and I've ignored some more stuff as other reviewers already gave you feedback.

Regards,
Angelo


