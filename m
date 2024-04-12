Return-Path: <linux-kernel+bounces-142409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85C8A2B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A1C1F216E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3347502B1;
	Fri, 12 Apr 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwbBFUas"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C07F5027F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712914066; cv=none; b=G/lowbyJ0zcjmetpa4eg5psXQwNQvdWDoOOXvxPLVxJIgSvwBhbhgzTKDgJerNfYgdQsGa8RkqW03tMLRE/zuoESAEReL9blMfqOD4sIiS8SOptZwVULbFOmAusbIVypCaZyyOBBXcOMnWLZKZ8Rsycx0ZOEimo22xZ0HLmOEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712914066; c=relaxed/simple;
	bh=hc+r50+4bqwYfxs8xBSkd/X+duwxG2yXgPjT4gey95g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4m0oOljrlDK3vvVe5vmCra5Q2Uq1pwWzV2gfrWj75KsZDakZiV1dms2a77ZwKZ4T4t6Ek+h3z7+BQfYjbe/2R10YY6k+IAtRYoMbOnvrlr4O/F1tYFOGB3z27F9mSsQJxd5/O3gLWuSjK1m9kNWPMT3wocBTvH3n3wP1QeK3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwbBFUas; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4dac5a3fbeaso282521e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712914063; x=1713518863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UagXId7cRif8x61mxRpgvyeVRGMhUfmv6V6k9eKHP1g=;
        b=LwbBFUasJsI8rWOkpoOukknzdjv909tXtyqo68fMlqwmESz35xIwhDvLGTuQhOxtRI
         CFzfyjUPywYQeR78tT8N+lln7NN51ABjGlaK66OlgMjWUohEv6eqWCIi1DiSF83+FRm+
         0uMgu3KEkIGZmDLGE0lB9rmkyZgWf11LgnGXQMAGBnEqJno4wOwYJACHToP8ICsBdY++
         kVToLpJS+oNZJwNRgS+/WArc6Itk5wOdY6yDzL0MtYPmdQRPBsfGCHnc8HU4DCC9v4ma
         d+pYnZxHOyyLjJ0a9qXRncVylgIwM/4KfnW0ZqPau73xbGcSWNh9E4Do9JoLQovhHhbl
         6yUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712914063; x=1713518863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UagXId7cRif8x61mxRpgvyeVRGMhUfmv6V6k9eKHP1g=;
        b=oGL7/5zIvOfc849wRUkGvkR0/EjDRpY3SL4TKSKsd2ut+DBCgjbnMXUouoRChMzIpG
         5EYZKwmdc7Nnf10VeHCRpCLXid+G9T2297N54Q8v5UsynuhaVMftVFvG7xKNco+E5mXw
         meoUqLnCRU0dQ2sIaGDvjkBIQ8y4Op9Sm4+dvEOIfQVTH0OJ1GO2CVoklmb5zU5NIgmY
         cQn6jAXkXBaHGd2ZITedE5k4FDowOfaiPFNniSzNPer7i9cf4C5in4twCFdvEHmeoWKZ
         ENOV2iJrESjsO0xcl+tYcD8ai91JtElDomyPcMInc042deGjUBPH1YV7dNFeiH+6g+Kt
         DBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYZkNDPMsKJKHTj31b039kfBsa0DCXAyjln+cm1djStGAXix6Npz8QXRkv3uK2TowK+ZsA+93C6tLyFdzFIB3ConVxhOiCcyEHfYmn
X-Gm-Message-State: AOJu0YxXACAWx/B6mCvzcQ4HWDc295wVP8p+LZwEftgOoRETfl8KrObh
	tZSH+3l6BFAZBRpwzJsBM9tXq9UOBZEd6d57yMvLU0FoFgHbVXGCoGhc8mpThprfNfoabanRpi5
	h1oEHVI/RCPhzUy2IyT5FDWxnGNs=
