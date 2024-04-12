Return-Path: <linux-kernel+bounces-142767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C858A2FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1BB8B21FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D5E85948;
	Fri, 12 Apr 2024 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6MJz8cN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C184DFF;
	Fri, 12 Apr 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929918; cv=none; b=JnhRexF1AwwKWed2dQgimGvwYsbwFPulapqgwHi1pMFuG5wCufjSNXC3xK5NxeleHGeWDT7qcHh6P0IrEwkZ1oRa/GneLiMUkrkPbEUmIbKOGk6YriJU24N+jdrzDvpXMJ7G5+maPm+gGl1O/wfvHsDNP6PB0+MFwUROiJifFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929918; c=relaxed/simple;
	bh=uO3kNffPt8k6Rw16SW5d5r2nyLGqqfTi0dbeoGQYHb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfjLMx85MXP9svnlZD7Q1IJfhOXsRAtVeCPTKIPwzdf7xF4KfHoz8ek6PETNosRAJjZAD+5Nq5bksPiZ6Kj0L+y6JufTuxelgX7hFr5EtCQuGsmApZRFQ46AI/OuZ68t2+94dFluN7HJxltbHW4jy1Bxd6aOMmZyZlPfJ4SzY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6MJz8cN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB845C113CC;
	Fri, 12 Apr 2024 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712929917;
	bh=uO3kNffPt8k6Rw16SW5d5r2nyLGqqfTi0dbeoGQYHb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C6MJz8cNAjnyoHwQDegU15ad3V+cn/IzLHefnStqNB8OABQKrb+zcESQ/EENBPeHz
	 iscHoBx1l6hGSfwv3g21ZWMOExNMi2rPgMDz3Z0JK4cPh9QnCq9R6wEd7OT7sbPxGf
	 I1xlx3M9CEHaJ93aAmFdr6wrIPmFof8c4EDZGWmQUlupVxHvbHKbyY/rXQgqCITXD0
	 UGuH0/va4PurxwDcuB8pJ/t3Y3krObZxB2/1sJZcFXP6wNtIYJ2Q6SgDr5j+JHxjm4
	 bBQwYxhkCIc//HLBM/apynk9cA0zzT3/xtt4SI+JbUYiiGKVx5fyv+t7UK0v2Emxci
	 tZvKeDnLBsLrA==
Date: Fri, 12 Apr 2024 14:50:23 +0100
From: Simon Horman <horms@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH net-next v1 11/12] mm: page_frag: add a test module for
 page_frag
Message-ID: <20240412135023.GS514426@kernel.org>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-12-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407130850.19625-12-linyunsheng@huawei.com>

On Sun, Apr 07, 2024 at 09:08:48PM +0800, Yunsheng Lin wrote:
> Basing on the lib/objpool.c, change it to something like a
> ptrpool, so that we can utilize that to test the correctness
> and performance of the page_frag.
> 
> The testing is done by ensuring that the fragments allocated
> from a frag_frag_cache instance is pushed into a ptrpool
> instance in a kthread binded to the first cpu, and a kthread
> binded to the current node will pop the fragmemt from the
> ptrpool and call page_frag_alloc_va() to free the fragmemt.
> 
> We may refactor out the common part between objpool and ptrpool
> if this ptrpool thing turns out to be helpful for other place.
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

..

> diff --git a/mm/page_frag_test.c b/mm/page_frag_test.c

..

> +/* allocate and initialize percpu slots */
> +static int objpool_init_percpu_slots(struct objpool_head *pool,
> +				     int nr_objs, gfp_t gfp)
> +{
> +	int i;
> +
> +	for (i = 0; i < pool->nr_cpus; i++) {
> +		struct objpool_slot *slot;
> +		int size;
> +
> +		/* skip the cpu node which could never be present */
> +		if (!cpu_possible(i))
> +			continue;
> +
> +		size = struct_size(slot, entries, pool->capacity);
> +
> +		/*
> +		 * here we allocate percpu-slot & objs together in a single
> +		 * allocation to make it more compact, taking advantage of
> +		 * warm caches and TLB hits. in default vmalloc is used to
> +		 * reduce the pressure of kernel slab system. as we know,
> +		 * mimimal size of vmalloc is one page since vmalloc would

nit: minimal

> +		 * always align the requested size to page size
> +		 */
> +		if (gfp & GFP_ATOMIC)
> +			slot = kmalloc_node(size, gfp, cpu_to_node(i));
> +		else
> +			slot = __vmalloc_node(size, sizeof(void *), gfp,
> +					      cpu_to_node(i),
> +					      __builtin_return_address(0));
> +		if (!slot)
> +			return -ENOMEM;
> +
> +		memset(slot, 0, size);
> +		pool->cpu_slots[i] = slot;
> +
> +		objpool_init_percpu_slot(pool, slot);
> +	}
> +
> +	return 0;
> +}

..

> +static struct objpool_head ptr_pool;
> +static int nr_objs = 512;
> +static int nr_test = 5120000;
> +static atomic_t nthreads;
> +static struct completion wait;
> +struct page_frag_cache test_frag;

nit: Is test_frag used outside of this file?
     If not, should it be static?

..

