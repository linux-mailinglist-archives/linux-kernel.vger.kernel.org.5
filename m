Return-Path: <linux-kernel+bounces-117129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3789588A7A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6504A1C3E291
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D46172BCB;
	Mon, 25 Mar 2024 13:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7HpHQXk"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B378172BC9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372740; cv=none; b=jPG9pQtbFdZ3ViwlUmEQj2fFqNTR1ydEj7GA+6kMHYjiUDF5UMrJVwA+1rJdRqHER1jIki7TopMwtY2KVDgLPTJxZ6ebRz1GYatpgfktZb58xkiSzKBdJLwFZWmvk3VqC45aPU37F7vruJ0bOphPunJokd2rJk7N18D7PgDT0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372740; c=relaxed/simple;
	bh=+g6l24R7iYlT3jLfuSklU+YCcpUZzJymv4Cy8kThrH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWCYh5ss/IpZ/PaOpMIUt/aawvmguZrYImp+B08WvO8j+2M9xH3AoK7ACvEoHLMa4KcIsC9bfBvaaXxQ4KAbHnF4IVJLTOIyz3lfu5hLwUhlvr2dOGAShCnkyC8mcYFzf7kJaTZ7c5ktagJpyAynJE0LuOXs75dFG2Po+k03N3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7HpHQXk; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso3933699276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372738; x=1711977538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qc+iVsnT1Xzqqiyad328U5HjkOGFMt7G5z0pWYZra+o=;
        b=d7HpHQXkpBc4q1z6AF2GvvML3HuI9q/Uf0epEpxw4diM8f7yvQPuW2vrWGUS4Z/qHp
         4dK6DCBA9gXxTfivY+qARHI92rLbNTwuv+fq4iHF9YlS6iRz5wLgzowlMsZk81yzPPtl
         KLWcGtUhLIMvR0bl9KfifT/wGBfInkgyQumbEU+IPTvbIp7dc46IihrwpL/hUMAnwn3/
         AXQbbzZiuxzFK0uErN6ptFqKOIYCMniVlb4FW8PrJV6QUzZxpS69WDrRSy851QhocAeq
         CIKusO9PIHW2alRk4wffOlddKnO9zi1AJqGizexsz9knu9m3BXFnzch1FZ+VECf9VFHY
         ag5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372738; x=1711977538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qc+iVsnT1Xzqqiyad328U5HjkOGFMt7G5z0pWYZra+o=;
        b=e056uRPqCxukdvdR+Rrfc4JZu4q13CFLM278sqyMlQln90Y+Uq2l8XwyCgC7KBCXLn
         B9DFfNf6uf+L8mi5884KmX4MaXCeZo/yL6TwN46nDok7BjUYnhX7Vxqk0WGOzm4cpK8M
         H022f6OUIEskr8z8/N1TNLbrznWS2EXwiM+/6l+JZ/ZC5R39ke0kJsYug1FGpmUaNc/E
         QJgyLVQSWYI4JzPirsI1PKZEUjAcb5tfGB/DUUke1Qw9amEPWfEFKRoqBm5hiY4NlNlW
         d94jN5lcgAuFNjx76BMPLeRl3NBlw6q6OgK7FsmCWH7B+q02L2mF35VMTeLNo+VndTZl
         sNIw==
X-Forwarded-Encrypted: i=1; AJvYcCX52dqHGk6ls6ZWhjqk4NQHMORkO1daCHIGvDCkGFd0YOD47AkC7Y5fLRmqLlCSoW4fjhnC7gmL5LUPEycBbUgrEFxARRYOr4E8uEHx
X-Gm-Message-State: AOJu0YwUl9QayTKfT/+ZdUFsrr6Ib6HgqaYKhOf20gZSTIw7bi7637aY
	yMV5WTDUvqYikH1qehjSL8QJrUe/zZQ18ECEXFm1v8xN8M/xq1ydslJ7ZY9TcZyJprPxiEx+fJu
	9t41kzrCXV3hqOpDTeI5PBLcX7hh78mSwArqVxA==
X-Google-Smtp-Source: AGHT+IEMz2pveieTRzatmvaD78PaHp+oiu25iulyM43bTmQBBxO8fIlfqLirkAWS82Cw+Pwqx/Nargo85AIivPxTPnk=
X-Received: by 2002:a25:8042:0:b0:dcc:5aa1:7ac3 with SMTP id
 a2-20020a258042000000b00dcc5aa17ac3mr5037282ybn.2.1711372738228; Mon, 25 Mar
 2024 06:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307114500.3643489-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240307114500.3643489-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:22 +0100
Message-ID: <CAPDyKFpf4TEtee7bUsKEkmwzOcffXQWTH9xZz+JBk8WE1Fb5RA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-sprd: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Wenchao Chen <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 12:45, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-sprd.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index bed57a1c64b5..685b1c648901 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -13,7 +13,6 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> --
> 2.43.0.rc1.1.gbec44491f096
>

