Return-Path: <linux-kernel+bounces-101354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8596C87A5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74E31C21C00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428993B789;
	Wed, 13 Mar 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ugu2wrmu"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C48D3A1B4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710325783; cv=none; b=a6qEtiXJ7YKGik1IMLnIw3X3SsyHNNpBC1VxkkTtc8CM/Q9/uLm1P6wxDGCDX1b2KNJg4X3/jP+t6XN+wq/vVPCDV4vAvbLMHYzi2zgczIYX4phNuLnUkOld3ZhcITOkgjkl5kuak2ekSnrIKX33KLcm5BETKg15XoKUiy9OGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710325783; c=relaxed/simple;
	bh=+BNsXKsv3Z99gUImvWqUbE2s/DQXyamyA3qt0L+MQz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0aiLbjxN6qlIlDNskf9uiz4j6x2w4G3v7xDxU3y7W/0+UTpd5Ds2wAMPqXrN/RIy37/0vB51VYQkeMxlghhro3tpE3oHhksxFmksgZAYHbc6OqRVcG699nprCWbHliby8ExGSry3prEleEnkbRS/FMOBP27kD4O+o+BBUTopaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ugu2wrmu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a465ddc2c09so43819566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 03:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710325779; x=1710930579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h90PwmEKgkeo9xq9N4xH2gsdxhkIDdIMs34ij43dsWo=;
        b=Ugu2wrmuyu6NFvXKbWdtg3weOKAgRlIEiHWP3VNbbZdlJiOdexwkh4dNOy7yaKs1RW
         uqZkPUDPodad8k0kNzZXegxLfajpSukpzS0Mrn9ZZqGyeUInLmOB9AX66O4BrhfrZyPZ
         M0HPgAneNOySnYSAQT+UZT8dS402/Cz/NSFlhHNfUZBe7jlvYXiRR6Dpv7fQ1w2YRGXJ
         x8y04YGYBi7505hZo8mQe4rl4ue7izrloCUPTD172X5yIdDffwvjItkknVKI2RidAWMk
         7TPaXNxAcGDnzEO7c5HCGqwSr1BBMSqoLBGk8zetLWvZlf+weW6qmOprTqjhb+zijTHu
         DRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710325779; x=1710930579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h90PwmEKgkeo9xq9N4xH2gsdxhkIDdIMs34ij43dsWo=;
        b=Jht/AiOzc+9nxiVNtu+9h9BK1pvsAAu99SwfG5QWnmMfK9X5Vk2EepQ5kt2S//MnKy
         OUNZOQpmZvU0T+aEkBNtWEEQykBqzkI4e71FSetS6MHMKDzfjb8/NdA1O4fmcaSUWyLR
         PXcK9RurN5LjRncYeWiwPkRGRKE/NoCdyJuTg5rlphBwY8B17N214H/xw7QzWRyVbEIh
         R2rndhXTZfjcvR8NTBu5YmimCFP/HuiqkX+/FdgPJS7RgRJ7vygMt2DHtXkISGQ2plVq
         UijjVg/TucJMjILxRMOeuqaLHo6QuBbcvlmeMmgt+u+cFWxGC3GQ4mtqNO28+7zauiG9
         IUsg==
X-Forwarded-Encrypted: i=1; AJvYcCWhaEYYrdPNpvWu3Qy/X8P7PRT4vtqGayfuqQtBwdyXkY1TaOeNEwm50QycxxXD8c68yc2fM3OG+aTrZSBIU7xQDmlMiM/rq7MfzElY
X-Gm-Message-State: AOJu0Yw7xUqhDQKJpPSikU8DhVsf5018LYxUMfN9+6S0pHeGH8Gdzbug
	U6rYkgCjCyDzSCLF0BgrHhL7HcXtXbuwFxNHcSy1JML7WNQFr+Pf7ojsAXhR8bc=
X-Google-Smtp-Source: AGHT+IGQ9hru+o0CKXheTMDFWVHZM9tnEJyYpndf58cTWLJjL9Sxz6u4h7l6Y7AZXNJmefNCTejN5A==
X-Received: by 2002:a17:906:5917:b0:a44:4c9e:85ef with SMTP id h23-20020a170906591700b00a444c9e85efmr6327478ejq.77.1710325779403;
        Wed, 13 Mar 2024 03:29:39 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:73a8:7285:c2ff:fedd:7e3a? ([2a10:bac0:b000:73a8:7285:c2ff:fedd:7e3a])
        by smtp.gmail.com with ESMTPSA id nb31-20020a1709071c9f00b00a46006bc7e9sm4594377ejc.159.2024.03.13.03.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 03:29:39 -0700 (PDT)
Message-ID: <d167bf69-64f7-4b7b-81ee-054f05d39c98@suse.com>
Date: Wed, 13 Mar 2024 12:29:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] x86/boot: replace __PHYSICAL_START with
 LOAD_PHYSICAL_ADDR
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
 <20240313075839.8321-3-richard.weiyang@gmail.com>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240313075839.8321-3-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.03.24 г. 9:58 ч., Wei Yang wrote:
> Both __PHYSICAL_START and LOAD_PHYSICAL_ADDR are defined to get aligned
> CONFIG_PHYSICAL_START, so we can replace __PHYSICAL_START with
> LOAD_PHYSICAL_ADDR. And then remove the definition of __PHYSICAL_START,
> which is only used to define __START_KERNEL.
> 
> Since <asm/boot.h> includes <asm/pgtable_types.h>, which includes
> <asm/page_types.h>, it is fine to move definition from <asm/boot.h> to
> <asm/page_types.h>.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>   arch/x86/include/asm/boot.h       | 5 -----
>   arch/x86/include/asm/page_types.h | 8 +++++---
>   2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
> index a38cc0afc90a..12cbc57d0128 100644
> --- a/arch/x86/include/asm/boot.h
> +++ b/arch/x86/include/asm/boot.h
> @@ -6,11 +6,6 @@
>   #include <asm/pgtable_types.h>
>   #include <uapi/asm/boot.h>
>   
> -/* Physical address where kernel should be loaded. */
> -#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
> -				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
> -				& ~(CONFIG_PHYSICAL_ALIGN - 1))
> -
>   /* Minimum kernel alignment, as a power of two */
>   #ifdef CONFIG_X86_64
>   # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
> diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
> index 86bd4311daf8..acc1620fd121 100644
> --- a/arch/x86/include/asm/page_types.h
> +++ b/arch/x86/include/asm/page_types.h
> @@ -31,10 +31,12 @@
>   
>   #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
>   
> -#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
> -				      CONFIG_PHYSICAL_ALIGN)
> +/* Physical address where kernel should be loaded. */
> +#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
> +				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
> +				& ~(CONFIG_PHYSICAL_ALIGN - 1))

Why don't you simply define LOAD_PHYSICAL_ADDR via 
ALIGN(CONFIG_PHYSICAL_START, CONFIG_PHYSICAL_ALING) it's way more readable.

>   
> -#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
> +#define __START_KERNEL		(__START_KERNEL_map + LOAD_PHYSICAL_ADDR)
>   
>   #ifdef CONFIG_X86_64
>   #include <asm/page_64_types.h>

