Return-Path: <linux-kernel+bounces-148982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BC98A8A14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F72E2830D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B543F171673;
	Wed, 17 Apr 2024 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ognPq+Ew"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB71487DE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374285; cv=none; b=rja1AP/BFWfgHA1pIhIPAeQLv4dbZXumgg2rbQZUaXGQ9EhwES9YQkXS/JpfyK2GNKSqTcHlWURWwxhXbWH9kcNMrIkIx6sXPVPbDi1hcbcHdLZ0W/wFfW+BjMZgcyVpNnsRI2LpYe5bW08qB9H278DIpAgeOGRT6lxqWgj2O9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374285; c=relaxed/simple;
	bh=1mxsPZgnGKGU7qT1MjD4wtwR9Im98k2ezxC8N06nZ2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rVsaJV0OE1XFYZJyACzvlGwxlRCdqo3L+Dva/234sVdHJIXI3lSArOguX1zqsRk1fMm8VaK9/Lcu05R2cc9iYB167EKkXxfz0Kx3RNg0VhOB+gPdnhFa5WYluUw9TdG7SPcL1vA+w4uTyPQJtHRnVg65dqkQ/90SH3/hjW/6B0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ognPq+Ew; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-434ed2e513dso18506791cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1713374283; x=1713979083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ge6pGSPn0Uuw9Wl7VGZm6zy1FRDKrs+Xgw3FaaawFgk=;
        b=ognPq+EwSu784CejCurGLLNQY8n2F236cV36Sn+eGce1rdiGDmYVsgEDslXkwlc3B0
         s9u4qtyN9Zub1HSp8VxYPGvr737Drds4PrTwgMVZErudYqk0/OVIAt1lavgYH6l/8Vgi
         cU/VImWENK9SCstM6ANzS2QLW2DgV4RNHaLN0WHKgI4+7JkYRPxo7J9NzZ6g9WAk+HVW
         epcov7f119TvQZBqXERvJLtno24ziC1AXiBW4bkRAPBA11QrOEOZlS9A3bbE6RTccvod
         +/X5a7X5yklLdPBw0UFcP1vjzMLsPgRLjS1gQs8O9rxXwlokOfJX4KmKeg9kSQ18B7EZ
         MYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374283; x=1713979083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ge6pGSPn0Uuw9Wl7VGZm6zy1FRDKrs+Xgw3FaaawFgk=;
        b=sCihbAD/P6ZcfPEwvsjF9jyyxt1qZ0+4B0KckuhrY7t0u5LnpIE3drFPEpEetRtZgZ
         FFmAXQ1vSx6lclkciM/7r34mWi2CR5wLu8O1cLUhmXKO5oGqszaU2B4N+YjCFXhOyK39
         J8soLNYPhiH5FRsKc3OhCn57+VEuR5hSnvFSAIPdtMwK3Gns94jw2oWAaexDBUP1wr1X
         Vj4ocV1XxcN9fktab5JJOubIWWW1uQ8Z4Wv1FeHVleQqCMrDTtpPrC6cCpUOtCzIedxE
         mv44pQzg1MH5PhhFal690R3IvmwTkbuZFkrVobgi7XICW7e9rU1948rwKnENdMjuQJPG
         XxWA==
X-Gm-Message-State: AOJu0YzIrkKi1XW1fqSxlU1uZwdQkfxSf2FIIin8ublLRScka2/YDPnG
	ykay8loR1TnIGvAxd4o0M7L/kFczSPhSkUZKmZ5sEIHVemsovaqxMBQzLUIfdQd7xzohBfouKS7
	MF6HklkCG9DgVDDL9YvGzm7uZX6b50BN+DZUA+Q==
X-Google-Smtp-Source: AGHT+IHjmc6rnhxHm5z1T/LOAQZV6fGKUJLqQpoEWSTZWCRmG16CaUcwe8GOES9wc6+B7vz0VYS79I6a9VIIeHWosBg=
X-Received: by 2002:ac8:590d:0:b0:436:d9cf:7da0 with SMTP id
 13-20020ac8590d000000b00436d9cf7da0mr104758qty.17.1713374282679; Wed, 17 Apr
 2024 10:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415205259.2535077-1-peterx@redhat.com> <CA+CK2bCSs8om+7tO_Sq2fAUD+gzD_4unUXMtO9oRUB+=4biv-Q@mail.gmail.com>
 <Zh_-j56_0RWxd33E@x1n>
