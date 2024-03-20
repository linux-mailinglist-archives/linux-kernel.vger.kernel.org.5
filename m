Return-Path: <linux-kernel+bounces-108393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F34B8809EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339D31C22D66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44282BAFC;
	Wed, 20 Mar 2024 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJCvIH/Q"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B12BB0A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902885; cv=none; b=MMyrQOvtlqQ3zCCD2gqknkn5a9og9+e7ouVapel923A/zwqh2iDbbTbN4uPHjdsQhGE5656PI+i7ZkwodHxdwu8rk6+J2SguZKp+1L6y7M5TW0WETLG879ZQDteMXeM9WXk9Nm8KPNpZyaSVOfW37pCWZ5i7llFTkRPn7VnPSt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902885; c=relaxed/simple;
	bh=LwB7Xs9yyepMcXo/druWrMcEuXVo4j7h2tFRCWTAtsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOXVfLFKRzuOzEPz+nlpK9MraXjIYZAzfJSOyAEjwObhBLZCNKLL17pWrkKMLJolyKGln4yDfbEPemqPUP2QafnDxqx2e2ZAGHkvkWj853Yhs6HevU5ndHnC4c8Q3+gLQOkyT1XB0rduhMnkrcAEEuYtE090OOYkucFu0ZRzwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJCvIH/Q; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e0a3fdaef3so297561241.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710902882; x=1711507682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2zDHLzD2gozMABkU+Rb308kWqluttfK/My8IZFv7bE=;
        b=WJCvIH/QaHJkXCdfR25onhkclYQ/VFJfIlPc4PdSJDwnih4KPayagGH6baYbVd4Xpz
         /QcjEwwxUtH4tdNOiccdXUm5xQOIYfK4wugXwKTReqMtgpxkuFPzermd5zb8DWmMqC1T
         Jz1DZOJkgzpzGeMQfsy1a9ANW4z0L4LeDbiROMU+Li576LDuP9ua96cr0Kjw+2IuCEUo
         tBfGn6OLY7Plk9BHPm9CQwr6BWL9hyAUXS/C8hhfwWOLwLBSSldFBMh6XXY+aH1GPeO/
         PlXzpCF/WqBQy5NIxwT33qulaJoVrmMLElZVwUpi62W+hib8NOwwXVQsXzcF5LW0TNlw
         PZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902882; x=1711507682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2zDHLzD2gozMABkU+Rb308kWqluttfK/My8IZFv7bE=;
        b=jYyRz6Qj8ixaHhH2UrCnjkQZa6k9S3FkSP/G2pxImoyfS5MM+xoQYDPpCfd/YORXYq
         nn4d4w2JWXmE/N3DvHSEkf6S0DucH/27H3LzSuzTNkV4RtVppAiaKNPOnA3fLuYgoHYR
         pWnWitrd6+tNBZ4O0WYoNhoYZ18jWuyzLxxqxJ3PUHIZT6TVg9dA5A5QVf0H9AgxcTSw
         Z/T1l+1mVfb38XvkdsvVEj4wqchxFSzjgHW3J8h7y2EnDLpWX5ey8eY6Mia5PPguqc5o
         pLqoiuzqeZXUo4088B2ttC9HtDy+2AZzH58s/x0pvXhOGrNd6ng0C4M0dljeQJggGckU
         CPLg==
X-Forwarded-Encrypted: i=1; AJvYcCVpn6oaFeWVWb8hJsrk4r75b5L5/eCMDEUea5jWd5ipIC3sXAS+0M/HYR/yWR/rgxihvwfrrnG0aeTwYTqaqIFwzR6aILAcwr31yn84
X-Gm-Message-State: AOJu0YxB/F8FUA+OQ1BYQ7XeIIZDYMyuSfp5ux/7W+jouR4jv+NgF9xQ
	7yL2vi3LehfhJaiQb2ActyDuIg2dcCW/VMTNWBVRruxL8eFXVokMWEfFV8YH6uWP4TwEaeJ5TjX
	WodXf5t3ExcAEK7f93Olhu+aTW1k=
X-Google-Smtp-Source: AGHT+IFPKyvY1+N1OUzaJDaMMheT9M1hSCaKRHjOgDe3v3QLnyYDrkevkMjsjrIdW148I9iAOA9baVXo//SuHF7Ly8A=
X-Received: by 2002:a1f:eb43:0:b0:4d4:1a1a:6db7 with SMTP id
 j64-20020a1feb43000000b004d41a1a6db7mr672030vkh.2.1710902881911; Tue, 19 Mar
 2024 19:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-6-21cnbao@gmail.com>
 <87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
 <87sf0rx3d6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xna1xKz7J=MWDR3h543UvnS9v0-+ggVc5fFzpFOzfpyA@mail.gmail.com>
 <87jzm0wblq.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wTU3cmzXMCu+yQRMnEiCEUA8rO5=QQUopgG0RMnHYd5g@mail.gmail.com>
 <9ec62266-26f1-46b6-8bb7-9917d04ed04e@arm.com> <87jzlyvar3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <f918354d-12ee-4349-9356-fc02d2457a26@arm.com> <87zfutsl25.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87zfutsl25.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 20 Mar 2024 15:47:50 +1300
Message-ID: <CAGsJ_4zuEFnLwM_h7DF1BN2eN3P4S0Sw=omxo90ucKpPT4ampA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:20=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Ryan Roberts <ryan.roberts@arm.com> writes:
>
> > On 19/03/2024 09:20, Huang, Ying wrote:
> >> Ryan Roberts <ryan.roberts@arm.com> writes:
> >>
> >>>>>> I agree phones are not the only platform. But Rome wasn't built in=
 a
