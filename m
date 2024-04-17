Return-Path: <linux-kernel+bounces-147821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3198A7A19
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9217D1C2165C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630DD1852;
	Wed, 17 Apr 2024 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFwIw+s+"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17817EF
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713316577; cv=none; b=Z2Mhytq/xIiidl4aCDKctEr9kzaNAvZfs0a1ibUeDvoYBvL7xYEssdYVvZv5VjiCqVrcQMfjQlNp/D5lUSya3dQepgpId1CZ5dnhpaxBN3B2/gtqQ2vb9XDg+S/EU1FozEbIvIIC1lcMCTviGBUcDhWTCpLzCU6v2uyqeJoz8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713316577; c=relaxed/simple;
	bh=t5RvkN1QNs0xebbpaIFdJi8FJIUawQlql5ntZK+0V8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVbSzjll6gCbwhFTeafIFFPcYP39t7PTu28ss3tUJFuH2muBFXV1kml5OEnz1k9t90DK/FdjEYg4cfKfTAhudGwSQ1Tz/vb46s+pg8ZMHXnjQPzxZl5yFCR21x2eonrKk75gezg0ONQ1kEmZIJblK5YaP/V26+fe0nrz5XJAEWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFwIw+s+; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-479dd0261c8so159594137.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713316575; x=1713921375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhef9E7wjd2Bx3ipiUQxQimnP4SgvHXdB7wwCVe31Ow=;
        b=PFwIw+s+zg9vX6C0T6WeJEc+h2grINoyM5okMUfnBZjyCJWnWV/26OqsJsiRqjVhZ7
         JVJpBxCTRDRwXzomY4QhozdT33FubbG+8J1mxKIrJ8QSHNwvhFd66CEaO79EHdP3gfFl
         evpdI6+o4wXIKQAhRBGv+0WrerdKnD3fEIYMG9nX+YG8mlCPTCNhs3zdylNLtuAlp5YS
         uH/cSfDhJ+xewPPNN+aSHym2Y3E4tpsSCXptrMLhqmSOWZQ2qHatoB5l0BIxPxy6/X/E
         WjcItugOo/FDNkqsiluR8MRnjlYoF2/42tAgvRx/X0RJuLE6CwSi8guyhAzr4RXJjt4L
         E1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713316575; x=1713921375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhef9E7wjd2Bx3ipiUQxQimnP4SgvHXdB7wwCVe31Ow=;
        b=xO2sw/4/1GLkFDU5F0JgYZ1K7IsgQcGCYNxwk8OTywOpQDYOWkxA0QJ2KoukJnp1zu
         3M3gkMznIZheeqcN0tp6WFpnrZwUxHPCge9j+oMBUOuo8y4IXn97iXChVEusQfv0lpoJ
         6DtIduzrZmNhz3LduybEOJaCHVTpJ/rliR0FrFGRZT+THpDI/oCL7EyLX65WD9WHCXbd
         yP11RoPnrXSFTrWmyU2bLFt59077OJnmGYt7fCvnVfZOhTSFnXfR00fCEek8pJl/KIBd
         GMT0yAjrluVK3R7pTSt1yBfVSgIgfqo3oiCekmf6ACBBcTOPTqdezhIZnatawtVSVevq
         0hQg==
X-Forwarded-Encrypted: i=1; AJvYcCUeL/qRnPhROHWUWWvlH79L/K5wUP91A34SgvE1Mv6M9C8yyV9mo/3e4YHqPoPyFVCbYI1/eIWkLLlSmWOjP3JbllP6h1gURbP1FZyh
X-Gm-Message-State: AOJu0YwDiArsSfHKEsjxdRWfEgQ1H00GzKNfADq7mYvh/1R/eZ+CPzfq
	BJRnUwy3sKLOlBvzYXucuI/6RdMu/uSaRfoMhsq0jFbtoC8aE3H4xifrui3Hl2iSgfqkIHemeRM
	5y39eFRkRPavqAPgGabreLfPsT80=
X-Google-Smtp-Source: AGHT+IFYcXiCzXMJD5RGz8InopSiEjEofiEh111EICYX9z0m6IzjC/8y+caOWZqEF0GgBUf3R/ulhRf0GMAqmdoBya0=
X-Received: by 2002:a05:6102:3c8e:b0:47a:2f76:5719 with SMTP id
 c14-20020a0561023c8e00b0047a2f765719mr3648453vsv.17.1713316573648; Tue, 16
 Apr 2024 18:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-6-21cnbao@gmail.com>
 <87frvk24x8.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frvk24x8.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 17 Apr 2024 09:16:01 +0800
Message-ID: <CAGsJ_4yoz=UH+=Z+ZmRy_9=vu_JWuOXnNO0gFtkBZ-rKJppMPA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm: add per-order mTHP swpin_refault counter
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, ryan.roberts@arm.com, surenb@google.com, 
	v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 8:47=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Currently, we are handling the scenario where we've hit a
> > large folio in the swapcache, and the reclaiming process
> > for this large folio is still ongoing.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/huge_mm.h | 1 +
> >  mm/huge_memory.c        | 2 ++
> >  mm/memory.c             | 1 +
> >  3 files changed, 4 insertions(+)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index c8256af83e33..b67294d5814f 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -269,6 +269,7 @@ enum mthp_stat_item {
> >       MTHP_STAT_ANON_ALLOC_FALLBACK,
> >       MTHP_STAT_ANON_SWPOUT,
> >       MTHP_STAT_ANON_SWPOUT_FALLBACK,
> > +     MTHP_STAT_ANON_SWPIN_REFAULT,
>
> This is different from the refault concept used in other place in mm
> subystem.  Please check the following code
>
>         if (shadow)
>                 workingset_refault(folio, shadow);
>
> in __read_swap_cache_async().

right. it is slightly different as refault can also cover the case folios
have been entirely released and a new page fault happens soon
after it.
Do you have a better name for this?
MTHP_STAT_ANON_SWPIN_UNDER_RECLAIM
or
MTHP_STAT_ANON_SWPIN_RECLAIMING ?

>
> >       __MTHP_STAT_COUNT
> >  };
>
> --
> Best Regards,
> Huang, Ying
>
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index d8d2ed80b0bf..fb95345b0bde 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -556,12 +556,14 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_=
ALLOC);
> >  DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBA=
CK);
> >  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> >  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALL=
BACK);
> > +DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT=
);
> >
> >  static struct attribute *stats_attrs[] =3D {
> >       &anon_alloc_attr.attr,
> >       &anon_alloc_fallback_attr.attr,
> >       &anon_swpout_attr.attr,
> >       &anon_swpout_fallback_attr.attr,
> > +     &anon_swpin_refault_attr.attr,
> >       NULL,
> >  };
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 9818dc1893c8..acc023795a4d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4167,6 +4167,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >               nr_pages =3D nr;
> >               entry =3D folio->swap;
> >               page =3D &folio->page;
> > +             count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPIN_=
REFAULT);
> >       }
> >
> >  check_pte:

