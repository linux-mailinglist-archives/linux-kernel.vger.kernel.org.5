Return-Path: <linux-kernel+bounces-107080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59687F74A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDECB21F63
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE7A7C0B8;
	Tue, 19 Mar 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSpEaWqL"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514A65195
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829651; cv=none; b=I7gvcls6uzEllvPaN28YPWPpQbdpM6rp+DaBMxxKh8b3kbIR0l+tbEJ7+VoJ5GUFl+Izwx4qtMfqzvVvKSpJZwewMgfKKAnzSo1aPurU50F41ppdBZYtvr3ccs6xQZ2yly26HDt4YcK1Kbzq+W8mcwqDy3+m69KL6CbcrM6PvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829651; c=relaxed/simple;
	bh=pVtxxugKsObC+6ht9V8/4xyXNqYWC2B1i48KlBcew+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r03UEzbeaV3ia+lO5v1TzxE/EWEukAaIcYxPG542bQ8Q6TWSrDiGS7TdEQIicw9MW+zyZcffiwcIn1O+heSeWnwPE+eRKq4G1lgx2uRikQzViVZfogX8xNj2iwVM3J8ND9TuELB1AVG4v2ZiLC0oTCSLqXdQMpNcF+/pwFhTijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSpEaWqL; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7e05cb778e9so829420241.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710829649; x=1711434449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vs7vWTjjMcASIAitT8voMJEud9O3qlM3o8yjeSirqcc=;
        b=BSpEaWqLxWpddHVdVxH4cLFhgcGoqzJmSLm8RZXbes9KYe8xH3VRrLFUt5LRP5wI07
         /YBT9AtkQU9q8DegD5yxdMyurA/dDVZDMBtkjhhBWuSZkQaQfGL7AaF/DGEZYoCZrF5Q
         fMuXnfkKbgGbHHe6AHq0vyhQSpTBvlyj5eBLptimlqFwcxaoRgm5hz40lonZADWjtO0O
         r9A0N0Yy0fECfhpFS9Oucv3oImORDKzO69A8YceAReLjQYs0/cfk3gZg7racRqzKOpde
         uMmEE5WgfFOU5a30lVl7W3GnbQV5gmZggtDwQYn37MAvXmbcKVBAPel59fvOBZmNz4ZI
         8YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710829649; x=1711434449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vs7vWTjjMcASIAitT8voMJEud9O3qlM3o8yjeSirqcc=;
        b=p+lEzrKbCJcJn027nXdXq/dzt+voKH0W7VYF6D75Lw37072yjjD5vPBQJlwc0gKJWG
         F+jShWbItjZe7CmjWB5c2OU5SPM5Xei95veLiwQneQifSdqZiGocm/5REj6W6IodJAH4
         8q9hLd4J7GwgxbPsi8JaC9WRSS2/DNqn3YSlpHmJGhqKBpSc+MzRdo47oT4TZGuXQ0sC
         UUbtUqNjgUSsX/JGgx69+xnzHOfBGFIZ8rwO9U/57qKnZjNBCkTkYlsuP/4NGGaTTDVw
         r4pYx35uUbWYWY6IJXpgnYJZAkqLtSxDKiXj84WkOwCUw4bbi4M74RnnWr5KOPrEGbe4
         40bA==
X-Forwarded-Encrypted: i=1; AJvYcCUA6+NuHM2/vcXTQRDdMMP1SkQdgy0MaxKIl+o+p4V+7PV3ziSuQm5RrRdAS5YyAszC3KRRex3mPDYTYVmXSpD2SQsUmhT7C5C+TiCF
X-Gm-Message-State: AOJu0YxJ5tjsmQ/HZ02Ms2OrUDBktDSHWksiD/y+HZDhDWDXXbdP+BT5
	7TqWfnqdnsNJWibumdoXzpnOx9Lo/uw+P1BCgkna/+gf6L2G8A0xqe1vwirUDoyXCNUOILiOONv
	3xJrGs+KDaPvB2zwx+Ad7TEFbKbQ=
