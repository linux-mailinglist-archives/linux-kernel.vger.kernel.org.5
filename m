Return-Path: <linux-kernel+bounces-49024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6627B8464EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 206E9287818
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDE1374;
	Fri,  2 Feb 2024 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s+SHRizR"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4927E5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832710; cv=none; b=ilOCuF0jMFtA2+0ZvRB58YLkelngkWFlUx3M092NaxAfaZtMwLVI3Gjm1pgD1aOSHhl2DjjpIHpTG+08g+/a6vP24xXkrQkPLLnm+lwcCMnAznXdYooEv82r6+LaFPc3z9myWMMFrcW56uiRNcq418kT2183XbjeyxLCO3A0Grg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832710; c=relaxed/simple;
	bh=lhjdbRHbvdHY7Z3TOsOTDkD9TWvKmPMv1mfS60RvpeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hU5AWDv6xDFk22Aaz+JpT2KGMjssINbdbHLIAo1XG+ATVOhlHs1vmjZRBXqAI1wAacBXF2QCjecVyiaRaU5ac3RABK05hr8iCKNh0wp/bYVIq2gu3eeq/tx7ObsSUuLusOk+51m8Jw0QHvnj8l6U8WMK0tAPhTMzR71ovkFlg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s+SHRizR; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60404484c23so29134947b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 16:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706832708; x=1707437508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mDT/qE/+WVGmDsJ6kPb18GmoSMaYniB/v/SigU85+bM=;
        b=s+SHRizRcLTCZtAmRFwN5GccUZJl+l86pIRVqnXZyX+YMNzP4xUrBytDf5taSSBrO5
         MU/P7/iPfptT9+GQLb/LHF+R/eg8JMVm8FMTm6zlFp/r9fR8r6JSBmi5NYUReVFobc+D
         n3qkpdz5ulp4KGdCvZZUF2NuztUq7Zx3yjTlyMRP7ENnkWqzO2/l5fYPDqdU0sGwitiN
         S8bNwydvxWVVv/HsavhxhI/LefXPor7NB1oL2IfoP8wHHkCbPtFezobZZe+TmkiWiIxo
         G7Ca3R4A8KzGQPzQy0hxCOhAdNQfkoTdGJi2yAdNC4s4cZ9krTWeGlNOjB6VFknyLJCj
         HVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706832708; x=1707437508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDT/qE/+WVGmDsJ6kPb18GmoSMaYniB/v/SigU85+bM=;
        b=F3W4+ldQUhTf8oiIWOikgPaqH7sPovFVaF8eUwBII5mNA9FaDsEkWx1LwEIkjNf538
         x7f++FVdtgqnQzv9ou25D7QevC3v8ozt+ZPJdPVlZYTSHt7H7d9477kx0JdUVrCK/sKZ
         tRhETlJeAwCJDUN0y+OkBC0iF2U4D4l0bysXNg4HC8sAOtkxCYDMDee1/zm9ZyAONd82
         WAVL+PIHlU/c1iJBlvKqx180oMG0hiqUwGa1mfWaZRSaTjhyGownNQFd868I4GEE8zgQ
         Y7qMkkDRP62biIiMviaoiEUubmI7aLcAs4uKICmDwQLILuQM37f70eEAtB6Fx9/UvT4D
         3FSA==
X-Gm-Message-State: AOJu0YxRJPvR9wqHShD2enzjMtkFPkLWx2kjbLUauWdfTFlimagfubyI
	jauRXcKW7yWUKFXgLXq+PLJkKpBMN24FtW5nSgsu8y+5RTrXAc7HbtYaliP7pAkZ85ZerS9S/cQ
	96VQx/dReJ9hv3zctyg==
X-Google-Smtp-Source: AGHT+IHPeKgVvNSY20JNt33flC373sxunYTNsPIaWQfFmfH6G07nItYOAlnE3GgG+J4YjJjJhPY78fFZ80WEEhCj
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:39d:b0:604:228:7e with SMTP id
 bh29-20020a05690c039d00b006040228007emr1405545ywb.8.1706832708419; Thu, 01
 Feb 2024 16:11:48 -0800 (PST)
Date: Fri, 2 Feb 2024 00:11:46 +0000
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-2-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-2-56ed496b6e55@bytedance.com>
Message-ID: <ZbwzQmWHE_FSp3L8@google.com>
Subject: Re: [PATCH 2/6] mm/zswap: invalidate zswap entry when swap entry free
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 01, 2024 at 03:49:02PM +0000, Chengming Zhou wrote:
> During testing I found there are some times the zswap_writeback_entry()
> return -ENOMEM, which is not we expected:
> 
> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
> @[-12]: 1563
> @[0]: 277221
> 
> The reason is that __read_swap_cache_async() return NULL because
> swapcache_prepare() failed. The reason is that we won't invalidate
> zswap entry when swap entry freed to the per-cpu pool, these zswap
> entries are still on the zswap tree and lru list.
> 
> This patch moves the invalidation ahead to when swap entry freed
> to the per-cpu pool, since there is no any benefit to leave trashy
> zswap entry on the tree and lru list.
> 
> With this patch:
> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=count()}'
> @[0]: 259744
> 
> Note: large folio can't have zswap entry for now, so don't bother
> to add zswap entry invalidation in the large folio swap free path.

This makes me slightly nervous. Should we add a comment somewhere just
in case this is missed if someone adds large folio support?

Otherwise the patch itself LGTM.

