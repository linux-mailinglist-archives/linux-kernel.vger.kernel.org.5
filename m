Return-Path: <linux-kernel+bounces-79466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DF286229F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 05:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2C01C22158
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 04:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661821400B;
	Sat, 24 Feb 2024 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS2IUeKA"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344FB38D
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708749493; cv=none; b=gvxACmpp9HvpbpDKj+lFNpWGpgNVpFqiPq9q03uWyDoyyuzKspXxWd4QytAfGP3mtcZuyr3WTUe7MQ/wIEOzQQM075vmWunk2aAKSl3GMdQhGgp6gR2py5NqwVOIXslDOtvNXrcMpCSMi1YyFSZZoEl51AH6JdKef2SHaIR/QR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708749493; c=relaxed/simple;
	bh=wPm12rcEg9Fw8WpU7yQ7B/mL8nmn23fQ6tJME/I8d78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qf5Pm+OxX9f0dSXOXbFZbYDv7sm47x0DOjAyLsZopPL4o102zSuRisBGFLPbVB9XpqgYUoZkfyIyXj8HCg/nc3XhiYT/DLEEFw6tO3BPK5Ch0iWlDt6S2b54k6MENb2PM1t0j6cOHuHb5lREicAoGWk9FbvfMc5hBEPlOiNsB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS2IUeKA; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2e15193bbso929576241.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708749491; x=1709354291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWzQINguLAHnwR7gEMC59aXOARD1GxeU+Zpu6O8lb4I=;
        b=KS2IUeKAvkQKPz7LYpZ1/+AXyAQrbk0+MmE6F9+K0C3pMEw8nkzcUv0UBHAjjVgitQ
         jNXx2n9+9RGNsQ2Rx5/tzESQjUfnLnwaIJaZd3cphwWHJUwHPFI7nq7teO+JdeGI1lRv
         dreVRRbfi5RIPPYA0koMInXkYi5FAA9GfwN2NkGC1rTVbtQw51JmQbUNRYWY5minwzuz
         VmgjDxx0l4cV/9xpxfz3lnngc1lsIGqVDLe4LD2Kg9QGOmXjDU58f4lZN5i6kb6spIkK
         DXkPQwW+QH5WyvhF7MayvU/jErpu9KhUhrOSG4nc8gDgrLtqfDx8Rd7MHoqC92HReAsU
         TWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708749491; x=1709354291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWzQINguLAHnwR7gEMC59aXOARD1GxeU+Zpu6O8lb4I=;
        b=X+Zq1Fla5qU+qW8BufXFZLG42R8tbe8R7Gei1gakiIuPqC5TAhD85wQbh3jD/xBroJ
         blrBPPGlIAUatEP1HEvzkSKEH/kgoHg1ud9Eiv/QNwRu6MK+d3qiyfL3CGEnYD9dnhlA
         sDeElAeMjCbm5pm+i0V65lZtZggnyuOaocgBWkCN9irEu6WMvhIMZ2bdSJ59T9C/aZ43
         KtkUzWjkzOkj2YVV9ebGm6YXVssoaqnB/mhR14jcYUy+gSbHyKLfAHZsgc5f9RAaYR9e
         ZDaCA1845xLLAiMPkSPR5FRbqNggxb+Unj9JwMD2JI1g8QUJIRxY52Sx0+9KbKiI8iks
         zYHg==
X-Forwarded-Encrypted: i=1; AJvYcCVGhfcTs6bfa8Jr5FLXE09cGnCLgOXssidHHBWVR2jo/ADL1FKr9iK14b+GlZaPpuoJP/AyqkXdVec5sUkDxBgVgdEtWqmqYDbOgIfU
X-Gm-Message-State: AOJu0Yyt0B3J0KkKuxN2sPvf11W9VtNr5JEjYLOAFfjp6tDWqqE69/lb
	my3nRp32j1lvhVy46RvDaA/Cb6zNuPL7JpQhiwCndzAr+6YASyCj45z1uMpLd7/SPiLQ+EiYm0M
	8xo47v9zQBeiRibws6w83V4t8WyFCGNdwS3w9BA==
