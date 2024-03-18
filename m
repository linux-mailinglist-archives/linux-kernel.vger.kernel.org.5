Return-Path: <linux-kernel+bounces-105734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C10BB87E3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CC0B20F98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D352F22094;
	Mon, 18 Mar 2024 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6bU/1h1"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB421101
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710742572; cv=none; b=UOoeAf/juTE+klSyGkpS+GJX+pekOlDY+chOph5EIGXHdsfbCzofXshFXiyh30j7lWtkVygBIcjqgPHzl2YAVeOAGrvp4x9L/55jWz+3A2U5+DUp5GydRMRRttBDxJBpyxn0JA/u0Z3m6X0wt2GfSVc0MmO2/GVHzWsmdxHTIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710742572; c=relaxed/simple;
	bh=oJG4CKg6ZCCliKGwAMX4aUzsNYxc3R/Zr7vw56W+rCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhgU8lsovrMyF3j2UUm0JKZ6vpULyzlO/8FIHn0L0z+JWQcnWeYuM2GT9VpfgcNiirL/ow/x0l8i+Lhq0DIqXYwuGqqpHl/rS1uSpNSUswzRh1ygJOMAidCkKyk264BVwze+y5LGnwKfBno+L2eu4cgBq8SJZMprngDzn8N5XpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6bU/1h1; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513e4dd6ca4so931122e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710742568; x=1711347368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HlTC/PQyLZ9gsecrmYd7shisTwC2CsnXMSCozFMXgo=;
        b=I6bU/1h1FRJorYOSFftGVc1uZEmtSEEnsAei9Kt/S+4j/0uHSI7wZCeNvMXXTKaksS
         dyo8T9ux3uLKFIPdWXKAzaMyQDfNUsLGZPgrpB9iSB3YaMZrk2tuHQ4wgK8T2RclAprh
         m5R8F1lwWjxOQbsimB+TrOF90a1DDf2sD0c7YvTZkbynLbJUfXGgbF5xmZm+rDZUsFgt
         BPjEi45GOBWMV2/8cXMXOHImK6zqPGRyNFQtdj8ToSDPRM8aOklRBtxPWbAFbBBvyQM5
         xoH9ET5ZL1EHWqF6Y/mIu7KTNkIZ1VcndFqplMq1b4dfe58Egh/vJJ4m7VCCi28vcaW5
         GddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710742568; x=1711347368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HlTC/PQyLZ9gsecrmYd7shisTwC2CsnXMSCozFMXgo=;
        b=Qd8zdMy2ud3UlpocG1NuPBL6x2qwnqP+EnHCW0kMBJw5VqR56E4D8dwkyu2HRZbR4M
         gK/IHEGR4vC3m404IHW0KPH3igcxgATbl5TZg0EUpCVVZZxWtcdMdEzeANXfKhm8thKJ
         Xnf+7naNaQ67URUhOr2gQ20j92j7qAZz0KF4QkSUz2aM2H+yFDgOOT8NbZrz5i4EBQXp
         7/zNpm61mR1DSXPLA/C0Fd8Ijze0ZT2iM/KPTRcUdVeW7i3q3hxWcANP1HDiIfIA4nJu
         imBI5i/aMPT833ioV5BX6PD5ZJylIYoMTvk7Ss6PSNv5zxn2bsMg50NssKh3YIPdRsr4
         BU2A==
X-Forwarded-Encrypted: i=1; AJvYcCXYVpaCRtRdyjq553B9F1KkMlTY5IUo68PN93UDqexiZpyP05tT9GSSlrkc4UgBckNgaJf/EawLy9IlAtBY+lCvKiCc1YPFTRkMxffd
X-Gm-Message-State: AOJu0YyHAmRGWXQNIDIK9ul1xw9zqQ8dqvAG0cR6wokuUxLLCMq05W+L
	4DhpJ1wlKHrWBdfjnHIXXT+guYJE10FAcWV8a3wrWJC0ncYKMwkXxdwxwT6NHh7KIofn7sLVy4t
	45IvnfoQytrSwyF20C9uLb/d9QkQ=
X-Google-Smtp-Source: AGHT+IGDo1rnN/i8+dbudhy57Z3WozyjNrzH1Q58Vyf48bLYj8/R0SepXkiFiJwlIJKHQv/xwprG8ZJyi0aMzjJlX/E=
X-Received: by 2002:a2e:7a01:0:b0:2d4:91c4:fca8 with SMTP id
 v1-20020a2e7a01000000b002d491c4fca8mr2519373ljc.11.1710742567999; Sun, 17 Mar
 2024 23:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b88ce9ecad0d456d8adbc78e42ec713a@BJMBX01.spreadtrum.com> <Zfe0yl2QTV1zSS1n@casper.infradead.org>
