Return-Path: <linux-kernel+bounces-19797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5B7827430
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAF31C220F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D410537FE;
	Mon,  8 Jan 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvULxm9e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB719524A0;
	Mon,  8 Jan 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso1826805e87.1;
        Mon, 08 Jan 2024 07:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704728552; x=1705333352; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=kuoLtHe+rWGX4qEJ+9p1WuBO75Jm6fA3SdoxDdYmn7U=;
        b=QvULxm9eN68dabbJcuu0rIzM/zszywhOmzatogsnVorCyRbKCbv7U02ymXE9X8kGRC
         zvsWRjK5LGkDRKmIaH6YxoPlxM7iXeP7pDP0rUvQ/RZB5RTW53oo1xkQMa00KI55p/DS
         WBcFqbFNl1xnIFdub/cQfYOpuvwArYzAj//mfGrfL9eylxV8v65D2fFHYUHDNFENjWMz
         yiq4GFdHJwbb89E1uR4O+4LQzyZvYXyxbT2deZfI5ak057BImOFyGoYPAbwUlMBqAUnk
         Y7q91Cz7VQ/AOGo0kR8iVzLyvFouKgaXJGXzieep/Ngkd72xUi3vmg1PKG1P9vv2IqGc
         llTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704728552; x=1705333352;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuoLtHe+rWGX4qEJ+9p1WuBO75Jm6fA3SdoxDdYmn7U=;
        b=R7Wi2E3byADHq67whduaUky/NdIcEdcGebzrQEEThITbaNO3jOwy0AOfeQDl8jX9TU
         x9F5iVByVBnpl5Lrn4xx6WsXZeI/9TwwH06/uJ7fmT79Dh6NpTdfobnbUSoU2R+1bvnq
         F1cOweOYQUrvQQx3613bnOlnceG8Jn2CVvcN4FaFD+6ZvewG3iPuLCw7lZMgQftfMhhX
         B+20chclkLHGcn4FSQbCcKG3dCu+16ew60xDUXBsfT+R+OYcq3VnzzMPZ59aGNfQPcqq
         UpMwEzs8NHpBISP4PNA0aynUXj5oSOsNNn2TsY5tV2IqZY3rW4Y0XqSk0vpBXJm8NB5P
         k6/w==
X-Gm-Message-State: AOJu0YznoAJBH0YbBvktDMgZ548coGe3phVqCS5ROfvjgugHy6NHS+WZ
	iCn/+bypXENR80GjsviOrt0=
X-Google-Smtp-Source: AGHT+IHH65HQEN2sQckMNrBKi3lprxVVxomjslv9Sk4Zm9mPMQIOhsMTEY5l74QMIZNdMzp7VNoJug==
X-Received: by 2002:ac2:4db5:0:b0:50e:681e:d63 with SMTP id h21-20020ac24db5000000b0050e681e0d63mr779483lfe.213.1704728551406;
        Mon, 08 Jan 2024 07:42:31 -0800 (PST)
Received: from razdolb ([89.208.103.172])
        by smtp.gmail.com with ESMTPSA id i19-20020a056512341300b0050e7c037063sm3079lfr.22.2024.01.08.07.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 07:42:31 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-10-mike.rudenko@gmail.com>
 <ZZvaDyGSMrjb6e75@valkosipuli.retiisi.eu>
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
Subject: Re: [PATCH v2 09/20] media: i2c: ov4689: Use runtime PM autosuspend
Date: Mon, 08 Jan 2024 18:06:52 +0300
In-reply-to: <ZZvaDyGSMrjb6e75@valkosipuli.retiisi.eu>
Message-ID: <878r4z4ysb.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Sakari,

Thanks for the review!

On 2024-01-08 at 11:18 GMT, Sakari Ailus <sakari.ailus@iki.fi> wrote:

> Hi Mikhail,
>
> On Mon, Dec 18, 2023 at 08:40:30PM +0300, Mikhail Rudenko wrote:
>> Use runtime PM autosuspend to avoid powering off the sensor during
>> fast stop-reconfigure-restart cycles.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 22 +++++++++++++++-------
>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 5300e621ff90..64cc6d9e48cc 100644
>> --- a/drivers/media/i2c/ov4689.c
>> +++ b/drivers/media/i2c/ov4689.c
>> @@ -407,26 +407,27 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>>  					  ov4689->cur_mode->num_regs,
>>  					  NULL);
>>  		if (ret) {
>> -			pm_runtime_put(dev);
>> +			pm_runtime_put_sync(dev);
>
> Why are you switching to pm_runtime_put_sync() here? That isn't covered by
> the commit message (nor I think should be done).

PM autosuspend conversion was suggested earlier by Laurent in his review
of this series [1], and he adviced looking at how it was done for the
imx290 driver. I followed along the lines of the corresponding patch
[2].

>>  			goto unlock_and_return;
>>  		}
>>
>>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>>  		if (ret) {
>> -			pm_runtime_put(dev);
>> +			pm_runtime_put_sync(dev);
>>  			goto unlock_and_return;
>>  		}
>>
>>  		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>>  				OV4689_MODE_STREAMING, NULL);
>>  		if (ret) {
>> -			pm_runtime_put(dev);
>> +			pm_runtime_put_sync(dev);
>>  			goto unlock_and_return;
>>  		}
>>  	} else {
>>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>>  			  OV4689_MODE_SW_STANDBY, NULL);
>> -		pm_runtime_put(dev);
>> +		pm_runtime_mark_last_busy(dev);
>> +		pm_runtime_put_autosuspend(dev);
>>  	}
>>
>>  unlock_and_return:
>> @@ -606,7 +607,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>>  		break;
>>  	}
>>
>> -	pm_runtime_put(dev);
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_put_autosuspend(dev);
>
> Also note that with runtime PM autosuspend,  you have to use
> pm_runtime_get_if_active() instead of pm_runtime_get_if_in_use().

Noted, will do so in v3.

>> +
>>  	return ret;
>>  }
>>
>> @@ -877,8 +880,10 @@ static int ov4689_probe(struct i2c_client *client)
>>  	}
>>
>>  	pm_runtime_set_active(dev);
>> +	pm_runtime_get_noresume(dev);
>>  	pm_runtime_enable(dev);
>> -	pm_runtime_idle(dev);
>> +	pm_runtime_set_autosuspend_delay(dev, 1000);
>> +	pm_runtime_use_autosuspend(dev);
>>
>>  	ret = v4l2_async_register_subdev_sensor(sd);
>>  	if (ret) {
>> @@ -886,11 +891,14 @@ static int ov4689_probe(struct i2c_client *client)
>>  		goto err_clean_subdev_pm;
>>  	}
>>
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_put_autosuspend(dev);
>> +
>>  	return 0;
>>
>>  err_clean_subdev_pm:
>>  	pm_runtime_disable(dev);
>> -	pm_runtime_set_suspended(dev);
>> +	pm_runtime_put_noidle(dev);
>>  	v4l2_subdev_cleanup(sd);
>>  err_clean_entity:
>>  	media_entity_cleanup(&sd->entity);

[1] https://lore.kernel.org/all/20231211181935.GG27535@pendragon.ideasonboard.com/
[2] https://lore.kernel.org/all/20230116144454.1012-14-laurent.pinchart@ideasonboard.com/

--
Best regards,
Mikhail Rudenko

