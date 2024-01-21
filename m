Return-Path: <linux-kernel+bounces-32148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77713835742
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 286F1281C56
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E2D38380;
	Sun, 21 Jan 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLqUjJnn"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C04376EC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 18:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705862458; cv=none; b=KrR5Gxp6HU2h/puNYWS5zkFDnGt/U/0HUn/tw7zngu5eyaFujk+zT7bDxU+0cAo8BzNr4XErUaTC4W0aR4D77BvLAHkX6/qBubmntI9DDbjeFnCCkXmZvBXZSVWaGfrDvBTrC/c0nzBOGgzQGhGwC9Lsu+L/M7+ZLZqcWgLUlD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705862458; c=relaxed/simple;
	bh=ZRoRjEqFx7MIByRXmDw4ektr1iw1LKBslUYVcR9EXlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUT4CQVl3Yk3fKmlyVwi9mZ7k0JbTEUo1A7I9o5y724S6ApQ7dhwaSNDhDYCd647P88syl3fSmzWazaiMomH2BmJYGE8mOdu2yAoE12oSXj9B0zMQ6LFFf5EecR8/sggn/nympM5EKL8jSurodhKPan5Bd/iXeHTfH+o5e7x8Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLqUjJnn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-339289fead2so1488448f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 10:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705862454; x=1706467254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMEwMebWb54vAGMkX6mQ7I2tPYB1wuLiLvYDmgiNCng=;
        b=FLqUjJnnfMml/wDV2KUQN3oyDAMHrEa1QZJlMzre0FC5oLJMHYvo6BY4NnlOph3FSw
         WdOxrlI2R2/9Sa4dIpKYyitKDHOMzrmjSDU3BzHAln82CpgwzvmiFW47mE/Kis8ZFczB
         sE/wVb6NUXGyPIdnifmzdFOFGOPRhDviKqVrpnZupGn26E3E4fCihDvlJwjed7XZogTM
         AJe+1T8rxw4enUWvck/SMMQzhr8PKCmh1/UwOXf6mHVnM93Rt6urhOm5XzklASrHMvHp
         yyyXeVgFnHs4N3X9Yr2sODYf1iBG6MzNkzCQBHgIplaCIhgpVGdMfaiOnoVvvzeIcGpT
         LGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705862454; x=1706467254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMEwMebWb54vAGMkX6mQ7I2tPYB1wuLiLvYDmgiNCng=;
        b=TX7fmNPxyvoGGmVzH8PiGvrZ7LyX3i2ZW1Hn+U8GtxpoB3ZxumuCpPL2HZqFE9gMD+
         awcGGuUpdzkmY6Uz7Sz18OruHiay76pEsl+H4q2X5JFlJuCr7oe1o9jnmZXz95u4w9EY
         h9r3TtAxTcPsFHxusBOPHTeHHmhZJjjdNLULy5nEN194R6fkR3B0peRBJEdv8ZJdymBD
         d/xl6xPD3wVkoe2J/NSnUyvHWyZ6sKRg6UIEvZ6aP0zcN5/PyV2EBqrB1gBXGTfjDjQT
         DwM0CBMh6McJAUa9gv/42DIwU3X52XYJXFQBbo26+gdvLlIOZ+11S41eJfUzl8Ju+8Gu
         WINw==
X-Gm-Message-State: AOJu0YzvnQLwtSLn67ikAFMQx/00NAA8Pm4MKqxH/JATZnQpnTxVLEh+
	nenALRfPFj7cfmG/w98vmBgTqSdYxKtZSFFVz7Xpme7n+qZI9zs/PKlD6Uq/h6kEr6axiCNzwWJ
	v/uibbAzvdN4On+x8GHl46nxiTnmymK0ySskGDS/T
X-Google-Smtp-Source: AGHT+IH09vHhB3eQd+rksJCjbNduGKVm1wu3qz4o6mf6KJHTxFERz9F41l7i/5jc3lVvd6E/UrkYd0CXUYApC6ro6p8=
X-Received: by 2002:adf:d046:0:b0:337:98e1:4682 with SMTP id
 v6-20020adfd046000000b0033798e14682mr1717578wrh.143.1705862454227; Sun, 21
 Jan 2024 10:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-9-ryncsn@gmail.com>
 <875y039utw.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7DkyZU0udhSUEfCMMT84Vad20UauXz9pzQp4c=cVFtiMw@mail.gmail.com>
 <87sf2z1hxt.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sf2z1hxt.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 22 Jan 2024 02:40:36 +0800
