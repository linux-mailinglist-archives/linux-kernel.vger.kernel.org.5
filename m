Return-Path: <linux-kernel+bounces-161447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7237C8B4C13
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7806E1C20A83
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5486E61A;
	Sun, 28 Apr 2024 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkRHzluf"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9021433BD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714313015; cv=none; b=fefXVoi0bwGQvxp5baislA9wlOKzApeSR+7t+SGPeh35GkYsJYHDHZSiIRAPuA9w4hbJbKA5EqE8tKTnmBAKRs8/ft5c/LMOgx0GBsoVCsLLKcJSEG3gD6XwtRQ+HIC2FyahG3suQXLrPSdOg9IHPH5NM5QAV7q30tA53OVOyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714313015; c=relaxed/simple;
	bh=W4Rekvj5rjMQEMyrvrDguiibMfMdswqmFgzCJjSBkmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8kdlm2f/dIiwQ8rD86RkbnbJny5sNGtqKFnhjgh/qkxLxbN7cSFbyomTUkScYWpZJyBBRhC9J6gyK5h3EBfH2XNDbnXfCyiOFnC9KuzxbeTe5TLKhL8UuTgoPInPeli8qkOadSeXIQmZAP6aP1BLsD3bFVcg0aDrRJAiM56kxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lkRHzluf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5727dc6d3edso328641a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714313011; x=1714917811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4LkwHkM4YstZ7I6Hr8RDgjhYJhml/L2D5NhBnPSk8m0=;
        b=lkRHzlufAyABx0DLN7ItkAqhki1SPKtkRhbbINRB9HUFPXIJvjB8YTXiFrcLPLXG3+
         n1uqqdvsztOm61jiu/M4IblyhMfJkq4cFXVR6RDUdiQ12Brq94nx6BLn8aB9CBCpDRdn
         8zTg0vIdb1ytcOrgRKrn0UXOPBgsh0rnvYIPZAFpI+FWSUubr4PcNVy4HuTy/sIN3ApG
         qCvtdGEsv75Sd9rAP2vit1e13jDMh8ZfRnMcnFbDPRTJ+b6BlEOZ11xbMXUokpzNbGqD
         eCxRBSGjVoEylqqbzqoYX3kwu0NRAGIILrIYQjxpKVpWRmlZt6RKKg7sHcD6gJyPG/lX
         YsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714313011; x=1714917811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LkwHkM4YstZ7I6Hr8RDgjhYJhml/L2D5NhBnPSk8m0=;
        b=psUGbymiAcSAqRqkUiqpftnlEqxQGQMdCutAPWTEfL/0UNEBT2hErtLVJ0/+rGLVlW
         l0osBUX/giEa/MNlZ78caBXTdcSzhvPjczZcuBs7oEU56Iney5q9VfjY0QYHiuoTGRHk
         DU+/ThGLD76+8Ei++AgUBM6qpy+CaTXPQ4f5NGgByjUzzZhrTvgYeL9+pf0NAQh2VG+u
         JsjNS5eqCQ7X5+85OmAzSTBVir54MVRSgLojQJAgIJGztHcfHjSiEzuEW6u7cUpQcR4w
         O5cBXMeeI88wUQxJwy4GpxbNxBagucKOMFSj8r0rfHTN5YEOAQlYr8Ndle9ZEqOTRpSd
         Fq2g==
X-Forwarded-Encrypted: i=1; AJvYcCV1HN5N8R24zapvULHIni8oYvv3GUKEOc/Na45it77FxkqaKafDHCgEyRhGusXYlaOXLvTO29F3SJ43mlBu3x35hC/AGoVJskHLzcfc
X-Gm-Message-State: AOJu0Yxf/4caUBh+SyDiMO+kTe+vBMDkX70dBdJTL8Oajaz5ipPuWjbe
	PyZ5rdUHCjQqbXI3VWBJLgedgv/Rd4Vjgllb4VlR1nlixIQDNCBfBsrndLXcVWg=
X-Google-Smtp-Source: AGHT+IEsYnfmO00nQBKypL68lPb0+Y9MZyh6Sub86JRNTqRLbUZ2ckphZO76Q5wRWKp2auF76BFgvA==
X-Received: by 2002:a05:6402:26cc:b0:572:57d8:4542 with SMTP id x12-20020a05640226cc00b0057257d84542mr4475106edd.8.1714313010990;
        Sun, 28 Apr 2024 07:03:30 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7de82000000b005720e083878sm7545949edv.49.2024.04.28.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 07:03:30 -0700 (PDT)
Date: Sun, 28 Apr 2024 17:03:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: pipishuo <1289151713@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft:fixes unnecessary parentheses
Message-ID: <ec7398c5-2bed-4121-bf95-44a7fe3438cf@moroto.mountain>
References: <tencent_FDF9E162435F21368C39AB61255D2F2C8D08@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_FDF9E162435F21368C39AB61255D2F2C8D08@qq.com>

On Sun, Apr 28, 2024 at 08:19:08PM +0800, pipishuo wrote:
> This patch fixes the checks reported by checkpatch.pl
> for unnecessary parentheses
> 
> Signed-off-by: pipishuo <1289151713@qq.com>
> ---
>  drivers/staging/fbtft/fb_ili9320.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/fb_ili9320.c
> index 0be7c2d51548..045275a9bc0b 100644
> --- a/drivers/staging/fbtft/fb_ili9320.c
> +++ b/drivers/staging/fbtft/fb_ili9320.c
> @@ -37,7 +37,8 @@ static int init_display(struct fbtft_par *par)
>  	devcode = read_devicecode(par);
>  	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Device code: 0x%04X\n",
>  		      devcode);
> -	if ((devcode != 0x0000) && (devcode != 0x9320))
> +	if (devcode != 0x0000 &&
> +	    devcode != 0x9320)


Nah, just leave it.  It's a personal preference for Greg.

https://lore.kernel.org/all/?q=init_display%20devcode

regards,
dan carpenter


