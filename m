Return-Path: <linux-kernel+bounces-109299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB988175D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975062851EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6C085290;
	Wed, 20 Mar 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeRwTSFu"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A956A8A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959933; cv=none; b=R/1B4CPG2CNMl+1y4GgEAczifSnajmi9Q85O8Pw4ebPZD3ismvplKWhiOp44SdJx9trdJqkxgYkq9KYFLdjgi796wra2cLlCRx4H6on7af50VXk+D7pQ5PBfcLD7xUCBazcMDApKsbDQILLB7iHsAU+tQ7mI36Xri6gumyqjxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959933; c=relaxed/simple;
	bh=J/HdPUQnjGsMI7eKE08wmL9T5eh9N3pNUphWmAfIIMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI2c5Cy/AeXLx+mQegc2VZIQg791cMebD0yNYmKxoXShNRrNvu3/6UtB6d3JgpneDqR+CdAebXnPjgh/PSaTiXMqBfPpsIP8dGyh6fZWp0XyHyEfAWRGqP7Vrk9aGV5wYQnVIGB3PP46IYgZvU+0lyrLxig7uJWes8fZTf+r7fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeRwTSFu; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e0425e5aa8so60918241.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710959930; x=1711564730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9GLo3WEc0TbH91CgwMuG9NfCun8rQAOObu/qOhupcY=;
        b=SeRwTSFuOUCsX9mB38wp85WAWK90vXxjUN9fFhF3RKJXjLVJGk109awOi+AJW4YT/r
         WLcQkyeKtOmTe6iL/2D3Ypo/6LzA7v9q6Hs37wIAX4HAqZLUB+fp7bC/bpdKIaSPaxzi
         fQDtxKXMPh+W1sCQRU7VGDToVp30qRl8gc+E8VoRbm3pyQTY12J4zSJK8Wro0+d/kA69
         90AVZEMrK93Ad09GikjVhI6MLhGXqtW+RnD7l58p8dlVAjnVj1C96FZR7jaj1LqBuHxk
         WEWDCY/6pqJHi2UjAskt1q7+dWy2+SH7AoO9Z4xFyo2vJcb/2THei1eBTWxXxtrX3EJT
         2qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959930; x=1711564730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9GLo3WEc0TbH91CgwMuG9NfCun8rQAOObu/qOhupcY=;
        b=odEjpOnx6HbKCmpUffQkQ4E0a7e0OxqR0GSgPgckZVY11Z3wBAjqxTXUp/vQs2KiYL
         D3bLCQYlWlcAbo8v8RipHkhu3kMSWRqJj05KaHhactC1x6yRcTMtDuPdWlyAeq1j1/n9
         k7kbJ1jqtd2b/qPu7ERvXit1cZL/h6LIHV+qBxRPFiXvi+w4uUu60ipZD22B/ZiBGR/5
         2d5D1VxDGjXI8h1l5J75Iv0vxkekYrQoRxCgnbXXkryI7zuIJOV0uPyZVaysWFAatxad
         je2haKlD81UBXqhxxX7wZLoC6GgWt4+iN7nvirdiE0HlmNwAYL7BQBZTqoy2qbmPWi2k
         e+kA==
X-Forwarded-Encrypted: i=1; AJvYcCXISJ02zBDNN4QmZ/gf2aQnl+Y+AI5vmvGbXDYr7RXwtkt/lO7P68NJVifSipyCXoWa2qQkSZt6rm+6cLBuCPfL69m/HywqfAAiiv1s
X-Gm-Message-State: AOJu0Yxrr7qSx7f5G6suDZw7qBDGmogJafC8f0OBkUfTF0daOIkBdK3F
	J/RaCR+E/zLxmnwO/FfWYOLyaw4Iye8f11tA/c57sXKgFruaDEjp6Q+XfOK6KEFCCfjVjAb2yXY
	hebsllRiw3LNfpdhP0mq7o407A0c=
X-Google-Smtp-Source: AGHT+IEs5Eh5D+EFQ6awkQSFrKzkTsQwstEfjurELStBp0tO+tXg6nua+i5QpOBvbNrK1kEEMgXPP+O+8zdTwSv1O9E=
X-Received: by 2002:a67:eb0a:0:b0:473:18d9:caf5 with SMTP id
 a10-20020a67eb0a000000b0047318d9caf5mr16166904vso.24.1710959928887; Wed, 20
 Mar 2024 11:38:48 -0700 (PDT)
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
 <CAGsJ_4zuEFnLwM_h7DF1BN2eN3P4S0Sw=omxo90ucKpPT4ampA@mail.gmail.com> <87msqts9u1.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87msqts9u1.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Mar 2024 07:38:37 +1300
