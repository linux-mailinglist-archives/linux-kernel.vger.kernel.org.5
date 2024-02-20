Return-Path: <linux-kernel+bounces-72328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A51F285B207
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5DCB20D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB51F56759;
	Tue, 20 Feb 2024 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdZ/jIKK"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45B45942;
	Tue, 20 Feb 2024 04:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708405033; cv=none; b=SWQF+rau4EK3o3NOiXfMdSiZypM9ZyQi9nWg+JO4WfHD1Jqny66M8/BoagYnOmCOO3oHd+UavuTe4Z/G70PLcSFz23rk/BysXf4HyQ60TBeUyHr4kyJF69Va6GvxH9+rofKdQeKko5HxpLPCBJBgN5X1oUIWHbzEUOcfQiRc7i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708405033; c=relaxed/simple;
	bh=MawsSdPUwxQAQsozFkAy+ITHA2q+yH579NNdBmQ+rcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ro5AS7VVu9VLHkz7qyZuvtnYdrjuUoyHddvnVgOB2ppJ6DT8F6iZnEoQmoSlOJ8FvGPP8uEU9YMSceuj5wNbePcR1+ACl3SuHEABIxV61d6eAYR+eciRabPcH3a69x/jMbxRRRdKFt8jJHjPbFIl4G7bQV+BBN9AfjLGw9EzRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdZ/jIKK; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d1094b5568so66815261fa.1;
        Mon, 19 Feb 2024 20:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708404994; x=1709009794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg3T1pEc7CYdM3PwDVHR28RzeLutlMFhPKCwmDpZrlA=;
        b=RdZ/jIKKIGH5Ki9sCAHPDRJFkM9jqatou7iLJTJ4Werv3TzoSmMyH/AV+BuYNKJiNK
         Jkfa6A15VTHCLWQCEvtTl/nGx4vRr0i5DcYQpKptaohJileimgSmFht36v3UVyfgrhkP
         xsZPAXpEnhgrLfhajBXGVAyFGYIoUzlbn50Bc20CImkv9nn1QQAk5k4eAenpzAJ5S8ea
         f605xKqAT7ZWZ8/ASTwBli4Af1xRZMlX8/0jWhS/071WYmpr0ABWI7Xgu678UR45OEvP
         qoIZCM1i9Bov3+STJa6gcFGIYtF4OaQjNfquo8xyJF6zA+adObQ2CSzPW8KSCL4RTs1C
         UysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708404994; x=1709009794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg3T1pEc7CYdM3PwDVHR28RzeLutlMFhPKCwmDpZrlA=;
        b=UPBJYFpphxIg/jVnTCb3viQgUgljlnHJjJpw30MXOyvX+h9fx/rEg4JkAkCSuty71e
         Ru+ccfK/BMDSXk5FRDQciHknr5jwZJG198fkkAMaQ91zmlGegjpR7/n4pAiwldSowkei
         oe/imP9nFZEcXl9kZOJrw96/ZQFByn17WLKT9H+bz9e2BtaC8vKk3+LSMbNiFEpgNKE5
         fVdIXc2VQAvDpj6rWxlDw6JvlnndzdBymle4sw9zvcEFhVu+5sMNAij7Pw6zOjMvRQBz
         o1p5E7houUrGGf9kAXOHejkbeVQXeYZnaogweeSek00a90gKhg86IQyWWabqTIb++4W9
         KaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLJr+fieAocbX3hhBifsSi8KIZUWhRexUBdcYfnUTukjkmZClU5mXH269doVgk0SNuHpYnQLXDNstW4m42URg6Bgli+YQJpjSodcTDukSkE7+cQFLONJIye2sip3ylewWbsN7X
X-Gm-Message-State: AOJu0YwDfn3Np/ZoUxrnbKCmajlHfy9pXE9P/FtEYCz7FjMk16LjF1/F
	Kyjj2P+NjG/TJbxgCpI5Fs0sxywHNaIwsMqwtC6t8Pjw84+jdkNtvHz+NHiR3HACbre+8xDToXk
	Q9H16lOBhEIvCh+XYIeQ9mIB8pMI=
