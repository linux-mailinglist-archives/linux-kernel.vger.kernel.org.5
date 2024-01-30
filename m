Return-Path: <linux-kernel+bounces-44502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325A8422E6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C13291454
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5381366B38;
	Tue, 30 Jan 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPQJOgpy"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4409F66B29
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613843; cv=none; b=VMjT4mfnCarVGehATCLZhPshvY0RI1Y9B0UvebCyeqA8+J5cRr2uMgmV0rBscJI8g15PCO3MQq9ZpwIoh+/C7T0uCtXNL1FUwWr2ymmI0ynuBEDq4jYuQ0RkAl19ZfO8JvYSDDZRknJP0ofd6QwYgoyT7eDWdDrSsVgYnE0zu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613843; c=relaxed/simple;
	bh=lv43hevcTa+64J0GxwrbWW7IYyzTy2+TvNR2spRRFog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebtDJS8jV27dOIA/2vovL51eoeRloJE9Xyj2W+e3BvK95mYIM7Hcdz//yKsQjLDW/OA26AdW7r0tsC0FFiQnCyhWS9lz0K6u8M4wY9sunlCi0GhearA98HscxuMLBMvb5t98LCdeVn2kJ1+UjX41cwJdQYV7kQXKy1EtP3/Lt8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPQJOgpy; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36379bc5d93so5653475ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706613840; x=1707218640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1F5K1w5ptPpWVbrzL69kxVWikdQT589qSufOOrLNvyk=;
        b=mPQJOgpy+wTYbwtDum+aQq7oz33hTL0GIglFPB5vs6lUOtuhGEcrHVMimZokGK8tBx
         KF0JU3vrYL5ATdAjFhbZ+IO82dHUMseNkIGO00lfVnBIrNQRBNHQ5NN8FOe/2bk5Cprz
         8iwK0Zc074HVHEjE7jHvWpxD4X8tpr9VxKPi9BvHSK5ty1WzgXsLOMmcx/SDXOOC3+P+
         ljMpkur++avK9FnO7/9lIjR/UzaBh1A+dxNErNA4XwxnIQLT16p6/stsM2KsszYa791c
         WciaTYjFxQ3uJDHRe2+N2clevGyAP6aHS1qiIR9Rh4STySrbCbkrGg2N0qTz12Yq258N
         X8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613840; x=1707218640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1F5K1w5ptPpWVbrzL69kxVWikdQT589qSufOOrLNvyk=;
        b=uLY/MLRUF/aVPkRBC2/3FhMMgd8VPdKWy+gFNmZ9hNTQAVWIvk0KxZCG8Mpm+/zGxt
         ZuO2vq503WsuCj3tuZvENqmt9aofbYrvBhZSNNLtGtaiFvEs6fVXy25nXWnL9PehR84l
         tRsx9etjyQqNDNIe7n71MkpQVUEoTEBapek29nWwO8x0WxrS92Nu7FugQfpeESJFTBll
         UZBtLMFSjEYVNMwjiyI10QiZVgy5zsSh4jCb2XAKjBY38CN1s4+O4ehhrDuF9iHs6xTS
         PH+hJSmzEdBKKj7l32aiPFWDchqfc5lSTYP6G+YLwW5cJEpt5epQgtUtybAiaY4RYsKw
         qW6Q==
X-Gm-Message-State: AOJu0YxxaMPhnSSD7+H3bc/ZpLFhgnj7lx57kFYcLvqAQsnTysf0+/0Z
	ICp17V5PG6zVfMoXt841BP0BtoLxfNvMiTSe3Xozr21qW2E0M27A+ZZ/A+Zx3JY=
X-Google-Smtp-Source: AGHT+IHKdQCanZI5XXVDCMtb7vhvgINd+abU2YHqtb5E0Q9PMHdFUkLdkHUE23F69+B0bNtzNBk0pg==
X-Received: by 2002:a92:c14b:0:b0:363:8559:edf with SMTP id b11-20020a92c14b000000b0036385590edfmr3200068ilh.1.1706613840424;
        Tue, 30 Jan 2024 03:24:00 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id e16-20020a92d750000000b00362902d6818sm2787085ilq.62.2024.01.30.03.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:23:59 -0800 (PST)
Message-ID: <b5ae6fd2-1dee-47e4-b7e4-ebd8a2aea472@linaro.org>
Date: Tue, 30 Jan 2024 05:23:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: mhi: ep: Use kcalloc() instead of kzalloc()
To: Erick Archer <erick.archer@gmx.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jeffrey Hugo <quic_jhugo@quicinc.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Dan Carpenter <error27@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240128112722.4334-1-erick.archer@gmx.com>
Content-Language: en-US
From: Alex Elder <elder@linaro.org>
In-Reply-To: <20240128112722.4334-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/28/24 5:27 AM, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because the "event_rings"
> member never can have a value greater than 255 (8 bits). This member
> is set twice using always FIELD_GET:
> 
> mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> mhi_cntrl->event_rings = FIELD_GET(MHICFG_NER_MASK, regval);
> 
> And the MHICFG_NER_MASK macro defines the 8 bits mask that guarantees
> a maximum value of 255.
> 
> However, using kcalloc() is more appropriate [1] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
> Changes in v2:
> - Add more info in the commit message to better explain the change.
>    (Dan Carpenter)
> - Add the "Reviewed-by:" tag.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Previous versions:
> v1 - https://lore.kernel.org/linux-hardening/20240120152518.13006-1-erick.archer@gmx.com/
> ---
>   drivers/bus/mhi/ep/main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index 65fc1d738bec..8d7a4102bdb7 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -1149,8 +1149,9 @@ int mhi_ep_power_up(struct mhi_ep_cntrl *mhi_cntrl)
>   	mhi_ep_mmio_mask_interrupts(mhi_cntrl);
>   	mhi_ep_mmio_init(mhi_cntrl);
> 
> -	mhi_cntrl->mhi_event = kzalloc(mhi_cntrl->event_rings * (sizeof(*mhi_cntrl->mhi_event)),
> -					GFP_KERNEL);
> +	mhi_cntrl->mhi_event = kcalloc(mhi_cntrl->event_rings,
> +				       sizeof(*mhi_cntrl->mhi_event),
> +				       GFP_KERNEL);
>   	if (!mhi_cntrl->mhi_event)
>   		return -ENOMEM;
> 
> --
> 2.25.1
> 