Message-ID: <CAGsJ_4wP_Zy9LZxZA-5KG13S3sQOak4LJK7rOhs3M=ETNJppNw@mail.gmail.com>
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

On Wed, Mar 20, 2024 at 7:22=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Mar 20, 2024 at 3:20=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Ryan Roberts <ryan.roberts@arm.com> writes:
> >>
> >> > On 19/03/2024 09:20, Huang, Ying wrote:
> >> >> Ryan Roberts <ryan.roberts@arm.com> writes:
> >> >>
> >> >>>>>> I agree phones are not the only platform. But Rome wasn't built=
 in a
> >> >>>>>> day. I can only get
> >> >>>>>> started on a hardware which I can easily reach and have enough =
hardware/test
> >> >>>>>> resources on it. So we may take the first step which can be app=
lied on
> >> >>>>>> a real product
> >> >>>>>> and improve its performance, and step by step, we broaden it an=
d make it
> >> >>>>>> widely useful to various areas  in which I can't reach :-)
> >> >>>>>
> >> >>>>> We must guarantee the normal swap path runs correctly and has no
> >> >>>>> performance regression when developing SWP_SYNCHRONOUS_IO optimi=
zation.
> >> >>>>> So we have to put some effort on the normal path test anyway.
> >> >>>>>
> >> >>>>>> so probably we can have a sysfs "enable" entry with default "n"=
 or
> >> >>>>>> have a maximum
> >> >>>>>> swap-in order as Ryan's suggestion [1] at the beginning,
> >> >>>>>>
> >> >>>>>> "
> >> >>>>>> So in the common case, swap-in will pull in the same size of fo=
lio as was
> >> >>>>>> swapped-out. Is that definitely the right policy for all folio =
sizes? Certainly
> >> >>>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO). =
But I'm not sure
> >> >>>>>> it makes sense for 2M THP; As the size increases the chances of=
 actually needing
> >> >>>>>> all of the folio reduces so chances are we are wasting IO. Ther=
e are similar
> >> >>>>>> arguments for CoW, where we currently copy 1 page per fault - i=
t probably makes
> >> >>>>>> sense to copy the whole folio up to a certain size.
> >> >>>>>> "
> >> >>>
> >> >>> I thought about this a bit more. No clear conclusions, but hoped t=
his might help
> >> >>> the discussion around policy:
> >> >>>
> >> >>> The decision about the size of the THP is made at first fault, wit=
h some help
> >> >>> from user space and in future we might make decisions to split bas=
ed on
> >> >>> munmap/mremap/etc hints. In an ideal world, the fact that we have =
had to swap
> >> >>> the THP out at some point in its lifetime should not impact on its=
 size. It's
> >> >>> just being moved around in the system and the reason for our origi=
nal decision
> >> >>> should still hold.
> >> >>>
> >> >>> So from that PoV, it would be good to swap-in to the same size tha=
t was
> >> >>> swapped-out.
> >> >>
> >> >> Sorry, I don't agree with this.  It's better to swap-in and swap-ou=
t in
> >> >> smallest size if the page is only accessed seldom to avoid to waste
> >> >> memory.
> >> >
> >> > If we want to optimize only for memory consumption, I'm sure there a=
re many
> >> > things we would do differently. We need to find a balance between me=
mory and
> >> > performance. The benefits of folios are well documented and the kern=
el is
> >> > heading in the direction of managing memory in variable-sized blocks=
 So I don't
> >> > think it's as simple as saying we should always swap-in the smallest=
 possible
> >> > amount of memory.
> >>
> >> It's conditional, that is,
> >>
> >> "if the page is only accessed seldom"
> >>
> >> Then, the page swapped-in will be swapped-out soon and adjacent pages =
in
> >> the same large folio will not be accessed during this period.
> >>
> >> So, I suggest to create an algorithm to decide swap-in order based on
> >> swap-readahead information automatically.  It can detect the situation
> >> above via reduced swap readahead window size.  And, if the page is
> >> accessed for quite long time, and the adjacent pages in the same large
> >> folio are accessed too, swap-readahead window will increase and large
> >> swap-in order will be used.
> >
> > The original size of do_anonymous_page() should be honored, considering=
 it
