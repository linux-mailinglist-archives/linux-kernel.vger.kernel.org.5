Return-Path: <linux-kernel+bounces-149084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF18A8BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E931F22720
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16361224C9;
	Wed, 17 Apr 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="hNixHriy"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AD171A5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379948; cv=none; b=GtQKxQV4kRjoiUujjlb7AidQ5wx+BpV9orJT+Q6fIu7owMwyEOZ2lIjrynfMYBvr+6RYWARMr8q32jiDPqTNYZsIyedwx38UhuvaZ+04tBdfkPWXeYmiWTpvhreX8xcksN8w5OUBA0ryVxvDz2I4SAlVo/qDilxUYMj5a8Iwqsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379948; c=relaxed/simple;
	bh=L6ByHLhFvvuUwfUwx7O7Ew9ERmtwxGGu8oQKQCadNto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvp1oxa6fckF0qyi4EHqpVFKjeSdX+mu3Irq7WdIv/3SpXmYi4bYGyrBePnnuaYvUA609z7GQonmoe5TJEGN15CCA0c0jOUwM1TxFpR3zdtCBmpJwPGSVFZS5pKnJpc/E3njgd6cKJgr1EXLyhHSEOuIedKBf/L4thjPiBluqAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=hNixHriy; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4373f17a39dso12570431cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1713379945; x=1713984745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYY7Lz3nOoOLfIfGCItn7CVOAZGQHNOlGWi+/nIv2kg=;
        b=hNixHriyVVJczC+Xe1QZvb8Kx/cpAKDdT1kGK4EBPUvojIfTEEeDZgqPm9waikyaF9
         M+R5xcIdHAPfys1J0ppk53/BgymRdhcLX2M3TgyChWvIUAXG00yFrytv4+g2RLdagphJ
         0oY3rJJYkSTycLXLp3q8eRSNoysqq/iOk0CMpgaF0sdyw5PDeVLYq2SMteAsTj8prirb
         H+XI4q8jG+uMglnxH42q3vDJhmuLeKdoOxFsiw/Bhb2R/OBPo77d4/NJv3ytHQTUtjHb
         4E2qCiWCyybsTU/WueVruILcPWgv4WKSxb+EevTyn2lVrK2tduwgSlMG5qz7FvCvVAh+
         Sr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379945; x=1713984745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYY7Lz3nOoOLfIfGCItn7CVOAZGQHNOlGWi+/nIv2kg=;
        b=NUoL98GgEZJo/mGDW84HaUp3dDtGaCpc7+mQ04xb4Q+M+4TikZSMCRT2gfPWBYtcfj
         KmKE/RI6N1dk3pbRmuf7n9pr8Ex1OotCy+FXKg0/5KNzKdynCaYhSAqByQap6ws4mhmY
         7+styCag+WEuAsaV5wU3kiLwvEKqno3SmhjE6O1ralyxXtPqNq0nM18HaTpbaho+yljS
         S9EwqvvM3JLZ2TI6xBps/wfGUNwIe3bM9ro+y0IbB8x1Z30h9ot3drOwr9PUQ8D5SdhV
         7kdW0/CdXCQ5hJILDprLkM164P7lw/TmA4k/lxG8zLp3/qV9kc6MBJ8KoKVb7b7nIcIy
         Sirg==
X-Gm-Message-State: AOJu0YxUPXh6NGg6/L3TLe602TMlWGjvo+EBS9GSHI4qGf36ANxWBwkm
	RjUt+42+yJRKuh8PVnTr7i9NAbDfMVnRhqYLwBrvR7cl++Tp/sELzvc3j8CJwB/M8Ieg2hkGJ3K
	Md2kajC9w4vj6q8frAezQY6+xvCiuvouVSce4Xw==
