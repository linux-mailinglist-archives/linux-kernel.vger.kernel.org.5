Return-Path: <linux-kernel+bounces-19735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E3682721A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF91F22EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448B54778B;
	Mon,  8 Jan 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0zl1nHT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199D4778E;
	Mon,  8 Jan 2024 15:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso1748052e87.2;
        Mon, 08 Jan 2024 07:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704726353; x=1705331153; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=DAoA3tv/wdP6ptUjj++Ti6uTHwdnk8j5ZELOrqboXww=;
        b=S0zl1nHToFAj8t5NIzVjaIgYBKq2aG0631imsTs8qC6EVSK8U11GEDTiql9i1o0Q9N
         e4npU/XESgff6CVhntAOLqI9+kGufpbSd1siU7QnFZ9AG9P+7gHSVxNUdYAKAH0MW0Lr
         vIdnlNym4cjMCW0MTKr7P0rrmnTAAWhhKZWziJlkYCCIHD3v/sd584G/NcpQuCtnGUPo
         pfDG+FuZR3aMGjRDLKW79O+JVPLYZvuYXXZVktYntp+lQvGrytmUE/c9w+hABD6T+qo4
         740qMDzwzJWk+cu7UGY1QKPN6eZGoyAeyuGdl90N+YL3s9RB0PdbUp8Ksj23dMrZJx0s
         LSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704726353; x=1705331153;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAoA3tv/wdP6ptUjj++Ti6uTHwdnk8j5ZELOrqboXww=;
        b=eOEdBj2CSyVTLyacIxV58jHp5nMs9YV2iK3v41FQ5bQax1IZXhFqslrYFX76yTNcF+
         62xY+dkYKtbBh4SZ0lvvqd6lXsBKd51b3m8NHTKc/Kii3GvfC35K+GbykiGkVhT0B58P
         3z+8oEILy6mVyCOvyiyQfW1W0EKZHHhl+GzaMNbg4Psx/6BORcoG5OKGoMU9gsj9WsEX
         11sIZRdzXbB2KVP/8+JP3xR1DUOCqz07r0KcUV18OEXzMBF4n0d/KG+JZv8YcAjv4TSH
         0Lo91F3w3UybMr8Kw3uVzgla61Au+kSN7GdSdH4lsgBkHo9lDLz8ffVmg1qbBSNp2HOt
         hiJQ==
X-Gm-Message-State: AOJu0YyXCQGIP8fIK+NfLxjGirnTdAXmLj84yGunafwS4frtxjQ5fE25
	OSyIlbi1dsWXdEkx4V4+5AE=
X-Google-Smtp-Source: AGHT+IGksT91FgUvvTguJ4heKPRAGhrrIHQ/EfhoGlskyBbK/dZ64i0GVVagf7uObk0At5UXrAI8Gw==
X-Received: by 2002:a05:6512:2821:b0:50e:3904:4f0a with SMTP id cf33-20020a056512282100b0050e39044f0amr2123465lfb.9.1704726352616;
        Mon, 08 Jan 2024 07:05:52 -0800 (PST)
Received: from razdolb ([89.208.103.172])
        by smtp.gmail.com with ESMTPSA id t1-20020a19ad01000000b0050e798ab1b9sm1171185lfc.139.2024.01.08.07.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:05:52 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-7-mike.rudenko@gmail.com>
 <ZZvZdxqotS47XftY@valkosipuli.retiisi.eu>
User-agent: mu4e 1.10.7; emacs 29.1
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>,
 Tommaso Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 06/20] media: i2c: ov4689: Refactor ov4689_set_ctrl
Date: Mon, 08 Jan 2024 17:57:33 +0300
In-reply-to: <ZZvZdxqotS47XftY@valkosipuli.retiisi.eu>
Message-ID: <87frz750he.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



Hi Sakari,

Thanks for the review!

On 2024-01-08 at 11:16 GMT, Sakari Ailus <sakari.ailus@iki.fi> wrote:

> Hi Mikhail,
>
> On Mon, Dec 18, 2023 at 08:40:27PM +0300, Mikhail Rudenko wrote:
>> Introduce local variable for regmap within the ov4689_set_ctrl
>> function. This adjustment eliminates repetition within the function.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 3b20eba59c9c..d42f5d1a1ba8 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -580,6 +580,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  {
>>  	struct ov4689 *ov4689 =
>>  		container_of(ctrl->handler, struct ov4689, ctrl_handler);
>> +	struct regmap *regmap = ov4689->regmap;
>>  	struct device *dev = ov4689->dev;
>>  	int sensor_gain;
>>  	s64 max_expo;
>> @@ -603,16 +604,15 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  	switch (ctrl->id) {
>>  	case V4L2_CID_EXPOSURE:
>>  		/* 4 least significant bits of exposure are fractional part */
>> -		ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
>> -				ctrl->val << 4, NULL);
>> +		cci_write(regmap, OV4689_REG_EXPOSURE, ctrl->val << 4, &ret);
>
> If you do this, ret needs to have been initialised to 0, but it isn't.
>
> Same for the changes below.

Nice catch, will fix it in v3.

>>  		break;
>>  	case V4L2_CID_ANALOGUE_GAIN:
>>  		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
>> -		cci_write(ov4689->regmap, OV4689_REG_GAIN, sensor_gain, &ret);
>> +		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
>>  		break;
>>  	case V4L2_CID_VBLANK:
>> -		ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
>> -				ctrl->val + ov4689->cur_mode->height, NULL);
>> +		cci_write(regmap, OV4689_REG_VTS,
>> +			  ctrl->val + ov4689->cur_mode->height, &ret);
>>  		break;
>>  	case V4L2_CID_TEST_PATTERN:
>>  		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
>> @@ -625,7 +625,6 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  	}
>>
>>  	pm_runtime_put(dev);
>> -
>
> I thought it was nice.

Will get the blank line back in v3, especially since "Use runtime
autosuspend" patch (09/20) restores it.

>>  	return ret;
>>  }
>>


--
Best regards,
Mikhail Rudenko

