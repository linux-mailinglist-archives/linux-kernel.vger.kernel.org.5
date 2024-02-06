Return-Path: <linux-kernel+bounces-55694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F7884C021
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0FC288D61
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FDD1C2AE;
	Tue,  6 Feb 2024 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZZhFz0F"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222551C295
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707258992; cv=none; b=NDQOcGlOR7enmQSkNxAC3jNvPTZ+mFcAVZsNO414DaHbvFygtWP8AmZ0etc8ddIOz0NSxrFypDVqCcn5wgCM3Y32WdviyjZ6KfmmZSMT2G9/YHB9p9jngKJJIwN7x5/wtlFpexu6gbgyF3hBnTt+5ULfmYT5Lgnlh/noUSorCwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707258992; c=relaxed/simple;
	bh=7QrIMERdjq61vUpc9OT4JVGI9Rs0/Mmw9Vd9BvIWxRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6u1cYZ6H5Y4co87uZbEiOD9wjXkPWtJ0zxDy/a6T899LKEc7wRPJelcAe2PwUWpT9qY0OKjyOFPeraN9XNmDmXEBeyLksmJIaviivLBcmHyEcmLRPniwZw2Xg2hXfBy3g3e+tHuOpCtrME14Gc1YrWwqcUvFkalyPdFA0krtJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aZZhFz0F; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso26139f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 14:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707258989; x=1707863789; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iRhZMOmAA7TAbkhcDCFrfmA34xC8BxSwITTbUht8po0=;
        b=aZZhFz0FNYNOqWNBZEI+ipBQyMo2dYp8HAWJ6M8r8s40O7n7hp24U1GFxZXhmLVGpA
         cP2E/Poh70k0dJjJK6rOgNQnu6e8/yh7Qre3xnF2kWXFD2puFXcxJlwgn4vWgcg38FpN
         O3UzLI0FZc2LkrU4OVMVLVznSWY+DJOUA0wxueSqISkdGxDXf08g2otmxse2pc7xdVQu
         N2s4bAS7KBT2aD85pu6Si51aERhWWFsQr9/efWoc3EGNl1Q3QpNptcFJ1M8GLB6vjyOb
         hweRv2GZQDwg3lx1JELKmzan8ucUoIzhJOgwTTK4drRo4+/NFZlJARhCb6QylGEqgop7
         J7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707258989; x=1707863789;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRhZMOmAA7TAbkhcDCFrfmA34xC8BxSwITTbUht8po0=;
        b=HM2ICcumfl8zmBORfqzhWk/hjWnpvSQJkHpANrQwWKRtFuGrP6YdE8lV3V/jmcsO1i
         thSkrXmi1H24YZzuiub6GwZYdPUFwzRmZ2wAaBGXWd2NloXBLh1ttJqU/Ip4zzf4Qn/r
         xz9BZzxSzwjOvBZm3mPWtulvxjRvdiB5uEOnzqN53LMNLqNTxDrZ3PCPdtfYnFpu9FUi
         dlJbyeYKApsIUQ8x6NNsk0Nw6w5VIrIep1qQkgyKQBTszOJ+FE7YsqVc5stvaugVIdiO
         CBi30xRW93usEBb4JsJ39+2uhWsNbNPX3Ij/yJ2wDouCgeSj5PSocbBKY1rkytG0cZCS
         5g+g==
X-Gm-Message-State: AOJu0YzFlU4G7sswTeyxZGdJv/nynzMtoer4/X955M8JJWkWdw1OO0sN
	mXZbi0b8QDtfXEzeRu1yVLMmk2NxoAaC7fbk3PytnWPwkMcEwGqzdAr56a5rKUVpueXYHSHcloS
	B2bA=
X-Google-Smtp-Source: AGHT+IG+M0GeCEMLYAfdfVbjtiqILEHWEct0zaNDN1ZCbuPUKTdgkLnarP4CjTcQuyBjHA/2Vted/w==
X-Received: by 2002:a05:6000:232:b0:33a:f521:7066 with SMTP id l18-20020a056000023200b0033af5217066mr2168070wrz.9.1707258989239;
        Tue, 06 Feb 2024 14:36:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVY4nXap1SU4OIfmVLgiP1qLcGYEnhmtYm/id3EjbIFbKKY79D2JTpAXrkAD/X8SmOhXvtJLB9wDMnyf2RQvUf5sZOPwh+FMXB2szWl9+Hhkv1OkrPk/d8TPLtb892G7TH1YHgbBy56lXH6zrt67l2bMDL0sS+0btQqWeM2l7PoK32CHFKuan6JBw7gZF7r/zBndaBKxw1aJ8dn2/Wu
Received: from [192.168.43.244] ([213.215.212.194])
        by smtp.googlemail.com with ESMTPSA id w13-20020a5d680d000000b0033afcc069c3sm40059wru.84.2024.02.06.14.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 14:36:28 -0800 (PST)
Message-ID: <1ecb3744-7baf-4bdd-a01c-8c87fa0a42b3@linaro.org>
Date: Tue, 6 Feb 2024 22:36:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
Content-Language: en-US
To: Joy Chakraborty <joychakr@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: linux-kernel@vger.kernel.org, manugautam@google.com,
 stable@vger.kernel.org
References: <20240206042408.224138-1-joychakr@google.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240206042408.224138-1-joychakr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2024 04:24, Joy Chakraborty wrote:
> reg_read() callback registered with nvmem core expects an integer error
> as a return value but rmem_read() returns the number of bytes read, as a
> result error checks in nvmem core fail even when they shouldn't.
> 
> Return 0 on success where number of bytes read match the number of bytes
> requested and a negative error -EINVAL on all other cases.
> 
> Fixes: 5a3fa75a4d9c ("nvmem: Add driver to expose reserved memory as nvmem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>   drivers/nvmem/rmem.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
> index 752d0bf4445e..a74dfa279ff4 100644
> --- a/drivers/nvmem/rmem.c
> +++ b/drivers/nvmem/rmem.c
> @@ -46,7 +46,12 @@ static int rmem_read(void *context, unsigned int offset,
>   
>   	memunmap(addr);
>   
> -	return count;
> +	if (count != bytes) {

How can this fail unless the values set in priv->mem->size is incorrect

Only case I see this failing with short reads is when offset cross the 
boundary of priv->mem->size.


can you provide more details on the failure usecase, may be with actual 
values of offsets, bytes and priv->mem->size?


> +		dev_err(priv->dev, "Failed read memory (%d)\n", count);
> +		return -EINVAL;
> +	}
> +

> +	return 0;

thanks,
srini

>   }
>   
>   static int rmem_probe(struct platform_device *pdev)

