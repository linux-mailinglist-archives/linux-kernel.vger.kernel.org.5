Return-Path: <linux-kernel+bounces-78770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF8586189B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A0A1F2553D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00512AAF5;
	Fri, 23 Feb 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJTgMIab"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176BF1292C6;
	Fri, 23 Feb 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708707632; cv=none; b=k4BfV0EV8sglukBWGrsCRpUzcFnm8GrashRVBPAngs+XEilGhLDqSFziv2BXic+t18TtWe4BMaCU9nEXzGxRb0u8G9l4N1Ab1AzlW+6/o9E9x7HF2mjH8H0CttDq2cx7NFxHPzSThLN7vQX/2tkQUR2yIJlnfQk3wzHAfA6wJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708707632; c=relaxed/simple;
	bh=DP07s/Kd4y5Nre6qJCsFlczCNJviiMGXk8qxZy4ibMM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=PecNZfdT5iyPfV0UeCHipB+aAiQB1/XFutddR7D0rrgFhBqvuKGTikR1/CqAWImVRtuMR0GFVOS/AR/QtoPHkKZO6ex65Fa5+Xn/subwV8lA1aO4f8EVvpS/ESNiPvq+r1kqdO0Bg1+tQ0AXi9vfftLtPsXvz+eakzcURkh83hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJTgMIab; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512ab55fde6so792491e87.2;
        Fri, 23 Feb 2024 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708707629; x=1709312429; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=KdZCvZnQvtvoXFrprhSZehsA4lrftV7UQsxYXFE5r3k=;
        b=SJTgMIabpAlnz4uH50iUovUdHjBJvSj8Usj1UcvUedXchcdDU1fk7yxDI0dGpVjZ5a
         3h6oJ3At9Jqru45+g/klxbJIN4kkktFJaOkyV+PzF4uSTW1//haeEHllKEYkMrOI88YE
         ADBAQawhbtfEM5/9Ms+HdPztL2yL2YjnVFG/jKHKwuf21Ry9tit4Pu9O0Y2e2jQsDSjh
         XedHzrniNwr2rifZGb0N9Qwf+YUXvA31Wfc7MdaOH1Bv+j3KCPZCvNBEe8Oiie1ybWaL
         hY8ZXndFlLfUFxNEubYFC3yg92K+t91goqnQD3vYc9FQq/iqH5/5eBqlamFM5HrAtF0f
         fPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708707629; x=1709312429;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdZCvZnQvtvoXFrprhSZehsA4lrftV7UQsxYXFE5r3k=;
        b=IghkoEMCElNZGVIi7qPuLj4/cThjo67Qd3y8q0rOF3tKKbApB9FkNVoZKlQT+IO7jp
         CTVwijk5GsQLhtpm/ULfWy34Xg1+js+Igc2SOB6YxyNp2TfEPMrod775CL+fiGoqbY0u
         l1YvPT9LmLOSw54dybulp675DsFs8uj9zc3VjVBokr/cGlWBSuvT51gAABdoP5DaqmRH
         X9yf+VSoE5pYJPA057zHTwD8b3k4rJ3QuBj9JuKRLlTD8VLSlqmb2DkDe7IW4cCMgui+
         4YBco/EEz7E0YBpztJqit2QhXNpFgYZaYNwiGSYRbIhB5rjllTAyx7ZQgAeo4qSeV1ev
         F8zw==
X-Forwarded-Encrypted: i=1; AJvYcCUiz8dOE3Yv+wzCpXnBWUDFhZ0pas23/nkufNvqs8AWsFKQR64b9FrurAno/4RKuf5unvHFMw9kv1UAIZpGcoGFwVcIUmpgjWxbAHPFurPfcFnspgYzNJqBF9kAl7cMpl3NhenSkPHJJvo=
X-Gm-Message-State: AOJu0Yyc3Q/JUZt00oiXltx7rrBEaebLFBt8caHlpcsG14DY2ULnALaD
	9BwqFazpck8DRwm4dKVzzCip/d/Ph821r4OgvouZRBvpFUeTVuGT
X-Google-Smtp-Source: AGHT+IHsOc5/Zrb/rPJJ3eV0TA68yL6/1WBUbQzJaTU3sPB0EfY7x7ikiHptfqS9ZrAkw8Swu2eBJg==
X-Received: by 2002:a19:f710:0:b0:512:bd51:a0ea with SMTP id z16-20020a19f710000000b00512bd51a0eamr234006lfe.9.1708707628879;
        Fri, 23 Feb 2024 09:00:28 -0800 (PST)
Received: from razdolb ([37.1.50.248])
        by smtp.gmail.com with ESMTPSA id j9-20020a19f509000000b00512ebe08d7bsm173052lfb.290.2024.02.23.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:00:28 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-10-mike.rudenko@gmail.com>
 <ZZvaDyGSMrjb6e75@valkosipuli.retiisi.eu> <878r4z4ysb.fsf@gmail.com>
 <ZdhVAEElqzmJAynB@kekkonen.localdomain>
User-agent: mu4e 1.10.8; emacs 29.2.50
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Jacopo Mondi <jacopo@jmondi.org>,
 Tommaso Merciai <tomm.merciai@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Subject: Re: [PATCH v2 09/20] media: i2c: ov4689: Use runtime PM autosuspend
