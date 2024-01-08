Return-Path: <linux-kernel+bounces-19417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC116826C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB1281035
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A157414AA5;
	Mon,  8 Jan 2024 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Luppexhm";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="wlzWEzml"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501AB14A8D;
	Mon,  8 Jan 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4T7s2975kkz49Py8;
	Mon,  8 Jan 2024 13:16:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1704712578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRzBCMMQ3iNT4N+/PtoE+zl1cNf6xy8Jh8N7QEIPuR0=;
	b=LuppexhmF+qLbw/oCBO6M82rgaF2MnuRfZPyAkoWzoDHEVASUB7ccsqBrVFA0rJVQUz3qW
	tg7/ZAScmc/wWtZrc1RJ7qnQd2knGxDe2IUGL9eY0vqkzpVmyavDCmJTuskTb4RYPZAKEx
	TZAd+uNT7Q9bdvgZDamY5QpP56VZGtDHBTT67ZOl53cZ7je9FZ4OOIdwcfK9ES2uy6E2M3
	maytfVves+96dso5hUukg26h9YDyIAVQg0MXGBC/+ZE/y/+zpNLyyWXQnaefWWQzduW0oq
	Lhxe3DAMB/kTICVibgoY3hp368XbS5t18ZNZbuIXHKxjTSMJYfsE4wo5Bj8xeg==
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4T7s203rwCzyVF;
	Mon,  8 Jan 2024 13:16:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1704712570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRzBCMMQ3iNT4N+/PtoE+zl1cNf6xy8Jh8N7QEIPuR0=;
	b=wlzWEzmlfbjtN7EPAYxysu6dnh1OrLqhAltCHxtZNtHPfb3E+Q96GDuHP+twx271ZDm6r1
	ITyttcHJS8Z9hnA0PuMESKwmbEM+MidtOwyPHDW/LhvGMy/yLPJ2gEucSG09uVhgobxjIV
	veG1KXvcfPpwxJevtdwd1XFA/wVrgNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1704712570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRzBCMMQ3iNT4N+/PtoE+zl1cNf6xy8Jh8N7QEIPuR0=;
	b=OwaUdeirO3y0WBsvVKLnjqN9JcMnQxS2glNNDL9wjYy8tRAjhXz2AFIl5vINm/CtPLYkFd
	6qGbLU7gnq7gPlelrcgx7by8kydtDGfnYM1bv+l9+EgZ0SVAJgBcZhcQKNSyQMAe6r/2Dl
	XbxbNzSJPQR1VnRciPmiM3SH8GMlygg=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1704712570; a=rsa-sha256; cv=none;
	b=QAyS2Xbkog7xn84AR3YlL+1qoyaideEeDfZXszlGKtqNDMYlkQ8JGwCRXV6h+ww1dKbgoY
	cJLoT8xmm7VCS1JT/ZaPHsCjT3Hxb0d5ct2eyPrJRIjTtKZsDC1D1z9jBjCEyulms55G+w
	O5eTf7hl7iW3AdACeWSPLi2L5edQG88=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 01AD2634C93;
	Mon,  8 Jan 2024 13:16:07 +0200 (EET)
Date: Mon, 8 Jan 2024 11:16:07 +0000
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
Subject: Re: [PATCH v2 06/20] media: i2c: ov4689: Refactor ov4689_set_ctrl
Message-ID: <ZZvZdxqotS47XftY@valkosipuli.retiisi.eu>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-7-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-7-mike.rudenko@gmail.com>

Hi Mikhail,

On Mon, Dec 18, 2023 at 08:40:27PM +0300, Mikhail Rudenko wrote:
> Introduce local variable for regmap within the ov4689_set_ctrl
> function. This adjustment eliminates repetition within the function.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index 3b20eba59c9c..d42f5d1a1ba8 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -580,6 +580,7 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  {
>  	struct ov4689 *ov4689 =
>  		container_of(ctrl->handler, struct ov4689, ctrl_handler);
> +	struct regmap *regmap = ov4689->regmap;
>  	struct device *dev = ov4689->dev;
>  	int sensor_gain;
>  	s64 max_expo;
> @@ -603,16 +604,15 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  	switch (ctrl->id) {
>  	case V4L2_CID_EXPOSURE:
>  		/* 4 least significant bits of exposure are fractional part */
> -		ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
> -				ctrl->val << 4, NULL);
> +		cci_write(regmap, OV4689_REG_EXPOSURE, ctrl->val << 4, &ret);

If you do this, ret needs to have been initialised to 0, but it isn't.

Same for the changes below.

>  		break;
>  	case V4L2_CID_ANALOGUE_GAIN:
>  		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
> -		cci_write(ov4689->regmap, OV4689_REG_GAIN, sensor_gain, &ret);
> +		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
>  		break;
>  	case V4L2_CID_VBLANK:
> -		ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
> -				ctrl->val + ov4689->cur_mode->height, NULL);
> +		cci_write(regmap, OV4689_REG_VTS,
> +			  ctrl->val + ov4689->cur_mode->height, &ret);
>  		break;
>  	case V4L2_CID_TEST_PATTERN:
>  		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
> @@ -625,7 +625,6 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
>  	}
>  
>  	pm_runtime_put(dev);
> -

I thought it was nice.

>  	return ret;
>  }
>  

-- 
Regards,

Sakari Ailus

