Return-Path: <linux-kernel+bounces-31958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F06F83544C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 04:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AF71F21F4D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 03:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FFB36125;
	Sun, 21 Jan 2024 03:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnN4NmK6"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A436114;
	Sun, 21 Jan 2024 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705806736; cv=none; b=LzFcHac1QUQXixcFN/kTqBpKasVZYXNnP9f6iCvND5nySC7cxipfID0IWahlcpw4mP5qp2CBK7XdOXYbBn385lCrfwzhao4Otk1+RygPP7EMBxFIG1hyw4uGyZ1fCfIWZBxWxN3gFbKMAq2MBhbnQW3BfaNl4zw1g767vH62/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705806736; c=relaxed/simple;
	bh=GlWq5YzAvZikC6Mv5PQXdsGxLulWZUj/h1yfuwvRCWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jT9ehGhvuvg19Ezx0pDqb/b5Nr71txMmFS4wy3wHT2ODS9R7z01LRFCXqBK76QwgO29ygFMwgH5ZqO5ESk8FM/h9Z9xcrm+EnSgLEhEUbzmVUc82ttv4q8GE2ph1NQ+OgAkImV2FywbMPBLrUCswIx5tniojba47VChUUwaJdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnN4NmK6; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7838af983c1so163659885a.3;
        Sat, 20 Jan 2024 19:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705806733; x=1706411533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6gPUh4N2LTgxhCi9niOzUXp+BMTDaWgskKb2u+4b3k=;
        b=HnN4NmK6Nvf0mfWobl+THmsTiEfNbLlNmr8Gi+HkL+laARk/oCMwq0v13XnVuYTg2j
         g1tA3QBi2LeB8zcXZEOBqzS31dpYBqxq+K4j8pnBOEyKmlCXHf1lBS8QcmJAgpXttLLN
         K8Gow0t2lm7ub/Wx0oB6xAA51iWxpy9zk1ENKkAVsM+xW/31qCiLBYjI53ut0MKZFFbh
         s6E3R2KcyuNz2jOVNQwDhKJDr7FHWxiaFTt/KPgdp9rUFC5JeBFKdjZZasafagNsuHox
         n3jxT6dHZKlgi+px4XzjICYp71XbyWX3zXvmcY3Rb5HHlAclYGDRbAOh8E2xDYjQX4NG
         IqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705806733; x=1706411533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6gPUh4N2LTgxhCi9niOzUXp+BMTDaWgskKb2u+4b3k=;
        b=KfcdCwWj5q43XNiv/ChBxJBB6l6r907Wup2kIotKu8XGv9RYgvtcKLkem4zGxLYO7x
         LglO/z7YeU9hcEXK3Hx2BPR04w2luHcPFO548oAVnwrgBnXXo9ijftmVryX16Dfz6pAV
         frVy93voM6gtt1Z6sI+xtEKjvCUGy/AT2qkj7M13S/kKTR1PB7xWQRy42KwUBiHv4WKv
         CC/+QGIj+IF1A5QjZ6FAY1Y5cVEr2wLvsc7e9y+/9pyiJhJFk/hWOJKfoBAm/vlyLG+m
         swYoGrhlthN3urQ84Afy6ztQZqEDtcDANBpRaSrRZFjhzSzlQ4rcyGic6ke3iNcEusY/
         pntg==
X-Gm-Message-State: AOJu0YyunXlsvhS18ov00o+D5xDUV6jC9Mp08WtLVh0QhgssL+U5+ILS
	3nkIdC0RTh3l11q04KrSnulcekDCcxUDEg6Tpf6uiEIfBjTAchcvQ9zYvD3injmVwyHBOrkUSe5
	/KV2LyfAxvLYhb8R0NvcPP3X8law=
X-Google-Smtp-Source: AGHT+IGzafBFye2vRrqSSVKyNAjIMueIUF73ZPHJZdbsCmZjylhu1mYb99ImFJp5Y3+8ybHG56NBq7i0QuUsMAzr+EQ=
X-Received: by 2002:a05:620a:6089:b0:783:8e00:5e38 with SMTP id
 dx9-20020a05620a608900b007838e005e38mr3210431qkb.121.1705806732955; Sat, 20
 Jan 2024 19:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com>
In-Reply-To: <20240118120347.61817-1-ioworker0@gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sun, 21 Jan 2024 11:12:01 +0800
Message-ID: <CAK1f24=TfJvsDCEesaTa8rGP7ay62p6UiJem=XWnpFa9yfSA3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: akpm@linux-foundation.org
Cc: zokeefe@google.com, david@redhat.com, songmuchun@bytedance.com, 
	shy828301@gmail.com, peterx@redhat.com, mknyszek@google.com, 
	minchan@kernel.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Everyone,

