Return-Path: <linux-kernel+bounces-141805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF68D8A23AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E07A1F226B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0958411185;
	Fri, 12 Apr 2024 02:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjoqMKgb"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B3101EE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 02:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712887671; cv=none; b=ZW7VA+L7ttC75XDfYxvls2dlsl4qqtixAS3d77h4IDFTAu5lfZ5scWxtA3jLXJSyk4hhciYRzfN8VYSw71kf/mKhmfmSTfW58vuZ5J3SooM1tr3Go7izE533oKEY16DwwsSTW8Eb3YC68aakNFxrlfpTCAvM0GTFKNiJrRraBXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712887671; c=relaxed/simple;
	bh=1q11t7yvW1jL1zb5HSEuFU8i7pc8pFeVnikLXS61Uxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lA4BiIA+GI9nAVCCxNF0vgRCPhYeDGIkeijA5ZQj37fUdABbwBRXUPgqgYfWQG+msZAOFcH2K99OS6bFxOKbVefHvWxGpmr464tY76Gyn1JGpclYNum4V3LtJ+FOGQfx44dh9/JisiU54FHqpn+cPVI3KKTFiR1TX8qXpoUM6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjoqMKgb; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d47ce662so621253e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712887667; x=1713492467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/3k3JxJTwlap/AjeFL5ZKsYU4dX5m8N2zUFTIwlNiA=;
        b=OjoqMKgbV6ExhDeVYe5KbFlb1oWskOqkCTuYQLeuS/uiVg/FlLlKO2lR0k45zK+iqE
         hi4QebPUm7ik0X64cIGKk+JDORqyvYyGEkV/cDoAcbyR0AAa397a1/x37mN3P1QvDoBn
         iWI5z4AeQB81lTBy8mKetfXfx4qDjjImfRb6iHReSu5R6+eEbZP8HmBVsJAJCfUom7ub
         uJvaxARqt2bL5dehErLNAvWgLv65tBMzOtH3Ger4tw5CE0BhFJI3aL5S+X7srtayUO58
         usGszpkPtQem09q0IVZhbKw9aO8xNR9rh1yhA2pDcc08V6gxdMnlBVoaewpuck+/fUT+
         hwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712887667; x=1713492467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/3k3JxJTwlap/AjeFL5ZKsYU4dX5m8N2zUFTIwlNiA=;
        b=n/nYeagG4MeBFnKHwMsGBblwSzzaa8ccF5CRyIQXCC9QkMQvNc0ALAbpW7M7z/JbXP
         1vEWIbnCrjHkFk/jLjx37R2f/7y0EGNtLaveR4DB4d/tCIgL92sMtHAfEkdcPtmnHo17
         dUUIkjjdRB05vKazs2urLzh8ORLdx4qwcUQ+xFQpVGBCLCyhdhMoRy8LFBvBDVoaSE8z
         uhotWRYYe/LXewihboA9kpk8TfTyaVsuSU6hFEjpTN+GNrgTyW+XGu+kvHh/fpQBotf7
         6PSq4oIhm18TZnPUzUw7RFJ0jPObOpAEy091Wxq+iHpWtwkoGoy9/QuiOy1GYOhIdcLG
         d6hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV5WkwZK41Xblbmau5pqyFoUHGVEHDS/QoVrFcEl4QPb7tsDNqKY2+oazQ4/9UvnzkqwqAQ4QzxB1zR2UI6y/sWgQd6J94DWmIA7IN
X-Gm-Message-State: AOJu0YxzX/75EZtiUQINE+v6FZMZakVnd/qqOsz7pzz2xBb1fqezq1yw
	1K2vDU+hrBI9PrlEpfdyVoKotrL0fgPIJPOsoWm3gcZAJzvtbOmc6zeWxIUdMP/Dkx0N7x14XZk
	0g3KX3yx3QY47EO8RniNNweuowsA=
X-Google-Smtp-Source: AGHT+IHB0JdqUUFhdudNNoeO+JnYOVK/BsVh/H/RXL13v9tqfKo1C9R13uTqWJRXOxEDNh/pG+DVa2j3WmUl+v09DoE=
X-Received: by 2002:a05:6512:32a6:b0:515:b0be:3a42 with SMTP id
 q6-20020a05651232a600b00515b0be3a42mr1078898lfe.33.1712887667277; Thu, 11 Apr
 2024 19:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409082631.187483-1-21cnbao@gmail.com> <20240409082631.187483-2-21cnbao@gmail.com>
 <95bc0ebb-49f4-4331-8809-3e4625f1d91a@arm.com>
