Return-Path: <linux-kernel+bounces-617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A516814397
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D04A1C226D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF413AC6;
	Fri, 15 Dec 2023 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOstoCbP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2712E40;
	Fri, 15 Dec 2023 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso420875e87.3;
        Fri, 15 Dec 2023 00:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702628898; x=1703233698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stTvSHZLb5CqsEOyVRIAudsm7pck73dfys1JaIqoEL8=;
        b=iOstoCbPjK+VP50rENwFjVGIasDx8Q+LHP7/Yynf7iP0WxEiYOBQSZ69pfD2KkwpZe
         w5Vgo64lwX3D+gBP5eFgzgrFK3aE7rRJkx6lXt8OroORK08O5x5yyCtlziVsM7y39ZVr
         5TT0Vryf4cWjTyLJxqDjguv+/5IwrMXFonkpbCME+c55HDWZO/Y5S1IDENLfrdsbLQHo
         zjAYrHZpRv29KRLPPmTk+HdrRfScRzZ4LZQ0NzKJewwfsqUn9sGi+6+TK0fZUyXVBNfk
         IACzTwbtHt2b0XfNvvu74zaHEVCJQEYhaE5lYiBDQxSdJaFVDCFcqsH0AzEKk2BJ/lZs
         fbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702628898; x=1703233698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stTvSHZLb5CqsEOyVRIAudsm7pck73dfys1JaIqoEL8=;
        b=mjmg+IgofS+IRTyivtbufJoOIzXuGWdIehy5XPcKq7w6M9Km3xRndWPZGWQF2YFDHc
         5S+2PVYIXX9OVMET6Ms2nDz/k4R7qO58sK4qTTgc2uKYQ3bVaknA43E4aw9yylQcBQte
         6vdXVO4nuZ9oVTPORYcUeh9kPdB1Hu0T/d89gLqshZO8QUd+OGq/ms7wfkquV2snaAyj
         wZJjTrJi2D8lkgmDcOZFzb/hf3KIVoRAgryJ0B1COa5mt5G76K45jkiMsNHjh7pH6yiF
         Vo67HyPUAkLJAGKHJNmy0Rhpzfog8eOk1yP4E3EOsoA/+sqvk8mqZWU1T00zgd+nZ+PE
         AO7w==
X-Gm-Message-State: AOJu0YwktNDgIzpAx1VBzpoGhh3Y36ywiHz6E/5sbkLWIn4s9OF82EM7
	/nntyMrkedEGiswqNUbgng8=
X-Google-Smtp-Source: AGHT+IE3gMo5yhvXli3epF1ZD1Y8aQjJ8qr8RuhjCwUQeEvoBNFjxc1W3qHZlTZRP3Hj46JTVb8xdw==
X-Received: by 2002:a05:6512:ba8:b0:50c:d30:3a05 with SMTP id b40-20020a0565120ba800b0050c0d303a05mr7232947lfv.25.1702628898225;
        Fri, 15 Dec 2023 00:28:18 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id vi8-20020a170907d40800b00a1c7b20e9e6sm10433472ejc.32.2023.12.15.00.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 00:28:17 -0800 (PST)
Date: Fri, 15 Dec 2023 09:28:15 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: linuxfancy@googlegroups.com, sakari.ailus@linux.intel.com,
	laurent.pinchart@ideasonboard.com,
	Martin Hecht <martin.hecht@avnet.eu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] media: i2c: alvium: removal of dft_fr, min_fr and
 max_fr
Message-ID: <ZXwOH08B2A0JeNWI@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231215082136.1720379-1-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215082136.1720379-1-tomm.merciai@gmail.com>

Hi,
Wrong git send-email, sorry.
Drop this, is in the series below.

Thanks & Regards,
Tommaso

