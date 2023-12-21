Return-Path: <linux-kernel+bounces-7698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6681ABB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16761C21A28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554780C;
	Thu, 21 Dec 2023 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHoibLme"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A89623
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a234938c7f3so21269966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703118299; x=1703723099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2A+gj4jHgXnzarDM6KYQd3pZD+FO87csNCByA+KPf0=;
        b=WHoibLmegBXPC1yS/7fTmFS1FHsKqgtaIGlzrw087IAc7ZYeVSW1QZHawqwYTIPRQh
         vwWnzYXmnpb02YkszcmfE46qJyCy0rMKIJOCreRmYjQMhSf0ZKD+dd0F7mxgP+Gl/+tL
         yX99uknj8cUUyPP6PH/tvUVNMYclA18lMuM7xzzZBg33edIIDBBj5Ln4xQezHl11M4dQ
         qIyTfxrOLNtbIkTpEGyBuXXRLX1+i0QhP6SHcV3K7lCDjIFBDtSu9whn8vlB+8V5a8qv
         ULlk8abO1akRkeDJufkjgvg9/LDM7EkhsnYIb75aVnCl3p1GutsOIZ9gx0sFlZoYN6rc
         4NKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703118299; x=1703723099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2A+gj4jHgXnzarDM6KYQd3pZD+FO87csNCByA+KPf0=;
        b=JaXpO1I7oRBiFpUl+flBzxCqOg5x1EVAfMeKo5VNU1xztk+XtenyfFKL9P7QF9OR5e
         VRa7ivyrYhYw4RkmicOuGxk31c/gtgW5XsnKdLAR1ThL8l5Mf4Q9kMmqjAmvhkK6FiyQ
         m/TX+LJ7flHmEAl3+zFO+UCqISpPigEQQI9TYZv/qPu42lhsoaJ9/D+4q2IHN4MoXVvE
         xoNNKlJCv2u8CldHXCkwsJvZMZQv8lSbqRXBvDOwTOEMePrSxmFa3PRhY/R50zG+BLtE
         HWKOLMxBM1yuKv/aehAnZEmzLE9JD5VHciuJmIXwt1Rvm9sWl8Xq3xLxgbMQ/HAxZs9s
         Oukw==
X-Gm-Message-State: AOJu0YwjDTwKmOetr/hcGB7tNmn1wkL1xjp7izh5+2UzqqWBFErkrikp
	mJ+mTLUE35ZRagRUH+77p2pu/Spw8r404kQo28Kccg==
X-Google-Smtp-Source: AGHT+IF/q0Cvl7dgpQLrdGEKfgdZRiZpZhKKggUyb19FqDUvKeUfvQ5HG1Q7O7+mO/6HSLVd2kEHYHF6fKE1AeZSODg=
X-Received: by 2002:a17:906:af0c:b0:a24:20f:d63a with SMTP id
 lx12-20020a170906af0c00b00a24020fd63amr1874289ejb.97.1703118299064; Wed, 20
 Dec 2023 16:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qktkitg@mail.gmail.com>
 <20231218144431.GB19167@cmpxchg.org> <CAJD7tkakMjE1sNfexLzooptDyQS4YZf5DmuoywnSFD7JTbh9BA@mail.gmail.com>
 <20231220051523.GB23822@cmpxchg.org> <CAJD7tkbzVjYxykracNW729xKTqFdpk5Hw5k94Epc_uSvUP1g=g@mail.gmail.com>
 <20231220145025.GC23822@cmpxchg.org>
In-Reply-To: <20231220145025.GC23822@cmpxchg.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 20 Dec 2023 16:24:22 -0800
Message-ID: <CAJD7tkbmWcEvsfF8i+HrRetTVu6v4fKFn2WL0RLsHNheu=5wVw@mail.gmail.com>
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

On Wed, Dec 20, 2023 at 6:50=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Dec 20, 2023 at 12:59:15AM -0800, Yosry Ahmed wrote:
> > On Tue, Dec 19, 2023 at 9:15=E2=80=AFPM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Mon, Dec 18, 2023 at 01:52:23PM -0800, Yosry Ahmed wrote:
> > > > > > Taking a step back from all the memory.swap.tiers vs.
> > > > > > memory.zswap.writeback discussions, I think there may be a more
> > > > > > fundamental problem here. If the zswap store failure is recurre=
nt,
> > > > > > pages can keep going back to the LRUs and then sent back to zsw=
ap
> > > > > > eventually, only to be rejected again. For example, this can if=
 zswap
