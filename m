Return-Path: <linux-kernel+bounces-150869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 614FD8AA60A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204962840F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A98E7B3FA;
	Thu, 18 Apr 2024 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrOYcUrP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03B71742
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713484385; cv=none; b=r4TTSVlTo3kysEvBZwSYvQaJpbBqoS2kBud3rgxDY/u/DdegqY7nI9ofXkMvHfGjVaGXplD55uKW36q6AV4gzBFw+tTj4JRVbB2KKN0ToE5dbodeazWiEONBfVSvpyCCaLHNrpy89Y4SByLlBBVDmc0vge+r/+psdoRZG48Txz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713484385; c=relaxed/simple;
	bh=EDzBhMg3yje1/eGD1XEWICChoTbSZ81Zm8yXEhJtxxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnkP2TbOWvgj6vuuZygdhs8yZmvIxhGfvwdjWdGVoLtOhQmEijFUutnillx80Ufdj2Cr2deJ+jpkgJDSdQY8i2pv8cKSWl1rKFcZYVmPUXxYckWzyLQgSm7zfOrYTH0i/4IlKbLx3WqV0j5BnA59mBozlVbv+rVThbJhRwlGVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XrOYcUrP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e4f341330fso12716845ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713484382; x=1714089182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzX9pV7TdTXrgXQbegjfNEKAsh+k3EiRMkuLKOr5KHA=;
        b=XrOYcUrP+x6nO1eZ8FWERz1skw94W/NFrPCtW4E+CSmQEs4G7LBEGZxkHrdbxiSMmW
         kBbXzt3SLvPEssXin/p6tSMoPriB79AMFJiMY9pwDYPr6cxiYReOoImSarZqmPjEq6N5
         0Z/MH4o2d0Q8rDF7cNp+cRysxLj7ty3jbIEdES/HcGO8vOte+69XGxzpgFtWpvzZdiRC
         2ZjxQ9YPotL3BvphPmgHRDtZPtrHyI7ec1WYOrIqPBr858Q0TG35ywIHtciJBzc7LWqm
         AMQy+HjpfbyjksodLcTEX52tztROd9DGl0WSSMiHPxvb8L3FMjOPOJr+T2AR0Uq7LvIn
         aUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713484382; x=1714089182;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzX9pV7TdTXrgXQbegjfNEKAsh+k3EiRMkuLKOr5KHA=;
        b=cpK8hVN/+Pf5Huz8PQiDgsMVu+Rkz7e8Z1R8NxTVsKh/IJf5S98M7xmra/c/dLYFQv
         YPcZlvYkrS9x2n2fZGWQcDT7W/YaR6g4/4zC8dltlM2ZW0XE2IylnySsmCcc5K4ikKHb
         nosF0Rq6sRJ6JzY6zuZN4CrF4oIMO6TmEFmGjBF2sYXiItF9DT7dHkbux2FR7DnsHntt
         49E+pfQFwXOoW4e9lyrYnK2T5SKWDWeXVdb/FAjT+JIgWA3egg22cYIUmwbw6EOlr1IH
         hd0oyqMF3fbUe4rUWxp6nOR5XgnBY6IMNZpzf8rrsuERl91ctNsgPRTyqkBa7oFGNh4Q
         Oi6A==
X-Forwarded-Encrypted: i=1; AJvYcCWrpcPse32dGt/yEXnq0CTwok9xNDNXhT4pyX7qPEVpoUVVEUsHKJB9SlO5S3SpTOb+4b1Aan0fNDHwGUOPnImZ89x2oYRyGCxmtCMm
X-Gm-Message-State: AOJu0YzpKbIRAndLHtDO1ZMiP3uYkGgU1L3Njqb8DcC1/lT+QqTQ0pS4
	BuICJeESTVQkYrUgwoOl8sRMYpvds+Z/EHbhrfG98eqAZYwCDwAsKagXxbD2Ons=
X-Google-Smtp-Source: AGHT+IGW0RLkSC3AZg6v7pfLU2MxaV8C6m7IOIUWMOVzP3hN/gFj68l3mm8pTK5mB7H109tSbfYIoQ==
X-Received: by 2002:a17:902:6b49:b0:1e3:f2d0:1a4d with SMTP id g9-20020a1709026b4900b001e3f2d01a4dmr601126plt.45.1713484382187;
        Thu, 18 Apr 2024 16:53:02 -0700 (PDT)