X-Google-Smtp-Source: AGHT+IHp9Sx8VFdiBM+QCSw+J+CxLbnSxfj37mb/rgk6L0LXAUDXBIoUtYMlXePo4C+f/QF7I7RrA5lTl90W2rTfIxE=
X-Received: by 2002:a1f:6283:0:b0:4d1:34a1:d94f with SMTP id
 w125-20020a1f6283000000b004d134a1d94fmr1516295vkb.6.1708749490923; Fri, 23
 Feb 2024 20:38:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223041550.77157-1-21cnbao@gmail.com> <ZdkXpcAB6xWj2geh@google.com>
 <CAGsJ_4zPVNcP-7YQ8wkxmZu0xLkaQ-hyh98Ot0+RpyXm9o1krQ@mail.gmail.com> <ZdkpRavkakwCnoIg@google.com>
In-Reply-To: <ZdkpRavkakwCnoIg@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 24 Feb 2024 12:37:59 +0800
Message-ID: <CAGsJ_4xZQGgzFxEMTJby5MBb22GKV3+X_pLdz1E-1m_hzM4x5A@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: madvise: pageout: ignore references rather than
 clearing young
To: Minchan Kim <minchan@kernel.org>, sj@kernel.org
Cc: akpm@linux-foundation.org, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, hannes@cmpxchg.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 7:24=E2=80=AFAM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> On Sat, Feb 24, 2024 at 11:20:36AM +1300, Barry Song wrote:
> > On Sat, Feb 24, 2024 at 11:09=E2=80=AFAM Minchan Kim <minchan@kernel.or=
g> wrote:
> > >
> > > Hi Barry,
> > >
> > > On Fri, Feb 23, 2024 at 05:15:50PM +1300, Barry Song wrote:
> > > > From: Barry Song <v-songbaohua@oppo.com>
> > > >
> > > > While doing MADV_PAGEOUT, the current code will clear PTE young
> > > > so that vmscan won't read young flags to allow the reclamation
> > > > of madvised folios to go ahead.
> > >
> > > Isn't it good to accelerate reclaiming? vmscan checks whether the
> > > page was accessed recenlty by the young bit from pte and if it is,
> > > it doesn't reclaim the page. Since we have cleared the young bit
> > > in pte in madvise_pageout, vmscan is likely to reclaim the page
> > > since it wouldn't see the ferencecd_ptes from folio_check_references.
> >
> > right, but the proposal is asking vmscan to skip the folio_check_refere=
nces
> > if this is a PAGEOUT. so we remove both pte_clear_young and rmap
> > of folio_check_references.
> >
> > >
> > > Could you clarify if I miss something here?
> >
> > guest you missed we are skipping folio_check_references now.
> > we remove both, thus, make MADV_PAGEOUT 6% faster.
>
> This makes sense to me.
>
> Only concern was race with mlock during the reclaim but the race was alre=
ady
> there for normal page reclaming. Thus, mlock would already handle it.

yes. in try_to_unmap_one(), mlock()'s vma is not reclaimed,
while (page_vma_mapped_walk(&pvmw)) {
      /* Unexpected PMD-mapped THP? */
      VM_BUG_ON_FOLIO(!pvmw.pte, folio);

      /*
       * If the folio is in an mlock()d vma, we must not swap it out.
       */
      if (!(flags & TTU_IGNORE_MLOCK) &&
               (vma->vm_flags & VM_LOCKED)) {
            /* Restore the mlock which got missed */
                 if (!folio_test_large(folio))
                           mlock_vma_folio(folio, vma);
                  page_vma_mapped_walk_done(&pvmw);
                  ret =3D false;
                  break;
  }

BTW=EF=BC=8C
Hi SeongJae,
I am not quite sure if damon also needs this, so I have kept damon as is by
setting ignore_references =3D false.  MADV_PAGEOUT is an explicit hint user=
s
don't want the memory to be reclaimed, I don't know if it is true for damon=
 as
well. If you have some comments, please chime in.

>
> Thanks.

Thanks
Barry

