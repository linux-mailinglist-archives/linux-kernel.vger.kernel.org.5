Return-Path: <linux-kernel+bounces-39653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EA383D460
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0251F24DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CD91B285;
	Fri, 26 Jan 2024 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esu7Jn2d"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59A10A30;
	Fri, 26 Jan 2024 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249815; cv=none; b=lapaJht+dyQx4GJaBDqr8uu7XzPJpWpU05UAE3N/Z3r4PYhpnzAqwem6gUqRWwMq1jh41+kLHrA+PuUelkGL2NE0GSi206v2/p4AEatHaRjfwBwxqVfC9wmpHKFDrlSdBWSiuNPYgps00Pv1fjfIOt+s+AywWxHKN0L6MFqIrok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249815; c=relaxed/simple;
	bh=+RS6pWLYvZZR5qr9QIYCkeX9PeKaTmLVjC/XMzz9ppw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWjOHR+MEYGamvguifSKkg9E+ofS/iEr0YgFqc5riWo31vRCkZkRKPrrEO4LLDPxMozavW0RNETMDY2LqzD1m7iwsSDbL7OsEnJZWQfhnDXh4nK3zyqdZYPAkU6ITZ70pJRfkHB4tAnpDbXLMmsdxj/z2+yFHoq28V/IWrhd+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esu7Jn2d; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc239f84ba4so50706276.3;
        Thu, 25 Jan 2024 22:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706249812; x=1706854612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJFY19VRpGGo0KhyprIbVswQV2+1t5y/yCLnkUggO50=;
        b=Esu7Jn2dQMv7o279VNoRIx9WYgj7cB9xft4RJVCnIJ0Mtfhd77IguwU6ZrBlzWlLbw
         QTYkkueSudM0NSH8NePA5saVgGPDR8PToIIrgpiEe1v9YRJi4qPxeC587k13ZavtrU0W
         2YJE6m/cIlFQ7tN1TvlZZy1UWqHHsjly0MYUJWqGOFEzQ9m9yKGiWbYgLpwy37oq2e+N
         LKpd/6XPEXCN60+ZhknN1+BdTRZriuZMfpdFV0ZPlUXafO0ngHRAM45spo/jDvQYCraW
         P4RpURPTdzeRfI3/S1QGSIvbgCUIQJNtIkP1y5JjemZ/FXdhymNyh9abOfhMu99vWDed
         AB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706249812; x=1706854612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJFY19VRpGGo0KhyprIbVswQV2+1t5y/yCLnkUggO50=;
        b=PRRXVkHgvkXWTxHgy3VhAkAbfk5UGknmBOu2d38uIgLrNPHUnL2fO2YMpyIBR+RcH9
         HUsDeNhUNVBeOg+i1GR++C1a/ZrPtbXpQi4lULQfnAfpbe9mkacgPHHRfNY2oMbKN5rJ
         4YH68nZFJXMYCJNIcrXv4wLz8TjG+GZPrk7zSTmJs2Vd8dP79Q661ylgFsRbAJBAMNQv
         9MiR/c66bM68vlgcikJrJenV14IEmpLRf08PpRLp2JxgFV/OB1vcjjpSTqmNhKxh7H1u
         lM+qSthTV3wDmn/dgtzeHmBpXIlJJzcr/qpTRJuceJwe14NXlH7WVn4cnRz+JJQOpG4f
         VV+A==
X-Gm-Message-State: AOJu0YwhDbz0xUHVILDPuh0W0o/rcb3bkIDsG5F8r5xiG+4WR+c7jqPO
	fVQmzosYNGzVuv4BGbRGfIpOEeFKxGbYQdA9jKcTs7zpE41cELhBojKkoGfO0JDEqRlBmf60+zh
	UPg4NuldGdA3SPKi0GTUq+VjV4MA=
X-Google-Smtp-Source: AGHT+IFmOPOdaxGhsCDEjkGs4JIHTYXt8bhasKBscJgccbBO8Xd2sgNigVbPmXBpqPWdi6tW+RXIpTUUf7/4/tawbls=
X-Received: by 2002:a05:6902:56c:b0:dbe:a8e7:a6ea with SMTP id
 a12-20020a056902056c00b00dbea8e7a6eamr1137312ybt.22.1706249811799; Thu, 25
 Jan 2024 22:16:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <CAK1f24=TfJvsDCEesaTa8rGP7ay62p6UiJem=XWnpFa9yfSA3A@mail.gmail.com>
