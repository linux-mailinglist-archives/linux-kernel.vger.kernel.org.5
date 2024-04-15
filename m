Return-Path: <linux-kernel+bounces-145871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9587F8A5C24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9952844A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429B9156882;
	Mon, 15 Apr 2024 20:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHLgdnwp"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10371B50;
	Mon, 15 Apr 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713212438; cv=none; b=kmJIYqsUEbhQ2xDE98bFzZVoLuWiyrPzQA6mFQWliWyzh/rHU5BoPEypguWHKxw0tf31Sryb21VJCwzVJrawX7qvV+/WBn/vR0pdO+BQFIS2iTaW+6Iq4tqnEg1uej+IY0J+pma122Q3gXu3yW8cO+VnR7rePImpxKPIfhEo+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713212438; c=relaxed/simple;
	bh=NhzeK2mKKHvAmPeelTHGEg+UPHg67iKUqkIMgvllB+E=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=NWdbPjQkhZHk4xrK+7Wkrirm/FsY/xkDo7PL6anyiCvdXR6veYsLsDtmzXeTLVe3/xXXemBiUIdc0nkLTLvqUFmjdXXCMuRCx1ryewLoA4EYx2RRP744fhZxPhv6mMOwg3yW+EPln1IUS9GQ0kjZVUt8thGNxvspkV1CLPKEGkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHLgdnwp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d2600569so4564005e87.0;
        Mon, 15 Apr 2024 13:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713212434; x=1713817234; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=+hMO8/WXYJs4KZvn4zTnLdDZkMCg570qWjmbj7VC9ZM=;
        b=LHLgdnwpmH2jCVKuzslaicz3W4Ux8RiCIXdo/emnLE0FRLVpjIHAU7J6rzdyTNh/kc
         JqLVtUta9XbLi9dfDzyIIijVbNRHaTIJOWG9ywXYHTT9hAvkBq+n0+qMnbqjmEyXpBm6
         SZmHXry+pw94J1SJPjBzVFKO7DYou8ds2fH6KjDp6Im6rsDBN9pDR/ErVnzY2dThbfo2
         43jlGxS6CpqOAfc/QzBuSE++naknCwliRzsBGCaG6WRT6CeUu684aTnTjZNjm16uzqOA
         lj92cpVUxONCfoYjOtH5lfvD5LKSGT+KS49wd2B/swDbGGGyY5wPJAUHaY6KOohC7O66
         zPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713212434; x=1713817234;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hMO8/WXYJs4KZvn4zTnLdDZkMCg570qWjmbj7VC9ZM=;
        b=S65GUGP6Mbh5/DWd/ScEhDzjCyNl7RI34Xuyvd2seC2T/ZvpyefTywj0365Ztxms9Y
         i/FVjIKqIuXQvUnDc0hXiiK5LVcQs/SuESZb+LWb/D8gsHTrRzcE0DPn8Y5hNkVi5qxj
         i3zparQQgB1c9rJIT/NTFeTt3dfndi5dthtcTZkHRnLsyFnbbtg6itMIageOsZkFRKV4
         yMb3XkQCXv0gpm3BF7cRGbadFY/ngOMhB3tISLG1aLnwv653hnIoESu+k5K6kncTJU2v
         hXNjfY3LyR/5OwZiQmVistNY6dSEefcoKiWDduSTPqN1EQH75iN+Auo3yzeps2Qn7BoO
         JMIg==
X-Forwarded-Encrypted: i=1; AJvYcCXMyxW5xm+CY1+Lj67oe9T2PqUU2lx02i3otCe7wOIFeDBtwqH4/k6PVvZdGD1FN58xmm7SZ21YJWSJjwxUTI8RGRewx+u8m4BMbJkT
X-Gm-Message-State: AOJu0YwVwKGV3NGyDWKROuC5kdHSHMw28c5vU9FXWdjn43i//cwpB1iH
	Sym6GHWfS2CkqCBVAWm5mBkGOjKsetWRa2jLeaELwyyCuihHxfKR
X-Google-Smtp-Source: AGHT+IH+NHHUifyaWcx4i38FWBXRWT1ug8ts6enB6xvpsshk91MjoEip/3tX7N0OfvLuRWCle9xa+A==
X-Received: by 2002:a19:2d55:0:b0:516:d22c:be2 with SMTP id t21-20020a192d55000000b00516d22c0be2mr7710698lft.61.1713212433668;
        Mon, 15 Apr 2024 13:20:33 -0700 (PDT)
