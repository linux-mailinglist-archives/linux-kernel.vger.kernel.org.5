Return-Path: <linux-kernel+bounces-19403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F5826C72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B323B21F46
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A315814AA7;
	Mon,  8 Jan 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="FBraPGtN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016A25750;
	Mon,  8 Jan 2024 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4T7s4w02TnzyVF;
	Mon,  8 Jan 2024 13:18:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1704712720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JYyZivua966D0ojZL046xk0JFccdrag8FMopQfN8oYk=;
	b=FBraPGtNKodiNjGYVYMbjmnmxYf9d9uhpN2ocTdshdLSf/+IhWxyw4mxHl6CTZNxQG4LmG
	FyHmuqmlHJf/8NPbEzMu0qk5pti9dobBr9BnZm+IRL6FO4LIQaE7U3e7bpPZkQw4LxRz9Z
	AQCd6Whg6iKI+ImoUmQNTEzLAS7QxRA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1704712720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JYyZivua966D0ojZL046xk0JFccdrag8FMopQfN8oYk=;
	b=jCtk6A+YWUxF6QDwmTZHBf8EsyiJc/sov9d3TiSXTGPCpt1vDhlWWu1BLDhEncsxO+yl5V
	YiufIIC7FJ2dkx15qw8N4RRUr50SH8c1PF/VrH/3hc7emU83yTd9inilmbDOgIsozNK3xX
	N7ruP4rLMKtlzjgAjS5zwqXTwSR1xio=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1704712720; a=rsa-sha256; cv=none;
	b=BdWSkpyE1DNebr6QA8jgit5UkvkdSNZsgW0AyfiK/+rIsFwxoIDA/lwggAHB0U2i6cBndr
	Cbobb5L1ivcinMQIxFARu1ke382N4C6IvF8ukVoVBWnfGdJNj9C/CEutPnCBylGS9Z35t0
	J6t+Uh/CD9Vmkd8rxxvr/ooqtRS/TuM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id B28E1634C93;
	Mon,  8 Jan 2024 13:18:39 +0200 (EET)
Date: Mon, 8 Jan 2024 11:18:39 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 09/20] media: i2c: ov4689: Use runtime PM autosuspend
Message-ID: <ZZvaDyGSMrjb6e75@valkosipuli.retiisi.eu>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-10-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-10-mike.rudenko@gmail.com>

Hi Mikhail,

On Mon, Dec 18, 2023 at 08:40:30PM +0300, Mikhail Rudenko wrote:
> Use runtime PM autosuspend to avoid powering off the sensor during
> fast stop-reconfigure-restart cycles.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 5300e621ff90..64cc6d9e48cc 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -407,26 +407,27 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  					  ov4689->cur_mode->num_regs,
>  					  NULL);
>  		if (ret) {
> -			pm_runtime_put(dev);
> +			pm_runtime_put_sync(dev);

Why are you switching to pm_runtime_put_sync() here? That isn't covered by
the commit message (nor I think should be done).

>  			goto unlock_and_return;
>  		}
>  
>  		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
>  		if (ret) {
> -			pm_runtime_put(dev);
> +			pm_runtime_put_sync(dev);
>  			goto unlock_and_return;
>  		}
>  
>  		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>  				OV4689_MODE_STREAMING, NULL);
>  		if (ret) {
> -			pm_runtime_put(dev);
> +			pm_runtime_put_sync(dev);
>  			goto unlock_and_return;
>  		}
>  	} else {
>  		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
>  			  OV4689_MODE_SW_STANDBY, NULL);
> -		pm_runtime_put(dev);
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
>  	}
>  
>  unlock_and_return:
> @@ -606,7 +607,9 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	}
>  
> -	pm_runtime_put(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);

Also note that with runtime PM autosuspend,  you have to use
pm_runtime_get_if_active() instead of pm_runtime_get_if_in_use().

> +
>  	return ret;
>  }
>  
> @@ -877,8 +880,10 @@ static int ov4689_probe(struct i2c_client *client)
>  	}
>  
>  	pm_runtime_set_active(dev);
> +	pm_runtime_get_noresume(dev);
>  	pm_runtime_enable(dev);
> -	pm_runtime_idle(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);
>  
>  	ret = v4l2_async_register_subdev_sensor(sd);
>  	if (ret) {
> @@ -886,11 +891,14 @@ static int ov4689_probe(struct i2c_client *client)
>  		goto err_clean_subdev_pm;
>  	}
>  
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
>  	return 0;
>  
>  err_clean_subdev_pm:
>  	pm_runtime_disable(dev);
> -	pm_runtime_set_suspended(dev);
> +	pm_runtime_put_noidle(dev);
>  	v4l2_subdev_cleanup(sd);
>  err_clean_entity:
>  	media_entity_cleanup(&sd->entity);

-- 
Regards,

Sakari Ailus

