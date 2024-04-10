Return-Path: <linux-kernel+bounces-137837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B789E828
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DB11C22FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847B28BF0;
	Wed, 10 Apr 2024 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t1NH+D0G"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B23944D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712716275; cv=none; b=iolgS4jrbxLsCK/4WBjLt2i71eGjy/P11s3B4j2mAgdMRrMNwl4Rap0aVZ1sIevhXbu5gOGa7BXnq+UrUc4JbPZ81m87YXeaCQmM55bv5KyZXvJPOPApOss+TJ86eyF3FjkkcnaqEZO232eERkFwt/OpLgD7IJ3LtDJn/B5KHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712716275; c=relaxed/simple;
	bh=RxQ4w7eDmsIDInqOAbvW0AlFj3vygFD5++VGkUFw57A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWeDJF4zR0hsVOPgawAZjq682sqmkeBr2nZG3nOr96PjHewhTvUJ45xkxlzNJaHJ/Gn8UFaunoYMKHIR0yHuvnNMdibJcFBcbZsQ0HNogekqiC7mD1Lgqc4MlbxrFsYDCjVCREkQr8oXMLy7ZtzmHP1ZmrFHDxEGwvlnvAJHE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t1NH+D0G; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a340fb1a-7225-42d6-8a66-c6ac63bccaaa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712716271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXsqbKt2Eq9TaCWXeOVJD5QoPofr+kcc4LPka5x/Pxk=;
	b=t1NH+D0Gpi+dF65xdmLCN/lM3ADPR+TwbKusm6AxJCdStLdRsbsZ+M8IztThDKjDbOdJ9q
	0lcEVapmhLw5QOL416m/q4+eLpV77miJrYuRHj/oIJ4mfyUjODcMXd9q1tKFKwlpzyXmUq
	Go569l/w9giiIBa5QIYvW2ZnAw3KDLQ=
Date: Wed, 10 Apr 2024 10:31:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/5] mm: zswap: remove same_filled module params
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240405053510.1948982-1-yosryahmed@google.com>
 <20240405053510.1948982-6-yosryahmed@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240405053510.1948982-6-yosryahmed@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/4/5 13:35, Yosry Ahmed wrote:
> These knobs offer more fine-grained control to userspace than needed and
> directly expose/influence kernel implementation; remove them.
> 
> For disabling same_filled handling, there is no logical reason to refuse
> storing same-filled pages more efficiently and opt for compression.
> Scanning pages for patterns may be an argument, but the page contents
> will be read into the CPU cache anyway during compression. Also,
> removing the same_filled handling code does not move the needle
> significantly in terms of performance anyway [1].
> 
> For disabling non_same_filled handling, it was added when the compressed
> pages in zswap were not being properly charged to memcgs, as workloads
> could escape the accounting with compression [2]. This is no longer the
> case after commit f4840ccfca25 ("zswap: memcg accounting"), and using
> zswap without compression does not make much sense.
> 
> [1]https://lore.kernel.org/lkml/CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=khn1_TXvA@mail.gmail.com/
> [2]https://lore.kernel.org/lkml/19d5cdee-2868-41bd-83d5-6da75d72e940@maciej.szmigiero.name/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Nice cleanup!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Thanks.

> ---
>  mm/zswap.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 13869d18c13bd..b738435215218 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -140,19 +140,6 @@ static const struct kernel_param_ops zswap_accept_thr_param_ops = {
>  module_param_cb(accept_threshold_percent, &zswap_accept_thr_param_ops,
>  		&zswap_accept_thr_percent, 0644);
>  
> -/*
> - * Enable/disable handling same-value filled pages (enabled by default).
> - * If disabled every page is considered non-same-value filled.
> - */
> -static bool zswap_same_filled_pages_enabled = true;
> -module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
> -		   bool, 0644);
> -
> -/* Enable/disable handling non-same-value filled pages (enabled by default) */
> -static bool zswap_non_same_filled_pages_enabled = true;
> -module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
> -		   bool, 0644);
> -
>  /* Number of zpools in zswap_pool (empirically determined for scalability) */
>  #define ZSWAP_NR_ZPOOLS 32
>  
> @@ -1421,9 +1408,6 @@ static bool zswap_is_folio_same_filled(struct folio *folio, unsigned long *value
>  	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*page) - 1;
>  	bool ret = false;
>  
> -	if (!zswap_same_filled_pages_enabled)
> -		return false;
> -
>  	page = kmap_local_folio(folio, 0);
>  	val = page[0];
>  
> @@ -1512,9 +1496,6 @@ bool zswap_store(struct folio *folio)
>  		goto store_entry;
>  	}
>  
> -	if (!zswap_non_same_filled_pages_enabled)
> -		goto freepage;
> -
>  	/* if entry is successfully added, it keeps the reference */
>  	entry->pool = zswap_pool_current_get();
>  	if (!entry->pool)