In-Reply-To: <Zh_-j56_0RWxd33E@x1n>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Apr 2024 13:17:26 -0400
Message-ID: <CA+CK2bACyxNgFACfSu=3ro-nn-+PXCMf6Mug5G0G1oWpWabq4Q@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: Support userfault wr-protect entries
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nadav Amit <nadav.amit@gmail.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 12:53=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Tue, Apr 16, 2024 at 05:34:50PM -0400, Pasha Tatashin wrote:
> > Hi Peter,
>
> Pasha,
>
> >
> > Thanks for this patch, I like this extra checking logic, my comments be=
low:
>
> Thanks for taking a look.
>
> >
> > On Mon, Apr 15, 2024 at 4:53=E2=80=AFPM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > Allow page_table_check hooks to check over userfaultfd wr-protect cri=
teria
> > > upon pgtable updates.  The rule is no co-existance allowed for any wr=
itable
> > > flag against userfault wr-protect flag.
> > >
> > > This should be better than c2da319c2e, where we used to only sanitize=
 such
> > > issues during a pgtable walk, but when hitting such issue we don't ha=
ve a
> > > good chance to know where does that writable bit came from [1], so th=
at
> > > even the pgtable walk exposes a kernel bug (which is still helpful on
> > > triaging) but not easy to track and debug.
> > >
> > > Now we switch to track the source.  It's much easier too with the rec=
ent
> > > introduction of page table check.
> > >
> > > There are some limitations with using the page table check here for
> > > userfaultfd wr-protect purpose:
> > >
> > >   - It is only enabled with explicit enablement of page table check c=
onfigs
> > >   and/or boot parameters, but should be good enough to track at least
> > >   syzbot issues, as syzbot should enable PAGE_TABLE_CHECK[_ENFORCED] =
for
> > >   x86 [1].  We used to have DEBUG_VM but it's now off for most distro=
s,
> > >   while distros also normally not enable PAGE_TABLE_CHECK[_ENFORCED],=
 which
> > >   is similar.
> > >
> > >   - It conditionally works with the ptep_modify_prot API.  It will be
> > >   bypassed when e.g. XEN PV is enabled, however still work for most o=
f the
> > >   rest scenarios, which should be the common cases so should be good
> > >   enough.
> > >
> > >   - Hugetlb check is a bit hairy, as the page table check cannot iden=
tify
> > >   hugetlb pte or normal pte via trapping at set_pte_at(), because of =
the
> > >   current design where hugetlb maps every layers to pte_t... For exam=
ple,
> > >   the default set_huge_pte_at() can invoke set_pte_at() directly and =
lose
> > >   the hugetlb context, treating it the same as a normal pte_t. So far=
 it's
> > >   fine because we have huge_pte_uffd_wp() always equals to pte_uffd_w=
p() as
> > >   long as supported (x86 only).  It'll be a bigger problem when we'll
> > >   define _PAGE_UFFD_WP differently at various pgtable levels, because=
 then
