Return-Path: <linux-kernel+bounces-78782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3689D8618C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590CF1C25114
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F912B177;
	Fri, 23 Feb 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/FCMC7j"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC11292C6;
	Fri, 23 Feb 2024 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707845; cv=none; b=H2amteRN5olBkrPN2tBFmdZV5VxuLUdzNG27PKHZL6zX27kEZsTDTBvR8Zd7O4sKePYAYmrE3LVk3BgioRPFfRzp4EPoTUbJ7D5GjzsnK5xxHUKAjtMmUg/C+crJ4GiAnqfnOKvRds/36aPaStr6HRh7Tt60pqwxU3sThFSBVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707845; c=relaxed/simple;
	bh=24/2qKxV1gp+6ayMzFlopK0XAHCRMUovamW/HF6TT1k=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=i4Bi4ZAJCos0svDWl7O5yNqcQhivZS8zuE2ElDdoVqSNGwu9VJanalVKrxhgdGbM97/OTfNkGKP5xm0NxU8HkpX/SxYt8bsN9HoSdn0wXejNNJh3CUXSOuBisEM0oj92AyeCRlIX9fnFBdtsdUr5V8WoFEy6h/oeBLXDxkAptKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/FCMC7j; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512cca90f38so1199211e87.2;
        Fri, 23 Feb 2024 09:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707842; x=1709312642; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=5vprYMz4exidKwo8GJvOkhQC/eRW/EWv6a6Q26pk2qY=;
        b=G/FCMC7jz+8Dstlyv54IxbGo2THRicLMCa4AR6mDtlcqnueKleeA9nWcKF8BjLhPGA
         U+9j8v8PBx2OGarDk1JFEKVfRejJ8SKTGu+jpI+v/mV+fkXRAUa+zwPlagAP+n1adNwX
         UmxEoLImuKuD15YdZkOfyZJrHep5a1ujr/xIW4+sAQutMKdnBH8SVx2KgzW2PUu1UJHW
         sKnyHxT0IZVnWzM4EK2TfZ7XRfQbFTygxO6y9eG4itw6b+6Zx5An2JGUHPsMpsJ82VWv
         M+FgvHmnyAwqZNdXMdb3wzMsV+YhT38xbSI1yNnVOk2CvWMQ7RcO1ZqtyIuYpGiXe+MJ
         LmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707842; x=1709312642;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vprYMz4exidKwo8GJvOkhQC/eRW/EWv6a6Q26pk2qY=;
        b=SFM7hUg82Zsr8kndWVZUJp2a3o1/CHFdwqGl3qtF9Dpq/NH/KiSLlJJSjML1hAjoq2
         wiHgx1WwpnrCVpEv7TwzmN6uloBUTHvJ2r7beTxufs42Buu7zTbauH61jBINQVl9S28/
         4ESKOLiKijUKe6Drf4s1ImC3rl6gk+bp5PD/jxG+tTW+ShqEW81KoEoRlqLqFCNNeZ7X
         eHjboXydcMr+R+K62M5fGO/X9FQMNHmu6bi8AWG/7yuZpfj0QdQ4iX93HrK/Z35MEp2H
         0C1TvS0r6hqfY6p1O91gYzf/EjOd9QvtLRWTchgg0kokQDEfMRcz/OQJGiMLije7M5Y5
         otGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU21ZlUXgd/kI139YBKCu8DD3Hv094l9HK1nmtwRr8eLqaNCJE1okojM862552UBVIlIbxokO95AH15k8ys5rQf1xPNAungWiTkKTS9
X-Gm-Message-State: AOJu0YwNEVWfDPVUfhByw3C426RwVi8IrVRu4vrTyPEQfKlAJ2esXh5g
	dX9fGFMrmaGM45ji9JEFP14UDnuCC5FOzwE2CK835miZFwpNoUxn
X-Google-Smtp-Source: AGHT+IFjfi2rjXSi5yl86kTwZSozJHbTGqxDKbGIdtVb8FIju9srax57AinJqwbbiRKvKCKZlRSxwA==
X-Received: by 2002:a05:6512:23a5:b0:512:bc14:6b80 with SMTP id c37-20020a05651223a500b00512bc146b80mr232877lfv.25.1708707841926;
        Fri, 23 Feb 2024 09:04:01 -0800 (PST)
Received: from razdolb ([37.1.50.248])
        by smtp.gmail.com with ESMTPSA id fb18-20020a056512125200b00512e548a6c5sm356328lfb.235.2024.02.23.09.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:04:01 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-17-mike.rudenko@gmail.com>
 <20240223114403.GT31348@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, Tommaso
 Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 16/20] media: i2c: ov4689: Set timing registers
 programmatically
Date: Fri, 23 Feb 2024 19:34:06 +0300
In-reply-to: <20240223114403.GT31348@pendragon.ideasonboard.com>
Message-ID: <87v86fcdtq.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Laurent,

and thanks for the review!

