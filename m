Return-Path: <linux-kernel+bounces-157374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C1A8B10BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4628B1C23110
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F7716C6A5;
	Wed, 24 Apr 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QB5gYiQP"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E919115B576
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978780; cv=none; b=mgUR2cz5Q7eoeszuKLhQzzrcjvBJMen62ExWJHFKvgbLkve8CwjvW3oNFY+ieB/DGJaIus6gQDZdYSk7Gh2NgMsUC2daXy0OISdBuSrnMBjDBIRM+GuBafND+aqneFZx+7mRA3ta/6z9Hq7mjEFFdsV9T3+pcxKNwY6uhwjIYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978780; c=relaxed/simple;
	bh=xNgSO6vavVOEj+spHOS2Yy+4B4uhfmmasqmmAlwbHDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKHAyuloZ+fJCAilQp1vuOKjETwFsWxkFVTo1kNMeIZRdmc2KBB6EnDsRbmGSfNuwXVKaALES13EjYMulJMIlMgnpP+nvonxmHfnSFBONHTakZoEq+yaviyKF/COlc/HfjSbkq1J7XWOEVzM99uuj0IUMnrjKvOrkfNZ6rEbyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QB5gYiQP; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2ab791bce6fso115738a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713978778; x=1714583578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxegVweWqPE61Ew53tJ0ETeROIZotZvlHjzQVwAHEps=;
        b=QB5gYiQPh1LsjY4SrHt0DgAy/FrJEAZ8TEyw6hb/W1JI5DZMrO+/kYdqXseyIhZE4t
         CY13+TA8L7Pbn2Eyq1He96am8RbCT3ke/5qq3m/iO3VJxAs83nwhztn8N0HDUVyuJFIV
         4rLINQrXz/ykDt8xoBZYSBEsO04HwAixL4h7092PQtQf8UFIfoPR2RTJbY/IZWRMfu2N
         4b3LVfw8iaKQexnTF0gbJk/htT1xhgfI7diVbW3n0lnXg4Sc5XS+TrVn+4zUpssCTvD+
         Ojq5Mr2wVuKJtRosI6R4AU5RadkBR2+8qKJeapLeKglGMpfR3TlhG4mxnDOkepT3QptT
         PyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713978778; x=1714583578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxegVweWqPE61Ew53tJ0ETeROIZotZvlHjzQVwAHEps=;
        b=TORpHmMklCkzoaWYcc8NBetzCXZHiyfKlMBGspHpM9ywd/sQ83xq2zJ1Fxtvb4aaii
         lwfaasU1DQ7VWwmNrov0Wh6eMe/Vju28rn/bc3tuJ2qdu1uqOsAV+VOxdRtvpZiNP1UG
         L/Lsb6QWubfxd8TBefYHeK8HJE4W0uQSkUUKk6VdiHXXWNoIgcRGgZcRsiSVdCL1uH1Y
         JHRYhGMVsdlOa2S5S36ypvQOofb4uxAP0/WcOFCpEXVEzbfreP1tifoWM1eAuE8aTie5
         aGqQRFPZFPqxqrcJCyqedWF9x9eNuDgF1fcT57XhbB8CAv1+zOkK1dkWjIWiQSeEw44u
         LKOw==
X-Forwarded-Encrypted: i=1; AJvYcCXsuxkDCZgjPwKbwafjyL+/WuuTWh7qeIjxbl9OrKWmBhNer5sD3Y2iJY40xHQCOf1rNG8dIXcr84ROsLTW0M9KCqFaIHBxsFz9lx4o
X-Gm-Message-State: AOJu0Yw8GqH/1rePxFT6RlkXuZVrys2Jm86du1c/npEg7TYiqLqNncOT
	i+cLQVl6sn4NpN29Z6jEVEgtjXpALQS4mL/Jb1e1mV3MFMoSeSiZ
X-Google-Smtp-Source: AGHT+IGwhhiu4+La+tG0OomZAWmseIzRLz3aE1iD1bwq3lJoIbnOV11f34aO0HHKjJs1M5qglz/5Zg==
X-Received: by 2002:a17:90b:1c0d:b0:2ae:1316:a4a with SMTP id oc13-20020a17090b1c0d00b002ae13160a4amr3131444pjb.4.1713978778201;
        Wed, 24 Apr 2024 10:12:58 -0700 (PDT)