> > >   one huge_pte_uffd_wp() per-arch will stop making sense first.. as o=
f now
> > >   we can leave this for later too.
> > >
> > > This patch also removes commit c2da319c2e altogether, as we have some=
thing
> > > better now.
> > >
> > > [1] https://lore.kernel.org/all/000000000000dce0530615c89210@google.c=
om/
> > >
> > > Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  arch/x86/include/asm/pgtable.h | 18 +-----------------
> > >  mm/page_table_check.c          | 32 +++++++++++++++++++++++++++++++-
> >
> > Please add the new logic to: Documentation/mm/page_table_check.rst
>
> Will do.
>
> >
> > >  2 files changed, 32 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pg=
table.h
> > > index 273f7557218c..65b8e5bb902c 100644
> > > --- a/arch/x86/include/asm/pgtable.h
> > > +++ b/arch/x86/include/asm/pgtable.h
> > > @@ -388,23 +388,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
> > >  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> > >  static inline int pte_uffd_wp(pte_t pte)
> > >  {
> > > -       bool wp =3D pte_flags(pte) & _PAGE_UFFD_WP;
> > > -
> > > -#ifdef CONFIG_DEBUG_VM
> > > -       /*
> > > -        * Having write bit for wr-protect-marked present ptes is fat=
al,
> > > -        * because it means the uffd-wp bit will be ignored and write=
 will
> > > -        * just go through.
> > > -        *
> > > -        * Use any chance of pgtable walking to verify this (e.g., wh=
en
> > > -        * page swapped out or being migrated for all purposes). It m=
eans
> > > -        * something is already wrong.  Tell the admin even before th=
e
> > > -        * process crashes. We also nail it with wrong pgtable setup.
> > > -        */
> > > -       WARN_ON_ONCE(wp && pte_write(pte));
> > > -#endif
> > > -
> > > -       return wp;
> > > +       return pte_flags(pte) & _PAGE_UFFD_WP;
> > >  }
> > >
> > >  static inline pte_t pte_mkuffd_wp(pte_t pte)
> > > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > > index af69c3c8f7c2..d4eb1212f0f5 100644
> > > --- a/mm/page_table_check.c
> > > +++ b/mm/page_table_check.c
> > > @@ -7,6 +7,8 @@
> > >  #include <linux/kstrtox.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/page_table_check.h>
> > > +#include <linux/swap.h>
> > > +#include <linux/swapops.h>
> > >
> > >  #undef pr_fmt
> > >  #define pr_fmt(fmt)    "page_table_check: " fmt
> > > @@ -182,6 +184,23 @@ void __page_table_check_pud_clear(struct mm_stru=
ct *mm, pud_t pud)
> > >  }
> > >  EXPORT_SYMBOL(__page_table_check_pud_clear);
> > >
> > > +/* Whether the swap entry cached writable information */
> > > +static inline bool swap_cached_writable(swp_entry_t entry)
> > > +{
> > > +       unsigned type =3D swp_type(entry);
> > > +
> > > +       return type =3D=3D SWP_DEVICE_EXCLUSIVE_WRITE ||
> > > +           type =3D=3D SWP_MIGRATION_WRITE;
> > > +}
> > > +
> > > +static inline void __page_table_check_pte(pte_t pte)
> >
> > may be something like:
> > page_table_check_new_pte() ? Naming is starting to get confusing. The
> > idea for this function is to check the pte that is about to be set
> > into the page table.
>
> But then we keep __page_table_check_ptes_set() as is?
>
> It feels more natural if we keep using those underscores if all the rest
> does so.  The "_new" is also not matching with what you used to have as

In mm/page_table_check.c, function names with an underscore prefix are
intended for global symbols with internal use only. All local
functions, such as page_table_check_set() and
page_table_check_clear(), do not have this prefix as we do not pollute
the global namespace.

> "_set".  If you see that's how I carefully chose the current name, with t=
he
> hope to match everything..
>
> No strong opinions on these, but let me know your final choice of such
> name.  I'm happy to align that to your preference.
>
> >
> > > +{
> > > +       if (pte_present(pte) && pte_uffd_wp(pte))
> > > +               WARN_ON_ONCE(pte_write(pte));
> > > +       else if (is_swap_pte(pte) && pte_swp_uffd_wp(pte))
> > > +               WARN_ON_ONCE(swap_cached_writable(pte_to_swp_entry(pt=
e)));
> > > +}
> > > +
> > >  void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, =
pte_t pte,
> > >                 unsigned int nr)
> > >  {
> > > @@ -190,18 +209,29 @@ void __page_table_check_ptes_set(struct mm_stru=
ct *mm, pte_t *ptep, pte_t pte,
> > >         if (&init_mm =3D=3D mm)
> > >                 return;
> > >
> > > -       for (i =3D 0; i < nr; i++)
> > > +       for (i =3D 0; i < nr; i++) {
> > > +               __page_table_check_pte(pte);
> >
> > This should really be called only once after this loop.
>
> This is also my intention to keep it in the loop just to make it as gener=
ic
> e.g. to have no assumption of "ignoring PFNs", and I didn't worry on perf
> much as we'll read/write these ptes anyway, also because it's only enable=
d
> for debugging kernels.
>
> But I made it at least inaccurate by checking pte not *ptep..
> How about I move it out, rename it to __page_table_check_pte_flags(pte)?

Sounds good. I like:
 page_table_check_pte_flags()
 page_table_check_pmd_flags()

Pasha

