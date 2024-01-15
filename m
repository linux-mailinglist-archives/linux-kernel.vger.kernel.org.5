Return-Path: <linux-kernel+bounces-26481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47782E1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449DD1F22D66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFA91AABD;
	Mon, 15 Jan 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8ExDVAB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6619470
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3fde109f2so210585ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705350871; x=1705955671; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P+hIIiUGTA1gfR6oVyWhIVuLYG5c59pLAjuo8X++8ik=;
        b=O8ExDVABJcp4mhHz+Q86+GXuowK4KQmeMmxhAQAtBDyPT9ww4/93m3eHhFfPbV+ZLS
         yqMiss16D8d9lzDi/WNatfmw0r89xjCue20M8TbN4+UCZJ+Fc32ypvNUWYJ5mKhC5Kpk
         X/4oh77KRWPd9k3OMnSxseIk6uH/yadKtIbecquni0YoxFZ5TKjEm7osukERjVomCCu6
         u0v7CvDfYskWta4lQmQfwPzE6aqUSUB1PZ6An4Wd6eIYp1akSb6A9kQDxvo31ZQLWXYj
         7zk8906yyT94oiwYRkYG1MMP/k7i1Lj+7wvUG8yJX2oBlWxfz/sKJKTSd9DpsnSzoYl4
         +AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705350871; x=1705955671;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+hIIiUGTA1gfR6oVyWhIVuLYG5c59pLAjuo8X++8ik=;
        b=MqZ3/YuXHyZcQoQZyOq0jt9tb7znzkhKsJ2VpoikfN9mWpEg5js4kPlbhNbh78Wg96
         v5FwV2eFzDRcTvUB+Jc/dvjnPkhnA7tEBLJfvIn1uVDlX6caIDxHonmdqm3oOCKhj7no
         uNeepgAsXrqPxw/NDS2l7PsJ5OjJC0mjPtMo3ny2jPX0E4szIIxfxNc4D5PUH5Va/23n
         O+Ftg+ay9xf0ajS9JEvDw+4BpdI9JExkUNUEaj9z9GgphqRwsRAXmOFc9mv6KEj2Vc3w
         MQKPc3PLUy6/i25tWBTkXdKZnu9bGrbygwrOifBFuziOxbNdLZC4Pe97xJuSJwrwBeBU
         VH4Q==
X-Gm-Message-State: AOJu0Yx/KkA1HT2B0HdthvnEMZ6gZ53fPKzO9MGbdo/9Ygg1KL241sUX
	PGAD0nFMV4238lcssyhGT3QK4aKL4X6U
X-Google-Smtp-Source: AGHT+IFvKY3dNipbZ9E7YARrrSXjK+Fu4ZKIU/7WJEMZ5nonhHzI9it27UVskow8qjnk4PsO9o8f5w==
X-Received: by 2002:a17:902:ce8f:b0:1d4:55b3:45d9 with SMTP id f15-20020a170902ce8f00b001d455b345d9mr292456plg.6.1705350870685;
        Mon, 15 Jan 2024 12:34:30 -0800 (PST)
Received: from [2620:0:1008:15:fa9e:3266:a147:d436] ([2620:0:1008:15:fa9e:3266:a147:d436])
        by smtp.gmail.com with ESMTPSA id az2-20020a170902a58200b001cc1dff5b86sm7980707plb.244.2024.01.15.12.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:34:30 -0800 (PST)
Date: Mon, 15 Jan 2024 12:34:29 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Vern Hao <haoxing990@gmail.com>
cc: mgorman@techsingularity.net, akpm@linux-foundation.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Xin Hao <vernhao@tencent.com>
Subject: Re: [PATCH RFC v1 2/2] mm, pcp: add more detail info about high
 order page count
In-Reply-To: <20240115093437.87814-3-vernhao@tencent.com>
Message-ID: <4cc41592-2f1a-590a-962e-0cf56082a6b6@google.com>
References: <20240115093437.87814-1-vernhao@tencent.com> <20240115093437.87814-3-vernhao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jan 2024, Vern Hao wrote:

