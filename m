Return-Path: <linux-kernel+bounces-142499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611228A2C55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170F92819D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A953E16;
	Fri, 12 Apr 2024 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anq5eotS"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B252F92
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917795; cv=none; b=ZxJKN7BgxcIyKPM/8Xoc9w8FGE0TmlobAA/Q1KLw+QV8v5VXX7vaOMgoD4VZHc0VzwlhB0d96iYTWYriSRgIOucXRJ3UHqGie27rR8n/kEJlBCXVh5QBorwdKoWAsm5pwRCPkoSSdVHydGoAfXF0/Z6Xu3fkoeskhtt/IVfD85w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917795; c=relaxed/simple;
	bh=9CxLOFppIB/13rEqFSiPkicRCToQUVuaX1AOaFj0Aj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jARwkkdXPkSuW8pSCtwIxJPVGX5uBRB7JpXAyOTjh83vpKapQUhJOSfaEQBS1ntOvNQj+Z+KcEoF242JVsi7o87g3Au02vNNa+spwQe1v8MyU84jPUnaEQX3CEAqGyH1MGW+WbykU2MEpYQiaV1sW0xY83HvqQaKoHOewBr6VL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anq5eotS; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7e3b3e33ae3so217638241.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712917792; x=1713522592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDA9Fsvooy18fjo8cTSK3tEnpx1k9+s98KjFedtdKvs=;
        b=anq5eotSJx6NDULuVnTVnAk5xRTIJHmS1eElikT1FM0cBqQkXPnW6fAY3u8sVYNs8y
         iOf9VlqSOCPgiLbVQ67VDHyxX0ZYt81Qy1/m5GnyfYk6jQ9qWiNv61j97uxSeGsleUSt
         PpqYN2fthGPpoVknC39iRbJapdbyFwQCcIl3jCeHvdtxsWox901XT8IpKK4zgp0eQPKe
         3S/0vWw7TE36H9ECoGGjIh7ca+OLAtUODQTQk8tUQkIDA7byP1GzgAcJVhxGKp588F0E
         uuaXlSAxbTtXeowke+P+Bt2YGUnRqp5FV0Ju6dMjqkTore7xckL5ISauS3aZ4F1FsvSX
         HLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712917792; x=1713522592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDA9Fsvooy18fjo8cTSK3tEnpx1k9+s98KjFedtdKvs=;
        b=IpagKZr6BMd7bZtUprZgMxL+mkJXERDFokvYi0aLCLU0ryfT/dWJxgH7iC9DztwI8x
         jL6QE7I76TCLXTSwYus++E/dFiYB3tewjQQHH6G2rjETamSwBNgphjGm4M/uCqFrj672
         jQgfB3ACECYkaRy5ZCa+ZafcdVlOG9L4hW0//G/Mp0lFWP8onI4NNI8L2ZqPOHBVGWwO
         P2x7mnsslyb6MyH0/DP4htZMeaEkRGU9jgPBV+leK4aC2nISqOrikJmPLxaKqnuja8q0
         D82HN28GR8eauVCASBCWnX2E1ClTzJ99+bhYH3Mir3BasNmS1c8LZXhOhlZr923Q68rA
         75fA==
X-Forwarded-Encrypted: i=1; AJvYcCXEPFdJTJ/bPG2mXv7FMl9OqK+CVymBtPxcdiwHCvIk91er4aj/GaM+THqY0hxBwg1wsV23EL/x5qvM6zK6rjob6BVA8P500eBX13Ih
X-Gm-Message-State: AOJu0Yy3wVl7Hy0jfbp5ZEVfIF6vefkMJL/5pJD/ZHozIuIimd2mx3o4
	pouiX/85bRkwqUEAD8ysmlWHdYx6GG8yJrjNgzNXYPXPba4XCYbV1wPTfOpOEaSp4aeCip35RMH
	IAjjw6ijSaKv4W6SPXqKSlhgI3Vc=
X-Google-Smtp-Source: AGHT+IGe6v65rFbNtZ9Y82mossVRD62kRKetDMzyaq+ykRQZYS0zZlj2LzN+WsFpiMna22CdaNC/uRl3TxSh9oAKCno=
X-Received: by 2002:a05:6122:3c54:b0:4d8:4a7f:c166 with SMTP id
 fv20-20020a0561223c5400b004d84a7fc166mr2487170vkb.12.1712917792571; Fri, 12
 Apr 2024 03:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5d6e014-5d6b-441c-8379-252ff24e2260@arm.com> <20240412101756.296971-1-21cnbao@gmail.com>
 <744fc49e-d91b-4f5a-9a27-1a25c50c2154@arm.com>
