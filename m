Return-Path: <linux-kernel+bounces-109839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20162885656
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AA51282A11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC48053384;
	Thu, 21 Mar 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjs3TJqe"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63823BB35
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012942; cv=none; b=G2lgOceA1gg1xw3Hpz9m6kqkBMklluzFbR0goEY41R57KjIxNaddzswHKcESTKxXLihHEASwgOkPSxMNo2QB3PHEtBLmGCZt/NJqoAaElxPfSfOtsAEvnSA8ByoD9oTnCqY2raxdYvq9i7CIlqORgTokVDNLwBKpwO4LXLOR6bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012942; c=relaxed/simple;
	bh=PK/gIzz8f9Z0/+VmYjZFev1fla5COFfrRsZDhvCXupk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRewGguSl0MuQ/K1FvJJ3OKerkg7DPxEFdvNogvidvV5yHM9A53CJoT9BIAhUvAy1EW8ldVvAQGecP2AeG4VpA0l1k3SBBNwlIjWmTA/6WuV+wGu3e/1CpYvDxCpvPcDHuR2eySXWZaiaLavHPzPOb6ZZ6ouG1dUWiF7RsKklMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mjs3TJqe; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4d42ea640f0so297091e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711012940; x=1711617740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/SfnxPuh9EWRzGMLOisZaa8G0MP0iNbrgH6LWOByo0=;
        b=Mjs3TJqeWqUsCSrSf1Zns6CSlWORph5mqgS9d+NY8xFgbviEIqRkOAt+6WyItTsltN
         a5EX29tMQfZi/MTgQmYmfsiQXP47qjRl/aWn8ywmsGKi6GuO5M34JQexHZnQ/ko1kz3L
         7rGIYPQU7SNq5doLRv9nHqZ7gBHILGZKTUzpt/2pmckL91osYZ/9QtIGTWyB1HQbUJnq
         b2nhXuCI+vDWVC3yPCaVO53X53HBQYZtufYBNtUZ0cK/KipKY3lz6iUhQ7qg5xhRtydt
         pIcp+XL+d6L4CAuSDTu3EulY7s6OoQxZqOOoC3ESgLta9AwxRYPmoyLyvs8NTk/Cs9r1
         CbnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711012940; x=1711617740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/SfnxPuh9EWRzGMLOisZaa8G0MP0iNbrgH6LWOByo0=;
        b=BmzK6uaVR61CgVIv7YRgsZccAD4NiCj9QysUQh3ixO3FKpFkprzvGf15ZIG3Erp+bA
         Oh9DKyhL9wA2R+5MZ+Fm2Q1y+s+wkENMQQCVRY+ag1pDxcygsjv2UXgbLh9qntP/88ld
         f+fCbBi3xzA6NIOOBCtWlcgxSJvlgqiD75sXMv9TgfT5Y9p2ZU8iikHvRlvzijrBbhwd
         HPyP8Fw5hG9rQqGX+lKhSJ0uluo8ub5osdXMLDjXkpLyNAdQJRH8Tlywo4DTi8SotbX2
         SJrMg32GEfODMSxRQkEP7YtH3QjPE+NqmOgYgJrwNR2kROtqJ7v8jwy5f+ZxQR6hI0y5
         KW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSQZ1xeaNaevgXtXY0LGUHkC94elX/UbYODWmbgQU3vMdgT1RkXA3AW1uxVN/pGQdEEyzmkjoae+XHUaxBopegZUrdwlVuQaeeqFjC
X-Gm-Message-State: AOJu0Ywm/+b3FgtzTxtCT7Wmr7DPa7IdozER9bTTMEwDUZIbK5zrjTOT
	zptLXkGrUrRIWjAkTXHdpDHfkexDSngt6Lh3FPYudgVajty/PxvWyOfoldgatg+XElse7hndako
	q1eeY8MLx0gadIWFUuYu/JuwNLio=
X-Google-Smtp-Source: AGHT+IFjxfacrA08eDuMnbIwrfE3EdhXWfFxu/f74a3M1J4/YRzGYst3XpF6SN5AzPOoeMmfiCDds/4MOZ1COSGr35U=
X-Received: by 2002:a05:6122:3659:b0:4c0:2d32:612f with SMTP id
 dv25-20020a056122365900b004c02d32612fmr5502675vkb.15.1711012939590; Thu, 21
 Mar 2024 02:22:19 -0700 (PDT)
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
 <9ec62266-26f1-46b6-8bb7-9917d04ed04e@arm.com> <CAGsJ_4xBiWWEbyaxC6nhjpA5te6Q8irQmFxZDePCRZtcpF0sVQ@mail.gmail.com>
 <d678a127-f401-4bc2-94b5-723ce4e44270@arm.com>
