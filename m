Return-Path: <linux-kernel+bounces-163760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A13B8B6F83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253A2280CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E48C1422B0;
	Tue, 30 Apr 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ofHG1e5a"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5713D628
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472394; cv=none; b=YdQEH8sb6U8+xegeAtgifOVd1kPvNLiTANy2o5cOiKKoC3ugfeAw/t/qMo1W3CTf5HH+4Gc6bqJesqpr+LK8o/QEWogmp4qRtiSA9ajnPaALu/n9UOJ63gGm9JqteUE7vPZB6v7uBoAYteImYf0NP0bNd/L857LOLke40/BJ8PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472394; c=relaxed/simple;
	bh=AaoNuMQr7wfwWhIydrl39sw5dNrBWXxRwOatOXO5Gyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi9LTF3TAG875ZaXXCw52KGnFwcJ7DPnl9+vZu+zndVUORMYY+LlBbt8lyVuKVFfePbqTBWrdMFIaIIH93IDTSJjVYX5XJBocMkn6tnVAe7Xb0zyqwOUuPyFrPSlydK7E/3jorTv2ayjZvE5kvVMvuAu9POrBokTeGaCFsfZ2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ofHG1e5a; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5176f217b7bso9625249e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714472391; x=1715077191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi+zY4jrvA7etE5aJ4Zb1R79uvZhxlcK87yfMIoJspk=;
        b=ofHG1e5aVVQfIQEg61mcPjd7H6UemWv432Pgi8NYazUVne/0k+9esbA047OQj8puav
         TIdeRBqXAEz/Bjk/vj/GqbV5QYoE9oAZaa3A57ZwDXWGMduT5PL+308xiZkbrdxVGDZk
         66lOYv80T2XLOWICRG9DHdk2HGW7G01P7VDlyOJ1MGujs4yilajeUtKQWnbYUk0Fn74v
         VOYQhCC2jxTdR42NukNHGaxqlr9Dovct53xARj9BybBjBpCZTeLV1i8AHMrmuUNMt2Af
         rgvE2LHkbDcsUnQ2cMrWav6PiSNLD9y2/kJM9Ko3yUni4EyXfDVl7Jugn70dxzs6PZxj
         NYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472391; x=1715077191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi+zY4jrvA7etE5aJ4Zb1R79uvZhxlcK87yfMIoJspk=;
        b=uE5qIASVjnua4bmqR1tCgHduSRYjq5Aaghywt/lVoNHUJE13VZ0zZV1KSHNiTPlZpc
         mQ5Vg6c5lSVLMJvFRwji4kql2Qt6V0djhS0n/eouPZB+ryEZyCsZf4Q62s6FG4m5hL/0
         2k9Yx9z2hcmMs1wqsPIpo8r00bo24eNSCXpqIXnR8P5nR6R/9YjcpEN7T/D/TbEmrfWZ
         DvVHroY6DVefKvNMn64u37DVBQeiadkw7VU8r7jzMROrGIAaKtp9h+zN+yprvp7ZAoX5
         E+/+Abet9IkK+lCefzzrvEJdcoTV6pbc9l1XkcNOUZjpPZbuKL+vOv7G4gJitGXRNs2C
         djnA==
X-Forwarded-Encrypted: i=1; AJvYcCVg4DtxANTZE1ekjVkWMk5mi/ozyyPoR9e0ORgWOr8M2J9dGXG13m1pFPTQNmnybpyEZM6e99AFAWQqXAmpCqSOdiaePnSkH0I+hYoK
X-Gm-Message-State: AOJu0YzjG8pzA2juBw/BOID3lEgYkHrSdYDwYtFuoMWIM+IXU8sxTZJo
	ewRpKeyrrjs5FMwGdfHLmup3qG7eXHxx1aom+QV7UJnnzhIgUbE1RexxHB82d64=
X-Google-Smtp-Source: AGHT+IFivDvhkvzdK3js9J8r/Omj4m9EtI36Z7K6bKiY8IRU1gTzJE2IoEcCjop9Y8xeDqlTpaY03A==
X-Received: by 2002:a19:6907:0:b0:51c:1657:b04a with SMTP id e7-20020a196907000000b0051c1657b04amr9624458lfc.63.1714472389353;
        Tue, 30 Apr 2024 03:19:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id e1-20020a196901000000b0051bc10ea8ccsm2520317lfc.38.2024.04.30.03.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:19:49 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:19:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/3] drm/panel: ili9341: Correct use of device
 property APIs
Message-ID: <oin54zqdhrdp7glme7te6yd4yoddwqkg24igzktw6lg4toh7t2@lcrmkwmujjpq>
References: <20240425142706.2440113-1-andriy.shevchenko@linux.intel.com>
 <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>

On Thu, Apr 25, 2024 at 05:26:17PM +0300, Andy Shevchenko wrote:
> It seems driver missed the point of proper use of device property APIs.
> Correct this by updating headers and calls respectively.
> 
> Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                | 2 +-
>  drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

