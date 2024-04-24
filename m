Return-Path: <linux-kernel+bounces-157624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576388B13BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88FF1F241D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D774F13AA22;
	Wed, 24 Apr 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8fhKqmi"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EC41772F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987877; cv=none; b=BYR40U73FCr1D3vq1xtGfzp9/YyjMGXloSHlChLiENxyg4a9dKIJn6uHrRKfGu3EFA+7zc1p6mvn7E3yUrvsnlrof56CH/8EHyXyJtk9mILEKOkRHUiwN/1huGKkSDKc+gPtdYPB+MBn43bzUzm1GVuRqBt39xUvMcFNLQNWn2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987877; c=relaxed/simple;
	bh=YSM87iAoIodEiDUERQ+h1AceM+9vyAuKOW1CLWr2gWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEtvvlwZE1mrRov0lMe/HCeymyAfREX6UA2vpJDeith7k0lZsl5MrVnaXAHuZQPENFPusleWrYOq/4HgCaCRGR4+ax4TVDsGTh51HyuMz2jM6by3f0qXdys15C+f9AulCkZOq5ANcOAz/zhtbtXQCLTQaPNlC+MxZ0n16rXYPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8fhKqmi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57225322312so187363a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713987874; x=1714592674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sg/GVS5qfc+eLyLw+UQ3X015Hk8d4BvhRX2za/DtXWk=;
        b=D8fhKqmiG+PkxrbI13o7Jn0FW+dyZU0kiePtOlHMzskm7XB5du53kj81O69AwLfgs3
         MmKGSDzkvElTKlp+p1GxPPUAqoA+miOwJixV5YibTVuIFtVKV23jOBGiJ8t3bQpuENlP
         n5YBYYwsZ+CHAMAc0Dzyty6se3WiAOxsvLsjH1i8zEE0ktmwdNr4nSH+pKx2saW5qxxn
         YiGjUVzqjzwSavpCZffgPAB3Su0O+Vsic1j/qhMehMAipaiV+WpsvH/AN2c3TFV8GAS1
         zjvTKKR4+KowBUHHmqAoOlyn8jAQfVdgpgcKjK9lakehh0vROyniCUA4Kxs1o4kSzwzH
         QOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987874; x=1714592674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sg/GVS5qfc+eLyLw+UQ3X015Hk8d4BvhRX2za/DtXWk=;
        b=kzoYwk3/gYceTQWmUn0DTLN4mc3HvAGyBi/ZSCTDDKIjojWWiyPay4BpabRMOZ2ydN
         oPdXXIp5NHR8WVJnDqQw8YA62qStoodNn60ROZiFc7TMS+moRq01mFM000mo/+2ngxux
         /EZg3hRRUyntR+hYha61k2jrxBXOCIJSPZvUfBK6Wcl1rDtrYFETh04SIgnUHZG4b8K7
         zxnbfDQBq5yLloTf8sOzROeDGIbUJg9GJ9y/aTXPOnpx8Zj7DJqopzXpazJghitaIU8q
         EkRsQRBLzsBFcmR2fIMtkjhIe2zgByIVfdxo3qDPeUGTSewuoPUYeURhNh5mRKXeQDOJ
         y9tw==
X-Forwarded-Encrypted: i=1; AJvYcCWFvnGm82a663oGi6D1CaILXXBtbIl94N7KTFhBU4jjuEI5+7WOPwpD0uYSid4dg383xuJyuV/5uHLHCw7+tLt3Q8qc2R1X5TyvKgQk
X-Gm-Message-State: AOJu0YyxmkiMjQqpSlAJHMu6/pibD4jWuqD7VAELpPxI1dt4dN+8pJt3
	CtIz4PXHcVBlqDuZRj2C55NOw8mlGeKicCcZ7xS3HYVgg27+40RZSls43GxmN2cbaPBck7frq5d
	+i6/C3tHX+qikYx0HQJEQmsxj0hBerO5M
X-Google-Smtp-Source: AGHT+IE1K/+472IKxewaARuPb2okWq96Fp9o8DZwRdbW6LZq7vLVuK+32gAaz5Y26En6ceih2Sl5LihOmGKC6f2hrX4=
X-Received: by 2002:a50:9ee3:0:b0:56e:2f2c:e249 with SMTP id
 a90-20020a509ee3000000b0056e2f2ce249mr2322542edf.7.1713987873584; Wed, 24 Apr
 2024 12:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424135148.30422-1-ioworker0@gmail.com> <20240424135148.30422-2-ioworker0@gmail.com>