In-Reply-To: <Zfe0yl2QTV1zSS1n@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Mon, 18 Mar 2024 14:15:56 +0800
Message-ID: <CAGWkznHQLoU48Wx5kP64LN-ord6J2kvopBzpOLno4PDKTnQsiQ@mail.gmail.com>
Subject: Re: reply: [PATCH] mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 11:28=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Mar 18, 2024 at 01:37:04AM +0000, =E9=BB=84=E6=9C=9D=E9=98=B3 (Zh=
aoyang Huang) wrote:
> > >On Sun, Mar 17, 2024 at 12:07:40PM +0800, Zhaoyang Huang wrote:
> > >> Could it be this scenario, where folio comes from pte(thread 0), loc=
al
> > >> fbatch(thread 1) and page cache(thread 2) concurrently and proceed
> > >> intermixed without lock's protection? Actually, IMO, thread 1 also
> > >> could see the folio with refcnt=3D=3D1 since it doesn't care if the =
page
> > >> is on the page cache or not.
> > >>
> > >> madivise_cold_and_pageout does no explicit folio_get thing since the
> > >> folio comes from pte which implies it has one refcnt from pagecache
> > >
> > >Mmm, no.  It's implicit, but madvise_cold_or_pageout_pte_range()
> > >does guarantee that the folio has at least one refcount.
> > >
> > >Since we get the folio from vm_normal_folio(vma, addr, ptent); we know=
 that
> > >there is at least one mapcount on the folio.  refcount is always >=3D =
mapcount.
> > >Since we hold pte_offset_map_lock(), we know that mapcount (and theref=
ore
> > >refcount) cannot be decremented until we call pte_unmap_unlock(), whic=
h we
> > >don't do until we have called folio_isolate_lru().
> > >
> > >Good try though, took me a few minutes of looking at it to convince my=
self that
> > >it was safe.
> > >
> > >Something to bear in mind is that if the race you outline is real, fai=
ling to hold a
> > >refcount on the folio leaves the caller susceptible to the
> > >VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio); if the other thread c=
alls
> > >folio_put().
> > Resend the chart via outlook.
> > I think the problem rely on an special timing which is rare, I would li=
ke to list them below in timing sequence.
> >
> > 1. thread 0 calls folio_isolate_lru with refcnt =3D=3D 1
>
> (i assume you mean refcnt =3D=3D 2 here, otherwise none of this makes sen=
se)
>
> > 2. thread 1 calls release_pages with refcnt =3D=3D 2.(IMO, it could be =
1 as release_pages doesn't care if the folio is used by page cache or fs)
> > 3. thread 2 decrease refcnt to 1 by calling filemap_free_folio.(as I me=
ntioned in 2, thread 2 is not mandatary here)
> > 4. thread 1 calls folio_put_testzero and pass.(lruvec->lock has not bee=
n take here)
>
> But there's already a bug here.
>
> Rearrange the order of this:
>
> 2. thread 1 calls release_pages with refcount =3D=3D 2 (decreasing refcou=
nt to 1)
> 3. thread 2 decrease refcount to 0 by calling filemap_free_folio
> 1. thread 0 calls folio_isolate_lru() and hits the BUG().
>
> > 5. thread 0 clear folio's PG_lru by calling folio_test_clear_lru. The f=
olio_get behind has no meaning there.
> > 6. thread 1 failed in folio_test_lru and leave the folio on the LRU.
> > 7. thread 1 add folio to pages_to_free wrongly which could break the LR=
U's->list and will have next folio experience list_del_invalid
> >
> > #thread 0(madivise_cold_and_pageout)        #1(lru_add_drain->fbatch_re=
lease_pages)       #2(read_pages->filemap_remove_folios)
> > refcnt =3D=3D 1(represent page cache)             refcnt=3D=3D2(another=
 one represent LRU)          folio comes from page cache
>
> This is still illegible.  Try it this way:
>
> Thread 0        Thread 1        Thread 2
> madvise_cold_or_pageout_pte_range
>                 lru_add_drain
>                 fbatch_release_pages
>                                 read_pages
>                                 filemap_remove_folio
Thread 0        Thread 1        Thread 2
madvise_cold_or_pageout_pte_range
                truncate_inode_pages_range
                fbatch_release_pages
                                truncate_inode_pages_range
                                filemap_remove_folio
Sorry for the confusion. Rearrange the timing chart like above
according to the real panic's stacktrace. Thread 1&2 are all from
truncate_inode_pages_range(I think thread2(read_pages) is not
mandatory here as thread 0&1 could rely on the same refcnt=3D=3D1).
>
> Some accuracy in your report would also be appreciated.  There's no
> function called madivise_cold_and_pageout, nor is there a function called
> filemap_remove_folios().  It's a little detail, but it's annoying for
> me to try to find which function you're actually referring to.  I have
> to guess, and it puts me in a bad mood.
>
> At any rate, these three functions cannot do what you're proposing.
> In read_page(), when we call filemap_remove_folio(), the folio in
> question will not have the uptodate flag set, so can never have been
> put in the page tables, so cannot be found by madvise().
>
> Also, as I said in my earlier email, madvise_cold_or_pageout_pte_range()
> does guarantee that the refcount on the folio is held and can never
> decrease to zero while folio_isolate_lru() is running.  So that's two
> ways this scenario cannot happen.
The madivse_xxx comes from my presumption which has any proof.
Whereas, It looks like truncate_inode_pages_range just cares about
page cache refcnt by folio_put_testzero without noticing any task's VM
stuff. Furthermore, I notice that move_folios_to_lru is safe as it
runs with holding lruvec->lock.
>

