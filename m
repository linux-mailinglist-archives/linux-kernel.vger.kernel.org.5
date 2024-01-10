Return-Path: <linux-kernel+bounces-21661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8C829287
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6CD1C20C64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82299320C;
	Wed, 10 Jan 2024 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz1CR0Zl"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FBE23B1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd1aeb1bf3so33830101fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 18:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704855240; x=1705460040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD7bzsVHDyZVaIw1WEtjfdf6X1QN0YaIlFCaqqO1VuM=;
        b=Cz1CR0ZlUXtm/1br5zpPr0knRFNgPojPMyIRWibhoPQGfb6mtXFKjqcBTWRbxZRzAQ
         f9XBLtZfPqB1ZUbqmIEkg3IW1+dQR0FbCEh+gtSU0bLPvJ8OvFlFIc2Xd9sn8Ia6DsWA
         g2qzByq2yudBTo516XsjuPspfOmfxAQQJoczStNWkj52FvLKnLYI3AcHTh9SccL3hLJW
         rlLE2/pdsLro5lCnD9qcjCs/vELr832CUIpptDmLhjo32I/xz3W1mobxo9KkvVH6zwVR
         eoGSDS7qQf+FrPbTokv1WaW8EChMLRnKFRZuukJhviazKnm6rtWxtETdwydd8aOt4nj/
         l+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704855240; x=1705460040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD7bzsVHDyZVaIw1WEtjfdf6X1QN0YaIlFCaqqO1VuM=;
        b=MfuW7vvNhiM+Ism4pBertuHNYMlAfME1bJI/dYqhn5heJ9zV0uJXB1X2YVa+zNkYhy
         FfDSkzXc2EAtlREp8w539O+V4K6ZUHyqlxo0uz2xEI5WhnK7acO3Wb1TCUwJYT6FQtWX
         SaM2PKVySuEAQlyP3K1Og8Gq7WUuu5qgAeangP7SLB0Dj8lEa5wfimBjmheNxgQ6U4Hw
         4yhhESF9nvIRxIRE52f28jF4jkwCnjr3TAQjZ3U8VlS0uWOLg2qUrRW9jFf4jF1qOUMu
         f8aPYAOE2ETc1Ff79UNHmmWYOjO4MJZGodc3qSoJo6h+be1fZLaA2glZ2VEYOG9iudbj
         6qGg==
X-Gm-Message-State: AOJu0YwkE+Kz1Jsaxt291w6tiZePjpRYcJ3N9GWxQx1oF07tBgjpiVJB
	rOSh5g58HqcdC53uSJtAwWttNNJ2nglxIOKYQOUyjN7dUXPTL/Rz
X-Google-Smtp-Source: AGHT+IHQN4O+MHJ48DV2x61/acZugFlcfT7v1vm9DSTQ8kXrGy6Cxt3Ro+CwkAH+vOJyvBwx5pmwfXX0VubD6jIlWFU=
X-Received: by 2002:a2e:a90a:0:b0:2cd:6ea2:bff9 with SMTP id
 j10-20020a2ea90a000000b002cd6ea2bff9mr1180838ljq.21.1704855239938; Tue, 09
 Jan 2024 18:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-7-ryncsn@gmail.com>
 <87a5pg9qno.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5pg9qno.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 10 Jan 2024 10:53:42 +0800
Message-ID: <CAMgjq7Ce6sCSTRd==N3ihrAcvVd2ggszdZuTwxDbFYcBWzcE_g@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] mm/swap: handle swapcache lookup in swapin_entry
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=B8=80 16:28=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > Since all callers of swapin_entry need to check the swap cache first, w=
e
> > can merge this common routine into swapin_entry, so it can be shared an=
d
> > optimized later.
> >
> > Also introduce a enum to better represent possible swap cache usage, an=
d
> > add some comments about it, make the usage of swap cache easier to
> > understand.
>
> I don't find any benefit to do this.  The code line number isn't
> reduced.  The concept of swap cache isn't hided either.

Hi Ying

Thanks for the comments.

Maybe I should squash this with the following commit? The following
commit want to do cache lookup in swapin_entry to avoid a redundant
shadow lookup, it can help to improve the performance by about 4% for
swapin path. So it need to return a enum to represent cache status.

Further more, note the comments added here:

+/*
+ * Caller of swapin_entry may need to know the cache lookup result:
+ *
+ * SWAP_CACHE_HIT: cache hit, cached folio is retured.
+ * SWAP_CACHE_MISS: cache miss, folio is allocated, read from swap device
+ *                  and adde to swap cache, but still may return a cached
+ *                  folio if raced (check __read_swap_cache_async).
+ * SWAP_CACHE_BYPASS: cache miss, folio is new allocated and read
+ *                    from swap device bypassing the cache.
+ */

SWAP_CACHE_MISS might be inaccurate, this is not an issue introduced
by this commit, but better exposed. May worth a fix later. So far I
can see two benefits fixing it:
- More accurate maj/min page fault count.
- Note the PageHWPoison check in do_swap_page, it ignored the race
case, if a page getting poisoned is raced with swapcache then it may
not work as expected.

These are all minor issue indeed, some other optimization might also
be doable, but at least a comment might be helpful.

> --
> Best Regards,
> Huang, Ying
>