For applications actively utilizing THP, the defrag mode may
not be a very user-friendly design. Here are the reasons:
1. Before marking the address space with
    MADV_HUGEPAGE,it is necessary to check if
    the current configuration of the defrag mode aligns with
    their preferences.
2. Once the defrag mode configuration changes, these
    applications may face the risk of unpredictable stalls.

THP is an important feature of the Linux kernel that can
significantly enhance memory access performance.
However, due to the lack of fine-grained control over
the huge page allocation strategy, many applications
default to not using huge pages and even recommend
users to disable THP. This situation is regrettable.

With the introduction of MADV_COLLAPSE into the kernel,
it is not affected by the defrag mode.
MADV_COLLAPSE offers the potential for
fine-grained synchronous control over the huge page
allocation mechanism, marking a significant enhancement
for THP.

By adding flags to MADV_COLLAPSE, different
synchronous allocation strategies can be provided to
applications. This can instill confidence in them, allowing
them to reconsider using THP and allocate huge pages
according to their desired synchronous allocation strategy,
without worrying about the defrag mode configuration.

BR,
Lance


On Thu, Jan 18, 2024 at 8:03=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> This idea was inspired by MADV_COLLAPSE introduced by Zach O'Keefe[1].
>
> Allow MADV_F_COLLAPSE_LIGHT behavior for process_madvise(2) if the caller
> has CAP_SYS_ADMIN or is requesting the collapse of its own memory.
>
> The semantics of MADV_F_COLLAPSE_LIGHT are similar to MADV_COLLAPSE, but
> it  avoids direct reclaim and/or compaction, quickly failing on allocatio=
n
> errors.
>
> This change enables a more flexible and efficient usage of memory collaps=
e
> operations, providing additional control to userspace applications for
> system-wide THP optimization.
>
> Semantics
>
> This call is independent of the system-wide THP sysfs settings, but will
> fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
> multiple VMAs, the semantics of the collapse over each VMA is independent
> from the others.  This implies a hugepage cannot cross a VMA boundary.  I=
f
> collapse of a given hugepage-aligned/sized region fails, the operation ma=
y
> continue to attempt collapsing the remainder of memory specified.
>
> The memory ranges provided must be page-aligned, but are not required to
> be hugepage-aligned.  If the memory ranges are not hugepage-aligned, the
> start/end of the range will be clamped to the first/last hugepage-aligned
> address covered by said range.  The memory ranges must span at least one
> hugepage-sized region.
>
> All non-resident pages covered by the range will first be
> swapped/faulted-in, before being internally copied onto a freshly
> allocated hugepage.  Unmapped pages will have their data directly
> initialized to 0 in the new hugepage.  However, for every eligible
> hugepage aligned/sized region to-be collapsed, at least one page must
> currently be backed by memory (a PMD covering the address range must
> already exist).
>
> Allocation for the new hugepage will not enter direct reclaim and/or
> compaction, quickly failing if allocation fails. When the system has
> multiple NUMA nodes, the hugepage will be allocated from the node providi=
ng
> the most native pages. This operation operates on the current state of th=
e
> specified process and makes no persistent changes or guarantees on how pa=
ges
> will be mapped, constructed, or faulted in the future.
>
> Use Cases
>
> An immediate user of this new functionality is the Go runtime heap alloca=
tor
> that manages memory in hugepage-sized chunks. In the past, whether it was=
 a
