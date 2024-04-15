Return-Path: <linux-kernel+bounces-144561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920E78A47C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5863D1C218A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75C7BE4D;
	Mon, 15 Apr 2024 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5K+jNMU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC7BE556;
	Mon, 15 Apr 2024 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161284; cv=none; b=Wk/ZwF/uK1bPjf+H6r7yA8S7hNHuGvMJRy54spUDJQXazeplcVykvbZjqkywMZlPlEkWmHlGXe+eDRKlfAnq8A3wDhdzmtTaYO3ZCjNFJrQ5+QknmfgnpeiTh4M5kp/i4MR+/w4n12aRXu2Q1qyqXKnx+3KXuasbhCQlW3A7cQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161284; c=relaxed/simple;
	bh=/8Sp54htChnPy06fVPjVsPWRm4W+KKKwZ8arDGVGZtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGewi0OVskzG1FJoVNIB8KnWIwty9jZ8+4yP9vEcgyvpOMHopkQJroCMUDyhu4mnc0N1nbFwE2H8eReswk9OUPSYbaT0vTk9b0F2VGVgZ8cxzI8HwRGFSIG7ZTVNKNGxHErN1SjU6olgqjbokAVdBVGZFyekrHj6Ri59VU1mAns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5K+jNMU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713161282; x=1744697282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/8Sp54htChnPy06fVPjVsPWRm4W+KKKwZ8arDGVGZtw=;
  b=F5K+jNMUobGAqtREBZFgFzh9BnBPnCgqyjtO0/YgREmBMexJMNu9eMBF
   I3kMIC27PNzE+X9JdWuq6zxw3DjzkEmxOyFK1ekB3NzphBAJWQKQmSefT
   /5d+3vozJs82uDAQmQef1nmep0+CWPRETsRN9FDEZ89xI6m1IeVGcHnwX
   Ee2xocJKzjvh1hPUNZT9g0o53TViEU3RkdwBHhR2wY6SdUSCu32+lfddv
   eSzw9wR0b3p6CUncSgoY5z9Zini+sQN7bsRyP1GwSOGor0yB/NfsMo63u
   Ko+4vUu77eClV+rag2PykfS/R1GPFfObwuQ1oWzuE4WPd1rIJJH2wxyfj
   Q==;
X-CSE-ConnectionGUID: ZzMfzEjQQaaPkjoeGRx2Zg==
X-CSE-MsgGUID: oqpPB1PZRH2kT1S/xLtXsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="11484388"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="11484388"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:07:40 -0700
X-CSE-ConnectionGUID: 8XO0Fp1KQ/iJf0ZXbV+HYQ==
X-CSE-MsgGUID: 2GK137H7Q7evxocIi9be7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="21896223"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2024 23:07:38 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 54DF811F8AF;
	Mon, 15 Apr 2024 09:07:35 +0300 (EEST)
Date: Mon, 15 Apr 2024 06:07:35 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v4 20/20] media: i2c: ov4689: Implement 2x2 binning
Message-ID: <ZhzEJ81BDT_AJp9X@kekkonen.localdomain>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
 <20240402164552.19171-21-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402164552.19171-21-mike.rudenko@gmail.com>

Hi Nikhail,

