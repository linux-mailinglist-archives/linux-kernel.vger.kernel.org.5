Return-Path: <linux-kernel+bounces-3432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79014816C29
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C00C8B218A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C950199BF;
	Mon, 18 Dec 2023 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPrwcFgy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56418E1B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702898985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GSd7La5h0M9e2qVPUNvunxZbxK4L5T2M7NX5H+PBXVk=;
	b=YPrwcFgy+ibVOtXmOaNpyEJ+FwMGoUN734HNZ+I+2/0AkWdHGKjae7oL25phVVncNdcB+0
	m0QXjCJEQgju+eyPE75c8xt1inwz+k+GhQ0rllWkIOT31jUykpZ4dwfmaify2gXo4QygS3
	9JrlQMfnaqTv8aXM5sqyRkqq8GT4hPU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-m6HGHiyKOGWXIePzZvPZZw-1; Mon, 18 Dec 2023 06:29:44 -0500
X-MC-Unique: m6HGHiyKOGWXIePzZvPZZw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33652ced20fso2122665f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702898983; x=1703503783;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSd7La5h0M9e2qVPUNvunxZbxK4L5T2M7NX5H+PBXVk=;
        b=GP0F1vHRWdYjMCldJnQWczs0D2h1lF0h8gD2gmYEa7CyyD38I0MenCr2aVmvxnKNYI
         MGIG7+SHE60wHGd9On2FBa+PEd0LJJ+vm5Zo2medZKNHhwAFfEMfO9wFPEczpjV4pjRc
         axgOXkf9bvesdHq0XF3vNuYNOPHpVSfy27bRgj8UU+X4LUHuOqJtm/jw1jMvTP0/nJdP
         uV2k75x1YgYch3qlMqJu8+W5UXVR7uD0OnjNwD3NbxHP8Sn2h0oVKDyG5FCdn617Tkib
         4mXgm2Wgv++UMOoqzcboXLw305DC2lUGleU11RFX9n9L5PorMiyQSjHxJIFoscj6LVca
         NezQ==
X-Gm-Message-State: AOJu0YwXjTsnCdKIWpKyH/DJ4W3djidsMndjvZR2G4gY7RIDVdsOTbI1
	ZoBgjsBKdRGantPN+YAIlJ7xSeUV7QhRlNl79TY9/eL4s9pIMpwyAAjOPNLARqipwaHcVwVAW12
	+FheuZcJq2xSvJsHHZJEc8cCg
X-Received: by 2002:adf:ef04:0:b0:336:6907:cbb4 with SMTP id e4-20020adfef04000000b003366907cbb4mr472476wro.53.1702898983030;
        Mon, 18 Dec 2023 03:29:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSYs8MX72nGp36XBQBg4VQAgzg9jXe+N+wQBLnawj0g5rPEg6QHYh8Pl/GzzsFyY2vnJR3ZA==
X-Received: by 2002:adf:ef04:0:b0:336:6907:cbb4 with SMTP id e4-20020adfef04000000b003366907cbb4mr472462wro.53.1702898982551;
        Mon, 18 Dec 2023 03:29:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c72b:b500:b53e:6e32:1408:27ac? (p200300cbc72bb500b53e6e32140827ac.dip0.t-ipconnect.de. [2003:cb:c72b:b500:b53e:6e32:1408:27ac])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b003364360839esm13204369wrx.81.2023.12.18.03.29.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 03:29:42 -0800 (PST)
Message-ID: <07c3d204-8285-46d2-b7fa-c63800bd7073@redhat.com>
Date: Mon, 18 Dec 2023 12:29:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] mm/ksm: add ksm advisor
Content-Language: en-US
To: Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231213182729.587081-1-shr@devkernel.io>
 <20231213182729.587081-2-shr@devkernel.io>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231213182729.587081-2-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.12.23 19:27, Stefan Roesch wrote:
> This adds the ksm advisor. The ksm advisor automatically manages the
> pages_to_scan setting to achieve a target scan time. The target scan
> time defines how many seconds it should take to scan all the candidate
> KSM pages. In other words the pages_to_scan rate is changed by the
> advisor to achieve the target scan time. The algorithm has a max and min
> value to:
> - guarantee responsiveness to changes
> - limit CPU resource consumption
> 
> The respective parameters are:
> - ksm_advisor_target_scan_time (how many seconds a scan should take)
> - ksm_advisor_max_cpu (maximum value for cpu percent usage)
> 
> - ksm_advisor_min_pages (minimum value for pages_to_scan per batch)
> - ksm_advisor_max_pages (maximum value for pages_to_scan per batch)
> 
> The algorithm calculates the change value based on the target scan time
> and the previous scan time. To avoid pertubations an exponentially
> weighted moving average is applied.
> 
> The advisor is managed by two main parameters: target scan time,
> cpu max time for the ksmd background thread. These parameters determine
> how aggresive ksmd scans.
> 
> In addition there are min and max values for the pages_to_scan parameter
> to make sure that its initial and max values are not set too low or too
> high. This ensures that it is able to react to changes quickly enough.
> 
> The default values are:
> - target scan time: 200 secs
> - max cpu: 70%
> - min pages: 500
> - max pages: 30000
> 
> By default the advisor is disabled. Currently there are two advisors:
> none and scan-time.
> 
> Tests with various workloads have shown considerable CPU savings. Most
> of the workloads I have investigated have more candidate pages during
> startup, once the workload is stable in terms of memory, the number of
> candidate pages is reduced. Without the advisor, the pages_to_scan needs
> to be sized for the maximum number of candidate pages. So having this
> advisor definitely helps in reducing CPU consumption.
> 
> For the instagram workload, the advisor achieves a 25% CPU reduction.
> Once the memory is stable, the pages_to_scan parameter gets reduced to
> about 40% of its max value.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   mm/ksm.c | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 160 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 7efcc68ccc6ea..4f7b71a1f3112 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -21,6 +21,7 @@
>   #include <linux/sched.h>
>   #include <linux/sched/mm.h>
>   #include <linux/sched/coredump.h>
> +#include <linux/sched/cputime.h>
>   #include <linux/rwsem.h>
>   #include <linux/pagemap.h>
>   #include <linux/rmap.h>
> @@ -248,6 +249,9 @@ static struct kmem_cache *rmap_item_cache;
>   static struct kmem_cache *stable_node_cache;
>   static struct kmem_cache *mm_slot_cache;
>   
> +/* Default number of pages to scan per batch */
> +#define DEFAULT_PAGES_TO_SCAN 100
> +
>   /* The number of pages scanned */
>   static unsigned long ksm_pages_scanned;
>   
> @@ -276,7 +280,7 @@ static unsigned int ksm_stable_node_chains_prune_millisecs = 2000;
>   static int ksm_max_page_sharing = 256;
>   
>   /* Number of pages ksmd should scan in one batch */
> -static unsigned int ksm_thread_pages_to_scan = 100;
> +static unsigned int ksm_thread_pages_to_scan = DEFAULT_PAGES_TO_SCAN;
>   
>   /* Milliseconds ksmd should sleep between batches */
>   static unsigned int ksm_thread_sleep_millisecs = 20;
> @@ -297,6 +301,155 @@ unsigned long ksm_zero_pages;
>   /* The number of pages that have been skipped due to "smart scanning" */
>   static unsigned long ksm_pages_skipped;
>   
> +/* Don't scan more than max pages per batch. */
> +static unsigned long ksm_advisor_max_pages = 30000;
> +
> +/* At least scan this many pages per batch. */
> +static unsigned long ksm_advisor_min_pages = 500;
> +
> +/* Min CPU for scanning pages per scan */
> +static unsigned int ksm_advisor_min_cpu =  10;

That will never be modified, right? Either mark it const or just turn it 
into a define.

[...]

> +/*
> + * The scan time advisor is based on the current scan rate and the target
> + * scan rate.
> + *
> + *      new_pages_to_scan = pages_to_scan * (scan_time / target_scan_time)
> + *
> + * To avoid perturbations it calculates a change factor of previous changes.
> + * A new change factor is calculated for each iteration and it uses an
> + * exponentially weighted moving average. The new pages_to_scan value is
> + * multiplied with that change factor:
> + *
> + *      new_pages_to_scan *= change facor
> + *
> + * The new_pages_to_scan value is limited by the cpu min and max values. It
> + * calculates the cpu percent for the last scan and calculates the new
> + * estimated cpu percent cost for the next scan. That value is capped by the
> + * cpu min and max setting.
> + *
> + * In addition the new pages_to_scan value is capped by the max and min
> + * limits.
> + */
> +static void scan_time_advisor(void)
> +{
> +	unsigned int cpu_percent;
> +	unsigned long cpu_time;
> +	unsigned long cpu_time_diff;
> +	unsigned long cpu_time_diff_ms;
> +	unsigned long pages;
> +	unsigned long per_page_cost;
> +	unsigned long factor;
> +	unsigned long change;
> +	unsigned long last_scan_time;
> +	unsigned long scan_time;
> +
> +	/* Convert scan time to seconds */
> +	scan_time = div_s64(ktime_ms_delta(ktime_get(), advisor_ctx.start_scan),
> +			    MSEC_PER_SEC);
> +	scan_time = scan_time ? scan_time : 1;
> +
> +	/* Calculate CPU consumption of ksmd background thread */
> +	cpu_time = task_sched_runtime(current);
> +	cpu_time_diff = cpu_time - advisor_ctx.cpu_time;
> +	cpu_time_diff_ms = cpu_time_diff / 1000 / 1000;
> +
> +	cpu_percent = (cpu_time_diff_ms * 100) / (scan_time * 1000);
> +	cpu_percent = cpu_percent ? cpu_percent : 1;
> +	last_scan_time = prev_scan_time(&advisor_ctx, scan_time);

I'd simply inline prev_scan_time() here and get rid of it. Whatever you 
think is best.


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


