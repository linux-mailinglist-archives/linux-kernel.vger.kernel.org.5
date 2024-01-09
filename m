Return-Path: <linux-kernel+bounces-20676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2139A82835B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FB11C2509C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448AD341A9;
	Tue,  9 Jan 2024 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mS+KcBus"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4536093
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cd33336b32so35512271fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704793134; x=1705397934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5CG7gKe3zzhtwNm9ckc7vr/DcXv1rqoHLezAiqFL6A=;
        b=mS+KcBusrLdgWtL7ayQbYa+ziYZih05Ncv9izOe7cTzfsvqfrDFRGR8ACW2nfD+t7y
         xAHXNRhmsLGauSxpcd/S9GlajRUrvj0bf7hhL/f7VWGPl0+nh3I+KQAkkcV/puCc2uAz
         337XFN8gS1YaLo0C1WEDz5QV/KQST6QOiqozoQ3bz2I69zMwn3wa3IDVoPWl1Qef75tc
         P1WJek5j2IDYEDkYzhvcHjMwCzc0SH0cEfHOQf8eycVf6UatR575TXIgbV6EyzwSeYO0
         RaLBk4DSfD6dWTMtdLrTA2cru/1Qd5wDkHq71Ek19MxHFBRFzMd/mrvyanRWA+6UeQBC
         0uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704793134; x=1705397934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5CG7gKe3zzhtwNm9ckc7vr/DcXv1rqoHLezAiqFL6A=;
        b=O/Blzhyov5Thho2fX2CfF/ypVqRKQ+RqPQzmSHBkDbl6MBZ2ge6i49Lwpe5J/jGtmH
         sU6cNLCsdM2ISnOiggnz6Wvg2wzjCy/pI7Byq3Qhy1N/FBMw/LbXnn/gwhjiucD1VcDb
         9DTtyQDQkjBSyBZLAAdEtnFCCuTwKgx0pugKXH8DKTA5ThKoztU+xtpQooJBMkL7aqEC
         SiWELwVV/0yyY6ht3s360kFPdjJUMaqD1pAR/s1t+XjuUyCSadZoYpOzB70T7ZIwCZDo
         JWmZZliM0XJwEg9BSuc99vDX4ONmjvDABhNWNMAyjYzWjF4dwGUBdvHuOn9sAC7r8+MD
         2PmA==
X-Gm-Message-State: AOJu0YwbF49/LpQ2MJ6VGDmh2GW1/sETIC6fo4sZznV7s4f4zEP/xJp6
	H5hoi7w44IfbMbAbW7CPaMQyA64gIwrtjj8Uco0=
X-Google-Smtp-Source: AGHT+IEvFIYZpifxfs5Zu6mdB8gje+BnrgvL90Gq3STayyXBjpgXnsSb91nrbEnPidaaO7Yykha4puwqy49umoxGjK0=
X-Received: by 2002:a05:651c:a07:b0:2cd:10be:cf14 with SMTP id
 k7-20020a05651c0a0700b002cd10becf14mr2778836ljq.19.1704793133664; Tue, 09 Jan
 2024 01:38:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102175338.62012-1-ryncsn@gmail.com> <20240102175338.62012-4-ryncsn@gmail.com>
 <87le95bjsf.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87le95bjsf.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 9 Jan 2024 17:38:36 +0800
Message-ID: <CAMgjq7AehV6tr9pKktzonHH9L_sEbB4c9V3Bi4U8wXZM9xZ4_A@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] mm/swap: avoid doing extra unlock error checks for
 direct swapin
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=884=E6=97=
=A5=E5=91=A8=E5=9B=9B 16:12=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > When swapping in a page, mem_cgroup_swapin_charge_folio is called for
> > new allocated folio, nothing else is referencing the folio so no need
> > to set the lock bit early. This avoided doing extra unlock checks
> > on the error path.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swap_state.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index 24cb93ed5081..6130de8d5226 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -881,16 +881,15 @@ struct folio *swapin_direct(swp_entry_t entry, gf=
p_t gfp_mask,
> >       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> >                               vma, vmf->address, false);
> >       if (folio) {
> > -             __folio_set_locked(folio);
> > -             __folio_set_swapbacked(folio);
> > -
> > -             if (mem_cgroup_swapin_charge_folio(folio,
> > -                                     vma->vm_mm, GFP_KERNEL,
> > -                                     entry)) {
> > -                     folio_unlock(folio);
> > +             if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> > +                                                GFP_KERNEL, entry)) {
> >                       folio_put(folio);
> >                       return NULL;
> >               }
> > +
> > +             __folio_set_locked(folio);
> > +             __folio_set_swapbacked(folio);
> > +
> >               mem_cgroup_swapin_uncharge_swap(entry);
> >
> >               shadow =3D get_shadow_from_swap_cache(entry);
>
> I don't find any issue with the patch.  But another caller of
> mem_cgroup_swapin_charge_folio() in __read_swap_cache_async() setups
> newly allocated folio in the same way before the change.  Better to keep
> them same?  Because the benefit of change is small too.

OK, this is just a trivial optimization, I can drop it.

