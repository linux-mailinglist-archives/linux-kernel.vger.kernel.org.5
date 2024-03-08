Return-Path: <linux-kernel+bounces-96399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F2875BA5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040D71C20B4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841D2134B;
	Fri,  8 Mar 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eGmaD0Bm"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7725139E;
	Fri,  8 Mar 2024 00:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859414; cv=none; b=InFFxAFXWM6wPEYdgAY+W5Frc5PObMRq/yBb/SiQZ57SPwTyA1FpFdWjRZatrLa6QMfFcM1XuDudRA49RUCMRX9+nD+FZOegAzz8BfHjUnUv3EP0LJvjzpSDTKA2In0a333gveQ/z4zxdfPddDAsKMwMVMnhZV2qL8YLrHpYeZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859414; c=relaxed/simple;
	bh=SWG3S1OZuOH20AGyfh9tG4DkZfmkAUgGLb06Mf7VwI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRD4PZvlKCaMzz0pugMJa4UIwU1GHalHUfWFlQLP3gznsg8JglFcoYvyOgK+DSTjeyaafMbJUpTJmMwEtGlylEX4qc5MtZLNqOq0k12dwW0ow7jJpNwTJMjksWNqqItj4tHyQ5m9kySD9ZVFoGs8mZDRZbFGEkCe0XrrxI6hDRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eGmaD0Bm; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709859409; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iReoZfK/zkr+2bld/rPURGTuIP+W1I5bWYMybRMeyRU=;
	b=eGmaD0Bm0whEuyhV5CedG29+eVYb6kO+FOTG6dyUN/jDzNXsJpToDLL9V2HraNwuzFf6zsG+wwDGx/bVsjzqZ8CUPYy0Ku60ACyOzDf3LtirIQEdaOuygTcdzjXzOecr7AlA+Lb5z60zP+MsiuBnUSWlz4kvhXFpswSupxkg21w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W20rC5y_1709859407;
Received: from 30.97.56.62(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W20rC5y_1709859407)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 08:56:48 +0800
Message-ID: <ec328b25-1ba7-4f28-a30e-d0ea9f25a263@linux.alibaba.com>
Date: Fri, 8 Mar 2024 08:56:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] mmc: sdhci-sprd: Remove unused of_gpio.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Wenchao Chen
 <wenchao.chen@unisoc.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Orson Zhai
 <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20240307114500.3643489-1-andriy.shevchenko@linux.intel.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240307114500.3643489-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/7 19:45, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   drivers/mmc/host/sdhci-sprd.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index bed57a1c64b5..685b1c648901 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -13,7 +13,6 @@
>   #include <linux/mmc/mmc.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> -#include <linux/of_gpio.h>
>   #include <linux/pinctrl/consumer.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>

