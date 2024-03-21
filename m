Return-Path: <linux-kernel+bounces-109886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA90885758
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E60283018
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726BD5645E;
	Thu, 21 Mar 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyTlyDzH"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C03B200D3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016437; cv=none; b=SCOBUT/srN5RyHdAoXmVB9sr5BJYKoA+l4vuGkXGcU7+V6S74mlkupdqXBdRwYe4QeKsrpbspnXPmjMdOqRCG3QZPFMwlHNkwtuK00FgVmCvWnXIwC5SpVxBTrrkr8nPcg6UYnpd20H7HCfmRCbNdZgvcoMflg6PWbrzGC8qEFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016437; c=relaxed/simple;
	bh=lFrVJYmfysxEsJ0xiffGlnGeVtEFAwmKETvh1ku2HhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gezKdKedASyd6LWYOjJuYyd/jlDaWmPnrU1XUGk6DbTg35afG/9ftUn6Ng0Hw9sQ7Ph2g96VzX9gXjYKbLHaqfMRx15ZUl01LU5z19/WQwzYJJljxC4AnDNvNKPPyi1kx/FrN9X6wLMiG8mwuCzy/jiBxWYHOgCwbQMG+o0/Zos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyTlyDzH; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4d43a1f0188so308424e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711016435; x=1711621235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGZfHShf8cu5x0RkynH4JraFdCNV05guyu1vnYqsvdg=;
        b=OyTlyDzH1gbvBP4E9SlnMw0vo1cWLPecTUXb4Vf9wwTUKddyJYg/5/hkzChOEKSx+k
         iIAVbAK3LxjMXuSPHGvG2UPf+C92fi4Fx1doN9rDhxqpUCiOumF+KZ78/fxJkyuqItk8
         PoTF7FVPlJi892ulYRki+PrFuYg4iMYzhrnQzIjgz/v2z1SWkZdi2KUWRjnyuyAH5Brd
         WBYIIuVTpIklQPOoJoLTfJ+7UrKORs+GcCgJhu/2Nzv2DnKyFLxNdBm6XOL9ZUKJa2V0
         65TqE7sAUzzV3YHDydlRsUBieDTdklA/1uWgAo6Jh+hdf8TA/M8qy8p11TrXAKCdvEj+
         7ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711016435; x=1711621235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGZfHShf8cu5x0RkynH4JraFdCNV05guyu1vnYqsvdg=;
        b=Tvba0u112mPK6aYmLau6w3ay5/VH+hBZ63faGhv95hY2HRwUB37EvNAshV5rbmBEXl
         BQI2TijxUo3aa9VveU0aRvxw9sluLp4lVAqEv33DE+OjVkBGdEzhLcDPZtHC/Xm8Br6B
         iPaz3xxbNGiXkbR2n7zn+jE03O/pK4nN+ou0k+MD2wCHKh8wWrsWYMuqP6j8F0Owhw6D
         1sVVEhnovfgDbZnPxZ6i2HaiNe6QwyenflHMd0dRq1NKo6jtMh8tWrYeqtBRb6tHOgpm
         yMzsMbLbQfXJBlNp2Mj246HqSS4XYSp3q4KrDkwO2GkGpDOTHVncw5r0Rk0Nxirz7l8h
         fLtg==
X-Forwarded-Encrypted: i=1; AJvYcCVXFDwpy/TGBrrLdb+VnzJ1lJHcxZKb+GLegvzquDI4Bb0SJPo340kEIc6pIdxWmFseU2CW2R+iSRk9y0P8Z5cUc3BRh3qsdWgICpRC
X-Gm-Message-State: AOJu0YyQLGa4gV+oZlGTsGnCScEe75Y39/6UwmdeRju9kh83xG27cLk7
	zvIJ9Fm9GYU6Wg0mvFxetV6ff3Z3NPNs5svpsKw/3BNkLC+fD8otImtLov0TSX7Zh5NaD0XNkOD
	rQqdulw7eE+2A3XjlU3aCM8c02+U=
X-Google-Smtp-Source: AGHT+IGRfCz7kzvP0Ejqk7dWG4ee/kOzQMXlvoxiZ0s0QmlwQF2ws14PTJlNaVzZp30vTe4Jvy2QOMjKlTFqCvncEo8=
X-Received: by 2002:a1f:f80a:0:b0:4d4:1b6a:7924 with SMTP id
 w10-20020a1ff80a000000b004d41b6a7924mr1160950vkh.8.1711016434870; Thu, 21 Mar
 2024 03:20:34 -0700 (PDT)
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
 <f918354d-12ee-4349-9356-fc02d2457a26@arm.com>
