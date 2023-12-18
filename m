Return-Path: <linux-kernel+bounces-4283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1160B817ADE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E197BB23282
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD76A006;
	Mon, 18 Dec 2023 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbTRxa8o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A2D1DDFC;
	Mon, 18 Dec 2023 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b7a9f90eeaso149670139f.1;
        Mon, 18 Dec 2023 11:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702927296; x=1703532096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAs6D0uJ0x5kiQXSZZGHnmNnaGxTdWspreN+/zc3zIo=;
        b=XbTRxa8oB5KadM0txe4w95eLJizrvFOG3s91HQOkm9OYfVViWd1sfR16tqRyfBX4ra
         m4hfViiKWpz35dS2Kozto9ZKde+Bh1tZ0OKmfp3K/tXkk1MAAsFpKq4QqPFTQ1I5N4LF
         HfceF4GzT3WBs+/HMo1t+YTAIW2I11S6LwSLqsUUdzr+xKOkc3jk2tIfKPeRlwU8ovuo
         eaBCiLyVqQJrDafKJMQLTT215v42tTRdQXXuNFqh56PfmQAh6LydOn6QHPWTZ5qUSnuu
         HEB7ZImmts5C3NGBngVJQRUD3VwKCWKfB71Hm6h8x6pDjpsAWwrpR8aGch+Z1oGrNJ/V
         d8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702927296; x=1703532096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAs6D0uJ0x5kiQXSZZGHnmNnaGxTdWspreN+/zc3zIo=;
        b=cwzhTp6Fvazn0EX/Pp68eL5gY9lDGda1fDO2qdvSG4K9UUbP8Ye6UbfHv0GreZ073A
         Q2beiB0EcGv6y4+shjPn/KccjZok3eWLoD7S05zABkljQOxNqonXL9vN0fMGJP5n7Ol8
         W9JWvywNGLg2ozxWQ4w9zjhMraY0xQbOpsgz+B91UIeltUduBHn56fKIaRW/fu/Eu+Ez
         IZr5qjMewrSeCxhN2PJc9d5jwLUd9Hab6WrTelEPRWBFA5e0CEyoTMxQfI0YqrQUYZGd
         93dSEaXQ8whB5HPQ7qhDwyuhkdA1uaZcpyBlllB6L2RI4yn+Wde5esPl/+d+hec6xSi2
         SDPA==
X-Gm-Message-State: AOJu0Yyb2hcpbtZ5csJKyCmn9zu6omo4lghp0xQ6oGCmqKIHuTWY7jXk
	pysYAJvsbjsPC8ILZnUy0VLF+WwuPPZvuntvhog=
X-Google-Smtp-Source: AGHT+IH23qT1zZXl3qSKeb37PU/BuOiKEnvrAT+6Q1oNu+yY5zedGw0T+lf+U9FJ6KgRhzjx8w71/lwSMxEGHoltcB4=
X-Received: by 2002:a6b:e515:0:b0:7b7:e9d:a645 with SMTP id
 y21-20020a6be515000000b007b70e9da645mr16533966ioc.23.1702927296164; Mon, 18
 Dec 2023 11:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qktkitg@mail.gmail.com>
 <20231218144431.GB19167@cmpxchg.org>
In-Reply-To: <20231218144431.GB19167@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 18 Dec 2023 11:21:24 -0800
Message-ID: <CAKEwX=OdeFCPNFzwQsGTsMV-+JB8dfTSbEff_ztENZ-8gwdnJQ@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, tj@kernel.org, 
	lizefan.x@bytedance.com, cerasuolodomenico@gmail.com, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev, 
	hughd@google.com, corbet@lwn.net, konrad.wilk@oracle.com, 
	senozhatsky@chromium.org, rppt@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	david@ixit.cz, chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 6:44=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, Dec 15, 2023 at 01:21:57PM -0800, Yosry Ahmed wrote:
