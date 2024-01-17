Return-Path: <linux-kernel+bounces-29510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDD830F74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FC52840B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5CF1E892;
	Wed, 17 Jan 2024 22:44:23 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936701E883
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531462; cv=none; b=ZOh1+VcP0WK3YRWeRtBqHOdiNj+yCzr5so6uE626ROSRDhthAESofBNjIQ0fsdKYbeRmn/9LQP4uHrHp4LT36LccTIv3hpjppIYVUyxd4AhvM+Tl9TK2I65rJogzmJmlDsSOTl/yFwYIQ23t+tldE/eRNqoRzYVKN3Httcy6jps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531462; c=relaxed/simple;
	bh=zKG3K+QByYlgDHGRmnH6YXsZ+X1D9YqmjXVAdiyz46k=;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type; b=Q3n1R3aWYf5nRK1S5lGnySa9FUqFbRYM9FGkTc0HYYeGnl51JzmFo4wkfZ1IBAUfzbmz2RNdDMjdwBydloTTB/wHwYnfbu+MX3UJvtFviexuUZkx+3zGXwD+yFfXKDLLsjwbqsmVtnKT1QtuaW+JK/DN3Lh2DHNvhva4aJF3XWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Received: by gentwo.org (Postfix, from userid 1003)
	id C1A6540A8B; Wed, 17 Jan 2024 14:44:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C0F7C40A85;
	Wed, 17 Jan 2024 14:44:20 -0800 (PST)
Date: Wed, 17 Jan 2024 14:44:20 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Pekka Enberg <penberg@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/slub: remove full list manipulation for non-debug
 slab
In-Reply-To: <20240117-slab-misc-v1-2-fd1c49ccbe70@bytedance.com>
Message-ID: <4f97c3c9-3b92-8c0e-19ea-73fb16484808@gentwo.org>
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com> <20240117-slab-misc-v1-2-fd1c49ccbe70@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 17 Jan 2024, Chengming Zhou wrote:

> Since debug slab is processed by free_to_partial_list(), and only debug
> slab which has SLAB_STORE_USER flag would care about the full list, we
> can remove these unrelated full list manipulations from __slab_free().

Acked-by: Christoph Lameter (Ampere) <cl@linux.com>