In-Reply-To: <744fc49e-d91b-4f5a-9a27-1a25c50c2154@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 12 Apr 2024 22:29:41 +1200
Message-ID: <CAGsJ_4z6B09wbRFTXXek+pNi9yCHSSF+ZS2gph+AtViMhZyN9w@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: add per-order mTHP anon_fault_alloc and
 anon_fault_fallback counters
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, cerasuolodomenico@gmail.com, chrisl@kernel.org, 
	corbet@lwn.net, david@redhat.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, peterx@redhat.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	yosryahmed@google.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 10:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 12/04/2024 11:17, Barry Song wrote:
> > On Fri, Apr 12, 2024 at 9:56=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 12/04/2024 10:43, Barry Song wrote:
> >>> On Fri, Apr 12, 2024 at 9:27=E2=80=AFPM Ryan Roberts <ryan.roberts@ar=
m.com> wrote:
> >>>>
> >>>> Hi Barry,
> >>>>
> >>>> 2 remaining comments - otherwise looks good. (same comments I just m=
ade in the
> >>>> v4 conversation).
> >>>>
> >>>> On 12/04/2024 08:37, Barry Song wrote:
> >>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>
> >>>>> Profiling a system blindly with mTHP has become challenging due to =
the
> >>>>> lack of visibility into its operations.  Presenting the success rat=
e of
> >>>>> mTHP allocations appears to be pressing need.
> >>>>>
> >>>>> Recently, I've been experiencing significant difficulty debugging
> >>>>> performance improvements and regressions without these figures.  It=
's
> >>>>> crucial for us to understand the true effectiveness of mTHP in real=
-world
> >>>>> scenarios, especially in systems with fragmented memory.
> >>>>>
> >>>>> This patch establishes the framework for per-order mTHP
> >>>>> counters. It begins by introducing the anon_fault_alloc and
> >>>>> anon_fault_fallback counters. Additionally, to maintain consistency
> >>>>> with thp_fault_fallback_charge in /proc/vmstat, this patch also tra=
cks
> >>>>> anon_fault_fallback_charge when mem_cgroup_charge fails for mTHP.
> >>>>> Incorporating additional counters should now be straightforward as =
well.
> >>>>>
> >>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>>> Cc: Chris Li <chrisl@kernel.org>
> >>>>> Cc: David Hildenbrand <david@redhat.com>
> >>>>> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >>>>> Cc: Kairui Song <kasong@tencent.com>
> >>>>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> >>>>> Cc: Peter Xu <peterx@redhat.com>
> >>>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>>>> Cc: Suren Baghdasaryan <surenb@google.com>
> >>>>> Cc: Yosry Ahmed <yosryahmed@google.com>
> >>>>> Cc: Yu Zhao <yuzhao@google.com>
> >>>>> ---
> >>>>>  include/linux/huge_mm.h | 51 ++++++++++++++++++++++++++++++++++
> >>>>>  mm/huge_memory.c        | 61 +++++++++++++++++++++++++++++++++++++=
++++
> >>>>>  mm/memory.c             |  3 ++
> >>>>>  mm/page_alloc.c         |  4 +++
> >>>>>  4 files changed, 119 insertions(+)
> >>>>>
> >>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> >>>>> index e896ca4760f6..c5beb54b97cb 100644
> >>>>> --- a/include/linux/huge_mm.h
> >>>>> +++ b/include/linux/huge_mm.h
> >>>>> @@ -264,6 +264,57 @@ unsigned long thp_vma_allowable_orders(struct =
vm_area_struct *vma,
> >>>>>                                         enforce_sysfs, orders);
> >>>>>  }
> >>>>>
> >>>>> +enum mthp_stat_item {
> >>>>> +     MTHP_STAT_ANON_FAULT_ALLOC,
> >>>>> +     MTHP_STAT_ANON_FAULT_FALLBACK,
> >>>>> +     MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >>>>> +     __MTHP_STAT_COUNT
> >>>>> +};
> >>>>> +
> >>>>> +struct mthp_stat {
> >>>>> +     unsigned long stats[0][__MTHP_STAT_COUNT];
> >>>>> +};
> >>>>> +
> >>>>> +extern struct mthp_stat __percpu *mthp_stats;
> >>>>> +
> >>>>> +static inline void count_mthp_stat(int order, enum mthp_stat_item =
item)
> >>>>> +{
> >>>>> +     if (order <=3D 0 || order > PMD_ORDER || !mthp_stats)
> >>>>> +             return;
> >>>>> +
> >>>>> +     this_cpu_inc(mthp_stats->stats[order][item]);
> >>>>> +}
> >>>>> +
> >>>>> +static inline void count_mthp_stats(int order, enum mthp_stat_item=
 item, long delta)
