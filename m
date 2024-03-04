Return-Path: <linux-kernel+bounces-91327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD95870F01
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0FD1F21161
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4DB7B3E6;
	Mon,  4 Mar 2024 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQZOEUvR"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC11EB5A;
	Mon,  4 Mar 2024 21:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588997; cv=none; b=M10qHGkWSkTGZ8jKNnhy7mPVuHh4Mk1zVYlXs3jO3dwBhESdHPKd54m05hterWF7OoWZMG+4TTE/92cibLFipqR415XGinK9LFlmvjj9Qn6qO4jRtFldWu7EVBFBE8zfE+kcxxa27RZBAKHBD10UuR1GImrrAzjNnu1aLx+y9hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588997; c=relaxed/simple;
	bh=N/qoAzsb/7sLnf5j1MSPu0te/TnAblCIa6qjqGuyO9E=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=cSI+6HkCE6fEv57nF69/XXpdPDKibj7vTuDGv8hSbwaVYD7r6Yw59IwCxlBE4xPlu7oy2FBoAvAe6wCklv4L1lTeq0eRUtT8xHR8BNOO3JcRxvQUqUVzgIRaCiLFgblKz2rTRVjsDKXA0fQToSoYCjpppJKGPK2Tna7CO8L6wBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQZOEUvR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so50691761fa.2;
        Mon, 04 Mar 2024 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709588993; x=1710193793; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=r1fd5JWBu5m9ExqQ1tPo3RjEN00HnWcydYH7DAOUA/I=;
        b=UQZOEUvRsO4y1Vj73CCaYdPqL8/0/INd/t+SuZeXM2GDo/6TTdSuR/Png8YsdBunY6
         +rVmlvOBtSc4CibE+Nqpsr/ZgXzejGCL6hfB5MmXosBbZJG/XZhw5/cK0V6yL2iN3e8h
         OaZoISQ7xaCybhbA8Lm5tcK5e9H4KJ87JHzGygmVjc9fYOSTols1AFvMy6e1pbLKExTc
         jx3LTwPnSJ+jWzb7DjCAIk8ydKABCM0zp2MhAth/gvIUOX3jYbGvOsrlcWOZx23avc3V
         EYbQ+BjpbaYbKf/N8ny2ngPiVVbfhNDO5gxGdlPqmCiN+I4NlIQJV4CgNjnwI3I9SCPK
         KknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709588993; x=1710193793;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1fd5JWBu5m9ExqQ1tPo3RjEN00HnWcydYH7DAOUA/I=;
        b=tRm23T4pybooKzusMMRoxD4juEdkS7Whqhs+YzrXbo/94uoVicb+MyiX18KpmS4yC9
         LQjSqDYsIjA4Sq5akwzUG+1FDtIFcS2do5eRreN8FkApJmOGAyTjQ17D6Z69mwdDrkXl
         mEdJSGoivfPW4QmtWJCrvagrJIlh/l9DKV0iNVLz0HY3AaPPmlBTx27P2v5+rE6A93bW
         PntzXkyaJaNrSxCQ9RilnEhUqs17ebyprsQ9Lq/S41gsxYmCA82nALZbld2exOU2fY4E
         XF0UhbbWEDefdH4JhiWTgDjS83RzwbVswK3q6I1B7Scb0cpJpBLKzO6yRekKsVHu+8vB
         C5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+MOnS0zNOQ8LargZYmepjlCHcOV7hAb5JEaLCjdIRUUIICF37sSdXnd/fgc8mIgqbOnYWuh/JTB4/qOjLBvOAF2n+E8YqbQOACm+i
X-Gm-Message-State: AOJu0YyZt8Ok0s05fBUW1xR/r3/5eyT9rlIDYKZBXrmVANlm7VVRjBum
	4SgxE56C0p2sVgjDw+4DeXZH5nNcMJoqQseVrkcukDblUr4nMxJj
X-Google-Smtp-Source: AGHT+IE0Pk2KzSaDGL17XDUQZmFBaTN4nO30WcTvLXVgfEjNbKLW6/KcodVPa/0E6urqu3Io6JSWCA==
X-Received: by 2002:a05:651c:b06:b0:2d2:9b43:8d48 with SMTP id b6-20020a05651c0b0600b002d29b438d48mr88296ljr.39.1709588993145;
        Mon, 04 Mar 2024 13:49:53 -0800 (PST)
Received: from razdolb (95-24-155-202.broadband.corbina.ru. [95.24.155.202])
        by smtp.gmail.com with ESMTPSA id r20-20020a2e9954000000b002d0c639e0cesm1902850ljj.6.2024.03.04.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 13:49:52 -0800 (PST)
References: <20240229165333.227484-1-mike.rudenko@gmail.com>
 <20240229165333.227484-20-mike.rudenko@gmail.com>
 <20240304213103.GA3239@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, Tommaso
 Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v3 19/20] media: i2c: ov4689: Refactor ov4689_s_stream