X-Google-Smtp-Source: AGHT+IGlSLWj7FvqNg95icP/DE4JbNFLu1eeAnxnc7mSkqtYFFe8hed4h08NbE6pekrB61R3PPAICKqmiCdDLarE1cs=
X-Received: by 2002:a05:6122:731:b0:4d4:be1:8196 with SMTP id
 49-20020a056122073100b004d40be18196mr10456951vki.11.1710829648831; Mon, 18
 Mar 2024 23:27:28 -0700 (PDT)
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
 <9ec62266-26f1-46b6-8bb7-9917d04ed04e@arm.com>
In-Reply-To: <9ec62266-26f1-46b6-8bb7-9917d04ed04e@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 19:27:17 +1300
Message-ID: <CAGsJ_4xBiWWEbyaxC6nhjpA5te6Q8irQmFxZDePCRZtcpF0sVQ@mail.gmail.com>
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

On Tue, Mar 19, 2024 at 5:45=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> >>> I agree phones are not the only platform. But Rome wasn't built in a
> >>> day. I can only get
> >>> started on a hardware which I can easily reach and have enough hardwa=
re/test
> >>> resources on it. So we may take the first step which can be applied o=
n
> >>> a real product
> >>> and improve its performance, and step by step, we broaden it and make=
 it
> >>> widely useful to various areas  in which I can't reach :-)
> >>
> >> We must guarantee the normal swap path runs correctly and has no
> >> performance regression when developing SWP_SYNCHRONOUS_IO optimization=
.
> >> So we have to put some effort on the normal path test anyway.
> >>
> >>> so probably we can have a sysfs "enable" entry with default "n" or
> >>> have a maximum
> >>> swap-in order as Ryan's suggestion [1] at the beginning,
> >>>
> >>> "
> >>> So in the common case, swap-in will pull in the same size of folio as=
 was
> >>> swapped-out. Is that definitely the right policy for all folio sizes?=
 Certainly
> >>> it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'=
m not sure
> >>> it makes sense for 2M THP; As the size increases the chances of actua=
lly needing
> >>> all of the folio reduces so chances are we are wasting IO. There are =
similar
> >>> arguments for CoW, where we currently copy 1 page per fault - it prob=
ably makes
> >>> sense to copy the whole folio up to a certain size.
> >>> "
>
> I thought about this a bit more. No clear conclusions, but hoped this mig=
ht help
> the discussion around policy:
>
> The decision about the size of the THP is made at first fault, with some =
help
> from user space and in future we might make decisions to split based on
> munmap/mremap/etc hints. In an ideal world, the fact that we have had to =
swap
> the THP out at some point in its lifetime should not impact on its size. =
It's
> just being moved around in the system and the reason for our original dec=
ision
> should still hold.

Indeed, this is an ideal framework for smartphones and likely for
widely embedded
Linux systems utilizing zRAM. We set the mTHP size to 64KiB to
leverage CONT-PTE,
given that more than half of the memory on phones may frequently swap out a=
nd
swap in (for instance, when opening and switching between apps). The
ideal approach
would involve adhering to the decision made in do_anonymous_page().

>
> So from that PoV, it would be good to swap-in to the same size that was
> swapped-out. But we only kind-of keep that information around, via the sw=
ap
> entry contiguity and alignment. With that scheme it is possible that mult=
iple
> virtually adjacent but not physically contiguous folios get swapped-out t=
o
> adjacent swap slot ranges and then they would be swapped-in to a single, =
larger
> folio. This is not ideal, and I think it would be valuable to try to main=
tain
> the original folio size information with the swap slot. One way to do thi=
s would
> be to store the original order for which the cluster was allocated in the
> cluster. Then we at least know that a given swap slot is either for a fol=
io of
> that order or an order-0 folio (due to cluster exhaustion/scanning). Can =
we
> steal a bit from swap_map to determine which case it is? Or are there bet=
ter
> approaches?

In the case of non-SWP_SYNCHRONOUS_IO, users will invariably invoke
swap_readahead()
even when __swap_count(entry) equals 1.  This leads to two scenarios:
swap_vma_readahead
and swap_cluster_readahead.