X-Google-Smtp-Source: AGHT+IGEMcT+kNQWgvtNK+axIqQJUbJoPiQNPKJwzNdYAJVbhAlhbREAAzlJ+GHf0YdHgFHJ5RGTkjuImP1NIMEbenA=
X-Received: by 2002:ac8:5909:0:b0:434:a5c9:b8e8 with SMTP id
 9-20020ac85909000000b00434a5c9b8e8mr378901qty.54.1713379944999; Wed, 17 Apr
 2024 11:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415205259.2535077-1-peterx@redhat.com> <CA+CK2bCSs8om+7tO_Sq2fAUD+gzD_4unUXMtO9oRUB+=4biv-Q@mail.gmail.com>
 <Zh_-j56_0RWxd33E@x1n> <CA+CK2bACyxNgFACfSu=3ro-nn-+PXCMf6Mug5G0G1oWpWabq4Q@mail.gmail.com>
In-Reply-To: <CA+CK2bACyxNgFACfSu=3ro-nn-+PXCMf6Mug5G0G1oWpWabq4Q@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Apr 2024 14:51:48 -0400
Message-ID: <CA+CK2bCr0eb+tc-Hp8Gqjsor4C9vpcGB2y1zhPORTAX=phhzig@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: Support userfault wr-protect entries
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Nadav Amit <nadav.amit@gmail.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:17=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Apr 17, 2024 at 12:53=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> >
> > On Tue, Apr 16, 2024 at 05:34:50PM -0400, Pasha Tatashin wrote:
> > > Hi Peter,
> >
> > Pasha,
> >
> > >
> > > Thanks for this patch, I like this extra checking logic, my comments =
below:
> >
> > Thanks for taking a look.
> >
> > >
> > > On Mon, Apr 15, 2024 at 4:53=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> > > >
> > > > Allow page_table_check hooks to check over userfaultfd wr-protect c=
riteria
> > > > upon pgtable updates.  The rule is no co-existance allowed for any =
writable
> > > > flag against userfault wr-protect flag.
> > > >
> > > > This should be better than c2da319c2e, where we used to only saniti=
ze such
> > > > issues during a pgtable walk, but when hitting such issue we don't =
have a
> > > > good chance to know where does that writable bit came from [1], so =
that
> > > > even the pgtable walk exposes a kernel bug (which is still helpful =
on
> > > > triaging) but not easy to track and debug.
> > > >
> > > > Now we switch to track the source.  It's much easier too with the r=
ecent
> > > > introduction of page table check.
> > > >
> > > > There are some limitations with using the page table check here for
> > > > userfaultfd wr-protect purpose:
> > > >
> > > >   - It is only enabled with explicit enablement of page table check=
 configs
> > > >   and/or boot parameters, but should be good enough to track at lea=
st
> > > >   syzbot issues, as syzbot should enable PAGE_TABLE_CHECK[_ENFORCED=
] for
> > > >   x86 [1].  We used to have DEBUG_VM but it's now off for most dist=
ros,
> > > >   while distros also normally not enable PAGE_TABLE_CHECK[_ENFORCED=
], which
> > > >   is similar.
> > > >
> > > >   - It conditionally works with the ptep_modify_prot API.  It will =
be
> > > >   bypassed when e.g. XEN PV is enabled, however still work for most=
 of the
> > > >   rest scenarios, which should be the common cases so should be goo=
d
> > > >   enough.
> > > >
> > > >   - Hugetlb check is a bit hairy, as the page table check cannot id=
entify
> > > >   hugetlb pte or normal pte via trapping at set_pte_at(), because o=
f the
> > > >   current design where hugetlb maps every layers to pte_t... For ex=
ample,
> > > >   the default set_huge_pte_at() can invoke set_pte_at() directly an=
d lose
> > > >   the hugetlb context, treating it the same as a normal pte_t. So f=
ar it's
> > > >   fine because we have huge_pte_uffd_wp() always equals to pte_uffd=
_wp() as
> > > >   long as supported (x86 only).  It'll be a bigger problem when we'=
ll
> > > >   define _PAGE_UFFD_WP differently at various pgtable levels, becau=
se then
> > > >   one huge_pte_uffd_wp() per-arch will stop making sense first.. as=
 of now
