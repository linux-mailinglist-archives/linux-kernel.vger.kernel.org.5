Return-Path: <linux-kernel+bounces-109656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EED1881C17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6951F22099
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6143B36B01;
	Thu, 21 Mar 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j27/QpJb"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3EA2E842
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710997964; cv=none; b=I95HQXdRPJT3HLF1ffwMwusAvP1KwTXrPrUrG9OjQ28pdYW5BYGRjSn7McYAn58xe5f1HkFnwP4h24Mw/IAT03NVrlyExxMQ8scqe2JVly2Nf2anmybcuqveh2KPWYSkt5rHJkEjhkaoTv5btC8D7WWmy798MBe7O8uYJUq856E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710997964; c=relaxed/simple;
	bh=3Qv/RuwGcSHVOX6A0pNTDyTSgt0DYin9Ia5I8pIG8pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkgWyTiCikyYFkXCbuOvbywG5MVuR+IhtMmexvH98ws70Zv6RDepvz3lfU75alJKtdXbbYYXhQXSVVCvgS+l689csvPOfem/J+bNGrXYVfdmSRkGaDa694ByLEu+cKu56z4L0dH8yllF44O/5O4dgHS8Fkr5VLdJ32eO+KmQqZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j27/QpJb; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4d44beade3cso279305e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710997961; x=1711602761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u5E1qw0QMta/rSbzTb8FCwnkFevgCil9PPg5QPkjUUg=;
        b=j27/QpJbvJhzKVJwR6H7mqzrEZrcDHILQaK6JBxsoErmb12ZKBON4aE86G9LMw4SIH
         a01R8H2ddZHhZK9lKHNAHBoLUmm6DBm7kSP1JuITb5xUEPT0ogxZQA2W+J/FihGfTLSm
         oFO6t58kqCf3RF2z5+XcObzu8B8uO27TxEPV5JsXGhnhKjBy1du1TC/oPxfA1+8VimHl
         M0AYJ0JDhFNCkfSC3vEkvgQus9tRTOnw+9cjUr/dqAQQwsS+LZ2o9V5Pvd1+xsWEYB0J
         h7qRD3NXZcfblXycpQ+/ZGmETgtg+ByNLBKyUSxW/EO1PW+JUSia0+BaFGJjhn9Pc4RL
         05Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710997961; x=1711602761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5E1qw0QMta/rSbzTb8FCwnkFevgCil9PPg5QPkjUUg=;
        b=nB0/pHaDD/+uRgpHoV6AZ0UZA+6VpCGVt0YDyh67bRSfUpMglyuO8OzZ91S7RHYEI6
         UZJLrfTtP5T2kHQdsPB/BCNURDLIoh6zc6XJOlXnT3yiZHmx479cyUQT6S/W8ZrRHgTn
         sDdlBhH7VQ8dP+1McvdvefFQ5/xb8NuINHKSWQC0UI9GuWVAR1ZoZHhi5bh2LaCZGjIC
         B1HxI6H9TNBUlO+2eZV5PGYE9+8Rj3+uILpM+rTHhkg3+Zseqmie6YUj97u6cSKMyihZ
         U1ytNJTn85vJ94FKgImsMGM+pCv9svCnDM8AOy6HQTiMSSV66LfHs4xH6pSrda6cj0kv
         ANGA==
X-Forwarded-Encrypted: i=1; AJvYcCVMV+w0bCckGHjBtLvEyK+ANiLIz6Zp54UN5OOvxAfbcOFYISFeQ5+d/dozhjb/1Q730vj+1HUG/G5YqvMtnuZqgu9dchC4RNrUqoos
X-Gm-Message-State: AOJu0Ywcn/RoVGb9BY8n3hr47bcS83gbuhW6Xxfs74L09Lmcz8y0A1VI
	tj4KXCbAZMFmkG0++hA4DrMyQWRI9DCTZ/067eo6vKNRnXKIYakRgmql4RHwGGIL3kBfLS34wUR
	cGsYN6PBXEKC0ZYPzc3RrWABvBp0=