Date: Fri, 23 Feb 2024 18:18:12 +0300
In-reply-to: <ZdhVAEElqzmJAynB@kekkonen.localdomain>
Message-ID: <87le7bdsk4.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Sakari,

and thanks for the review!

On 2024-02-23 at 08:19 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hi Mikhail,
>
> On Mon, Jan 08, 2024 at 06:06:52PM +0300, Mikhail Rudenko wrote:
>> Hi Sakari,
>>
>> Thanks for the review!
>>
>> On 2024-01-08 at 11:18 GMT, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>>
>> > Hi Mikhail,
>> >
>> > On Mon, Dec 18, 2023 at 08:40:30PM +0300, Mikhail Rudenko wrote:
>> >> Use runtime PM autosuspend to avoid powering off the sensor during
>> >> fast stop-reconfigure-restart cycles.
>> >>
>> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> >> ---
>> >>  drivers/media/i2c/ov4689.c | 22 +++++++++++++++-------
>> >>  1 file changed, 15 insertions(+), 7 deletions(-)
>> >>
>> >> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> >> index 5300e621ff90..64cc6d9e48cc 100644
>> >> --- a/drivers/media/i2c/ov4689.c
>> >> +++ b/drivers/media/i2c/ov4689.c
>> >> @@ -407,26 +407,27 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>> >>  					  ov4689->cur_mode->num_regs,
>> >>  					  NULL);
>> >>  		if (ret) {
>> >> -			pm_runtime_put(dev);
>> >> +			pm_runtime_put_sync(dev);
>> >
>> > Why are you switching to pm_runtime_put_sync() here? That isn't covered by
>> > the commit message (nor I think should be done).
>>
>> PM autosuspend conversion was suggested earlier by Laurent in his review
>> of this series [1], and he adviced looking at how it was done for the
>> imx290 driver. I followed along the lines of the corresponding patch
>> [2].
>
> There's no need to use the _sync() variant here. And at least it wouldn't
> be related to autosuspend, were you to switch to that.

Ok, will use pm_runtime_put in v3. Or do you suggest dropping this patch
altogether? Laurent?

>>
>> >>  			goto unlock_and_return;
>> >>  		}
>> >>
>> >>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>> >>  		if (ret) {
>> >> -			pm_runtime_put(dev);
>> >> +			pm_runtime_put_sync(dev);
>> >>  			goto unlock_and_return;
>> >>  		}
>> >>
>> >>  		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>> >>  				OV4689_MODE_STREAMING, NULL);
>> >>  		if (ret) {
>> >> -			pm_runtime_put(dev);
>> >> +			pm_runtime_put_sync(dev);
>> >>  			goto unlock_and_return;
>> >>  		}
>> >>  	} else {
>> >>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>> >>  			  OV4689_MODE_SW_STANDBY, NULL);
>> >> -		pm_runtime_put(dev);
>> >> +		pm_runtime_mark_last_busy(dev);
>> >> +		pm_runtime_put_autosuspend(dev);
>> >>  	}
>> >>
>> >>  unlock_and_return:
>> >> @@ -606,7 +607,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>> >>  		break;
>> >>  	}
>> >>
>> >> -	pm_runtime_put(dev);
>> >> +	pm_runtime_mark_last_busy(dev);
>> >> +	pm_runtime_put_autosuspend(dev);
>> >
>> > Also note that with runtime PM autosuspend,  you have to use
>> > pm_runtime_get_if_active() instead of pm_runtime_get_if_in_use().
>>
>> Noted, will do so in v3.
>>
>> >> +
>> >>  	return ret;
>> >>  }
>> >>
>> >> @@ -877,8 +880,10 @@ static int ov4689_probe(struct i2c_client *client)
>> >>  	}
>> >>
>> >>  	pm_runtime_set_active(dev);
>> >> +	pm_runtime_get_noresume(dev);
>> >>  	pm_runtime_enable(dev);
>> >> -	pm_runtime_idle(dev);
>> >> +	pm_runtime_set_autosuspend_delay(dev, 1000);
>> >> +	pm_runtime_use_autosuspend(dev);
>> >>
>> >>  	ret = v4l2_async_register_subdev_sensor(sd);
>> >>  	if (ret) {
>> >> @@ -886,11 +891,14 @@ static int ov4689_probe(struct i2c_client *client)
>> >>  		goto err_clean_subdev_pm;
>> >>  	}
>> >>
>> >> +	pm_runtime_mark_last_busy(dev);
>> >> +	pm_runtime_put_autosuspend(dev);
>> >> +
>> >>  	return 0;
>> >>
>> >>  err_clean_subdev_pm:
>> >>  	pm_runtime_disable(dev);
>> >> -	pm_runtime_set_suspended(dev);
>> >> +	pm_runtime_put_noidle(dev);
>> >>  	v4l2_subdev_cleanup(sd);
>> >>  err_clean_entity:
>> >>  	media_entity_cleanup(&sd->entity);
>>
>> [1] https://lore.kernel.org/all/20231211181935.GG27535@pendragon.ideasonboard.com/
>> [2] https://lore.kernel.org/all/20230116144454.1012-14-laurent.pinchart@ideasonboard.com/
>>


--
Best regards,
Mikhail Rudenko

