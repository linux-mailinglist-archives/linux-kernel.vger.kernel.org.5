Return-Path: <linux-kernel+bounces-146234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C58F8A6281
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC8F1C21475
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A82D627;
	Tue, 16 Apr 2024 04:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY6oUkE2"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D6171D2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242422; cv=none; b=i757n8wTZDWe9p5hDZfxEnLY5otFg5E06TkhadOxMgdaw+qp6+qI2+HkxptWiufR/HTRr8xB9G63mk5aWJOxBo9JIUIdnCu2z+JRBZtM1a+goyvJ66YRzqMvIlj6HH2wlMDGeF48zW9r1sXCbjRKU91GpECnWtwTJHZdrs/50uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242422; c=relaxed/simple;
	bh=EKnhHQ3qPynxgcPwoGbvVEowY3HQDQRtS01uGC8DDs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJ/ZJzIS5zr9+pIlKvAzy9vZLZEyMdPApsgQ4q7URBKE+vJgHZSVzJM1GMoyqG8/D0Ew3zkx44fk0fSRVPlgoIVwVO8pDqYSfMyOb0YA/DxaqG8CBioHiMCegOW7iBXagl+X3H3+wY5up2/L2iRt2Si80Zwk+nkETqoh7N/wUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WY6oUkE2; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4daab3cf090so2142499e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 21:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713242419; x=1713847219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DNUNm1nTQTzvmw64PZzPb0ANLIFLIl6nmYK+uOcBCY=;
        b=WY6oUkE2DQEWcnQqwVmQ34em2cml/FUzTz1206NnpOHEpl9xDKsgT+eETFjNIvAR6V
         ujiGnIl46VMu7v/B81SoKh/pI8FotdRWuGr7O9P+YnhChyEKS7nBid4kiG7H2Da3C0SP
         B/RIMmxYxFLcqHxz1fkNyU3e8Oycvp4GuBOyp5+2yjNicUufSqpQ0hLGsrYIKIajGiRS
         Za93FmAuvQLV2rEL2j9xhRwBC+Sbfb51BZZemsDMBQ7GSrGawvDxyevSEVZp3q9emP2X
         8HSRN610nZAQTpaa4iNU2U1uG0ccozwJ5EHnXKxdfa+M9rbnZzOjfqYw8biS6peI7vM6
         w9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713242419; x=1713847219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DNUNm1nTQTzvmw64PZzPb0ANLIFLIl6nmYK+uOcBCY=;
        b=mzLUn75jlVs+ee6aq8ksI5oR/EDuJQrJ7N0/tfxWx1trKP66F3ewK0dZdCDeA536XP
         aVwqW2XpkP34CvjavPtAv2D2fy/McH+pJ6mdiAXOMLHIh9FD21VfmGkxosVCiQHIB+NA
         Yo/7P+vZqu7dSrIxzYrFT7fADICM9qM1olBLlV36JReiURUsvrMsrJNF+GbgE8l/CwWR
         dEFcwa6cO6DS2OXeu90OpDBw4TwzA+C7CG/Lg/ZvBGKnAE7LpPCf9c/HNl/u0T0eQuw7
         x4YIz3xOTE/wKojsfKEhUayYtV4DIosfYloqm1TiqYbsg7HLGvqpWWjmZth40Wpy9G7u
         qIvw==
X-Forwarded-Encrypted: i=1; AJvYcCUPHDerfH1YVfBvhLWgbHuy19DrT2ndR7Zo2oqLgujrzFQ1R2LSYvsvnWkTfXD4czj/jejI4HNkOIV1o96N+QUVpNPm8DTSFVb2mbTF
X-Gm-Message-State: AOJu0YzkdwxNtDjTdcAfJxc2QRUjqWkwf2nDFVCf/A/U6cp9X2Oq+KeI
	0IeL+QvsCrsaHIyc6F4Qk2zBKVsGDzDjsPq5FMnW3YGzyr/Dq6ne7LKNfl+mD8Th5uUTDLD6T6X
	riH/g40VkLCQw30N/Y0qpJUoyqrU=
