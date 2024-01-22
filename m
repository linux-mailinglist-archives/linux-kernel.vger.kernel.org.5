Return-Path: <linux-kernel+bounces-32534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D63835CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1A71F23D33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B48288DB;
	Mon, 22 Jan 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK0/gkg0"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24C41C32;
	Mon, 22 Jan 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912736; cv=none; b=Ry+POalmcjI+QkC/3gEyBzIvfbDlaBi3ZXrLbxVTUES8HZHl+1ArblQGeJK/LYrLRGF3uDZ7bRZ2X8TVTsB+6m81nMAGN8x/swrm+2pOXYRq7t/9dIOQazGesFriIjZtw3mPn/ITjvMRh5ZQ/yX44ZbiVVmCNGZX0N5pvTZtis4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912736; c=relaxed/simple;
	bh=iyt31Fwv7SvlN97QCV1M3DJCdkFqLKgGQtl6zPuMqcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKf7qQ+LlfKssiOS31VfDFuAguxsAovzyMeyUPuZB92rytMPwrd2D095IcSNXkKi/xhJZAQ+1Pir6WrKeJ4dxhCX9uvQXjNu4xpV4oS36Ife7Qa4yhEJIoiXJ5ZiDcrCnnNGOqW2BgNRUlxDjVQDfAeSuUXPFem7es9cU/sQqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK0/gkg0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so32560745e9.1;
        Mon, 22 Jan 2024 00:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705912733; x=1706517533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2yugJCPd8jiYL0SGmTLIZgbC+PDBHwJ6+q45hgq8ymY=;
        b=UK0/gkg0Ksx15/M8UC0QUYE0FahCrwWg85jmB+52RCcPXYr0xP5E43MbAiVWR2Hgaj
         Hj5uAGXnCdq0t8R/2IqM2ZUUnvrumi+P5D3aE5AlPlRUvZWSqRXBMUmUVOjCXpwnNj/Y
         HWWQhexMQ8f0DLCu9AAsvZCbS9xCgZ8Xju910200exlOyY505+76ov4g0tvbwkf8IgyY
         k5hhaAIk+6ua76C8qePup5oFtaSLRxjlifI5lZyDaRoiKNL8KFZCIJSxcOq0/OWnr6ax
         8KKYtejAKIMgtF+RKu8gMMK4ky0nZgb60amtaFBImp9EW+9GDkSuhLFPExX/GYhqrpg1
         WgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912733; x=1706517533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yugJCPd8jiYL0SGmTLIZgbC+PDBHwJ6+q45hgq8ymY=;
        b=DDl/lCYITHNHMwVlYdF9Ky673DNLbvCBofJlD87lWBCeWkizW+BUZgIILsr1wTwRpf
         U8Px+KervC67Tn5iYR2g592dBPchya6MEj8lIKbGp8NFL+PqU4wBxCby0BMUMjvYWRD6
         58IVeP6ggGnGefcGB+xqUG86JEu6fCHr1bM/BKT3RUe0OhnenkZGbmRp6Zt7QZAuhwLF
         ruUD89qmueVDAkkfLlRbylCP4Jt+qJkGYfiymRL1Mky1zFYQQu9dc1XnELJw3qmMQ0nX
         BN6chcGR/t7BFHLEF7NFlp/bjj9VmkpZDBzb/4R+dd28yf55Su88iySvPdei1Smt7crJ
         ABZQ==
X-Gm-Message-State: AOJu0YxlgC7OSUIaoASSyJwP+xyYeJzQmQPPqw0kccYAzIh4igtpiit5
	LR7wN0QkZN7Wntg5Zqly3TJfqwjKZj+o8YiQ6+5qz8eMoBLB9FY6
X-Google-Smtp-Source: AGHT+IHGL/CN7Ch/XQHu070cYX0yhaZRpgJ8dXbFAwR62/I6GOIuKFyU3SRJTiPHD1YNSW1Stzt6QA==
X-Received: by 2002:a05:600c:1906:b0:40e:4b0d:286d with SMTP id j6-20020a05600c190600b0040e4b0d286dmr2034987wmq.35.1705912732771;
        Mon, 22 Jan 2024 00:38:52 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
        by smtp.gmail.com with ESMTPSA id iv17-20020a05600c549100b0040e5034d8e0sm42483332wmb.43.2024.01.22.00.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:38:51 -0800 (PST)
Message-ID: <011d5f5b-cf10-4476-8b5c-2fc9805e71e2@gmail.com>
Date: Mon, 22 Jan 2024 09:38:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cpufreq: mediatek-hw: Wait for CPU supplies before
 probing