> > embodies a decision influenced by not only sysfs settings and per-vma
> > HUGEPAGE hints but also architectural characteristics, for example
> > CONT-PTE.
> >
> > The model you're proposing may offer memory-saving benefits or reduce I=
/O,
> > but it entirely disassociates the size of the swap in from the size pri=
or to the
> > swap out.
>
> Readahead isn't the only factor to determine folio order.  For example,
> we must respect "never" policy to allocate order-0 folio always.
> There's no requirements to use swap-out order in swap-in too.  Memory
> allocation has different performance character of storage reading.

Still quite unclear.

If users have only enabled 64KiB (4-ORDER) large folios in sysfs, and the
readahead algorithm requires 16KiB, what should be set as the large folio s=
ize?
Setting it to 16KiB doesn't align with users' requirements, while
setting it to 64KiB
would be wasteful according to your criteria.

>
> > Moreover, there's no guarantee that the large folio generated by
> > the readahead window is contiguous in the swap and can be added to the
> > swap cache, as we are currently dealing with folio->swap instead of
> > subpage->swap.
>
> Yes.  We can optimize only when all conditions are satisfied.  Just like
> other optimization.
>
> > Incidentally, do_anonymous_page() serves as the initial location for al=
locating
> > large folios. Given that memory conservation is a significant considera=
tion in
> > do_swap_page(), wouldn't it be even more crucial in do_anonymous_page()=
?
>
> Yes.  We should consider that too.  IIUC, that is why mTHP support is
> off by default for now.  After we find a way to solve the memory usage
> issue.  We may make default "on".

It's challenging to establish a universal solution because various systems
exhibit diverse hardware characteristics, and VMAs may require different
alignments. The current sysfs and per-vma hints allow users the opportunity
o customize settings according to their specific requirements.

>
> > A large folio, by its nature, represents a high-quality resource that h=
as the
> > potential to leverage hardware characteristics for the benefit of the
> > entire system.
>
> But not at the cost of memory wastage.
>
> > Conversely, I don't believe that a randomly determined size dictated by=
 the
> > readahead window possesses the same advantageous qualities.
>
> There's a readahead algorithm which is not pure random.
>
> > SWP_SYNCHRONOUS_IO devices are not reliant on readahead whatsoever,
> > their needs should also be respected.
>
> I understand that there are special requirements for SWP_SYNCHRONOUS_IO
> devices.  I just suggest to work on general code before specific
> optimization.

I disagree with your definition of "special" and "general". According
to your logic,
non-SWP_SYNCHRONOUS_IO devices could also be classified as "special".
Furthermore, the number of systems running SWP_SYNCHRONOUS_IO is
significantly greater than those running non-SWP_SYNCHRONOUS_IO,
contradicting your assertion.

SWP_SYNCHRONOUS_IO devices have a minor chance of being involved
in readahead. However, in OPPO's code, which hasn't been sent in the
LKML yet, we use the exact same size as do_anonymous_page for readahead.
Without a clear description of how you want the new readahead
algorithm to balance memory waste and users' hints from sysfs and
per-vma flags, it appears to be an ambiguous area to address.

Please provide a clear description of how you would like the new readahead
algorithm to function. I believe this clarity will facilitate others
in attempting to
implement it.

>
> >> > You also said we should swap *out* in smallest size possible. Have I
> >> > misunderstood you? I thought the case for swapping-out a whole folio=
 without
> >> > splitting was well established and non-controversial?
> >>
> >> That is conditional too.
> >>
> >> >>
> >> >>> But we only kind-of keep that information around, via the swap
> >> >>> entry contiguity and alignment. With that scheme it is possible th=
at multiple
> >> >>> virtually adjacent but not physically contiguous folios get swappe=
d-out to
> >> >>> adjacent swap slot ranges and then they would be swapped-in to a s=
ingle, larger
> >> >>> folio. This is not ideal, and I think it would be valuable to try =
to maintain
> >> >>> the original folio size information with the swap slot. One way to=
 do this would
> >> >>> be to store the original order for which the cluster was allocated=
 in the
> >> >>> cluster. Then we at least know that a given swap slot is either fo=
r a folio of
> >> >>> that order or an order-0 folio (due to cluster exhaustion/scanning=
). Can we
> >> >>> steal a bit from swap_map to determine which case it is? Or are th=
ere better
> >> >>> approaches?
> >> >>
> >> >> [snip]
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