Message-ID: <CAMgjq7C9p-Et2jqyztLp2DHyG8AZrHCnNjXfHkbQrCMDVx-p_g@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] mm/swap: introduce a helper for swapin without vmfault
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 9:54=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C 09:11=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Kairui Song <ryncsn@gmail.com> writes:
> >>
> >> > From: Kairui Song <kasong@tencent.com>
> >> >
> >> > There are two places where swapin is not caused by direct anon page =
fault:
> >> > - shmem swapin, invoked indirectly through shmem mapping
> >> > - swapoff
> >> >
> >> > They used to construct a pseudo vmfault struct for swapin function.
> >> > Shmem has dropped the pseudo vmfault recently in commit ddc1a5cbc05d
> >> > ("mempolicy: alloc_pages_mpol() for NUMA policy without vma"). Swapo=
ff
> >> > path is still using one.
> >> >
> >> > Introduce a helper for them both, this help save stack usage for swa=
poff
> >> > path, and help apply a unified swapin cache and readahead policy che=
ck.
> >> >
> >> > Due to missing vmfault info, the caller have to pass in mempolicy
> >> > explicitly, make it different from swapin_entry and name it
> >> > swapin_entry_mpol.
> >> >
> >> > This commit convert swapoff to use this helper, follow-up commits wi=
ll
> >> > convert shmem to use it too.
> >> >
> >> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >> > ---
> >> >  mm/swap.h       |  9 +++++++++
> >> >  mm/swap_state.c | 40 ++++++++++++++++++++++++++++++++--------
> >> >  mm/swapfile.c   | 15 ++++++---------
> >> >  3 files changed, 47 insertions(+), 17 deletions(-)
> >> >
> >> > diff --git a/mm/swap.h b/mm/swap.h
> >> > index 9180411afcfe..8f790a67b948 100644
> >> > --- a/mm/swap.h
> >> > +++ b/mm/swap.h
> >> > @@ -73,6 +73,9 @@ struct folio *swap_cluster_readahead(swp_entry_t e=
ntry, gfp_t flag,
> >> >               struct mempolicy *mpol, pgoff_t ilx);
> >> >  struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
> >> >                           struct vm_fault *vmf, enum swap_cache_resu=
lt *result);
> >> > +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
> >> > +                             struct mempolicy *mpol, pgoff_t ilx,
> >> > +                             enum swap_cache_result *result);
> >> >
> >> >  static inline unsigned int folio_swap_flags(struct folio *folio)
> >> >  {
> >> > @@ -109,6 +112,12 @@ static inline struct folio *swapin_entry(swp_en=
try_t swp, gfp_t gfp_mask,
> >> >       return NULL;
> >> >  }
> >> >
> >> > +static inline struct page *swapin_entry_mpol(swp_entry_t entry, gfp=
_t gfp_mask,
> >> > +             struct mempolicy *mpol, pgoff_t ilx, enum swap_cache_r=
esult *result)
> >> > +{
> >> > +     return NULL;
> >> > +}
> >> > +
> >> >  static inline int swap_writepage(struct page *p, struct writeback_c=
ontrol *wbc)
> >> >  {
> >> >       return 0;
> >> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> >> > index 21badd4f0fc7..3edf4b63158d 100644
> >> > --- a/mm/swap_state.c
> >> > +++ b/mm/swap_state.c
> >> > @@ -880,14 +880,13 @@ static struct folio *swap_vma_readahead(swp_en=
try_t targ_entry, gfp_t gfp_mask,
> >> >   * in.
> >> >   */
> >> >  static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mas=
k,
> >> > -                               struct vm_fault *vmf, void *shadow)
> >> > +                                struct mempolicy *mpol, pgoff_t ilx=
,
> >> > +                                void *shadow)
> >> >  {
> >> > -     struct vm_area_struct *vma =3D vmf->vma;
> >> >       struct folio *folio;
> >> >
> >> > -     /* skip swapcache */
> >> > -     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> >> > -                             vma, vmf->address, false);
> >> > +     folio =3D (struct folio *)alloc_pages_mpol(gfp_mask, 0,
> >> > +                     mpol, ilx, numa_node_id());
> >> >       if (folio) {
> >> >               if (mem_cgroup_swapin_charge_folio(folio, NULL,
> >> >                                                  GFP_KERNEL, entry))=
 {
> >> > @@ -943,18 +942,18 @@ struct folio *swapin_entry(swp_entry_t entry, =
gfp_t gfp_mask,
> >> >               goto done;
> >> >       }
> >> >
> >> > +     mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> >> >       if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> >> > -             folio =3D swapin_direct(entry, gfp_mask, vmf, shadow);
> >> > +             folio =3D swapin_direct(entry, gfp_mask, mpol, ilx, sh=
adow);
> >> >               cache_result =3D SWAP_CACHE_BYPASS;
> >> >       } else {
> >> > -             mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &il=
x);
> >> >               if (swap_use_vma_readahead())
> >> >                       folio =3D swap_vma_readahead(entry, gfp_mask, =
mpol, ilx, vmf);
> >> >               else
> >> >                       folio =3D swap_cluster_readahead(entry, gfp_ma=
sk, mpol, ilx);
> >> > -             mpol_cond_put(mpol);
> >> >               cache_result =3D SWAP_CACHE_MISS;
> >> >       }
> >> > +     mpol_cond_put(mpol);
> >> >  done:
> >> >       if (result)
> >> >               *result =3D cache_result;
> >> > @@ -962,6 +961,31 @@ struct folio *swapin_entry(swp_entry_t entry, g=
fp_t gfp_mask,
> >> >       return folio;
> >> >  }
> >> >
> >> > +struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
> >> > +                             struct mempolicy *mpol, pgoff_t ilx,
> >> > +                             enum swap_cache_result *result)
> >> > +{
> >> > +     enum swap_cache_result cache_result;
> >> > +     void *shadow =3D NULL;
> >> > +     struct folio *folio;
> >> > +
> >> > +     folio =3D swap_cache_get_folio(entry, NULL, 0, &shadow);
> >> > +     if (folio) {
> >> > +             cache_result =3D SWAP_CACHE_HIT;
> >> > +     } else if (swap_use_no_readahead(swp_swap_info(entry), entry))=
 {
> >> > +             folio =3D swapin_direct(entry, gfp_mask, mpol, ilx, sh=
adow);
> >> > +             cache_result =3D SWAP_CACHE_BYPASS;
> >> > +     } else {
> >> > +             folio =3D swap_cluster_readahead(entry, gfp_mask, mpol=
, ilx);
> >> > +             cache_result =3D SWAP_CACHE_MISS;
> >> > +     }
> >> > +
> >> > +     if (result)
> >> > +             *result =3D cache_result;
> >> > +
> >> > +     return folio;
> >> > +}
> >> > +
> >> >  #ifdef CONFIG_SYSFS
> >> >  static ssize_t vma_ra_enabled_show(struct kobject *kobj,
> >> >                                    struct kobj_attribute *attr, char=
 *buf)