In-Reply-To: <CAK1f24=TfJvsDCEesaTa8rGP7ay62p6UiJem=XWnpFa9yfSA3A@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 26 Jan 2024 14:16:40 +0800
Message-ID: <CAK1f24nS8MEA3wcS4za-uSp7ZBxvd+xqMRf8-u=m5uCvTs8yJQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>, 
	"Zach O'Keefe" <zokeefe@google.com>, Yang Shi <shy828301@gmail.com>, 
	David Hildenbrand <david@redhat.com>
Cc: songmuchun@bytedance.com, peterx@redhat.com, mknyszek@google.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99d like to add another real use case.

In our company, we deploy applications using offline-online
hybrid deployment. This approach leverages the distinctive
resource utilization patterns of online services, utilizing idle
resources during various time periods by filling them with
offline jobs. This helps reduce the growing cost expenditures
for the enterprise.

Whether for online services or offline jobs, their requirements
for THP can be roughly categorized into three types:

* The first type aims to use huge pages as much as possible
and tolerates unpredictable stalls caused by direct reclaim
and/or compaction.
* The second type attempts to use huge pages but is relatively
latency-sensitive and cannot tolerate unpredictable stalls.
* The third type prefers not to use huge pages at all and is
extremely latency-sensitive.

After careful consideration, we decided to prioritize the
requirements of the first type and modify the THP settings
as follows:

echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
echo defer >/sys/kernel/mm/transparent_hugepage/defrag

With the introduction of MADV_COLLAPSE into the kernel,
it is no longer dependent on any sysfs setting under
/sys/kernel/mm/transparent_hugepage. MADV_COLLAPSE
offers the potential for fine-grained synchronous control over
the huge page allocation mechanism, marking a significant
enhancement for THP.

If the kernel supports a more relaxed (opportunistic)
MADV_COLLAPSE, we will modify the THP settings as follows:

echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
echo madvise >/sys/kernel/mm/transparent_hugepage/defrag

Then, we will use process_madvise(MADV_COLLAPSE, xx_relaxed_flag)
to address the requirements of the second type.

Why don't we favor madvise(MADV_COLLAPSE) for the first type
of requirements?
The main reason is that these requirements are typically for offline
jobs in the Hadoop ecosystem, such as MapReduce and Spark,
which run primarily on the JVM. IIRC, the JVM currently does not
support madvise(MADV_COLLAPSE). The second type of
requirements is all for our in-house developed online services.
For us, integrating a more relaxed (opportunistic)
MADV_COLLAPSE into our online services is relatively
straightforward.

By introducing various flags to MADV_COLLAPSE, we can offer
multiple synchronous allocation strategies for applications. This
fine-grained control may be more suitable for cloud-native
environments than the widespread settings under
/sys/kernel/mm/transparent_hugepage in sysfs.

Thanks for your time!
Lance

On Sun, Jan 21, 2024 at 11:12=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
>
> Hello Everyone,
>
> For applications actively utilizing THP, the defrag mode may
> not be a very user-friendly design. Here are the reasons:
> 1. Before marking the address space with
>     MADV_HUGEPAGE,it is necessary to check if
>     the current configuration of the defrag mode aligns with
>     their preferences.
> 2. Once the defrag mode configuration changes, these
>     applications may face the risk of unpredictable stalls.
>
> THP is an important feature of the Linux kernel that can
> significantly enhance memory access performance.
> However, due to the lack of fine-grained control over
> the huge page allocation strategy, many applications
> default to not using huge pages and even recommend
> users to disable THP. This situation is regrettable.
>
> With the introduction of MADV_COLLAPSE into the kernel,
> it is not affected by the defrag mode.
> MADV_COLLAPSE offers the potential for
> fine-grained synchronous control over the huge page
> allocation mechanism, marking a significant enhancement
> for THP.
>
> By adding flags to MADV_COLLAPSE, different
> synchronous allocation strategies can be provided to
> applications. This can instill confidence in them, allowing
> them to reconsider using THP and allocate huge pages
> according to their desired synchronous allocation strategy,
> without worrying about the defrag mode configuration.
>
> BR,
> Lance
>
>
> On Thu, Jan 18, 2024 at 8:03=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].
> >
> > Allow MADV_F_COLLAPSE_LIGHT behavior for process_madvise(2) if the call=
er
> > has CAP_SYS_ADMIN or is requesting the collapse of its own memory.
> >
> > The semantics of MADV_F_COLLAPSE_LIGHT are similar to MADV_COLLAPSE, bu=
t
> > it  avoids direct reclaim and/or compaction, quickly failing on allocat=
ion
> > errors.
> >
> > This change enables a more flexible and efficient usage of memory colla=
pse
> > operations, providing additional control to userspace applications for
> > system-wide THP optimization.
> >
> > Semantics
> >
> > This call is independent of the system-wide THP sysfs settings, but wil=
l
> > fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
> > multiple VMAs, the semantics of the collapse over each VMA is independe=
nt
> > from the others.  This implies a hugepage cannot cross a VMA boundary. =
 If
