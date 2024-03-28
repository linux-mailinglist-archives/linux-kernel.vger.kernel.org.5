Return-Path: <linux-kernel+bounces-123012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5685489010B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B223729851A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E6281737;
	Thu, 28 Mar 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvhIG+G8"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282C17D417
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634604; cv=none; b=QbF79HUh3KBJF9/lAshBuA5lXu++/HLHCPjfgxzrl9v/srRNbC4rJcJ9ISoBch8Tv49RPOOj25yzZqZl+u26WZeylV1WiDzU8TcJdPtpIlNi+tk3JYATwQsGSZxjoILhegWNZPijyOYZrSvmYWmrJz1ci8rP3yVlesajNa6X+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634604; c=relaxed/simple;
	bh=1CRhwGIJSKhMbpQ/RBExx1bECy0jy3gMQ+/TAbtgpUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSwLA0tx9QChQD/rv4bjVzUZ80Rk1yuNQILQF3LiFrVQF9jbg1+W6MG27atfdNS53isBmM7Yl3dnbtJgb0lad9WA5rKsKS5epsg2wLU4Lq35A43kmGTyi1NcSiz6sDwtPWKmZx+7/qqvsfHFC8knd87vSk6auoBXsunrU4XeEIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OvhIG+G8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so1226875a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711634601; x=1712239401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sKGYLNVMGXVEBGiVnvjU98J22psaopjpEMp6FYlRJU=;
        b=OvhIG+G8M/PBoly+ggOtEA+9GvmMtXLnLwpjJYt++QNLm5CYTdPIagM6P6GpKuBNkf
         pk7byB2dVlr5rFBrknb1RJjpMvI9OxSIVRwM73FzE6zZ73VTENFELD5DIQ72GgmqnwX0
         7hvs1AyK3fHxMe14knOsWxEsC/dOcaY1wqX40heIzWG/49Cx6WlQ8FSTkub9n71UcUr4
         q+NhaB1OMQ5uV6BJTQLTrRMFW/n7XeK4zj5ozj99pJftcPgAZEuyedgszQZpsSYpDwHM
         Tg4LB9Gr0YaxcA/BKD15WcPgX1BNPhw6DM8WFvuviSNr89PtX3BlOdmCf4FTohyuQWDA
         8AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711634601; x=1712239401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sKGYLNVMGXVEBGiVnvjU98J22psaopjpEMp6FYlRJU=;
        b=FY41tKFcZ2E2wtdIaYh5cozsd+fAGAxYfRl1dOEbfEDQEebentTq1rVMPpYeM4YWXM
         tIhFUvRsZbBR/s5sKPz72LqsFdhSQbyfwReggwnjKyUop3rIYM4cH/qq7rYbFsb2ROla
         dntILJvMMU18uNEUhMqY+4INV65T7FW71ef5sZbuTYF+ZJqh5OkSQsb8GfXfqBhLaRwP
         ax+36nzeTiOae/yrE3UbLnX6isZTiGkuVRhsxcMYKcXl7X5MftZxNCTMsvaEq4uIi6Hv
         GrpTfi8LR647krt3PW/IN8mQsRFjVHRsFsOQ9b4+TI9mleVVJxoUaKDuLSt/+QSTOlIG
         x72A==
X-Forwarded-Encrypted: i=1; AJvYcCW2kt1FgA1ghqPSaAnyT4+LGbJZJuT4Su9/wEGiH3vSLfZo7LbniUgeF2pfIdImfEucmeT8RoLoR+n/ibsPVz+4MpIRaXdPP4iUTeKw
X-Gm-Message-State: AOJu0YzMGyRCjokskMP3NwRSbH6baWbbXCIWta6SA9j7tCUI1U3W9t2V
	KMRo/Dryt2Mf6I3UP7fm0rEjlQ88ySyAFuRhqmGE5ZI9TJRA3T/mND1+ybJ2cOk=
X-Google-Smtp-Source: AGHT+IFCInzZpL9neFPC+ou6pgAku6KUY9RgTMC2MkaJLzHuJMtbTOz1CQwMNI0J3x0j2Qa4AC/izQ==
X-Received: by 2002:a17:907:6d1a:b0:a4e:1ff7:5c79 with SMTP id sa26-20020a1709076d1a00b00a4e1ff75c79mr1982741ejc.14.1711634601273;
        Thu, 28 Mar 2024 07:03:21 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f5-20020a1709062c4500b00a455519bcb3sm788519ejh.55.2024.03.28.07.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:03:20 -0700 (PDT)
Date: Thu, 28 Mar 2024 17:03:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	felixkimbu1@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] staging: pi433: Remove duplicated code using the
 "goto" error recovery scheme.
Message-ID: <9c5b4159-da26-49d8-9682-445c01b19a51@moroto.mountain>
References: <20240328121244.1244719-1-ikobh7@gmail.com>
 <20240328121244.1244719-7-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328121244.1244719-7-ikobh7@gmail.com>

On Thu, Mar 28, 2024 at 02:12:44PM +0200, Shahar Avidar wrote:
> pi433_init had "unregister_chrdev" called twice.
> Remove it using goto statements.
> 
> Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 62ce75b07bf0..e538f1d4e787 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -1400,24 +1400,25 @@ static int __init pi433_init(void)
>  	 */
>  	status = alloc_chrdev_region(&pi433_devt, 0, N_PI433_MINORS, "pi433");
>  	if (status < 0)
> -		return status;
> +		goto fail;

Just return directly.  Do nothing gotos are bad for readability and they
create Forgot to Set the Error Code bugs.  Also there was a direct
return earlier in the function so it's better to do things consistently.

>  
>  	status = class_register(&pi433_class);
> -	if (status) {
> -		unregister_chrdev(MAJOR(pi433_devt),
> -				  pi433_spi_driver.driver.name);
> -		return status;
> -	}
> +	if (status)
> +		goto unreg_chrdev;
>  
>  	root_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
>  
>  	status = spi_register_driver(&pi433_spi_driver);
> -	if (status < 0) {
> -		class_unregister(&pi433_class);
> -		unregister_chrdev(MAJOR(pi433_devt),
> -				  pi433_spi_driver.driver.name);
> -	}
> +	if (status < 0)
> +		goto unreg_class;
>  
> +	return 0;
> +
> +unreg_class:
> +	class_unregister(&pi433_class);

There is a debugfs_remove() missing.  I have written a blog that might
be helpful:

https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

regards,
dan carpenter

> +unreg_chrdev:
> +	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
> +fail:
>  	return status;
>  }


