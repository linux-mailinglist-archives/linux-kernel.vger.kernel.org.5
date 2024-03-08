Return-Path: <linux-kernel+bounces-96828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844278761F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BC81C2149C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E82854672;
	Fri,  8 Mar 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iM+wuZR2"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225DF53E1A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893693; cv=none; b=Gqf1fpD/dtk0zm9FfoSvTXaldsfpEgtx+KBQhCaT0FReQggF7sboU6KsHqHMIdCwHrxdiDr1VDLnrvySR3WwQ+dZwQIjRvsdbasFabpK9LCMykEIrgtrzNual6qxEVIaO6cd2O7lhEQPRzAg+LGVVuKSZzBhc1qmuFI4uKHSAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893693; c=relaxed/simple;
	bh=SkCmbVseqTChv+k4hU/N5P8H84yWE+pvBjawPWM4LOk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWZt6Jcgy43idfurdhcNQmgNN9fgQx7GuuFlb6xzc9whDrZdH3LiliAz2LLGrusH92XiPALGCo+E8esk5LvccIwbPv6c5J38J6ci/HgrkKLXm2knRhhUZVGM2KIK2XaOJYbnkpGLSrVrC6iQWS7wU88WLstnNhq1ZCBDmlzHAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iM+wuZR2; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51326436876so2498997e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709893690; x=1710498490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBDERlcMFtZu/muYJ2+aOhb4NEueDDD1cqxDNs7/Kqs=;
        b=iM+wuZR2YeN7cZriuyx+2l/st6eA4K4ocm2u4qPY5pE4rF7T3Y2Ir+fB+dn2wGMx6r
         YtMuNPTGrFA19cquzxsDHl2jaDBWpoAWiyM9CJ22KjQvR4mDKEXSnxCoaOAjCKetAsmG
         ctvIdvYvY/UUWI30xdsxZcXOIuiGhWrQ7BZwJMDg3bQu+vskThEUkspsOgt0X9aF+ZNP
         3Y/iyuwZ6VSJ4jmw9rXcGM8d0l48GZl3GdvYfoTvy9HIbWAZ3gv3nsdMkBVgylCd3fUa
         rwUMiqohO4ivHHJZTXSBhRPbPhG7Z5yUh2nDEnzOx341c0R3Mwl3dOJEs++B/TgiacpI
         z2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709893690; x=1710498490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBDERlcMFtZu/muYJ2+aOhb4NEueDDD1cqxDNs7/Kqs=;
        b=qCRJV1qS92nNL8N+LWjWmgZQVurmYJmKUbiOnX7ojzcZ3z36lbB+f84d+9oZAIYD9i
         5gtylL5AT4sqOGGW/1LcUY80MlPtQmYuQNZl3/SxjRvFaWWKA+LMdD8FGxop6ANw8U9F
         z7h2Se7OcHpDzGEiJCzub0kVChpDmOO433hVNVHvcO/JjE8onaJMNNG19UjHNONiE3i8
         TsUbO2nh+LVA1DPTHzGBzqKXlYbXO+h+9p3AqepDccph4bbGzFRf/MdVPFvZDj1yjZpH
         tLD5SClAo6jQ8c2Plz5IRPo3Us0j29rewpKzEpbsK5hQzTAuZO06R/BMQ7jN/2UmlLUu
         YHbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEn8c6j/SnBb+ojH0xrY6HHyqoFGKVBVKlHb5TaBOIsU5MRViI1SPX9ogDCjPyjFcl34ByT1FmZTg1Yt0xwkWA9YEyncpvRZhqQMFz
X-Gm-Message-State: AOJu0Yxq9Z8jfRAQIV4xOBy41GvZP1q7ra/cMmZBMlQ6t8wzjZzh91Oc
	ymCGALECJbnsgEgRO7/fUOM4o7EtrKRRC6iPmVcl+Z+CFDuG1rjUUvhP95XqN/4=
X-Google-Smtp-Source: AGHT+IEMWl0js3+29IRQOofJrkKm0NRvkzc7iWaN92QgEAsMgbOrM9gjzbja4OSrLul7AlcHmIBDrw==
X-Received: by 2002:ac2:47f3:0:b0:512:cda1:9bab with SMTP id b19-20020ac247f3000000b00512cda19babmr3031431lfp.13.1709893689854;
        Fri, 08 Mar 2024 02:28:09 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id i15-20020a0565123e0f00b00512851da32esm1238742lfv.248.2024.03.08.02.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:28:08 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 8 Mar 2024 11:28:05 +0100