> >>>>> +{
> >>>>> +     if (order <=3D 0 || order > PMD_ORDER || !mthp_stats)
> >>>>> +             return;
> >>>>> +
> >>>>> +     this_cpu_add(mthp_stats->stats[order][item], delta);
> >>>>> +}
> >>>>> +
> >>>>> +/*
> >>>>> + * Fold the foreign cpu mthp stats into our own.
> >>>>> + *
> >>>>> + * This is adding to the stats on one processor
> >>>>> + * but keeps the global counts constant.
> >>>>> + */
> >>>>> +static inline void mthp_stats_fold_cpu(int cpu)
> >>>>> +{
> >>>>> +     struct mthp_stat *fold_stat;
> >>>>> +     int i, j;
> >>>>> +
> >>>>> +     if (!mthp_stats)
> >>>>> +             return;
> >>>>> +     fold_stat =3D per_cpu_ptr(mthp_stats, cpu);
> >>>>> +     for (i =3D 1; i <=3D PMD_ORDER; i++) {
> >>>>> +             for (j =3D 0; j < __MTHP_STAT_COUNT; j++) {
> >>>>> +                     count_mthp_stats(i, j, fold_stat->stats[i][j]=
);
> >>>>> +                     fold_stat->stats[i][j] =3D 0;
> >>>>> +             }
> >>>>> +     }
> >>>>> +}
> >>>>
> >>>> This is a pretty horrible hack; I'm pretty sure just summing for all=
 *possible*
> >>>> cpus should work.
> >>>>
> >>>>> +
> >>>>>  #define transparent_hugepage_use_zero_page()                      =
   \
> >>>>>       (transparent_hugepage_flags &                                =
   \
> >>>>>        (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
> >>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>>> index dc30139590e6..21c4ac74b484 100644
> >>>>> --- a/mm/huge_memory.c
> >>>>> +++ b/mm/huge_memory.c
> >>>>> @@ -526,6 +526,50 @@ static const struct kobj_type thpsize_ktype =
=3D {
> >>>>>       .sysfs_ops =3D &kobj_sysfs_ops,
> >>>>>  };
> >>>>>
> >>>>> +struct mthp_stat __percpu *mthp_stats;
> >>>>> +
> >>>>> +static unsigned long sum_mthp_stat(int order, enum mthp_stat_item =
item)
> >>>>> +{
> >>>>> +     unsigned long sum =3D 0;
> >>>>> +     int cpu;
> >>>>> +
> >>>>> +     cpus_read_lock();
> >>>>> +     for_each_online_cpu(cpu) {
> >>>>> +             struct mthp_stat *this =3D per_cpu_ptr(mthp_stats, cp=
u);
> >>>>> +
> >>>>> +             sum +=3D this->stats[order][item];
> >>>>> +     }
> >>>>> +     cpus_read_unlock();
> >>>>> +
> >>>>> +     return sum;
> >>>>> +}
> >>>>> +
> >>>>> +#define DEFINE_MTHP_STAT_ATTR(_name, _index)                      =
           \
> >>>>> +static ssize_t _name##_show(struct kobject *kobj,                 =
   \
> >>>>> +                     struct kobj_attribute *attr, char *buf)      =
   \
> >>>>> +{                                                                 =
   \
> >>>>> +     int order =3D to_thpsize(kobj)->order;                       =
     \
> >>>>> +                                                                  =
   \
> >>>>> +     return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index))=
;  \
> >>>>> +}                                                                 =
   \