In-Reply-To: <95bc0ebb-49f4-4331-8809-3e4625f1d91a@arm.com>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Fri, 12 Apr 2024 10:07:35 +0800
Message-ID: <CANzGp4Jzw9bUnQw1zVdw7V6=pARx7x5s8QTyXJGfdEzrXVkZTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched swap_free()
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com, 
	kasong@tencent.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ryan Roberts <ryan.roberts@arm.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B 22:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On 09/04/2024 09:26, Barry Song wrote:
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > While swapping in a large folio, we need to free swaps related to the w=
hole
> > folio. To avoid frequently acquiring and releasing swap locks, it is be=
tter
> > to introduce an API for batched free.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>
> Couple of nits; feel free to ignore.
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>
> > ---
> >  include/linux/swap.h |  5 +++++
> >  mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 11c53692f65f..b7a107e983b8 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
> >  extern int swap_duplicate(swp_entry_t);
> >  extern int swapcache_prepare(swp_entry_t);
> >  extern void swap_free(swp_entry_t);
> > +extern void swap_free_nr(swp_entry_t entry, int nr_pages);
> >  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> >  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> >  int swap_type_of(dev_t device, sector_t offset);
> > @@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
> >  {
> >  }
> >
> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> > +{
> > +}
> > +
> >  static inline void put_swap_folio(struct folio *folio, swp_entry_t swp=
)
> >  {
> >  }
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 28642c188c93..f4c65aeb088d 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
> >               __swap_entry_free(p, entry);
> >  }
> >
> > +/*
> > + * Free up the maximum number of swap entries at once to limit the
> > + * maximum kernel stack usage.
> > + */
> > +#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTER=
)
> > +
> > +/*
> > + * Called after swapping in a large folio, batched free swap entries
> > + * for this large folio, entry should be for the first subpage and
> > + * its offset is aligned with nr_pages
> > + */
> > +void swap_free_nr(swp_entry_t entry, int nr_pages)
> > +{
> > +     int i, j;
> > +     struct swap_cluster_info *ci;
> > +     struct swap_info_struct *p;
> > +     unsigned int type =3D swp_type(entry);
> > +     unsigned long offset =3D swp_offset(entry);
> > +     int batch_nr, remain_nr;
> > +     DECLARE_BITMAP(usage, SWAP_BATCH_NR) =3D { 0 };
> > +
> > +     /* all swap entries are within a cluster for mTHP */
> > +     VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER=
);
> > +
> > +     if (nr_pages =3D=3D 1) {
> > +             swap_free(entry);
> > +             return;
> > +     }
> > +
> > +     remain_nr =3D nr_pages;
> > +     p =3D _swap_info_get(entry);
> > +     if (p) {
>
> nit: perhaps return early if (!p) ? Then you dedent the for() block.

Agreed!

>
> > +             for (i =3D 0; i < nr_pages; i +=3D batch_nr) {
> > +                     batch_nr =3D min_t(int, SWAP_BATCH_NR, remain_nr)=
;
> > +
> > +                     ci =3D lock_cluster_or_swap_info(p, offset);
> > +                     for (j =3D 0; j < batch_nr; j++) {
> > +                             if (__swap_entry_free_locked(p, offset + =
i * SWAP_BATCH_NR + j, 1))
> > +                                     __bitmap_set(usage, j, 1);
> > +                     }
> > +                     unlock_cluster_or_swap_info(p, ci);
> > +
> > +                     for_each_clear_bit(j, usage, batch_nr)
> > +                             free_swap_slot(swp_entry(type, offset + i=
 * SWAP_BATCH_NR + j));
> > +
>
> nit: perhaps change to for (;;), and do the checks here to avoid clearing=
 the
> bitmap on the last run:
>
>                         i +=3D batch_nr;
>                         if (i < nr_pages)
>                                 break;
Great, thank you for your advice!
>
> > +                     bitmap_clear(usage, 0, SWAP_BATCH_NR);
> > +                     remain_nr -=3D batch_nr;
> > +             }
> > +     }
> > +}
> > +
> >  /*
> >   * Called after dropping swapcache to decrease refcnt to swap entries.
> >   */
>
>


--=20
Thanks,
Chuanhua

