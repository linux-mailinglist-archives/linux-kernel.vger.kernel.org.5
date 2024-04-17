Return-Path: <linux-kernel+bounces-147926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B38A7B69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399601F23231
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895A533981;
	Wed, 17 Apr 2024 04:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxUKjA1U"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A30E1170F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713328547; cv=none; b=kBAuZEwW0+KjMYQTBtEZ0cW8dCaVH3A6Ew62N2Amv/I+TAkiXbgDHe+SyMNSuWYJ+mlVrRHHThzG0LCqDLQaGwte36dna1a+NeGuWF18BpdBcXzggo7UZL/YlL/L9aaffa7fWq9A81cbvYFBCV9O2TM3J7XXlrK7w8AblSLTSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713328547; c=relaxed/simple;
	bh=8MopPJ/CLQ4+ifSq7fqDQSrhRMa5pHLe+RsfTUWDVPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeeCHD+IFnyEhujjalC/AvBY0DyY4+L/MV/gmcR4rghkdbx+WRHdFmYHUbREau3kDxR1TQXZThUlM4cyp+kozWF2I9e7APUZ5wH4BF879Vh/Bmx6E3VeI+AF1v5Ib6nZ+2NV8SbiYj+mB62U2xFcF2IIrPe3iIGYjkWxOt6H6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxUKjA1U; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5701de9e971so3743184a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713328544; x=1713933344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WPlG9eiYEfwesF2hPVZ1q/BGXJT99jp6URTsnvCkUg=;
        b=SxUKjA1UoR67Rw5XsMmMr499SsfYiy5Ew/yATi0vRrLHwoM8/u/G5UIq5TABmweiuw
         ZnfslenHhDfjjTrCEUQSX6Nf9BmW5mixdS4AUsJiR2FNXHExPkkYw32MuPVtdKe0Dcll
         TFg12CTlEJe+Dq93ASxRvCcPBz/IC1Ryzd0KIHDDbjo7bYiO6AwJZaRbBh5Uul3t1Dwc
         PBZNHSGnBjTOyhqO0hFIM3xywa/2AMqOrrHj3YWFe00NKIsPch59AlEsGyrZ3T5HIzYv
         VNtUmdBfN4RMJs4AW4VBAZomDhl/7XNuuGpbdo6yYhJI0Kh9nbERq7iRYnd3zuG9w7Jw
         KmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713328544; x=1713933344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WPlG9eiYEfwesF2hPVZ1q/BGXJT99jp6URTsnvCkUg=;
        b=NZ850UhXtxwq55n+oeVZR/oqVWnB5RggnGugYnrv7Mydct+cs2aF0BoYXPxOFA8gaf
         KCkWpPK1zhUFNooFWmh9qXHrJEMhTA/AWMlAWABnGvbnzrw90SMu9L4QFolbuyPQejfD
         hvoTQ2xUoGnq6G03L8hsXC1SI+bHCb1GEHQroODUG1xmZvTKNVth8j2VTUwZHMa0TYrO
         xz/IErncRvN4le+pQGjcP3d3hh103GQtJl+7lbs4q9mA3/MkxrKLW1oClSqNf1Spab2x
         tF9LK04vEF71ypunHSSiVOw8vCHp5ivFkIdQWxwKd9VuLV/NVP9AkdJLTPkb+8hfl3Yd
         mcDw==
X-Forwarded-Encrypted: i=1; AJvYcCUTPRMfA+dIMQo4Vt5BDExXQr0XzJVh7bnHad7g3EqHLBPZqWCh0+YNbis0x9arSsh5TeBvw7gnd1uDT1scnkC7vyZe8mDt4qFuIuYs
X-Gm-Message-State: AOJu0YzE3mVU7JI4eCTTEWhczq4vo7GNBBabI06/q5EvlEyxVh14P2Kv
	BtG4oUfoVOwkHQ7iz9vHY69yP5HV3Vu06AABW0elM4S4KrS6SyRjmPhdWe//6m5gdX/FRSk7SaT
	FbkO/x0KsYeCWPY85LiH6nKtw0hE=
X-Google-Smtp-Source: AGHT+IGgXcMhJrXthZF6eoYhPniPoKU3Zw19yX2pWOyOem/YYivdlYkAaLkEWW9KRkMlzl0Dy0jiltdpUeHmo/YysSE=
X-Received: by 2002:a50:d68a:0:b0:570:4b51:edc6 with SMTP id
 r10-20020a50d68a000000b005704b51edc6mr1743101edi.28.1713328544377; Tue, 16
 Apr 2024 21:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416033457.32154-1-ioworker0@gmail.com> <20240416033457.32154-4-ioworker0@gmail.com>
 <d833efd7-28fd-42f0-83cd-e29f0f343909@arm.com> <3a0d1d1c-97f4-4c9d-bc25-9de3f3659b67@redhat.com>
In-Reply-To: <3a0d1d1c-97f4-4c9d-bc25-9de3f3659b67@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Wed, 17 Apr 2024 12:35:33 +0800
Message-ID: <CAK1f24nxfaRBaD+88shL75wOCQG8LbUu1QDWKGWitUuZ+epTDQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Ryan, David,

Thanks for taking time to review!

On Wed, Apr 17, 2024 at 12:52=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> >> +                    nr =3D madvise_folio_pte_batch(addr, end, folio, =
pte,
> >> +                                                 ptent, &any_young, &=
any_dirty);
> >> +
> >> +                    if (nr < folio_nr_pages(folio)) {
> >> +                            if (folio_likely_mapped_shared(folio))
> >> +                                    continue;
> >> +
> >> +                            arch_leave_lazy_mmu_mode();
> >> +                            if (madvise_pte_split_folio(mm, pmd, addr=
,
> >> +                                                        folio, &start=
_pte, &ptl))
> >> +                                    nr =3D 0;
> >> +                            if (!start_pte)
> >> +                                    break;
> >> +                            pte =3D start_pte;
> >> +                            arch_enter_lazy_mmu_mode();
> >> +                            continue;
> >> +                    }
> >> +
> >> +                    if (any_young)
> >> +                            ptent =3D pte_mkyoung(ptent);
> >> +                    if (any_dirty)
> >> +                            ptent =3D pte_mkdirty(ptent);
> >>              }
> >>
> >> +            if (folio_mapcount(folio) !=3D folio_nr_pages(folio))
> >> +                    continue;
> >
> > Why is this here? I thought we had previously concluded to only do this=
 test
> > inside the below if statement (where you have it duplicated).

My bad for this mistake - sorry!

>
> I stumbled over these same while reviewing. It's not exactly duplicate,
> because it's unreliable without the folio lock. It looks more like an
> best-effort early check.
>
> But then, we also add it to cases where we previously wouldn't check the
> mapcount at all: when the folio was added to the swapcache or is already
> dirty.
>
> In that case, we would even see a change for order-0 folios with that
> new check.

Thanks for pointing that out! I'll remove this check here in the next versi=
on.

I overlooked that this is a new check for order-0 folios :(

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

