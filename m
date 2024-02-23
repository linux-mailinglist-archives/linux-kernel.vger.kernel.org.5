Return-Path: <linux-kernel+bounces-78780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF448618BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5787D1F260D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872412D74B;
	Fri, 23 Feb 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoGOy6Vs"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961CF12AAFA;
	Fri, 23 Feb 2024 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707777; cv=none; b=AnnpKa3iY7aR/qw3wZxSimnGYxCaVALwwg4g7xt0nuZwlJ9QKJHFeOFvQfKH9MBphD0QFXB+51aOZzHcXCDEAYvpHEy/8zwlMKPnudwpxvpXeA45RplfrjFe9zSXbd/CFSPbyasPdEgh/cXg6YZFezvGqYZ9VMNfqv6ClGtf7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707777; c=relaxed/simple;
	bh=w3vKnidsx0wUtK3fpR4TZWN2po2bShZX3cmliDEejj4=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=EqEn56u4ER/UtCpOLArEcUUagRi9cwQu3SX4YpVw2sBIEljcOP/w7ufbHDpx3EJzAhiCEDs+8i8tpiZcZFQotCMZSSJPqXri9zdEDypQVx5tS/cVV1g1eufJvb3rW9w4b/YrzsHQbCS80/yvFFOlpPq4dBEGIJchid7ocebYh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoGOy6Vs; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512d5744290so1427477e87.2;
        Fri, 23 Feb 2024 09:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707773; x=1709312573; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=SDARa/oqbm/d9tdhXbytuGygf2kw/guW3ER9GGbmrkA=;
        b=PoGOy6VsUZVpdbHGSOvTwqr5zNlukF2OB5FalDDhEaNQ3AAmoncgHw67M2amuQSzQd
         ULKORic7Dv73K3dwU4RE7dG0RdlvvcNwe+Ocz5b0tVtqkII5w3dyPKuC+GC7rmHb27nf
         8CxOrgtt8oypUzq9Q3jS189n9TGQMXw3IAVH+nmP06SD8DUFqcHGG1544ssllBt++ETF
         BWRuIObh+rW29H5oGsZn/ueLpupfCioU3UW1Dq+2yLGm+QKjSISYmN4cip7sWNiW3Mxt
         XH5tuhaJxH0DDWasDb9TH6TQ+z4SNmnvO5yXdHbUr+EjuFDSb/5MoIN4hHxnwfezq+AY
         Gv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707773; x=1709312573;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDARa/oqbm/d9tdhXbytuGygf2kw/guW3ER9GGbmrkA=;
        b=Mn7NyaEtJzVwNN1gRnCx7MwXrhzEa6ufDsz0aKUP7sgetOK2MMGSA/UbVkdeY+sVfx
         dJVD1BUxReBOWATpeXJNyFv6J88PqC3C6C6+iJ3jySHLa4keFtxSYPiu7tzKCrhV8ola
         c/w0QYhk0S69d78Q/QD+MZqH35dYposQ1qQIeHWMnQ/QKF4bQXDS80dqxGFvRHZrLJYH
         kItIviPZ0E/Pe6zfzJVvp5PNa6z7YnWksVVLJovuP6r0oDJz/QfTsU13+ShNUoxL7zC6
         nef0b94Topuj7TDCrEhoEYNUkMuA2RzorJ3r9b6LBgmhXk9e1ECnijSn9RO99gYgwMyA
         uoIA==
X-Forwarded-Encrypted: i=1; AJvYcCXoPxBftbPCyeiPyuDl6tth2BpP+mz2gS93b++53KQvfgOSC+QKTzJOZe92YvDItUMny4Nf7rLH6A/gul6VeL04JmNuTYVgr61icGBo
X-Gm-Message-State: AOJu0Yw5SZkm6NHNQ3SL35CdTWxufiGIa+ueFK1bwn/zYbwzKcvp5VRr
	tF1lzq1FkNu9nzI4M09tHc7RzR+CHqL6abTbYW2O8Jzn2Xxwo/rtmtRQf84a86SQVw==
X-Google-Smtp-Source: AGHT+IHa0Wv6AanMCgAGh0zxvBqJA4ChoAzx7oJxdKKctA8sXuKVuddjKVQs1OBIpwnhVCHG65/MIQ==
X-Received: by 2002:ac2:4f0b:0:b0:512:b318:c1fd with SMTP id k11-20020ac24f0b000000b00512b318c1fdmr293439lfr.54.1708707773451;
        Fri, 23 Feb 2024 09:02:53 -0800 (PST)
