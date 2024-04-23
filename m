Return-Path: <linux-kernel+bounces-154383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9678ADB72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 114B9284A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DABA125C0;
	Tue, 23 Apr 2024 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8DwuEve"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A808FC18
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835061; cv=none; b=siHPXZvfMEPV7rAhvx5hoI/XZdtvtkAS3a4BB3V18uOcJu2OiLWTkWAvDGsYGA8HvBEc3o+jkeSPRvqhvvp+Duq4B21sKWekNbteRSzCFpGaCGMMLZV0ksrhUAtBmEuoohV8vVyE7laxvSVHYQ4g22AH3KcSj95s9JdT9igg40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835061; c=relaxed/simple;
	bh=5dNHtu9PJ4dePjTdOxbwG2n1lua4BrF3Sz0/qY0oe14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSvFaXVlxngFc9g3LJqvzR8xYCJz/rvsjS1wVIuDUhUEzMgPQNBDzTj+0e8SqenuvqgquAb6vxGEIQxXmeCjHoSw6apkSAzoYZkkeTeW4ftTGzrOCs2C8JCDWCnmwWvJBOPbk5TM6Q5GehRzDXoteKm652J57jYMJ+RqnPVmxIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8DwuEve; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4dcf9659603so1555526e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713835059; x=1714439859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQfi/J7nvpoMKwZ6FO7G+J37oGiYtgYh3OlF6VNlT/g=;
        b=M8DwuEve0Jt4yc/SZOnNyv9fOYYrn3BpC/qTgnVGee5dQmzqxJr6GwW+StB08IVrHe
         gB4TCblbHkzIkBf10EGJEkxN42kd5sQiL286xQrUpDeT1/M18ZGYw9e9R1M6a4Xr2zn3
         uBI+EeOGTrlbx+JZretq6bEqYY1cVeyzT6glOuwxRrQKrD27iU4x3IJDe2UJhDwbXdsJ
         tb5vIW+CqhXtVL4OQq+9ZCU/8WDaqAPagoAe6fXhE1+jj/q/LnsSZTN5jQdntPR1opfp
         CZfS+phJkLV3V0s73YHwrGfr7pKC2H1eM2hrhzn8Zg0Y3MHG6GYPUgbkqzmoUK3VT3+m
         Rgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713835059; x=1714439859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQfi/J7nvpoMKwZ6FO7G+J37oGiYtgYh3OlF6VNlT/g=;
        b=ueqX+0s/yBtcda9AVGbw8hdGTMh+SNpNjkg9BA6aPikKoBLgl3UiG7y3ojnJnAlN9P
         OkEYboCgiPmUtgw+HzesVgn6B+diKhwSbrHLXNUJAKtT3MrRm37BQbo9Im28FNL1FMBJ
         v/lLS1r1wdhdwfwpOFY7VqwM02lPH2u2m1rSjDWzsfquiBos62/1bUqqNnkmJUkdRQ8f
         Zkz1V0aaqECfFIW0f6PVZpGgxXZdVrM6f19smCY4WPel72e2KuC0m6oCs27t/sVGAQEt
         7BRJUhNoHS25YTTKVR78i1DTsvPle2vmJPDkveue9C4mexaQCaZrk8Yqbr5lWLk/DKju
         Qn2A==
X-Forwarded-Encrypted: i=1; AJvYcCVHiqzIArOsOWtYRvizYfm2IYNqX2szFgr3huLe+SevK+7rYXNXr8QgDE2c8vf2gNjrtfK8oypwbwoEJ4cUZoyz9D1hdNmY9w/1mPc/
X-Gm-Message-State: AOJu0YyedyIYNaSfeynXpqOaS1f3kRPZf7XQVEP6CQ3ozWV0XpAtoRsP
	shh09CbEGe+vA5KuSA+hUPRmC4L+rCeh4M34Rftp8H7wAkzZ1ymjBpJpAgx5v619M4oFFb43hvn
	j9SL2fPEWIYAMK+NgQnufeLb0tC0=