In-Reply-To: <20240424135148.30422-2-ioworker0@gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 24 Apr 2024 12:44:22 -0700
Message-ID: <CAHbLzkq2cnZNj+0V1c=cbdQukpHCQsLCtEQLEzpH2mdjOZj_cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add per-order mTHP split counters
To: Lance Yang <ioworker0@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, 21cnbao@gmail.com, ryan.roberts@arm.com, 
	david@redhat.com, baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 6:53=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> At present, the split counters in THP statistics no longer include
> PTE-mapped mTHP. Therefore, this commit introduces per-order mTHP split
> counters to monitor the frequency of mTHP splits. This will assist
> developers in better analyzing and optimizing system performance.
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats
>         split_page
>         split_page_failed
>         deferred_split_page

The deferred_split_page counter may easily go insane with the fix from
https://lore.kernel.org/linux-mm/20240411153232.169560-1-zi.yan@sent.com/

Zi Yan,

Will you submit v2 for this patch soon?


>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  include/linux/huge_mm.h |  3 +++
>  mm/huge_memory.c        | 14 ++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 56c7ea73090b..7b9c6590e1f7 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -272,6 +272,9 @@ enum mthp_stat_item {
>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>         MTHP_STAT_ANON_SWPOUT,
>         MTHP_STAT_ANON_SWPOUT_FALLBACK,
> +       MTHP_STAT_SPLIT_PAGE,
> +       MTHP_STAT_SPLIT_PAGE_FAILED,
> +       MTHP_STAT_DEFERRED_SPLIT_PAGE,
>         __MTHP_STAT_COUNT
>  };
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 055df5aac7c3..52db888e47a6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -557,6 +557,9 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_=
ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_F=
ALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBA=
CK);
> +DEFINE_MTHP_STAT_ATTR(split_page, MTHP_STAT_SPLIT_PAGE);
> +DEFINE_MTHP_STAT_ATTR(split_page_failed, MTHP_STAT_SPLIT_PAGE_FAILED);
> +DEFINE_MTHP_STAT_ATTR(deferred_split_page, MTHP_STAT_DEFERRED_SPLIT_PAGE=
);
>
>  static struct attribute *stats_attrs[] =3D {
>         &anon_fault_alloc_attr.attr,
> @@ -564,6 +567,9 @@ static struct attribute *stats_attrs[] =3D {
>         &anon_fault_fallback_charge_attr.attr,
>         &anon_swpout_attr.attr,
>         &anon_swpout_fallback_attr.attr,
> +       &split_page_attr.attr,
> +       &split_page_failed_attr.attr,
> +       &deferred_split_page_attr.attr,
>         NULL,
>  };
>
> @@ -3083,7 +3089,7 @@ int split_huge_page_to_list_to_order(struct page *p=
age, struct list_head *list,
>         XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_o=
rder);
>         struct anon_vma *anon_vma =3D NULL;
>         struct address_space *mapping =3D NULL;
> -       bool is_thp =3D folio_test_pmd_mappable(folio);
> +       int order =3D folio_order(folio);
>         int extra_pins, ret;
>         pgoff_t end;
>         bool is_hzp;
> @@ -3262,8 +3268,10 @@ int split_huge_page_to_list_to_order(struct page *=
page, struct list_head *list,
>                 i_mmap_unlock_read(mapping);
>  out:
>         xas_destroy(&xas);
> -       if (is_thp)
> +       if (order >=3D HPAGE_PMD_ORDER)
>                 count_vm_event(!ret ? THP_SPLIT_PAGE : THP_SPLIT_PAGE_FAI=
LED);
> +       count_mthp_stat(order, !ret ? MTHP_STAT_SPLIT_PAGE :
> +                                     MTHP_STAT_SPLIT_PAGE_FAILED);
>         return ret;
>  }
>
> @@ -3327,6 +3335,8 @@ void deferred_split_folio(struct folio *folio)
>         if (list_empty(&folio->_deferred_list)) {
>                 if (folio_test_pmd_mappable(folio))
>                         count_vm_event(THP_DEFERRED_SPLIT_PAGE);
> +               count_mthp_stat(folio_order(folio),
> +                               MTHP_STAT_DEFERRED_SPLIT_PAGE);
>                 list_add_tail(&folio->_deferred_list, &ds_queue->split_qu=
eue);
>                 ds_queue->split_queue_len++;
>  #ifdef CONFIG_MEMCG
> --
> 2.33.1
>
>

