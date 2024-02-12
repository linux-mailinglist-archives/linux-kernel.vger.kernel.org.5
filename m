Return-Path: <linux-kernel+bounces-62234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E712851D63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E24A9B291F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD047A60;
	Mon, 12 Feb 2024 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT8/O5bo"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB647774
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764001; cv=none; b=sz3Ww4WAwkMMBiHFu6PXTfUZf23e8u+cK/n4vruqU8QpVfxDW21UIA7mLDlPAle3UESvBlCm2DJchqAPcZej362hd/+/sVX7GltPZWz+OOHnKkjFn2bdU5wqoyna/m/wGcJgha9SJu6rdo2C0LDS0rcZeOVw6yE6oiOw8qnb6Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764001; c=relaxed/simple;
	bh=c8irkFXpP+vn7yCJ9c1I04iTC31mwFw2jciRHXDJSn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+ldMOrM5gqaUyatH5xxBQasaSQJQaCy39MKDRrHk2am7L9xfVh3Zk1bX4CcIDmQJ564dLsK8pIL+mJzC6uCCPHiiELgfIS7r0sqlg3YIxWLTd5twdsgwP5udTh9L0oR7u+lZaoCYcEnKwSE4cFx7NEJH6xyesMJj8ChLo3slb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT8/O5bo; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-363b6c3bc1eso10704835ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707763999; x=1708368799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4QFqP4yLnP1kaBdv6CTyW0dZP0E/ZSe+IpLxw5UGMo=;
        b=QT8/O5boKtavHv1wMaSEvhBHT747k1EuwXT4zgF3OxItnmP3HwzAnuz1zV3WH5lj8v
         l1WVTxT12gkfn9M3uw0jGFIbIrKMIkFiZQfh+MClzO/fDW1V4pq9LioM1PWbqPESEm+P
         o20ywOSPk6h02zBJdxHgaaqDG073h1vLj1ePhl/INN4Fn8PPY8KX7gKpT/t5MXeqL37S
         zfmfHvCm3Eh64alPRhEYaWiUhp5dz00Vqydt0sppCcMT9wuUGOIeaLB+hEXk2Yd4vLrM
         llF4jn6dhcCE/voapjVwGWEAu5f09D8Q4rqJKNRAcBfdfL9INIQPQTmA9HPzhrK3RlU3
         MsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763999; x=1708368799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4QFqP4yLnP1kaBdv6CTyW0dZP0E/ZSe+IpLxw5UGMo=;
        b=iq2JaCzV9Jn8mY5gkujGQqCDtz7UhhJ1DvR71ujjo6vqPCY1bPeEOyjrGp+zK5F7LN
         XLHQ05LkDAW26TT/A6JyNXSt6HWhDgEETgLPOZH28ckFv6vgCDVg4Wq3bvm4Qj88n4+d
         X5al9Z/S5JMLcEcK+rbemWMoSlqOFiq+KYd11J/WM3GlzW933EwSNkiUUtF+N+FY1/WM
         Owf/fVD6Fa5EiWIX4xDY6EAyqXG7ZxSDMbeWfitFyDibPIC5GJjHP9qAaGFUZ+twX08d
         cRuASk1A+VpG73GCE43KJcX+VyJEV1vIKSW60IpdGP1FDQ0INwE+1upccqxKNwjuMndh
         bcWA==
X-Forwarded-Encrypted: i=1; AJvYcCUdv/cQyQbJgqxY+DuuETt7uZ2kTaHmNXPWHp8yxCZaBDiGxg5onNLUwNpSU8xcp/giu5vUr766w1CR3wpc9oned0YlWObAjWhOhnZO
X-Gm-Message-State: AOJu0YwC0Zvi/JJgGOMrL6EFiDMpsAiEKssYIpNEcF+4qQPaaQdxet/0
	IqqZYxL/Xp6AFQxVZUtEOkxM/RmOhPrNI1Hqz3yqet41lGG+ROeugSCz+LYghj/iChwieC1hSnN
	VaAH3XWhZUMcYNB6ynpeRWFtxe9Q=
