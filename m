Return-Path: <linux-kernel+bounces-78781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8CC8618BE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6731C256D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1003E12C549;
	Fri, 23 Feb 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URGWB2MX"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB71292DB;
	Fri, 23 Feb 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707796; cv=none; b=PjtVbimyDcxnf1GjtNtrJnfgc0Ioq2q4ZUvS98HE5ZvjXYB//y59xvDSYZwfzHEyXCdHuv7EEpzVJtnizS8jy0Rh5DqwQct+w1Gp7dIil9e1K3g3cJDo0Sf/ETxaOhTiaZg6o2EYHRl5J40r5IM48cj9vYKvCi3aaVPymNehDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707796; c=relaxed/simple;
	bh=7n8RedZ0xWn7IdIkdPbd+ilccelPiKvUF3ld378XrVE=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=MosaYJg+hLCegnAr3bmX8R80no7oG6qWdNKRRjhQtAa6y0JFqlAnVGqH17p/IWzl/vSK2NC1ercJS8X0ZukJJWKtJoPnNtvmBld97312wDdYI6f57I9OuWy+UeO061z5Xz19gTSCwJd2AEPnoq7Ea+AjVBwiy6bhYEw8jJBM/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URGWB2MX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d220e39907so16673501fa.1;
        Fri, 23 Feb 2024 09:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707792; x=1709312592; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mW8xcqnDkWV0uEFqtULo2IwxLUVuh2iE8fFcKgkzCtw=;
        b=URGWB2MXhgVQ+HLjX0LUfA+bx8SQ0dxNuRhVpRcSnQ4ZKbuoDbv031D9da+FxhTW6/
         1nMs4x6LKHfYgbWjCjMyYMvWCmO5tYCzaiY45xmbJeGDCfnI9LwfogNAwpdRcEJxrPeq
         /ktuBorbeGGdfqsN/bNnI5d2U9fuYoqGlOqH5IPs9+G0xNwxuO79AkcqGmumn+BE3Zpg
         A4gCYM4exC1ag0QWOE2wABmoelx6Zvrz1vBSo6MIhtxF9Ww0j9oauJR9QkK3qKjIi2uI
         HKpKF1Y6Uu4hII1bY0eYXcrL0zUYYa1burZrbKfLq6bjmYOQ++7vs8Cp7lBR4AvZ1Xh3
         dHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707792; x=1709312592;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW8xcqnDkWV0uEFqtULo2IwxLUVuh2iE8fFcKgkzCtw=;
        b=PZnemro8RLlDlUJZBU5Bm2IQKQG6vrrbNT4RkaL6lMh5moqqCCWpToOXknbMexfW2g
         RiNGq7Yei3dzTojl24Lm6nSkWKpOh3YxyyhugC3Qr/EfMdWqj9dKax3sqdpYdCzepCjV
         xYXbnjzd/MZxViamE/VQ5HHJ/slWoIzh1VY5+UqaClcJFWGNg1c81RqrcOuMmNpZRqtU
         +wDyaEROWLlcPix6Oo3nbCcmr5bhNU1QoKgEEh07+xNqCnKm3AYv0sLFq/F9OQTWx5ed
         ZlbFdureTH5iM6iV0wjjSY+QLuprwOC+F90DYS2UrQ0nTmWUp7zuQtouphUxok29Lhwt
         UtNA==
X-Forwarded-Encrypted: i=1; AJvYcCVADOlfaed44L6KAmyxpKQZXdL1MhxnDYhTWAYxwQKlXAHaXujoxCuN+8qkpe4FtBjNGkC1cPvp6ZetqxzEFI79LiURvJcthToMqZRL
X-Gm-Message-State: AOJu0Yz37FT+LaZL/OrzhNVRhKKagdtpgAtIOrMlPkIpvraf25bxNa49
	gUktfgdURD31L9hdahDlItMQ9NRu5XV8r1yc8q+RBfKqbHDUcqml
X-Google-Smtp-Source: AGHT+IGDqndCkPZfad26XaEKRMpgjuMo/RLtQfIcal/ei4ScMQhNCe3PiHiguOb/+D0pcvzGLj+NVw==
X-Received: by 2002:a2e:9187:0:b0:2d2:4028:9799 with SMTP id f7-20020a2e9187000000b002d240289799mr278460ljg.29.1708707792458;
        Fri, 23 Feb 2024 09:03:12 -0800 (PST)
Received: from razdolb ([37.1.50.248])
        by smtp.gmail.com with ESMTPSA id y18-20020a2eb012000000b002d25eb9e940sm693959ljk.90.2024.02.23.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:03:12 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-16-mike.rudenko@gmail.com>
 <20240223113300.GS31348@pendragon.ideasonboard.com>
 <20240223113637.GA14575@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, Tommaso
 Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 15/20] media: i2c: ov4689: Move pixel array size out
 of struct ov4689_mode