X-Google-Smtp-Source: AGHT+IFYyNyG43lazOLMtibqNC/p6+JtCDmf8y2Uyn7ZB9V4TTE49O/qma2mk0uajdyxjsyuCxHN4gT4dtoFPo7T9oI=
X-Received: by 2002:a05:6122:c84:b0:4d3:34f4:7e99 with SMTP id
 ba4-20020a0561220c8400b004d334f47e99mr590473vkb.0.1713242419205; Mon, 15 Apr
 2024 21:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-5-21cnbao@gmail.com>
 <87frvn2f89.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4x_bOchG=bJjR8WE=vQxu3ke8fkxcDOFhqX5FS_a-0heA@mail.gmail.com>
 <8734rm2gdj.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xHVN_QXu5Q8c_FcjsnffZYWsjOx4KR4G_2GNyaxfVWAw@mail.gmail.com>
 <87y19e115l.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xUna=wNNoLw0yCkzjD1d0pfJDKfqmWuA5zrSzWF+-cow@mail.gmail.com>
 <87pluq0zdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87pluq0zdr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 16 Apr 2024 16:40:08 +1200
Message-ID: <CAGsJ_4x5FJrpGLzvrEZ-mgWiSUVaO-41h6Dcy7VGyaMMC8Tmng@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: swap: entirely map large folios found in swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 3:19=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Tue, Apr 16, 2024 at 2:41=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Tue, Apr 16, 2024 at 2:27=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >>
> >> >> Added Khalid for arch_do_swap_page().
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Mon, Apr 15, 2024 at 8:39=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> [snip]
> >> >>
> >> >> >>
> >> >> >> > +     bool any_swap_shared =3D false;
> >> >> >> >
> >> >> >> >       if (!pte_unmap_same(vmf))
> >> >> >> >               goto out;
> >> >> >> > @@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault=
 *vmf)
> >> >> >> >        */
> >> >> >> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, v=
mf->address,
> >> >> >> >                       &vmf->ptl);
> >> >> >>
> >> >> >> We should move pte check here.  That is,
> >> >> >>
> >> >> >>         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), =
vmf->orig_pte)))
> >> >> >>                 goto out_nomap;
> >> >> >>
> >> >> >> This will simplify the situation for large folio.
> >> >> >
> >> >> > the plan is moving the whole code block
> >> >> >
> >> >> > if (start_pte && folio_test_large(folio) && folio_test_swapcache(=
folio))
> >> >> >
> >> >> > after
> >> >> >         if (unlikely(!folio_test_uptodate(folio))) {
> >> >> >                 ret =3D VM_FAULT_SIGBUS;
> >> >> >                 goto out_nomap;
> >> >> >         }
> >> >> >
> >> >> > though we couldn't be !folio_test_uptodate(folio)) for hitting
> >> >> > swapcache but it seems
> >> >> > logically better for future use.
> >> >>
> >> >> LGTM, Thanks!
> >> >>
> >> >> >>
> >> >> >> > +
> >> >> >> > +     /* We hit large folios in swapcache */
> >> >> >>
> >> >> >> The comments seems unnecessary because the code tells that alrea=
dy.
> >> >> >>
> >> >> >> > +     if (start_pte && folio_test_large(folio) && folio_test_s=
wapcache(folio)) {
> >> >> >> > +             int nr =3D folio_nr_pages(folio);
> >> >> >> > +             int idx =3D folio_page_idx(folio, page);
> >> >> >> > +             unsigned long folio_start =3D vmf->address - idx=
 * PAGE_SIZE;
> >> >> >> > +             unsigned long folio_end =3D folio_start + nr * P=
AGE_SIZE;
> >> >> >> > +             pte_t *folio_ptep;
> >> >> >> > +             pte_t folio_pte;
> >> >> >> > +
> >> >> >> > +             if (unlikely(folio_start < max(vmf->address & PM=
D_MASK, vma->vm_start)))
> >> >> >> > +                     goto check_pte;
> >> >> >> > +             if (unlikely(folio_end > pmd_addr_end(vmf->addre=
ss, vma->vm_end)))
> >> >> >> > +                     goto check_pte;
> >> >> >> > +
> >> >> >> > +             folio_ptep =3D vmf->pte - idx;
> >> >> >> > +             folio_pte =3D ptep_get(folio_ptep);
> >> >> >>
> >> >> >> It's better to construct pte based on fault PTE via generalizing
> >> >> >> pte_next_swp_offset() (may be pte_move_swp_offset()).  Then we c=
an find
> >> >> >> inconsistent PTEs quicker.
> >> >> >
> >> >> > it seems your point is getting the pte of page0 by pte_next_swp_o=
ffset()
> >> >> > unfortunately pte_next_swp_offset can't go back. on the other han=
d,
> >> >> > we have to check the real pte value of the 0nd entry right now be=
cause
> >> >> > swap_pte_batch() only really reads pte from the 1st entry. it ass=
umes
> >> >> > pte argument is the real value for the 0nd pte entry.
> >> >> >
> >> >> > static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, p=
te_t pte)
> >> >> > {
> >> >> >         pte_t expected_pte =3D pte_next_swp_offset(pte);
> >> >> >         const pte_t *end_ptep =3D start_ptep + max_nr;
> >> >> >         pte_t *ptep =3D start_ptep + 1;
> >> >> >
> >> >> >         VM_WARN_ON(max_nr < 1);
> >> >> >         VM_WARN_ON(!is_swap_pte(pte));
> >> >> >         VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
> >> >> >
> >> >> >         while (ptep < end_ptep) {
> >> >> >                 pte =3D ptep_get(ptep);
> >> >> >
> >> >> >                 if (!pte_same(pte, expected_pte))
> >> >> >                         break;
> >> >> >
> >> >> >                 expected_pte =3D pte_next_swp_offset(expected_pte=
);
> >> >> >                 ptep++;
> >> >> >         }
> >> >> >
> >> >> >         return ptep - start_ptep;
> >> >> > }
> >> >>
> >> >> Yes.  You are right.
> >> >>
> >> >> But we may check whether the pte of page0 is same as "vmf->orig_pte=
 -
