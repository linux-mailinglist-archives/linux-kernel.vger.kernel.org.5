Return-Path: <linux-kernel+bounces-80120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1190862AEC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031F31C20E04
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8401426F;
	Sun, 25 Feb 2024 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZL0LTO/O"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00102101F2;
	Sun, 25 Feb 2024 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873495; cv=none; b=gCG0j38ju5w00RWZWAFkbaBzbmzA3+rBzu9b9telFESp0PlV8tFX/dMF8slSC8ZuoKy+zanUXOxviqILXeK/0aQxpVay2axgFuzkpSl44jAYgd/FVI3UIsH6rxF/PkN7iIZanbTuz5X+BqUCBtPdw2FhF8gLzx7oDv1UCjsUqKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873495; c=relaxed/simple;
	bh=Qz3Hg3/pmrTsxW4lQR9gRwsvt0zyVvdL92XoMUAcjpA=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=RTzT3imLp0BV06FZ28JuTunyoK9M3JZKZ9a+BHjUJrUTk/657jZ7feeAxhAC96nib/V0khRAHizlfne4qWvBKynLZ4rA9RPILmdCevMCnwrmnWbftBdYC1t36YrVcKGBFNt6KaFPwKbW7slnj160whDl1AfzB3aR+/wmNNHnMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZL0LTO/O; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512fd840142so204040e87.2;
        Sun, 25 Feb 2024 07:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708873492; x=1709478292; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=RkMg7AWMyrEAw/Fmf6lRCrkWxcJYIt/urKvuCiI7gXI=;
        b=ZL0LTO/OYSTltvavf4VT95Nr6+QQsTqjl2A1c3gKfii5QktJntRDENNIqupg1Dtlc/
         jImQTKvc92/7fBJcuMgAPK4iSsFbTu0IFVHScSL/3R2YwS2MrNceihKQ8nojfjko8IKQ
         qImCmVn9n8HrbNGP6WUOvpWNaip0VeGELEkySsh8sYe4LojXrSUe6JqvChzvHBjwzQ/5
         rK6Yl/oo1XDKtDdLGBQPAiSdwRt+ArfWgreryhDWvM8f9PB6yl1bCL9MKmRTXVKhIPxk
         hHVTtRFTr3tiHn8fgCLGu3p/YP/jHQMbr6fahDbxQxS8eIzI2E2QMhGqJ9pQ1U5EIjDg
         6cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708873492; x=1709478292;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkMg7AWMyrEAw/Fmf6lRCrkWxcJYIt/urKvuCiI7gXI=;
        b=Te8kEgQFNmqo344FLVsUVa6Jlue88ycNgi6kKs7qT+EGNhDeVj6yTZdi8ZJLOoirrj
         lOhyRRvLctowuGzCxPU6MHerbFvJgt4MwE0QPLjtitE5gKhKyCVv6Gk8ys56A9iYjtQ5
         vJp5HbHIIssfjSZZnetN/Op9a2knV7XYNq32rWyRf517ne5W9+FAKBqgqWeB783NdTO0
         Bwuo2msOkuJUbBHGEe3NbIhEqNrFtYLgQv+/lmtDWyTa3w2OIwmhvkGGxn2fcsel91tm
         sPoWDTP5NwBwAMpfaE7Ieaf7BM03px8NWnx2trwFIp6RwRwgvq/c34+YZbNaBpoyTfiE
         sd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2vnBwzktnEGwDb2sG0i562hFEcoIUbQSZRnwktyzPjcw600jvt+/skIhv+s11RPLl36piqDVAMRUIE7BHOHxeJMo5Lw8vfGZVaoZeuqeT/J4FvqQXCBl4WmkH7eMYkTp/y0EXENUK6kE=
X-Gm-Message-State: AOJu0Yxx3heNEFAHGzHKaF3owlT07r56X/ADhHSjfI/XOKQFLDXLMHDZ
	Z+owF3lqvI+HSuBbhxJEJN+yaobfPN0H0+Bq1OJmxO3/d8Wg913v
X-Google-Smtp-Source: AGHT+IGjfNo0/awdjbV9i4IP6ZRmhNydv2WOonsqkcDUmc/+mjhy8rxCxzRRnZV2AtT9PrBZ1FKKiA==
X-Received: by 2002:ac2:410a:0:b0:512:bf98:b44a with SMTP id b10-20020ac2410a000000b00512bf98b44amr2638397lfi.49.1708873491811;
        Sun, 25 Feb 2024 07:04:51 -0800 (PST)
