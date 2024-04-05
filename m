Return-Path: <linux-kernel+bounces-133367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6176689A2E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E711C22939
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863D5171645;
	Fri,  5 Apr 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="piJPZuR3"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3176720B0F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335824; cv=none; b=sq8GNA0rdXPBnxdsauMlxwdvSG8t+dzjKjLcgNiTn8OZbVm5ulmSu/sxPqFkrHioWW/XcgaEgJiGnEwp0ebLTPebmsXLXaKhU2hwnZ23M1kLs1QaZkoZCA9eMbmL0YxdROZBT+dZpz7m88pp0VRHOpg34m+rb+jbwny5N6WsoHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335824; c=relaxed/simple;
	bh=jxZRTYp0lYxN1n5vVd2kDP+TuexqmFFWBYOJfm6H/JM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FzVbl92QTmLRGYTj63HODUw53JYZ/9MqONoul5mzjer3zYh9o//YKwfIKJlWaWq4nCxUlWeMU/UwWV/CD+N3HwBYQg5ux4fE20ugnSXsb4erHhF/BwkUmtNj9q818Qtg91Cxo12TTQ7u9vgXXIKcPlSIZnLOI3k4eApbI2tYd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=permerror (0-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=piJPZuR3; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1712335822;
	bh=jxZRTYp0lYxN1n5vVd2kDP+TuexqmFFWBYOJfm6H/JM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=piJPZuR3WuXyKKeZUkRLm7V4YnJy7TTI73aqrg55gwu5F8ZMU81fXRcoKmHF3X0SV
	 VGSYtgNfOe3zkVV8xWZGcKV94qcmo86MFGAcUJPLFVAb6AeDd6YnHTe+KcYOHuo5Pv
	 Pj5apSkFLc6Z6dAau869/VBp6BNUIu6bj3Wtf4Irr/recf0wwROy2fCMY9Q27AsVwb
	 0xd7SnavKu4cDKHNUoak54aWjh00XaII1HllAinbWvL5iYcDqQbcpespveTMGcoZP2
	 NgMyXwLAohbtfj3e17T1vQDJhCp0wgLDuwjuZlqXkGvcnkTuorYcDlCDhriaYOScwn
	 2e6QfdoToQJBA==
Received: by gentwo.org (Postfix, from userid 1003)
	id 365D540A86; Fri,  5 Apr 2024 09:50:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 3598540A80;
	Fri,  5 Apr 2024 09:50:22 -0700 (PDT)
Date: Fri, 5 Apr 2024 09:50:22 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Chen Jun <chenjun102@huawei.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, penberg@kernel.org, 
    rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, 
    xuqiang36@huawei.com, wangkefeng.wang@huawei.com
Subject: Re: [PATCH v2] mm/slub: Reduce memory consumption in extreme
 scenarios
In-Reply-To: <20240330082335.29710-1-chenjun102@huawei.com>
Message-ID: <0a59e5a1-1961-5eb2-2eb0-a930006e3f80@gentwo.org>
References: <20240330082335.29710-1-chenjun102@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 30 Mar 2024, Chen Jun wrote:

> When kmalloc_node() is called without __GFP_THISNODE and the target node
> lacks sufficient memory, SLUB allocates a folio from a different node
> other than the requested node, instead of taking a partial slab from it.

Hmmm... This would mean that we do not consult the partial lists of the 
other nodes. That is something to be fixed in the allocator.

> However, since the allocated folio does not belong to the requested
> node, it is deactivated and added to the partial slab list of the node
> it belongs to.

That should only occur if a request for an object for node X follows a 
request for an object from node Y.

> This behavior can result in excessive memory usage when the requested
> node has insufficient memory, as SLUB will repeatedly allocate folios
> from other nodes without reusing the previously allocated ones.

That is bad. Can we avoid that by verifying proper allocator behavior
during deactivation and ensuring that it searches remote partial objects 
first before doing something drastic as going to the page allocator?

> To prevent memory wastage,
> when (node != NUMA_NO_NODE) && !(gfpflags & __GFP_THISNODE) is,
> 1) try to get a partial slab from target node with GFP_NOWAIT |
>   __GFP_THISNODE opportunistically.

Did we check the partial lists of that node first for available 
objects before going to the page allocator?

get_any_partial() should do that. Maybe it is not called in the 
kmalloc_node case.


