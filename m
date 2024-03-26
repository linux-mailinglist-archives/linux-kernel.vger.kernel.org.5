Return-Path: <linux-kernel+bounces-118613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F65D88BD47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C852E880A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785443F9FB;
	Tue, 26 Mar 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghRl3jdw"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB429EED6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444030; cv=none; b=LNGu7XWsr8oNN60vH2V5ww2KRUY5H0LAyiacA3KVRk3MHetcWY6XyfXIFS9N/uBvxMY7LOBdy4kiL6Jcnv63iHxhSyu95dEdDwiCuIBW2pZdEoFR1mgJ09Nhms7+/9z2z7A31lALK8EyX8WtKsRupitA/sjmzvv9otFnTUaWJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444030; c=relaxed/simple;
	bh=MzFA3omNxum9f2WcXz1IdtDpNGH4dEvv/Gi7N8EUfMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arAAh+OHORU3zhRGR+esR7EN1tvn2QaWnHFhrFCF1L5JLJKo1tjl388q7gysGqwRPzEiucxoTRcx9tVF1xnKCwudx5E5pOgUw6539Oy2x6+T70j5I2UL3HVXrMiFuZvZjHsvhAza5V7kp/KrTRdY7leZ44NBFRk919EwVmrs5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghRl3jdw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d6c8d741e8so44411971fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711444027; x=1712048827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6TyakL5Bj5ST2mAiDgxAT/2s+jquNsrgmWWT3NFtug=;
        b=ghRl3jdw6jkp3bFw1lf+mqz3Truh0B7t/AF9hqV/0UqXEa/GFuLw5tEby5+tK/ob4W
         jV2m7l4GF9I0a6B6CZLi7KRmUVroUcuHw4N5S95MRjungiPliHp8UORf52k2zzuAwoQ4
         07MKWfxZdEcypF1NZdVXwQWVy1EppRBYG03WgXiRlHYXCaLZzKgMPZXtIgTdCUUj745p
         J9l52MELvBkQD50ZGuJ9LjaExANKTPVV+RRA8iFFt59Vrlkea5S57mhE9fbpHblzULwE
         Y2SFfLmbOQA0Wdaxn2prOik6tsGaOn+tglIyjk8smWKcNa0AfUH+So6MzOUBzWX9JZBL
         nrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444027; x=1712048827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6TyakL5Bj5ST2mAiDgxAT/2s+jquNsrgmWWT3NFtug=;
        b=ggX5h979GB9QTxuUI6DROXls/sPGT6XpjTyOTkCw+WX0FxPUtSDv7Xj9K657MvV4Ra
         Da8qOO8PtQkGYiigI0YmNteUTkkVOPD50iI5qLMxzMTAS+SnnuYyZ3ZvNITZ7CO7AjAw
         +Q+cFNSRbPSxwB/o317Itapg0lfz2Wl4Lqp6UdQn3B0V7Dp9G6mp79ztL5fuH3HBBya7
         81QvdnfjDH1ixQ4XrB2Aw3c9bfZ/OJQ3hnLEk1o3JUqLExf9ZtqUmMX5QuCamZFaN907
         yDM6+IfyFvp/NkjhM4D/DRMDLAsbAHKRp4w77P49hW86FkywU9PaexZtm6mM0riMNoVe
         OBNg==
X-Forwarded-Encrypted: i=1; AJvYcCWwnSViiQbYNaK9Yp+ofjXXXEd3iiQJQkhg5tZXBcz8Ly/SSE7J1XlBpFgNoLrtktS+SIxE9PU0U1ZhSJgXsFnImGf6InSyBJ0IuufN
X-Gm-Message-State: AOJu0Yx5U/hefLgB7Fu0z6PReqfw6gYLhTbM3jiqo86+nTVopoqk3BTn
	W0xezz9VXedMgkYgZtRNsVzpqYUeynrj7QAxcy7hVY9bRM9Bol28G32ziSN4s4R0Dwdm4pNWA+w
	xuNgSNlCvrY+k3iUyjQS+CGBOJhs=
X-Google-Smtp-Source: AGHT+IHIB4wK3C5TDKvBShvHPWZmeo86zhsPskI57FdMMUIk1AazdmGx21OdqBmUzW18A/+WwsL8r4sR95oV1FzovC8=
X-Received: by 2002:a2e:bc81:0:b0:2d6:d3fd:325f with SMTP id
 h1-20020a2ebc81000000b002d6d3fd325fmr4905290ljf.32.1711444026612; Tue, 26 Mar
 2024 02:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>
 <Zfg0WLrcOmCtdn_M@casper.infradead.org> <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
 <Zfj_-LbiIsAVWcPX@casper.infradead.org> <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
 <ZfwpuRjAZV07_lc3@casper.infradead.org> <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
 <Zfz4_GJAHRInB8ul@casper.infradead.org> <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
 <ZgDt9mwN-Py5Y-xr@casper.infradead.org>