> > collapse of a given hugepage-aligned/sized region fails, the operation =
may
> > continue to attempt collapsing the remainder of memory specified.
> >
> > The memory ranges provided must be page-aligned, but are not required t=
o
> > be hugepage-aligned.  If the memory ranges are not hugepage-aligned, th=
e
> > start/end of the range will be clamped to the first/last hugepage-align=
ed
> > address covered by said range.  The memory ranges must span at least on=
e
> > hugepage-sized region.
> >
> > All non-resident pages covered by the range will first be
> > swapped/faulted-in, before being internally copied onto a freshly
> > allocated hugepage.  Unmapped pages will have their data directly
> > initialized to 0 in the new hugepage.  However, for every eligible
> > hugepage aligned/sized region to-be collapsed, at least one page must
> > currently be backed by memory (a PMD covering the address range must
> > already exist).
> >
> > Allocation for the new hugepage will not enter direct reclaim and/or
> > compaction, quickly failing if allocation fails. When the system has
> > multiple NUMA nodes, the hugepage will be allocated from the node provi=
ding
> > the most native pages. This operation operates on the current state of =
the
> > specified process and makes no persistent changes or guarantees on how =
pages
> > will be mapped, constructed, or faulted in the future.
> >
> > Use Cases
> >
> > An immediate user of this new functionality is the Go runtime heap allo=
cator
> > that manages memory in hugepage-sized chunks. In the past, whether it w=
as a
> > newly allocated chunk through mmap() or a reused chunk released by
> > madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory =
with
> > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[3=
]
> > respectively. However, both approaches resulted in performance issues; =
for
> > both scenarios, there could be entries into direct reclaim and/or compa=
ction,
> > leading to unpredictable stalls[4]. Now, the allocator can confidently =
use
> > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of hug=
e pages.
> >
> > [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404f=
aca29a82689c77
> > [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa7333740996181=
268b60a3a
> > [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be4=
b3a9bd2af
> > [4] https://github.com/golang/go/issues/63334
> >
> > [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@gmai=
l.com/
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > Suggested-by: Zach O'Keefe <zokeefe@google.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > ---
> > V1 -> V2: Treat process_madvise(MADV_F_COLLAPSE_LIGHT) as the lighter-w=
eight alternative
> >         to madvise(MADV_COLLAPSE)
> >
> >  arch/alpha/include/uapi/asm/mman.h           |  1 +
> >  arch/mips/include/uapi/asm/mman.h            |  1 +
> >  arch/parisc/include/uapi/asm/mman.h          |  1 +
> >  arch/xtensa/include/uapi/asm/mman.h          |  1 +
> >  include/linux/huge_mm.h                      |  5 +--
> >  include/uapi/asm-generic/mman-common.h       |  1 +
> >  mm/khugepaged.c                              | 15 ++++++--
> >  mm/madvise.c                                 | 36 +++++++++++++++++---
> >  tools/include/uapi/asm-generic/mman-common.h |  1 +
> >  9 files changed, 52 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/ua=
pi/asm/mman.h
> > index 763929e814e9..22f23ca04f1a 100644
> > --- a/arch/alpha/include/uapi/asm/mman.h
> > +++ b/arch/alpha/include/uapi/asm/mman.h
> > @@ -77,6 +77,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi=
/asm/mman.h
> > index c6e1fc77c996..acec0b643e9c 100644
> > --- a/arch/mips/include/uapi/asm/mman.h
> > +++ b/arch/mips/include/uapi/asm/mman.h
> > @@ -104,6 +104,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/=
uapi/asm/mman.h
> > index 68c44f99bc93..812029c98cd7 100644
> > --- a/arch/parisc/include/uapi/asm/mman.h
> > +++ b/arch/parisc/include/uapi/asm/mman.h
> > @@ -71,6 +71,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  #define MADV_HWPOISON     100          /* poison a page for testing */
> >  #define MADV_SOFT_OFFLINE 101          /* soft offline page for testin=
g */
> > diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/=
uapi/asm/mman.h
> > index 1ff0c858544f..52ef463dd5b6 100644
> > --- a/arch/xtensa/include/uapi/asm/mman.h
> > +++ b/arch/xtensa/include/uapi/asm/mman.h
> > @@ -112,6 +112,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 5adb86af35fc..075fdb5d481a 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -303,7 +303,7 @@ int hugepage_madvise(struct vm_area_struct *vma, un=
signed long *vm_flags,
> >                      int advice);
> >  int madvise_collapse(struct vm_area_struct *vma,
> >                      struct vm_area_struct **prev,
> > -                    unsigned long start, unsigned long end);
> > +                    unsigned long start, unsigned long end, int behavi=
or);
> >  void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long s=
tart,
> >                            unsigned long end, long adjust_next);
> >  spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *v=
ma);
> > @@ -450,7 +450,8 @@ static inline int hugepage_madvise(struct vm_area_s=
truct *vma,
> >
> >  static inline int madvise_collapse(struct vm_area_struct *vma,
> >                                    struct vm_area_struct **prev,
> > -                                  unsigned long start, unsigned long e=
nd)
> > +                                  unsigned long start, unsigned long e=
nd,
> > +                                  int behavior)
> >  {
> >         return -EINVAL;
> >  }
> > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-=
generic/mman-common.h
> > index 6ce1f1ceb432..92c67bc755da 100644
> > --- a/include/uapi/asm-generic/mman-common.h
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -78,6 +78,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 2b219acb528e..2840051c0ae2 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -97,6 +97,8 @@ static struct kmem_cache *mm_slot_cache __ro_after_in=
it;
> >  struct collapse_control {
> >         bool is_khugepaged;
> >
> > +       int behavior;
> > +
> >         /* Num pages scanned per node */
> >         u32 node_load[MAX_NUMNODES];
> >
> > @@ -1058,10 +1060,16 @@ static int __collapse_huge_page_swapin(struct m=
m_struct *mm,
> >  static int alloc_charge_hpage(struct page **hpage, struct mm_struct *m=
m,
> >                               struct collapse_control *cc)
> >  {
> > -       gfp_t gfp =3D (cc->is_khugepaged ? alloc_hugepage_khugepaged_gf=
pmask() :
> > -                    GFP_TRANSHUGE);
> >         int node =3D hpage_collapse_find_target_node(cc);
> >         struct folio *folio;
> > +       gfp_t gfp;
> > +
> > +       if (cc->is_khugepaged)
> > +               gfp =3D alloc_hugepage_khugepaged_gfpmask();
> > +       else
> > +               gfp =3D (cc->behavior =3D=3D MADV_F_COLLAPSE_LIGHT ?
> > +                              GFP_TRANSHUGE_LIGHT :
> > +                              GFP_TRANSHUGE);
> >
> >         if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_n=
mask)) {
> >                 *hpage =3D NULL;
> > @@ -2697,7 +2705,7 @@ static int madvise_collapse_errno(enum scan_resul=
t r)
> >  }
> >
> >  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct=
 **prev,
> > -                    unsigned long start, unsigned long end)
> > +                    unsigned long start, unsigned long end, int behavi=
or)
> >  {
> >         struct collapse_control *cc;
> >         struct mm_struct *mm =3D vma->vm_mm;
> > @@ -2718,6 +2726,7 @@ int madvise_collapse(struct vm_area_struct *vma, =
struct vm_area_struct **prev,
> >         if (!cc)
> >                 return -ENOMEM;
> >         cc->is_khugepaged =3D false;
> > +       cc->behavior =3D behavior;
> >
> >         mmgrab(mm);
> >         lru_add_drain_all();
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 912155a94ed5..9c40226505aa 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
> >         case MADV_POPULATE_READ:
> >         case MADV_POPULATE_WRITE:
> >         case MADV_COLLAPSE:
> > +       case MADV_F_COLLAPSE_LIGHT:
> >                 return 0;
> >         default:
> >                 /* be safe, default to 1. list exceptions explicitly */
> > @@ -1082,8 +1083,9 @@ static int madvise_vma_behavior(struct vm_area_st=
ruct *vma,
> >                 if (error)
> >                         goto out;
> >                 break;
> > +       case MADV_F_COLLAPSE_LIGHT:
> >         case MADV_COLLAPSE:
> > -               return madvise_collapse(vma, prev, start, end);
> > +               return madvise_collapse(vma, prev, start, end, behavior=
);
> >         }
> >
> >         anon_name =3D anon_vma_name(vma);
> > @@ -1178,6 +1180,7 @@ madvise_behavior_valid(int behavior)
> >         case MADV_HUGEPAGE:
> >         case MADV_NOHUGEPAGE:
> >         case MADV_COLLAPSE:
> > +       case MADV_F_COLLAPSE_LIGHT:
> >  #endif
> >         case MADV_DONTDUMP:
> >         case MADV_DODUMP:
> > @@ -1194,6 +1197,17 @@ madvise_behavior_valid(int behavior)
> >         }
> >  }
> >
> > +
> > +static bool process_madvise_behavior_only(int behavior)
> > +{
> > +       switch (behavior) {
> > +       case MADV_F_COLLAPSE_LIGHT:
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> >  static bool process_madvise_behavior_valid(int behavior)
> >  {
> >         switch (behavior) {
> > @@ -1201,6 +1215,7 @@ static bool process_madvise_behavior_valid(int be=
havior)
> >         case MADV_PAGEOUT:
> >         case MADV_WILLNEED:
> >         case MADV_COLLAPSE:
> > +       case MADV_F_COLLAPSE_LIGHT:
> >                 return true;
> >         default:
> >                 return false;
> > @@ -1368,6 +1383,8 @@ int madvise_set_anon_name(struct mm_struct *mm, u=
nsigned long start,
> >   *             transparent huge pages so the existing pages will not b=
e
> >   *             coalesced into THP and new pages will not be allocated =
as THP.
> >   *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
> > + *  MADV_F_COLLAPSE_LIGHT - only for process_madvise, avoids direct re=
claim and/or
> > + *             compaction.
> >   *  MADV_DONTDUMP - the application wants to prevent pages in the give=
n range
> >   *             from being included in its core dump.
> >   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core du=
mp.
> > @@ -1394,7 +1411,8 @@ int madvise_set_anon_name(struct mm_struct *mm, u=
nsigned long start,
> >   *  -EBADF  - map exists, but area maps something that isn't a file.
> >   *  -EAGAIN - a kernel resource was temporarily unavailable.
> >   */
> > -int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_i=
n, int behavior)
> > +int _do_madvise(struct mm_struct *mm, unsigned long start, size_t len_=
in,
> > +               int behavior, bool is_process_madvise)
> >  {
> >         unsigned long end;
> >         int error;
> > @@ -1405,6 +1423,9 @@ int do_madvise(struct mm_struct *mm, unsigned lon=
g start, size_t len_in, int beh
> >         if (!madvise_behavior_valid(behavior))
> >                 return -EINVAL;
> >
> > +       if (!is_process_madvise && process_madvise_behavior_only(behavi=
or))
> > +               return -EINVAL;
> > +
> >         if (!PAGE_ALIGNED(start))
> >                 return -EINVAL;
> >         len =3D PAGE_ALIGN(len_in);
> > @@ -1448,9 +1469,14 @@ int do_madvise(struct mm_struct *mm, unsigned lo=
ng start, size_t len_in, int beh
> >         return error;
> >  }
> >
> > +int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_i=
n, int behavior)
> > +{
> > +       return _do_madvise(mm, start, len_in, behavior, false);
> > +}
> > +
> >  SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, be=
havior)
> >  {
> > -       return do_madvise(current->mm, start, len_in, behavior);
> > +       return _do_madvise(current->mm, start, len_in, behavior, false)=
;
> >  }
> >
> >  SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user=
 *, vec,
> > @@ -1504,8 +1530,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, cons=
t struct iovec __user *, vec,
> >         total_len =3D iov_iter_count(&iter);
> >
> >         while (iov_iter_count(&iter)) {
> > -               ret =3D do_madvise(mm, (unsigned long)iter_iov_addr(&it=
er),
> > -                                       iter_iov_len(&iter), behavior);
> > +               ret =3D _do_madvise(mm, (unsigned long)iter_iov_addr(&i=
ter),
> > +                                       iter_iov_len(&iter), behavior, =
true);
> >                 if (ret < 0)
> >                         break;
> >                 iov_iter_advance(&iter, iter_iov_len(&iter));
> > diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/inclu=
de/uapi/asm-generic/mman-common.h
> > index 6ce1f1ceb432..92c67bc755da 100644
> > --- a/tools/include/uapi/asm-generic/mman-common.h
> > +++ b/tools/include/uapi/asm-generic/mman-common.h
> > @@ -78,6 +78,7 @@
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop lock=
ed pages too */
> >
> >  #define MADV_COLLAPSE  25              /* Synchronous hugepage collaps=
e */
> > +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avo=
ids direct reclaim and/or compaction */
> >
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> > --
> > 2.33.1
> >

