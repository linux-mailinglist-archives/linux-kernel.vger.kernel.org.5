Return-Path: <linux-kernel+bounces-117127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590BE88A79F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDFC1F66AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AB813B293;
	Mon, 25 Mar 2024 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xcZYgWo6"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1914D42D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372732; cv=none; b=AGeGDGwJT6F9Aa1eu0qcf68eanXyhk6qxy0nBIUcjMfeAzcEkRbYcGQlaUpL3DAt4Pa5nUAS6iLycFUr5HNJA8C2vbs1u94NMtNreFCy3qO9vSeSjn0RSp/WfNE9/6sCWLWFvFprNidD6ucdGHuHm+wGULCzdoSMygSqOcZUfJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372732; c=relaxed/simple;
	bh=n3k0iYRKHsrgv7l06dQ8fzZi31Diqx4FQuGjvbP0wXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Md1JJBk9slWkxVXQcW3/V1tKLYkIabWKv4ZTsJG0N6TOJrVkNnWL43bhMwH/+8xoMV0cr+XkTRCo0k7xzGWm/bZigVFE2S1t9dOVen2GMlU3s2DIs/+vjwjiRHfhq9R5GpPAWA/IPIbt1eJzmU37iAIdKE3EjyAhtjS4gH61pdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xcZYgWo6; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4132033276.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372729; x=1711977529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cvgUqXkNCnMPYOL9pmGocb12/7B31f9lQJOhAhiYpoM=;
        b=xcZYgWo6bFyKOMzWgEUGG3/sFecmMBKxoFxiAd3K4/yUdLmWOIESgUcK364taDGv/q
         MjDUsnkbyx+PW5GYwADd6dRIg9o8lSUumNgNo14QnjbhCDgB4Z4nMoOKFCt8g1s0eRMt
         HmihjWsKu0GMCJA9AxLIlKbjj0WwnSoVVcWQk+NBBXF8TYeY6MLvYtNHz97Kp1nc2zSO
         nVzXVsYn/sA2APofDGdJKMZDQoK2Mn12eoHS26xPqxvcoykdm86ijF4yv4Pon/vk08iq
         Q7ChWGMgXgxdL2g9a4VJR9Qe+us+7Xt8BeG7ZibOFKG+5v0YTdxkC0euCPxI0SPsaV78
         9FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372729; x=1711977529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvgUqXkNCnMPYOL9pmGocb12/7B31f9lQJOhAhiYpoM=;
        b=hUHw4MNhu8VOPszS7AUbQZbtx4sUaMUFkmg7d/mrhfaM/oKS/88FzeJdMUqdgIWQQS
         RttTwkN7Fy/dxUPkVqXQaMW5oPQcZPSE/wDWg3OgebNm2lUyvWaNPN29Z/vvz+syawTw
         NbpDuWmUNYqLtSB0z4X8JQ/F7ErQvXdliqJBQm3fj4s2jhKS3QRwGzYnSy73+rDsfZ08
         mRKkLyTRCotAo2W+g8btXy3zBD9Erk2yqkwq9VcFgab0g9PJFtO6/9UFoDXcVsh97uMX
         Tz2WCNt7WYb8w5RlAQWaN2VLQmhE9JbGd/aZs24/JaWr/yky9dqvoRmtvNxn3tTYRjrX
         cmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqfSn4EQ96Cl8UHwfliOWZEh+TduG3y+y5aO0sMmK7V8DmFXdK87qPV7rFCAqTWXXHQegunKbW1ygdmHAH2WkVwjfNBKc9RyiJzom/
X-Gm-Message-State: AOJu0YymjM3GIB+Lz4/aHAJTikkBD5N/j05woBOpwIKo/kv7tZajGQPR
	ev6GzT3i1an8rq50m6ZBCPK6Ch/LeFkjVEw6gE01MADr3PneKT602SeU9a9jsGc+cmnQT7TksUi
	8nc4okMoUIfj/1t567v4JVo3cDZsYq+F3TCzlCw==
X-Google-Smtp-Source: AGHT+IHZVBThr1gKl1PUGSzyaGohCWnTiHIIdzOXuyMY7iKKwFdfPBat5kQW50jTwj/J1exaj8/EfpqCHQHzicLEWPk=
X-Received: by 2002:a25:2e0c:0:b0:dc2:470b:887e with SMTP id
 u12-20020a252e0c000000b00dc2470b887emr4783512ybu.21.1711372729682; Mon, 25
 Mar 2024 06:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307121912.3676850-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307121912.3676850-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:14 +0100
Message-ID: <CAPDyKFpyF2OAQGP+RYmzYCh-ZFk+T+9w0A3AkJSdODEy5rHLJQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-s3c: Replace deprecated of_get_named_gpio()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 13:19, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It seems the of_get_named_gpio() is solely used to check
> if the GPIO is present in DT as the function can return 0
> if and only if it's present and it becomes in the global
> number space 0. But this quite likely shows that the code
> wasn't ever been tested on the systems when no GPIO is provided.
> In any case, the proper test is just to call of_property_present()
> without any attempts in requesting GPIO (as we haven't saved the
> number or descriptor anywhere in the code).
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-s3c.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 0e8a8ac14e56..6493b0edba34 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -17,10 +17,8 @@
>  #include <linux/slab.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> -#include <linux/gpio.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>
> @@ -446,7 +444,7 @@ static int sdhci_s3c_parse_dt(struct device *dev,
>                 return 0;
>         }
>
> -       if (of_get_named_gpio(node, "cd-gpios", 0))
> +       if (of_property_present(node, "cd-gpios"))
>                 return 0;
>
>         /* assuming internal card detect that will be configured by pinctrl */
> --
> 2.43.0.rc1.1.gbec44491f096
>

