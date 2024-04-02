Return-Path: <linux-kernel+bounces-127460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E13894BCF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC361C21C29
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858B2CCD7;
	Tue,  2 Apr 2024 06:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8J8HsXY"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C62BD18
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040599; cv=none; b=BHiO2bx2H5xApwXcgFpmAKuMP0uzoZBd6Mn5XbN8EHozMIUtTLG5ccsYUxGsVq6649VQSHl+VJLwdK9FYSKldPTCcnQTlMY4KzjMm8ez03y39lDfN8GS3HK/gLpXNJ31j7httZLgO0M+ncqB5uWocrHU2haIvmKmEIwCBwGl4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040599; c=relaxed/simple;
	bh=eiNouxOE5/rBXeDv+m/p4E72cospl88ziAJcUPNip/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdtSkbPmE1bQE6ZxbPlPJrA5EeWbxD83TyUF6F908BqtgYO9Pn1cKS6ZX8dmqBJF1v7eYHo0IDcU+nfzCbN9lCid0tG44bvfIK6llUM8mCm/FIqEvI6VFa3eu722LDZNGbZSEfq5nSWkwRNmW6R7vos3WCZx83OwPTwJQSMznpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A8J8HsXY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56df3d94cf1so64634a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 23:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712040596; x=1712645396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pPqjVRbAXgeGN1lA/Onn5A9KAG7ZFxViPCHqpcaB3vk=;
        b=A8J8HsXYk9KkkJ6nUAzxypAba015TY1OsU7s7lvhjxw6wXEadxqAbPxq44vq0GW7AN
         fnKL9h80BeJwDQVfoJmBGUn/svzepQCPT7r7qUZOq3BLC8KTsdeziVhzq6w2Oy6lGUw6
         0Ifav6TkFJg735X4DCCuqFsySEjcI3kcYPWkXaP1AcNz1M0T7z/YxdTWLbW3rvij+lxu
         2Y8eRb7hHTDizlraYYdIT3kuVkw1UTkwfhUN8XVoQUww/HJwIb9THlL5UgpUryWRraju
         ahgsirWTAanF88K4Erq615kk/thmwxUemNzbdbrPcYVxmy95Y0Y3YIxOCFyp9nWdq1Q9
         GLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040596; x=1712645396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPqjVRbAXgeGN1lA/Onn5A9KAG7ZFxViPCHqpcaB3vk=;
        b=d9N0BjiytLzrQOpIkmMaOLKpGZfNOO7TS+A3RHUZiDuxfaaBkr0p15ScPnU9OJbCWd
         cVk0mH5AKgnjbk/jNRvkoNMtyK7H1AO0dm8j0VxftuI+Ju0fUt23BhqByf8AVGjZZJuJ
         1Er5/K2y+gTTh0lvgGQY23UXHA+86sN7OwLX4kqHlwKA6fM3InFflD5pLHYlhElAJqWg
         QoRptMollEsCOB8jsnrgeqfiO8BEh+LjTtsaucpEV7RcK6L6yv8Lg5krIMHUUFrIdF2H
         +Yhiqty58DPV8DB+HemmKN+iAzRX/5bPgSCqb+BOLjTrMamj2LRfC19jT2AxoaaGx9St
         huaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs+0CkHYeiIeGpO7RdOS9GsjW1Ei9rOwj3meYhyRrO6+c0BUtebWppk6NRGWzX8nAwpuTaFlf6IeP1orDrHAVMhGLXv5i24Owq5gal
X-Gm-Message-State: AOJu0YwKHTwVKM5hJauEHjDOV/WMobmRguqnGCuvp+Oof6vOCWkVn8/5
	8Dau5GxEKGVJ4Gd1b8B78emRnoKIDVm7ca17cI9bcPjmcFWxYToazZ57Jdf3o1vCPKRwA2x+WB/
	9
X-Google-Smtp-Source: AGHT+IGu1POPDiPVv+vHKQ69u63fSHZ3ugYq99osz195dbi2X3kVADg2wwCDwA62w7Y7hOSFs5PWpg==
X-Received: by 2002:a50:9e87:0:b0:56c:189f:cf2f with SMTP id a7-20020a509e87000000b0056c189fcf2fmr6578870edf.32.1712040595959;
        Mon, 01 Apr 2024 23:49:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q14-20020a056402248e00b0056c5515c183sm6052986eda.13.2024.04.01.23.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 23:49:55 -0700 (PDT)
Date: Tue, 2 Apr 2024 09:49:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: TaheraFahimi <fahimitahera@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: gdm724x: Align descendant argument to the open
 parenthesis
Message-ID: <56072f1a-6cca-4c11-9fbd-4081387afdfc@moroto.mountain>
References: <ZgXupx0nXwIOjy7F@tahera-OptiPlex-5000>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgXupx0nXwIOjy7F@tahera-OptiPlex-5000>

On Thu, Mar 28, 2024 at 04:26:47PM -0600, TaheraFahimi wrote:
> Mute the following checkpatch error:
> 	CHECK: Alignment should match open parenthesis

It's not aligned either before or after.  It should have been:

[tab][tab][tab][tab][tab][space][space][space][space][space][space]TTY_DRIVER_...

> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index 15c246d3b1a3..bd80cd48fb44 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -272,8 +272,8 @@ int register_lte_tty_driver(void)
>  	int ret;
>  
>  	for (i = 0; i < TTY_MAX_COUNT; i++) {
> -		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
> -				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> +		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
> +						TTY_DRIVER_DYNAMIC_DEV);

"TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV" goes together.  Don't
split that up over two lines.  Checkpatch is a tool which is supposed to
help readability.  It's not a ruler which must be obeyed.  If checkpatch
tells you to do something which makes the code less readable then just
ignore it.

regards,
dan carpenter


