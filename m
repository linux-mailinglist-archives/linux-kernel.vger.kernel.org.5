Return-Path: <linux-kernel+bounces-30241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ECE831C11
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87E1B22DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2EB1E88E;
	Thu, 18 Jan 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RCB/Pm0N"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41841E527
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590689; cv=none; b=R+CrAHwxTnZxaWimq4G3NFfjAfp1iEJnUGBLoCEtAqVDV0JEz5xYNOTcuHQPCTeikeURR0KfbDeGGceXjyLwm9lezVpt1vOvhTRXedB5pxiyQgj8kBBDUvFlnk0YUBgdTRW85gfKVophE8G1mVGy9nD+HRWmy6q663gSqnaqz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590689; c=relaxed/simple;
	bh=ggYTZpEmIwOuDJfSBEFPOlRNL9D4+7ikr65MnXHKMc8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N68X8yrznPLJKn2i9viSDvsIHh1vayJFkbnOE3I0e+nZBmiHTIXC/hn4ody9HY18+MVt7jhlxin86WqlJlxa6R8RhoN4Ym+2R8miNPgoSVMASKrJ6EpE92ffspwxlPfYiJslzJnGB3AdKvTOEfhVXgQJ2/EFAMs7eCZjpFI+ZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RCB/Pm0N; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6806914dba7so77121706d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705590684; x=1706195484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+n3702DzjvE8I5kV3B0z7yiCOBGUE0gdpStZqeKioA=;
        b=RCB/Pm0NtX/dgCCmRhyd+/Ybokv/Mu9eXUuJMcDM+Q8HMtqYAdPMzefP7t+Buyc3ny
         5+BI8PlkWUekcCMScZnSviWwnq7SyQjfg9ZIqvoZOcEzInRWhtoCEv2Cl0BHdXkJk0YI
         ZbNHZ3JqfZ3tOmCZ4cS6cVFiJZeqjqOtRVzEov60KEhW23IjCyn+Ee2hIDsq9Ph9Rdzh
         krGcZyVbSbKUEDzS92aDOKJPFtPra8DZUGIKS7ZLLOOx9Px4JluPs4YdmUEAPpL+Otqm
         XlwV2atfIP9YAM1Zfku7t6DtQ45a46c+p7sDrOZl7ksuSPUFAncpZxUkhiIj7I0dOjbj
         bWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705590684; x=1706195484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+n3702DzjvE8I5kV3B0z7yiCOBGUE0gdpStZqeKioA=;
        b=XuQF0LvihFc3eOL/7mGP9By9kPsGCwgTL4Ne/TeKCSJAhpp+7RBsowNYfHIhSZGMeT
         7+1pAodKB6T/pWGiN3H6/+jaGLXxL6pqcTE9czw2Hkx+yYQLIEvAF9EYmfRCGXiizKDk
         tGrWwHcpWgagNp8CUom3UUcQUVFxkmDt+TKfmZ9Gj8vtJQuTWo48XNA3b0n3lE3Wn3wE
         0Y1OtwGd4089JxB6GbPtlgnh8B08RREqhr6gCAHkJquc5e+MOSyncy3SVH0dFij9GzYg
         PrhpwpSwljG6QhlSbshqYZI4Ryx6OSu8It9IwMqw3WqeNOB5qpkGW0xshBkrPgTbXnR9
         ofbw==
X-Gm-Message-State: AOJu0YxnmjpES8lFBc+PzpGd6h9r0O02EwKq8b0eUxAny5INb7HzGVHn
	oop/jE+RnJ+8cYXs80zpezFHjaVKsNg8YqGCS3afmfrZ5AiDG0712/GIUTcJ1JA=
X-Google-Smtp-Source: AGHT+IHuI1hfsw0fiD9pOlV/VA4wpxp5PF3DTKwIpiToe6fi39i/8ohEnl7jT9S2c/geBCDuE0ChWg==
X-Received: by 2002:a05:6214:5191:b0:681:7859:8d7f with SMTP id kl17-20020a056214519100b0068178598d7fmr894837qvb.81.1705590684757;
        Thu, 18 Jan 2024 07:11:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:dd09])
        by smtp.gmail.com with ESMTPSA id pd2-20020a056214490200b0068187a62fc0sm993203qvb.90.2024.01.18.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:11:24 -0800 (PST)
Date: Thu, 18 Jan 2024 10:11:23 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Chris Li <chriscli@google.com>,
	Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: split zswap rb-tree
Message-ID: <20240118151123.GH939255@cmpxchg.org>
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <20240117-b4-zswap-lock-optimize-v1-2-23f6effe5775@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117-b4-zswap-lock-optimize-v1-2-23f6effe5775@bytedance.com>

On Wed, Jan 17, 2024 at 09:23:19AM +0000, Chengming Zhou wrote:
> Each swapfile has one rb-tree to search the mapping of swp_entry_t to
> zswap_entry, that use a spinlock to protect, which can cause heavy lock
> contention if multiple tasks zswap_store/load concurrently.
> 
> Optimize the scalability problem by splitting the zswap rb-tree into
> multiple rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M),
> just like we did in the swap cache address_space splitting.
> 
> Although this method can't solve the spinlock contention completely, it
> can mitigate much of that contention. Below is the results of kernel build
> in tmpfs with zswap shrinker enabled:
> 
>      linux-next  zswap-lock-optimize
> real 1m9.181s    1m3.820s
> user 17m44.036s  17m40.100s
> sys  7m37.297s   4m54.622s
> 
> So there are clearly improvements.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

One minor nit:

> @@ -265,6 +266,10 @@ static bool zswap_has_pool;
>  * helpers and fwd declarations
>  **********************************/
>  
> +#define swap_zswap_tree(entry)					\
> +	(&zswap_trees[swp_type(entry)][swp_offset(entry)	\
> +		>> SWAP_ADDRESS_SPACE_SHIFT])

Make this a static inline function instead?