X-Google-Smtp-Source: AGHT+IF+5Nveh523y3YiZQa38pUO8yVTBVCEFyzyqKUfHRCpzAxkK6fwK5wXPO9KAvW4JlYNChkmRUfKaB15sthpWOQ=
X-Received: by 2002:a05:6122:1d4d:b0:4c9:2540:8520 with SMTP id
 gd13-20020a0561221d4d00b004c925408520mr18997880vkb.1.1710997960940; Wed, 20
 Mar 2024 22:12:40 -0700 (PDT)
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
 <CAGsJ_4zuEFnLwM_h7DF1BN2eN3P4S0Sw=omxo90ucKpPT4ampA@mail.gmail.com>
 <87msqts9u1.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4wP_Zy9LZxZA-5KG13S3sQOak4LJK7rOhs3M=ETNJppNw@mail.gmail.com>
 <87a5msrz5e.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5msrz5e.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 21 Mar 2024 18:12:29 +1300
Message-ID: <CAGsJ_4xfwB6kWgfthikMaqj1zQS1cB=MNKBNxHhMfHt_-cdF8Q@mail.gmail.com>
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

On Thu, Mar 21, 2024 at 5:25=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Mar 20, 2024 at 7:22=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Wed, Mar 20, 2024 at 3:20=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Ryan Roberts <ryan.roberts@arm.com> writes:
> >> >>
> >> >> > On 19/03/2024 09:20, Huang, Ying wrote:
> >> >> >> Ryan Roberts <ryan.roberts@arm.com> writes:
> >> >> >>
> >> >> >>>>>> I agree phones are not the only platform. But Rome wasn't bu=
ilt in a
> >> >> >>>>>> day. I can only get
> >> >> >>>>>> started on a hardware which I can easily reach and have enou=
gh hardware/test
> >> >> >>>>>> resources on it. So we may take the first step which can be =
applied on
> >> >> >>>>>> a real product
> >> >> >>>>>> and improve its performance, and step by step, we broaden it=
 and make it
> >> >> >>>>>> widely useful to various areas  in which I can't reach :-)
> >> >> >>>>>
> >> >> >>>>> We must guarantee the normal swap path runs correctly and has=
 no
> >> >> >>>>> performance regression when developing SWP_SYNCHRONOUS_IO opt=
imization.
> >> >> >>>>> So we have to put some effort on the normal path test anyway.
> >> >> >>>>>
> >> >> >>>>>> so probably we can have a sysfs "enable" entry with default =
"n" or
> >> >> >>>>>> have a maximum
> >> >> >>>>>> swap-in order as Ryan's suggestion [1] at the beginning,
> >> >> >>>>>>
> >> >> >>>>>> "
> >> >> >>>>>> So in the common case, swap-in will pull in the same size of=
 folio as was
> >> >> >>>>>> swapped-out. Is that definitely the right policy for all fol=
io sizes? Certainly
> >> >> >>>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO=
). But I'm not sure
> >> >> >>>>>> it makes sense for 2M THP; As the size increases the chances=
 of actually needing
> >> >> >>>>>> all of the folio reduces so chances are we are wasting IO. T=
here are similar
> >> >> >>>>>> arguments for CoW, where we currently copy 1 page per fault =
- it probably makes
> >> >> >>>>>> sense to copy the whole folio up to a certain size.
> >> >> >>>>>> "
> >> >> >>>
> >> >> >>> I thought about this a bit more. No clear conclusions, but hope=
d this might help
> >> >> >>> the discussion around policy:
> >> >> >>>
> >> >> >>> The decision about the size of the THP is made at first fault, =
with some help
> >> >> >>> from user space and in future we might make decisions to split =
based on
> >> >> >>> munmap/mremap/etc hints. In an ideal world, the fact that we ha=
ve had to swap
> >> >> >>> the THP out at some point in its lifetime should not impact on =
its size. It's
> >> >> >>> just being moved around in the system and the reason for our or=
iginal decision
> >> >> >>> should still hold.
> >> >> >>>
> >> >> >>> So from that PoV, it would be good to swap-in to the same size =
that was
> >> >> >>> swapped-out.
> >> >> >>
> >> >> >> Sorry, I don't agree with this.  It's better to swap-in and swap=
-out in
> >> >> >> smallest size if the page is only accessed seldom to avoid to wa=
ste
> >> >> >> memory.
> >> >> >
> >> >> > If we want to optimize only for memory consumption, I'm sure ther=
e are many
> >> >> > things we would do differently. We need to find a balance between=
 memory and
