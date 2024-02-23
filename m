Return-Path: <linux-kernel+bounces-78773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 396F98618A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293461C24F31
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B28312A16B;
	Fri, 23 Feb 2024 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw9t7sS4"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D582C60;
	Fri, 23 Feb 2024 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707704; cv=none; b=pVFQZ7O5rKZnRLDCmlDUQYajAfL7FtLmCW5VgV+T5VC+uPT3tfS8jVNEGtJVNpyko3IyB39cLyUGNA+Fdpqvaebnk8rORyVUqyLW7mYUbhUVIQLn5uWzHgAy6l2CB5LSwLWjdMTjLylBaEohG32Zq/rdjorqWL5czYj6vG6Dwi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707704; c=relaxed/simple;
	bh=vFe08SHWfvtabkZYLW4bToYNx3XoemYaDa5So50KBcg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=gAg4Mi7w/CR41tgJDOZICVnldYjoDkTkwWGbwYNZ/G+FOWAa42gO02UN+DOpVsJVZvuAqwnIqYY28Xd/hqdc5yXdIxkmc3FKeiGNNkHU0I6dne96fqK9d+PZ+EU+SuVafDYbQ8Y4y/fFl5LMOIJ7hhjMjQqGlfHMN5ijt5k1JtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw9t7sS4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-512cba0f953so1309599e87.2;
        Fri, 23 Feb 2024 09:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707701; x=1709312501; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=HOTu63PGtzhSM1REmMCwm5QM0qnE5EGykzoHaNQEl2g=;
        b=Rw9t7sS4d8JLsi6dFeK0LSaT5Jd3nwbMsVuP/Ftw5GcAq+cQMxIhq8QY1cu6l7kUQI
         KkKneH//VujbVSfQeHALYR76Y86fNIM7VYa0jfCUQcFvAW2KEDD5aYeRoSgEFsBxgVUO
         7awmsJ5u/CcD6CcnLrOzNrkxvh6N6RmpzSvhdUD2Xrtd4X9LxCqgBOUb3hzr62w1z0Kf
         F+wSjxhSeOFi5JnOzoTRhKaZYQcNUamYHriY0wz6GtXexNUV2YdIgQp6NfLX1qA5fBSU
         mY+rNy7i7FeGuMf71ITqCYUNpWZI32O5gF4zwCuoMgb8BI8Zmki/UBXibfMD1lJuQq1g
         H6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707701; x=1709312501;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOTu63PGtzhSM1REmMCwm5QM0qnE5EGykzoHaNQEl2g=;
        b=SgNkynINXReGT9LXkKB3ZtReJx9LCmvXRTUG2vKAYxRc+mwvVUzO5lyoEkveH2uFPU
         7el+4h4krGrosrzhIKTV8l8PzayEfDF6WSF+lujxmBxSsojyq0X2RLUO7mPJkHa9ZJGS
         1qgJiO3QKzseYVvDz6bE7hDYc4Om1keNUH09zEP8hVyNZT6XBge3+ow2ki/ryH999RN7
         5CfpU93P42+e6T03/yPSX68OEHsJWXeXVdopEmQ88MJKs4JbnWRiFRrnPcE2ha2YHpJ6
         2Xr7dDgyIyDOjWerNcDiS1wM4w3PS3frYYZ8HwYjp0qnTM8RSfViqqTX5GjvBpwuaX2P
         NMsw==
X-Forwarded-Encrypted: i=1; AJvYcCW3QQbNrhPIMBjrL3Euc+rqV6XULc6E1FuVgecWGRToEBWEFIiFIcaQfCK/1ZEAFbkM8BdGLhx8CXjnZM2f/9PfPEPaB8NZGmEGEmDA
X-Gm-Message-State: AOJu0YxBXYTIfz4iMH8enhu8Eqz8mZxOwrg58Mxr46BhHQJFVvqfKcES
	8BUjoGfJIfe0XUZxqVmo4wUorcp6frgm4upxcB2s+RWhK0mEsICN
X-Google-Smtp-Source: AGHT+IFWTQHl/aU3c3aQiF01cEG8MUlvNNcZzilHQm4QpiRC0NAvWoTEUfbOz/01U/+KZAUBrq80QQ==
X-Received: by 2002:a05:6512:2399:b0:512:a8e1:abd1 with SMTP id c25-20020a056512239900b00512a8e1abd1mr331819lfv.23.1708707700705;
        Fri, 23 Feb 2024 09:01:40 -0800 (PST)
Received: from razdolb ([37.1.50.248])
        by smtp.gmail.com with ESMTPSA id z16-20020a056512371000b005118f924165sm2539844lfr.133.2024.02.23.09.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:01:40 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-13-mike.rudenko@gmail.com>
 <ZdhWzCNalXnScMQy@kekkonen.localdomain>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Jacopo Mondi
 <jacopo@jmondi.org>, Tommaso Merciai <tomm.merciai@gmail.com>, Christophe
 JAILLET <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 12/20] media: i2c: ov4689: Implement vflip/hflip
 controls
