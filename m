Return-Path: <linux-kernel+bounces-80990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 466E0866EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04738B264EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D6692FF;
	Mon, 26 Feb 2024 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eG3iAHed"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672DC200DA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937858; cv=none; b=cUcW3qySDjBxnBzmMATF7d9PbJas5QDZYlLbZhtGSopUhEkcs27QCl78lDMA1cmP0LvPQpNnHDVkb/sF2nlJXMh/3TtY64jsAL4Kk9uaC5EqrhLsktVkX5jjHTKdePXFHwZFoeTPa2/+5wEDykSsU3ZkZ7SRgnxNAyDGN2o/xfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937858; c=relaxed/simple;
	bh=euXXnvdMbMJMMfV4qlsZzqA+Y2K2gkmqFHN6luvwkDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrvaCfG9d2edZoNjmKsRH7g5jgJAjpAbkCMUvWAZmT/chYxg1qlHDowr6CdN3xbbE2vqDaCi3UGp1FwPv6uBE0e3hsFNBBBQYFK+GJ9mg9STUg0YQ2AS5SYIvX6AjiF571tTyX80zXZuEu7mm1uIa5DV8pKVzYCOJUtGsLLOU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eG3iAHed; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f4b7e424-8f43-4940-89f0-cdfffbf6bb4c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708937854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGvTh26T848JMN3BBqWYMoEdVO583KgJ9tSKxunJFKY=;
	b=eG3iAHedFz6CjYOcYV8vFg6YjWsHc5MirCyzm+JyrQ2Mni1FAtyC1+uK1men9uHOqAPs7/
	OisnnlkKQgBVV1caAbHf6o+d9AQgI2Y3HELcZJvvFuBU0Kl0//ioa+RKNO0cPyvnRkwVcp
	d1Zs90/JLO1DM4gSrwwzZ2MGcBMvWvg=
Date: Mon, 26 Feb 2024 16:57:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] erofs: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 vbabka@suse.cz, Xiongwei.Song@windriver.com
References: <20240224134749.829361-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224134749.829361-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:47, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete explicitly to avoid confusion
for users. Here we can just remove all its users, which has no any
functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/erofs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 9b4b66dcdd4f..8b6bf9ae1a59 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -885,7 +885,7 @@ static int __init erofs_module_init(void)
>  
>  	erofs_inode_cachep = kmem_cache_create("erofs_inode",
>  			sizeof(struct erofs_inode), 0,
> -			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT,
> +			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
>  			erofs_inode_init_once);
>  	if (!erofs_inode_cachep)
>  		return -ENOMEM;

