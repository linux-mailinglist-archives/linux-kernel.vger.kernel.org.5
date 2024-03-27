Return-Path: <linux-kernel+bounces-120383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF288D68E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE3BB224CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7D2C877;
	Wed, 27 Mar 2024 06:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE3JGv1a"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E821F606
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521467; cv=none; b=n6NtNJwMy3ro+36DX3HlJp7bzMNP3sc+zj/28AfAkSQ9KYMvYCRvLGLCSjzp1xAGV6I5TCUm4WrbAHomDAJW8j0bWC9Ic7t5h/H1MEJocsoThvQNKCGa5kvTEWCYzwpeFHCbSjM+kZCWNufLdYSxWpn8iYrUGzB+16C/2DZGbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521467; c=relaxed/simple;
	bh=YbTWH1ZEgnojQO0lu/RJHGC/KsAwMHzIuPpPakpg8oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f0/9XDBUDf0vJi211CXN6hUwTCJvYGE1gB6eyvvkNtpkljtzV0pOp23bTb4yiuL7e2zbhLA+w2gKgU0OohQL40qUL1Fdr59fAXLGA6fEavPZ2mZvl6PMbwsRwlR7GZj9lSGK3/T/hZAgYFDcyMujVVg7QXZL4hEmlAx+39BXDEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE3JGv1a; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so74387401fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711521464; x=1712126264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xRCZV/DoCsl1IXRPXRF8ryJxeBYrzLKPPE0aKQ6Epg=;
        b=QE3JGv1a7lYuYn+hFtgqV+7TlAMbF93oGLSEXlqNmOw5vS6zlxKJLTZpIRlyN/d99C
         JCaNUw/1PCk0exOJEQOSKkcLUy3oCEgC7PS0QePJULSocuGrmJ6Q5WMt5HeO4LUj4bd/
         5eZqZtWTeNFCn3s0ftpGdrNh1f9FF++MICYfF2tYyw3w6mmm3deRcDL/nivHUiDnG33y
         zMOhwkhDNTMfxIh5Pg62kkWoiN3I6YJxw8Z7pPEIvD5wkZ4yJ1Lnnz67qc6OhxG6f0pL
         GkKVImT7jPIIHZyLK8EYp2N45oWfgsDuAcJXeCBsKXW7l4KYE8FTl0e1XRVPgjDkg1Lz
         iGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521464; x=1712126264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xRCZV/DoCsl1IXRPXRF8ryJxeBYrzLKPPE0aKQ6Epg=;
        b=OZyN8JYHIYsdp/o4v6WfU1gfb+Vt0YIRlbfboJN+7mSLJZZBq5JlayOA8XAyx5bsp6
         gmDyKZbmpaLuMFOaQRJ/Pqc7UBHr+gTzUP042zmBaHtSdrqeuu259f0WVjiEKH/KpuP3
         bpu+wg4vJrsiOBD/9z4H9yytsOIskNFakPIuO/guGsFUoVFpY/r88Js/QOZLyjdW9vBL
         g6xITsK2J2xmIJkXgrsgtu4LTxZpkws1ST7Egy4s4yrYeSnIvMgrupHp3gRzypOl0S5l
         YRDX8KtjuLDWzbyTaFVzj6W+CE4rHWdEIeBIv94uWhn5Mn2UIEGTsMsvzHXd1AJb5m28
         MVTw==
X-Forwarded-Encrypted: i=1; AJvYcCWKTdOFbE6k8ji0OAQ5EZk1VNErgGpO0ib7sQH0B3tMw68ysGDmg3t0cFRnCH1z0c3tU0nQClPSVQIVbD6gDNG00up5FKW4zK1P50lI
X-Gm-Message-State: AOJu0YxDN9DvOJNxZIhjropW0e8Bhm8NhyWYladdXboJ9AfMixQlqyF7
	SVo9gsTl/uaUUTciPYhnSGePPr5QydO7LrNYroQiAkF+aZhJgdKVEjTk+yJNi464MPaaZ9b5+bm
	brSAmN2u2aNAOhWETp5YBMxHirWo=
X-Google-Smtp-Source: AGHT+IFP36X0x7Y4uIxFOLg/TPs4cMecmv/NsfNrKV01BYoqzbIV2D9iVtA+gZVp9VkMB8P0uScAIOQQksOhARs8EhE=
X-Received: by 2002:a2e:9f0b:0:b0:2d4:aae0:1d71 with SMTP id
 u11-20020a2e9f0b000000b002d4aae01d71mr226051ljk.43.1711521463657; Tue, 26 Mar
 2024 23:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326185032.72159-1-ryncsn@gmail.com> <20240326185032.72159-11-ryncsn@gmail.com>
 <87zfukmbwz.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87zfukmbwz.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Mar 2024 14:37:27 +0800
Message-ID: <CAMgjq7A-TxWkNKz0wwjaf0C-KZgps-VdPG+QcpY9tMmBY04TNA@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] mm/swap: optimize synchronous swapin
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yu Zhao <yuzhao@google.com>, SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:24=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Interestingly the major performance overhead of synchronous is actually
> > from the workingset nodes update, that's because synchronous swap in
>
> If it's the major overhead, why not make it the first optimization?

This performance issue became much more obvious after doing other
optimizations, and other optimizations are for general swapin not only
for synchronous swapin, that's also how I optimized things step by
step, so I kept my patch order...

And it is easier to do this after Patch 8/10 which introduces the new
interface for swap cache.

>
> > keeps adding single folios into a xa_node, making the node no longer
> > a shadow node and have to be removed from shadow_nodes, then remove
> > the folio very shortly and making the node a shadow node again,
> > so it has to add back to the shadow_nodes.
>
> The folio is removed only if should_try_to_free_swap() returns true?
>
> > Mark synchronous swapin folio with a special bit in swap entry embedded
> > in folio->swap, as we still have some usable bits there. Skip workingse=
t
> > node update on insertion of such folio because it will be removed very
> > quickly, and will trigger the update ensuring the workingset info is
> > eventual consensus.
>
> Is this safe?  Is it possible for the shadow node to be reclaimed after
> the folio are added into node and before being removed?

If a xa node contains any non-shadow entry, it can't be reclaimed,
shadow_lru_isolate will check and skip such nodes in case of race.

>
> If so, we may consider some other methods.  Make shadow_nodes per-cpu?

That's also an alternative solution if there are other risks.