X-Google-Smtp-Source: AGHT+IF7h60JamTAFY/4dM0uh2ZgmJrt1mlyvp9s00aVgRzR7HB/GAAhj130tz7KYoMU7HFUIl5TGRKEPl0P6/htdsc=
X-Received: by 2002:a05:6122:99e:b0:4db:223b:1c0a with SMTP id
 g30-20020a056122099e00b004db223b1c0amr2053524vkd.11.1712914063358; Fri, 12
 Apr 2024 02:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405102704.77559-1-21cnbao@gmail.com> <20240405102704.77559-2-21cnbao@gmail.com>
 <7cf0a47b-0347-4e81-956f-34bef4ef794a@arm.com> <CAGsJ_4zWiYguj1y6Q7Ls41yFkuL5=-ii7pY=rYHg1AZeXe4uTQ@mail.gmail.com>
 <cc9a3d6b-4979-4635-a51a-2edf07853ec6@arm.com>
In-Reply-To: <cc9a3d6b-4979-4635-a51a-2edf07853ec6@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Apr 2024 21:27:31 +1200
Message-ID: <CAGsJ_4xFxXkSgqmNgpKgxdpkrhcdhwEM8BP+CTbxsAprMxLiYA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: add per-order mTHP anon_alloc and
 anon_alloc_fallback counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cerasuolodomenico@gmail.com, chrisl@kernel.org, kasong@tencent.com, 
	peterx@redhat.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, yosryahmed@google.com, yuzhao@google.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 9:16=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 11/04/2024 23:40, Barry Song wrote:
> > On Fri, Apr 12, 2024 at 4:38=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 05/04/2024 11:27, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> Profiling a system blindly with mTHP has become challenging due to th=
e
> >>> lack of visibility into its operations. Presenting the success rate o=
f
> >>> mTHP allocations appears to be pressing need.
> >>>
> >>> Recently, I've been experiencing significant difficulty debugging
> >>> performance improvements and regressions without these figures.
> >>> It's crucial for us to understand the true effectiveness of mTHP in
> >>> real-world scenarios, especially in systems with fragmented memory.
> >>>
> >>> This patch sets up the framework for per-order mTHP counters, startin=
g
> >>> with the introduction of anon_alloc and anon_alloc_fallback counters.
> >>> Incorporating additional counters should now be straightforward as we=
ll.
> >>>
> >>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>> ---
> >>>  include/linux/huge_mm.h | 19 ++++++++++++++++
> >>>  mm/huge_memory.c        | 48 +++++++++++++++++++++++++++++++++++++++=
++
> >>>  mm/memory.c             |  2 ++
> >>>  3 files changed, 69 insertions(+)
> >>>
> >>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>> index e896ca4760f6..c5d33017a4dd 100644
> >>> --- a/include/linux/huge_mm.h
> >>> +++ b/include/linux/huge_mm.h
> >>> @@ -264,6 +264,25 @@ unsigned long thp_vma_allowable_orders(struct vm=
_area_struct *vma,
> >>>                                         enforce_sysfs, orders);
> >>>  }
> >>>
> >>> +enum mthp_stat_item {
> >>> +     MTHP_STAT_ANON_ALLOC,
> >>> +     MTHP_STAT_ANON_ALLOC_FALLBACK,
> >>> +     __MTHP_STAT_COUNT
> >>> +};
> >>> +
> >>> +struct mthp_stat {
> >>> +     unsigned long stats[PMD_ORDER + 1][__MTHP_STAT_COUNT];
> >>
> >> I saw a fix for this allocation dynamically due to powerpc PMD_ORDER n=
ot being
> >> constant. I wonder if ilog2(MAX_PTRS_PER_PTE) would help here?
> >>
> >
> > It's a possibility. However, since we've passed all the build tests
> > using dynamic
> > allocation, it might not be worth the effort to attempt static
> > allocation again. Who
> > knows what will happen next :-)
>
> If the dynamic version is clear and obvious then fair enough. I tried doi=
ng
> something similar for the swap-out series but it turned out a mess, so en=
ded up
> falling back to static allocation which was much easier to understand.

