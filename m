Return-Path: <linux-kernel+bounces-108979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CC28812E4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE921C2364F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D067F43ADE;
	Wed, 20 Mar 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfASzQfE"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901663EA98;
	Wed, 20 Mar 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943549; cv=none; b=dz0J+DjMSSDTQbk5Jm+aUOwiSnYbRURMsinACMiJzTEG1psLJaoLkwdZ680tg6JuMdGk63lMOyPn2Z4rjG9eWPwT9yIrACj4W2LxAvXiXQZMDwDFaej09RXME8JpY2nukUYBUAQ7pZ7/52LE279sF/rIH/oWRzfJbH9c62XeG7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943549; c=relaxed/simple;
	bh=irrfGLbO01Mq9CLIqn3SwQSHvJHO7nR7VitfAyslVwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9wLqgvB3f1zHU6E6/NQshVVPQKHR7ELMGSZsPV+vaozoeE3gKctZznwg7kkI5NJeDjjLiM6PfHIuQXHxmiCbxow+2GuPw91XoUsMP9PNj/trpPcj5FZSc6L7VHIKU7PCDIodjIt7TqT4UtpcsIK+rNcSwgZMhVU28P1gAwsgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfASzQfE; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-695df25699fso32704166d6.2;
        Wed, 20 Mar 2024 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710943546; x=1711548346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbVZj4I/+AtmVzGEkeHLDd9U7wOTVaVZVt9tQRs8U4g=;
        b=VfASzQfEi/wETVMpvQWeypdBBjBwvIlaUUnUGffBvQBmGgSRi9Wfg57HMJBXAJiEsW
         qI79hxSbNtftlpisW9/i1Vjz7YIsw9Iu0hfk4WEBpnwmbUL2npaZrEcKByQ/AIRsVZX3
         bUkB7J2/ZARQIzjkBQZwk8X/mkRyydOjsRQA0kWyrqMuabwXxfBenxHqNwX+1269XMdf
         3tlihJ+fLg6dKszpNXZz7kTaKxuXr0bz5TLUMUhpKV2q/g6ghAb+eMsR82/ftJpjySxK
         qndCotbxSWhL6LBbTV6DnY2XZCqghNWOCG/SK0Rl2EGZtJMGUdIjbgk5cCg++9Odp/6S
         jMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710943546; x=1711548346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbVZj4I/+AtmVzGEkeHLDd9U7wOTVaVZVt9tQRs8U4g=;
        b=QiJl9psUJO/XPaEMo0raopSZC8q0TpYHkt6f7taB1Ld8rA2xi6Dzxr6yniNaWi6Zt+
         dMV2bp1U9OjgVZQZdSP/NOr+ImqKe6/aqfJSYhhKXo1hy4emdq6NAsmSPSw525sIMgtY
         PQ6qoLcPC1i886Cz+6kc4jmDHplEzmzJWeWAu2xeJModjmL13CEJmza61XEIcCVL5sjJ
         Cj7d6C9NXmy9RKYdJd/vzPfYpvPDXhj2/mkBulcxkjWjZmkQS/mqQ2O4XOcOK0E+UMVJ
         ScPUaL8G/xlFFXlZO5+jfJgZyK71/nBtoErX5wboBJ10TnP2yhXdtzkwbQXGaThlkQhP
         gqbw==
X-Forwarded-Encrypted: i=1; AJvYcCX2QuinpOlS5nq8tpIYcdf2FXuhI5jm4nQAhcvtg9QGt+ZSscRRkm9nvOpohQL3d5VUkNapuuUGAD30w4qZDHl1qVJraIc9rKz9ufiZj3vs5x/To6Xa6lKr0uVWLR+7Qk7HKVjNYELuutBPCx8=
X-Gm-Message-State: AOJu0YxaIUl8jdtMc6u7tWtdDqqSoc4vX1Vr37pWfOIW6o9dn1ib+K98
	6GjABzhYwFai7DPdYZlC3DN2tH9yMR5TQl2qAGNVxyK7lUJUm8uT
X-Google-Smtp-Source: AGHT+IHdFGTq79nxwV181SXlfpWpmVH8EOQMcMbibgVMzCRjKbbjt3OJomu78LqTAbfs0jIAcEVAMw==
X-Received: by 2002:ad4:46d4:0:b0:691:fcc:1518 with SMTP id pm20-20020ad446d4000000b006910fcc1518mr1677638qvb.65.1710943546178;
        Wed, 20 Mar 2024 07:05:46 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id k5-20020ad45be5000000b00690baf5cde9sm7854440qvc.118.2024.03.20.07.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 07:05:45 -0700 (PDT)
Message-ID: <a44f21e3-1773-4b56-b1f0-c03a6462a7c1@gmail.com>
Date: Wed, 20 Mar 2024 07:05:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: allocate dummy net_device dynamically
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>
Cc: kuba@kernel.org, keescook@chromium.org,
 "open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
 "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
References: <20240319185735.1268980-1-leitao@debian.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240319185735.1268980-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/19/2024 11:57 AM, Breno Leitao wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct ath11k_ext_irq_grp by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at ath11k_ahb_config_ext_irq() for ahb, and
> ath11k_pcic_ext_irq_config() for pcic.
> 
>   The free of the device occurs at ath11k_ahb_free_ext_irq() for the ahb
> case, and ath11k_pcic_free_ext_irq() for the pcic case.
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>   drivers/net/wireless/ath/ath11k/ahb.c  |  8 ++++++--
>   drivers/net/wireless/ath/ath11k/core.h |  2 +-
>   drivers/net/wireless/ath/ath11k/pcic.c | 21 +++++++++++++++++----
>   3 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
> index 7c0a23517949..a8d89f510f62 100644
> --- a/drivers/net/wireless/ath/ath11k/ahb.c
> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
> @@ -442,6 +442,7 @@ static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
>   			free_irq(ab->irq_num[irq_grp->irqs[j]], irq_grp);
>   
>   		netif_napi_del(&irq_grp->napi);
> +		free_netdev(irq_grp->napi_ndev);
>   	}
>   }
>   
> @@ -533,8 +534,11 @@ static int ath11k_ahb_config_ext_irq(struct ath11k_base *ab)
>   
>   		irq_grp->ab = ab;
>   		irq_grp->grp_id = i;
> -		init_dummy_netdev(&irq_grp->napi_ndev);
> -		netif_napi_add(&irq_grp->napi_ndev, &irq_grp->napi,
> +		irq_grp->napi_ndev = alloc_netdev(0, "dummy", NET_NAME_UNKNOWN,
> +						  init_dummy_netdev);

Is not this going to be a problem with multiple network device drivers 
loaded in a given system and all using "dummy" here? While 
NET_NAME_UNKNOWN ensures that this is not exposed to user-space, there 
is still this part of alloc_netdev_mqs() which is going to be non-unique:

         ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);
-- 
Florian

