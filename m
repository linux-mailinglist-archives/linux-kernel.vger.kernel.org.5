Return-Path: <linux-kernel+bounces-84260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03886A447
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7516B1F27884
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B07EB;
	Wed, 28 Feb 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZ8QwQNt"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E67363
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079020; cv=none; b=ekZcngu4E8EltPwcD0EdIF3KBkIFFhdUH/sIuxoYtREkYG2cB7b+WGhTAGQkSsBB5A3g9B6kD4Z+oIUnx9wCkBp67mrWVoVAGj0lmEvAHRas8WKUA3WIaNQXviTA79v7Eqefux0T6Xg6yWRP25JMT8I1FUUpvTVk2mJSpP7Gv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079020; c=relaxed/simple;
	bh=OePn2Vqze54j1HJREhzx+vC2haay4Mm45C6FZi0nD1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7Lf+uDFHqivLreYuHCN3y+dlws3UhCHeRsAKy/s4L/myaa1nlE2BcPZ+cZGNqsk3TimvG1hSNmMgSQx5qCFoBbY2gLcbKZ1959/oOLcyyEPvW4gHv6bDV0u9iPPqTflbaAS79asYOjeSBBNZ/H11pUKDT2t/lKheZPdj6pTgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZ8QwQNt; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so2655634241.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709079017; x=1709683817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GU0HNIXp5FhKieQRiIc51gUQd5WumB9EvT9xoM2OiHs=;
        b=mZ8QwQNtLzcmc3aHZTZT+HrES5Xc3CbdKoGSMMc9f8MobfPYExzVrRJkvCMJa+9ppX
         4uNEH3dQKSBnv2/8Dk8GC8dVvLNmz+dltUQ/OXwoH6ONafI8GdK/ephei8LO2X7YFxsi
         7tI7b2WoCs5hg9s8BzO2g88vNhSS5rYReptgrLhXIwj+LfccY1qu9nyJtofni26TZnRd
         eVMLIma3V/CviGnTF1CGd4nMvFlXRnyd9OHKROfNsymWVScd3S1lVEBNiOPszT6wZL4B
         uhUC8BGuozdc7nE0IKKENpqXb4TkYWOTQz5Iwk0/+v28A325gXT5hBRiHPxD7aiwE6ZK
         or1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709079017; x=1709683817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GU0HNIXp5FhKieQRiIc51gUQd5WumB9EvT9xoM2OiHs=;
        b=XvA7nBbQ28PvK5uwGKCHdfemlUWgXbXt1r1QrUb+we3TDcJxWlFVduIRF68IgS7+rm
         r1/QxnwPX/kvade/7YRD1fBTmUr7QUniVX+Sh7csIuaScS+y6a/QzlioR5D7cjuPCkx0
         arvj/M29kHdQounnntYbpqxBvrTTvisuoDtnMMOhiu31mZCf8RGVtQ7ar8zrb0o9bwy8
         Qp5/00bvtqhFUBYBNAxzDeMRBbj4E1uUXefuPKEl6D/5SnGnG5bwwRdvW2rEc5TcnbUg
         jxxHgEqLnxkhSsVvM4PINJfn4oowfwMNaSSvK14+JYrqVVkWnF63V6YZw+aQZUCo2mbs
         4ipw==
X-Forwarded-Encrypted: i=1; AJvYcCWnELMs5xyNrenn1obWXRnFZU4sk8GpWLjvctwE85RXWpD6qrPFYUTeWHbqyJuENNbhl6duu8dUVn8XF+tN8MrEYkGHUAWw285OGVnU
X-Gm-Message-State: AOJu0Yw+U+aOxikypNs5WMok68LebCAp3BU9XDeko8leoc9l/25gnV1J
	8op9/Q/QTJl9+wGieDTw7/9XVdjzDXso30YlwPhZHM7OJyuTzUl2MREaGSY7UpiAi71fRAGXo89
	Frg4XLfYnQIHe0b4Q3o62yzVDxnk=
X-Google-Smtp-Source: AGHT+IELRdA4kvWrlniWfwpOQ/SrUe9sSWcOSNAz2d2m+y1pNDQnLGh953wecIjNrA0G1Mn/5MN8RKL1cpxIKj57X2g=
X-Received: by 2002:a05:6122:408b:b0:4d3:340d:c50f with SMTP id
 cb11-20020a056122408b00b004d3340dc50fmr2208980vkb.9.1709079017283; Tue, 27
 Feb 2024 16:10:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227104201.337988-1-21cnbao@gmail.com> <20240227215426.153162-1-sj@kernel.org>
In-Reply-To: <20240227215426.153162-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 13:10:06 +1300
Message-ID: <CAGsJ_4wWzG-37D82vqP_zt+Fcbz+URVe5oXLBc4M5wbN8A_gpQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: make folio_pte_batch available outside of mm/memory.c
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Yin Fengwei <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:54=E2=80=AFAM SeongJae Park <sj@kernel.org> wrot=
e:
>
> On Tue, 27 Feb 2024 23:42:01 +1300 Barry Song <21cnbao@gmail.com> wrote:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > madvise, mprotect and some others might need folio_pte_batch to check i=
f
> > a range of PTEs are completely mapped to a large folio with contiguous
> > physical addresses. Let's make it available in mm/internal.h.
>
> Hi Barry,
>
>
> I found this patch makes some of my build test that not setting CONFIG_MM=
U
> fails with multiple errors including below:
>
>     In file included from .../mm/nommu.c:43:
>     .../mm/internal.h: In function '__pte_batch_clear_ignored':
>     .../mm/internal.h:98:23: error: implicit declaration of function 'pte=
_mkclean'; did you mean 'page_mkclean'? [-Werror=3Dimplicit-function-declar=
ation]
>        98 |                 pte =3D pte_mkclean(pte);
>           |                       ^~~~~~~~~~~
>           |                       page_mkclean
>
> Enabling CONFIG_MMU made the build success.  I haven't had a time to look=
 into
> the code yet.  May I ask your opinion?

i guess it is because we have moved some func from memory.c to
headfile. and this headfile is included by lots of
files in mm.  memory.c, for itself, will only be compiled with enabled
CONFIG_MMU:
mmu-$(CONFIG_MMU)       :=3D highmem.o memory.o mincore.o \
                           mlock.o mmap.o mmu_gather.o mprotect.o mremap.o =
\
                           msync.o page_vma_mapped.o pagewalk.o \
                           pgtable-generic.o rmap.o vmalloc.o

Does the below fix your build?

diff --git a/mm/internal.h b/mm/internal.h
index fa9e2f7db506..4e57680b74e1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -83,6 +83,8 @@ static inline void *folio_raw_mapping(struct folio *folio=
)
        return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }

+#ifdef CONFIG_MMU
+
 /* Flags for folio_pte_batch(). */
 typedef int __bitwise fpb_t;

@@ -172,6 +174,7 @@ static inline int folio_pte_batch(struct folio
*folio, unsigned long addr,

        return min(ptep - start_ptep, max_nr);
 }
+#endif /* CONFIG_MMU */

 void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
                                                int nr_throttled);


> Thanks,
> SJ

Thanks
Barry