Received: from razdolb ([62.176.29.172])
        by smtp.gmail.com with ESMTPSA id d10-20020ac24c8a000000b00516d2489f16sm1337473lfl.260.2024.04.15.13.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:20:33 -0700 (PDT)
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
 <20240402164552.19171-21-mike.rudenko@gmail.com>
 <ZhzEJ81BDT_AJp9X@kekkonen.localdomain>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi
 <jacopo@jmondi.org>, Tommaso Merciai <tomm.merciai@gmail.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v4 20/20] media: i2c: ov4689: Implement 2x2 binning
Date: Mon, 15 Apr 2024 23:05:47 +0300
In-reply-to: <ZhzEJ81BDT_AJp9X@kekkonen.localdomain>
Message-ID: <87y19e74z5.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Sakari,

and thanks for your review!

On 2024-04-15 at 06:07 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hi Nikhail,
>
> On Tue, Apr 02, 2024 at 07:45:51PM +0300, Mikhail Rudenko wrote:
>> Implement 2x2 binning support. Compute best binning mode (none or 2x2)
>> from pad crop and pad format in ov4689_set_fmt. Use output frame size
>> instead of analogue crop to compute control ranges and BLC anchors.
>>
>> Also move ov4689_hts_min and ov4689_update_ctrl_ranges, since they are
>> now also called from ov4689_set_fmt. Update frame timings to
>> accommodate the requirements of binning mode and avoid visual
>> artefacts. Additionally, report 2x2 binned mode in addition to
>> non-binned one in ov4689_enum_frame_sizes.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 192 +++++++++++++++++++++++++------------
>>  1 file changed, 130 insertions(+), 62 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index e652d626f32f..83c7d0bae7d1 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -114,7 +114,7 @@
>>   * Minimum working vertical blanking value. Found experimentally at
>>   * minimum HTS values.
>>   */
>> -#define OV4689_VBLANK_MIN		31
>> +#define OV4689_VBLANK_MIN		35
>>
>>  static const char *const ov4689_supply_names[] = {
>>  	"avdd", /* Analog power */
>> @@ -256,6 +256,18 @@ static const struct cci_reg_sequence ov4689_common_regs[] = {
>>  	{CCI_REG8(0x5503), 0x0f}, /* OTP_DPC_END_L otp_end_address[7:0] = 0x0f */
>>  };
>>
>> +static const struct cci_reg_sequence ov4689_2x2_binning_regs[] = {
>> +	{CCI_REG8(0x3632), 0x05}, /* ADC */
>> +	{CCI_REG8(0x376b), 0x40}, /* Sensor control */
>> +	{CCI_REG8(0x3814), 0x03}, /* H_INC_ODD */
>> +	{CCI_REG8(0x3821), 0x07}, /* TIMING_FORMAT_2 hor_binning = 1*/
>> +	{CCI_REG8(0x382a), 0x03}, /* V_INC_ODD */
>> +	{CCI_REG8(0x3830), 0x08}, /* BLC_NUM_OPTION blc_use_num_2 = 1 */
>> +	{CCI_REG8(0x3836), 0x02}, /* TIMING_REG_36 r_zline_use_num_2 = 1 */
>> +	{CCI_REG8(0x4001), 0x50}, /* BLC DEBUG MODE */
>> +	{CCI_REG8(0x4502), 0x44}, /* ADC synch control*/
>
> Spaces inside { }'s, please.

Do you mean this array only, or ov4689_common_regs too?

>> +};
>> +
>>  static const u64 link_freq_menu_items[] = { 504000000 };
>>
>>  static const char *const ov4689_test_pattern_menu[] = {
>> @@ -305,18 +317,96 @@ static const struct ov4689_gain_range ov4689_gain_ranges[] = {
>>  	},
>>  };
>>
>> +/*
>> + * For now, only 2x2 binning implemented in this driver.
>> + */
>> +static int ov4689_best_binning(struct ov4689 *ov4689,
>> +			       const struct v4l2_mbus_framefmt *format,
>> +			       const struct v4l2_rect *crop,
>> +			       unsigned int *binning)
>> +{
>> +	const struct v4l2_area candidates[] = {
>> +		{ crop->width, crop->height },
>> +		{ crop->width / 2, crop->height / 2 },
>> +	};
>> +
>> +	const struct v4l2_area *best;
>> +	int index;
>> +
>> +	best = v4l2_find_nearest_size(candidates, ARRAY_SIZE(candidates), width,
>> +				      height, format->width, format->height);
>
> You can assume v4l2_find_nearest_size() returns a non-NULL value (see the
> other patch I cc'd you).

Ack, will remove the NULL check.

>> +	if (!best) {
>> +		dev_err(ov4689->dev,
>> +			"failed to find best binning for requested mode\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	index = best - candidates;
>> +	*binning = index + 1;
>> +
>> +	dev_dbg(ov4689->dev,
>> +		"best_binning: crop=%dx%d format=%dx%d binning=%d\n",
>> +		crop->width, crop->height, format->width, format->height,
>> +		*binning);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Minimum working HTS value for given output width (found
>> + * experimentally).
>> + */
>> +static unsigned int ov4689_hts_min(unsigned int width)
>> +{
>> +	return max_t(unsigned int, 3156, 224 + width * 19 / 16);
>> +}
>> +
>> +static void ov4689_update_ctrl_ranges(struct ov4689 *ov4689, unsigned int width,
>> +				      unsigned int height)
>> +{
>> +	struct v4l2_ctrl *exposure = ov4689->exposure;
>> +	struct v4l2_ctrl *vblank = ov4689->vblank;
>> +	struct v4l2_ctrl *hblank = ov4689->hblank;
>> +	s64 def_val, min_val, max_val;
>> +
>> +	min_val = ov4689_hts_min(width) - width;
>> +	max_val = OV4689_HTS_MAX - width;
>> +	def_val = clamp_t(s64, hblank->default_value, min_val, max_val);
>> +	__v4l2_ctrl_modify_range(hblank, min_val, max_val, hblank->step,
>> +				 def_val);
>
> Note that __v4l2_ctrl_modify_range() may fail. The problem isn't introduced
> by this patch but it'd be nice to fix it (but maybe in a separate patch).

Okay, will do this in a follow-up patch.

>> +
>> +	min_val = OV4689_VBLANK_MIN;
>> +	max_val = OV4689_HTS_MAX - width;
>> +	def_val = clamp_t(s64, vblank->default_value, min_val, max_val);
>> +	__v4l2_ctrl_modify_range(vblank, min_val, max_val, vblank->step,
>> +				 def_val);
>> +
>> +	min_val = exposure->minimum;
>> +	max_val = height + vblank->val - 4;
>> +	def_val = clamp_t(s64, exposure->default_value, min_val, max_val);
>> +	__v4l2_ctrl_modify_range(exposure, min_val, max_val, exposure->step,
>> +				 def_val);
>> +}
>> +
>>  static int ov4689_set_fmt(struct v4l2_subdev *sd,
>>  			  struct v4l2_subdev_state *sd_state,
>>  			  struct v4l2_subdev_format *fmt)
>>  {
>> +	struct ov4689 *ov4689 = to_ov4689(sd);
>>  	struct v4l2_mbus_framefmt *format;
>>  	struct v4l2_rect *crop;
>> +	unsigned int binning;
>> +	int ret;
>>
>>  	crop = v4l2_subdev_state_get_crop(sd_state, fmt->pad);
>>  	format = v4l2_subdev_state_get_format(sd_state, fmt->pad);
>>
>> -	format->width = crop->width;
>> -	format->height = crop->height;
>> +	ret = ov4689_best_binning(ov4689, &fmt->format, crop, &binning);
>> +	if (ret)
>> +		return ret;
>> +
>> +	format->width = crop->width / binning;
>> +	format->height = crop->height / binning;
>>
>>  	format->code = MEDIA_BUS_FMT_SBGGR10_1X10;
>>  	format->field = V4L2_FIELD_NONE;
>> @@ -327,6 +417,9 @@ static int ov4689_set_fmt(struct v4l2_subdev *sd,
>>
>>  	fmt->format = *format;
>>
>> +	if (fmt->which == V4L2_SUBDEV_FORMAT_ACTIVE)
>> +		ov4689_update_ctrl_ranges(ov4689, format->width, format->height);
>> +
>>  	return 0;
>>  }
>>
>> @@ -346,8 +439,9 @@ static int ov4689_enum_frame_sizes(struct v4l2_subdev *sd,
>>  				   struct v4l2_subdev_frame_size_enum *fse)
>>  {
>>  	const struct v4l2_rect *crop;
>> +	int binning;
>>
>> -	if (fse->index >= 1)
>> +	if (fse->index >= 2)
>>  		return -EINVAL;
>>
>>  	if (fse->code != MEDIA_BUS_FMT_SBGGR10_1X10)
>> @@ -355,10 +449,11 @@ static int ov4689_enum_frame_sizes(struct v4l2_subdev *sd,
>>
>>  	crop = v4l2_subdev_state_get_crop(sd_state, 0);
>>
>> -	fse->min_width = crop->width;
>> -	fse->max_width = crop->width;
>> -	fse->max_height = crop->height;
>> -	fse->min_height = crop->height;
>> +	binning = fse->index + 1;
>> +	fse->min_width = crop->width / binning;
>> +	fse->max_width = crop->width / binning;
>> +	fse->max_height = crop->height / binning;
>> +	fse->min_height = crop->height / binning;
>>
>>  	return 0;
>>  }
>> @@ -398,42 +493,6 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>>  	return -EINVAL;
>>  }
>>
>> -/*
>> - * Minimum working HTS value for given output width (found
>> - * experimentally).
>> - */
>> -static unsigned int ov4689_hts_min(unsigned int width)
>> -{
>> -	return max_t(unsigned int, 3156, 224 + width * 19 / 16);
>> -}
>> -
>> -static void ov4689_update_ctrl_ranges(struct ov4689 *ov4689,
>> -				      struct v4l2_rect *crop)
>> -{
>> -	struct v4l2_ctrl *exposure = ov4689->exposure;
>> -	struct v4l2_ctrl *vblank = ov4689->vblank;
>> -	struct v4l2_ctrl *hblank = ov4689->hblank;
>> -	s64 def_val, min_val, max_val;
>> -
>> -	min_val = ov4689_hts_min(crop->width) - crop->width;
>> -	max_val = OV4689_HTS_MAX - crop->width;
>> -	def_val = clamp_t(s64, hblank->default_value, min_val, max_val);
>> -	__v4l2_ctrl_modify_range(hblank, min_val, max_val, hblank->step,
>> -				 def_val);
>> -
>> -	min_val = OV4689_VBLANK_MIN;
>> -	max_val = OV4689_HTS_MAX - crop->width;
>> -	def_val = clamp_t(s64, vblank->default_value, min_val, max_val);
>> -	__v4l2_ctrl_modify_range(vblank, min_val, max_val, vblank->step,
>> -				 def_val);
>> -
>> -	min_val = exposure->minimum;
>> -	max_val = crop->height + vblank->val - 4;
>> -	def_val = clamp_t(s64, exposure->default_value, min_val, max_val);
>> -	__v4l2_ctrl_modify_range(exposure, min_val, max_val, exposure->step,
>> -				 def_val);
>> -}
>> -
>>  static int ov4689_set_selection(struct v4l2_subdev *sd,
>>  				struct v4l2_subdev_state *state,
>>  				struct v4l2_subdev_selection *sel)
>> @@ -470,7 +529,8 @@ static int ov4689_set_selection(struct v4l2_subdev *sd,
>>  		format->height = rect.height;
>>
>>  		if (sel->which == V4L2_SUBDEV_FORMAT_ACTIVE)
>> -			ov4689_update_ctrl_ranges(ov4689, &rect);
>> +			ov4689_update_ctrl_ranges(ov4689, rect.width,
>> +						  rect.height);
>>  	}
>>
>>  	*crop = rect;
>> @@ -485,21 +545,27 @@ static int ov4689_setup_timings(struct ov4689 *ov4689,
>>  	const struct v4l2_mbus_framefmt *format;
>>  	struct regmap *rm = ov4689->regmap;
>>  	const struct v4l2_rect *crop;
>> +	const int v_offset = 2;
>> +	unsigned int binning;
>>  	int ret = 0;
>>
>>  	format = v4l2_subdev_state_get_format(state, 0);
>>  	crop = v4l2_subdev_state_get_crop(state, 0);
>>
>> +	ret = ov4689_best_binning(ov4689, format, crop, &binning);
>> +	if (ret)
>> +		return ret;
>> +
>>  	cci_write(rm, OV4689_REG_H_CROP_START, crop->left, &ret);
>> -	cci_write(rm, OV4689_REG_V_CROP_START, crop->top, &ret);
>> -	cci_write(rm, OV4689_REG_H_CROP_END, crop->left + crop->width + 1, &ret);
>> -	cci_write(rm, OV4689_REG_V_CROP_END, crop->top + crop->height + 1, &ret);
>> +	cci_write(rm, OV4689_REG_V_CROP_START, crop->top - v_offset, &ret);
>> +	cci_write(rm, OV4689_REG_H_CROP_END, crop->left + crop->width + 3, &ret);
>> +	cci_write(rm, OV4689_REG_V_CROP_END, crop->top + crop->height + 7, &ret);
>>
>>  	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, format->width, &ret);
>>  	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, format->height, &ret);
>>
>>  	cci_write(rm, OV4689_REG_H_WIN_OFF, 0, &ret);
>> -	cci_write(rm, OV4689_REG_V_WIN_OFF, 0, &ret);
>> +	cci_write(rm, OV4689_REG_V_WIN_OFF, v_offset, &ret);
>>
>>  	/*
>>  	 * Maximum working value of vfifo_read_start for given output
>> @@ -507,6 +573,10 @@ static int ov4689_setup_timings(struct ov4689 *ov4689,
>>  	 */
>>  	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, format->width / 16 - 1, &ret);
>>
>> +	if (binning == 2)
>> +		cci_multi_reg_write(ov4689->regmap, ov4689_2x2_binning_regs,
>> +				    ARRAY_SIZE(ov4689_2x2_binning_regs),
>> +				    &ret);
>>  	return ret;
>>  }
>>
>> @@ -519,20 +589,20 @@ static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
>>  				    struct v4l2_subdev_state *state)
>>  {
>>  	unsigned int width_def = OV4689_H_OUTPUT_SIZE_DEFAULT;
>> +	const struct v4l2_mbus_framefmt *format;
>>  	struct regmap *rm = ov4689->regmap;
>> -	const struct v4l2_rect *crop;
>>  	int ret = 0;
>>
>> -	crop = v4l2_subdev_state_get_crop(state, 0);
>> +	format = v4l2_subdev_state_get_format(state, 0);
>>
>>  	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START,
>> -		  OV4689_ANCHOR_LEFT_START_DEF * crop->width / width_def, &ret);
>> +		  OV4689_ANCHOR_LEFT_START_DEF * format->width / width_def, &ret);
>>  	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END,
>> -		  OV4689_ANCHOR_LEFT_END_DEF * crop->width / width_def, &ret);
>> +		  OV4689_ANCHOR_LEFT_END_DEF * format->width / width_def, &ret);
>>  	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START,
>> -		  OV4689_ANCHOR_RIGHT_START_DEF * crop->width / width_def, &ret);
>> +		  OV4689_ANCHOR_RIGHT_START_DEF * format->width / width_def, &ret);
>>  	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END,
>> -		  OV4689_ANCHOR_RIGHT_END_DEF * crop->width / width_def, &ret);
>> +		  OV4689_ANCHOR_RIGHT_END_DEF * format->width / width_def, &ret);
>>
>>  	return ret;
>>  }
>> @@ -749,19 +819,19 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  	struct regmap *regmap = ov4689->regmap;
>>  	struct v4l2_subdev_state *sd_state;
>>  	struct device *dev = ov4689->dev;
>> -	struct v4l2_rect *crop;
>> +	struct v4l2_mbus_framefmt *fmt;
>>  	s64 max_expo, def_expo;
>>  	int sensor_gain;
>>  	int ret = 0;
>>
>>  	sd_state = v4l2_subdev_get_locked_active_state(&ov4689->subdev);
>> -	crop = v4l2_subdev_state_get_crop(sd_state, 0);
>> +	fmt = v4l2_subdev_state_get_format(sd_state, 0);
>>
>>  	/* Propagate change of current control to all related controls */
>>  	switch (ctrl->id) {
>>  	case V4L2_CID_VBLANK:
>>  		/* Update max exposure while meeting expected vblanking */
>> -		max_expo = crop->height + ctrl->val - 4;
>> +		max_expo = fmt->height + ctrl->val - 4;
>>  		def_expo = clamp_t(s64, ov4689->exposure->default_value,
>>  				   ov4689->exposure->minimum, max_expo);
>>
>> @@ -785,16 +855,14 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
>>  		break;
>>  	case V4L2_CID_VBLANK:
>> -		cci_write(regmap, OV4689_REG_VTS,
>> -			  ctrl->val + crop->height, &ret);
>> +		cci_write(regmap, OV4689_REG_VTS, ctrl->val + fmt->height, &ret);
>>  		break;
>>  	case V4L2_CID_TEST_PATTERN:
>>  		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
>>  		break;
>>  	case V4L2_CID_HBLANK:
>>  		cci_write(regmap, OV4689_REG_HTS,
>> -			  (ctrl->val + crop->width) /
>> -			  OV4689_HTS_DIVIDER, &ret);
>> +			  (ctrl->val + fmt->width) / OV4689_HTS_DIVIDER, &ret);
>>  		break;
>>  	case V4L2_CID_VFLIP:
>>  		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,


--
Best regards,
Mikhail Rudenko

