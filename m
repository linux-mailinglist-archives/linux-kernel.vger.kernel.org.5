Return-Path: <linux-kernel+bounces-165355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 137038B8BA6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927FA1F21A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BC112EBEE;
	Wed,  1 May 2024 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxncufKD"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103B12E1E0
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572394; cv=none; b=ki0TFYFfCGfeRJxo9bO8+kTiPWSH8pe/Swp5w3j8agu58gSp/rc50Gf61l7aglXd1dylWBd4YyRfZc3lxOOOmeIRuLh/9YsTJAR1SsMrDBvBFUNLFwzIn4CPNoaDjV8VjxBoXEGC3niBk0FhJ73lYri8BtiAXMO+W11uPU123oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572394; c=relaxed/simple;
	bh=ap95sRSBchjF/M6qtGbRKOjwOWiqypvpzG+i+mqKGuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ1Bhc2x2OaeRx9s2To+ltXsv+3cRIBIVm5IB8Xs51pzzCAiCdgm1v7HUwWbWD24N6/prZyZD7oFBMcoV1LmoopqxvFFoLWLlft1ZvdD07hEqyPyY8ddJXR3oUn4J2JUmHPYnzaVLpkgGLXuMqiYnCX89wmQ21jpaj3pQaB4+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hxncufKD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41c7ac71996so18412105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714572390; x=1715177190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dZfz70z0T6WsL8T1SfMzUnt6nyE7+lsRqawb7s4pzH4=;
        b=hxncufKDvRZVxhP+ZkjO9NNN2/fxki+Rc2WhK3FyMsQQ/LFlD/MifE2OeQsZPduw10
         B3lvgE9OOtQVszTzEvFdT/TzL7zXqyBVncHILmccxXWv+KOQqjjOF+QyafPj7Jt/qZt2
         5Kifi0UeUQXfVzjDBoj8Qjte3CXDlwCMD4992qeQ4zW9Oh4NcsK5OgzPVAWv9mN8GbtY
         Z0nrO33uTD9qpn/EwiL8thWOMN55VLOenVsTCPPJ1jZ9+INdT5q90en30ySTD0uFhWoS
         Zvmk+F9MvRWczSj/OzARYndhsbhBRNmiZJmKlqAQZGM3GkIjolJ4IUz9i/sm+IkepKzU
         0x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714572390; x=1715177190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZfz70z0T6WsL8T1SfMzUnt6nyE7+lsRqawb7s4pzH4=;
        b=Ro/liG5devBOL/7eZ2JiokPA1bSSascvIL0S+2YrNLO50woo6OvZ+POJsF8kZNwPyo
         zcYWfh7Nta7HPOcUK7/CHf+jod6e4Was7VRy2OvF9L/UyxUSuaXq7cWY64rZCsMIYwIz
         a8buCKArl7l3ET7og+CDy1QKbdA2+x8kiTGmASpu0UZ3nZq7nQ97JI+yAas4aezA4q8S
         dbcVLIeT2Knv7yyvL7Ulc+5fJSVtMVHMlhQFhX7iVZUKTdxNM/simG2WeFPWCkmx2Jul
         9e3nN3puvUdqeP/bhIE4CUFKKoZoCqw32tL4+wA4MYKxINzcvIyoFXqLrbDIAdwI09BB
         R/sg==
X-Forwarded-Encrypted: i=1; AJvYcCXZjy97rxCRljK1Xirmzvy49U2lj3kn1zscBc9d+XLK/ayRQceVnBJ9/IcIB4MtHBL75ROxQ2VDcJn9LZT5MMtuGg8jHiBx0tSNwVwD
X-Gm-Message-State: AOJu0YzaLq0y8H7Y5YoxvHdR2Z8ZbosJOTfoa/bHN7tbUHXJaDd2SkFW
	m1FKesSL9FWAxMGFNxZ2W1LyTNxsFpfgGS4kfZZw+Gx9L4hRMI188F6HsRvIyj8=
X-Google-Smtp-Source: AGHT+IEiNaR5Cn/+ooprU55AdeahgioYEMn15o+8Mt5SBbXilTTmivQUVQe66a+zwqBUsYT+P6+dsw==
X-Received: by 2002:a05:600c:458d:b0:41a:9a6a:41e1 with SMTP id r13-20020a05600c458d00b0041a9a6a41e1mr1846593wmo.29.1714572389827;
        Wed, 01 May 2024 07:06:29 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id i14-20020a05600c354e00b004169836bf9asm2306123wmq.23.2024.05.01.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:06:29 -0700 (PDT)
Date: Wed, 1 May 2024 17:06:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	felixkimbu1@gmail.com, krzysztof.kozlowski@linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: pi433: Rename goto label.
Message-ID: <3005db51-58f7-4247-a37b-02933767f644@moroto.mountain>
References: <20240501055820.603272-1-ikobh7@gmail.com>
 <20240501055820.603272-3-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501055820.603272-3-ikobh7@gmail.com>

On Wed, May 01, 2024 at 08:58:20AM +0300, Shahar Avidar wrote:
> Use destroy_class_and_remove_dbfs instead of unreg_class_and_remove_dbfs.
> 
> Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index c8c1d296184b..4fffd7007040 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -1409,11 +1409,11 @@ static int __init pi433_init(void)
>  
>  	status = spi_register_driver(&pi433_spi_driver);
>  	if (status < 0)
> -		goto unreg_class_and_remove_dbfs;
> +		goto destroy_class_and_remove_dbfs;
>  
>  	return 0;
>  
> -unreg_class_and_remove_dbfs:
> +destroy_class_and_remove_dbfs:
>  	debugfs_remove(root_dir);
>  	class_destroy(pi433_class);

This is cleaning up something which changed in patch 1 so it should have
been done in patch 1.

regards,
dan carpenter

>  unreg_chrdev:
> -- 
> 2.34.1