> > > >   we can leave this for later too.
> > > >
> > > > This patch also removes commit c2da319c2e altogether, as we have so=
mething
> > > > better now.
> > > >
> > > > [1] https://lore.kernel.org/all/000000000000dce0530615c89210@google=
com/
> > > >
> > > > Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  arch/x86/include/asm/pgtable.h | 18 +-----------------
> > > >  mm/page_table_check.c          | 32 ++++++++++++++++++++++++++++++=
+-
> > >
> > > Please add the new logic to: Documentation/mm/page_table_check.rst
> >
> > Will do.
> >
> > >
> > > >  2 files changed, 32 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/=
pgtable.h
> > > > index 273f7557218c..65b8e5bb902c 100644
> > > > --- a/arch/x86/include/asm/pgtable.h
> > > > +++ b/arch/x86/include/asm/pgtable.h
> > > > @@ -388,23 +388,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
> > > >  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
> > > >  static inline int pte_uffd_wp(pte_t pte)
> > > >  {
> > > > -       bool wp =3D pte_flags(pte) & _PAGE_UFFD_WP;
> > > > -
> > > > -#ifdef CONFIG_DEBUG_VM
> > > > -       /*
> > > > -        * Having write bit for wr-protect-marked present ptes is f=
atal,
> > > > -        * because it means the uffd-wp bit will be ignored and wri=
te will
> > > > -        * just go through.
> > > > -        *
> > > > -        * Use any chance of pgtable walking to verify this (e.g., =
when
> > > > -        * page swapped out or being migrated for all purposes). It=
 means
> > > > -        * something is already wrong.  Tell the admin even before =
the
> > > > -        * process crashes. We also nail it with wrong pgtable setu=
p.
> > > > -        */
> > > > -       WARN_ON_ONCE(wp && pte_write(pte));
> > > > -#endif
> > > > -
> > > > -       return wp;
> > > > +       return pte_flags(pte) & _PAGE_UFFD_WP;
> > > >  }
> > > >
> > > >  static inline pte_t pte_mkuffd_wp(pte_t pte)
> > > > diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> > > > index af69c3c8f7c2..d4eb1212f0f5 100644
> > > > --- a/mm/page_table_check.c
> > > > +++ b/mm/page_table_check.c
> > > > @@ -7,6 +7,8 @@
> > > >  #include <linux/kstrtox.h>
> > > >  #include <linux/mm.h>
> > > >  #include <linux/page_table_check.h>
> > > > +#include <linux/swap.h>
> > > > +#include <linux/swapops.h>
> > > >
> > > >  #undef pr_fmt
> > > >  #define pr_fmt(fmt)    "page_table_check: " fmt
> > > > @@ -182,6 +184,23 @@ void __page_table_check_pud_clear(struct mm_st=
ruct *mm, pud_t pud)
> > > >  }
> > > >  EXPORT_SYMBOL(__page_table_check_pud_clear);
> > > >
> > > > +/* Whether the swap entry cached writable information */
> > > > +static inline bool swap_cached_writable(swp_entry_t entry)
> > > > +{
> > > > +       unsigned type =3D swp_type(entry);
> > > > +
> > > > +       return type =3D=3D SWP_DEVICE_EXCLUSIVE_WRITE ||
> > > > +           type =3D=3D SWP_MIGRATION_WRITE;

This breaks linux-next build:

mm/page_table_check.c: In function =E2=80=98swap_cached_writable=E2=80=99:
mm/page_table_check.c:192:24: error: =E2=80=98SWP_DEVICE_EXCLUSIVE_WRITE=E2=
=80=99
undeclared (first use in this function)
  192 |         return type =3D=3D SWP_DEVICE_EXCLUSIVE_WRITE ||
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
mm/page_table_check.c:192:24: note: each undeclared identifier is
reported only once for each function it appears in
mm/page_table_check.c:194:1: error: control reaches end of non-void
function [-Werror=3Dreturn-type]
  194 | }

Looks like there is a dependence on CONFIG_DEVICE_PRIVATE.

Pasha