> >> >> > performance. The benefits of folios are well documented and the k=
ernel is
> >> >> > heading in the direction of managing memory in variable-sized blo=
cks. So I don't
> >> >> > think it's as simple as saying we should always swap-in the small=
est possible
> >> >> > amount of memory.
> >> >>
> >> >> It's conditional, that is,
> >> >>
> >> >> "if the page is only accessed seldom"
> >> >>
> >> >> Then, the page swapped-in will be swapped-out soon and adjacent pag=
es in
> >> >> the same large folio will not be accessed during this period.
> >> >>
> >> >> So, I suggest to create an algorithm to decide swap-in order based =
on
> >> >> swap-readahead information automatically.  It can detect the situat=
ion
> >> >> above via reduced swap readahead window size.  And, if the page is
> >> >> accessed for quite long time, and the adjacent pages in the same la=
rge
> >> >> folio are accessed too, swap-readahead window will increase and lar=
ge
> >> >> swap-in order will be used.
> >> >
> >> > The original size of do_anonymous_page() should be honored, consider=
ing it
> >> > embodies a decision influenced by not only sysfs settings and per-vm=
a
> >> > HUGEPAGE hints but also architectural characteristics, for example
> >> > CONT-PTE.
> >> >
> >> > The model you're proposing may offer memory-saving benefits or reduc=
e I/O,
> >> > but it entirely disassociates the size of the swap in from the size =
prior to the
> >> > swap out.
> >>
> >> Readahead isn't the only factor to determine folio order.  For example=
,
> >> we must respect "never" policy to allocate order-0 folio always.
> >> There's no requirements to use swap-out order in swap-in too.  Memory
> >> allocation has different performance character of storage reading.
> >
> > Still quite unclear.
> >
> > If users have only enabled 64KiB (4-ORDER) large folios in sysfs, and t=
he
> > readahead algorithm requires 16KiB, what should be set as the large fol=
io size?
> > Setting it to 16KiB doesn't align with users' requirements, while
> > setting it to 64KiB
> > would be wasteful according to your criteria.
>
> IIUC, enabling 64KB means you can use 64KB mTHP if appropriate, doesn't
> mean that you must use 64KB mTHP.  If so, we should use 16KB mTHP in
> that situation.

A specific large folio size inherently denotes a high-quality
resource. For example,
a 64KiB folio necessitates only one TLB on ARM64, just as a 2MB large folio
accommodates only one TLB. I am skeptical whether a size determined by
readahead offers any tangible advantages over simply having small folios.

>
> >> > Moreover, there's no guarantee that the large folio generated by
> >> > the readahead window is contiguous in the swap and can be added to t=
he
> >> > swap cache, as we are currently dealing with folio->swap instead of
> >> > subpage->swap.
> >>
> >> Yes.  We can optimize only when all conditions are satisfied.  Just li=
ke
> >> other optimization.
> >>
> >> > Incidentally, do_anonymous_page() serves as the initial location for=
 allocating
> >> > large folios. Given that memory conservation is a significant consid=
eration in
> >> > do_swap_page(), wouldn't it be even more crucial in do_anonymous_pag=
e()?
> >>
> >> Yes.  We should consider that too.  IIUC, that is why mTHP support is
> >> off by default for now.  After we find a way to solve the memory usage
> >> issue.  We may make default "on".
> >
> > It's challenging to establish a universal solution because various syst=
ems
> > exhibit diverse hardware characteristics, and VMAs may require differen=
t
> > alignments. The current sysfs and per-vma hints allow users the opportu=
nity
> > o customize settings according to their specific requirements.
>
> IIUC, Linux kernel is trying to provide a reasonable default behavior in
> all situations.  We are trying to optimize default behavior in the first
> place, only introduce customization if we fail to do that.  I don't
> think that it's a good idea to introduce too much customization if we
> haven't tried to optimize the default behavior.

I've never been opposed to the readahead case, but I feel it's a second ste=
p.

My point is to begin with the simplest and most practical approaches
that can generate
genuine value and contribution. The SWP_SYNCHRONOUS_IO case has been
implemented on millions of OPPO's phones and has demonstrated product succe=
ss.