mthp_stats doesn't need to be dynamically released, as long as hugepage_ini=
t()
succeeds, we need it forever even if sysfs is released or disabled.

>
> >
> >>> +};
> >>> +
> >>> +DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
> >>> +
> >>> +static inline void count_mthp_stat(int order, enum mthp_stat_item it=
em)
> >>
> >> I thought we were going to call this always counting up type of stat a=
nd event?
> >> "count_mthp_event"? But I'm happy with it as is, personally.
> >>
> >>> +{
> >>> +     if (unlikely(order > PMD_ORDER))
> >>> +             return;
> >>
> >> I'm wondering if it also makes sense to ignore order =3D=3D 0? Althoug=
h I guess if
> >> called for order-0 its safe since the storage exists and sum_mthp_stat=
() is
> >> never be called for 0. Ignore this comment :)
> >
> > Agreed. I'd like to change it to ignore oder 0;
> >
> >>
> >>> +     this_cpu_inc(mthp_stats.stats[order][item]);
> >>> +}
> >>> +
> >>>  #define transparent_hugepage_use_zero_page()                        =
 \
> >>>       (transparent_hugepage_flags &                                  =
 \
> >>>        (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index 9d4b2fbf6872..5b875f0fc923 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -526,6 +526,46 @@ static const struct kobj_type thpsize_ktype =3D =
{
> >>>       .sysfs_ops =3D &kobj_sysfs_ops,
> >>>  };
> >>>
> >>> +DEFINE_PER_CPU(struct mthp_stat, mthp_stats) =3D {{{0}}};
> >>> +
> >>> +static unsigned long sum_mthp_stat(int order, enum mthp_stat_item it=
em)
> >>> +{
> >>> +     unsigned long sum =3D 0;
> >>> +     int cpu;
> >>> +
> >>> +     for_each_online_cpu(cpu) {
> >>
> >> What happens if a cpu that was online and collected a bunch of stats g=
ets
> >> offlined? The user will see stats get smaller?
> >>
> >> Perhaps this should be for_each_possible_cpu()? Although I'm not sure =
what
> >> happens to percpu data when a cpu goes offline? Is the data preserved?=
 Or wiped,
> >> or unmapped? dunno. Might we need to rescue stats into a global counte=
r at
> >> offline-time?
> >
> > Good catch. I see /proc/vmstat is always using the  for_each_online_cpu=
() but it
> > doesn't have the issue, but mTHP counters do have the problem.
> >
> > * step 1: cat  the current thp_swpout value before running a test
> > program which does
> > swpout;
> >
> > / # cat /proc/vmstat | grep thp_swpout
> > thp_swpout 0
> > / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon=
_swpout
> > 0
> >
> > * step 2: run the test program on cpu2;
> >
> > / # taskset -c 2 /home/barry/develop/linux/swpcache-2m
> >
> > * step 3: cat the current thp_swpout value after running a test
> > program which does
> > swpout;
> >
> > / # cat /proc/vmstat | grep thp_swpout
> > thp_swpout 98
> > / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon=
_swpout
> > 98
> >
> > *step 4: offline cpu2 and read thp_swpout;
> >
> > / # echo 0 > /sys/devices/system/cpu/cpu2/online
> > [  339.058661] psci: CPU2 killed (polled 0 ms)
> >
> > / # cat /proc/vmstat | grep thp_swpout
> > thp_swpout 98
> > / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon=
_swpout
> > 0
> >
> > *step 5: online cpu2 and read thp_swpout
> >
> > / # echo 1 > /sys/devices/system/cpu/cpu2/online
> > [  791.642058] CPU2: Booted secondary processor 0x0000000002 [0x000f051=
0]
> >
> > / # cat /proc/vmstat | grep thp_swpout
> > thp_swpout 98
> > / # cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/stats/anon=
_swpout
> > 98
> >
> >
> >
> > As you can see, in step 4, /proc/vmstat is all good but mTHP counters b=
ecome
> > zero.
> >
> > The reason is /proc/vmstat will fold the offline cpu to an online cpu
> > but mthp counters lack
> > it:
> >
> > /*
> >  * Fold the foreign cpu events into our own.
> >  *
> >  * This is adding to the events on one processor
> >  * but keeps the global counts constant.
> >  */
> > void vm_events_fold_cpu(int cpu)
> > {
> >         struct vm_event_state *fold_state =3D &per_cpu(vm_event_states,=
 cpu);
> >         int i;
> >
> >         for (i =3D 0; i < NR_VM_EVENT_ITEMS; i++) {
> >                 count_vm_events(i, fold_state->event[i]);
> >                 fold_state->event[i] =3D 0;
> >         }
> > }
> >
> > static int page_alloc_cpu_dead(unsigned int cpu)
> > {
> >         ...
> >         /*
> >          * Spill the event counters of the dead processor
> >          * into the current processors event counters.
> >          * This artificially elevates the count of the current
> >          * processor.
> >          */
> >         vm_events_fold_cpu(cpu);
> >         ...
> >
> >         return 0;
> > }
> >
> > So I will do the same thing for mTHP counters - fold offline cpu
> > counters to online one.
>
> That all looks like a complete mess - better avoided if possible! A quick=
 search
> for "for_each_possible_cpu" shows loads of places where code is iterating=
 over
> all *possible* cpus and grabbing its per-cpu data. So the data definitely
> remains accessible when the cpu is offline. Looks like it doesn't get wip=
ed either.
>
> So can't you just change your sum function to iterate over all possible c=
pus?().

I don't find why not. but i sent a v5[1] similar to  vm_events_fold_cpu.
i can move to for_each_possible_cpu() in v6. if it is a better approach,
i can even further refine that for vmstat.

[1] https://lore.kernel.org/linux-mm/20240412073740.294272-2-21cnbao@gmail.=
com/

>
> >
> >>
> >>> +             struct mthp_stat *this =3D &per_cpu(mthp_stats, cpu);
> >>> +
> >>> +             sum +=3D this->stats[order][item];
> >>> +     }
> >>> +
> >>> +     return sum;
> >>> +}
> >>> +
> >>> +#define DEFINE_MTHP_STAT_ATTR(_name, _index)                        =
         \
> >>> +static ssize_t _name##_show(struct kobject *kobj,                   =
 \
> >>> +                     struct kobj_attribute *attr, char *buf)        =
 \
> >>> +{                                                                   =
 \
> >>> +     int order =3D to_thpsize(kobj)->order;                         =
   \
> >>> +                                                                    =
 \
> >>> +     return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index)); =
 \