In-Reply-To: <d678a127-f401-4bc2-94b5-723ce4e44270@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Mar 2024 22:22:08 +1300
Message-ID: <CAGsJ_4x5UMM9XFJWBERZssBtJosEKZrP5SxygKJ+fq=BG0Hh0g@mail.gmail.com>
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

On Tue, Mar 19, 2024 at 10:05=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 19/03/2024 06:27, Barry Song wrote:
> > On Tue, Mar 19, 2024 at 5:45=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
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
> >
> > Indeed, this is an ideal framework for smartphones and likely for
> > widely embedded
> > Linux systems utilizing zRAM. We set the mTHP size to 64KiB to
> > leverage CONT-PTE,
> > given that more than half of the memory on phones may frequently swap o=
ut and
> > swap in (for instance, when opening and switching between apps). The
> > ideal approach
> > would involve adhering to the decision made in do_anonymous_page().
> >
> >>
> >> So from that PoV, it would be good to swap-in to the same size that wa=
s
> >> swapped-out. But we only kind-of keep that information around, via the=
 swap
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
> > In the case of non-SWP_SYNCHRONOUS_IO, users will invariably invoke
> > swap_readahead()
> > even when __swap_count(entry) equals 1.  This leads to two scenarios:
> > swap_vma_readahead
> > and swap_cluster_readahead.
> >
> > In swap_vma_readahead, when blk_queue_nonrot, physical contiguity
> > doesn't appear to be a
> > critical concern. However, for swap_cluster_readahead, the focus
> > shifts towards the potential
> > impact of physical discontiguity.
>
> When you talk about "physical [dis]contiguity" I think you are talking ab=
out
> contiguity of the swap entries in the swap device? Both paths currently a=
llocate
> order-0 folios to swap into, so neither have a concept of physical contig=
uity in
> memory at the moment.
>
> As I understand it, roughly the aim is to readahead by cluster for rotati=
ng
> disks to reduce seek time, and readahead by virtual address for non-rotat=
ing
> devices since there is no seek time cost. Correct?

From the  code comment, I agree with this.

 * It's a main entry function for swap readahead. By the configuration,
 * it will read ahead blocks by cluster-based(ie, physical disk based)
 * or vma-based(ie, virtual address based on faulty address) readahead.

>
> Note that today, swap-out on supports (2M) THP if the swap device is
> non-rotating. If it is rotating, the THP is first split. My swap-out seri=
es
> maintains this policy for mTHP. So I think we only really care about
> swap_vma_readahead() here; we want to teach it to figure out the order of=
 the
> swap entries and swap them into folios of the same order (with a fallback=
 to
> order-0 if allocation fails).

I agree we don't need to care about devices which rotate.

>
> >
> > struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> >                                 struct vm_fault *vmf)
> > {
> >         struct mempolicy *mpol;
> >         pgoff_t ilx;
> >         struct folio *folio;
> >
> >         mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> >         folio =3D swap_use_vma_readahead() ?
> >                 swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
> >                 swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
> >         mpol_cond_put(mpol);
> >
> >         if (!folio)
> >                 return NULL;
> >         return folio_file_page(folio, swp_offset(entry));
> > }
> >
> > In Android and embedded systems, SWP_SYNCHRONOUS_IO is consistently uti=
lized,
> > rendering physical contiguity less of a concern. Moreover, instances wh=
ere
> > swap_readahead() is accessed are rare, typically occurring only in scen=
arios
> > involving forked but non-CoWed memory.
>
> Yes understood. What I'm hearing is that for Android at least, stealing a=
 bit
> from swap_map to remember if a swap entry is the order marked in the clus=
ter or
> order-0 won't be noticed because almost all entries have swap count =3D=
=3D 1. From
> memory, I think swap_map is 8 bits, and 2 bits are currently stolen, leav=
ing 6
> bits (count =3D 64) before having to move to the swap map continuation st=
uff. Does
> anyone know what workloads provoke this overflow? What are the consequenc=
es of
> reducing that count to 32?

I'm not entirely clear on why you need bits to record this
information. Could you
provide more details?

>
> >
> > So I think large folios swap-in will at least need three steps
> >
> > 1. on SWP_SYNCHRONOUS_IO (Android and embedded Linux), this has a very
> > clear model and has no complex I/O issue.
> > 2. on nonrot block device(bdev_nonrot =3D=3D  true), it cares less abou=
t
> > I/O contiguity.
> > 3. on rot block devices which care about  I/O contiguity.
>
> I don't think we care about (3); if the device rotates, we will have spli=
t the
> folio at swap-out, so we are only concerned with swapping-in order-0 foli=
os.
>
> >
> > This patchset primarily addresses the systems utilizing
> > SWP_SYNCHRONOUS_IO(type1),
> > such as Android and embedded Linux, a straightforward model is establis=
hed,
> > with minimal complexity regarding I/O issues.
>
> Understood. But your implication is that making swap_vma_readahead() larg=
e folio
> swap-in aware will be complex. I think we can remember the original order=
 in the