In-Reply-To: <ZgDt9mwN-Py5Y-xr@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 26 Mar 2024 17:06:55 +0800
Message-ID: <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:22=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Sun, Mar 24, 2024 at 07:14:27PM +0800, Zhaoyang Huang wrote:
> > ok. It seems like madvise is robust enough to leave no BUGs. I presume
> > another two scenarios which call folio_isloate_lru by any other ways
> > but PTE. Besides, scenario 2 reminds me of a previous bug reported by
> > me as find_get_entry entered in a livelock where the folio's refcnt =3D=
=3D
> > 0 but remains at xarray which causes the reset->retry loops forever. I
> > would like to reply in that thread for more details.
> >
> > Scenario 1:
> > 0. Thread_bad gets the folio by find_get_entry and preempted before
> > folio_lock (could be the second round scan of
> > truncate_inode_pages_range)
> >     refcnt =3D=3D 2(page_cache, fbatch_bad), PG_lru =3D=3D true, PG_loc=
k =3D=3D false
> >         folio =3D find_get_entry
> >         folio_try_get_rcu
> >         <preempted>
> >         folio_try_lock
> >
> > 1. Thread_truncate get the folio via
> > truncate_inode_pages_range->find_lock_entries
> >     refcnt =3D=3D 3(page_cache, fbatch_bad, fbatch_truncate), PG_lru =
=3D=3D
> > true, PG_lock =3D=3D true
>
> Hang on, you can't have two threads in truncate_inode_pages_range()
> at the same time.  I appreciate that we don't have any documentation
> of that, but if it were possible, we'd see other crashes.  Removing
> the folio from the page cache sets folio->mapping to NULL.  And
> __filemap_remove_folio() uses folio->mapping in
> filemap_unaccount_folio() and page_cache_delete(), so we'd get NULL
> pointer dereferences.
ok. I will check if it is possible to have another way of entering
this scenario.
>
> I see a hint in the DAX code that it's an fs-dependent lock:
>
>         /*
>          * This gets called from truncate / punch_hole path. As such, the=
 caller
>          * must hold locks protecting against concurrent modifications of=
 the
>          * page cache (usually fs-private i_mmap_sem for writing). Since =
the
>          * caller has seen a DAX entry for this index, we better find it
>          * at that index as well...
>          */
>
> so maybe that's why there's no lockdep_assert() in
> truncate_inode_pages_range(), but there should be a comment.
>
> > Scenario 2:
> > 0. Thread_bad gets the folio by find_get_entry and preempted before
> > folio_lock (could be the second round scan of
> > truncate_inode_pages_range)
> >     refcnt =3D=3D 2(page_cache, fbatch_bad), PG_lru =3D=3D true, PG_loc=
k =3D=3D false
> >         folio =3D find_get_entry
> >         folio_try_get_rcu
> >         <preempted>
> >         folio_try_lock
> >
> > 1. Thread_readahead remove the folio from page cache and drop one
> > refcnt by filemap_remove_folio(get rid of the folios which failed to
> > launch IO during readahead)
> >     refcnt =3D=3D 1(fbatch_bad), PG_lru =3D=3D true, PG_lock =3D=3D tru=
e
>
> So readaahead inserts the folio locked, and then calls
> filemap_remove_folio() without having unlocked it.
> filemap_remove_folio() sets folio->mapping to NULL in
> page_cache_delete().  When "Thread_bad" wakes up, it gets the
> folio lock, calls truncate_inode_folio() and sees that
> folio->mapping !=3D mapping, so it doesn't call filemap_remove_folio().
>
> > 4. Thread_bad schedule back from step 0 and clear one refcnt wrongly
> > when doing truncate_inode_folio->filemap_remove_folio as it take this
> > refcnt as the page cache one
> >     refcnt =3D=3D 1'(thread_isolate), PG_lru =3D=3D false, PG_lock =3D=
=3D false
> >         find_get_entries
> >             folio =3D find_get_entry
> >             folio_try_get_rcu
> >         folio_lock
> >         <no check as folio->mapping !=3D mapping as folio_lock_entries =
does>
> >         truncate_inode_folio
> >             filemap_remove_folio
> >             <preempted>
Please review the following scenario, where the folio dropped two
refcnt wrongly when cleaning Non-IO folios within ractl. Should we
change it to __readahead_folio?

0. Thread_bad gets the folio by find_get_entry and preempted after
folio_try_get_rcu (could be the second round scan of
truncate_inode_pages_range)
    refcnt =3D=3D 2(page_cache, fbatch_bad), PG_lru =3D=3D true, PG_lock =
=3D=3D false
        folio =3D find_get_entry
        folio_try_get_rcu
        <preempted>

1. Thread_readahead remove the folio from page cache and drop 2 refcnt
by readahead_folio & filemap_remove_folio(get rid of the folios which
failed to launch IO during readahead)
    refcnt =3D=3D 0, PG_lru =3D=3D true, PG_lock =3D=3D true
    read_pages
..
        folio =3D readahead_folio
        <one refcnt dropped here>
********For the folio which can not launch IO, we should NOT drop
refcnt here??? replaced by __readahead_folio???**********
        folio_get
        filemap_remove_folio(folio)
        folio_unlock
        <one refcnt dropped here>
        folio_put

2.  folio_unlock
    refcnt =3D=3D 0, PG_lru =3D=3D true, PG_lock =3D=3D false

3. Thread_isolate get one refcnt and call folio_isolate_lru(could be
any process)
    refcnt =3D=3D 1(thread_isolate), PG_lru =3D=3D true, PG_lock =3D=3D fal=
se

4. Thread_isolate proceed to clear PG_lru and get preempted before folio_ge=
t
    refcnt =3D=3D 1(thread_isolate), PG_lru =3D=3D false, PG_lock =3D=3D fa=
lse
        folio_test_clear_folio
        <preempted>
        folio_get

5. Thread_bad schedule back from step 0 and proceed to drop one refcnt
by release_pages and hit the BUG
    refcnt =3D=3D 0'(thread_isolate), PG_lru =3D=3D false, PG_lock =3D=3D f=
alse

