Return-Path: <linux-kernel+bounces-27380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D93482EF06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2E41F23D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5BD1BC2B;
	Tue, 16 Jan 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSHuHUi1"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F7B6FC5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e80046264so15502015e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705408292; x=1706013092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT+z5kO7NZ0JfHwGBIqmnXCQBjLsapUuYK3PYHhWBbs=;
        b=JSHuHUi1WRIxLVeXXtfdfW/Hxah71RjDE67142Ymip/DuBVC2LdPS9CTDqEKLcvV9m
         awSkL4pqcv+XVP2O90ASIaIn2VaceBsfKok9bdon4bAiCPU1oZ60V0BZnigqHN7V58tD
         QRR4L0mHiO3K7z20UF7CUgBlOyLiqWUIH/v+SmjKVycClpf4N3BGAxw80EZiB3WRQ1ZV
         /Lf8CQDeWytc57np3dQGDQeOZezbV8+ihTwYpr3t5wOlMiauXl+cROD6IbqChJp8SMMN
         XpQ75YfGMx1jBgob0h1V7Mnk6VCtKAkln0dtk5CHXwRIDUybFkDcZkCEc31dJhisStmx
         ObbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705408292; x=1706013092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT+z5kO7NZ0JfHwGBIqmnXCQBjLsapUuYK3PYHhWBbs=;
        b=s8sMAC0p4KDf5kXSknwuaPNVMDbGo8h3bb54AlIiPxG15EjQKIY+YcjshclydnXBWZ
         eT8oNoqwrmAMezhVBdDiUZeS5gfnR8bO0Ld927qb1DyMsw7cdc0L8c6t87iRby4lQjhB
         RdPetGaQXKAcEtGvB5ku81/+wPlh2NL+pASpnKFjsHoBL4iw+LYNPoKc6mxVJArYM/FO
         xVmTn/mqbb/2KVGIqxwcNxslsRtNUjSmN0uc6hZNjy/NKwouCO1wkR8gInJIerCyRZ0S
         nOAexzC6rQ0r2RjknNblccsJ39WesVRuLZ0meRCwcplTp8gU2D/ydMF2N06S9yLq1UWG
         xn2w==
X-Gm-Message-State: AOJu0YwMft3fcDAyMkUaXS2NfrhqY13O9kkR32Ge6VUEm6EGxRkga3Gj
	8woLZ7W3lbkp1yR6/Zq/QCMJa9lQwmWjMA==
X-Google-Smtp-Source: AGHT+IEE+TByEl7XVOYopKpmNFuQHPmwYwCI1LrdzsQYzrF0eXV1Q8x8cWXCEoLTXlRQR5WPDNP8Hw==
X-Received: by 2002:a1c:740b:0:b0:40d:8815:afff with SMTP id p11-20020a1c740b000000b0040d8815afffmr3913595wmc.39.1705408291854;
        Tue, 16 Jan 2024 04:31:31 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id d15-20020adf9c8f000000b00336c43b366fsm14493657wre.12.2024.01.16.04.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 04:31:31 -0800 (PST)
Date: Tue, 16 Jan 2024 15:31:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau/fifo/gk104: remove redundant variable
 ret
Message-ID: <aafe669f-b322-4f22-a48e-564e3eb3447f@moroto.mountain>
References: <20240116111609.2258675-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116111609.2258675-1-colin.i.king@gmail.com>

On Tue, Jan 16, 2024 at 11:16:09AM +0000, Colin Ian King wrote:
> The variable ret is being assigned a value but it isn't being
> read afterwards. The assignment is redundant and so ret can be
> removed.
> 
> Cleans up clang scan build warning:
> warning: Although the value stored to 'ret' is used in the enclosing
> expression, the value is never actually read from 'ret'
> [deadcode.DeadStores]
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nvif/fifo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/fifo.c b/drivers/gpu/drm/nouveau/nvif/fifo.c
> index a463289962b2..e96de14ce87e 100644
> --- a/drivers/gpu/drm/nouveau/nvif/fifo.c
> +++ b/drivers/gpu/drm/nouveau/nvif/fifo.c
> @@ -73,9 +73,9 @@ u64
>  nvif_fifo_runlist(struct nvif_device *device, u64 engine)
>  {
>  	u64 runm = 0;
> -	int ret, i;
> +	int i;
>  
> -	if ((ret = nvif_fifo_runlists(device)))
> +	if (nvif_fifo_runlists(device))
>  		return runm;

Could we return a literal zero here?  Otherwise, I'm surprised this
doesn't trigger a static checker warning.

regards,
dan carpenter