> >> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> > index 5aa44de11edc..2f77bf143af8 100644
> >> > --- a/mm/swapfile.c
> >> > +++ b/mm/swapfile.c
> >> > @@ -1840,18 +1840,13 @@ static int unuse_pte_range(struct vm_area_st=
ruct *vma, pmd_t *pmd,
> >> >       do {
> >> >               struct folio *folio;
> >> >               unsigned long offset;
> >> > +             struct mempolicy *mpol;
> >> >               unsigned char swp_count;
> >> >               swp_entry_t entry;
> >> > +             pgoff_t ilx;
> >> >               int ret;
> >> >               pte_t ptent;
> >> >
> >> > -             struct vm_fault vmf =3D {
> >> > -                     .vma =3D vma,
> >> > -                     .address =3D addr,
> >> > -                     .real_address =3D addr,
> >> > -                     .pmd =3D pmd,
> >> > -             };
> >> > -
> >> >               if (!pte++) {
> >> >                       pte =3D pte_offset_map(pmd, addr);
> >> >                       if (!pte)
> >> > @@ -1871,8 +1866,10 @@ static int unuse_pte_range(struct vm_area_str=
uct *vma, pmd_t *pmd,
> >> >               pte_unmap(pte);
> >> >               pte =3D NULL;
> >> >
> >> > -             folio =3D swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
> >> > -                                  &vmf, NULL);
> >> > +             mpol =3D get_vma_policy(vma, addr, 0, &ilx);
> >> > +             folio =3D swapin_entry_mpol(entry, GFP_HIGHUSER_MOVABL=
E,
> >> > +                                       mpol, ilx, NULL);
> >> > +             mpol_cond_put(mpol);
> >> >               if (!folio) {
> >> >                       /*
> >> >                        * The entry could have been freed, and will n=
ot
> >>
> >> IIUC, after the change, we will always use cluster readahead for
> >> swapoff.  This may be OK.  But, at least we need some test results whi=
ch
> >> show that this will not cause any issue for this behavior change.  And
> >> the behavior change should be described explicitly in patch descriptio=
n.
> >
> > Hi Ying
> >
> > Actually there is a swap_use_no_readahead check in swapin_entry_mpol,
> > so when readahaed is not needed (SYNC_IO), it's just skipped.
> >
> > And I think VMA readahead is not helpful swapoff, swapoff is already
> > walking the VMA, mostly uninterrupted in kernel space. With VMA
> > readahead or not, it will issue IO page by page.
> > The benchmark result I posted before is actually VMA readhead vs
> > no-readahead for ZRAM, sorry I didn't make it clear. It's obvious
> > no-readahead is faster.
> >
> > For actual block device, cluster readahead might be a good choice for
> > swapoff, since all pages will be read for swapoff, there has to be
> > enough memory for all swapcached page to stay in memory or swapoff
> > will fail anyway, and cluster read is faster for block devices.
>
> It's possible.  But please run the tests on some actual block devices
> and show your results.  Random memory accessing pattern should be
> tested, and the swap space usage should be > 50% to show some not so
> friendly situation.
>

Hi Ying,

I setup a test environment and did following test, and found that
cluster readahaed for swapoff is actually much worse in default setup:

1. Setup MySQL server using 2G memcg, with 28G buffer pool, and 24G NVME sw=
ap
2. Stress test with sysbench for 15min.
3. Remove the 2G memcg limit and swapoff.

Before this patch, swapoff will take about 9m.
After this patch, swapoff will take about 30m.

After some analysis I found the reason is that cluster readahead is
almost disabled (window =3D=3D 1 or 2) during swapoff, because it will
detect a very low hit rate on fragmented swap. But VMA readhead is
much more aggressive here since swapoff is walking the VMA, with a
very high hit rate.

But If I force cluster readahead to use a large window for swapoff,
the swapoff performance boost by a lot:
By adding following change in swap_cluster_readahead:

if (unlikely(!(si->flags & SWP_WRITEOK)))
    mask =3D max_t(unsigned long, 1 << READ_ONCE(page_cluster), PMD_SIZE
/ PAGE_SIZE) - 1;

The swapoff will take only 40s to finish, more than 10x faster than
the VMA readahead path (9m), because VMA readhead is still doing 4K
random IO just with a longer queue due to async readahead. But cluster
readhead will be doing 2M IO now.
I think PMD size window is good here since it still keep a balance
between good IO performance and the swapoff progress can still be
interrupted, and the system is responsible. And in most cases we
expect swapoff to success, if it fail, the RA windows should still
keep the side effect of extra swapcache being generated acceptable.

But this showed a bad effect of ignoring mem policy. Actually this is
not a new issue, cluster readhead is already violating VMA's mem
policy since it does readhead only based on entry value not VMA, the
entry being swapped in is not aware of which VMA it belongs.

And I was thinking, maybe we can just drop the mpol all the way, and
use the nid from page shadow to alloc pages, that may save a lot of
effort, and make cluster readhead more usable in general, also might
simplify a lot of code. How do you think? If this is acceptable, I
think I can send out a new series first and then rework this one
later.