X-Google-Smtp-Source: AGHT+IE5kr7/FmDvHdESTeTV4pYrQRqKLntjammemlRhEqpP/AXB3ajSLiqSe4AE/qWEXqd9Lh4LDE0NGTk5T5AoRoU=
X-Received: by 2002:a05:6122:134d:b0:4d8:37eb:9562 with SMTP id
 f13-20020a056122134d00b004d837eb9562mr13950768vkp.0.1713835058873; Mon, 22
 Apr 2024 18:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com> <05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <05d0096e4ec3e572d1d52d33a31a661321ac1551.1713755580.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 23 Apr 2024 09:17:27 +0800
Message-ID: <CAGsJ_4xu4iL5pv7T1chyzGC2Vp9q1GwOp3wxb=bYMW-T-pj4dA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/5] mm: shmem: add anonymous share mTHP counters
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ryan.roberts@arm.com, 
	ying.huang@intel.com, shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:03=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/huge_mm.h | 2 ++
>  mm/huge_memory.c        | 4 ++++
>  mm/shmem.c              | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 26b6fa98d8ac..67b9c1acad31 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -270,6 +270,8 @@ enum mthp_stat_item {
>         MTHP_STAT_ANON_SWPOUT,
>         MTHP_STAT_ANON_SWPOUT_FALLBACK,
>         MTHP_STAT_ANON_SWPIN_REFAULT,
> +       MTHP_STAT_SHMEM_ANON_ALLOC,
> +       MTHP_STAT_SHMEM_ANON_ALLOC_FALLBACK,

not quite sure about this. for 2MB pmd-mapped THP shmem, we count them
as FILE_THP.
here we are counting as SHMEM_ANON. To me, SHMEM_ANON is more correct but
it doesn't align with pmd-mapped THP. David, Ryan, what do you think?


>         __MTHP_STAT_COUNT
>  };
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9e52c0db7580..dc15240c1ab3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -557,6 +557,8 @@ DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_=
ANON_ALLOC_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBA=
CK);
>  DEFINE_MTHP_STAT_ATTR(anon_swpin_refault, MTHP_STAT_ANON_SWPIN_REFAULT);
> +DEFINE_MTHP_STAT_ATTR(shmem_anon_alloc, MTHP_STAT_SHMEM_ANON_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(shmem_anon_alloc_fallback, MTHP_STAT_SHMEM_ANON_AL=
LOC_FALLBACK);
>
>  static struct attribute *stats_attrs[] =3D {
>         &anon_alloc_attr.attr,
> @@ -564,6 +566,8 @@ static struct attribute *stats_attrs[] =3D {
>         &anon_swpout_attr.attr,
>         &anon_swpout_fallback_attr.attr,
>         &anon_swpin_refault_attr.attr,
> +       &shmem_anon_alloc_attr.attr,
> +       &shmem_anon_alloc_fallback_attr.attr,
>         NULL,
>  };
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 8b009e7040b2..4a0aa75ab29c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1706,11 +1706,14 @@ static struct folio *shmem_alloc_and_add_folio(st=
ruct vm_fault *vmf,
>                         pages =3D 1 << order;
>                         index =3D round_down(index, pages);
>                         folio =3D shmem_alloc_hugefolio(gfp, info, index,=
 order);
> -                       if (folio)
> +                       if (folio) {
> +                               count_mthp_stat(order, MTHP_STAT_SHMEM_AN=
ON_ALLOC);
>                                 goto allocated;
> +                       }
>
>                         if (pages =3D=3D HPAGE_PMD_NR)
>                                 count_vm_event(THP_FILE_FALLBACK);
> +                       count_mthp_stat(order, MTHP_STAT_SHMEM_ANON_ALLOC=
_FALLBACK);
>                         order =3D next_order(&orders, order);
>                 }
>         } else {
> --
> 2.39.3
>

Thanks
Barry

