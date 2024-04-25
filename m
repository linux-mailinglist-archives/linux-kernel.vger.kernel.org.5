Return-Path: <linux-kernel+bounces-158285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6C68B1DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74F2B2804B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509AC84D29;
	Thu, 25 Apr 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agv5DHl9"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6337140
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036885; cv=none; b=i3oe28HaqKgiGguNlnNmNE6BreNt6GlF62dA64DFi1EgzcXQA9CaMxPhTWxj2I9g7CMatZxHXzbugsGlN37gSLGOKfW9PLJFPIQrdNGJRVlqB9lwhW8NvJP0nUfCAhSrl4VTT/GbMk70+h9kPtwNIZyccwikaIyTGf31i3lFVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036885; c=relaxed/simple;
	bh=w/74jurbDuepqPsA7RpgfY+QKH7zt6UX7ATRPYhZHb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhad8hfUSolpGAiI7+mNXlgeBsij+Mvg04fumCDzSHT47yQorANLA/GfmQtVn0AMzyyJrPg2S/pSTLtWZzE1SHYx5awcno7JkO8tZmXJ/jkqKAYg070SXx1hzaCn+NvDFmZt/fC4gLnCv6EUxPhhQmHcYD6IMD1OibF+kzm0EdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agv5DHl9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e4a148aeeso235104a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714036882; x=1714641682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE8GiAVvHFw1cHCNgHzSoH9bicMfpW/mOredZ8/si0Q=;
        b=agv5DHl9oz6Md+R9Vf6D3LyptC/GollZ305ZMzMzzhCACqU8QA44khEbgltOYRseUB
         y74gzYn4nn2azBiQil4raCQhpMV+10gVdQzLjQ4JlIDrWvqA1obr/bLhwYMRNNsa8J6H
         zFqx5UfOxuXxpT9cBi/WKArIgAHlS4dPwpz6Rff6VrhVpWnKnPm20KwDGMTCkc13lWga
         nhSpCmeTlqS+CbotYf5NDxTEkUKcRonGzWrMosTvLWSj5exOSxl/0/OKU8KHKp9a6Gq5
         QB0xB6KP7v7FvuE9NEe0SaXzv2XsZB+RDP5G3zF81S9gJYI4zCYqUieMwyYm/3EhmmCe
         0idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714036882; x=1714641682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KE8GiAVvHFw1cHCNgHzSoH9bicMfpW/mOredZ8/si0Q=;
        b=DCuCnXlcK9mwXagX+YkooQvK40nBRJn3bImwTWTeGLcsm8R+W0YRhyYm6ekw1mTe5B
         WbUnFFNa9yMtbiQed4YSZvXhZlEHzIk6nSUCZsV7n4zZCbX0M6t5d66nUGEzpqexAHKS
         wEi0V2nmdecHpHxTRqKECncnwIy3jUmLWkWFqSYx2mbSqMcSook4WGUz5ZZjxVpsmpVU
         /S8TsHj5rKTeblU7ga/3yY49ZpsQ676zQWfZ3xPz04VzsDSqabrc0vs3tZEdw26XWiUG
         fyjGRllUEM57prLCtLSyiy2nOJUi/qjP7C8GrQxvmmf6y/7O/2/kUBJN7zgmphcSJEB1
         KHRw==
X-Forwarded-Encrypted: i=1; AJvYcCWgJ5NRfKedhEbH9wtkvsZz5Rio7E1wT9DE9kaDa1M3ZCpjEfF502fw0b81Lks0N75iNi9DhFMId6CCGFf5vHnDoIwsUzKi3DHYWsNS
X-Gm-Message-State: AOJu0YzXmzOO61UBwdr32YeY2t9THmgNU6RjZdtOk4O0RbFnqKmv2Y2N
	4tyfWfHF1s5u9Nqn5rjXgJ16aoHyBFOK9/ze+MJvrgVTdcGbh8yTRm7UaIT6uHO1UyFq9Lizw2n
	t+Fg21ewU2GHHq6Uo/Q94vi5Eq/k=
