Return-Path: <linux-kernel+bounces-82581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996078686A1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48814286515
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF6AF4FC;
	Tue, 27 Feb 2024 02:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIpYiJ4R"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87E4A2D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000157; cv=none; b=qsfjmOeUcQEO6uKz8H4ENIqkJx+NsIogV++8NiGeRB34tsPZQBb9r29o72Uu+QDQ+/wPOZSHWZNu4zwKHFqWBFpikk2u6CyXQ4U6K2ZIYtg9QMDaZMWoT4fhK4wGz67vFIF9WnkxIE+z9mkIKOUGMGeCdly3XSRMPpzg/SUWbO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000157; c=relaxed/simple;
	bh=nVl8762S8UmTlM0YPpAa/tCDXRJSslc5Iuhj0a9u7Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYCKc71ibi/8eYe30R3xynlXcP9xcfRCnFOTsrE2ozG0bh3iQ992zwyU3quHf83urXC29untUS703X/5iAJw9nWFChpZgiYiFc/xASUwIa7XQcfuxtvLFDRhumBrl3tFbp9qbBqiREgFIVNAvtzo68NCXq5eD8KHDRwGl/MW1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIpYiJ4R; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-608e0b87594so22342237b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709000155; x=1709604955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XADzUalCyqzenFShHhcCXOpXUVDuaN8mLhuPYViKtP0=;
        b=HIpYiJ4RdpL0QhV3HZt+/1EqhIFOzHC344A7KjigqmHkYn3ljHjdH6N21L+ks0EnOf
         3relIZFR/zLK9qjydc5QKl6Z/+K8LeT8rNYFQJ6o/gsF3rlOCkz7a+ihzSEsn9FOybWl
         NPz1ozKYH7stJkgRiAYZg22nEftkJlNekWiX3h56vPzWgzouCBsDhNZ8l98au5azi1nw
         RhagppB93Rai6oAo1Q8tUM5M9W+rzJrO0opU1Gt3Ux+zy8AJBkTjJsK3Kz96nZziF/xA
         vI3ugvLx+/qwtG0KhUeCdzxopSnqt7QGZtPKhYmbREkFFEbrGbxunNPd/ie/zVw1x3H4
         aXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709000155; x=1709604955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XADzUalCyqzenFShHhcCXOpXUVDuaN8mLhuPYViKtP0=;
        b=O4FXuiUgF43qTQDL71sjRkezxIpTKMv0MdkzXdkO3W4pVqK6UyH1wVLACUcO2ds29b
         zhznDbhw1GxwyROxTDg6rkWXvVlPSgBSi0IwtRyzBXc15XZtzBfAOu9S9jbtUBgYYRsw
         ZoL/9R5i2nyF7kAdL97CxNpxEvPwuF4cbwLwp2eYQBZXhXHgaxdMuYM/i7Qvepo/xIjv
         2sUYMfrwhTjFyJs6kUs8x3qjMHnkdLieSIzw6HCNVgCkKovGaCyQgFoQaOE1LakkZZ16
         0+Swj5EnR5lsKnFrKiRWQCMpUBs7U0pJQBuo78DylirFxg8SqQeX1wjNXYWBJCviOtsN
         wWIw==
X-Forwarded-Encrypted: i=1; AJvYcCXt/7Qcq4In8S5lU2BuMT5VrkYlEGWznRZEBWUNs3cic8RjIHa4gIeKPtucvhBzLSQP0nwDcLueh6raQyWMbhKXECyljFK95AQjcO6U
X-Gm-Message-State: AOJu0YyKcUsJ8dfV90AMwtp/W/x9c5KgqR6Ly1XkSCPyKsIn+XfpA3pE
	k0ZFemolxC/q7tpbpSxow5Bl9mHFwGYBN6Iwbo7pcKxM3J8G4S+zT58kZyEg6U4ogCVBaWSVneh
	TjvWq3XvMoiMC22rmQGOSMXdFVUw=
