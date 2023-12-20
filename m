Return-Path: <linux-kernel+bounces-6615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87550819B08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB75D1C23612
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE18A1D6A6;
	Wed, 20 Dec 2023 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXe0anDK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5731D53D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2370535060so94361666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703062793; x=1703667593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLR+Picg0YGbnnq1391FrVjY92aX0Fgy3Wr8+PVd9bw=;
        b=sXe0anDKGynyl3fCAqitRIcXDTeKs9HKpUq5k84Jt+duKTCrghhUZNa2w2ZjndaeRl
         +dTbUKifDhF1QfBW5OUFCw7IBWtQG0KBbKWu3SgsovxvP5uxBhaRQaL/hp7ndlFMN+cz
         i+oUEK2LI6zlQMzHhZZv4r7JqzPlcRVorUxiy8LLagvXFWhAGKPlLoY7XJo2gL5C0LE2
         LzM8yO4GtJNxVMaIUk7aahyVIn09HuPk2iO4jRpmw7zV/zxSRnj0k7re81+rafYyS8ax
         J++ofSqGDw/Xa4JViZzKCS+ZHIOg4Rys8lNYNChIV9SaVOJKrrl0R4/KjxUAEk9DIGkC
         NVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062793; x=1703667593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLR+Picg0YGbnnq1391FrVjY92aX0Fgy3Wr8+PVd9bw=;
        b=A0TrOI5xBQWcnOE5yVYrHOQECGO5B5cGJHcPxEBUZgGsstms5VG3jqlmXo64MKPi5t
         tBigtSQ97chxkZog54benob3ilnkHergA5mDrPIyh6FjKsJFNkQnjUxqtgEdFwPsSzKj
         Bzcm3YQ6MZ8XemWa4KlCcV0+qGaWbhuL8WyndiV1Bp05mcSWHyyRgzGBBM/ldkSUSpHD
         oY6y3WVJksv9QamupKFHdpFoIq2Yr8FGAoP5d23tjrAfPycd9jj4oS4g4WD19geRlWST
         WZWEQlzCHotTK8WAPeSKb2Yx3OAjayNAJ7DDgEIaq5ogoItgQUK9beBnffZj6sQTdLMY
         KHqA==
X-Gm-Message-State: AOJu0YwgxWVO6LOlWvCXPwjL6tLS7OC5Bhjl2R6jnvDDzZQ6hwwDKVsF
	HpJfLrL39TL2IepDWjimVjdtrqW/B1AjMON5qr3NXdXVcB3U
X-Google-Smtp-Source: AGHT+IHYRWeO+3YIShZ1cYf6+2ND6yE4M9EA0qe8haJZaUeBo81F4ZbCNe42GvjFLhqnrfwVF2zP0/Tv+/P2iuKmpls=
X-Received: by 2002:a17:906:3405:b0:a23:74a8:ade with SMTP id
 c5-20020a170906340500b00a2374a80ademr2246512ejb.25.1703062792537; Wed, 20 Dec
 2023 00:59:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qktkitg@mail.gmail.com>
 <20231218144431.GB19167@cmpxchg.org> <CAJD7tkakMjE1sNfexLzooptDyQS4YZf5DmuoywnSFD7JTbh9BA@mail.gmail.com>
 <20231220051523.GB23822@cmpxchg.org>
In-Reply-To: <20231220051523.GB23822@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 20 Dec 2023 00:59:15 -0800
Message-ID: <CAJD7tkbzVjYxykracNW729xKTqFdpk5Hw5k94Epc_uSvUP1g=g@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, tj@kernel.org, 
	lizefan.x@bytedance.com, cerasuolodomenico@gmail.com, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev, 
	hughd@google.com, corbet@lwn.net, konrad.wilk@oracle.com, 
	senozhatsky@chromium.org, rppt@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	david@ixit.cz, chrisl@kernel.org, Wei Xu <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:15=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Dec 18, 2023 at 01:52:23PM -0800, Yosry Ahmed wrote:
