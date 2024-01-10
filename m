Return-Path: <linux-kernel+bounces-22480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAEE829E50
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A231A283586
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E3A4CB30;
	Wed, 10 Jan 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaPuwMgM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E854CB28
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704903343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JQxzPoBqUkjJKXWCpI4QIxSuMVYFE8rWv0kuA2EoYm0=;
	b=LaPuwMgMSeRgzBofTYCT5alcc7k7Q9hJyVr54sQP6tuIpDPNUY9P2t/FIA37tPwpUxfoa8
	g5gxxLwIgss2OIA0HvhfxZr/KTdYEqAWlzvzjoADZ/Tj7zo70eDPr+tLs3bBicgFl0MGWJ
	vpIJWmNgORe5dsGhHeRZeuned9t1ia0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-eEjgliXvNZKlKOq4Xw8asQ-1; Wed, 10 Jan 2024 11:15:41 -0500
X-MC-Unique: eEjgliXvNZKlKOq4Xw8asQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e435a606aso24848665e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:15:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704903340; x=1705508140;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQxzPoBqUkjJKXWCpI4QIxSuMVYFE8rWv0kuA2EoYm0=;
        b=o8tcCu2X4xACUwZu4kTI+sGzV2CrC1XimPKJjIg7gdXaBjatAJdhrYe8kPSUCwPyOJ
         g4Kz+0G25hcJgDvv/TzC90aDwjeMeeg0LB078MKq9bZPlvgY/L+vkw3hqCyQLK3xWbiR
         3DyL0ziRCgRkpu3h5agtN+rQKdTtD1bu86D4mlaT+YpBZT2UxWfQXP4yYqWy6hdTkzz/
         bNgb434dgGzti4mPwUaUUbaPuiybJeEaIKNx3M18dFlMxzZUJ0oF9VUHNQq+YE5e86rB
         sV0ONuQNBAhv2nxQm5ICrBknAnvx9IyvD9xjtCOfU/j1jsCImPP/6GKs4ZNgPvlkcd/V
         PIPw==
X-Gm-Message-State: AOJu0YzHfYbYa9mLX8QbLg/GV3UYX9XsVixs+Cd8P5wOQ9l/XEV0zQbz
	Qy/pVkfW2Btnr5RmAH8/dmI+5facxvP/ykkmRIi/pR3VS9lzV48e00rsGKBOECkXzqqp6dNdGAq
	NAeLXwQuXX+l018epZNVTiXoro9X8eCFm
X-Received: by 2002:a05:600c:3510:b0:40e:4e48:513b with SMTP id h16-20020a05600c351000b0040e4e48513bmr720154wmq.12.1704903340596;
        Wed, 10 Jan 2024 08:15:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDdldLwwCSeXTFyJAvZ2n3LbY4rJaPZI27i6HIK+nCTWMLKPz0evEsDOQ0W3aAHG8r6+AbnA==
X-Received: by 2002:a05:600c:3510:b0:40e:4e48:513b with SMTP id h16-20020a05600c351000b0040e4e48513bmr720145wmq.12.1704903340170;
        Wed, 10 Jan 2024 08:15:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c73d:de00:7cf7:9482:e5dc:6ad0? (p200300cbc73dde007cf79482e5dc6ad0.dip0.t-ipconnect.de. [2003:cb:c73d:de00:7cf7:9482:e5dc:6ad0])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c000900b0040b3d8907fesm2583491wmc.29.2024.01.10.08.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 08:15:39 -0800 (PST)
Message-ID: <23bfe8cc-cffe-4832-a1fb-322f30f98f20@redhat.com>
Date: Wed, 10 Jan 2024 17:15:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory_hotplug: fix memmap_on_memory sysfs value
 retrieval
Content-Language: en-US
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-mm <linux-mm@kvack.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <20240110140127.241451-1-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240110140127.241451-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.24 15:01, Sumanth Korikkar wrote:
> The set_memmap_mode() function stores the kernel parameter memmap mode
> as an integer. However, the get_memmap_mode() function utilizes
> param_get_bool() to fetch the value as a boolean, leading to potential
> endianness issue. On Big-endian architectures, the memmap_on_memory is
> consistently displayed as 'N' regardless of its actual status.
> 
> To address this endianness problem, the solution involves obtaining the
> mode as an integer. This adjustment ensures the proper display of the
> memmap_on_memory parameter, presenting it as one of the following
> options: Force, Y, or N.
> 
> Fixes: 2d1f649c7c08 ("mm/memory_hotplug: support memmap_on_memory when memmap is not aligned to pageblocks")
> Suggested-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # v6.6+
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   mm/memory_hotplug.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b944e8bf1911..707027f69150 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -101,9 +101,11 @@ static int set_memmap_mode(const char *val, const struct kernel_param *kp)
>   
>   static int get_memmap_mode(char *buffer, const struct kernel_param *kp)
>   {
> -	if (*((int *)kp->arg) == MEMMAP_ON_MEMORY_FORCE)
> -		return sprintf(buffer,  "force\n");
> -	return param_get_bool(buffer, kp);
> +	int mode = *((int *)kp->arg);
> +
> +	if (mode == MEMMAP_ON_MEMORY_FORCE)
> +		return sprintf(buffer, "force\n");
> +	return sprintf(buffer, "%c\n", mode ? 'Y' : 'N');
>   }

I was wondering if we want to return "Y" instead of "force". But using 
force seems more consistent.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


