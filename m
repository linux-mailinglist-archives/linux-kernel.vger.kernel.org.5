Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B0880EBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346465AbjLLMbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjLLMbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:31:33 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3775AF7;
        Tue, 12 Dec 2023 04:31:37 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bef9b7a67so6394142e87.1;
        Tue, 12 Dec 2023 04:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702384295; x=1702989095; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=tjBIgE59AZZCjyo8NFLiQP+EMk9+biaAHMERFDbHj+c=;
        b=P9RrNzpI6VFtMHAbF6eM46AUoxtWfDv4BgxVzxLoLcYu63aHK9bRecKDlrWUJwd/1T
         hc1393UOT+g0qB8BmPGDnaDmlvfcPanu9P1Yc8UqdnCSpDbaCgInnIu8uj7LwbnYcSZ+
         TxlJQOUDml139xk4PGXCZp1FsKbp6SiVr424H3fbU/Mw6YVQVCdJbZPBMLE7AlKichmw
         3/82fCihBR9wjP6lGB7bKOZfXPAjHn8yIZAh8pi4c0RQ+rgLMLN2VUi3Lh2IPjdKc/Hg
         rRkicxNodAP3vGlrWN5O97r0GaNUCj3FRoZpMXmMQ0j8ewmhSCUyeRYXMrCoJiZ5EhHE
         LQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702384295; x=1702989095;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjBIgE59AZZCjyo8NFLiQP+EMk9+biaAHMERFDbHj+c=;
        b=YtNdeiSDfUwFatvoRXtIUqy96em4GZKos+ilzziKYe2t1tczcahfXjNUj/szJqLJEk
         2RRuTnFtDlRFOGUA4LwNjazbPCAq04LR0VyeYBmgx6FxnhTmjWVLhAS11MuRZDUZcOW9
         qysjGfKqym5HWq7ThSKXRRW4CnfOcOxIDvbucsRkIgonIDGlMXm9Ix6/l3BU8Ua1S5du
         GwOFu/bvceon0EakBE42QRmKkmnCOUrCTg9n/sO6N1wsfyuE8haQspEP4C2CHEERp//S
         pPUfqnHBu2S/AljJL+NMFdNjq2bncvpOu+KixlcRSOlxI+S1Qdh+ERReJlIazKcD31xc
         bg/g==
X-Gm-Message-State: AOJu0YxQlPj2g+UFQmLdSEqry7OSpy1FtyBSSP4X69/hlvJJww16j+ag
        AvZ+ZWautZ0r7ZWAk6LH/g8=
X-Google-Smtp-Source: AGHT+IE7QTqtjR5Rws+/YWOVilRxR3pugs5ALociwjcdLOrSTzuhpE+dXfQg0eiKkeUpvxTxx+3NCg==
X-Received: by 2002:a05:6512:3604:b0:50d:2f84:759c with SMTP id f4-20020a056512360400b0050d2f84759cmr1706732lfs.103.1702384295205;
        Tue, 12 Dec 2023 04:31:35 -0800 (PST)
Received: from razdolb (95-24-149-38.broadband.corbina.ru. [95.24.149.38])
        by smtp.gmail.com with ESMTPSA id ep17-20020a056512485100b0050bf8e28d5dsm1332117lfb.223.2023.12.12.04.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:31:34 -0800 (PST)
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
 <20231211175023.1680247-8-mike.rudenko@gmail.com>
 <20231211181526.GF27535@pendragon.ideasonboard.com>
User-agent: mu4e 1.10.7; emacs 29.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 07/19] media: i2c: ov4689: Use sub-device active state
Date:   Tue, 12 Dec 2023 15:27:38 +0300
In-reply-to: <20231211181526.GF27535@pendragon.ideasonboard.com>
Message-ID: <87ttonppp5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-12-11 at 20:15 +02, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Mikhail,
>
> Thank you for the patch.
>
> On Mon, Dec 11, 2023 at 08:50:10PM +0300, Mikhail Rudenko wrote:
>> Use sub-device active state. Employ control handler lock to
>> synchronize access to the active state and s_stream.
>>
>> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
>> ---
>>  drivers/media/i2c/ov4689.c | 68 +++++++++++++++-----------------------
>>  1 file changed, 27 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
>> index 5392f650960c..2eef64cd0070 100644
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
>> @@ -506,19 +493,15 @@ static int __maybe_unused ov4689_power_off(struct device *dev)
>>  	return 0;
>>  }
>>
>> -static int ov4689_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
>> +static int ov4689_init_cfg(struct v4l2_subdev *sd,
>> +			   struct v4l2_subdev_state *sd_state)
>>  {
>> -	struct ov4689 *ov4689 = to_ov4689(sd);
>> -	struct v4l2_mbus_framefmt *try_fmt;
>> -
>> -	mutex_lock(&ov4689->mutex);
>> +	struct v4l2_mbus_framefmt *try_fmt =
>> +		v4l2_subdev_state_get_format(sd_state, 0);
>>
>> -	try_fmt = v4l2_subdev_state_get_format(fh->state, 0);
>>  	/* Initialize try_fmt */
>
> It's not necessarily a "try format" anymore, so you cand rop this
> comment, and rename the variable from try_fmt to fmt.

Ack, will rename it in v2.

>
>>  	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], try_fmt);
>>
>> -	mutex_unlock(&ov4689->mutex);
>> -
>>  	return 0;
>>  }
>>
>> @@ -526,18 +509,15 @@ static const struct dev_pm_ops ov4689_pm_ops = {
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
>>
>>  static const struct v4l2_subdev_pad_ops ov4689_pad_ops = {
>> +	.init_cfg = ov4689_init_cfg,
>
> Please rebase on top of the latest media tree for the next version, the
> .init_cfg() operation has been renamed to .init_state() and moved to
> v4l2_subdev_internal_ops.

Thanks for the tip, will do it in v2.

> Other than that, this patch looks good.
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>>  	.enum_mbus_code = ov4689_enum_mbus_code,
>>  	.enum_frame_size = ov4689_enum_frame_sizes,
>> -	.get_fmt = ov4689_get_fmt,
>> +	.get_fmt = v4l2_subdev_get_fmt,
>>  	.set_fmt = ov4689_set_fmt,
>>  	.get_selection = ov4689_get_selection,
>>  };
>> @@ -649,7 +629,6 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>>  	ret = v4l2_ctrl_handler_init(handler, 10);
>>  	if (ret)
>>  		return ret;
>> -	handler->lock = &ov4689->mutex;
>>
>>  	ctrl = v4l2_ctrl_new_int_menu(handler, NULL, V4L2_CID_LINK_FREQ, 0, 0,
>>  				      link_freq_menu_items);
>> @@ -862,13 +841,14 @@ static int ov4689_probe(struct i2c_client *client)
>>  		return dev_err_probe(dev, ret,
>>  				     "Failed to get power regulators\n");
>>
>> -	mutex_init(&ov4689->mutex);
>> -
>>  	sd = &ov4689->subdev;
>>  	v4l2_i2c_subdev_init(sd, client, &ov4689_subdev_ops);
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
>> @@ -878,19 +858,26 @@ static int ov4689_probe(struct i2c_client *client)
>>  	if (ret)
>>  		goto err_power_off;
>>
>> -	sd->internal_ops = &ov4689_internal_ops;
>>  	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
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
>> @@ -899,14 +886,14 @@ static int ov4689_probe(struct i2c_client *client)
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
>> @@ -918,9 +905,8 @@ static void ov4689_remove(struct i2c_client *client)
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