X-Google-Smtp-Source: AGHT+IE51DNAgivlKygoc8YbW1wKrzKBcOJ4CPEsfVHtg+lnqpbB4fNtvhyJqsoLe19BPgghFJKRz+xa/iUE3D8jCkc=
X-Received: by 2002:a2e:860e:0:b0:2d1:59:9474 with SMTP id a14-20020a2e860e000000b002d100599474mr9764115lji.48.1708404993637;
 Mon, 19 Feb 2024 20:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219082040.7495-1-ryncsn@gmail.com> <20240219173147.3f4b50b7c9ae554008f50b66@linux-foundation.org>
 <CAMgjq7DgBOJhDJStwGuD+C6-FNYZBp-cu6M_HAgRry3gBSf7GA@mail.gmail.com> <CAGsJ_4zyf5OOq_WA7VjsDKp1ciaDwzM23Ef95_O-24oLtr_5AQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zyf5OOq_WA7VjsDKp1ciaDwzM23Ef95_O-24oLtr_5AQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 20 Feb 2024 12:56:16 +0800
Message-ID: <CAMgjq7AnZJSseC2BB_nF+s533YybyP_WU8HijEKFA=OXE1x41Q@mail.gmail.com>
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>, 
	SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:01=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Tue, Feb 20, 2024 at 4:42=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Tue, Feb 20, 2024 at 9:31=E2=80=AFAM Andrew Morton <akpm@linux-found=
ation.org> wrote:
> > >
> > > On Mon, 19 Feb 2024 16:20:40 +0800 Kairui Song <ryncsn@gmail.com> wro=
te:
> > >
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more thre=
ads
> > > > swapin the same entry at the same time, they get different pages (A=
, B).
> > > > Before one thread (T0) finishes the swapin and installs page (A)
> > > > to the PTE, another thread (T1) could finish swapin of page (B),
> > > > swap_free the entry, then swap out the possibly modified page
> > > > reusing the same entry. It breaks the pte_same check in (T0) becaus=
e
> > > > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > > > install a stalled page (A) into the PTE and cause data corruption.
> > > >
> > > > @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> > > >       if (!folio) {
> > > >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > > >                   __swap_count(entry) =3D=3D 1) {
> > > > +                     /*
> > > > +                      * Prevent parallel swapin from proceeding wi=
th
> > > > +                      * the cache flag. Otherwise, another thread =
may
> > > > +                      * finish swapin first, free the entry, and s=
wapout
> > > > +                      * reusing the same entry. It's undetectable =
as
> > > > +                      * pte_same() returns true due to entry reuse=
.
> > > > +                      */
> > > > +                     if (swapcache_prepare(entry)) {
> > > > +                             /* Relax a bit to prevent rapid repea=
ted page faults */
> > > > +                             schedule_timeout_uninterruptible(1);
> > >
> > > Well this is unpleasant.  How often can we expect this to occur?
> > >
> >
> > The chance is very low, using the current mainline kernel and ZRAM,
> > even with threads set to race on purpose using the reproducer I
> > provides, for 647132 page faults it occured 1528 times (~0.2%).
> >
> > If I run MySQL and sysbench with 128 threads and 16G buffer pool, with
> > 6G cgroup limit and 32G ZRAM, it occured 1372 times for 40 min,
> > 109930201 page faults in total (~0.001%).
>

Hi Barry,

> it might not be a problem for throughput. but for real-time and tail late=
ncy,
> this hurts. For example, this might increase dropping frames of UI which
> is an important parameter to evaluate performance :-)
>

That's a true issue, as Chris mentioned before I think we need to
think of some clever data struct to solve this more naturally in the
future, similar issue exists for cached swapin as well and it has been
there for a while. On the other hand I think maybe applications that
are extremely latency sensitive should try to avoid swap on fault? A
swapin could cause other issues like reclaim, throttled or contention
with many other things, these seem to have a higher chance than this
race.

> BTW, I wonder if ying's previous proposal - moving swapcache_prepare()
> after swap_read_folio() will further help decrease the number?

We can move the swapcache_prepare after folio alloc or cgroup charge,
but I didn't see an observable change from statistics, for some
workload the reading is even worse. I think that's mostly due to
noise, or higher swap out rate since all raced threads will alloc an
extra folio now. Applications that have many pages swapped out due to
memory limit are already on the edge of triggering another reclaim, so
a dozen more folio alloc could just trigger that...

And we can't move it after swap_read_folio()... That's exactly what we
want to protect.

