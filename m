Return-Path: <linux-kernel+bounces-147485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF4A8A751A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2051C22812
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412C139588;
	Tue, 16 Apr 2024 19:49:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2F113792D;
	Tue, 16 Apr 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713296978; cv=none; b=d6BrqrLsPYF5q1kt/Su7/WVtscjPcp93oBDzKIYXVbLN+i3InX/zwk0YwKXGCZjgOzHdQ+5d8yLmmDkGkE13iEm3jA4aGGXmhtXyScywj7GX9HUgBXK7OX6Ok4PB0ZMtukpatsSkWWDZVdnFYYCmoEOEtKVFFv8uFXVrPoUu1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713296978; c=relaxed/simple;
	bh=ax3Hkz8by9sa3C0PHz6V5APRvHG6ooQ+PnH0zYUfSDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QG+u2WYLOhTjQb/eoyM9gcCh0bkqxwCUdAxuYVBIeR3F1v6j9lxqXHrN+7WAx2RS6HLh54J9xjGLEZv8GBGkvDd/8lqkkUIDiwNDpjlDT4NxYCUvb23AAlcKYqHVowpAFTxYa3LaN4X132J7Air9GtyuWQX+2EI9GHQkaslb+Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0143F339;
	Tue, 16 Apr 2024 12:50:03 -0700 (PDT)
Received: from [192.168.20.58] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93F4F3F738;
	Tue, 16 Apr 2024 12:49:30 -0700 (PDT)
Message-ID: <f18251ff-979f-42bb-9db4-8f7256c4ca4a@arm.com>
Date: Tue, 16 Apr 2024 14:49:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] riscv: cacheinfo: remove the useless parameter
 (node) of ci_leaf_init()
Content-Language: en-US
To: Yunhui Cui <cuiyunhui@bytedance.com>, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, bhelgaas@google.com, james.morse@arm.com,
 jhugo@codeaurora.org, john.garry@huawei.com, Jonathan.Cameron@huawei.com,
 pierre.gondois@arm.com, sudeep.holla@arm.com, tiantao6@huawei.com
References: <20240416031438.7637-1-cuiyunhui@bytedance.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20240416031438.7637-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Other than a comment in 2/3 this all (patches 1-3) looks sane to me. So:

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks,


On 4/15/24 22:14, Yunhui Cui wrote:
> The implementation of the ci_leaf_init() function body and the caller
> do not use the input parameter (struct device_node *node), so remove it.
> 
> Fixes: 6a24915145c9 ("Revert "riscv: Set more data to cacheinfo"")
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   arch/riscv/kernel/cacheinfo.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 09e9b88110d1..30a6878287ad 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -64,7 +64,6 @@ uintptr_t get_cache_geometry(u32 level, enum cache_type type)
>   }
>   
>   static void ci_leaf_init(struct cacheinfo *this_leaf,
> -			 struct device_node *node,
>   			 enum cache_type type, unsigned int level)
>   {
>   	this_leaf->level = level;
> @@ -80,11 +79,11 @@ int populate_cache_leaves(unsigned int cpu)
>   	int levels = 1, level = 1;
>   
>   	if (of_property_read_bool(np, "cache-size"))
> -		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
> +		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>   	if (of_property_read_bool(np, "i-cache-size"))
> -		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
> +		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
>   	if (of_property_read_bool(np, "d-cache-size"))
> -		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
> +		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
>   
>   	prev = np;
>   	while ((np = of_find_next_cache_node(np))) {
> @@ -97,11 +96,11 @@ int populate_cache_leaves(unsigned int cpu)
>   		if (level <= levels)
>   			break;
>   		if (of_property_read_bool(np, "cache-size"))
> -			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
> +			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>   		if (of_property_read_bool(np, "i-cache-size"))
> -			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
> +			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
>   		if (of_property_read_bool(np, "d-cache-size"))
> -			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
> +			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
>   		levels = level;
>   	}
>   	of_node_put(np);


