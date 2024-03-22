Return-Path: <linux-kernel+bounces-111636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5B886ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ABC7B23195
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4689E481DA;
	Fri, 22 Mar 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLl8Xabd"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570843ACB;
	Fri, 22 Mar 2024 14:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118674; cv=none; b=Ggy9WwGPWtVG/AqrFaMtvZTG19sODIQQ2UcTQb9/wMeCmX7UpeA2Qbzv41kG6el0go3+1C1uMw2dVHhoitJhfh4/cwlkVPG9e8CUCyF3ynJSxTFpGIMgtbwR/P2qc3IOsHrtwOx63yJPwnB1sz1JXUB2IGSKroyt/Z8zE9rfWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118674; c=relaxed/simple;
	bh=fLvLAoxK4AgIfQuMHjJKO2hy8PqWwldmk3SToV5xSGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kn4q4Pf7iWA+BmMbYytPGPhMATA3CUpnQsOolE+peGP1xhtUwJ0FLiwtb3ick23hdscao6zYQqvIKyMuuj9NA9GxXDqodDFFHNUPh8/OlxC4A8Erp1gmru0IbZZ/vyqeeqFk+u5gqNxGJI1yuVzPjP1MvWbGrDnCH+B/1Lo99Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLl8Xabd; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513dc9d6938so2913413e87.2;
        Fri, 22 Mar 2024 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118671; x=1711723471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydPjZIhrdpBAx+xTo9vWQVbHzQe3rJLAV5yOy6IIdbM=;
        b=RLl8XabdAZxIQSmkIp4JskFxZ7VbWXjYU1ZMm21JSmyUlMIPzsKsMW4scMRsVK/Tgm
         wYSSq2uB8KkXCeMXm7eGcIWS+JQ8ZNM+5Nr2OOnlWLFE4AMIibl+Kx0Fyz0wtVgJS1IR
         moFRNNMNO00a20DVr8CZQbfNeVA9WJ90cdS7rArso9ODGTTRtyccJlh6QHdpFMu2ozkf
         3SueP0VAU2ThBWp3yFN14dHVDpf3MGSwWeruKipdHVzYUAknasv31YKFjtAfQC6Bwb2C
         KxKe6LteVXo86dCSon285BRbI9DZGmgwvXfr6qmHTl0vsEZRvsKd7KhOU85tl38wiqBw
         eRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118671; x=1711723471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydPjZIhrdpBAx+xTo9vWQVbHzQe3rJLAV5yOy6IIdbM=;
        b=ZQrEtviifuBpMJzr5rIIQ42hDWncUdxyCkF72XMs2uYOPUGxHs1YZz4Gr2dRnjAvUZ
         LcPnJERxIC4s0W10+ASypCkzIT9gu2DBKXx1ucOEry2814r34ZvXz5eKoThIqqPxbvL/
         jVms0ZODN1AcgF1+bGjOqlSr7tXf4vaM/YCgIMUgxit1wVXOsuU+pP1rnx45b8UuDpD7
         +prfP6xW7sN1IU764yOPjWiChMQVJTSNY+Gi67A2np2r731M0m2rJl5HGHj26REZa6eK
         lxspCRsGPl3HLDhpypH7+Eb9U2+d5SkITxMil/tu2M5+fOr1SqXkHYsAO7sSgCw8p/Wi
         Qomg==
X-Forwarded-Encrypted: i=1; AJvYcCWIbEq7MGhh1SG9FGzzvxZFRIkhJ4MIsn3LO7pfiZCQ8hM35wyYY0nUjvHkR/0Lbvx7wN3EP6aiqWyvrD+YTHpu3yg1c0rFcDV4rdy7
X-Gm-Message-State: AOJu0YyHjcxfWoYO1ZSjWdQ6BEmGj3NSx7VNcQxeXBYd2fm+8ElAipMu
	qGlhlqwS9uViir8EjOWmH0KSZPVNYGGgVsSLycY79Qsnilws7CBEFA9X2xm+
X-Google-Smtp-Source: AGHT+IEuuUGLVdqwKWOu7gZSFXVyRXmkiOxN7iaPO+pplXKWT/UMBkwDue6rk2yl6Rc0l/aWKolPLQ==
X-Received: by 2002:a19:7714:0:b0:513:a39e:ae45 with SMTP id s20-20020a197714000000b00513a39eae45mr1736686lfc.62.1711118670520;
        Fri, 22 Mar 2024 07:44:30 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id k37-20020a05600c1ca500b004140a3d34fasm3256054wms.41.2024.03.22.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:44:29 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:44:28 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] media: imx335: Parse fwnode properties
Message-ID: <Zf2ZTFxKjPHgN9eU@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240321111239.808735-1-umang.jain@ideasonboard.com>
 <20240321111239.808735-3-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321111239.808735-3-umang.jain@ideasonboard.com>

Hi Umang,

On Thu, Mar 21, 2024 at 04:42:35PM +0530, Umang Jain wrote:
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> Call the V4L2 fwnode device parser to handle controls that are
> standardised by the framework.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index c633ea1380e7..b8cf85984127 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -1227,10 +1227,12 @@ static int imx335_init_controls(struct imx335 *imx335)
>  {
>  	struct v4l2_ctrl_handler *ctrl_hdlr = &imx335->ctrl_handler;
>  	const struct imx335_mode *mode = imx335->cur_mode;
> +	struct v4l2_fwnode_device_properties props;
>  	u32 lpfr;
>  	int ret;
>  
> -	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 7);
> +	/* v4l2_fwnode_device_properties can add two more controls */
> +	ret = v4l2_ctrl_handler_init(ctrl_hdlr, 9);
>  	if (ret)
>  		return ret;
>  
> @@ -1296,15 +1298,27 @@ static int imx335_init_controls(struct imx335 *imx335)
>  		imx335->hblank_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>  
>  	if (ctrl_hdlr->error) {
> -		dev_err(imx335->dev, "control init failed: %d\n",
> -			ctrl_hdlr->error);
> -		v4l2_ctrl_handler_free(ctrl_hdlr);
> -		return ctrl_hdlr->error;
> +		ret = ctrl_hdlr->error;
> +		dev_err(imx335->dev, "control init failed: %d\n", ret);

Don't know if we need this dev_err print here.
If I'm not wrong this is already printed into the imx335_probe:

ret = imx335_init_controls(imx335);
if (ret) {
	dev_err(imx335->dev, "failed to init controls: %d\n", ret);
	goto error_power_off;
}

Apart of that looks good to me. :)
Reviewed-by: Tommaso Merciai <tomm.merciai@gmail.com>

> +		goto free_ctrl_hdlr;
>  	}
>  
> +	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
> +	if (ret)
> +		goto free_ctrl_hdlr;
> +
> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
> +					      &props);
> +	if (ret)
> +		goto free_ctrl_hdlr;
> +
>  	imx335->sd.ctrl_handler = ctrl_hdlr;
>  
>  	return 0;
> +
> +free_ctrl_hdlr:
> +	v4l2_ctrl_handler_free(ctrl_hdlr);
> +	return ret;
>  }
>  
>  /**
> -- 
> 2.43.0

Thanks & Regards,
Tommaso

> 
> 