On 2024-02-23 at 13:44 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> Thank you for the patch.
>
> On Mon, Dec 18, 2023 at 08:40:37PM +0300, Mikhail Rudenko wrote:
>> Set timing-related and BLC anchor registers via cci calls instead of
>> hardcoding them in the register table. This prepares the driver for
>> implementation of configurable analogue crop and binning. No
>> functional change intended.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 83 +++++++++++++++++++++++++++++++-------
>>  1 file changed, 68 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 475508559e3e..3b73ee282761 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -41,6 +41,13 @@
>>  #define OV4689_DIG_GAIN_STEP		1
>>  #define OV4689_DIG_GAIN_DEFAULT		0x800
>>
>> +#define OV4689_REG_H_CROP_START		CCI_REG16(0x3800)
>> +#define OV4689_REG_V_CROP_START		CCI_REG16(0x3802)
>> +#define OV4689_REG_H_CROP_END		CCI_REG16(0x3804)
>> +#define OV4689_REG_V_CROP_END		CCI_REG16(0x3806)
>> +#define OV4689_REG_H_OUTPUT_SIZE	CCI_REG16(0x3808)
>> +#define OV4689_REG_V_OUTPUT_SIZE	CCI_REG16(0x380a)
>> +
>>  #define OV4689_REG_HTS			CCI_REG16(0x380c)
>>  #define OV4689_HTS_DIVIDER		4
>>  #define OV4689_HTS_MAX			0x7fff
>> @@ -48,6 +55,9 @@
>>  #define OV4689_REG_VTS			CCI_REG16(0x380e)
>>  #define OV4689_VTS_MAX			0x7fff
>>
>> +#define OV4689_REG_H_WIN_OFF		CCI_REG16(0x3810)
>> +#define OV4689_REG_V_WIN_OFF		CCI_REG16(0x3812)
>> +
>>  #define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
>>  #define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
>>  #define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
>> @@ -56,6 +66,17 @@
>>  #define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
>>  					 OV4689_TIMING_FLIP_DIGITAL)
>>
>> +#define OV4689_REG_ANCHOR_LEFT_START	CCI_REG16(0x4020)
>> +#define OV4689_ANCHOR_LEFT_START_DEF	576
>> +#define OV4689_REG_ANCHOR_LEFT_END	CCI_REG16(0x4022)
>> +#define OV4689_ANCHOR_LEFT_END_DEF	831
>> +#define OV4689_REG_ANCHOR_RIGHT_START	CCI_REG16(0x4024)
>> +#define OV4689_ANCHOR_RIGHT_START_DEF	1984
>> +#define OV4689_REG_ANCHOR_RIGHT_END	CCI_REG16(0x4026)
>> +#define OV4689_ANCHOR_RIGHT_END_DEF	2239
>> +
>> +#define OV4689_REG_VFIFO_CTRL_01	CCI_REG8(0x4601)
>> +
>>  #define OV4689_REG_WB_GAIN_RED		CCI_REG16(0x500c)
>>  #define OV4689_REG_WB_GAIN_BLUE		CCI_REG16(0x5010)
>>  #define OV4689_WB_GAIN_MIN		1
>> @@ -199,10 +220,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>>  	{CCI_REG8(0x3798), 0x1b},
>>
>>  	/* Timing control */
>> -	{CCI_REG8(0x3801), 0x08}, /* H_CROP_START_L h_crop_start[7:0] = 0x08 */
>> -	{CCI_REG8(0x3805), 0x97}, /* H_CROP_END_L h_crop_end[7:0] = 0x97 */
>> -	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
>> -	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
>>  	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
>>
>>  	/* OTP control */
>> @@ -218,22 +235,11 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>>  	{CCI_REG8(0x401b), 0x00}, /* DEBUG_MODE */
>>  	{CCI_REG8(0x401d), 0x00}, /* DEBUG_MODE */
>>  	{CCI_REG8(0x401f), 0x00}, /* DEBUG_MODE */
>> -	{CCI_REG8(0x4020), 0x00}, /* ANCHOR_LEFT_START_H anchor_left_start[11:8] = 0 */
>> -	{CCI_REG8(0x4021), 0x10}, /* ANCHOR_LEFT_START_L anchor_left_start[7:0] = 0x10 */
>> -	{CCI_REG8(0x4022), 0x07}, /* ANCHOR_LEFT_END_H anchor_left_end[11:8] = 0x07 */
>> -	{CCI_REG8(0x4023), 0xcf}, /* ANCHOR_LEFT_END_L anchor_left_end[7:0] = 0xcf */
>> -	{CCI_REG8(0x4024), 0x09}, /* ANCHOR_RIGHT_START_H anchor_right_start[11:8] = 0x09 */
>> -	{CCI_REG8(0x4025), 0x60}, /* ANCHOR_RIGHT_START_L anchor_right_start[7:0] = 0x60 */
>> -	{CCI_REG8(0x4026), 0x09}, /* ANCHOR_RIGHT_END_H anchor_right_end[11:8] = 0x09 */
>> -	{CCI_REG8(0x4027), 0x6f}, /* ANCHOR_RIGHT_END_L anchor_right_end[7:0] = 0x6f */
>>
>>  	/* ADC sync control */
>>  	{CCI_REG8(0x4500), 0x6c}, /* ADC_SYNC_CTRL */
>>  	{CCI_REG8(0x4503), 0x01}, /* ADC_SYNC_CTRL */
>>
>> -	/* VFIFO */
>> -	{CCI_REG8(0x4601), 0xa7}, /* VFIFO_CTRL_01 r_vfifo_read_start[7:0] = 0xa7 */
>> -
>>  	/* Temperature monitor */
>>  	{CCI_REG8(0x4d00), 0x04}, /* TPM_CTRL_00 tmp_slope[15:8] = 0x04 */
>>  	{CCI_REG8(0x4d01), 0x42}, /* TPM_CTRL_01 tmp_slope[7:0] = 0x42 */
>> @@ -406,6 +412,41 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>>  	return -EINVAL;
>>  }
>>
>> +static int ov4689_setup_timings(struct ov4689 *ov4689)
>> +{
>> +	const struct ov4689_mode *mode = ov4689->cur_mode;
>> +	struct regmap *rm = ov4689->regmap;
>> +	int ret = 0;
>> +
>> +	cci_write(rm, OV4689_REG_H_CROP_START, 8, &ret);
>> +	cci_write(rm, OV4689_REG_V_CROP_START, 8, &ret);
>> +	cci_write(rm, OV4689_REG_H_CROP_END, 2711, &ret);
>> +	cci_write(rm, OV4689_REG_V_CROP_END, 1531, &ret);
>
> This is interesting. The previous patch defines
>
> #define OV4689_PIXEL_ARRAY_WIDTH	2720
> #define OV4689_PIXEL_ARRAY_HEIGHT	1536
> #define OV4689_DUMMY_ROWS		8
> #define OV4689_DUMMY_COLUMNS		16
>
> and the (only) mode has
>
> 	.width = 2688,
> 	.height = 1520,
>
> The above register values should result in an analog crop rectangle size
> of 2704x1524. Then, the digital crop is configured below to
> (8,4)/2688x1520. The combined crop rectangle, relative to the pixel
> array, is thus (16,12)/2688x1520. This centers the crop rectangle
> horizontally but not vertically. I wonder why, and I also wonder why
> there's a need to apply both analog crop and digital crop, instead of
> setting
>
> 	OV4689_REG_H_CROP_START = 16
> 	OV4689_REG_V_CROP_START = 8
> 	OV4689_REG_H_CROP_END = 2703
> 	OV4689_REG_V_CROP_END = 1527
>
> 	OV4689_REG_H_WIN_OFF = 0
> 	OV4689_REG_V_WIN_OFF = 0
> 	OV4689_REG_H_OUTPUT_SIZE = 2688
> 	OV4689_REG_V_OUTPUT_SIZE = 1520

The only reason for this is purely historical: these cropping/windowing
settings were used in the register-table-based driver from Rockchip BSP,
and there was no reason to change them until now. In fact, the next
patch ([PATCH v2 17/20] media: i2c: ov4689: Configurable analogue crop)
does exactly what you suggest. :)