To: Baoquan He <bhe@redhat.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, rulinhuang <rulin.huang@intel.com>,
	akpm@linux-foundation.org, colin.king@intel.com, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lstoakes@gmail.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	wangyang.guo@intel.com, zhiguo.zhou@intel.com
Subject: Re: [PATCH v7 1/2] mm/vmalloc: Moved macros with no functional
 change happened
Message-ID: <ZeroNTcyEMx6jiZF@pc636>
References: <20240301155417.1852290-1-rulin.huang@intel.com>
 <20240301155417.1852290-2-rulin.huang@intel.com>
 <Zei9n-VMxtzG8z4Y@pc636>
 <ZekW/nGXfTqOlvPZ@MiWiFi-R3L-srv>
 <ZeoSiP-hOeHG89BJ@pc638.lan>
 <ZerLB/LNWAOvC2HM@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZerLB/LNWAOvC2HM@MiWiFi-R3L-srv>

> > I would remove it, because it is really hard to mess it, there is only
> > one place also BUG_ON() is really a show stopper. I really appreciate
> > what rulinhuang <rulin.huang@intel.com> is doing and i understand that
> > it might be not so easy.
> 
> I agree, I was hesitant, now it firms up my mind.
> 
> > 
> > So, if we can avoid of moving the code, that looks to me that we can do,
> > if we can pass less arguments into alloc_vmap_area() since it is overloaded 
> > that would be great.
> 
> Agree too, less arguments is much better. While I personnally prefer the open
> coding a little bit like below. There is suspicion of excessive packaging in
> __pre/__post_setup_vmalloc_vm() wrapping. They are very simple and few
> assignments after all. 
> 
> ---
>  mm/vmalloc.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 0fd8ebaad17b..0c738423976d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1924,8 +1924,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  				unsigned long align,
>  				unsigned long vstart, unsigned long vend,
>  				int node, gfp_t gfp_mask,
> -				unsigned long va_flags, struct vm_struct *vm,
> -				unsigned long flags, const void *caller)
> +				unsigned long va_flags, struct vm_struct *vm)
>  {
>  	struct vmap_node *vn;
>  	struct vmap_area *va;
> @@ -1988,8 +1987,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	va->vm = NULL;
>  	va->flags = (va_flags | vn_id);
>  
> -	if (vm)
> -		setup_vmalloc_vm(vm, va, flags, caller);
> +	if (vm) {
> +		vm->addr = (void *)va->va_start;
> +		vm->size = va->va_end - va->va_start;
> +		va->vm = vm;
> +	}
>  
>  	vn = addr_to_node(va->va_start);
>  
> @@ -2565,8 +2567,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	va = alloc_vmap_area(VMAP_BLOCK_SIZE, VMAP_BLOCK_SIZE,
>  					VMALLOC_START, VMALLOC_END,
>  					node, gfp_mask,
> -					VMAP_RAM|VMAP_BLOCK, NULL,
> -					0, NULL);
> +					VMAP_RAM|VMAP_BLOCK, NULL);
>  	if (IS_ERR(va)) {
>  		kfree(vb);
>  		return ERR_CAST(va);
> @@ -2924,7 +2925,7 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node)
>  		va = alloc_vmap_area(size, PAGE_SIZE,
>  				VMALLOC_START, VMALLOC_END,
>  				node, GFP_KERNEL, VMAP_RAM,
> -				NULL, 0, NULL);
> +				NULL);
>  		if (IS_ERR(va))
>  			return NULL;
>  
> @@ -3063,7 +3064,10 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (!(flags & VM_NO_GUARD))
>  		size += PAGE_SIZE;
>  
> -	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area, flags, caller);
> +	area->flags = flags;
> +	area->caller = caller;
> +
> +	va = alloc_vmap_area(size, align, start, end, node, gfp_mask, 0, area);
>  	if (IS_ERR(va)) {
>  		kfree(area);
>  		return NULL;
> -- 
> 2.41.0
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Looks even better :) It can be applied on on top of:

[PATCH v8] mm/vmalloc: Eliminated the lock contention from twice to once

We are a bit ahead since v8 will be taken later. Anyway please use the
reviewed-by tag once you send a complete patch. 

Thanks!

--
Uladzislau Rezki