> > > > > > is above the acceptance threshold, but could be even worse if i=
t's the
> > > > > > allocator rejecting the page due to not compressing well enough=
. In
> > > > > > the latter case, the page can keep going back and forth between=
 zswap
> > > > > > and LRUs indefinitely.
> > > > > >
> > > > > > You probably did not run into this as you're using zsmalloc, bu=
t it
> > > > > > can happen with zbud AFAICT. Even with zsmalloc, a less problem=
atic
> > > > > > version can happen if zswap is above its acceptance threshold.
> > > > > >
> > > > > > This can cause thrashing and ineffective reclaim. We have an in=
ternal
> > > > > > implementation where we mark incompressible pages and put them =
on the
> > > > > > unevictable LRU when we don't have a backing swapfile (i.e. gho=
st
> > > > > > swapfiles), and something similar may work if writeback is disa=
bled.
> > > > > > We need to scan such incompressible pages periodically though t=
o
> > > > > > remove them from the unevictable LRU if they have been dirited.
> > > > >
> > > > > I'm not sure this is an actual problem.
> > > > >
> > > > > When pages get rejected, they rotate to the furthest point from t=
he
> > > > > reclaimer - the head of the active list. We only get to them agai=
n
> > > > > after we scanned everything else.
> > > > >
> > > > > If all that's left on the LRU is unzswappable, then you'd assume =
that
> > > > > remainder isn't very large, and thus not a significant part of ov=
erall
> > > > > scan work. Because if it is, then there is a serious problem with=
 the
> > > > > zswap configuration.
> > > > >
> > > > > There might be possible optimizations to determine how permanent =
a
> > > > > rejection is, but I'm not sure the effort is called for just
> > > > > yet. Rejections are already failure cases that screw up the LRU
> > > > > ordering, and healthy setups shouldn't have a lot of those. I don=
't
> > > > > think this patch adds any sort of new complications to this pictu=
re.
> > > >
> > > > We have workloads where a significant amount (maybe 20%? 30% not su=
re
> > > > tbh) of the memory is incompressible. Zswap is still a very viable
> > > > option for those workloads once those pages are taken out of the
> > > > picture. If those pages remain on the LRUs, they will introduce a
> > > > regression in reclaim efficiency.
> > > >
> > > > With the upstream code today, those pages go directly to the backin=
g
> > > > store, which isn't ideal in terms of LRU ordering, but this patch
> > > > makes them stay on the LRUs, which can be harmful. I don't think we
> > > > can just assume it is okay. Whether we make those pages unevictable=
 or
> > > > store them uncompressed in zswap, I think taking them out of the LR=
Us
> > > > (until they are redirtied), is the right thing to do.
> > >
> > > This is how it works with zram as well, though, and it has plenty of
> > > happy users.
> >
> > I am not sure I understand. Zram does not reject pages that do not
> > compress well, right? IIUC it acts as a block device so it cannot
> > reject pages. I feel like I am missing something.
>
> zram_write_page() can fail for various reasons - compression failure,
> zsmalloc failure, the memory limit. This results in !!bio->bi_status,
> __end_swap_bio_write redirtying the page, and vmscan rotating it.
>
> The effect is actually more pronounced with zram, because the pages
> don't get activated and thus cycle faster.
>
> What you're raising doesn't seem to be a dealbreaker in practice.

For the workloads using zram, yes, they are exclusively using zsmalloc
which can store incompressible pages anyway.

>
> > If we already want to support taking pages away from the LRUs when
> > rejected by zswap (e.g. Nhat's proposal earlier), doesn't it make
> > sense to do that first so that this patch can be useful for all
> > workloads?
>
> No.
>
> Why should users who can benefit now wait for a hypothetical future
> optimization that isn't relevant to them? And by the looks of it, is
> only relevant to a small set of specialized cases?
>
> And the optimization - should anybody actually care to write it - can
> be transparently done on top later, so that's no reason to change
> merge order, either.

We can agree to disagree here, I am not trying to block this anyway.
But let's at least document this in the commit message/docs/code
(wherever it makes sense) -- that recurrent failures (e.g.
incompressible memory) may keep going back to zswap only to get
rejected, so workloads prone to this may observe some reclaim
inefficiency.