On Tue, Apr 02, 2024 at 07:45:51PM +0300, Mikhail Rudenko wrote:
> Implement 2x2 binning support. Compute best binning mode (none or 2x2)
> from pad crop and pad format in ov4689_set_fmt. Use output frame size
> instead of analogue crop to compute control ranges and BLC anchors.
> 
> Also move ov4689_hts_min and ov4689_update_ctrl_ranges, since they are
> now also called from ov4689_set_fmt. Update frame timings to
> accommodate the requirements of binning mode and avoid visual
> artefacts. Additionally, report 2x2 binned mode in addition to
> non-binned one in ov4689_enum_frame_sizes.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 192 +++++++++++++++++++++++++------------
>  1 file changed, 130 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index e652d626f32f..83c7d0bae7d1 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -114,7 +114,7 @@
>   * Minimum working vertical blanking value. Found experimentally at
>   * minimum HTS values.
>   */
> -#define OV4689_VBLANK_MIN		31
> +#define OV4689_VBLANK_MIN		35
>  
>  static const char *const ov4689_supply_names[] = {
>  	"avdd", /* Analog power */
> @@ -256,6 +256,18 @@ static const struct cci_reg_sequence ov4689_common_regs[] = {
>  	{CCI_REG8(0x5503), 0x0f}, /* OTP_DPC_END_L otp_end_address[7:0] = 0x0f */
>  };
>  
> +static const struct cci_reg_sequence ov4689_2x2_binning_regs[] = {
> +	{CCI_REG8(0x3632), 0x05}, /* ADC */
> +	{CCI_REG8(0x376b), 0x40}, /* Sensor control */
> +	{CCI_REG8(0x3814), 0x03}, /* H_INC_ODD */
> +	{CCI_REG8(0x3821), 0x07}, /* TIMING_FORMAT_2 hor_binning = 1*/
> +	{CCI_REG8(0x382a), 0x03}, /* V_INC_ODD */
> +	{CCI_REG8(0x3830), 0x08}, /* BLC_NUM_OPTION blc_use_num_2 = 1 */
> +	{CCI_REG8(0x3836), 0x02}, /* TIMING_REG_36 r_zline_use_num_2 = 1 */
> +	{CCI_REG8(0x4001), 0x50}, /* BLC DEBUG MODE */
> +	{CCI_REG8(0x4502), 0x44}, /* ADC synch control*/

Spaces inside { }'s, please.

> +};
> +
>  static const u64 link_freq_menu_items[] = { 504000000 };
>  
>  static const char *const ov4689_test_pattern_menu[] = {
> @@ -305,18 +317,96 @@ static const struct ov4689_gain_range ov4689_gain_ranges[] = {
>  	},
>  };
>  
> +/*
> + * For now, only 2x2 binning implemented in this driver.
> + */
> +static int ov4689_best_binning(struct ov4689 *ov4689,
> +			       const struct v4l2_mbus_framefmt *format,
> +			       const struct v4l2_rect *crop,
> +			       unsigned int *binning)
> +{
> +	const struct v4l2_area candidates[] = {
> +		{ crop->width, crop->height },
> +		{ crop->width / 2, crop->height / 2 },
> +	};
> +
> +	const struct v4l2_area *best;
> +	int index;
> +
> +	best = v4l2_find_nearest_size(candidates, ARRAY_SIZE(candidates), width,
> +				      height, format->width, format->height);

You can assume v4l2_find_nearest_size() returns a non-NULL value (see the
other patch I cc'd you).

> +	if (!best) {
> +		dev_err(ov4689->dev,
> +			"failed to find best binning for requested mode\n");
> +		return -EINVAL;
> +	}
> +
> +	index = best - candidates;
> +	*binning = index + 1;
> +
> +	dev_dbg(ov4689->dev,
> +		"best_binning: crop=%dx%d format=%dx%d binning=%d\n",
> +		crop->width, crop->height, format->width, format->height,
> +		*binning);
> +
> +	return 0;
> +}
> +
> +/*
> + * Minimum working HTS value for given output width (found
> + * experimentally).
> + */
> +static unsigned int ov4689_hts_min(unsigned int width)
> +{
> +	return max_t(unsigned int, 3156, 224 + width * 19 / 16);
> +}
> +
> +static void ov4689_update_ctrl_ranges(struct ov4689 *ov4689, unsigned int width,
> +				      unsigned int height)
> +{
> +	struct v4l2_ctrl *exposure = ov4689->exposure;
> +	struct v4l2_ctrl *vblank = ov4689->vblank;
> +	struct v4l2_ctrl *hblank = ov4689->hblank;
> +	s64 def_val, min_val, max_val;
> +
> +	min_val = ov4689_hts_min(width) - width;
> +	max_val = OV4689_HTS_MAX - width;
> +	def_val = clamp_t(s64, hblank->default_value, min_val, max_val);
> +	__v4l2_ctrl_modify_range(hblank, min_val, max_val, hblank->step,
> +				 def_val);

Note that __v4l2_ctrl_modify_range() may fail. The problem isn't introduced
by this patch but it'd be nice to fix it (but maybe in a separate patch).

> +
> +	min_val = OV4689_VBLANK_MIN;
> +	max_val = OV4689_HTS_MAX - width;
> +	def_val = clamp_t(s64, vblank->default_value, min_val, max_val);
> +	__v4l2_ctrl_modify_range(vblank, min_val, max_val, vblank->step,
> +				 def_val);
> +
> +	min_val = exposure->minimum;
> +	max_val = height + vblank->val - 4;
> +	def_val = clamp_t(s64, exposure->default_value, min_val, max_val);
> +	__v4l2_ctrl_modify_range(exposure, min_val, max_val, exposure->step,
> +				 def_val);
> +}
> +
>  static int ov4689_set_fmt(struct v4l2_subdev *sd,
>  			  struct v4l2_subdev_state *sd_state,
>  			  struct v4l2_subdev_format *fmt)
>  {
> +	struct ov4689 *ov4689 = to_ov4689(sd);
>  	struct v4l2_mbus_framefmt *format;
>  	struct v4l2_rect *crop;
> +	unsigned int binning;
> +	int ret;
>  
>  	crop = v4l2_subdev_state_get_crop(sd_state, fmt->pad);
>  	format = v4l2_subdev_state_get_format(sd_state, fmt->pad);
>  
> -	format->width = crop->width;
> -	format->height = crop->height;
> +	ret = ov4689_best_binning(ov4689, &fmt->format, crop, &binning);
> +	if (ret)
> +		return ret;
> +
> +	format->width = crop->width / binning;
> +	format->height = crop->height / binning;
>  
>  	format->code = MEDIA_BUS_FMT_SBGGR10_1X10;
>  	format->field = V4L2_FIELD_NONE;
> @@ -327,6 +417,9 @@ static int ov4689_set_fmt(struct v4l2_subdev *sd,
>  
>  	fmt->format = *format;
>  
> +	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> +		ov4689_update_ctrl_ranges(ov4689, format->width, format->height);
> +
>  	return 0;
>  }
>  
> @@ -346,8 +439,9 @@ static int ov4689_enum_frame_sizes(struct v4l2_subdev *sd,
>  				   struct v4l2_subdev_frame_size_enum *fse)
>  {
>  	const struct v4l2_rect *crop;
> +	int binning;
>  
> -	if (fse->index >= 1)
> +	if (fse->index >= 2)
>  		return -EINVAL;
>  
>  	if (fse->code != MEDIA_BUS_FMT_SBGGR10_1X10)
> @@ -355,10 +449,11 @@ static int ov4689_enum_frame_sizes(struct v4l2_subdev *sd,
>  
>  	crop = v4l2_subdev_state_get_crop(sd_state, 0);
>  
> -	fse->min_width = crop->width;
> -	fse->max_width = crop->width;
> -	fse->max_height = crop->height;
> -	fse->min_height = crop->height;
> +	binning = fse->index + 1;
> +	fse->min_width = crop->width / binning;
> +	fse->max_width = crop->width / binning;
> +	fse->max_height = crop->height / binning;
> +	fse->min_height = crop->height / binning;
>  
>  	return 0;
>  }
> @@ -398,42 +493,6 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>  	return -EINVAL;
>  }
>  
> -/*
> - * Minimum working HTS value for given output width (found
> - * experimentally).
> - */
> -static unsigned int ov4689_hts_min(unsigned int width)
> -{
> -	return max_t(unsigned int, 3156, 224 + width * 19 / 16);
> -}
> -
> -static void ov4689_update_ctrl_ranges(struct ov4689 *ov4689,
> -				      struct v4l2_rect *crop)
> -{
> -	struct v4l2_ctrl *exposure = ov4689->exposure;
> -	struct v4l2_ctrl *vblank = ov4689->vblank;
> -	struct v4l2_ctrl *hblank = ov4689->hblank;
> -	s64 def_val, min_val, max_val;
> -
> -	min_val = ov4689_hts_min(crop->width) - crop->width;
> -	max_val = OV4689_HTS_MAX - crop->width;
> -	def_val = clamp_t(s64, hblank->default_value, min_val, max_val);
> -	__v4l2_ctrl_modify_range(hblank, min_val, max_val, hblank->step,
> -				 def_val);
> -
> -	min_val = OV4689_VBLANK_MIN;
> -	max_val = OV4689_HTS_MAX - crop->width;
> -	def_val = clamp_t(s64, vblank->default_value, min_val, max_val);
> -	__v4l2_ctrl_modify_range(vblank, min_val, max_val, vblank->step,
> -				 def_val);
> -
> -	min_val = exposure->minimum;
> -	max_val = crop->height + vblank->val - 4;
> -	def_val = clamp_t(s64, exposure->default_value, min_val, max_val);
> -	__v4l2_ctrl_modify_range(exposure, min_val, max_val, exposure->step,
> -				 def_val);
> -}
> -
>  static int ov4689_set_selection(struct v4l2_subdev *sd,
>  				struct v4l2_subdev_state *state,
>  				struct v4l2_subdev_selection *sel)
> @@ -470,7 +529,8 @@ static int ov4689_set_selection(struct v4l2_subdev *sd,
>  		format->height = rect.height;
>  
>  		if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
> -			ov4689_update_ctrl_ranges(ov4689, &rect);
> +			ov4689_update_ctrl_ranges(ov4689, rect.width,
> +						  rect.height);
>  	}
>  
>  	*crop = rect;
> @@ -485,21 +545,27 @@ static int ov4689_setup_timings(struct ov4689 *ov4689,
>  	const struct v4l2_mbus_framefmt *format;
>  	struct regmap *rm = ov4689->regmap;
>  	const struct v4l2_rect *crop;
> +	const int v_offset = 2;
> +	unsigned int binning;
>  	int ret = 0;
>  
>  	format = v4l2_subdev_state_get_format(state, 0);
>  	crop = v4l2_subdev_state_get_crop(state, 0);
>  
> +	ret = ov4689_best_binning(ov4689, format, crop, &binning);
> +	if (ret)
> +		return ret;
> +
>  	cci_write(rm, OV4689_REG_H_CROP_START, crop->left, &ret);
> -	cci_write(rm, OV4689_REG_V_CROP_START, crop->top, &ret);
> -	cci_write(rm, OV4689_REG_H_CROP_END, crop->left + crop->width + 1, &ret);
> -	cci_write(rm, OV4689_REG_V_CROP_END, crop->top + crop->height + 1, &ret);
> +	cci_write(rm, OV4689_REG_V_CROP_START, crop->top - v_offset, &ret);
> +	cci_write(rm, OV4689_REG_H_CROP_END, crop->left + crop->width + 3, &ret);
> +	cci_write(rm, OV4689_REG_V_CROP_END, crop->top + crop->height + 7, &ret);
>  
>  	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, format->width, &ret);
>  	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, format->height, &ret);
>  
>  	cci_write(rm, OV4689_REG_H_WIN_OFF, 0, &ret);
> -	cci_write(rm, OV4689_REG_V_WIN_OFF, 0, &ret);
> +	cci_write(rm, OV4689_REG_V_WIN_OFF, v_offset, &ret);
>  
>  	/*
>  	 * Maximum working value of vfifo_read_start for given output
> @@ -507,6 +573,10 @@ static int ov4689_setup_timings(struct ov4689 *ov4689,
>  	 */
>  	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, format->width / 16 - 1, &ret);
>  
> +	if (binning == 2)
> +		cci_multi_reg_write(ov4689->regmap, ov4689_2x2_binning_regs,
> +				    ARRAY_SIZE(ov4689_2x2_binning_regs),
> +				    &ret);
>  	return ret;
>  }
>  
> @@ -519,20 +589,20 @@ static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
>  				    struct v4l2_subdev_state *state)
>  {
>  	unsigned int width_def = OV4689_H_OUTPUT_SIZE_DEFAULT;
> +	const struct v4l2_mbus_framefmt *format;
>  	struct regmap *rm = ov4689->regmap;
> -	const struct v4l2_rect *crop;
>  	int ret = 0;
>  
> -	crop = v4l2_subdev_state_get_crop(state, 0);
> +	format = v4l2_subdev_state_get_format(state, 0);
>  
>  	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START,
> -		  OV4689_ANCHOR_LEFT_START_DEF * crop->width / width_def, &ret);
> +		  OV4689_ANCHOR_LEFT_START_DEF * format->width / width_def, &ret);
>  	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END,
> -		  OV4689_ANCHOR_LEFT_END_DEF * crop->width / width_def, &ret);
> +		  OV4689_ANCHOR_LEFT_END_DEF * format->width / width_def, &ret);
>  	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START,
> -		  OV4689_ANCHOR_RIGHT_START_DEF * crop->width / width_def, &ret);
> +		  OV4689_ANCHOR_RIGHT_START_DEF * format->width / width_def, &ret);
>  	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END,
> -		  OV4689_ANCHOR_RIGHT_END_DEF * crop->width / width_def, &ret);
> +		  OV4689_ANCHOR_RIGHT_END_DEF * format->width / width_def, &ret);
>  
>  	return ret;
>  }
> @@ -749,19 +819,19 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  	struct regmap *regmap = ov4689->regmap;
>  	struct v4l2_subdev_state *sd_state;
>  	struct device *dev = ov4689->dev;
> -	struct v4l2_rect *crop;
> +	struct v4l2_mbus_framefmt *fmt;
>  	s64 max_expo, def_expo;
>  	int sensor_gain;
>  	int ret = 0;
>  
>  	sd_state = v4l2_subdev_get_locked_active_state(&ov4689->subdev);
> -	crop = v4l2_subdev_state_get_crop(sd_state, 0);
> +	fmt = v4l2_subdev_state_get_format(sd_state, 0);
>  
>  	/* Propagate change of current control to all related controls */
>  	switch (ctrl->id) {
>  	case V4L2_CID_VBLANK:
>  		/* Update max exposure while meeting expected vblanking */
> -		max_expo = crop->height + ctrl->val - 4;
> +		max_expo = fmt->height + ctrl->val - 4;
>  		def_expo = clamp_t(s64, ov4689->exposure->default_value,
>  				   ov4689->exposure->minimum, max_expo);
>  
> @@ -785,16 +855,14 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
>  		break;
>  	case V4L2_CID_VBLANK:
> -		cci_write(regmap, OV4689_REG_VTS,
> -			  ctrl->val + crop->height, &ret);
> +		cci_write(regmap, OV4689_REG_VTS, ctrl->val + fmt->height, &ret);
>  		break;
>  	case V4L2_CID_TEST_PATTERN:
>  		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
>  		break;
>  	case V4L2_CID_HBLANK:
>  		cci_write(regmap, OV4689_REG_HTS,
> -			  (ctrl->val + crop->width) /
> -			  OV4689_HTS_DIVIDER, &ret);
> +			  (ctrl->val + fmt->width) / OV4689_HTS_DIVIDER, &ret);
>  		break;
>  	case V4L2_CID_VFLIP:
>  		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,

-- 
Kind regards,

Sakari Ailus