> >>> +}                                                                   =
 \
> >>> +static struct kobj_attribute _name##_attr =3D __ATTR_RO(_name)
> >>
> >> Very nice!
> >
> > Right. I got duplicated copy-paste and bad small in code so I wrote thi=
s macro.
> >
> >>
> >>> +
> >>> +DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
> >>> +DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALL=
BACK);
> >>> +
> >>> +static struct attribute *stats_attrs[] =3D {
> >>> +     &anon_alloc_attr.attr,
> >>> +     &anon_alloc_fallback_attr.attr,
> >>> +     NULL,
> >>> +};
> >>> +
> >>> +static struct attribute_group stats_attr_group =3D {
> >>> +     .name =3D "stats",
> >>> +     .attrs =3D stats_attrs,
> >>> +};
> >>> +
> >>>  static struct thpsize *thpsize_create(int order, struct kobject *par=
ent)
> >>>  {
> >>>       unsigned long size =3D (PAGE_SIZE << order) / SZ_1K;
> >>> @@ -549,6 +589,12 @@ static struct thpsize *thpsize_create(int order,=
 struct kobject *parent)
> >>>               return ERR_PTR(ret);
> >>>       }
> >>>
> >>> +     ret =3D sysfs_create_group(&thpsize->kobj, &stats_attr_group);
> >>> +     if (ret) {
> >>> +             kobject_put(&thpsize->kobj);
> >>> +             return ERR_PTR(ret);
> >>> +     }
> >>> +
> >>>       thpsize->order =3D order;
> >>>       return thpsize;
> >>>  }
> >>> @@ -1050,8 +1096,10 @@ vm_fault_t do_huge_pmd_anonymous_page(struct v=
m_fault *vmf)
> >>>       folio =3D vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, tru=
e);
> >>>       if (unlikely(!folio)) {
> >>>               count_vm_event(THP_FAULT_FALLBACK);
> >>> +             count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC_F=
ALLBACK);
> >>
> >> I think we should aim for the PMD-oder MTHP_STAT_ANON_ALLOC and
> >> MTHP_STAT_ANON_ALLOC_FALLBACK to match THP_FAULT_ALLOC and THP_FAULT_F=
ALLBACK.
> >> Its not currently setup this way...
> >
> > right. I also realized this and asked for your comments on this in anot=
her
> > thread.
>
> Ahh sorry - must have missed that.
>
> >
> >>
> >>
> >>>               return VM_FAULT_FALLBACK;
> >>>       }
> >>> +     count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC);
> >>>       return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
> >>>  }
> >>>
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 649e3ed94487..1723c8ddf9cb 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -4374,8 +4374,10 @@ static struct folio *alloc_anon_folio(struct v=
m_fault *vmf)
> >>>                       }
> >>>                       folio_throttle_swaprate(folio, gfp);
> >>>                       clear_huge_page(&folio->page, vmf->address, 1 <=
< order);
> >>> +                     count_mthp_stat(order, MTHP_STAT_ANON_ALLOC);
> >>>                       return folio;
> >>>               }
> >>> +             count_mthp_stat(order, MTHP_STAT_ANON_ALLOC_FALLBACK);
> >>
> >> ...And we should follow the usage same pattern for the smaller mTHP he=
re too.
> >> Which means MTHP_STAT_ANON_ALLOC_FALLBACK should be after the next: la=
bel. We
> >
> > The only difference is the case
> >
> > if (mem_cgroup_charge(folio, vma->vm_mm, gfp))
> >       goto next;
> >
> > but vmstat is counting this as fallback so i feel good to move after ne=
xt,
> >
> >         if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
> >                 folio_put(folio);
> >                 count_vm_event(THP_FAULT_FALLBACK);
> >                 count_vm_event(THP_FAULT_FALLBACK_CHARGE);
> >                 return VM_FAULT_FALLBACK;
> >         }
> >
> >> could introduce a MTHP_STAT_ANON_ALLOC_FALLBACK_CHARGE which would onl=
y trigger
> >> on a fallback due to charge failure, just like THP_FAULT_FALLBACK_CHAR=
GE?
> >
> > it is fine to add this THP_FAULT_FALLBACK_CHARGE though it is not that
> > useful for profiling buddy fragmentation.
>
> Well I thought you were interested in isolating fallback due to fragmenta=
tion
> only. You would get that with (FAULT_FALLBACK - FAULT_FALLBACK_CHARGE)? B=
ut if
> you think the latter will be relatively small/unimportant for now, and th=
erefore
> FAULT_FALLBACK will give good enough approximation on its own, then I'm h=
appy
> not to add FAULT_FALLBACK_CHARGE for now.

in v5, i actually added FAULT_FALLBACK_CHARGE. Please take a look at v5 :-)

>
> >
> >>
> >>>  next:
> >>>               order =3D next_order(&orders, order);
> >>>       }
> >>
> >
> > Thanks
> > Barry
>

