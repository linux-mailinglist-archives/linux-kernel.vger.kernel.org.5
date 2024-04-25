Return-Path: <linux-kernel+bounces-158016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69E8B1A37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1745A2865AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B8E3A1C9;
	Thu, 25 Apr 2024 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzOfmeAu"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AF037152
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714022041; cv=none; b=S4U+MOttPEHLaHw70hJCF6mr/2jrJanhjF8NAMHC+6ZqSmujpGzRJrS0bmA2xMPd/6NBSGIDpJYG9LdEyW2TOPvISWJhLli4TcsKz3PYub2f2WMJXIB0ggDc1akNYWlHC3ehEHsdHC33eiUAsNaL5XLWv/SQWde3v9AcTaFHcHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714022041; c=relaxed/simple;
	bh=omg8p74JGGqp9q57a+PVg8jb0v7WqFRnbLG3SgPaduc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3VlU1jDJ3ElyvUCoZpSeHeOm8L4OXSmnf8kM2dt2hFUKwTB1w8KiXeUjdR+SOR3jdnF1teMXJMWeWPKJI4S4jSmBnVo3S3Pa8MxyQh3FAt/ECT2XGpc+OpHJowV1cGYfPFe/JYlPbaoJPyJUxWsLqnQN3uxdTUIwSzEnvRGuW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzOfmeAu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-571ba432477so482278a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 22:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714022038; x=1714626838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMsvfQXS9e2cwUupmSavWVeAMqTjyBi4FVMWejO9Cz0=;
        b=WzOfmeAuanJKumysbAv7lfQOxbn9TS6cGjGF/7macdnae3mJOOj0zIMdZ2AvfVbWpZ
         KNhwgSLKu/GmHsX/Jd3iJ2dzGCYlBhMHo/lL90GJxQHe0o9OzdoeibLQxefH/hZSGMGU
         zUemIlptuBgVZ/NuffanV6nFt+H+4T2NNeFEKqbehfftx7zEyOY65jECBBo4xt2jCEn4
         Law8upNv6M4p5dGSuB6kXV1rkufJrne0qwOqc1TveyZZRrJw6QYUQfgCb670Bz28gs3I
         5Gx27yQvwLuZju9Br14M9MbFtFdLsmVQqkAAc51vyFXfVugMBjE7z+j1VeiLvsDn3f3I
         hFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714022038; x=1714626838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMsvfQXS9e2cwUupmSavWVeAMqTjyBi4FVMWejO9Cz0=;
        b=maUwKq03XpASN+yCgBu9JYZHdkCHgwkDFX9EnpgXEjMuHPanxUUfu8yz2poXARFjRg
         W2KBMjwn3oXueNdrJ64gGjytdcu1G+SscboWuwF16d+qPYCvGwCzXqVykmTiHf/OrI5a
         x/4KvHfVLaRXGADCP4EBqB0wtogMVDOobAfOvpBf0j2alz/PN+iuxKENn/2Pnb4j4LnO
         mmZ2aBVBvApedBlAglZZUj6mcDSLWQCotnUn5nxmobT+WHMjFZB8OHyTGuvnNYulFWzE
         N58h1pXQeQrYaXG9+r5N7t9ThptZCeR6sgpTPI0Uym76vypir6VorD3iXSLHgPy2FLkK
         msxg==
X-Forwarded-Encrypted: i=1; AJvYcCX5hD9TAbgUXCrbtJYbwfoGpyi3/FO1M3K8Kc934YowSCaw+50J3Dq2/Rx03Q7BSi4lf0nSvwfihJvcY7mLxdRm7j8CRfgVTuAkEKCe
X-Gm-Message-State: AOJu0YzSaNXT6xayVsy1HCTkK8DH6cf1MkBuDHIF8A624S65KDiJ2pCs
	eVcoNwmQIbcuYtu+ghI8RBGqlFMPwWeUwpaLrDBMZo6Vd4ue0Q6ft+DGOrreu1mmghIr4gzfmt7
	AGY3emTLwJlr/qZsuGqWOlId/+MbY9wmbfng=