X-Google-Smtp-Source: AGHT+IFdFWbMxuNMt/eEaKf2Wqdoj6hgK4E48dPopsQNW+phuc0U6MUfTSWDkx6StAauk9J7g8OjclwwiEeJ9nbe2kM=
X-Received: by 2002:a05:6e02:1a09:b0:363:d96f:6850 with SMTP id
 s9-20020a056e021a0900b00363d96f6850mr11605169ild.12.1707763999051; Mon, 12
 Feb 2024 10:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
 <20240210-zswap-global-lru-v1-2-853473d7b0da@bytedance.com>
 <CAKEwX=MCkhH2Qa2+dGErpo2e_27=HyyVeEDWVO=+O6D-7mRQ1Q@mail.gmail.com> <900cd5da-da96-4107-b5f0-c7d975a8ba97@bytedance.com>
In-Reply-To: <900cd5da-da96-4107-b5f0-c7d975a8ba97@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 12 Feb 2024 10:53:07 -0800
Message-ID: <CAKEwX=PtOWJ3=dur30sPBmhrAemPcoEQqJkOXCo8=XQLqO1Fvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/zswap: change zswap_pool kref to percpu_ref
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 5:29=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2024/2/12 05:21, Nhat Pham wrote:
> > On Sun, Feb 11, 2024 at 5:58=E2=80=AFAM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> All zswap entries will take a reference of zswap_pool when
> >> zswap_store(), and drop it when free. Change it to use the
> >> percpu_ref is better for scalability performance.
> >>
> >> Testing kernel build in tmpfs with memory.max=3D2GB
> >> (zswap shrinker and writeback enabled with one 50GB swapfile).
> >>
> >>         mm-unstable  zswap-global-lru
> >> real    63.20        63.12
> >> user    1061.75      1062.95
> >> sys     268.74       264.44
> >>
> >> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> >> ---
> >>  mm/zswap.c | 30 +++++++++++++++++++++---------
> >>  1 file changed, 21 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/mm/zswap.c b/mm/zswap.c
> >> index 7668db8c10e3..afb31904fb08 100644
> >> --- a/mm/zswap.c
> >> +++ b/mm/zswap.c
> >> @@ -173,7 +173,7 @@ struct crypto_acomp_ctx {
> >>  struct zswap_pool {
> >>         struct zpool *zpools[ZSWAP_NR_ZPOOLS];
> >>         struct crypto_acomp_ctx __percpu *acomp_ctx;
> >> -       struct kref kref;
> >> +       struct percpu_ref ref;
> >>         struct list_head list;
> >>         struct work_struct release_work;
> >>         struct hlist_node node;
> >> @@ -303,6 +303,7 @@ static void zswap_update_total_size(void)
> >>  /*********************************
> >>  * pool functions
> >>  **********************************/
> >> +static void __zswap_pool_empty(struct percpu_ref *ref);
> >>
> >>  static struct zswap_pool *zswap_pool_create(char *type, char *compres=
sor)
> >>  {
> >> @@ -356,13 +357,18 @@ static struct zswap_pool *zswap_pool_create(char=
 *type, char *compressor)
> >>         /* being the current pool takes 1 ref; this func expects the
> >>          * caller to always add the new pool as the current pool
> >>          */
> >> -       kref_init(&pool->kref);
> >> +       ret =3D percpu_ref_init(&pool->ref, __zswap_pool_empty,
> >> +                             PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
> >> +       if (ret)
> >> +               goto ref_fail;
> >>         INIT_LIST_HEAD(&pool->list);
> >>
> >>         zswap_pool_debug("created", pool);
> >>
> >>         return pool;
> >>
> >> +ref_fail:
> >> +       cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool-=
>node);
> >>  error:
> >>         if (pool->acomp_ctx)
> >>                 free_percpu(pool->acomp_ctx);
> >> @@ -435,8 +441,8 @@ static void __zswap_pool_release(struct work_struc=
t *work)
> >>
> >>         synchronize_rcu();
> >>
> >> -       /* nobody should have been able to get a kref... */
> >> -       WARN_ON(kref_get_unless_zero(&pool->kref));
> >
> > Do we no longer care about this WARN? IIUC, this is to catch someone
> > still holding a reference to the pool at release time, which sounds
> > like a bug. I think we can simulate the similar behavior with:
>
> Ok, I thought it has already been put to 0 when we're here, so any tryget
> will fail. But keeping this WARN_ON() is also fine to me, will keep it.

Yup - it should fail, if the code is not buggy. But that's a pretty big if =
:)

Jokes aside, we can remove it if folks think the benefit is not worth
the cost/overhead. However, I'm a bit hesitant to remove checks in
zswap, especially given how buggy it has been (some of which are
refcnt bugs as well, IIRC).