Date: Tue, 05 Mar 2024 00:48:14 +0300
In-reply-to: <20240304213103.GA3239@pendragon.ideasonboard.com>
Message-ID: <87wmqhfz0f.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Laurent,

and thanks for the review.

On 2024-03-04 at 23:31 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> Thank you for the patch.
>
> On Thu, Feb 29, 2024 at 07:53:32PM +0300, Mikhail Rudenko wrote:
>> Split ov4689_s_stream into __ov4689_stream_on and __ov4689_stream_off
>> functions. Also remove repetitive pm_runtime_put calls and call
>> pm_runtime_put once at the end of the __ov4689_stream_off function if
>> any error occurred.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 100 ++++++++++++++++++++-----------------
>>  1 file changed, 53 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 2496067b90a0..5cea9b5ba201 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -537,61 +537,67 @@ static int ov4689_setup_blc_anchors(struct ov4689 *ov4689,
>>  	return ret;
>>  }
>>
>> +static int __ov4689_stream_on(struct ov4689 *ov4689,
>
> No need for the __ prefix. Same for __ov4689_stream_off().

Will remove the prefix in v4.

>> +			      struct v4l2_subdev_state *sd_state)
>> +{
>> +	int ret;
>> +
>> +	ret = pm_runtime_resume_and_get(ov4689->dev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = cci_multi_reg_write(ov4689->regmap, ov4689_common_regs,
>> +				  ARRAY_SIZE(ov4689_common_regs), NULL);
>> +	if (ret)
>> +		goto cleanup_pm;
>> +
>> +	ret = ov4689_setup_timings(ov4689, sd_state);
>> +	if (ret)
>> +		goto cleanup_pm;
>> +
>> +	ret = ov4689_setup_blc_anchors(ov4689, sd_state);
>> +	if (ret)
>> +		goto cleanup_pm;
>> +
>> +	ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>> +	if (ret)
>> +		goto cleanup_pm;
>> +
>> +	ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>> +			OV4689_MODE_STREAMING, NULL);
>> +	if (ret)
>> +		goto cleanup_pm;
>> +
>> +	return 0;
>> +
>> + cleanup_pm:
>
> No space before the label. I would also name it just "error".

Thanks for the suggestion, will do so in v4.

> With those small changes,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>> +	pm_runtime_put(ov4689->dev);
>> +	return ret;
>> +}
>> +
>> +static int __ov4689_stream_off(struct ov4689 *ov4689)
>> +{
>> +	cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE, OV4689_MODE_SW_STANDBY,
>> +		  NULL);
>> +	pm_runtime_mark_last_busy(ov4689->dev);
>> +	pm_runtime_put_autosuspend(ov4689->dev);
>> +
>> +	return 0;
>> +}
>> +
>>  static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>>  {
>>  	struct ov4689 *ov4689 = to_ov4689(sd);
>>  	struct v4l2_subdev_state *sd_state;
>> -	struct device *dev = ov4689->dev;
>> -	int ret = 0;
>> +	int ret;
>>
>>  	sd_state = v4l2_subdev_lock_and_get_active_state(&ov4689->subdev);
>>
>> -	if (on) {
>> -		ret = pm_runtime_resume_and_get(dev);
>> -		if (ret < 0)
>> -			goto unlock_and_return;
>> -
>> -		ret = cci_multi_reg_write(ov4689->regmap,
>> -					  ov4689_common_regs,
>> -					  ARRAY_SIZE(ov4689_common_regs),
>> -					  NULL);
>> -		if (ret) {
>> -			pm_runtime_put(dev);
>> -			goto unlock_and_return;
>> -		}
>> -
>> -		ret = ov4689_setup_timings(ov4689, sd_state);
>> -		if (ret) {
>> -			pm_runtime_put(dev);
>> -			goto unlock_and_return;
>> -		}
>> -
>> -		ret = ov4689_setup_blc_anchors(ov4689, sd_state);
>> -		if (ret) {
>> -			pm_runtime_put(dev);
>> -			goto unlock_and_return;
>> -		}
>> -
>> -		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>> -		if (ret) {
>> -			pm_runtime_put(dev);
>> -			goto unlock_and_return;
>> -		}
>> -
>> -		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>> -				OV4689_MODE_STREAMING, NULL);
>> -		if (ret) {
>> -			pm_runtime_put(dev);
>> -			goto unlock_and_return;
>> -		}
>> -	} else {
>> -		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>> -			  OV4689_MODE_SW_STANDBY, NULL);
>> -		pm_runtime_mark_last_busy(dev);
>> -		pm_runtime_put_autosuspend(dev);
>> -	}
>> +	if (on)
>> +		ret = __ov4689_stream_on(ov4689, sd_state);
>> +	else
>> +		ret = __ov4689_stream_off(ov4689);
>>
>> -unlock_and_return:
>>  	v4l2_subdev_unlock_state(sd_state);
>>
>>  	return ret;


--
Best regards,
Mikhail Rudenko