Received: from [172.20.10.110] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id kq6-20020a170903284600b001e26b7d3e8dsm2087342plb.266.2024.04.18.16.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 16:53:01 -0700 (PDT)
Message-ID: <2614c8b3-ee7f-4ac0-9b43-20905759756e@linaro.org>
Date: Fri, 19 Apr 2024 00:52:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] net: ipa: maintain bitmap of suspend-enabled
 endpoints
Content-Language: en-US
To: Alex Elder <elder@linaro.org>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: mka@chromium.org, andersson@kernel.org, quic_cpratapa@quicinc.com,
 quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
 quic_subashab@quicinc.com, elder@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240418204729.1952353-1-elder@linaro.org>
 <20240418204729.1952353-2-elder@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240418204729.1952353-2-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/04/2024 21:47, Alex Elder wrote:
> Keep track of which endpoints have the SUSPEND IPA interrupt enabled
> in a variable-length bitmap.  This will be used in the next patch to
> allow the SUSPEND interrupt type to be disabled except when needed.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>   drivers/net/ipa/ipa_interrupt.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
> index c44ec05f71e6f..0e8d4e43275ea 100644
> --- a/drivers/net/ipa/ipa_interrupt.c
> +++ b/drivers/net/ipa/ipa_interrupt.c
> @@ -37,11 +37,13 @@
>    * @ipa:		IPA pointer
>    * @irq:		Linux IRQ number used for IPA interrupts
>    * @enabled:		Mask indicating which interrupts are enabled
> + * @suspend_enabled:	Bitmap of endpoints with the SUSPEND interrupt enabled
>    */
>   struct ipa_interrupt {
>   	struct ipa *ipa;
>   	u32 irq;
>   	u32 enabled;
> +	unsigned long *suspend_enabled;
>   };
>   
>   /* Clear the suspend interrupt for all endpoints that signaled it */
> @@ -211,6 +213,7 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
>   		val |= mask;
>   	else
>   		val &= ~mask;
> +	__change_bit(endpoint_id, interrupt->suspend_enabled);
>   
>   	iowrite32(val, ipa->reg_virt + offset);
>   }
> @@ -246,7 +249,16 @@ int ipa_interrupt_config(struct ipa *ipa)
>   
>   	interrupt->ipa = ipa;
>   
> -	/* Disable all IPA interrupt types */
> +	/* Initially all IPA interrupt types are disabled */
> +	interrupt->enabled = 0;
> +	interrupt->suspend_enabled = bitmap_zalloc(ipa->endpoint_count,
> +						   GFP_KERNEL);

why not use devm_bitmap_zalloc() instead and skip managing the cleanup ?

> +	if (!interrupt->suspend_enabled) {
> +		ret = -ENOMEM;
> +		goto err_kfree;
> +	}
> +
> +	/* Disable IPA interrupt types */
>   	reg = ipa_reg(ipa, IPA_IRQ_EN);
>   	iowrite32(0, ipa->reg_virt + reg_offset(reg));
>   
> @@ -254,7 +266,7 @@ int ipa_interrupt_config(struct ipa *ipa)
>   				   "ipa", interrupt);
>   	if (ret) {
>   		dev_err(dev, "error %d requesting \"ipa\" IRQ\n", ret);
> -		goto err_kfree;
> +		goto err_free_bitmap;
>   	}
>   
>   	ret = dev_pm_set_wake_irq(dev, irq);
> @@ -270,6 +282,8 @@ int ipa_interrupt_config(struct ipa *ipa)
>   
>   err_free_irq:
>   	free_irq(interrupt->irq, interrupt);
> +err_free_bitmap:
> +	bitmap_free(interrupt->suspend_enabled);
>   err_kfree:
>   	kfree(interrupt);

You could also use devm_kzalloc() and do away with the kfree()s you have 
here on the probe path.

>   
> @@ -286,6 +300,7 @@ void ipa_interrupt_deconfig(struct ipa *ipa)
>   
>   	dev_pm_clear_wake_irq(dev);
>   	free_irq(interrupt->irq, interrupt);
> +	bitmap_free(interrupt->suspend_enabled);
>   }
>   
>   /* Initialize the IPA interrupt structure */

Just suggestions though.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