Received: from [192.168.3.172] ([122.231.145.235])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903209100b001e45c0d6ce6sm12165046plc.306.2024.04.24.10.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 10:12:57 -0700 (PDT)
Message-ID: <1192295a-5b94-4c1a-b11c-7cd8ef0e62b7@gmail.com>
Date: Thu, 25 Apr 2024 01:12:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com, ryan.roberts@arm.com,
 david@redhat.com, baolin.wang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240424135148.30422-1-ioworker0@gmail.com>
 <20240424135148.30422-2-ioworker0@gmail.com>
Content-Language: en-US
From: Bang Li <libang.linux@gmail.com>
In-Reply-To: <20240424135148.30422-2-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Lance,

On 2024/4/24 21:51, Lance Yang wrote:

> At present, the split counters in THP statistics no longer include
> PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP split
> counters to monitor the frequency of mTHP splits. This will assist
> developers in better analyzing and optimizing system performance.
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>          split_page
>          split_page_failed
>          deferred_split_page
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>   include/linux/huge_mm.h |  3 +++
>   mm/huge_memory.c        | 14 ++++++++++++--
>   2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 56c7ea73090b..7b9c6590e1f7 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -272,6 +272,9 @@ enum mthp_stat_item {
>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>   	MTHP_STAT_ANON_SWPOUT,
>   	MTHP_STAT_ANON_SWPOUT_FALLBACK,
> +	MTHP_STAT_SPLIT_PAGE,
> +	MTHP_STAT_SPLIT_PAGE_FAILED,
> +	MTHP_STAT_DEFERRED_SPLIT_PAGE,
>   	__MTHP_STAT_COUNT
>   };
>   
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 055df5aac7c3..52db888e47a6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>   DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>   DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
> +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
> +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED);
> +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_PAGE);
>   
>   static struct attribute *stats_attrs[] = {
>   	&anon_fault_alloc_attr.attr,
> @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] = {
>   	&anon_fault_fallback_charge_attr.attr,
>   	&anon_swpout_attr.attr,
>   	&anon_swpout_fallback_attr.attr,
> +	&split_page_attr.attr,
> +	&split_page_failed_attr.attr,
> +	&deferred_split_page_attr.attr,
>   	NULL,
>   };
>   
> @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>   	struct anon_vma *anon_vma = NULL;
>   	struct address_space *mapping = NULL;
> -	bool is_thp = folio_test_pmd_mappable(folio);
> +	int order = folio_order(folio);
>   	int extra_pins, ret;
>   	pgoff_t end;
>   	bool is_hzp;
> @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   		i_mmap_unlock_read(mapping);
>   out:
>   	xas_destroy(&xas);
> -	if (is_thp)
> +	if (order >= HPAGE_PMD_ORDER)
>   		count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAILED);
> +	count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
> +				      MTHP_STAT_SPLIT_PAGE_FAILED);
>   	return ret;
>   }
>   
> @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
>   	if (list_empty(&folio->_deferred_list)) {
>   		if (folio_test_pmd_mappable(folio))
>   			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +		count_mthp_stat(folio_order(folio),
> +				MTHP_STAT_DEFERRED_SPLIT_PAGE);
>   		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
>   		ds_queue->split_queue_len++;
>   #ifdef CONFIG_MEMCG

My opinion can be ignored :). Would it be better to modify the 
deferred_split_folio
function as follows? I'm not sure.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c index 
055df5aac7c3..e8562e8630b1 100644 --- a/mm/huge_memory.c +++ 
b/mm/huge_memory.c @@ -3299,12 +3299,13 @@ void 
deferred_split_folio(struct folio *folio) struct mem_cgroup *memcg = 
folio_memcg(folio); #endif unsigned long flags; + int order = 
folio_order(folio); /* * Order 1 folios have no space for a deferred 
list, but we also * won't waste much memory by not adding them to the 
deferred list. */ - if (folio_order(folio) <= 1) + if (order <= 1) 
return; /* @@ -3325,8 +3326,9 @@ void deferred_split_folio(struct folio 
*folio) spin_lock_irqsave(&ds_queue->split_queue_lock, flags); if 
(list_empty(&folio->_deferred_list)) { - if 
(folio_test_pmd_mappable(folio)) + if (order >= HPAGE_PMD_ORDER) 
count_vm_event(THP_DEFERRED_SPLIT_PAGE); + count_mthp_stat(order, 
MTHP_STAT_DEFERRED_SPLIT_PAGE); list_add_tail(&folio->_deferred_list, 
&ds_queue->split_queue); ds_queue->split_queue_len++; #ifdef CONFIG_MEMCG thanks,
bang