>
> >>
> >> > A large folio, by its nature, represents a high-quality resource tha=
t has the
> >> > potential to leverage hardware characteristics for the benefit of th=
e
> >> > entire system.
> >>
> >> But not at the cost of memory wastage.
> >>
> >> > Conversely, I don't believe that a randomly determined size dictated=
 by the
> >> > readahead window possesses the same advantageous qualities.
> >>
> >> There's a readahead algorithm which is not pure random.
> >>
> >> > SWP_SYNCHRONOUS_IO devices are not reliant on readahead whatsoever,
> >> > their needs should also be respected.
> >>
> >> I understand that there are special requirements for SWP_SYNCHRONOUS_I=
O
> >> devices.  I just suggest to work on general code before specific
> >> optimization.
> >
> > I disagree with your definition of "special" and "general". According
> > to your logic,
> > non-SWP_SYNCHRONOUS_IO devices could also be classified as "special".
>
> SWP_SYNCHRONOUS_IO devices also use general code path.  They just use
> some special optimization in some special situation (__swap_count(entry)
> =3D=3D 1).  Optimization in general path benefits everyone.
>
> > Furthermore, the number of systems running SWP_SYNCHRONOUS_IO is
> > significantly greater than those running non-SWP_SYNCHRONOUS_IO,
> > contradicting your assertion.
> >
> > SWP_SYNCHRONOUS_IO devices have a minor chance of being involved
> > in readahead.
>
> Then it loses an opportunity to determine the appropriate folio order.
> We can consider how to balance between the overhead and benefit of
> readahead.  IIUC, compared with original SWP_SYNCHRONOUS_IO swap-in,
> mTHP is a kind of readahead too.
>
> BTW, because we have added more and more swap cache related operations
> (swapcache_prepare(), clear_shadow_from_swap_cache(), swapcache_clear(),
> etc.) in SWP_SYNCHRONOUS_IO code path, I suspect whether the benefit of
> SWP_SYNCHRONOUS_IO is still large enough.  We may need to re-evaluate
> it.

Obviously SWP_SYNCHRONOUS_IO is still quite valuable as Kairui has the data
in his commit  13ddaf26be324a ("mm/swap: fix race when skipping swapcache")

"Performance overhead is minimal, microbenchmark swapin 10G from 32G zram:
Before: 10934698 us
After: 11157121 us
Cached: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag) "

>
> > However, in OPPO's code, which hasn't been sent in the
> > LKML yet, we use the exact same size as do_anonymous_page for readahead=
.
> > Without a clear description of how you want the new readahead
> > algorithm to balance memory waste and users' hints from sysfs and
> > per-vma flags, it appears to be an ambiguous area to address.
> >
> > Please provide a clear description of how you would like the new readah=
ead
> > algorithm to function. I believe this clarity will facilitate others
> > in attempting to
> > implement it.
>
> For example, if __swapin_nr_pages() > 4, we can try to allocate an
> order-2 mTHP if other conditions are satisfied.

There is no evidence suggesting that an order-2 or any other orders
determined by readahead are superior to having four small folios.

>
> >>
> >> >> > You also said we should swap *out* in smallest size possible. Hav=
e I
> >> >> > misunderstood you? I thought the case for swapping-out a whole fo=
lio without
> >> >> > splitting was well established and non-controversial?
> >> >>
> >> >> That is conditional too.
> >> >>
> >> >> >>
> >> >> >>> But we only kind-of keep that information around, via the swap
> >> >> >>> entry contiguity and alignment. With that scheme it is possible=
 that multiple
> >> >> >>> virtually adjacent but not physically contiguous folios get swa=
pped-out to
> >> >> >>> adjacent swap slot ranges and then they would be swapped-in to =
a single, larger
> >> >> >>> folio. This is not ideal, and I think it would be valuable to t=
ry to maintain
> >> >> >>> the original folio size information with the swap slot. One way=
 to do this would
> >> >> >>> be to store the original order for which the cluster was alloca=
ted in the
> >> >> >>> cluster. Then we at least know that a given swap slot is either=
 for a folio of
> >> >> >>> that order or an order-0 folio (due to cluster exhaustion/scann=
ing). Can we
> >> >> >>> steal a bit from swap_map to determine which case it is? Or are=
 there better
> >> >> >>> approaches?
> >> >> >>
> >> >> >> [snip]
> >>
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