> >>>>>> day. I can only get
> >>>>>> started on a hardware which I can easily reach and have enough har=
dware/test
> >>>>>> resources on it. So we may take the first step which can be applie=
d on
> >>>>>> a real product
> >>>>>> and improve its performance, and step by step, we broaden it and m=
ake it
> >>>>>> widely useful to various areas  in which I can't reach :-)
> >>>>>
> >>>>> We must guarantee the normal swap path runs correctly and has no
> >>>>> performance regression when developing SWP_SYNCHRONOUS_IO optimizat=
ion.
> >>>>> So we have to put some effort on the normal path test anyway.
> >>>>>
> >>>>>> so probably we can have a sysfs "enable" entry with default "n" or
> >>>>>> have a maximum
> >>>>>> swap-in order as Ryan's suggestion [1] at the beginning,
> >>>>>>
> >>>>>> "
> >>>>>> So in the common case, swap-in will pull in the same size of folio=
 as was
> >>>>>> swapped-out. Is that definitely the right policy for all folio siz=
es? Certainly
> >>>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO). But=
 I'm not sure
> >>>>>> it makes sense for 2M THP; As the size increases the chances of ac=
tually needing
> >>>>>> all of the folio reduces so chances are we are wasting IO. There a=
re similar
> >>>>>> arguments for CoW, where we currently copy 1 page per fault - it p=
robably makes
> >>>>>> sense to copy the whole folio up to a certain size.
> >>>>>> "
> >>>
> >>> I thought about this a bit more. No clear conclusions, but hoped this=
 might help
> >>> the discussion around policy:
> >>>
> >>> The decision about the size of the THP is made at first fault, with s=
ome help
> >>> from user space and in future we might make decisions to split based =
on
> >>> munmap/mremap/etc hints. In an ideal world, the fact that we have had=
 to swap
> >>> the THP out at some point in its lifetime should not impact on its si=
ze. It's
> >>> just being moved around in the system and the reason for our original=
 decision
> >>> should still hold.
> >>>
> >>> So from that PoV, it would be good to swap-in to the same size that w=
as
> >>> swapped-out.
> >>
> >> Sorry, I don't agree with this.  It's better to swap-in and swap-out i=
n
> >> smallest size if the page is only accessed seldom to avoid to waste
> >> memory.
> >
> > If we want to optimize only for memory consumption, I'm sure there are =
many
> > things we would do differently. We need to find a balance between memor=
y and
> > performance. The benefits of folios are well documented and the kernel =
is
> > heading in the direction of managing memory in variable-sized blocks. S=
o I don't
> > think it's as simple as saying we should always swap-in the smallest po=
ssible
> > amount of memory.
>
> It's conditional, that is,
>
> "if the page is only accessed seldom"
>
> Then, the page swapped-in will be swapped-out soon and adjacent pages in
> the same large folio will not be accessed during this period.
>
> So, I suggest to create an algorithm to decide swap-in order based on
> swap-readahead information automatically.  It can detect the situation
> above via reduced swap readahead window size.  And, if the page is
> accessed for quite long time, and the adjacent pages in the same large
> folio are accessed too, swap-readahead window will increase and large
> swap-in order will be used.

The original size of do_anonymous_page() should be honored, considering it
embodies a decision influenced by not only sysfs settings and per-vma
HUGEPAGE hints but also architectural characteristics, for example
CONT-PTE.

The model you're proposing may offer memory-saving benefits or reduce I/O,
but it entirely disassociates the size of the swap in from the size prior t=
o the
swap out. Moreover, there's no guarantee that the large folio generated by
the readahead window is contiguous in the swap and can be added to the
swap cache, as we are currently dealing with folio->swap instead of
subpage->swap.

Incidentally, do_anonymous_page() serves as the initial location for alloca=
ting
large folios. Given that memory conservation is a significant consideration=
 in
do_swap_page(), wouldn't it be even more crucial in do_anonymous_page()?

A large folio, by its nature, represents a high-quality resource that has t=
he
potential to leverage hardware characteristics for the benefit of the
entire system.
Conversely, I don't believe that a randomly determined size dictated by the
readahead window possesses the same advantageous qualities.

SWP_SYNCHRONOUS_IO devices are not reliant on readahead whatsoever,
their needs should also be respected.

> > You also said we should swap *out* in smallest size possible. Have I
> > misunderstood you? I thought the case for swapping-out a whole folio wi=
thout
> > splitting was well established and non-controversial?
>
> That is conditional too.
>
> >>
> >>> But we only kind-of keep that information around, via the swap
> >>> entry contiguity and alignment. With that scheme it is possible that =
multiple
> >>> virtually adjacent but not physically contiguous folios get swapped-o=
ut to
> >>> adjacent swap slot ranges and then they would be swapped-in to a sing=
le, larger
> >>> folio. This is not ideal, and I think it would be valuable to try to =
maintain
> >>> the original folio size information with the swap slot. One way to do=
 this would
> >>> be to store the original order for which the cluster was allocated in=
 the
> >>> cluster. Then we at least know that a given swap slot is either for a=
 folio of
> >>> that order or an order-0 folio (due to cluster exhaustion/scanning). =
Can we
> >>> steal a bit from swap_map to determine which case it is? Or are there=
 better
> >>> approaches?
> >>
> >> [snip]
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