Content-Language: en-US, ca-ES, es-ES
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, "Hector.Yuan" <hector.yuan@mediatek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20240110142305.755367-1-nfraprado@collabora.com>
 <20240110142305.755367-3-nfraprado@collabora.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRd1TlIARAAm78mTny44Hwd
 IYNK4ZQH6U5pxcJtU45LLBmSr4DK/7er9chpvJ5pgzCGuI25ceNTEg5FChYcgfNMKqwCAekk
 V9Iegzi6UK448W1eOp8QeQDS6sHpLSOe8np6/zvmUvhiLokk7tZBhGz+Xs5qQmJPXcag7AMi
 fuEcf88ZSpChmUB3WflJV2DpxF3sSon5Ew2i53umXLqdRIJEw1Zs2puDJaMqwP3wIyMdrfdI
 H1ZBBJDIWV/53P52mKtYQ0Khje+/AolpKl96opi6o9VLGeqkpeqrKM2cb1bjo5Zmn4lXl6Nv
 JRH/ZT68zBtOKUtwhSlOB2bE8IDonQZCOYo2w0opiAgyfpbij8uiI7siBE6bWx2fQpsmi4Jr
 ZBmhDT6n/uYleGW0DRcZmE2UjeekPWUumN13jaVZuhThV65SnhU05chZT8vU1nATAwirMVeX
 geZGLwxhscduk3nNb5VSsV95EM/KOtilrH69ZL6Xrnw88f6xaaGPdVyUigBTWc/fcWuw1+nk
 GJDNqjfSvB7ie114R08Q28aYt8LCJRXYM1WuYloTcIhRSXUohGgHmh7usl469/Ra5CFaMhT3
 yCVciuHdZh3u+x+O1sRcOhaFW3BkxKEy+ntxw8J7ZzhgFOgi2HGkOGgM9R03A6ywc0sPwbgk
 gF7HCLirshP2U/qxWy3C8DkAEQEAAcLBdgQYAQgAIBYhBOa5khjA8sMlHCw6F9kUC7JWEwLx
 BQJd1TlIAhsMAAoJENkUC7JWEwLxtdcP/jHJ9vI8adFi1HQoWUKCQbZdZ5ZJHayFKIzU9kZE
 /FHzzzMDZYFgcCTs2kmUVyGloStXpZ0WtdCMMB31jBoQe5x9LtICHEip0irNXm80WsyPCEHU
 3wx91QkOmDJftm6T8+F3lqhlc3CwJGpoPY7AVlevzXNJfATZR0+Yh9NhON5Ww4AjsZntqQKx
 E8rrieLRd+he57ZdRKtRRNGKZOS4wetNhodjfnjhr4Z25BAssD5q+x4uaO8ofGxTjOdrSnRh
 vhzPCgmP7BKRUZA0wNvFxjboIw8rbTiOFGb1Ebrzuqrrr3WFuK4C1YAF4CyXUBL6Z1Lto//i
 44ziQUK9diAgfE/8GhXP0JlMwRUBlXNtErJgItR/XAuFwfO6BOI43P19YwEsuyQq+rubW2Wv
 rWY2Bj2dXDAKUxS4TuLUf2v/b9Rct36ljzbNxeEWt+Yq4IOY6QHnE+w4xVAkfwjT+Vup8sCp
 +zFJv9fVUpo/bjePOL4PMP1y+PYrp4PmPmRwoklBpy1ep8m8XURv46fGUHUEIsTwPWs2Q87k
 7vjYyrcyAOarX2X5pvMQvpAMADGf2Z3wrCsDdG25w2HztweUNd9QEprtJG8GNNzMOD4cQ82T
 a7eGvPWPeXauWJDLVR9jHtWT9Ot3BQgmApLxACvwvD1a69jaFKov28SPHxUCQ9Y1Y/Ct
In-Reply-To: <20240110142305.755367-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/01/2024 15:23, Nícolas F. R. A. Prado wrote:
> Before proceeding with the probe and enabling frequency scaling for the
> CPUs, make sure that all supplies feeding the CPUs have probed.
> 
> This fixes an issue observed on MT8195-Tomato where if the
> mediatek-cpufreq-hw driver enabled the hardware (by writing to
> REG_FREQ_ENABLE) before the SPMI controller driver (spmi-mtk-pmif),
> behind which lies the big CPU supply, probed the platform would hang
> shortly after with "rcu: INFO: rcu_preempt detected stalls on
> CPUs/tasks" being printed in the log.
> 
> Fixes: 4855e26bcf4d ("cpufreq: mediatek-hw: Add support for CPUFREQ HW")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> 
> ---
> 
> Changes in v2:
> - Added this commit
> 
>   drivers/cpufreq/mediatek-cpufreq-hw.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index d46afb3c0092..a1aa9385980a 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -13,6 +13,7 @@
>   #include <linux/of.h>
>   #include <linux/of_platform.h>
>   #include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   
>   #define LUT_MAX_ENTRIES			32U
> @@ -300,7 +301,23 @@ static struct cpufreq_driver cpufreq_mtk_hw_driver = {
>   static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
>   {
>   	const void *data;
> -	int ret;
> +	int ret, cpu;
> +	struct device *cpu_dev;
> +	struct regulator *cpu_reg;
> +
> +	/* Make sure that all CPU supplies are available before proceeding. */
> +	for_each_possible_cpu(cpu) {
> +		cpu_dev = get_cpu_device(cpu);
> +		if (!cpu_dev)
> +			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
> +					     "Failed to get cpu%d device\n", cpu);
> +
> +		cpu_reg = devm_regulator_get_optional(cpu_dev, "cpu");
> +		if (IS_ERR(cpu_reg))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(cpu_reg),
> +					     "CPU%d regulator get failed\n", cpu);
> +	}
> +
>   
>   	data = of_device_get_match_data(&pdev->dev);
>   	if (!data)

