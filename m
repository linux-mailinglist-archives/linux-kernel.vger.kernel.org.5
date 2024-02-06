Return-Path: <linux-kernel+bounces-54845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C45184B464
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0A42843BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0524412FF97;
	Tue,  6 Feb 2024 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uIALr5GL"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F13130AD5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220850; cv=none; b=lzfu11ZnVKE5+oNnP0qIokjKLmVlL40kWizix9QHlQMlKZzf8RsMpcJ87Hf0uI6Uejn/Cz/p4jkdC98Q4S+Rb8boGXFekjGQfn01bZTb06JY4ZJySFp988SG3G30vaH15mK8NbA5ZQLk7ZXsihJragHO1V67QB7GlQ74S/xBN4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220850; c=relaxed/simple;
	bh=18lYvSeKmq38bs8N+84VmT5iHrgU5RFM7nhP+Zpxhno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSxYRZ1P7v0Ty2R/uWzfVaHG8bYJf+ZThp4yRDnhNOGTz6/1UNjyJvl3SIk8Nz+pEPddTlJz52Ie2mfwS7XRFACeucFqEcyJ0dqeZhn0UGi7hRaHb7O9kul1Bn0B16wh9Q/YyfEbOzF1CHQfrwbn1JMvBP8XoNm12kO4RpK/py0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uIALr5GL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so2858125e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 04:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707220846; x=1707825646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=avTvuS762qmCgD6kqcgwSuKbF4TUne9nUly+9xf9U+Y=;
        b=uIALr5GL7Rs/JvhSQu6xNYiEUoNNk3BgAYI58D1fGeU6/Lb8+z31ApR+219Qzs7tLR
         SQBY7vGG3/fdPXyFY9bZyWt1vjz1FxfHx07963l+0n8EJ6fdToJAJw2umjNfpLSeeLeR
         74sX/zLemATOxfXjb1vFFbG7RzN/84Ha+rfDWxg/TXN//xNcgIq+grB/olsY8happi+T
         CZcJyRZplOAVvWsfz7UhekuXZoPit+NGssiQcM/mYHQL8XBLsqIrYJay+aL4f6kQqBfx
         SbEgmNCl2V9xPLQ9V9Z8h5VkxzuXT4ln5KtSgNeEF77XVUDcetuZh8Pe0m49in6Ta30Q
         WgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707220846; x=1707825646;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avTvuS762qmCgD6kqcgwSuKbF4TUne9nUly+9xf9U+Y=;
        b=AvLC6XUAScAKuvocOj5TeosowYQ+ywlsRhU9OKCKa3IQj4cjVrsSqyjQRi0x/RZNN5
         H+AdXqCso89X/PDf3w6z/xlq63M/fI/kWVqSE9N+44Qwup1N7B3s0CKododAGl+r188S
         6KAXNjpaLJ31RgjmsSuL72rLBZoebm4x93w1Scg0aYVz86SDQdPfmrBwn5GskHMOYv2/
         hUJYAChUigHToL35aK/0PQoJQzBoh4Oi+ppMInA3TAl910Zm6EhrUxu1M49m9Agf4OKM
         +4EBVVF6l6pC2NK5yBX5146+pM/6dcNCMeHzu0JUIT0utO1Y9e01X/equxPDVb17HPAV
         rfxg==
X-Gm-Message-State: AOJu0YyAB6TGKnpT0tx83fEySeZCQCt1zp5zu+iPk9Edqn71+caKadrq
	DaDUl6/5pKJh2DrpJ2midwmupxv0RZ9ZdQ2hXQEI/PVW5KsHIQBLy/WizoKtySs=
X-Google-Smtp-Source: AGHT+IH23PPTvp/q6Exz5xjfy1mPO/CAZzxSHy/N9EiLHdA2TLlOHNZ/7a57DAAVN43CWzL+bJVMiA==
X-Received: by 2002:a05:600c:3552:b0:40f:b69e:aa1e with SMTP id i18-20020a05600c355200b0040fb69eaa1emr6523132wmq.13.1707220846416;
        Tue, 06 Feb 2024 04:00:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEvra0UCaEfz+U+lHYdsGUU4Mr6ByfWR8bqjc4vDVt/lZSKWoRUeSyIwE3xnjHboiWV+xKfXubHqa8cce4i3Hw6grMloIrv1Cpr/kw7vR9J6nFl55lG5LSblaMxRXdsjYvTOThx+xEzI4PsiUVzvvn4K2LGR9718QtCQHCqY0V+zQoHLP+GsobUOBSmHOWJYCGt5V+x60hheIs8X0Z9ohem9Yd/mn9FC31TMAh/qXxH560tftiL9GN0ki6iQ3n7XqM7ri8vVR1ZffkAA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id d22-20020a05600c34d600b0040e3bdff98asm1847575wmq.23.2024.02.06.04.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 04:00:45 -0800 (PST)
Message-ID: <2df227df-8bd4-44f1-a361-15b43aea0b47@linaro.org>
Date: Tue, 6 Feb 2024 13:00:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch] memory: tegra: Skip SID override from Guest VM
Content-Language: en-US
To: Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
 jonathanh@nvidia.com, maz@kernel.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: amhetre@nvidia.com, bbasu@nvidia.com
References: <20240206114852.8472-1-sumitg@nvidia.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240206114852.8472-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 12:48, Sumit Gupta wrote:
> MC SID register access is restricted for Guest VM.
> So, skip the SID override programming from the Guest VM.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/tegra186.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
> index 1b3183951bfe..df441896b69d 100644
> --- a/drivers/memory/tegra/tegra186.c
> +++ b/drivers/memory/tegra/tegra186.c
> @@ -10,6 +10,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <asm/virt.h>

Are you sure this still compile tests?

>  
>  #include <soc/tegra/mc.h>
>  
> @@ -118,6 +119,11 @@ static int tegra186_mc_probe_device(struct tegra_mc *mc, struct device *dev)
>  	unsigned int i, index = 0;
>  	u32 sid;
>  
> +	if (!is_kernel_in_hyp_mode()) {
> +		dev_dbg(mc->dev, "Register access not allowed\n");

Doesn't this depend on hypervisor?

> +		return 0;
> +	}
> +
>  	if (!tegra_dev_iommu_get_stream_id(dev, &sid))
>  		return 0;

Best regards,
Krzysztof