Received: from razdolb ([89.208.103.172])
        by smtp.gmail.com with ESMTPSA id eo2-20020a056512480200b00512fcc54a1csm137896lfb.288.2024.02.25.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:04:51 -0800 (PST)
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-10-mike.rudenko@gmail.com>
 <ZZvaDyGSMrjb6e75@valkosipuli.retiisi.eu> <878r4z4ysb.fsf@gmail.com>
 <ZdhVAEElqzmJAynB@kekkonen.localdomain> <87le7bdsk4.fsf@gmail.com>
 <ZdpFwtU0iJEFWxhu@kekkonen.localdomain>
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
Date: Sun, 25 Feb 2024 17:58:43 +0300
In-reply-to: <ZdpFwtU0iJEFWxhu@kekkonen.localdomain>
Message-ID: <87edd0d1pq.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On 2024-02-24 at 19:38 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hi Mikhail,
>
> On Fri, Feb 23, 2024 at 06:18:12PM +0300, Mikhail Rudenko wrote:
>>
>> Hi Sakari,
>>
>> and thanks for the review!
>>
>> On 2024-02-23 at 08:19 GMT, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>>
>> > Hi Mikhail,
>> >
>> > On Mon, Jan 08, 2024 at 06:06:52PM +0300, Mikhail Rudenko wrote:
>> >> Hi Sakari,
>> >>
>> >> Thanks for the review!
>> >>
>> >> On 2024-01-08 at 11:18 GMT, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>> >>
>> >> > Hi Mikhail,
>> >> >
>> >> > On Mon, Dec 18, 2023 at 08:40:30PM +0300, Mikhail Rudenko wrote:
>> >> >> Use runtime PM autosuspend to avoid powering off the sensor during
>> >> >> fast stop-reconfigure-restart cycles.
>> >> >>
>> >> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> >> >> ---
>> >> >>  drivers/media/i2c/ov4689.c | 22 +++++++++++++++-------
>> >> >>  1 file changed, 15 insertions(+), 7 deletions(-)
>> >> >>
>> >> >> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> >> >> index 5300e621ff90..64cc6d9e48cc 100644
>> >> >> --- a/drivers/media/i2c/ov4689.c
>> >> >> +++ b/drivers/media/i2c/ov4689.c
>> >> >> @@ -407,26 +407,27 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>> >> >>  					  ov4689->cur_mode->num_regs,
>> >> >>  					  NULL);
>> >> >>  		if (ret) {
>> >> >> -			pm_runtime_put(dev);
>> >> >> +			pm_runtime_put_sync(dev);
>> >> >
>> >> > Why are you switching to pm_runtime_put_sync() here? That isn't covered by
>> >> > the commit message (nor I think should be done).
>> >>
>> >> PM autosuspend conversion was suggested earlier by Laurent in his review
>> >> of this series [1], and he adviced looking at how it was done for the
>> >> imx290 driver. I followed along the lines of the corresponding patch
>> >> [2].
>> >
>> > There's no need to use the _sync() variant here. And at least it wouldn't
>> > be related to autosuspend, were you to switch to that.
>>
>> Ok, will use pm_runtime_put in v3. Or do you suggest dropping this patch
>> altogether? Laurent?
>
> Using autosuspend is preferred.
>
> Much of the benefit come from avoiding redundant register writes but that's
> a separate matter.

I see, will try to do it in a separate patch outside this series. Could
you please point to a driver which does this right?

>
>>
>> >>
>> >> >>  			goto unlock_and_return;
>> >> >>  		}
>> >> >>
>> >> >>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>> >> >>  		if (ret) {
>> >> >> -			pm_runtime_put(dev);
>> >> >> +			pm_runtime_put_sync(dev);
>> >> >>  			goto unlock_and_return;
>> >> >>  		}
>> >> >>
>> >> >>  		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>> >> >>  				OV4689_MODE_STREAMING, NULL);
>> >> >>  		if (ret) {
>> >> >> -			pm_runtime_put(dev);
>> >> >> +			pm_runtime_put_sync(dev);
>> >> >>  			goto unlock_and_return;
>> >> >>  		}
>> >> >>  	} else {
>> >> >>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>> >> >>  			  OV4689_MODE_SW_STANDBY, NULL);
>> >> >> -		pm_runtime_put(dev);
>> >> >> +		pm_runtime_mark_last_busy(dev);
>> >> >> +		pm_runtime_put_autosuspend(dev);
>> >> >>  	}
>> >> >>
>> >> >>  unlock_and_return:
>> >> >> @@ -606,7 +607,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>> >> >>  		break;
>> >> >>  	}
>> >> >>
>> >> >> -	pm_runtime_put(dev);
>> >> >> +	pm_runtime_mark_last_busy(dev);
>> >> >> +	pm_runtime_put_autosuspend(dev);
>> >> >
>> >> > Also note that with runtime PM autosuspend,  you have to use
>> >> > pm_runtime_get_if_active() instead of pm_runtime_get_if_in_use().
>> >>
>> >> Noted, will do so in v3.
>> >>
>> >> >> +
>> >> >>  	return ret;
>> >> >>  }
>> >> >>
>> >> >> @@ -877,8 +880,10 @@ static int ov4689_probe(struct i2c_client *client)
>> >> >>  	}
>> >> >>
>> >> >>  	pm_runtime_set_active(dev);
>> >> >> +	pm_runtime_get_noresume(dev);
>> >> >>  	pm_runtime_enable(dev);
>> >> >> -	pm_runtime_idle(dev);
>> >> >> +	pm_runtime_set_autosuspend_delay(dev, 1000);
>> >> >> +	pm_runtime_use_autosuspend(dev);
>> >> >>
>> >> >>  	ret = v4l2_async_register_subdev_sensor(sd);
>> >> >>  	if (ret) {
>> >> >> @@ -886,11 +891,14 @@ static int ov4689_probe(struct i2c_client *client)
>> >> >>  		goto err_clean_subdev_pm;
>> >> >>  	}
>> >> >>
>> >> >> +	pm_runtime_mark_last_busy(dev);
>> >> >> +	pm_runtime_put_autosuspend(dev);
>> >> >> +
>> >> >>  	return 0;
>> >> >>
>> >> >>  err_clean_subdev_pm:
>> >> >>  	pm_runtime_disable(dev);
>> >> >> -	pm_runtime_set_suspended(dev);
>> >> >> +	pm_runtime_put_noidle(dev);
>> >> >>  	v4l2_subdev_cleanup(sd);
>> >> >>  err_clean_entity:
>> >> >>  	media_entity_cleanup(&sd->entity);
>> >>
>> >> [1] https://lore.kernel.org/all/20231211181935.GG27535@pendragon.ideasonboard.com/
>> >> [2] https://lore.kernel.org/all/20230116144454.1012-14-laurent.pinchart@ideasonboard.com/
>> >>
>>
>>


--
Best regards,
Mikhail Rudenko