X-Google-Smtp-Source: AGHT+IFbERbEp9rBfe6jSoAxhQSJYvCOlvBJXZKbDQHeqNYLmeZpToIT2lAlLtHPkX8AQOwLRu29uaWEgQWZ9T45fFI=
X-Received: by 2002:a50:d542:0:b0:570:5b9c:3f25 with SMTP id
 f2-20020a50d542000000b005705b9c3f25mr2342825edj.26.1714036881928; Thu, 25 Apr
 2024 02:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK1f24nb6FkipH3OZa0uwbBWkefS3f2BrJ_GTxkS2j6+6bgODQ@mail.gmail.com>
 <20240425085051.74889-1-ioworker0@gmail.com> <49394660-8455-48ec-8ae1-fbd2d590d27a@redhat.com>
In-Reply-To: <49394660-8455-48ec-8ae1-fbd2d590d27a@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 17:21:10 +0800
Message-ID: <CAK1f24kaphS9Gz4Nxe-+=iHs_+CpA1Qk7q=pdzUJKc5u-0_qXw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
To: David Hildenbrand <david@redhat.com>
Cc: ziy@nvidia.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	fengwei.yin@intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maskray@google.com, mhocko@suse.com, minchan@kernel.org, peterx@redhat.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, songmuchun@bytedance.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiehuan09@gmail.com, 
	zokeefe@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:01=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 25.04.24 10:50, Lance Yang wrote:
> > Hey Zi, David,
>
> Hi,
>
> >
> > How about this change(diff against mm-unstable) as follows?
>
> goes into the right direction, please resent the whole thing, that will
> make it easier to review.

Got it. I=E2=80=98ll keep that in mind, thanks!

>
> >
> > I'd like to add __try_to_unmap_huge_pmd() as a new internal function
> > specifically for unmapping PMD-mapped folios. If, for any reason, we ca=
nnot
> > unmap the folio, then we'll still split it as previously done.
> >
> > Currently, __try_to_unmap_huge_pmd() only handles lazyfree THPs, but it
> > can be extended to support other large folios that are PMD-mapped in th=
e
> > future if needed.
> >
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index 670218f762c8..0f906dc6d280 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -100,8 +100,6 @@ enum ttu_flags {
> >                                        * do a final flush if necessary =
*/
> >       TTU_RMAP_LOCKED         =3D 0x80, /* do not grab rmap lock:
> >                                        * caller holds it */
> > -     TTU_LAZYFREE_THP        =3D 0x100, /* avoid splitting PMD-mapped =
THPs
> > -                                       * that are marked as lazyfree. =
*/
> >   };
> >
> >   #ifdef CONFIG_MMU
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index a7913a454028..879c8923abfc 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1606,6 +1606,19 @@ void folio_remove_rmap_pmd(struct folio *folio, =
struct page *page,
> >   #endif
> >   }
> >
> > +static bool __try_to_unmap_huge_pmd(struct vm_area_struct *vma,
> > +                                 unsigned long addr, struct folio *fol=
io)
> > +{
> > +     VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +     if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
> > +             return discard_trans_pmd(vma, addr, folio);
> > +#endif
> > +
> > +     return false;
> > +}
> > +
> >   /*
> >    * @arg: enum ttu_flags will be passed to this argument
> >    */
> > @@ -1631,14 +1644,11 @@ static bool try_to_unmap_one(struct folio *foli=
o, struct vm_area_struct *vma,
> >       if (flags & TTU_SYNC)
> >               pvmw.flags =3D PVMW_SYNC;
> >
> > -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -     if (flags & TTU_LAZYFREE_THP)
> > -             if (discard_trans_pmd(vma, address, folio))
> > +     if (flags & TTU_SPLIT_HUGE_PMD) {
> > +             if (__try_to_unmap_huge_pmd(vma, address, folio))
> >                       return true;
> > -#endif
> > -
> > -     if (flags & TTU_SPLIT_HUGE_PMD)
> >               split_huge_pmd_address(vma, address, false, folio);
> > +     }
> >
>
> I was wondering if we can better integrate that into the pagewalk below.
>
> That is, don't do the TTU_SPLIT_HUGE_PMD immediately. Start the pagewalk
> first. If we walk a PMD, try to unmap it. Only if that fails, split it.

Nice. Thanks for the suggestion!
I'll work on integrating it into the pagewalk as you suggested.

>
> Less working on "vma + address" and instead directly on PMDs.

Yes, some of the work on "vma + address" can be avoided :)

Thanks again for the review!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