> Anyway, this is not an issue introduced by this patch, so
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>> +
>> +	cci_write(rm, OV4689_REG_H_OUTPUT_SIZE, mode->width, &ret);
>> +	cci_write(rm, OV4689_REG_V_OUTPUT_SIZE, mode->height, &ret);
>> +
>> +	cci_write(rm, OV4689_REG_H_WIN_OFF, 8, &ret);
>> +	cci_write(rm, OV4689_REG_V_WIN_OFF, 4, &ret);
>> +
>> +	cci_write(rm, OV4689_REG_VFIFO_CTRL_01, 167, &ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int ov4689_setup_blc_anchors(struct ov4689 *ov4689)
>> +{
>> +	struct regmap *rm = ov4689->regmap;
>> +	int ret = 0;
>> +
>> +	cci_write(rm, OV4689_REG_ANCHOR_LEFT_START, 16, &ret);
>> +	cci_write(rm, OV4689_REG_ANCHOR_LEFT_END, 1999, &ret);
>> +	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_START, 2400, &ret);
>> +	cci_write(rm, OV4689_REG_ANCHOR_RIGHT_END, 2415, &ret);
>> +
>> +	return ret;
>> +}
>> +
>>  static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>>  {
>>  	struct ov4689 *ov4689 = to_ov4689(sd);
>> @@ -429,6 +470,18 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>>  			goto unlock_and_return;
>>  		}
>>
>> +		ret = ov4689_setup_timings(ov4689);
>> +		if (ret) {
>> +			pm_runtime_put(dev);
>> +			goto unlock_and_return;
>> +		}
>> +
>> +		ret = ov4689_setup_blc_anchors(ov4689);
>> +		if (ret) {
>> +			pm_runtime_put(dev);
>> +			goto unlock_and_return;
>> +		}
>> +
>>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>>  		if (ret) {
>>  			pm_runtime_put_sync(dev);


--
Best regards,
Mikhail Rudenko