> > On Thu, Dec 7, 2023 at 11:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > During our experiment with zswap, we sometimes observe swap IOs due t=
o
> > > occasional zswap store failures and writebacks-to-swap. These swappin=
g
> > > IOs prevent many users who cannot tolerate swapping from adopting zsw=
ap
> > > to save memory and improve performance where possible.
> > >
> > > This patch adds the option to disable this behavior entirely: do not
> > > writeback to backing swapping device when a zswap store attempt fail,
> > > and do not write pages in the zswap pool back to the backing swap
> > > device (both when the pool is full, and when the new zswap shrinker i=
s
> > > called).
> > >
> > > This new behavior can be opted-in/out on a per-cgroup basis via a new
> > > cgroup file. By default, writebacks to swap device is enabled, which =
is
> > > the previous behavior. Initially, writeback is enabled for the root
> > > cgroup, and a newly created cgroup will inherit the current setting o=
f
> > > its parent.
> > >
> > > Note that this is subtly different from setting memory.swap.max to 0,=
 as
> > > it still allows for pages to be stored in the zswap pool (which itsel=
f
> > > consumes swap space in its current form).
> > >
> > > This patch should be applied on top of the zswap shrinker series:
> > >
> > > https://lore.kernel.org/linux-mm/20231130194023.4102148-1-nphamcs@gma=
il.com/
> > >
> > > as it also disables the zswap shrinker, a major source of zswap
> > > writebacks.
> > >
> > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > Taking a step back from all the memory.swap.tiers vs.
> > memory.zswap.writeback discussions, I think there may be a more
> > fundamental problem here. If the zswap store failure is recurrent,
> > pages can keep going back to the LRUs and then sent back to zswap
> > eventually, only to be rejected again. For example, this can if zswap
> > is above the acceptance threshold, but could be even worse if it's the
> > allocator rejecting the page due to not compressing well enough. In
> > the latter case, the page can keep going back and forth between zswap
> > and LRUs indefinitely.
> >
> > You probably did not run into this as you're using zsmalloc, but it

Which is why I recommend everyone to use zsmalloc, and change the
default allocator to it in Kconfig :)

But tongue-in-cheek aside, I think this is fine. As you noted below,
we probably want to try again on that page (for instance, in case its
content has changed and is now more compressible). And as Johannes has
explained, we'll only look at it again once we have scanned everything
else. This sounds acceptable to me.

Now if all of the intermediate pages are also unstoreable as well,
then we have a problem, but that seems unlikely, and perhaps is an
indication that we need to do something else entirely (if the workload
is *that* incompressible, perhaps it is better to just disable zswap
entirely here).

> > can happen with zbud AFAICT. Even with zsmalloc, a less problematic
> > version can happen if zswap is above its acceptance threshold.
> >
> > This can cause thrashing and ineffective reclaim. We have an internal
> > implementation where we mark incompressible pages and put them on the
> > unevictable LRU when we don't have a backing swapfile (i.e. ghost
> > swapfiles), and something similar may work if writeback is disabled.
> > We need to scan such incompressible pages periodically though to
> > remove them from the unevictable LRU if they have been dirited.
>
> I'm not sure this is an actual problem.
>
> When pages get rejected, they rotate to the furthest point from the
> reclaimer - the head of the active list. We only get to them again
> after we scanned everything else.

Agree.  That is the reason why we rotate the LRU here - to avoid
touching it again until we have tried other pages.

>
> If all that's left on the LRU is unzswappable, then you'd assume that
> remainder isn't very large, and thus not a significant part of overall
> scan work. Because if it is, then there is a serious problem with the
> zswap configuration.

Agree.

>
> There might be possible optimizations to determine how permanent a
> rejection is, but I'm not sure the effort is called for just
> yet. Rejections are already failure cases that screw up the LRU
> ordering, and healthy setups shouldn't have a lot of those. I don't
> think this patch adds any sort of new complications to this picture.

Yep. This is one of the reasons (among many) why we were toying around
with storing uncompressed pages in zswap - it's one of the failure
cases where trying again (if the page's content has not changed) -
isn't likely to yield a different result, so might as well just retain
the overall LRU ordering and squeeze it in zswap (but as discussed,
that has quite a bit of implications that we need to deal with).

