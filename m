Return-Path: <linux-kernel+bounces-26393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3882E000
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFFE4283D45
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB1018646;
	Mon, 15 Jan 2024 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ChLSa9V4"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899B518C05
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4a2526a7eso49335045ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705343684; x=1705948484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JZFlmy7BEwywSiV8spelsk1ZtaQWPPF5+4+sReYmSWw=;
        b=ChLSa9V4bm2V4qsVVPy2jAnElpifyDfKa1aunT3UaNJgj3YMNIK1VUesBr9tPmcaOq
         zRCjOQdymmNdVuV53hZ312xtiT8VmD1+eb7Z4A25uqvMi9GCVtNPLO+scp/CtX6tR7pC
         VtZmVCzWKqC7sdbmbcKMZDZog+O8bXmgAAPvnakeiF9ZiKBFyYBoZbz65xOfgbeS3KNY
         VGowNqxjNDNEWJ628xpU+txcqWTSyktVzwUouXgrpo6BsuH5u/YwhzWWPdwdS2zD5wms
         6J2PojOJcvscqHvEhUgm7eWDDSOF1IwoostITewz4x4mqAK0Dxmhe8weIP0/GZltEN8x
         AaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705343684; x=1705948484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZFlmy7BEwywSiV8spelsk1ZtaQWPPF5+4+sReYmSWw=;
        b=DSScoTHw+HgrJ45WBSOuRCr75Hv+pRdFpVxXAyBLI0MADC/Wol8ijA7ysVLgmGKfyy
         ANduklQnSewt1/oxHem9kfwZhWce4xnXMccctgPul48Nz7VqD10QUUNighEoM+t6jLxk
         X40soVJzmjaFLuVTcMM2pj8ufpQGtkWxeD84FAIWs7eNRofl0SZ3BSnJFwc6IlRftJlC
         5pC419UJB1fs/wtCshWyFRG9+76hBkRti4Efr4+OvBXJNldbnB2zv57u/QGIuFFYjtzW
         X/S827+wEsm5IQ46la2dDxcB978kOAfuimeLsT7sqTZiIR/lDUIFhInfR9xwAeRKJaf9
         tYtQ==
X-Gm-Message-State: AOJu0YzGUy0ZQYSNYsJHi2x5pfiQRaLdcaNfVh6nJ+02yApXLWeWfkS8
	JCJw6sMseK0c0lURUTGwYpgkviDbEJvI5w==
X-Google-Smtp-Source: AGHT+IFVo39doGrlpm6PCXcFggJ9N+UcWB3vS/3WT5T9cSsVWvXYfyWpabs7SSfBYUzkE94TLt49zg==
X-Received: by 2002:a17:902:834c:b0:1d4:75e5:8feb with SMTP id z12-20020a170902834c00b001d475e58febmr3004149pln.35.1705343683810;
        Mon, 15 Jan 2024 10:34:43 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800::5ced])
        by smtp.gmail.com with ESMTPSA id ku6-20020a170903288600b001d555735b6bsm7910033plb.239.2024.01.15.10.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 10:34:43 -0800 (PST)
Date: Mon, 15 Jan 2024 11:34:41 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] rpmsg: Remove usage of the deprecated ida_simple_xx() API
Message-ID: <ZaV6wd8GghPy+Ti7@p14s>
References: <c09ee5b66d451bf97d14c167048549aa0824ee06.1705225049.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c09ee5b66d451bf97d14c167048549aa0824ee06.1705225049.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

On Sun, Jan 14, 2024 at 10:37:43AM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_max() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/rpmsg/rpmsg_char.c | 12 ++++++------
>  drivers/rpmsg/rpmsg_ctrl.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 

I will apply this patch when the next rc1 comes out.

Thanks,
Mathieu

> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 09833ad05da7..1cb8d7474428 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -399,8 +399,8 @@ static void rpmsg_eptdev_release_device(struct device *dev)
>  {
>  	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
>  
> -	ida_simple_remove(&rpmsg_ept_ida, dev->id);
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(eptdev->dev.devt));
> +	ida_free(&rpmsg_ept_ida, dev->id);
> +	ida_free(&rpmsg_minor_ida, MINOR(eptdev->dev.devt));
>  	kfree(eptdev);
>  }
>  
> @@ -441,12 +441,12 @@ static int rpmsg_chrdev_eptdev_add(struct rpmsg_eptdev *eptdev, struct rpmsg_cha
>  
>  	eptdev->chinfo = chinfo;
>  
> -	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
> +	ret = ida_alloc_max(&rpmsg_minor_ida, RPMSG_DEV_MAX - 1, GFP_KERNEL);
>  	if (ret < 0)
>  		goto free_eptdev;
>  	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
>  
> -	ret = ida_simple_get(&rpmsg_ept_ida, 0, 0, GFP_KERNEL);
> +	ret = ida_alloc(&rpmsg_ept_ida, GFP_KERNEL);
>  	if (ret < 0)
>  		goto free_minor_ida;
>  	dev->id = ret;
> @@ -462,9 +462,9 @@ static int rpmsg_chrdev_eptdev_add(struct rpmsg_eptdev *eptdev, struct rpmsg_cha
>  	return ret;
>  
>  free_ept_ida:
> -	ida_simple_remove(&rpmsg_ept_ida, dev->id);
> +	ida_free(&rpmsg_ept_ida, dev->id);
>  free_minor_ida:
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> +	ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
>  free_eptdev:
>  	put_device(dev);
>  	kfree(eptdev);
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> index 433253835690..c312794ba4b3 100644
> --- a/drivers/rpmsg/rpmsg_ctrl.c
> +++ b/drivers/rpmsg/rpmsg_ctrl.c
> @@ -130,8 +130,8 @@ static void rpmsg_ctrldev_release_device(struct device *dev)
>  {
>  	struct rpmsg_ctrldev *ctrldev = dev_to_ctrldev(dev);
>  
> -	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> +	ida_free(&rpmsg_ctrl_ida, dev->id);
> +	ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
>  	kfree(ctrldev);
>  }
>  
> @@ -156,12 +156,12 @@ static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
>  	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
>  	ctrldev->cdev.owner = THIS_MODULE;
>  
> -	ret = ida_simple_get(&rpmsg_minor_ida, 0, RPMSG_DEV_MAX, GFP_KERNEL);
> +	ret = ida_alloc_max(&rpmsg_minor_ida, RPMSG_DEV_MAX - 1, GFP_KERNEL);
>  	if (ret < 0)
>  		goto free_ctrldev;
>  	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
>  
> -	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
> +	ret = ida_alloc(&rpmsg_ctrl_ida, GFP_KERNEL);
>  	if (ret < 0)
>  		goto free_minor_ida;
>  	dev->id = ret;
> @@ -179,9 +179,9 @@ static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
>  	return ret;
>  
>  free_ctrl_ida:
> -	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> +	ida_free(&rpmsg_ctrl_ida, dev->id);
>  free_minor_ida:
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> +	ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
>  free_ctrldev:
>  	put_device(dev);
>  	kfree(ctrldev);
> -- 
> 2.43.0
> 

