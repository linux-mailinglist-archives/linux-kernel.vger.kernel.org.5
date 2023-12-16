Return-Path: <linux-kernel+bounces-2181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AEB815913
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA51F23AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A421D69E;
	Sat, 16 Dec 2023 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+ZYGiIj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2BA18EA6;
	Sat, 16 Dec 2023 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3364c9ba749so1258090f8f.1;
        Sat, 16 Dec 2023 04:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702730757; x=1703335557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1H4hMNJCw/32Z+RZWpdrmp582opVHteiynBOAnY14+Y=;
        b=B+ZYGiIjDMpUECTMQnlD+xleKAzubC/13ZGcpQAJFlGHIUI8VegQT4z2GODs2VGI/p
         L4i4R8hr05AsO8EUgwl6R1VQfmaBNCTY4pIB2gsXYt6fO+OOWIDUSfuIlKSCJ7dfaKih
         lmbv+lyr/wAKuWukSMlEleZfnHQt7TayZjuINj+t7/jThexf+crNZFGyqrlUFK/VZExG
         rDZEugIj/ezx0cdEsBuuLLmYDUgI9zwvq0Kkfdx3r76+LUxHLpA1fWOpXlD2Jme9BKaI
         hzKO/oHr8XrrybUTl6NmfIo7j6e3/5NSEEELuy9jUu12kXaUyZL1QvamEPQLmZm24XZJ
         D5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702730757; x=1703335557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H4hMNJCw/32Z+RZWpdrmp582opVHteiynBOAnY14+Y=;
        b=exuDJBt2XOqXMTCi8WrZaVqG28ZdFbaSfyOfqxi/F7Z99NxNndhrzkLGebqHC9HYHQ
         P/+ZUczGib8cscVjYce51WLM1VF9CrjJrWi5fmTlT1xubUc7zCB9JVUdVlGYKWFUKFoS
         PKBLvV5M8aRcrRZLECXkBdcw4F70mCv9dLGIJDEEwKZbJUh4+Xfft3gqeb3Gvsa8/Bw1
         KMVs6Cpyt7S31CA3vry7NF/dWK4dVq4Fbeh4dRAHYjjURCdJNilBqaktnbmpQMFFNy0s
         3mvCdOfCEE+GLGB9Vh98ZqhJU7w50pqavg0w38e/r3AWR/6+UPyUoF0GOaURoP6p+pUs
         Mmbg==
X-Gm-Message-State: AOJu0YyvTTi+vLzRXntRVcHZMxdm8Icwd2XPbHv79PUj4jZQB97+rd3T
	LH3kQNCuwDwTn1/UZv1H/ac4xSysMVE=
X-Google-Smtp-Source: AGHT+IHMYHWJES6roXispGRb1UVzSUy2mCj2n9V5d+lGj61Xf1XEIiW0yHZbSqNk1xnabS0cdDUErA==
X-Received: by 2002:adf:e841:0:b0:336:608f:91eb with SMTP id d1-20020adfe841000000b00336608f91ebmr126621wrn.95.1702730756677;
        Sat, 16 Dec 2023 04:45:56 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id vg14-20020a170907d30e00b00a1dcfd8f95csm11775051ejc.37.2023.12.16.04.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:45:56 -0800 (PST)
Date: Sat, 16 Dec 2023 14:45:55 +0200
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: Re: [PATCH] iio: hid-sensor-als: Don't stop probing at non-supported
 attribute
Message-ID: <20231216124555.eyplwam45jdfazr3@jekhomev>
References: <20231216114229.652020-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216114229.652020-1-jekhor@gmail.com>

On Sat, Dec 16, 2023 at 01:42:29PM +0200, Yauhen Kharuzhy wrote:
> Some ambient light sensors don't support color temperature and
> chromaticity attributes. The driver stops probing if it finds this.
> 
> To support sensors without of color temperature and chromaticity
> attributes, just skip them at probing if they weren't found.
> 
> Tested at Lenovo Yogabook YB1-X91L tablet.

Hi, It seems that Srinivas Pandruvada has posted another patch fixing
the same issue. So, drop my patch in favor of his one.

> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/iio/light/hid-sensor-als.c | 39 ++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index f17304b54468..b711bac3bb2b 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -314,8 +314,11 @@ static int als_parse_report(struct platform_device *pdev,
>  						usage_id,
>  						HID_USAGE_SENSOR_LIGHT_ILLUM,
>  						&st->als[i]);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			dev_err(&pdev->dev,
> +				"Failed to setup Illuminance attribute\n");
>  			return ret;
> +		}
>  		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
>  
>  		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
> @@ -326,14 +329,16 @@ static int als_parse_report(struct platform_device *pdev,
>  				usage_id,
>  				HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
>  				&st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
> -	if (ret < 0)
> -		return ret;
> -	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
> -				st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
> +	if (!ret) {
> +		dev_info(&pdev->dev, "Color temperature is supported\n");
> +		als_adjust_channel_bit_mask(channels,
> +			CHANNEL_SCAN_INDEX_COLOR_TEMP,
> +			st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
>  
> -	dev_dbg(&pdev->dev, "als %x:%x\n",
> -		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
> -		st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
> +		dev_dbg(&pdev->dev, "als %x:%x\n",
> +			st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].index,
> +			st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].report_id);
> +	}
>  
>  	for (i = 0; i < 2; i++) {
>  		int next_scan_index = CHANNEL_SCAN_INDEX_CHROMATICITY_X + i;
> @@ -342,23 +347,25 @@ static int als_parse_report(struct platform_device *pdev,
>  				HID_INPUT_REPORT, usage_id,
>  				HID_USAGE_SENSOR_LIGHT_CHROMATICITY_X + i,
>  				&st->als[next_scan_index]);
> -		if (ret < 0)
> -			return ret;
> -
> -		als_adjust_channel_bit_mask(channels,
> +		if (!ret) {
> +			dev_info(&pdev->dev,
> +				 "Light chromaticity %c is supported\n",
> +				 i ? 'Y' : 'X');
> +			als_adjust_channel_bit_mask(channels,
>  					CHANNEL_SCAN_INDEX_CHROMATICITY_X + i,
>  					st->als[next_scan_index].size);
>  
> -		dev_dbg(&pdev->dev, "als %x:%x\n",
> -			st->als[next_scan_index].index,
> -			st->als[next_scan_index].report_id);
> +			dev_dbg(&pdev->dev, "als %x:%x\n",
> +				st->als[next_scan_index].index,
> +				st->als[next_scan_index].report_id);
> +		}
>  	}
>  
>  	st->scale_precision = hid_sensor_format_scale(usage_id,
>  				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
>  				&st->scale_pre_decml, &st->scale_post_decml);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  /* Function to initialize the processing for usage id */
> -- 
> 2.43.0
> 

-- 
Yauhen Kharuzhy