> >>>>> +static struct kobj_attribute _name##_attr =3D __ATTR_RO(_name)
> >>>>> +
> >>>>> +DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC=
);
> >>>>> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FA=
LLBACK);
> >>>>> +DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_F=
AULT_FALLBACK_CHARGE);
> >>>>> +
> >>>>> +static struct attribute *stats_attrs[] =3D {
> >>>>> +     &anon_fault_alloc_attr.attr,
> >>>>> +     &anon_fault_fallback_attr.attr,
> >>>>> +     &anon_fault_fallback_charge_attr.attr,
> >>>>> +     NULL,
> >>>>> +};
> >>>>> +
> >>>>> +static struct attribute_group stats_attr_group =3D {
> >>>>> +     .name =3D "stats",
> >>>>> +     .attrs =3D stats_attrs,
> >>>>> +};
> >>>>> +
> >>>>>  static struct thpsize *thpsize_create(int order, struct kobject *p=
arent)
> >>>>>  {
> >>>>>       unsigned long size =3D (PAGE_SIZE << order) / SZ_1K;
> >>>>> @@ -549,6 +593,12 @@ static struct thpsize *thpsize_create(int orde=
r, struct kobject *parent)
> >>>>>               return ERR_PTR(ret);
> >>>>>       }
> >>>>>
> >>>>> +     ret =3D sysfs_create_group(&thpsize->kobj, &stats_attr_group)=
;
> >>>>> +     if (ret) {
> >>>>> +             kobject_put(&thpsize->kobj);
> >>>>> +             return ERR_PTR(ret);
> >>>>> +     }
> >>>>> +
> >>>>>       thpsize->order =3D order;
> >>>>>       return thpsize;
> >>>>>  }
> >>>>> @@ -691,6 +741,11 @@ static int __init hugepage_init(void)
> >>>>>        */
> >>>>>       MAYBE_BUILD_BUG_ON(HPAGE_PMD_ORDER < 2);
> >>>>>
> >>>>> +     mthp_stats =3D __alloc_percpu((PMD_ORDER + 1) * sizeof(mthp_s=
tats->stats[0]),
> >>>>> +                     sizeof(unsigned long));
> >>>>
> >>>> Personally I think it would be cleaner to allocate statically using
> >>>> ilog2(MAX_PTRS_PER_PTE) instead of PMD_ORDER.
> >>>
> >>> Hi Ryan,
> >>>
> >>> I don't understand why MAX_PTRS_PER_PTE is the correct size. For ARM6=
4,
> >>>
> >>> #define PMD_ORDER       (PMD_SHIFT - PAGE_SHIFT)
> >>>
> >>> #define MAX_PTRS_PER_PTE PTRS_PER_PTE
> >>>
> >>> #define PTRS_PER_PTE            (1 << (PAGE_SHIFT - 3))
> >>>
> >>> while PAGE_SIZE is 16KiB or 64KiB, PTRS_PER_PTE can be a huge number?
> >>>
> >>>
> >>> Am I missing something?
> >>
> >> PTRS_PER_PTE is the number of PTE entries in a PTE table. On arm64 its=
 as follows:
> >>
> >> PAGE_SIZE       PAGE_SHIFT      PTRS_PER_PTE
> >> 4K              12              512
> >> 16K             14              2048
> >> 64K             16              8192
> >>
> >> So (PTRS_PER_PTE * PAGE_SIZE) =3D PMD_SIZE
> >>
> >> PMD_ORDER is ilog2(PMD_SIZE / PAGE_SIZE) =3D ilog2(PTRS_PER_PTE)
> >>
> >> MAX_PTRS_PER_PTE is just the maximum value that PTRS_PER_PTE will ever=
 have,
> >> (and its equal to PTRS_PER_PTE except for powerpc).
> >>
> >> Pretty sure the math is correct?
> >
> > I am not convinced the math is correct :-)
> >
> > while page size is 64KiB, the page table is as below,
> > PMD_ORDER =3D L2 index bits =3D [41:29] =3D 13 !=3D ilog2(8192)
>
> 1 << 13 =3D 8192
>
> Right? So:
>
> ilog2(8192) =3D 13
>
> What's wrong with that?
>
> I even checked in Python to make sure I'm not going mad:
>
> >>> import math
> >>> math.log2(8192)
> 13.0

You're correct. My mind fixated on the '16' in the line '64K 16 8192'.
I mistakenly thought ilog2(8192) equals 16. Apologies for the confusion.

>
> >
> >
> > +--------+--------+--------+--------+--------+--------+--------+-------=
-+
> > |63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      =
0|
> > +--------+--------+--------+--------+--------+--------+--------+-------=
-+
> >  |                 |    |               |              |
> >  |                 |    |               |              v
> >  |                 |    |               |            [15:0]  in-page of=
fset
> >  |                 |    |               +----------> [28:16] L3 index
> >  |                 |    +--------------------------> [41:29] L2 index
> >  |                 +-------------------------------> [47:42] L1 index (=
48-bit)
> >  |                                                   [51:42] L1 index (=
52-bit)
> >  +-------------------------------------------------> [63] TTBR0/1
> >
> > while page size is 4KiB, the page table is as below,
> >
> > +--------+--------+--------+--------+--------+--------+--------+-------=
-+
> > |63    56|55    48|47    40|39    32|31    24|23    16|15     8|7      =
0|
> > +--------+--------+--------+--------+--------+--------+--------+-------=
-+
> >  |                 |         |         |         |         |
> >  |                 |         |         |         |         v
> >  |                 |         |         |         |   [11:0]  in-page of=
fset
> >  |                 |         |         |         +-> [20:12] L3 index
> >  |                 |         |         +-----------> [29:21] L2 index
> >  |                 |         +---------------------> [38:30] L1 index
> >  |                 +-------------------------------> [47:39] L0 index
> >  +-------------------------------------------------> [63] TTBR0/1
> >
> > PMD_ORDER =3D L2 index bits =3D [29:21] =3D 9 =3D ilog2(512).
> >
> > You are only correct while page size =3D 4KiB.
> >
> >
> >
> >
>

