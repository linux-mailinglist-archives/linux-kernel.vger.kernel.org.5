Return-Path: <linux-kernel+bounces-78778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58E8618B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585111F2606D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7104128815;
	Fri, 23 Feb 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKXPUlE3"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2612BE99;
	Fri, 23 Feb 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707753; cv=none; b=b8luWooyB6ocHEYnYV7tb2NDn30gfWreNl5/b8jM+k9mSsMUePug6rS12B4yTQ3PTxckKXsesFwcRzNTjieRfOxoOhyc959dOhaCKHqFpX08jlB27BqhQWd5J7yvjnSEJloYQoFgwd3UhXSO4ZEjfcT70fd9djXfXOyYIWZdz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707753; c=relaxed/simple;
	bh=jl1GuNpqHEKFR/WgkQ6rkBKyXSKl8Z+5PfbgGCSiT24=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=lDb451Q5SdCiKxrzMpC5814Hkt9kg75V2UhZXCSbISXY5EB5n+kFShIi8fJfIA8qmB1ahO+3sFro8bc/FzOUYVUdeU7aNvnz76AVLusrBpMdQzNOKgIU7E1vTLQyrun7NZyi7LsSAlzV1sUAlI7fciFlNMlxe1/+GzN4ewDZEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKXPUlE3; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512ab55fde6so795706e87.2;
        Fri, 23 Feb 2024 09:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707750; x=1709312550; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=UPzFnuWfSpaL+FRaaXCLba4SMZ6+eA3CGRCUP9VUKIk=;
        b=dKXPUlE31BiubcZo33pQPt1XfxjLAudroSKyycTpwODe4yKi8hruH0GpzHXtZ/BBuu
         3xdKw/Ibm8BLx+l/+yKJGtPU/BmVeyA8yeX6CEZQYsjmH7fJLZTjB5j3Y4DoHc0t0a02
         6Dt57oC+OiOnofx41AeNTONe206mvJ0ddAn7db8dR8qBSllG8DMprf4rkXIsJtHePSts
         QLo3bzLXJzU2b4Q12PjIpLwzzAHJCChUGcewL6KvS5TSlofqJfOl26+hk2NWYVpOik+I
         GFqvYID1+jBYHu3Pe6MS5OGxQqh07ZN65578BHRqMi06/i1fEy+8t/vETvzAJwAIE2kV
         200g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707750; x=1709312550;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPzFnuWfSpaL+FRaaXCLba4SMZ6+eA3CGRCUP9VUKIk=;
        b=jzm8Uv6yeDcvufozsfeIho5n/zY+p+ZK8nN71o88SJY6FhCeeGWnvgIKoSN2EdAUEC
         jLcXbFKEZVIdWIty0VTSES73KV+OtE3tTx8xSn2JLzTLD578n3nEaM7Vm2Uv0p/FruZM
         by29EjLB3XotfxDAwz8PfPZV5UdNOYnfBKp3koHJFNfiusUmZGNtt4htT0g60Q8gTiLX
         ecGtaO7DS4q117gKyCM9hxssXKGnUkPRxa7+XHaFva8DF/+T8ZuNReRPNogc6TJwf38H
         Fgrac9GPVwd8/DZOOLOw6Y/yxD6Z0wWgWBNle6Dlvq7oL4aW2O/Luuaq2GZ41BRyObDA
         U3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXfO3m8eBnLsiKVSi9rGJFxWz34wEXzKDQ5fIiHORr46XPPlVrh9BBaLgHie+BP2udtmvtvEsDewWfq8/zd5SB+HrtOS8vl00IGA9FB
X-Gm-Message-State: AOJu0Yx3Tm+usKSDzhkXdBHn6mv2Hgr4WboKteqdfmoWvHrOaBz4CJl/
	DFrvEpQjyIV7Jpp3N24lanxsr9s3ABqrn9qah1+Cus6oUCKb9DsE
X-Google-Smtp-Source: AGHT+IHfMb7+gH0fnH/kOJXpV+LL3w6u7P3dyZ1UvQMAwJb5gbOj1F3I/QQvRtLPu8H0kOZQonJoRQ==
X-Received: by 2002:a05:6512:3da9:b0:511:5f38:76e with SMTP id k41-20020a0565123da900b005115f38076emr364248lfv.1.1708707749966;
        Fri, 23 Feb 2024 09:02:29 -0800 (PST)