In swap_vma_readahead, when blk_queue_nonrot, physical contiguity
doesn't appear to be a
critical concern. However, for swap_cluster_readahead, the focus
shifts towards the potential
impact of physical discontiguity.

struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
                                struct vm_fault *vmf)
{
        struct mempolicy *mpol;
        pgoff_t ilx;
        struct folio *folio;

        mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
        folio =3D swap_use_vma_readahead() ?
                swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
                swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
        mpol_cond_put(mpol);

        if (!folio)
                return NULL;
        return folio_file_page(folio, swp_offset(entry));
}

In Android and embedded systems, SWP_SYNCHRONOUS_IO is consistently utilize=
d,
rendering physical contiguity less of a concern. Moreover, instances where
swap_readahead() is accessed are rare, typically occurring only in scenario=
s
involving forked but non-CoWed memory.

So I think large folios swap-in will at least need three steps

1. on SWP_SYNCHRONOUS_IO (Android and embedded Linux), this has a very
clear model and has no complex I/O issue.
2. on nonrot block device(bdev_nonrot =3D=3D  true), it cares less about
I/O contiguity.
3. on rot block devices which care about  I/O contiguity.

This patchset primarily addresses the systems utilizing
SWP_SYNCHRONOUS_IO(type1),
such as Android and embedded Linux, a straightforward model is established,
with minimal complexity regarding I/O issues.

>
> Next we (I?) have concerns about wasting IO by swapping-in folios that ar=
e too
> large (e.g. 2M). I'm not sure if this is a real problem or not - intuitiv=
ely I'd
> say yes but I have no data. But on the other hand, memory is aged and
> swapped-out per-folio, so why shouldn't it be swapped-in per folio? If th=
e
> original allocation size policy is good (it currently isn't) then a folio=
 should
> be sized to cover temporally close memory and if we need to access some o=
f it,
> chances are we need all of it.
>
> If we think the IO concern is legitimate then we could define a threshold=
 size
> (sysfs?) for when we start swapping-in the folio in chunks. And how big s=
hould
> those chunks be - one page, or the threshold size itself? Probably the la=
tter?
> And perhaps that threshold could also be used by zRAM to decide its upper=
 limit
> for compression chunk.


Agreed. What about introducing a parameter like
/sys/kernel/mm/transparent_hugepage/max_swapin_order
giving users the opportunity to fine-tune it according to their needs. For =
type1
users specifically, setting it to any value above 4 would be
beneficial. If there's
still a lack of tuning for desktop and server environments (type 2 and type=
 3),
the default value could be set to 0.

>
> Perhaps we can learn from khugepaged here? I think it has programmable
> thresholds for how many swapped-out pages can be swapped-in to aid collap=
se to a
> THP? I guess that exists for the same concerns about increased IO pressur=
e?
>
>
> If we think we will ever be swapping-in folios in chunks less than their
> original size, then we need a separate mechanism to re-foliate them. We h=
ave
> discussed a khugepaged-like approach for doing this asynchronously in the
> background. I know that scares the Android folks, but David has suggested=
 that
> this could well be very cheap compared with khugepaged, because it would =
be
> entirely limited to a single pgtable, so we only need the PTL. If we need=
 this
> mechanism anyway, perhaps we should develop it and see how it performs if
> swap-in remains order-0? Although I guess that would imply not being able=
 to
> benefit from compressing THPs for the zRAM case.

The effectiveness of collapse operation relies on the stability of
forming large folios
to ensure optimal performance. In embedded systems, where more than half of=
 the
memory may be allocated to zRAM, folios might undergo swapping out before
collapsing or immediately after the collapse operation. It seems a
TAO-like optimization
to decrease fallback and latency is more effective.

>
> I see all this as orthogonal to synchronous vs asynchronous swap devices.=
 I
> think the latter just implies that you might want to do some readahead to=
 try to
> cover up the latency? If swap is moving towards being folio-orientated, t=
hen
> readahead also surely needs to be folio-orientated, but I think that shou=
ld be
> the only major difference.
>
> Anyway, just some thoughts!

Thank you very much for your valuable and insightful deliberations.

>
> Thanks,
> Ryan
>

Thanks
Barry