On Fri, Dec 15, 2023 at 09:21:36AM +0100, Tommaso Merciai wrote:
> Remove driver private data dft_fr, min_fr and max_fr.
> Those are used only in alvium_set_frame_interval function.
> Use local ones instead.
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/media/i2c/alvium-csi2.c | 45 +++++++++++++++------------------
>  drivers/media/i2c/alvium-csi2.h |  3 ---
>  2 files changed, 21 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> index 34ff7fad3877..c4b7851045a1 100644
> --- a/drivers/media/i2c/alvium-csi2.c
> +++ b/drivers/media/i2c/alvium-csi2.c
> @@ -1170,40 +1170,36 @@ static int alvium_set_bayer_pattern(struct alvium_dev *alvium,
>  	return 0;
>  }
>  
> -static int alvium_get_frame_interval(struct alvium_dev *alvium)
> +static int alvium_get_frame_interval(struct alvium_dev *alvium,
> +				     u64 *dft_fr, u64 *min_fr, u64 *max_fr)
>  {
> -	u64 dft_fr, min_fr, max_fr;
>  	int ret = 0;
>  
>  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> -		    &dft_fr, &ret);
> +		    dft_fr, &ret);
>  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R,
> -		    &min_fr, &ret);
> +		    min_fr, &ret);
>  	alvium_read(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R,
> -		    &max_fr, &ret);
> +		    max_fr, &ret);
>  	if (ret)
>  		return ret;
>  
> -	alvium->dft_fr = dft_fr;
> -	alvium->min_fr = min_fr;
> -	alvium->max_fr = max_fr;
> -
>  	return 0;
>  }
>  
> -static int alvium_set_frame_rate(struct alvium_dev *alvium)
> +static int alvium_set_frame_rate(struct alvium_dev *alvium, u64 fr)
>  {
>  	struct device *dev = &alvium->i2c_client->dev;
>  	int ret;
>  
>  	ret = alvium_write_hshake(alvium, REG_BCRM_ACQUISITION_FRAME_RATE_RW,
> -				  alvium->fr);
> +				  fr);
>  	if (ret) {
>  		dev_err(dev, "Fail to set frame rate lanes reg\n");
>  		return ret;
>  	}
>  
> -	dev_dbg(dev, "set frame rate: %llu us\n", alvium->fr);
> +	dev_dbg(dev, "set frame rate: %llu us\n", fr);
>  
>  	return 0;
>  }
> @@ -1667,36 +1663,36 @@ static int alvium_g_frame_interval(struct v4l2_subdev *sd,
>  }
>  
>  static int alvium_set_frame_interval(struct alvium_dev *alvium,
> -				     struct v4l2_subdev_frame_interval *fi)
> +				     struct v4l2_subdev *sd,
> +				     struct v4l2_subdev_state *sd_state,
> +				     struct v4l2_subdev_frame_interval *fi,
> +				     u64 *req_fr)
>  {
>  	struct device *dev = &alvium->i2c_client->dev;
> -	u64 req_fr, min_fr, max_fr;
> +	u64 dft_fr, min_fr, max_fr;
>  	int ret;
>  
>  	if (fi->interval.denominator == 0)
>  		return -EINVAL;
>  
> -	ret = alvium_get_frame_interval(alvium);
> +	ret = alvium_get_frame_interval(alvium, &dft_fr, &min_fr, &max_fr);
>  	if (ret) {
>  		dev_err(dev, "Fail to get frame interval\n");
>  		return ret;
>  	}
>  
> -	min_fr = alvium->min_fr;
> -	max_fr = alvium->max_fr;
> -
>  	dev_dbg(dev, "fi->interval.numerator = %d\n",
>  		fi->interval.numerator);
>  	dev_dbg(dev, "fi->interval.denominator = %d\n",
>  		fi->interval.denominator);
>  
> -	req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
> +	*req_fr = (u64)((fi->interval.denominator * USEC_PER_SEC) /
>  		       fi->interval.numerator);
>  
> -	if (req_fr >= max_fr && req_fr <= min_fr)
> -		req_fr = alvium->dft_fr;
> +	if (*req_fr >= max_fr && *req_fr <= min_fr)
> +		*req_fr = dft_fr;
>  
> -	alvium->fr = req_fr;
> +	alvium->fr = *req_fr;
>  	alvium->frame_interval.numerator = fi->interval.numerator;
>  	alvium->frame_interval.denominator = fi->interval.denominator;
>  
> @@ -1708,6 +1704,7 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  				   struct v4l2_subdev_frame_interval *fi)
>  {
>  	struct alvium_dev *alvium = sd_to_alvium(sd);
> +	u64 req_fr;
>  	int ret;
>  
>  	/*
> @@ -1720,9 +1717,9 @@ static int alvium_s_frame_interval(struct v4l2_subdev *sd,
>  	if (alvium->streaming)
>  		return -EBUSY;
>  
> -	ret = alvium_set_frame_interval(alvium, fi);
> +	ret = alvium_set_frame_interval(alvium, sd, sd_state, fi, &req_fr);
>  	if (!ret)
> -		ret = alvium_set_frame_rate(alvium);
> +		ret = alvium_set_frame_rate(alvium, req_fr);
>  
>  	return ret;
>  }
> diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
> index 8b554bffdc39..a6529b28e7dd 100644
> --- a/drivers/media/i2c/alvium-csi2.h
> +++ b/drivers/media/i2c/alvium-csi2.h
> @@ -443,9 +443,6 @@ struct alvium_dev {
>  
>  	struct alvium_mode mode;
>  	struct v4l2_fract frame_interval;
> -	u64 dft_fr;
> -	u64 min_fr;
> -	u64 max_fr;
>  	u64 fr;
>  
>  	u8 h_sup_csi_lanes;
> -- 
> 2.34.1
> 