Received: from razdolb ([37.1.50.248])
        by smtp.gmail.com with ESMTPSA id b22-20020a0565120b9600b00512aaf3f26bsm2268053lfv.298.2024.02.23.09.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:02:29 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-8-mike.rudenko@gmail.com>
 <20240223112839.GO31348@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, Tommaso
 Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 07/20] media: i2c: ov4689: Use sub-device active state
Date: Fri, 23 Feb 2024 19:26:17 +0300
In-reply-to: <20240223112839.GO31348@pendragon.ideasonboard.com>
Message-ID: <878r3bdsgr.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Laurent,

and thanks for the review!

On 2024-02-23 at 13:28 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> Thank you for the patch.
>
> On Mon, Dec 18, 2023 at 08:40:28PM +0300, Mikhail Rudenko wrote:
>> Use sub-device active state. Employ control handler lock to
>> synchronize access to the active state and s_stream.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 75 ++++++++++++++++----------------------
>>  1 file changed, 32 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index d42f5d1a1ba8..501901aad4ae 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -86,7 +86,6 @@ struct ov4689 {
>>
>>  	u32 clock_rate;
>>
>> -	struct mutex mutex; /* lock to protect ctrls and cur_mode */
>>  	struct v4l2_ctrl_handler ctrl_handler;
>>  	struct v4l2_ctrl *exposure;
>>
>> @@ -319,19 +318,6 @@ static int ov4689_set_fmt(struct v4l2_subdev *sd,
>>  	return 0;
>>  }
>>
>> -static int ov4689_get_fmt(struct v4l2_subdev *sd,
>> -			  struct v4l2_subdev_state *sd_state,
>> -			  struct v4l2_subdev_format *fmt)
>> -{
>> -	struct v4l2_mbus_framefmt *mbus_fmt = &fmt->format;
>> -	struct ov4689 *ov4689 = to_ov4689(sd);
>> -
>> -	/* only one mode supported for now */
>> -	ov4689_fill_fmt(ov4689->cur_mode, mbus_fmt);
>> -
>> -	return 0;
>> -}
>> -
>>  static int ov4689_enum_mbus_code(struct v4l2_subdev *sd,
>>  				 struct v4l2_subdev_state *sd_state,
>>  				 struct v4l2_subdev_mbus_code_enum *code)
>> @@ -405,10 +391,11 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>>  static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>>  {
>>  	struct ov4689 *ov4689 = to_ov4689(sd);
>> +	struct v4l2_subdev_state *sd_state;
>>  	struct device *dev = ov4689->dev;
>>  	int ret = 0;
>>
>> -	mutex_lock(&ov4689->mutex);
>> +	sd_state = v4l2_subdev_lock_and_get_active_state(&ov4689->subdev);
>>
>>  	if (on) {
>>  		ret = pm_runtime_resume_and_get(dev);
>> @@ -443,7 +430,7 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>>  	}
>>
>>  unlock_and_return:
>> -	mutex_unlock(&ov4689->mutex);
>> +	v4l2_subdev_unlock_state(sd_state);
>>
>>  	return ret;
>>  }
>> @@ -506,18 +493,13 @@ static int __maybe_unused ov4689_power_off(struct device *dev)
>>  	return 0;
>>  }
>>
>> -static int ov4689_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
>> +static int ov4689_init_state(struct v4l2_subdev *sd,
>> +			     struct v4l2_subdev_state *sd_state)
>>  {
>> -	struct ov4689 *ov4689 = to_ov4689(sd);
>> -	struct v4l2_mbus_framefmt *try_fmt;
>> -
>> -	mutex_lock(&ov4689->mutex);
>> -
>> -	try_fmt = v4l2_subdev_state_get_format(fh->state, 0);
>> -	/* Initialize try_fmt */
>> -	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], try_fmt);
>> +	struct v4l2_mbus_framefmt *fmt =
>> +		v4l2_subdev_state_get_format(sd_state, 0);
>>
>> -	mutex_unlock(&ov4689->mutex);
>> +	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], fmt);
>>
>>  	return 0;
>>  }
>> @@ -526,10 +508,6 @@ static const struct dev_pm_ops ov4689_pm_ops = {
>>  	SET_RUNTIME_PM_OPS(ov4689_power_off, ov4689_power_on, NULL)
>>  };
>>
>> -static const struct v4l2_subdev_internal_ops ov4689_internal_ops = {
>> -	.open = ov4689_open,
>> -};
>> -
>>  static const struct v4l2_subdev_video_ops ov4689_video_ops = {
>>  	.s_stream = ov4689_s_stream,
>>  };
>> @@ -537,11 +515,15 @@ static const struct v4l2_subdev_video_ops ov4689_video_ops = {
>>  static const struct v4l2_subdev_pad_ops ov4689_pad_ops = {
>>  	.enum_mbus_code = ov4689_enum_mbus_code,
>>  	.enum_frame_size = ov4689_enum_frame_sizes,
>> -	.get_fmt = ov4689_get_fmt,
>> +	.get_fmt = v4l2_subdev_get_fmt,
>>  	.set_fmt = ov4689_set_fmt,
>>  	.get_selection = ov4689_get_selection,
>>  };
>>
>> +static const struct v4l2_subdev_internal_ops ov4689_internal_ops = {
>> +	.init_state = ov4689_init_state,
>> +};
>> +
>>  static const struct v4l2_subdev_ops ov4689_subdev_ops = {
>>  	.video = &ov4689_video_ops,
>>  	.pad = &ov4689_pad_ops,
>> @@ -648,7 +630,6 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>  	ret = v4l2_ctrl_handler_init(handler, 10);
>>  	if (ret)
>>  		return ret;
>> -	handler->lock = &ov4689->mutex;
>>
>>  	ctrl = v4l2_ctrl_new_int_menu(handler, NULL, V4L2_CID_LINK_FREQ, 0, 0,
>>  				      link_freq_menu_items);
>> @@ -861,13 +842,15 @@ static int ov4689_probe(struct i2c_client *client)
>>  		return dev_err_probe(dev, ret,
>>  				     "Failed to get power regulators\n");
>>
>> -	mutex_init(&ov4689->mutex);
>> -
>>  	sd = &ov4689->subdev;
>>  	v4l2_i2c_subdev_init(sd, client, &ov4689_subdev_ops);
>> +	sd->internal_ops = &ov4689_internal_ops;
>> +
>>  	ret = ov4689_initialize_controls(ov4689);
>> -	if (ret)
>> -		goto err_destroy_mutex;
>> +	if (ret) {
>> +		dev_err(dev, "Failed to initialize controls\n");
>> +		return ret;
>> +	}
>>
>>  	ret = ov4689_power_on(dev);
>>  	if (ret)
>> @@ -877,19 +860,26 @@ static int ov4689_probe(struct i2c_client *client)
>>  	if (ret)
>>  		goto err_power_off;
>>
>> -	sd->internal_ops = &ov4689_internal_ops;
>>  	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
>
> I would move this line above, just before calling
> ov4689_initialize_controls(), to group all subdev initialization code.

Will do it in v3.

>> +	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
>>
>>  	ov4689->pad.flags = MEDIA_PAD_FL_SOURCE;
>> -	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
>>  	ret = media_entity_pads_init(&sd->entity, 1, &ov4689->pad);
>>  	if (ret < 0)
>>  		goto err_power_off;
>>
>> +	sd->state_lock = ov4689->ctrl_handler.lock;
>> +	ret = v4l2_subdev_init_finalize(sd);
>> +
>
> No need for a blank line.
>

Will remove it in v3.

> With these small changes,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>> +	if (ret) {
>> +		dev_err(dev, "Could not register v4l2 device\n");
>> +		goto err_clean_entity;
>> +	}
>> +
>>  	ret = v4l2_async_register_subdev_sensor(sd);
>>  	if (ret) {
>>  		dev_err(dev, "v4l2 async register subdev failed\n");
>> -		goto err_clean_entity;
>> +		goto err_clean_subdev;
>>  	}
>>
>>  	pm_runtime_set_active(dev);
>> @@ -898,14 +888,14 @@ static int ov4689_probe(struct i2c_client *client)
>>
>>  	return 0;
>>
>> +err_clean_subdev:
>> +	v4l2_subdev_cleanup(sd);
>>  err_clean_entity:
>>  	media_entity_cleanup(&sd->entity);
>>  err_power_off:
>>  	ov4689_power_off(dev);
>>  err_free_handler:
>>  	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
>> -err_destroy_mutex:
>> -	mutex_destroy(&ov4689->mutex);
>>
>>  	return ret;
>>  }
>> @@ -917,9 +907,8 @@ static void ov4689_remove(struct i2c_client *client)
>>
>>  	v4l2_async_unregister_subdev(sd);
>>  	media_entity_cleanup(&sd->entity);
>> -
>> +	v4l2_subdev_cleanup(sd);
>>  	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
>> -	mutex_destroy(&ov4689->mutex);
>>
>>  	pm_runtime_disable(&client->dev);
>>  	if (!pm_runtime_status_suspended(&client->dev))


--
Best regards,
Mikhail Rudenko