X-Google-Smtp-Source: AGHT+IE/9QetanPpeHio2vCkD+cyXLQAeOf1Fm5gRVXkkaRDNSvLErLYqbtjNHI5HxouLeyPUMT/ibwSUta6rDaPvE4=
X-Received: by 2002:a0d:dd89:0:b0:608:8a2b:b96d with SMTP id
 g131-20020a0ddd89000000b006088a2bb96dmr869584ywe.10.1709000155300; Mon, 26
 Feb 2024 18:15:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK1f24=yWPQnYuQYgc3cXdBC0HoR1yAwY59Xs2DYPAC4DQzw0A@mail.gmail.com>
 <20240227012127.174048-1-21cnbao@gmail.com> <CAK1f24kuorp8nzdeugURmnGunBhcA5VFTXi_G8M_r+Fmm=_DaQ@mail.gmail.com>
 <CAGsJ_4yAbtMzUifVRLO8nZREOX+nW2_dEcV7++Y7-9SGNK_nsg@mail.gmail.com>
In-Reply-To: <CAGsJ_4yAbtMzUifVRLO8nZREOX+nW2_dEcV7++Y7-9SGNK_nsg@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Tue, 27 Feb 2024 10:15:44 +0800
Message-ID: <CAK1f24nzYEi6yb+Fz_17BTyX4vhsawG7cwj_WT7Fnd_hhojdAg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, fengwei.yin@intel.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com, 
	minchan@kernel.org, peterx@redhat.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, songmuchun@bytedance.com, wangkefeng.wang@huawei.com, 
	zokeefe@google.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Barry!

On Tue, Feb 27, 2024 at 10:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Tue, Feb 27, 2024 at 2:48=E2=80=AFPM Lance Yang <ioworker0@gmail.com> =
wrote:
> >
> > On Tue, Feb 27, 2024 at 9:21=E2=80=AFAM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > > Thanks for your suggestion. I'll use folio_pte_batch() in v2.
> > >
> > > Hi Lance,
> > > Obviously, we both need this. While making large folio swap-in
> > > v2, I am exporting folio_pte_batch() as below,
> >
> > Thanks, Barry.
> >
> > Could you separate the export of folio_pte_batch() from the large folio
> > swap-in v2? Prioritizing the push for this specific change would aid in
> > the development of the v2 based on it.
>
> I agree we should make this one pulled in by Andrew early to avoid potent=
ial
> dependencies and conflicts in two jobs.
>
> >
> > Best,
> > Lance
> >
> > >
> > > From: Barry Song <v-songbaohua@oppo.com>
> > > Date: Tue, 27 Feb 2024 14:05:43 +1300
> > > Subject: [PATCH] mm: export folio_pte_batch as a couple of modules ne=
ed it
> > >
> > > MADV_FREE, MADV_PAGEOUT and some other modules might need folio_pte_b=
atch
> > > to check if a range of PTEs are completely mapped to a large folio wi=
th
> > > contiguous physcial offset.
> > >
> > > Cc: Lance Yang <ioworker0@gmail.com>
> > > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > > Cc: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > > ---
> > >  mm/internal.h | 13 +++++++++++++
> > >  mm/memory.c   |  2 +-
> > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 36c11ea41f47..7e11aea3eda9 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio=
 *folio)
> > >         return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
> > >  }
> > >
> > > +/* Flags for folio_pte_batch(). */
> > > +typedef int __bitwise fpb_t;
> > > +
> > > +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> > > +#define FPB_IGNORE_DIRTY               ((__force fpb_t)BIT(0))
> > > +
> > > +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirt=
y bit. */
> > > +#define FPB_IGNORE_SOFT_DIRTY          ((__force fpb_t)BIT(1))
> > > +
> > > +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
> > > +               pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags=
,
> > > +               bool *any_writable);
> > > +
> > >  void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
> > >                                                 int nr_throttled);
> > >  static inline void acct_reclaim_writeback(struct folio *folio)
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 6378f6bc22c5..dd9bd67f037a 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -989,7 +989,7 @@ static inline pte_t __pte_batch_clear_ignored(pte=
_t pte, fpb_t flags)
> > >   * If "any_writable" is set, it will indicate if any other PTE besid=
es the
> > >   * first (given) PTE is writable.
> > >   */
> > > -static inline int folio_pte_batch(struct folio *folio, unsigned long=
 addr,
> > > +int folio_pte_batch(struct folio *folio, unsigned long addr,
> > >                 pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags=
,
> > >                 bool *any_writable)
> > >  {
> > > --
> > > 2.34.1
> > >
> > > > Best,
> > > > Lance
> > >
> Thanks
> Barry
> > >