> newly allocated chunk through mmap() or a reused chunk released by
> madvise(MADV_DONTNEED), the allocator attempted to eagerly back memory wi=
th
> huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPSE)[3]
> respectively. However, both approaches resulted in performance issues; fo=
r
> both scenarios, there could be entries into direct reclaim and/or compact=
ion,
> leading to unpredictable stalls[4]. Now, the allocator can confidently us=
e
> process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of huge =
pages.
>
> [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56404fac=
a29a82689c77
> [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa733374099618126=
8b60a3a
> [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca3be4b3=
a9bd2af
> [4] https://github.com/golang/go/issues/63334
>
> [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@gmail.=
com/
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> Suggested-by: Zach O'Keefe <zokeefe@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> ---
> V1 -> V2: Treat process_madvise(MADV_F_COLLAPSE_LIGHT) as the lighter-wei=
ght alternative
>         to madvise(MADV_COLLAPSE)
>
>  arch/alpha/include/uapi/asm/mman.h           |  1 +
>  arch/mips/include/uapi/asm/mman.h            |  1 +
>  arch/parisc/include/uapi/asm/mman.h          |  1 +
>  arch/xtensa/include/uapi/asm/mman.h          |  1 +
>  include/linux/huge_mm.h                      |  5 +--
>  include/uapi/asm-generic/mman-common.h       |  1 +
>  mm/khugepaged.c                              | 15 ++++++--
>  mm/madvise.c                                 | 36 +++++++++++++++++---
>  tools/include/uapi/asm-generic/mman-common.h |  1 +
>  9 files changed, 52 insertions(+), 10 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi=
/asm/mman.h
> index 763929e814e9..22f23ca04f1a 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -77,6 +77,7 @@
>  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked=
 pages too */
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
> +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avoid=
s direct reclaim and/or compaction */
>
>  /* compatibility flags */
>  #define MAP_FILE       0
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/a=
sm/mman.h
> index c6e1fc77c996..acec0b643e9c 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -104,6 +104,7 @@
>  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked=
 pages too */
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
> +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avoid=
s direct reclaim and/or compaction */
>
>  /* compatibility flags */
>  #define MAP_FILE       0
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/ua=
pi/asm/mman.h
> index 68c44f99bc93..812029c98cd7 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -71,6 +71,7 @@
>  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked=
 pages too */
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
> +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avoid=
s direct reclaim and/or compaction */
>
>  #define MADV_HWPOISON     100          /* poison a page for testing */
>  #define MADV_SOFT_OFFLINE 101          /* soft offline page for testing =
*/
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/ua=
pi/asm/mman.h
> index 1ff0c858544f..52ef463dd5b6 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -112,6 +112,7 @@
>  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked=
 pages too */
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
> +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avoid=
s direct reclaim and/or compaction */
>
>  /* compatibility flags */
>  #define MAP_FILE       0
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 5adb86af35fc..075fdb5d481a 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -303,7 +303,7 @@ int hugepage_madvise(struct vm_area_struct *vma, unsi=
gned long *vm_flags,
>                      int advice);
>  int madvise_collapse(struct vm_area_struct *vma,
>                      struct vm_area_struct **prev,
> -                    unsigned long start, unsigned long end);
> +                    unsigned long start, unsigned long end, int behavior=
);
>  void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long sta=
rt,
>                            unsigned long end, long adjust_next);
>  spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma=
);
> @@ -450,7 +450,8 @@ static inline int hugepage_madvise(struct vm_area_str=
uct *vma,
>
>  static inline int madvise_collapse(struct vm_area_struct *vma,
>                                    struct vm_area_struct **prev,
> -                                  unsigned long start, unsigned long end=
)
> +                                  unsigned long start, unsigned long end=
,
> +                                  int behavior)
>  {
>         return -EINVAL;
>  }
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-ge=
neric/mman-common.h
> index 6ce1f1ceb432..92c67bc755da 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -78,6 +78,7 @@
>  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked=
 pages too */
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
> +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avoid=
s direct reclaim and/or compaction */
>
>  /* compatibility flags */
>  #define MAP_FILE       0
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2b219acb528e..2840051c0ae2 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -97,6 +97,8 @@ static struct kmem_cache *mm_slot_cache __ro_after_init=
;
>  struct collapse_control {
>         bool is_khugepaged;
>
> +       int behavior;
> +
>         /* Num pages scanned per node */
>         u32 node_load[MAX_NUMNODES];
>
> @@ -1058,10 +1060,16 @@ static int __collapse_huge_page_swapin(struct mm_=
struct *mm,
>  static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
>                               struct collapse_control *cc)
>  {
> -       gfp_t gfp =3D (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpm=
ask() :
> -                    GFP_TRANSHUGE);
>         int node =3D hpage_collapse_find_target_node(cc);
>         struct folio *folio;
> +       gfp_t gfp;
> +
> +       if (cc->is_khugepaged)
> +               gfp =3D alloc_hugepage_khugepaged_gfpmask();
> +       else
> +               gfp =3D (cc->behavior =3D=3D MADV_F_COLLAPSE_LIGHT ?
> +                              GFP_TRANSHUGE_LIGHT :
> +                              GFP_TRANSHUGE);
>
>         if (!hpage_collapse_alloc_folio(&folio, gfp, node, &cc->alloc_nma=
sk)) {
>                 *hpage =3D NULL;
> @@ -2697,7 +2705,7 @@ static int madvise_collapse_errno(enum scan_result =
r)
>  }
>
>  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct *=
*prev,
> -                    unsigned long start, unsigned long end)
> +                    unsigned long start, unsigned long end, int behavior=
)
>  {
>         struct collapse_control *cc;
>         struct mm_struct *mm =3D vma->vm_mm;
> @@ -2718,6 +2726,7 @@ int madvise_collapse(struct vm_area_struct *vma, st=
ruct vm_area_struct **prev,
>         if (!cc)
>                 return -ENOMEM;
>         cc->is_khugepaged =3D false;
> +       cc->behavior =3D behavior;
>
>         mmgrab(mm);
>         lru_add_drain_all();
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 912155a94ed5..9c40226505aa 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
>         case MADV_POPULATE_READ:
>         case MADV_POPULATE_WRITE:
>         case MADV_COLLAPSE:
> +       case MADV_F_COLLAPSE_LIGHT:
>                 return 0;
>         default:
>                 /* be safe, default to 1. list exceptions explicitly */
> @@ -1082,8 +1083,9 @@ static int madvise_vma_behavior(struct vm_area_stru=
ct *vma,
>                 if (error)
>                         goto out;
>                 break;
> +       case MADV_F_COLLAPSE_LIGHT:
>         case MADV_COLLAPSE:
> -               return madvise_collapse(vma, prev, start, end);
> +               return madvise_collapse(vma, prev, start, end, behavior);
>         }
>
>         anon_name =3D anon_vma_name(vma);
> @@ -1178,6 +1180,7 @@ madvise_behavior_valid(int behavior)
>         case MADV_HUGEPAGE:
>         case MADV_NOHUGEPAGE:
>         case MADV_COLLAPSE:
> +       case MADV_F_COLLAPSE_LIGHT:
>  #endif
>         case MADV_DONTDUMP:
>         case MADV_DODUMP:
> @@ -1194,6 +1197,17 @@ madvise_behavior_valid(int behavior)
>         }
>  }
>
> +
> +static bool process_madvise_behavior_only(int behavior)
> +{
> +       switch (behavior) {
> +       case MADV_F_COLLAPSE_LIGHT:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static bool process_madvise_behavior_valid(int behavior)
>  {
>         switch (behavior) {
> @@ -1201,6 +1215,7 @@ static bool process_madvise_behavior_valid(int beha=
vior)
>         case MADV_PAGEOUT:
>         case MADV_WILLNEED:
>         case MADV_COLLAPSE:
> +       case MADV_F_COLLAPSE_LIGHT:
>                 return true;
>         default:
>                 return false;
> @@ -1368,6 +1383,8 @@ int madvise_set_anon_name(struct mm_struct *mm, uns=
igned long start,
>   *             transparent huge pages so the existing pages will not be
>   *             coalesced into THP and new pages will not be allocated as=
 THP.
>   *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
> + *  MADV_F_COLLAPSE_LIGHT - only for process_madvise, avoids direct recl=
aim and/or
> + *             compaction.
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given =
range
>   *             from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump=
.
> @@ -1394,7 +1411,8 @@ int madvise_set_anon_name(struct mm_struct *mm, uns=
igned long start,
>   *  -EBADF  - map exists, but area maps something that isn't a file.
>   *  -EAGAIN - a kernel resource was temporarily unavailable.
>   */
> -int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in,=
 int behavior)
> +int _do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in=
,
> +               int behavior, bool is_process_madvise)
>  {
>         unsigned long end;
>         int error;
> @@ -1405,6 +1423,9 @@ int do_madvise(struct mm_struct *mm, unsigned long =
start, size_t len_in, int beh
>         if (!madvise_behavior_valid(behavior))
>                 return -EINVAL;
>
> +       if (!is_process_madvise && process_madvise_behavior_only(behavior=
))
> +               return -EINVAL;
> +
>         if (!PAGE_ALIGNED(start))
>                 return -EINVAL;
>         len =3D PAGE_ALIGN(len_in);
> @@ -1448,9 +1469,14 @@ int do_madvise(struct mm_struct *mm, unsigned long=
 start, size_t len_in, int beh
>         return error;
>  }
>
> +int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in,=
 int behavior)
> +{
> +       return _do_madvise(mm, start, len_in, behavior, false);
> +}
> +
>  SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, beha=
vior)
>  {
> -       return do_madvise(current->mm, start, len_in, behavior);
> +       return _do_madvise(current->mm, start, len_in, behavior, false);
>  }
>
>  SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *=
, vec,
> @@ -1504,8 +1530,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const =
struct iovec __user *, vec,
>         total_len =3D iov_iter_count(&iter);
>
>         while (iov_iter_count(&iter)) {
> -               ret =3D do_madvise(mm, (unsigned long)iter_iov_addr(&iter=
),
> -                                       iter_iov_len(&iter), behavior);
> +               ret =3D _do_madvise(mm, (unsigned long)iter_iov_addr(&ite=
r),
> +                                       iter_iov_len(&iter), behavior, tr=
ue);
>                 if (ret < 0)
>                         break;
>                 iov_iter_advance(&iter, iter_iov_len(&iter));
> diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include=
/uapi/asm-generic/mman-common.h
> index 6ce1f1ceb432..92c67bc755da 100644
> --- a/tools/include/uapi/asm-generic/mman-common.h
> +++ b/tools/include/uapi/asm-generic/mman-common.h
> @@ -78,6 +78,7 @@
>  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked=
 pages too */
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
> +#define MADV_F_COLLAPSE_LIGHT  26      /* Similar to COLLAPSE, but avoid=
s direct reclaim and/or compaction */
>
>  /* compatibility flags */
>  #define MAP_FILE       0
> --
> 2.33.1
>

