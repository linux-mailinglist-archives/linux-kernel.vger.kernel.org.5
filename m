Return-Path: <linux-kernel+bounces-120296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C0388D579
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3EF1C23F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD82723D7;
	Wed, 27 Mar 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vRU0lzol"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D30C36B;
	Wed, 27 Mar 2024 04:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711513830; cv=none; b=bEY7LFb79UKBE54aaK8mfR7MVcQQoZG001ZJbih8q5nr4OlAUeAU3TtLFI4kqYYBN7RrHeod/ou+T0Gy/RLWPEJtikjOImxU1ysscCvb0BdvCxlfC4CI8jbBmNsu5z9eKkrmOYhNlIGxRnRB7LJvAO90F2l4jUAe0F6RlSzwyGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711513830; c=relaxed/simple;
	bh=nDWTZJr52CDhdBEGdA1dMU8t28mf3eBIn0+2tXdHsrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s09PJKFg0wt5pB4oB6xMb/WNLamO9t1UM4dS+5C4p8kDg30rz76PY6NrSlB6sxjHwCUzNYwpUa8ZUs0BdLEuuEMyr2Q3W+B5TzfdPLBdU+6DEs466Vnx75b6ZFM4USRmWya/9iys4qEZhZxE8NgD2lXT+LyLGVTQgsGYO+dRjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vRU0lzol; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=fKaXAOy4zrHCHrk6cr69a+Oj1pHgwDYN2mzGRu5zIRc=; b=vRU0lzolD9NgpOEadMLe3oTiMK
	JM/5OuitsTe68PHW2/EPsV2d0Je0eaeo8qm9R+9OLulvQbE2aVdVteyh7BoIuydbvB2isKPx6X8G9
	mY710oD/MitXP1eqTkH9QdYW0sHS+o2jRE9TQJFeCb2+MXik3VbihUnx2Fx7pg4/fbBPvg725nVJO
	q2xu+N6yc/k9QTXNwmkm/R/1PScZJAXkTK9mAA5pm7BS9AMRoITxI505T2V9fW+3o2hg0viDH5FYZ
	7PYcyyzQSPIk0pDSPBm4oq5IMxQ3TedvCUgI3X3MXOQx2xT+Lf5OYTF+FiR9/ccQqmlrS96x0290O
	JqMcrVkw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpKvg-00000007QL9-1WFX;
	Wed, 27 Mar 2024 04:30:24 +0000
Message-ID: <bb16f178-15e1-4111-8bb1-b4ca8c5739cc@infradead.org>
Date: Tue, 26 Mar 2024 21:30:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Documentation fixes for memory allocation profiling
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: sfr@canb.auug.org.au, kent.overstreet@linux.dev, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326231453.1206227-1-surenb@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240326231453.1206227-1-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/24 16:14, Suren Baghdasaryan wrote:
> With the introduction of [1] kernel-doc can handle _noprof function names. 
> This patchset changes back _noprof documentation changes introduced in
> memory allocation profiling patchset [2].
> Changes are split into several patches, each undoing changes in a specific
> patch from the original patchset so that it's easy to squash the fix into
> the initial patch if Andrew wants to do that.
> Changes apply cleanly over mm-unstable and are tested with [1] applied.
> 
> [1] https://lore.kernel.org/all/20240326054149.2121-1-rdunlap@infradead.org/
> [2] https://lore.kernel.org/all/20240321163705.3067592-1-surenb@google.com/
> 
> Suren Baghdasaryan (6):
>   Documentation: rhashtable: undo _noprof additions in the documentation
>   Documentation: mm: undo _noprof additions in the documentation
>   Documentation: mempool: undo _noprof additions in the documentation
>   Documentation: mm: vmalloc: undo _noprof additions in the
>     documentation
>   Documentation: mm: percpu: undo _noprof additions in the documentation
>   Documentation: mm/slab: undo _noprof additions in the documentation
> 

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

>  lib/rhashtable.c |  6 +++---
>  mm/mempolicy.c   |  6 +++---
>  mm/mempool.c     |  2 +-
>  mm/nommu.c       |  8 ++++----
>  mm/page_alloc.c  |  8 ++++----
>  mm/percpu.c      |  2 +-
>  mm/slub.c        |  2 +-
>  mm/util.c        | 10 +++++-----
>  mm/vmalloc.c     | 14 +++++++-------
>  9 files changed, 29 insertions(+), 29 deletions(-)
> 
> 
> base-commit: 4aaccadb5c04dd4d4519c8762a38010a32d904a3
> prerequisite-patch-id: 1c2be401fcd818b167ef7d506a2fb87fea230835
> prerequisite-patch-id: d3c1b90bc5ee32295962c5d30bd79dfb6eb774c3
> prerequisite-patch-id: 25e37766c40250d564a0c198e2af01a9aae33c92
> prerequisite-patch-id: ed3859d70637371a854c212aa08db8f28edbede4

-- 
#Randy

