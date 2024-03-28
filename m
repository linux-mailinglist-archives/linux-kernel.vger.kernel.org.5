Return-Path: <linux-kernel+bounces-123489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60113890958
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E28DE1F22C34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C727713791D;
	Thu, 28 Mar 2024 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="y69kluRk"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223EA3DAC10
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711654739; cv=none; b=r7Ogu8TCR17Iv836eoxNc5xMyQI52xn6xfYnw75gBtqUAQAuT9PKNeStuuc9cn0nhvMXahd6EbcxMBPd7ctAGaDxOaPEmoGT1iltijiVZcNkLiERuzlPyoI6nU8pAA4BpNQGGXz7XDFoF+lLngFDJJtNwWqRC9xSL2dBoYFugjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711654739; c=relaxed/simple;
	bh=0LhFG5dGbV3iSP2b5RsJ+KY5PBF+sl7WbsjafkjLxZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0+uqygG9tEwoU3H5v6esRs2LTEe2DIW1Rbd4uutXD64FGEiAvVdoeWphobFGMO0raMxuMvsEUgJ08xAUvY6WjChmY68NUQ4Ey9EBrvyUTvWkUPb3+U3L9xiO79jnzV0KJUFcRwsn/EG/QPaJWE6ar/TeaEdgYAP0XpD3k30TA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=y69kluRk; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78a2290b48eso81520785a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711654735; x=1712259535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCiQo1MAtcR26ctf6PaMfsaO2b9Y5boPDvEB8BEdvaw=;
        b=y69kluRkfhK0kyLXQyI10HQ0QB7hYIZQLzjKpF48xWrI7wMVs8haCAVp4MynsHiMfF
         ONC1oRbBem2sqTBxzeoFgzV8clplG2msUxzkse+wFnRME0ap8L5/00XAghbhk6a4RiBT
         jf1m2XemckzgApHTvr+DbGH2qbkY8UEEJdt5RAo+uhYfzeW0/tqo03+2tW1hK9EX1jbS
         wQDRPgshraLYShiY7GnofTEnuu9pSN32rwsbcZ0jfO0wC8idkVM80LP2AphbLVCiQ/Pf
         kWAzFaGJniALnJhWrzyaIQi50k4In6IbpaH5db4ndj06/ajtvh//OxWR3KUdKgAH7QN4
         nlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711654735; x=1712259535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCiQo1MAtcR26ctf6PaMfsaO2b9Y5boPDvEB8BEdvaw=;
        b=fyRIxZ0XpaPsG+0xtJnAB80a48AxUtgShAFdMoC/EEVIBU8aq+xvaYVpKZe6wGhiGh
         0vvaDe6xHEGY8M5jkvDaq70bvQXpOSSjwIt4LBZ8Npsl0lVC5B5hZLiGd5JrwcLk4jxG
         jMw27PFLUhWsFgZrU9ubxMGtaO6aM7QoI3pdyahTvaCGeBhS0MbHg0qfoTvJrD2EH0AX
         +Q2tLYutyAFPqjDe3yZlsxf0wYvj5h3V3QNTaixjemiY53cQbBpaBLyFWjiMrVA5AeKK
         30tRymARXxKKN/CyvyS4Y+HoGNKkm+ceFdiZcJUDcM/6y2AbikC/1e7Sc+hrUHx8IZau
         zFGw==
X-Forwarded-Encrypted: i=1; AJvYcCW8QaFp6GDGgiw8sTW8FuZJtMV9EV+IQ9DEsBK5PY3MecgDzrvhq5M6UjDNlrQyeYVYczAJhjP8upX/fsESO342wnaJUoDSx1uY6l/x
X-Gm-Message-State: AOJu0YwmykYulQEFt9QRydhNyt6MV7E0hnrhQIxOcCkMhCWvRUoW7DJ1
	6MGp33jnAROnvYEMWp8qWzGk4GZbe8nWjAnvreFfwYmGcUgj4pVjWtZwgZ+f3sY=
X-Google-Smtp-Source: AGHT+IHS2fTAhR7/2bFnaQsf9xIhswTUUUgW/mbm1wT+yk0UQqtu+X9Q7joZO8+Jr3iYQwrNMIJvWQ==
X-Received: by 2002:a05:620a:450d:b0:78b:c549:c3bc with SMTP id t13-20020a05620a450d00b0078bc549c3bcmr431043qkp.54.1711654734966;
        Thu, 28 Mar 2024 12:38:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:bb1f])
        by smtp.gmail.com with ESMTPSA id wx37-20020a05620a5a6500b00788402160besm770464qkn.128.2024.03.28.12.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:38:54 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:38:53 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 7/9] mm: zswap: store zero-filled pages without a
 zswap_entry
Message-ID: <20240328193853.GG7597@cmpxchg.org>
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-8-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325235018.2028408-8-yosryahmed@google.com>

On Mon, Mar 25, 2024 at 11:50:15PM +0000, Yosry Ahmed wrote:
> After the rbtree to xarray conversion, and dropping zswap_entry.refcount
> and zswap_entry.value, the only members of zswap_entry utilized by
> zero-filled pages are zswap_entry.length (always 0) and
> zswap_entry.objcg. Store the objcg pointer directly in the xarray as a
> tagged pointer and avoid allocating a zswap_entry completely for
> zero-filled pages.
> 
> This simplifies the code as we no longer need to special case
> zero-length cases. We are also able to further separate the zero-filled
> pages handling logic and completely isolate them within store/load
> helpers.  Handling tagged xarray pointers is handled in these two
> helpers, as well as the newly introduced helper for freeing tree
> elements, zswap_tree_free_element().
> 
> There is also a small performance improvement observed over 50 runs of
> kernel build test (kernbench) comparing the mean build time on a skylake
> machine when building the kernel in a cgroup v1 container with a 3G
> limit. This is on top of the improvement from dropping support for
> non-zero same-filled pages:
> 
> 		base            patched         % diff
> real            69.915          69.757		-0.229%
> user            2956.147        2955.244	-0.031%
> sys             2594.718        2575.747	-0.731%
> 
> This probably comes from avoiding the zswap_entry allocation and
> cleanup/freeing for zero-filled pages. Note that the percentage of
> zero-filled pages during this test was only around 1.5% on average.
> Practical workloads could have a larger proportion of such pages (e.g.
> Johannes observed around 10% [1]), so the performance improvement should
> be larger.
> 
> This change also saves a small amount of memory due to less allocated
> zswap_entry's. In the kernel build test above, we save around 2M of
> slab usage when we swap out 3G to zswap.
> 
> [1]https://lore.kernel.org/linux-mm/20240320210716.GH294822@cmpxchg.org/
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 137 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 78 insertions(+), 59 deletions(-)

Tbh, I think this makes the code worse overall. Instead of increasing
type safety, it actually reduces it, and places that previously dealt
with a struct zswap_entry now deal with a void *.

If we go ahead with this series, I think it makes more sense to either

a) do the explicit subtyping of struct zswap_entry I had proposed, or

b) at least keep the specialness handling of the xarray entry as local
   as possible, so that instead of a proliferating API that operates
   on void *, you have explicit filtering only where the tree is
   accessed, and then work on struct zswap_entry as much as possible.

