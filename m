Return-Path: <linux-kernel+bounces-163762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE98B6F89
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65B9B2101C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1BC129E98;
	Tue, 30 Apr 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kAfuh2d/"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3943FC02
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472520; cv=none; b=MSCfdwCP6TkfEj1wjtrym9R5amP/ghirV7kfeUVxDOjdtsAzAzonNa+lTc1jJXPgt/sf6QGoNXXGePZqcPI4tiLt1xyMycEjFsRlITLlPIEh5NTzsOQb8JzLVm1hjlTvruM3yrMNPsghZ9QJHZm9UtT/szocroIpNLqE8Kqq+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472520; c=relaxed/simple;
	bh=tgm30x71yKw/vDLwvaQ+wGBwr+GM8nm47x2MQCtOytY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghrtU2+tXWE26P909GW7bRkBULhENqu2jX5e0BCpwoem0XCNzTlxnTq7N24aSGs951H0MZTpwWGGdZ772+ByI6PH0p80WJoJUjBN6DLVOmOaIGJ+87dkfV5Hmmw5KVNdbZAqNjGfRfMWToF9IGN0ccMhBD3/dG9nASqvgmymADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kAfuh2d/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51acb95b892so6769589e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714472517; x=1715077317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT01Ki3TawfQ3ig4lt1wnzEPfhDo0Jb/siTeqh9G5lE=;
        b=kAfuh2d/LuGWtSjBKMtv8EXnbkjEl7grGbAm7/Yx5+pJr9TzEEHfcbH4P2SCk4vUKS
         lPB7wTqILpeItpfefnBXCK7Cx8cR27D9QiLRX5qfqDVPBVFT0HetxW614pBrb6FT/9rG
         lg9x6yMeiT8li6PA6OyoOrL8LGsePss6+u9ujKDJugfPlu8LPWQNS+oyGAMAkKny5vpm
         WWKWEPvM7O1ULEVMWsoyRzhXQN5HEbU+0KA8nMSs16y8cucP/S/BdTsu8NzPCgnSQ7uB
         +RbhNVRuzBlP3T3NpCFDgB6S94/jmFkDvTO2N/7x/uQ5IUR3gai6rlGO2rrUxKJfJAXR
         985w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472517; x=1715077317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT01Ki3TawfQ3ig4lt1wnzEPfhDo0Jb/siTeqh9G5lE=;
        b=tttg1eTlrgkvpStV5rysxnKVyZ4cCTW5V6HaQIj9psbU+nlBGWVAid6wjt5udhOUHb
         0kIx95VsjH3pM6XSNOVt3om7xcY0JVSisMJfA9WG+pr1ouBI+MoYAui1MZuQG/di382Q
         GxzZfxR7k3H8U3iU0KB3KzsOb0CnboPbey0xjhRlFyDyffgHeCvzKyah0nB5YoKfaIlC
         TF5bd5BrF8UyeTLf7TaHwMNswLlVfio+27Q2Jy2b0mmvhOvRXMJZx5ewPT8SwlKfJXKx
         XBqs7z/s3jjXQoepV9twCkDBcXAdJI2fmgQJaFbVVRdzg3A0dfenh8DKCUEU0bxoJ5bS
         1qoA==
X-Forwarded-Encrypted: i=1; AJvYcCVFSQBm/0o+9hfQwH7aA5swacOCt8/CtH5KUF/50Lt5D594wyV0sSCxa0/yT+tv6OWnKEnTOLx/3QhYT3Am7oOOBKb46jSesr+gMfIp
X-Gm-Message-State: AOJu0YzNNcKbgnSG9OFuIjaKfAWrWfa3tcdf86QRAjE2rSaEVnIhBr/3
	45lp51r54/uGZnax2CtybvSA2LV4QzeeVmWKLnw7dxKRsW7LQaXRTSbk51IJ1HM=
X-Google-Smtp-Source: AGHT+IFcCOuX6QEEljjpvhMiSZt5CExqyrWGa7Y3OF0CEbw6Gv9K9DYV5uUKU5rAI7Mcf9Sx4WpE9A==
X-Received: by 2002:ac2:48ab:0:b0:51a:f48d:7b31 with SMTP id u11-20020ac248ab000000b0051af48d7b31mr9463882lfg.13.1714472513855;
        Tue, 30 Apr 2024 03:21:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id e24-20020a196918000000b0051d913a3695sm845676lfc.182.2024.04.30.03.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:21:53 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:21:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 2/3] drm/panel: ili9341: Respect deferred probe
Message-ID: <aaizdoc5ct4ktn3owbg4woexenao4h6kgn6chg5mjusm4aoy5i@ajwvvl2tzknt>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
 <20240425142706.2440113-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425142706.2440113-3-andriy.shevchenko@linux.intel.com>

On Thu, Apr 25, 2024 at 05:26:18PM +0300, Andy Shevchenko wrote:
> GPIO controller might not be available when driver is being probed.
> There are plenty of reasons why, one of which is deferred probe.
> 
> Since GPIOs are optional, return any error code we got to the upper
> layer, including deferred probe. With that in mind, use dev_err_probe()
> in order to avoid spamming the logs.
> 
> Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