Date: Fri, 23 Feb 2024 19:31:36 +0300
In-reply-to: <20240223113637.GA14575@pendragon.ideasonboard.com>
Message-ID: <87zfvrcdv4.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Laurent,

and thanks for the review!

On 2024-02-23 at 13:36 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> On Fri, Feb 23, 2024 at 01:33:01PM +0200, Laurent Pinchart wrote:
>> Hi Mikhail,
>>
>> Thank you for the patch.
>>
>> On Mon, Dec 18, 2023 at 08:40:36PM +0300, Mikhail Rudenko wrote:
>> > Pixel array dimensions and default crop size do not belong to the
>> > ov4689_mode structure, since they are mode independent. Make them
>> > defines instead.
>> >
>> > Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> > ---
>> >  drivers/media/i2c/ov4689.c | 29 +++++++++++++----------------
>> >  1 file changed, 13 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> > index b43fb1d7b15f..475508559e3e 100644
>> > --- a/drivers/media/i2c/ov4689.c
>> > +++ b/drivers/media/i2c/ov4689.c
>> > @@ -70,6 +70,11 @@
>> >  #define OV4689_LANES			4
>> >  #define OV4689_XVCLK_FREQ		24000000
>> >
>> > +#define OV4689_PIXEL_ARRAY_WIDTH	2720
>> > +#define OV4689_PIXEL_ARRAY_HEIGHT	1536
>> > +#define OV4689_DUMMY_ROWS		8
>> > +#define OV4689_DUMMY_COLUMNS		16
>>
>> Adding a comment here to indicate that there are dummy columns in each
>> side would be useful:
>>
>> #define OV4689_DUMMY_ROWS		8	/* 8 dummy rows on each side */
>> #define OV4689_DUMMY_COLUMNS		16	/* 16 dummy columns on each side */
>>
>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> > +
>> >  static const char *const ov4689_supply_names[] = {
>> >  	"avdd", /* Analog power */
>> >  	"dovdd", /* Digital I/O power */
>> > @@ -90,10 +95,6 @@ struct ov4689_mode {
>> >  	u32 vts_def;
>> >  	u32 exp_def;
>> >  	u32 pixel_rate;
>> > -	u32 sensor_width;
>> > -	u32 sensor_height;
>> > -	u32 crop_top;
>> > -	u32 crop_left;
>> >  	const struct cci_reg_sequence *reg_list;
>> >  	unsigned int num_regs;
>> >  };
>> > @@ -254,10 +255,6 @@ static const struct ov4689_mode supported_modes[] = {
>> >  		.id = OV4689_MODE_2688_1520,
>> >  		.width = 2688,
>> >  		.height = 1520,
>> > -		.sensor_width = 2720,
>> > -		.sensor_height = 1536,
>> > -		.crop_top = 8,
>> > -		.crop_left = 16,
>> >  		.exp_def = 1536,
>> >  		.hts_def = 10296,
>> >  		.hts_min = 3432,
>> > @@ -385,8 +382,6 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>> >  				struct v4l2_subdev_state *state,
>> >  				struct v4l2_subdev_selection *sel)
>> >  {
>> > -	const struct ov4689_mode *mode = to_ov4689(sd)->cur_mode;
>> > -
>> >  	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
>> >  		return -EINVAL;
>> >
>> > @@ -394,15 +389,17 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>> >  	case V4L2_SEL_TGT_CROP_BOUNDS:
>> >  		sel->r.top = 0;
>> >  		sel->r.left = 0;
>> > -		sel->r.width = mode->sensor_width;
>> > -		sel->r.height = mode->sensor_height;
>> > +		sel->r.width = OV4689_PIXEL_ARRAY_WIDTH;
>> > +		sel->r.height = OV4689_PIXEL_ARRAY_HEIGHT;
>> >  		return 0;
>> >  	case V4L2_SEL_TGT_CROP:
>> >  	case V4L2_SEL_TGT_CROP_DEFAULT:
>> > -		sel->r.top = mode->crop_top;
>> > -		sel->r.left = mode->crop_left;
>> > -		sel->r.width = mode->width;
>> > -		sel->r.height = mode->height;
>> > +		sel->r.top = OV4689_DUMMY_ROWS;
>> > +		sel->r.left = OV4689_DUMMY_COLUMNS;
>> > +		sel->r.width =
>> > +			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_COLUMNS;
>> > +		sel->r.height =
>> > +			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_ROWS;
>
> I spoke too fast: this should be OV4689_PIXEL_ARRAY_HEIGHT, not
> OV4689_PIXEL_ARRAY_WIDTH.

Good catch, will fix in v3.

>> >  		return 0;
>> >  	}
>> >


--
Best regards,
Mikhail Rudenko