> swap device, then it shouldn't be too difficult - conceptually at least.

Currently, I can scan PTE entries and determine the number of
contiguous swap offsets.
The swap_vma_readahead code to support large folios already exists in
OPPO's repository.
I'm confident that it can be cleaned up and submitted to LKML.
However, the issue lies with
the readahead policy. We typically prefer using the same 64KiB size as in
do_anonymous_page(), but clearly, this isn't the preference for Ying :-)

>
> >
> >>
> >> Next we (I?) have concerns about wasting IO by swapping-in folios that=
 are too
> >> large (e.g. 2M). I'm not sure if this is a real problem or not - intui=
tively I'd
> >> say yes but I have no data. But on the other hand, memory is aged and
> >> swapped-out per-folio, so why shouldn't it be swapped-in per folio? If=
 the
> >> original allocation size policy is good (it currently isn't) then a fo=
lio should
> >> be sized to cover temporally close memory and if we need to access som=
e of it,
> >> chances are we need all of it.
> >>
> >> If we think the IO concern is legitimate then we could define a thresh=
old size
> >> (sysfs?) for when we start swapping-in the folio in chunks. And how bi=
g should
> >> those chunks be - one page, or the threshold size itself? Probably the=
 latter?
> >> And perhaps that threshold could also be used by zRAM to decide its up=
per limit
> >> for compression chunk.
> >
> >
> > Agreed. What about introducing a parameter like
> > /sys/kernel/mm/transparent_hugepage/max_swapin_order
> > giving users the opportunity to fine-tune it according to their needs. =
For type1
> > users specifically, setting it to any value above 4 would be
> > beneficial. If there's
> > still a lack of tuning for desktop and server environments (type 2 and =
type 3),
> > the default value could be set to 0.
>
> This sort of thing sounds sensible to me. But I have a history of proposi=
ng
> crappy sysfs interfaces :) So I'd like to hear from others - I suspect it=
 will
> take a fair bit of discussion before we converge. Having data to show tha=
t this
> threshold is needed would also help (i.e. demonstration that the intuitio=
n that
> swapping in a 2M folio is often counter-productive to performance).
>

I understand. The ideal swap-in size is obviously a contentious topic :-)
However,  for my real use case, simplicity reigns: we consistently adhere
to a single size - 64KiB.

> >
> >>
> >> Perhaps we can learn from khugepaged here? I think it has programmable
> >> thresholds for how many swapped-out pages can be swapped-in to aid col=
lapse to a
> >> THP? I guess that exists for the same concerns about increased IO pres=
sure?
> >>
> >>
> >> If we think we will ever be swapping-in folios in chunks less than the=
ir
> >> original size, then we need a separate mechanism to re-foliate them. W=
e have
> >> discussed a khugepaged-like approach for doing this asynchronously in =
the
> >> background. I know that scares the Android folks, but David has sugges=
ted that
> >> this could well be very cheap compared with khugepaged, because it wou=
ld be
> >> entirely limited to a single pgtable, so we only need the PTL. If we n=
eed this
> >> mechanism anyway, perhaps we should develop it and see how it performs=
 if
> >> swap-in remains order-0? Although I guess that would imply not being a=
ble to
> >> benefit from compressing THPs for the zRAM case.
> >
> > The effectiveness of collapse operation relies on the stability of
> > forming large folios
> > to ensure optimal performance. In embedded systems, where more than hal=
f of the
> > memory may be allocated to zRAM, folios might undergo swapping out befo=
re
> > collapsing or immediately after the collapse operation. It seems a
> > TAO-like optimization
> > to decrease fallback and latency is more effective.
>
> Sorry, I'm not sure I've understood what you are saying here.

I'm not entirely clear on the specifics of the khugepaged-like
approach. However,a major
distinction for Android is that its folios may not remain in memory
for extended periods.
If we incur the cost of compaction and page migration to form a large
folio, it might soon
be swapped out. Therefore, a potentially more efficient approach could
involve a TAO-like
pool, where we obtain large folios at a low cost.

>
> >
> >>
> >> I see all this as orthogonal to synchronous vs asynchronous swap devic=
es. I
> >> think the latter just implies that you might want to do some readahead=
 to try to
> >> cover up the latency? If swap is moving towards being folio-orientated=
, then
> >> readahead also surely needs to be folio-orientated, but I think that s=
hould be
> >> the only major difference.
> >>
> >> Anyway, just some thoughts!
> >
> > Thank you very much for your valuable and insightful deliberations.
> >
> >>
> >> Thanks,
> >> Ryan
> >>
> >

Thanks
Barry

