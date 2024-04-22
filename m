Return-Path: <linux-kernel+bounces-153439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8063A8ACE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B641C21235
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58314F9C6;
	Mon, 22 Apr 2024 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BsOYc8kK"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7914F13B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792347; cv=none; b=tiyqtHL4USeRJBOhuYavtfmeve/H36VZ036PqpjRkfIH13qIeuaYEUq2u5qRigjm8CdSdr2ivjBcYB5Oz8pRbxeAg9JyPRfCg98/reHpCBFC0IsLFxgILbwz319YL5btplbwgADce7qM/dml6pzPmDrTxuYx1EG/aMiSLrlVCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792347; c=relaxed/simple;
	bh=p71XPOYccBTrK5vNtFphHMc7xrNQr0V9gF4p0adc0z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhJoDuOSkDrxjzeA0ACsvQbZa5ok45dCeV1Au8KhzBA/bwaArtgWl/sHqWmoJkok3MoGY9KGpp6JNi1yZiEScKP7ldowJcUxvf/fJBQIZMBmFZVfOgnMaYlSGPKGuPzMKN0Acb7C+i68xFTlQ4CHchlUbq6Tbb4IDM1UG7/8mUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BsOYc8kK; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so23068661fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713792342; x=1714397142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/kyPaZIZyrkWqjj0WFiDLbAxvb7aRYR+HuKJ6/NuUGw=;
        b=BsOYc8kKt4Q6uNuwgGExl66dXM2B7nHDi9znqKlCDM1xhyaY4GGq+rOS6yzCDIotqL
         ftlx2KiA30tjV22Ru1eKbG0OKrLeJtCm+kei7BUh/BG3oscuBDl/TRr706tHK0ZplkDj
         PRzKs31GOkjZ32RDjU8k4YaIfM/QGEqCkaQ3iUjY8eTsuPJ84m/eTzebnxB8mDvz4cH9
         m6ItnrkWIwxuVkprcKBqtFMFqzCHFyHfCmjaiT+h1lkMt8i27mLPVCQBLEi8qS+rbeuB
         S/1mL2ta1j+EhvrzY0yLQmLXWJmfJYPQkjdG49py3a/0wMBMUf0GRBEKl2OFsi7s1ABH
         Babw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792342; x=1714397142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kyPaZIZyrkWqjj0WFiDLbAxvb7aRYR+HuKJ6/NuUGw=;
        b=Y2T+EGzfkX+afKgZPasH9vcSbLgXzYPXDWwljKvmHhUNPvngpOymJvcUrs4mDaBVz1
         ctGHVuT1ke3VSNVMc/jxOHUUac81Q1M/kRPVj+c8mLKhaJkmEUZNjN61INk4tRvzFJFa
         p1zUpsnUaTPumGEx7wPnOqVsYAwQf2eMQI731o+PuvVLVKS6dhigQA5Bws3Oo5EvHbH8
         wubKG8oZOK0W4iDPkeP1wm1gIGaUmxqhpAMnVvkM84ynUjV6AfkqNAjEUqW9RzNLKfL6
         GHscvkqUFC4YzgwnOIHTiXfxkkXJHuc7l2UIbK5JIjGKkuzc6E5LpnoXfpDgccrdUjFT
         kxPA==
X-Forwarded-Encrypted: i=1; AJvYcCVkiUiQp5afKkyHPm496NwObaGkg1ogvXDpliu++3AAha4IdOTbvbQEUtr8tipV7lNJEYG57sW4WLK+7NWE0AI93Sk61jjtMb/zbi4b
X-Gm-Message-State: AOJu0YxFyJjsGT5nqKymLb8a+MBWbm6zkE14me4XlQJiuYORErTIm3yL
	fH9CZ32crvScEYptUO6CABrnnV0SsYCuEKL+Hq0LyYaFw1UMoOveU9Mv6pSXI+A=
X-Google-Smtp-Source: AGHT+IHWET/ZymKfhlPZrQHfC2dJ8JbIntynRS8qE8Jm7h5ARJyaDMzXxiK//kI7R+cm7SauaT3FVQ==
X-Received: by 2002:a2e:9d43:0:b0:2d4:6f33:2e59 with SMTP id y3-20020a2e9d43000000b002d46f332e59mr5822818ljj.30.1713792342161;
        Mon, 22 Apr 2024 06:25:42 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ef9-20020a05640228c900b00571bde3b0a4sm5246522edb.34.2024.04.22.06.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:25:41 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:25:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: A <ashokemailat@yahoo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging:fbtft:fb_ili9320 Removed redundant Parentheses
Message-ID: <9baed766-a2d2-4b94-ae2b-d16ffbea3f67@moroto.mountain>
References: <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel.ref@yahoo.com>
 <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452e4a2dcdc7020f75b84d787297a1d17a21ca81.camel@yahoo.com>

0) Fix your From address.

1) Look at how other people write subjects.
   git log --oneline drivers/staging/fbtft/fb_ili9320.c

On Fri, Apr 19, 2024 at 11:04:21AM -0700, A wrote:
> >From 51e98164e314a2d1d834d2a9baea21a9823650bb Mon Sep 17 00:00:00 2001
> From: Ashok Kumar <ashokemailat@yahoo.com>
> Date: Fri, 19 Apr 2024 10:32:48 -0700
> Subject: [PATCH] staging:fbtft:fb_ili9320 Removed redundant
>  Parentheses

2) This should not be part of the email.

> 
> Adhere to Linux kernel coding style.
> Reported by checkpatch
> 
> CHECK: Unnecessary parentheses around 'devcode != 0x0000'
> +       if ((devcode != 0x0000) && (devcode != 0x9320))
> 

3) Just leave this as-is.  Ignore checkpatch in this case.  Greg likes
   parens.

> Signed-off-by: Ashok Kumar <ashokemailat@yahoo.com>
> ---
>  drivers/staging/fbtft/fb_ili9320.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fbtft/fb_ili9320.c
> b/drivers/staging/fbtft/fb_ili9320.c
> index 0be7c2d51548..409b54cc562e 100644
> --- a/drivers/staging/fbtft/fb_ili9320.c
> +++ b/drivers/staging/fbtft/fb_ili9320.c
> @@ -37,7 +37,7 @@ static int init_display(struct fbtft_par *par)
>  	devcode = read_devicecode(par);
>  	fbtft_par_dbg(DEBUG_INIT_DISPLAY, par, "Device code:
> 0x%04X\n",

4) This patch is corrupt and will not apply.  Read the first two
paragraphs of Documentation/process/email-clients.rst.

regards,
dan carpenter