Date: Fri, 23 Feb 2024 18:21:20 +0300
In-reply-to: <ZdhWzCNalXnScMQy@kekkonen.localdomain>
Message-ID: <87h6hzdsi4.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Sakari,

and thanks for the review!

On 2024-02-23 at 08:26 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hi Mikhail,
>
> On Mon, Dec 18, 2023 at 08:40:33PM +0300, Mikhail Rudenko wrote:
>> The OV4689 sensor supports horizontal and vertical flipping. Add
>> appropriate controls to the driver. Toggling both array flip and
>> digital flip bits allows to achieve flipping while maintaining output
>> Bayer order. Note that the default value of hflip control corresponds
>> to both bits set, as it was before this patch.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 06ed9d22b2c8..6cf986bf305d 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -42,6 +42,14 @@
>>  #define OV4689_REG_VTS			CCI_REG16(0x380e)
>>  #define OV4689_VTS_MAX			0x7fff
>>
>> +#define OV4689_REG_TIMING_FORMAT1	CCI_REG8(0x3820)
>> +#define OV4689_REG_TIMING_FORMAT2	CCI_REG8(0x3821)
>> +#define OV4689_TIMING_FLIP_MASK		GENMASK(2, 1)
>> +#define OV4689_TIMING_FLIP_ARRAY	BIT(1)
>> +#define OV4689_TIMING_FLIP_DIGITAL	BIT(2)
>> +#define OV4689_TIMING_FLIP_BOTH		(OV4689_TIMING_FLIP_ARRAY |\
>> +					 OV4689_TIMING_FLIP_DIGITAL)
>> +
>>  #define OV4689_REG_TEST_PATTERN		CCI_REG8(0x5040)
>>  #define OV4689_TEST_PATTERN_ENABLE	0x80
>>  #define OV4689_TEST_PATTERN_DISABLE	0x0
>> @@ -183,7 +191,6 @@ static const struct cci_reg_sequence ov4689_2688x1520_regs[] = {
>>  	{CCI_REG8(0x3811), 0x08}, /* H_WIN_OFF_L h_win_off[7:0] = 0x08*/
>>  	{CCI_REG8(0x3813), 0x04}, /* V_WIN_OFF_L v_win_off[7:0] = 0x04 */
>>  	{CCI_REG8(0x3819), 0x01}, /* VSYNC_END_L vsync_end_point[7:0] = 0x01 */
>> -	{CCI_REG8(0x3821), 0x06}, /* TIMING_FORMAT2 array_h_mirror = 1, digital_h_mirror = 1 */
>>
>>  	/* OTP control */
>>  	{CCI_REG8(0x3d85), 0x36}, /* OTP_REG85 OTP_power_up_load_setting_enable = 1,
>> @@ -607,6 +614,16 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  			  (ctrl->val + ov4689->cur_mode->width) /
>>  			  OV4689_HTS_DIVIDER, &ret);
>>  		break;
>> +	case V4L2_CID_VFLIP:
>> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT1,
>> +				OV4689_TIMING_FLIP_MASK,
>> +				ctrl->val ? OV4689_TIMING_FLIP_BOTH : 0, &ret);
>> +		break;
>> +	case V4L2_CID_HFLIP:
>> +		cci_update_bits(regmap, OV4689_REG_TIMING_FORMAT2,
>> +				OV4689_TIMING_FLIP_MASK,
>> +				ctrl->val ? 0 : OV4689_TIMING_FLIP_BOTH, &ret);
>> +		break;
>>  	default:
>>  		dev_warn(dev, "%s Unhandled id:0x%x, val:0x%x\n",
>>  			 __func__, ctrl->id, ctrl->val);
>> @@ -637,7 +654,7 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>
>>  	handler = &ov4689->ctrl_handler;
>>  	mode = ov4689->cur_mode;
>> -	ret = v4l2_ctrl_handler_init(handler, 10);
>> +	ret = v4l2_ctrl_handler_init(handler, 12);
>>  	if (ret)
>>  		return ret;
>>
>> @@ -677,6 +694,9 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>  				     ARRAY_SIZE(ov4689_test_pattern_menu) - 1,
>>  				     0, 0, ov4689_test_pattern_menu);
>>
>> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_VFLIP, 0, 1, 1, 0);
>> +	v4l2_ctrl_new_std(handler, &ov4689_ctrl_ops, V4L2_CID_HFLIP, 0, 1, 1, 0);
>
> Could you take the default value from the mounting rotation?

Could you provide an example (maybe a link to an existing driver) which
does this right? If I understand you correctly, I should flip default
for both flip controls for 180 degree rotation. But what should I do for
90, 270 and all the rest rotation values?

> The default should be upside-up, but this is an existing driver and
> changing the flipping now could affect existing users.

Do you mean default rotation value when missing device tree property?

> <URL:https://hverkuil.home.xs4all.nl/spec/userspace-api/drivers/camera-sensor.html#rotation-orientation-and-flipping>
>



>> +
>>  	if (handler->error) {
>>  		ret = handler->error;
>>  		dev_err(ov4689->dev, "Failed to init controls(%d)\n", ret);


--
Best regards,
Mikhail Rudenko

