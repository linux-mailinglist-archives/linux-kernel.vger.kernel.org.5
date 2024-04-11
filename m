Return-Path: <linux-kernel+bounces-139902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99728A08FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F31F2559E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4713E024;
	Thu, 11 Apr 2024 06:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gkCac0u7"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C613DBBD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818721; cv=none; b=Yt31GT1RWSBwWuifK8YhE+/4iJROdPFCo+XPHKkhOtoG3dY+KV83lbWhU0ZOaRRkZItnLL/ZAXwA5ppGFOwheONjy3fMes5Dz4gIi3XDLXzskRF+TQMi7DZne74tsUyrGppjlZSyvJ4CgShxcxEgXCKQ6KA+urZy+z4rad3rYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818721; c=relaxed/simple;
	bh=q895xwfKspqxfafp/g1RVbPZRAS17rrirl0p5xi4SKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnyuT0X701crwb3+WH9cFbrLz+g9tKRc0K+J6ugI2Vd4XOGFEFgkqN3Ab1lrjdt2jK6wyU8WA5b+HBb0Gy3vwabnycu4wtu2X4F8r4Lz2aADgAwyaM0Yi/lwiAsWYAge6fmO0mS123EDf28WSVds5VhdT/nYPY2OWAKqOApDrGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gkCac0u7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Apr 2024 02:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712818715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ya04erhgLsTLGZQ/2G7MTLQyzFsPBEoI90yJgKzdjKs=;
	b=gkCac0u71FyvdUvE2LJ9kO+GVR6IahtQgD3rKwS6ph62s4nKPsmM3FBXLMrLEeVl8N0EP2
	YMRR8zaktDjRCVnrcuXksqmtVqxSqFAwNX66dNtg3kKkGPYxWfkPZbHqVBHYeOX/6Qt1f7
	XoIeMW10SvxBcA8HhpLPuPQ2YPKWXi4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: improve entries in CODE TAGGING and MEMORY
 ALLOCATION PROFILING
Message-ID: <mya4xkisx6bah3dl7znb3uymtpwmqt5mesydr4q2icz2xcyrb3@kx7h4tqdzep5>
References: <20240411064717.51140-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411064717.51140-1-lukas.bulwahn@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 11, 2024 at 08:47:17AM +0200, Lukas Bulwahn wrote:
> Commit 5acf2502db99 ("MAINTAINERS: add entries for code tagging and memory
> allocation profiling") adds the two new sections CODE TAGGING and MEMORY
> ALLOCATION PROFILING. The files in these sections however do not match
> with the files added in the corresponding patch series.
> 
> Improve the two entries to refer to all files added with that series and
> drop the entries to non-existing files.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Acked-by: Kent Overstreet <kent.overstreet@linux.dev>

> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2d913c64704..e5431f06ab55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5332,6 +5332,7 @@ CODE TAGGING
>  M:	Suren Baghdasaryan <surenb@google.com>
>  M:	Kent Overstreet <kent.overstreet@linux.dev>
>  S:	Maintained
> +F:	include/asm-generic/codetag.lds.h
>  F:	include/linux/codetag.h
>  F:	lib/codetag.c
>  
> @@ -14241,10 +14242,10 @@ M:	Suren Baghdasaryan <surenb@google.com>
>  M:	Kent Overstreet <kent.overstreet@linux.dev>
>  L:	linux-mm@kvack.org
>  S:	Maintained
> +F:	Documentation/mm/allocation-profiling.rst
>  F:	include/linux/alloc_tag.h
> -F:	include/linux/codetag_ctx.h
> +F:	include/linux/pgalloc_tag.h
>  F:	lib/alloc_tag.c
> -F:	lib/pgalloc_tag.c
>  
>  MEMORY CONTROLLER DRIVERS
>  M:	Krzysztof Kozlowski <krzk@kernel.org>
> -- 
> 2.44.0
> 

