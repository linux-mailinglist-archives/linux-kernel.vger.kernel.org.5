Return-Path: <linux-kernel+bounces-96877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D702187627F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C4FB22F82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4903255C07;
	Fri,  8 Mar 2024 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tlp5ArJg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A625576D;
	Fri,  8 Mar 2024 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709895421; cv=none; b=dyftj+Nii5LbJf81J1KRyZAzjJ1WWdTJ2PuUlZQrENCsuMruBoIOvb+rqhvN7XBSgJI6aFtwY8JPhObb2+DXRx+bR5o/6gkBJ+GF7cpSakJ1qvTsk3CNfi5rXnw2c4MzuJJgJSOrjwIgBZ0YRrut97yMiKoNVtZdJvF/bQ6z17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709895421; c=relaxed/simple;
	bh=6MUM1+UrXfr+F/qr/LomUp2CQgH4YIN7KdQkXnuzBEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtSER4dkasyDw8QuSUtV9qiVpsSm7geuyPW1Ghpd41+qvGuW+4yIEjV4ZjiCrmijne0GwY5HCLkEOBv/ktmY1AI/AP97fTQ/J98PURrsAvDDifZbrHyTJ/DDvi2bSLHbApt7RKtuPU2zNgmaGIDBhKKI6SmqmkRoodVipND4mrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tlp5ArJg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4131bbb7fbcso1130775e9.2;
        Fri, 08 Mar 2024 02:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709895418; x=1710500218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ubL9v68J0vgO0GICkre151wnPO+/i+XqM+wdizAgqc4=;
        b=Tlp5ArJgZthPf5iHQTk4xXYwXsYG9c+gQPs+O8LbRfotzEDzGQsPySzJ4nxacQu6nf
         YBLWT/iGmfUdmJssdwCA0w/yg/pNF/NoO9HsgwOLpmTHlXiXMkfU7Uixqf0aS363y+AC
         i6zubf6xKfnT0xsfuHt52U7QXpjldq3feGSmT0IJ0TRnIfHzzauibuDUuxkfsB35Epwn
         0Np4aQB8RDi1a75G255F9MWgMpXJmj6mpkZLcsJtNPoXwIyMxGdcXYJKnPeYFQgI/PJf
         ya4W5WFaO5Qc2nPQunQ+Um61BaWWpdSBIT++KDMTgm+OeOzpZmvGf0948LoUAUktTQRq
         bTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709895418; x=1710500218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubL9v68J0vgO0GICkre151wnPO+/i+XqM+wdizAgqc4=;
        b=GLB+vCfAfxayx88zHLwmV3oDDFHVAoJxBMuORPeTZ6EY8694qOgwgPh+WYPhw6ljJJ
         SgbVGUyX6czs9WSqv80fxlgnFDow18jenSTsf6aZdBaodQ10QyBihOZlGgWxpa/+rHpK
         /DOTGiXXzov4uObgUyPRgCBBZbHOwmAmrEVNTdwLZ9SDoML1agHzfsfvfoyw8muSS/2F
         +/bD12XHMxb9qw9uKhGAqoJskfC41RJTnXSFdE9KEo6bo0NeNquCtFvtibZ/u0dX0duJ
         BnUoo5pmvQgFrGvkSq6sGiM+HKjih/QKNsUcvTSjVdrFZwWPLa7INFGhq451r//N8+zR
         BgIg==
X-Forwarded-Encrypted: i=1; AJvYcCVspKXasK5AmXiA6Od/S92xjRhDP4E4U7pD55IYPqZwD6A0WtwtkvcQqSzuDUfh6kDyL52dNi3UuiywjisAjTencCILQA4nJKDlI/ZJ
X-Gm-Message-State: AOJu0YxXBK/EKE0WmT3mL4mZN2D91Rdi/y5nqsSMXgu/+X+bBc374CKk
	+uVyZtJ6lKUpqwGZglEv/D7uonzkbHv4yqlEcqO+hLxi764SZbdJ
X-Google-Smtp-Source: AGHT+IH4fhrQOIu7P0Pj0Wl2QY+9shW0YlFfDBcZ/fYhEru9OuD6mKEWw+r4V3GLEQKgHLumukmRrg==
X-Received: by 2002:a5d:4f07:0:b0:33e:11c3:7ebf with SMTP id c7-20020a5d4f07000000b0033e11c37ebfmr15096484wru.62.1709895418111;
        Fri, 08 Mar 2024 02:56:58 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-82.cust.vodafonedsl.it. [188.217.49.82])
        by smtp.gmail.com with ESMTPSA id cc6-20020a5d5c06000000b0033e45c3f026sm11056266wrb.4.2024.03.08.02.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:56:57 -0800 (PST)
Date: Fri, 8 Mar 2024 11:56:55 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	open list <linux-kernel@vger.kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v2 2/6] media: imx335: Parse fwnode properties
Message-ID: <Zeru90ETVmNP6ehn@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20240308083312.90279-1-umang.jain@ideasonboard.com>
 <20240308083312.90279-3-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308083312.90279-3-umang.jain@ideasonboard.com>

Hi Umang, Kieram,

On Fri, Mar 08, 2024 at 02:03:08PM +0530, Umang Jain wrote:
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> Call the V4L2 fwnode device parser to handle controls that are
> standardised by the framework.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 7162b0a3cef3..819ab3a6c5fc 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -1225,10 +1225,12 @@ static int imx335_init_controls(struct imx335 *imx335)
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
> @@ -1300,6 +1302,15 @@ static int imx335_init_controls(struct imx335 *imx335)
>  		return ctrl_hdlr->error;
>  	}
>  
> +	ret = v4l2_fwnode_device_parse(imx335->dev, &props);
> +	if (ret)
> +		return ret;
> +
> +	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
> +					      &props);
> +	if (ret)
> +		return ret;
> +
>  	imx335->sd.ctrl_handler = ctrl_hdlr;
>  
>  	return 0;

Just a doubt on my side.
We don't need an error path to free ctrl_hdlr?
Or I'm missing something?

Something similar:

ret = v4l2_fwnode_device_parse(imx335->dev, &props);
if (ret)
	goto free_ctrls;

ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx335_ctrl_ops,
	                              &props);
if (ret)
	return ret;

free_ctrls:
	v4l2_ctrl_handler_free(hdl);
	return ret;

Thanks & Regards,
Tommaso

> -- 
> 2.43.0
> 
> 

