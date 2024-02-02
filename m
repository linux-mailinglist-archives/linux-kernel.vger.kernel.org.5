Return-Path: <linux-kernel+bounces-49026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA27F8464F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE301F26000
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB57D137B;
	Fri,  2 Feb 2024 00:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bn6mQnqU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC221ED8
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832931; cv=none; b=qrplSkpyI1n1KHbwyc0rc5hj2w/lG8HbD6roEGXT8toCkpWdPStvGJeteLCPOPbbub4AKVVOE0jLendg1HkfJ5m3d39AOSdEjvAuL+EFWbiULphDCkLs82dvXVA5jcM5y1+sUTWDB60i97Fp5GjWKBUNpkM/wjFqnAIqkZGYZyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832931; c=relaxed/simple;
	bh=IsM1n2YmjrO7qEqBaiGJ3uY74FQ/tRbSZSo4LQkbjno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ddi0fZpKaC2ieGHhJwNIMqfmgAvf//OeeidQ6R13zit9DsWCP44b4dNSI1ZgfEBVl/2y0fmm3H+X/NhUgorYIMR7p9DLBeuQC9YxiYw2xu5skCx4e1Jv8irQJhltMHqipmjiIWGkKcaUTDbr68Wg755yW5t+iU5QeXVPthbCEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bn6mQnqU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60405c0c9b0so35236897b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 16:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706832928; x=1707437728; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0B2dcyelbSjs2I6WfMab+Sv7WVPwcbYFuCtOi9mUo08=;
        b=Bn6mQnqUm+FpUowC6RxGquOtF8rQ77cF56TofnmKCsm+bsb6vO/NDST0EbvsgojFHE
         UCuEc82ssOsnXaosvR8doCJM94Kqc2OrgJP+BRwAEU9vzOQEcZ6m5SPh1TsXunRRcq7e
         CCf5TYmxKNd+Sy6nxi3TkjvDP0oRrxptnTxCoeKvRrmvmmlfsL5IZKTn+WueOE0ZzBeE
         Hjy1xR2BAwX+VmQjTTZZAnDjcFYeMAO5ILmBk4aWnGVL2bMgUjeEfsD2h9tTdXvS/3qS
         jz4D18gEp5QWCnfdRhv2gM9OW4mhCW3gqvH4bidt9j96E5PMYeHy6iiFe1sA93GDgZhR
         fMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706832928; x=1707437728;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0B2dcyelbSjs2I6WfMab+Sv7WVPwcbYFuCtOi9mUo08=;
        b=CeuXKhQjUA5oNSDmKn+kYcrPw1Jjv0OrOm/dBtOXDTQyBihZEBzR+Gd9lkxj5asFbZ
         4luwLkou4PtI1MlTr1xHEUt+M5MtU+p/pKcyASyQKp9Ajc8EJBc75nSSDh6anFuWu4as
         VUCM2cgkgjl1XdKdjj1CYk+E230249/bnHbzID1DIx7Ml3qDl4zwUnKaFxqhFAXh/pYE
         NW5T0+78/d8wY0Tw56AqWBqtjWeVTk6t6hOr3UyqnUkn3h5uzdvCVL/Lvu7yaH85clib
         tcRqmMjasTcmmMK87yTY5kAdjF95R0ZYdV5ZD3jzEvKIwGr+ab/XbaKsPTS3SYHdibyd
         UPyw==
X-Gm-Message-State: AOJu0Yya5d1H88L31xyWmWELaCRADIzvzaiwlJ2RYDu/C5l3MD8MhiLH
	btUziL+xRbbenmkZcWpn406lgC1YL/yyJcyAcZ6hUcEXbk1uEwwBTqdgzb1mL9x6Xj1dM6zoqzr
	Q0zlWne4Oqxs7lBpEmw==
X-Google-Smtp-Source: AGHT+IHsamGJvXtCbMOl776g6wlVHKIs36LmCDtrhwIx3m6h+fOkPx31v6CnKtR0J1ZIqN//bOCU1+Av2EJLRnM0
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:9:b0:5d3:5a95:2338 with SMTP
 id bc9-20020a05690c000900b005d35a952338mr161854ywb.9.1706832928736; Thu, 01
 Feb 2024 16:15:28 -0800 (PST)
Date: Fri, 2 Feb 2024 00:15:26 +0000
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-3-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-3-56ed496b6e55@bytedance.com>
Message-ID: <Zbw0HjFkvMG4PT9l@google.com>
Subject: Re: [PATCH 3/6] mm/zswap: stop lru list shrinking when encounter warm region
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 01, 2024 at 03:49:03PM +0000, Chengming Zhou wrote:
> When the shrinker encounter an existing folio in swap cache, it means
> we are shrinking into the warmer region. We should terminate shrinking
> if we're in the dynamic shrinker context.
> 
> This patch add LRU_STOP to support this, to avoid overshrinking.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

LGTM with one comment below.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/linux/list_lru.h | 1 +
>  mm/list_lru.c            | 3 +++
>  mm/zswap.c               | 4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index f2882a820690..5633e970144b 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -24,6 +24,7 @@ enum lru_status {
>  	LRU_SKIP,		/* item cannot be locked, skip */
>  	LRU_RETRY,		/* item not freeable. May drop the lock
>  				   internally, but has to return locked. */
> +	LRU_STOP,		/* stop lru list walking */

nit: Should we add "May drop the lock internally, but has to return
locked" like LRU_RETRY and LRU_REMOVED_RETRY?

>  };
>  
>  struct list_lru_one {
[..]