> > > > Taking a step back from all the memory.swap.tiers vs.
> > > > memory.zswap.writeback discussions, I think there may be a more
> > > > fundamental problem here. If the zswap store failure is recurrent,
> > > > pages can keep going back to the LRUs and then sent back to zswap
> > > > eventually, only to be rejected again. For example, this can if zsw=
ap
> > > > is above the acceptance threshold, but could be even worse if it's =
the
> > > > allocator rejecting the page due to not compressing well enough. In
> > > > the latter case, the page can keep going back and forth between zsw=
ap
> > > > and LRUs indefinitely.
> > > >
> > > > You probably did not run into this as you're using zsmalloc, but it
> > > > can happen with zbud AFAICT. Even with zsmalloc, a less problematic
> > > > version can happen if zswap is above its acceptance threshold.
> > > >
> > > > This can cause thrashing and ineffective reclaim. We have an intern=
al
> > > > implementation where we mark incompressible pages and put them on t=
he
> > > > unevictable LRU when we don't have a backing swapfile (i.e. ghost
> > > > swapfiles), and something similar may work if writeback is disabled=
.
> > > > We need to scan such incompressible pages periodically though to
> > > > remove them from the unevictable LRU if they have been dirited.
> > >
> > > I'm not sure this is an actual problem.
> > >
> > > When pages get rejected, they rotate to the furthest point from the
> > > reclaimer - the head of the active list. We only get to them again
> > > after we scanned everything else.
> > >
> > > If all that's left on the LRU is unzswappable, then you'd assume that
> > > remainder isn't very large, and thus not a significant part of overal=
l
> > > scan work. Because if it is, then there is a serious problem with the
> > > zswap configuration.
> > >
> > > There might be possible optimizations to determine how permanent a
> > > rejection is, but I'm not sure the effort is called for just
> > > yet. Rejections are already failure cases that screw up the LRU
> > > ordering, and healthy setups shouldn't have a lot of those. I don't
> > > think this patch adds any sort of new complications to this picture.
> >
> > We have workloads where a significant amount (maybe 20%? 30% not sure
> > tbh) of the memory is incompressible. Zswap is still a very viable
> > option for those workloads once those pages are taken out of the
> > picture. If those pages remain on the LRUs, they will introduce a
> > regression in reclaim efficiency.
> >
> > With the upstream code today, those pages go directly to the backing
> > store, which isn't ideal in terms of LRU ordering, but this patch
> > makes them stay on the LRUs, which can be harmful. I don't think we
> > can just assume it is okay. Whether we make those pages unevictable or
> > store them uncompressed in zswap, I think taking them out of the LRUs
> > (until they are redirtied), is the right thing to do.
>
> This is how it works with zram as well, though, and it has plenty of
> happy users.

I am not sure I understand. Zram does not reject pages that do not
compress well, right? IIUC it acts as a block device so it cannot
reject pages. I feel like I am missing something.

> The fact that there are antagonistic workloads doesn't
> mean the feature isn't useful. This flag is optional and not enabled
> by default, so nobody is forced to use it where it hurts.
>
> I'm not saying it's not worth optimizing those cases, but it doesn't
> look like a requirement in order to be useful to a variety of loads.

But we don't even understand the impact on those workloads today to
properly document it. What happens with a workload using zbud for
example and has quite a bit of memory that gets rejected? Is the
feature usable for such a setup or not? There has also been
discussions upstream about introducing a compression threshold for
zswap in general (see below), this seems to be going in an opposite
direction.

If we already want to support taking pages away from the LRUs when
rejected by zswap (e.g. Nhat's proposal earlier), doesn't it make
sense to do that first so that this patch can be useful for all
workloads?

>
> > Adding Wei and Yu for more data about incompressible memory in our
> > fleet. Keep in mind that we have internal patches to cap the
> > compression ratio (i.e. reject pages where the compressed size +
> > metadata is not worth it, or where zsmalloc will store it in a full
> > page anyway). But the same thing can happen upstream with zbud.
>
> I hate to bring this up, but there has been a bit of a disturbing
> trend in the zswap discussions recently.
>
> Please do not argue with private patches. Their behavior, the usecases
> they enable, and their dependencies are entirely irrelevant to patches
> submitted in this forum. They do not need to cater to them or consider
> the consequences for them. The only thing that matters is the upstream
> codebase and the usecases enabled by it.

Sorry if my intention wasn't clear. I am not arguing that this patch
affects our internal patches in any way. All I am saying is that we do
something similar internally, and we would like to move to an upstream
solution if possible -- so naturally we want the upstream solution to
work for us as well.

Besides, this can happen in the upstream codebase with zbud as I
mentioned earlier, and there has been discussions upstream about
introducing such a compression threshold as well (e.g. [1]). So it is
not something unique to Google. If this is where we think we are
headed upstream (and is already the case with zbud), I think it's not
unreasonable to bring it up.

[1]https://lore.kernel.org/lkml/7a0e3229-be63-4a24-a3fe-7e3ff517de10@byteda=
nce.com/