> >> >> folio_page_idx()" (fake code).
> >> >
> >> > right, that is why we are reading and checking PTE0 before calling
> >> > swap_pte_batch()
> >> > right now.
> >> >
> >> >   folio_ptep =3D vmf->pte - idx;
> >> >   folio_pte =3D ptep_get(folio_ptep);
> >> >   if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_entry(fol=
io_pte)) ||
> >> >       swap_pte_batch(folio_ptep, nr, folio_pte, &any_swap_shared) !=
=3D nr)
> >> >    goto check_pte;
> >> >
> >> > So, if I understand correctly, you're proposing that we should direc=
tly check
> >> > PTE0 in swap_pte_batch(). Personally, I don't have any objections to=
 this idea.
> >> > However, I'd also like to hear the feedback from Ryan and David :-)
> >>
> >> I mean that we can replace
> >>
> >>         !is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_entry(fol=
io_pte))
> >>
> >> in above code with pte_same() with constructed expected first pte.
> >
> > Got it. It could be quite tricky, especially with considerations like
> > pte_swp_soft_dirty, pte_swp_exclusive, and pte_swp_uffd_wp. We might
> > require a helper function similar to pte_next_swp_offset() but capable =
of
> > moving both forward and backward. For instance:
> >
> > pte_move_swp_offset(pte_t pte, long delta)
> >
> > pte_next_swp_offset can insteadly call it by:
> > pte_move_swp_offset(pte, 1);
> >
> > Is it what you are proposing?
>
> Yes.  Exactly.

Great. I agree that this appears to be much cleaner than the current code.

>
> --
> Best Regards,
> Huang, Ying
>
> >>
> >> >>
> >> >> You need to check the pte of page 0 anyway.
> >> >>
> >> >> >>
> >> >> >> > +             if (!is_swap_pte(folio_pte) || non_swap_entry(pt=
e_to_swp_entry(folio_pte)) ||
> >> >> >> > +                 swap_pte_batch(folio_ptep, nr, folio_pte, &a=
ny_swap_shared) !=3D nr)
> >> >> >> > +                     goto check_pte;
> >> >> >> > +
> >> >> >> > +             start_address =3D folio_start;
> >> >> >> > +             start_pte =3D folio_ptep;
> >> >> >> > +             nr_pages =3D nr;
> >> >> >> > +             entry =3D folio->swap;
> >> >> >> > +             page =3D &folio->page;
> >> >> >> > +     }
> >> >> >> > +
> >> >> >> > +check_pte:
> >> >> >> >       if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), =
vmf->orig_pte)))
> >> >> >> >               goto out_nomap;
> >> >> >> >
> >> >> >> > @@ -4190,6 +4223,10 @@ vm_fault_t do_swap_page(struct vm_fault=
 *vmf)
> >> >> >> >                        */
> >> >> >> >                       exclusive =3D false;
> >> >> >> >               }
> >> >> >> > +
> >> >> >> > +             /* Reuse the whole large folio iff all entries a=
re exclusive */
> >> >> >> > +             if (nr_pages > 1 && any_swap_shared)
> >> >> >> > +                     exclusive =3D false;
> >> >> >> >       }
> >> >> >> >
> >>
> >> [snip]
> >>
> >> --
> >> Best Regards,
> >> Huang, Ying