Received: from razdolb ([37.1.50.248])
        by smtp.gmail.com with ESMTPSA id p5-20020a056512234500b00512dd531149sm652334lfu.74.2024.02.23.09.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:02:53 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-16-mike.rudenko@gmail.com>
 <20240223113300.GS31348@pendragon.ideasonboard.com>
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
Date: Fri, 23 Feb 2024 19:29:06 +0300
In-reply-to: <20240223113300.GS31348@pendragon.ideasonboard.com>
Message-ID: <874jdzdsg3.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Laurent,

and thanks for the review!

On 2024-02-23 at 13:33 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> Thank you for the patch.
>
> On Mon, Dec 18, 2023 at 08:40:36PM +0300, Mikhail Rudenko wrote:
>> Pixel array dimensions and default crop size do not belong to the
>> ov4689_mode structure, since they are mode independent. Make them
>> defines instead.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 29 +++++++++++++----------------
>>  1 file changed, 13 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index b43fb1d7b15f..475508559e3e 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -70,6 +70,11 @@
>>  #define OV4689_LANES			4
>>  #define OV4689_XVCLK_FREQ		24000000
>>
>> +#define OV4689_PIXEL_ARRAY_WIDTH	2720
>> +#define OV4689_PIXEL_ARRAY_HEIGHT	1536
>> +#define OV4689_DUMMY_ROWS		8
>> +#define OV4689_DUMMY_COLUMNS		16
>
> Adding a comment here to indicate that there are dummy columns in each
> side would be useful:
>
> #define OV4689_DUMMY_ROWS		8	/* 8 dummy rows on each side */
> #define OV4689_DUMMY_COLUMNS		16	/* 16 dummy columns on each side */

Will add the comments in v3.

>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>> +
>>  static const char *const ov4689_supply_names[] = {
>>  	"avdd", /* Analog power */
>>  	"dovdd", /* Digital I/O power */
>> @@ -90,10 +95,6 @@ struct ov4689_mode {
>>  	u32 vts_def;
>>  	u32 exp_def;
>>  	u32 pixel_rate;
>> -	u32 sensor_width;
>> -	u32 sensor_height;
>> -	u32 crop_top;
>> -	u32 crop_left;
>>  	const struct cci_reg_sequence *reg_list;
>>  	unsigned int num_regs;
>>  };
>> @@ -254,10 +255,6 @@ static const struct ov4689_mode supported_modes[] = {
>>  		.id = OV4689_MODE_2688_1520,
>>  		.width = 2688,
>>  		.height = 1520,
>> -		.sensor_width = 2720,
>> -		.sensor_height = 1536,
>> -		.crop_top = 8,
>> -		.crop_left = 16,
>>  		.exp_def = 1536,
>>  		.hts_def = 10296,
>>  		.hts_min = 3432,
>> @@ -385,8 +382,6 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>>  				struct v4l2_subdev_state *state,
>>  				struct v4l2_subdev_selection *sel)
>>  {
>> -	const struct ov4689_mode *mode = to_ov4689(sd)->cur_mode;
>> -
>>  	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE)
>>  		return -EINVAL;
>>
>> @@ -394,15 +389,17 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>>  	case V4L2_SEL_TGT_CROP_BOUNDS:
>>  		sel->r.top = 0;
>>  		sel->r.left = 0;
>> -		sel->r.width = mode->sensor_width;
>> -		sel->r.height = mode->sensor_height;
>> +		sel->r.width = OV4689_PIXEL_ARRAY_WIDTH;
>> +		sel->r.height = OV4689_PIXEL_ARRAY_HEIGHT;
>>  		return 0;
>>  	case V4L2_SEL_TGT_CROP:
>>  	case V4L2_SEL_TGT_CROP_DEFAULT:
>> -		sel->r.top = mode->crop_top;
>> -		sel->r.left = mode->crop_left;
>> -		sel->r.width = mode->width;
>> -		sel->r.height = mode->height;
>> +		sel->r.top = OV4689_DUMMY_ROWS;
>> +		sel->r.left = OV4689_DUMMY_COLUMNS;
>> +		sel->r.width =
>> +			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_COLUMNS;
>> +		sel->r.height =
>> +			OV4689_PIXEL_ARRAY_WIDTH - 2 * OV4689_DUMMY_ROWS;
>>  		return 0;
>>  	}
>>


--
Best regards,
Mikhail Rudenko