X-Google-Smtp-Source: AGHT+IHp9Wwgtcn/BAPagOWZJypIB6On/thivfMjn03wEozTaGluYrlaW0ODr8J/d9SV1L5TtrwdJxDtaE7pDS1r7bo=
X-Received: by 2002:a05:6402:35cb:b0:570:5b98:dfda with SMTP id
 z11-20020a05640235cb00b005705b98dfdamr3302150edc.23.1714022037500; Wed, 24
 Apr 2024 22:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <20240424135148.30422-2-ioworker0@gmail.com>
 <CAHbLzkq2cnZNj+0V1c=cbdQukpHCQsLCtEQLEzpH2mdjOZj_cQ@mail.gmail.com>
In-Reply-To: <CAHbLzkq2cnZNj+0V1c=cbdQukpHCQsLCtEQLEzpH2mdjOZj_cQ@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 13:13:46 +0800
Message-ID: <CAK1f24my7H-Redm4LGBe1vWG1GO3Jo3bo2LTd3jU+gwJ4vfbNQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: Yang Shi <shy828301@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org, 21cnbao@gmail.com, 
	ryan.roberts@arm.com, david@redhat.com, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Yang,

Thanks for taking time to review!

On Thu, Apr 25, 2024 at 3:44=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Wed, Apr 24, 2024 at 6:53=E2=80=AFAM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > At present, the split counters in THP statistics no longer include
> > PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP split
> > counters to monitor the frequency of mTHP splits. This will assist
> > developers in better analyzing and optimizing system performance.
> >
> > /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
> >         split_page
> >         split_page_failed
> >         deferred_split_page
>
> The deferred_split_page counter may easily go insane with the fix from
> https://lore.kernel.org/linux-mm/20240411153232.169560-1-zi.yan@sent.com/
>
> Zi Yan,
>
> Will you submit v2 for this patch soon?

Thanks for bringing this to my attention!
I'll follow Zi Yan's patch, then submit the next version.

Thanks,
Lance

>
>
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  include/linux/huge_mm.h |  3 +++
> >  mm/huge_memory.c        | 14 ++++++++++++--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 56c7ea73090b..7b9c6590e1f7 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -272,6 +272,9 @@ enum mthp_stat_item {
> >         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> >         MTHP_STAT_ANON_SWPOUT,
> >         MTHP_STAT_ANON_SWPOUT_FALLBACK,
> > +       MTHP_STAT_SPLIT_PAGE,
> > +       MTHP_STAT_SPLIT_PAGE_FAILED,
> > +       MTHP_STAT_DEFERRED_SPLIT_PAGE,
> >         __MTHP_STAT_COUNT
> >  };
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 055df5aac7c3..52db888e47a6 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STA=
T_ANON_FAULT_FALLBACK);
> >  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT=
_FALLBACK_CHARGE);
> >  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
> >  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALL=
BACK);
> > +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
> > +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED);
> > +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_PA=
GE);
> >
> >  static struct attribute *stats_attrs[] =3D {
> >         &anon_fault_alloc_attr.attr,
> > @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] =3D {
> >         &anon_fault_fallback_charge_attr.attr,
> >         &anon_swpout_attr.attr,
> >         &anon_swpout_fallback_attr.attr,
> > +       &split_page_attr.attr,
> > +       &split_page_failed_attr.attr,
> > +       &deferred_split_page_attr.attr,
> >         NULL,
> >  };
> >
> > @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >         XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new=
_order);
> >         struct anon_vma *anon_vma =3D NULL;
> >         struct address_space *mapping =3D NULL;
> > -       bool is_thp =3D folio_test_pmd_mappable(folio);
> > +       int order =3D folio_order(folio);
> >         int extra_pins, ret;
> >         pgoff_t end;
> >         bool is_hzp;
> > @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct page=
 *page, struct list_head *list,
> >                 i_mmap_unlock_read(mapping);
> >  out:
> >         xas_destroy(&xas);
> > -       if (is_thp)
> > +       if (order >=3D HPAGE_PMD_ORDER)
> >                 count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_F=
AILED);
> > +       count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
> > +                                     MTHP_STAT_SPLIT_PAGE_FAILED);
> >         return ret;
> >  }
> >
> > @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
> >         if (list_empty(&folio->_deferred_list)) {
> >                 if (folio_test_pmd_mappable(folio))
> >                         count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> > +               count_mthp_stat(folio_order(folio),
> > +                               MTHP_STAT_DEFERRED_SPLIT_PAGE);
> >                 list_add_tail(&folio->_deferred_list, &ds_queue->split_=
queue);
> >                 ds_queue->split_queue_len++;
> >  #ifdef CONFIG_MEMCG
> > --
> > 2.33.1
> >
> >

