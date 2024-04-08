Return-Path: <linux-kernel+bounces-135628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DB889C8D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F6FB22E8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F081420D0;
	Mon,  8 Apr 2024 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rMq3Kl+p"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012A22091
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591567; cv=none; b=L7qnRqXLHX9jpoHV+f1Fpfx4FSr/gHt/zwni1bBF3X9RDwT2W0cuDXpRdyhUIwXosFFwvNQHwBxfRiZtFhfeh8lyYlRahv5OxnCqMRI96h7tTdqE2rQWon5gMK2jmd4XuFvD4/SaZIsrblVHKUvu/6yQ3VzLQCDAYKMFKlsg240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591567; c=relaxed/simple;
	bh=/Xx7sV+8iGsyhALy9s1bcJuSJKc9niXK3R6ezT61ZCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sn5rJCrQ7IVVW5mFv42Fb9UQ9wcNioAhViwtro6VImxl9pweNE6FStm1cYdjAsw8RPQjOnGKeKWuxAmcFgl5gnHRCUNyt/hyr64AIlUL8otMOpSS/c4tvbtWhrwc/o9js9XgNh0yHx4dsPBOjJ4/HEClCkUE5PqXlALWN97PG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rMq3Kl+p; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-617d25b2bc4so32243087b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712591565; x=1713196365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SxkgeoQeNIUqrwLW13ZD9YQozaM7Suz5SGdkew/WCbg=;
        b=rMq3Kl+pNqCenxgO3V4SC4OVX2isbu0ipfR/58aXRAGG2PXnOaFilOC+vdQEvw3igo
         Hll1ZPfFKSsP42W4rk5QyPUHjNZVk17V7V/R2Ywq7oZOcvGK7CcQ8+hsorfrX1aofUES
         6VhlcUJ7Z+3JidIsCpadEashASMpqROjGiu+QWja9IEW/An7WvsBMchJwTnSQXHWbJWV
         Om79NxSjyftGgLQ89d/tFSXtcdncJz6bUJDZqDKLSba9D8RfDns5PIfjlNKAdzznXP2l
         +kl+2/s4amuMNq/00w9BoGnKBHNqBjcOBXqmQQMkYrzmf2k6G4AMec/LCvjCWi3jbP4e
         km2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712591565; x=1713196365;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxkgeoQeNIUqrwLW13ZD9YQozaM7Suz5SGdkew/WCbg=;
        b=CkchQYA6N7529lROi0zp7AKMkbVoJrUNWGLYnpveEHBB1ns7OR8PQgqeHm8V3sId5L
         PwKoPMhOTiA8Eb9mqikcJTUkrmtiYgTi4uKHlZ04ySVT7tXJiyhJssPSgn55uyTPbJBt
         5MbBK5jj/etqGagbbBS1zj/O4Qw88tEE9WIuoFHf29Vtnv+07XV1AsxzPjgM7veQDwRV
         aDHe/Lj6W0oJKJumYKxXQ2AXxxwX38GGm486T03XjmJLcCoo8nq55CNjeD/AbX78ozxC
         njQtBpFhuSVNFFihYVuIeGPpTZDLza0guELJiz311UwMMS2LWXSym4Sose12M9zSJ6i7
         v1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXFcOuwdAwWSuyLRn72hS3QHdVv23Sy+l1emW5/W4iTOyAUqjLskHrh+qBSxS6EIBUPhunccLZCOgMACpP2x8FUTRjXrL1OEdDjv/zB
X-Gm-Message-State: AOJu0YySGyM1PYgi8A54VA7+0Xg7xjbuzAjN25Fda6Nn9BYusnk4NqvQ
	B/BFcxeivNpmJvTsqkAGMMHqxl5VLkV5kKSLyHLvqm5e02AJmMGRAp+awuoP7aBfLUyOIjHFi8/
	BuG0JZCD5cRHaiyUOMF1LJaM2pa5zB28j6PMpOg==
X-Google-Smtp-Source: AGHT+IGLnzhF0iW1cRj3Lg7cS9tUEIYYBj/O1ZdALYq3I/dJY/JXan3cwHXlFh2yn260/WHV8LwCOmumQG1gMmtuhu0=
X-Received: by 2002:a25:360a:0:b0:de0:e368:fa59 with SMTP id
 d10-20020a25360a000000b00de0e368fa59mr3976700yba.31.1712591565113; Mon, 08
 Apr 2024 08:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304175152.1199270-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240304175152.1199270-1-andriy.shevchenko@linux.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 8 Apr 2024 18:52:34 +0300
Message-ID: <CAA8EJprDxKSkL=OgmAqR_4cFBYGo4tnDCE8nesgTAaYg7rYL8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drm/msm/hdmi: Replace of_gpio.h by proper one
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 19:51, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
> index c8ebd75176bb..24abcb7254cc 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
> @@ -5,8 +5,8 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
>
> +#include <linux/gpio/consumer.h>
>  #include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>
> --
> 2.43.0.rc1.1.gbec44491f096
>

First one didn't reach the PW, let's try again:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