> From: Xin Hao <vernhao@tencent.com>
> 
> With this patch, we can see the distribution of pages of different orders on
> each cpu, just like below.
> 	#cat /proc/zoneinfo
>     ....
>     cpu: 2
>               total_count: 14286

I don't think we should be changing the naming of the field if there are 
existing users that parse /proc/zoneinfo.

>                   order0 : 1260
>                   order1 : 13
>                   order2 : 42
>                   order3 : 4
>                   order4 : 0
>                   order5 : 0
>                   order6 : 0
>                   order7 : 0
>                   order8 : 0
>                   order9 : 25
>                   order10: 0
>                   order11: 0
>                   order12: 0
>               high:  14541
>               batch: 63
> 
> Signed-off-by: Xin Hao <vernhao@tencent.com>
> ---
>  include/linux/mmzone.h |  1 +
>  mm/page_alloc.c        |  4 ++++
>  mm/vmstat.c            | 18 ++++++++++++------
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 883168776fea..55d25b4f51e5 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -684,6 +684,7 @@ enum zone_watermarks {
>  struct per_cpu_pages {
>  	spinlock_t lock;	/* Protects lists field */
>  	int total_count;	/* total number of pages in the list */
> +	int count[NR_PCP_LISTS]; /* per-order page counts */
>  	int high;		/* high watermark, emptying needed */
>  	int high_min;		/* min high watermark */
>  	int high_max;		/* max high watermark */
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4e91e429b8d1..7ec2dc5c5ea5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1228,6 +1228,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			list_del(&page->pcp_list);
>  			count -= nr_pages;
>  			pcp->total_count -= nr_pages;
> +			pcp->count[order] -= 1;
>  
>  			/* MIGRATE_ISOLATE page should not go to pcplists */
>  			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> @@ -2478,6 +2479,7 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
>  	pindex = order_to_pindex(migratetype, order);
>  	list_add(&page->pcp_list, &pcp->lists[pindex]);
>  	pcp->total_count += 1 << order;
> +	pcp->count[order] += 1;
>  
>  	batch = READ_ONCE(pcp->batch);
>  	/*
> @@ -2858,6 +2860,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  					migratetype, alloc_flags);
>  
>  			pcp->total_count += alloced << order;
> +			pcp->count[order] += alloced;
>  			if (unlikely(list_empty(list)))
>  				return NULL;
>  		}
> @@ -2865,6 +2868,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>  		page = list_first_entry(list, struct page, pcp_list);
>  		list_del(&page->pcp_list);
>  		pcp->total_count -= 1 << order;
> +		pcp->count[order] -= 1;
>  	} while (check_new_pages(page, order));
>  
>  	return page;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index c1e8096ff0a6..e04300ec450f 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1735,19 +1735,25 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
>  
>  	seq_printf(m, "\n  pagesets");
>  	for_each_online_cpu(i) {
> +		int j;
>  		struct per_cpu_pages *pcp;
>  		struct per_cpu_zonestat __maybe_unused *pzstats;
>  
>  		pcp = per_cpu_ptr(zone->per_cpu_pageset, i);
>  		seq_printf(m,
>  			   "\n    cpu: %i"
> -			   "\n              count: %i"
> -			   "\n              high:  %i"
> -			   "\n              batch: %i",
> +			   "\n              total_count: %i",
>  			   i,
> -			   pcp->total_count,
> -			   pcp->high,
> -			   pcp->batch);
> +			   pcp->total_count);
> +		for (j = 0; j < NR_PCP_LISTS; j++)
> +			seq_printf(m,
> +				   "\n                  order%-2i: %-3i",
> +				   j, pcp->count[j]);
> +		seq_printf(m,
> +                          "\n              high:  %i"
> +                          "\n              batch: %i",
> +                          pcp->high,
> +                          pcp->batch);
>  #ifdef CONFIG_SMP
>  		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, i);
>  		seq_printf(m, "\n  vm stats threshold: %d",
> -- 
> 2.31.1
> 
> 
> 

