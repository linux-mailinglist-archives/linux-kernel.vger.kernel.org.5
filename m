Return-Path: <linux-kernel+bounces-155733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B968AF64F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F721C21F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BD13E05F;
	Tue, 23 Apr 2024 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="o2/ujoUL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF4A13666F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895802; cv=none; b=nsMKlcAnc3FeZPbC5gYfkF1Na8B0yyPbhPiMOq2Lz48dWtmUKN3sxD7hVBTJKjfo2Irr0sXiaj6VJIHR3uGNHzKMg1mDlMSDs6UCjOW0lz6n+ZMGEnvZ9cLVDeF6wxbJKzZJh/CJ3H3/W72qQGQxgybWS3OgL9z8aAbK0bF1gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895802; c=relaxed/simple;
	bh=yWwuu1e4Hy/gDnhnwnLfWKeZpMIKvT0w/k6BBM66aAA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WXu43AJkCvvuNC0UmwUPUSyoUYsKwUiKmx89G9A1oKt0wnlBb0hKq1EVAEni+MUAY0gIwS6mEMotpkEROOxT1npLXcKIJntHkKtweww/L8xyp/hs+thlXiMKNNn/rLrpDU5NkDi4SrGi3OHk0QzJodIoSzEX/JfcbRGVwHes4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=o2/ujoUL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7736BC116B1;
	Tue, 23 Apr 2024 18:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713895801;
	bh=yWwuu1e4Hy/gDnhnwnLfWKeZpMIKvT0w/k6BBM66aAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o2/ujoULwF6bOMvmsYyRuy1cgJOOfvjqUuYr3RWSGnano4cCpwN1hDcCa7/8PlzFp
	 mnzXeuxkZ9NYm1X5bPcSsytb8gt6l5iNzWmyQs7I7kJxwApRcSAsm70/ejO+d0PbVz
	 IljyuzZNxH1bz9VB3gcotsfAmMtsR36StvR2Sc2U=
Date: Tue, 23 Apr 2024 11:10:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 1/1] mm: page_alloc: Avoid defining unused function
Message-Id: <20240423111000.aaf74252a07d7e7fd56d7e12@linux-foundation.org>
In-Reply-To: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
References: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 19:14:43 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> In some configurations I got
> mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
> Becuase the only user is guarged with a certain ifdeffery,
> do the same for add_to_free_list().
> 
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -653,14 +653,6 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
>  	area->nr_free++;
>  }
>  
> -static inline void add_to_free_list(struct page *page, struct zone *zone,
> -				    unsigned int order, int migratetype,
> -				    bool tail)
> -{
> -	__add_to_free_list(page, zone, order, migratetype, tail);
> -	account_freepages(zone, 1 << order, migratetype);
> -}
> -
>  /*
>   * Used for pages which are on another list. Move the pages to the tail
>   * of the list - so the moved pages won't immediately be considered for
> @@ -6776,6 +6768,14 @@ bool is_free_buddy_page(const struct page *page)
>  EXPORT_SYMBOL(is_free_buddy_page);
>  
>  #ifdef CONFIG_MEMORY_FAILURE
> +static inline void add_to_free_list(struct page *page, struct zone *zone,
> +				    unsigned int order, int migratetype,
> +				    bool tail)
> +{
> +	__add_to_free_list(page, zone, order, migratetype, tail);
> +	account_freepages(zone, 1 << order, migratetype);
> +}
> +
>  /*
>   * Break down a higher-order page in sub-pages, and keep our target out of
>   * buddy allocator.

Thanks, I'll queue this as a fix against "mm: page_alloc: consolidate
free page accounting".

Please do tell us the config when fixing these things.  That way I can
do a little bisect to ensure that I correctly identified the offending
patch.