In-Reply-To: <f918354d-12ee-4349-9356-fc02d2457a26@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Mar 2024 23:20:23 +1300
Message-ID: <CAGsJ_4wb6JTuBs=_xvUUB+80W7rXOeR2OhJT1418_Xnmu-1VvA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, chengming.zhou@linux.dev, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 1:19=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 19/03/2024 09:20, Huang, Ying wrote:
> > Ryan Roberts <ryan.roberts@arm.com> writes:
> >
> >>>>> I agree phones are not the only platform. But Rome wasn't built in =
a
> >>>>> day. I can only get
> >>>>> started on a hardware which I can easily reach and have enough hard=
ware/test
> >>>>> resources on it. So we may take the first step which can be applied=
 on
> >>>>> a real product
> >>>>> and improve its performance, and step by step, we broaden it and ma=
ke it
> >>>>> widely useful to various areas  in which I can't reach :-)
> >>>>
> >>>> We must guarantee the normal swap path runs correctly and has no
> >>>> performance regression when developing SWP_SYNCHRONOUS_IO optimizati=
on.
> >>>> So we have to put some effort on the normal path test anyway.
> >>>>
> >>>>> so probably we can have a sysfs "enable" entry with default "n" or
> >>>>> have a maximum
> >>>>> swap-in order as Ryan's suggestion [1] at the beginning,
> >>>>>
> >>>>> "
> >>>>> So in the common case, swap-in will pull in the same size of folio =
as was
> >>>>> swapped-out. Is that definitely the right policy for all folio size=
s? Certainly
> >>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO). But =
I'm not sure
> >>>>> it makes sense for 2M THP; As the size increases the chances of act=
ually needing
> >>>>> all of the folio reduces so chances are we are wasting IO. There ar=
e similar
> >>>>> arguments for CoW, where we currently copy 1 page per fault - it pr=
obably makes
> >>>>> sense to copy the whole folio up to a certain size.
> >>>>> "
> >>
> >> I thought about this a bit more. No clear conclusions, but hoped this =
might help
> >> the discussion around policy:
> >>
> >> The decision about the size of the THP is made at first fault, with so=
me help
> >> from user space and in future we might make decisions to split based o=
n
> >> munmap/mremap/etc hints. In an ideal world, the fact that we have had =
to swap
> >> the THP out at some point in its lifetime should not impact on its siz=
e. It's
> >> just being moved around in the system and the reason for our original =
decision
> >> should still hold.
> >>
> >> So from that PoV, it would be good to swap-in to the same size that wa=
s
> >> swapped-out.
> >
> > Sorry, I don't agree with this.  It's better to swap-in and swap-out in
> > smallest size if the page is only accessed seldom to avoid to waste
> > memory.
>
> If we want to optimize only for memory consumption, I'm sure there are ma=
ny
> things we would do differently. We need to find a balance between memory =
and
> performance. The benefits of folios are well documented and the kernel is
> heading in the direction of managing memory in variable-sized blocks. So =
I don't
> think it's as simple as saying we should always swap-in the smallest poss=
ible
> amount of memory.

Absolutely agreed. With 64KiB large folios implemented, there may have been
a slight uptick in memory usage due to fragmentation. Nevertheless, through=
 the
optimization of zRAM and zsmalloc to compress entire large folios, we found=
 that
the compressed data could be up to 1GiB smaller compared to compressing the=
m
in 4KiB increments on a typical phone with 12~16GiB memory. Consequently, w=
e
not only reclaimed our memory loss entirely but also gained the benefits of
CONT-PTE , reduced TLB misses etc.

>
> You also said we should swap *out* in smallest size possible. Have I
> misunderstood you? I thought the case for swapping-out a whole folio with=
out
> splitting was well established and non-controversial?
>
> >
> >> But we only kind-of keep that information around, via the swap
> >> entry contiguity and alignment. With that scheme it is possible that m=
ultiple
> >> virtually adjacent but not physically contiguous folios get swapped-ou=
t to
> >> adjacent swap slot ranges and then they would be swapped-in to a singl=
e, larger
> >> folio. This is not ideal, and I think it would be valuable to try to m=
aintain
> >> the original folio size information with the swap slot. One way to do =
this would
> >> be to store the original order for which the cluster was allocated in =
the
> >> cluster. Then we at least know that a given swap slot is either for a =
folio of
> >> that order or an order-0 folio (due to cluster exhaustion/scanning). C=
an we
> >> steal a bit from swap_map to determine which case it is? Or are there =
better
> >> approaches?
> >
> > [snip]
> >
> > --
> > Best Regards,
> > Huang, Ying

Thanks
Barry

