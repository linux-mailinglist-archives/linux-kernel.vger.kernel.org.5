Return-Path: <linux-kernel+bounces-72303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB42485B1C9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE5D1C2158E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214753E3B;
	Tue, 20 Feb 2024 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIvYOsQO"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359EB52F68;
	Tue, 20 Feb 2024 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401684; cv=none; b=aONJJ83XOMv3GrrdRIdMzRPC6tRoQTBkzwYweq6KGVb+lb6qHFrReKv5WsQqFSN3xicU4Sp3HzkhIaBFDlF9l9TIfdVu9cHxwCooYHOpMWQ8lub0g+cNCAGfRT/8spvmDHC0ofNsjJYZeFLk6sTaP8WwFKF8Yw+A9BLF6TiKzjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401684; c=relaxed/simple;
	bh=EtqPj06BXSieuMRXGbbN4iVl0m4nh6SEwC95Vkqic9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fr2LNauYJZ970lbYu9EPTFrY/xA5oxsMHYwuNXLzuQK2KdX1kW7+VlhnbQNDEeowDMHH3aVyqRHA4TQsEGtBnF2jq3G82C6VflEnUexDOjswzwoo4qt6STJqwQnbl57R9V6ncNjojo6BAuL3AOwCfG+N3HhIttoSnsgPZAK8PXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIvYOsQO; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4cba3807eedso834565e0c.0;
        Mon, 19 Feb 2024 20:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708401682; x=1709006482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+7pW6Td4IjBVEl/B0SbCdXWjl+KiOYugwOPe6kZqWU=;
        b=JIvYOsQOhWd59oVlmi5NIkerU3zVPTK4Snltoh/FQuJgGP+xGCPIQI2GD5gBRfkFs9
         0NePSD1eK2hmHFi/JUo6YcCLAUvlNBN4E1kP+8ATMYHCPljP1UZZdYdKkmWuQ5eqH6uS
         dSDgx6af3HNlQSeXyvR733QucRnUtDOjz0Rb9aUxm3WBPti9cLcZlz4Z/I3oFgV4N3QA
         isgxSBNZ8LDkDVa1mQyIGXpdgq6K+ZhV4EvG7eAfSbCwPj8dUkiRsFxBFzE1zZkn1h5C
         3zU2Bo2osjrE9CdusZ/sVSGuMvVVqXJQkCLURzD2J5YcZVznquFD/bRpnyvThHnGRKRH
         4u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708401682; x=1709006482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+7pW6Td4IjBVEl/B0SbCdXWjl+KiOYugwOPe6kZqWU=;
        b=ofUI8rv0Jd6uUdwnj/JXR276eOvEM0Fm3nVovbL2b8ZXC519Yt7QMqrm20jgYzd2O2
         jeCus0jXqMjZ0FN1hxCPBLy1EckFDlcaWY6u0YgmAQlK1Ux+KDa+C5P003PJEf580AC6
         820XhNTtUUyVYGR9ETYKcRAiyHmu9h8cNmQ8Vt7skkKoogcJYWF4fVS4s1vr0cXloJgn
         Iek/69CGUR72a0K8pF9Bw3pDjr3u/AfqLLjhmG7J700+qinPf1H+V8KejUvSooKjKapL
         cfMZi3ht2nOsnd2NtyrkhJlu9nluSFh+6JED9GVw+BxpQR1OHDijOwBxzX4vBcN4VKT2
         7yiA==
X-Forwarded-Encrypted: i=1; AJvYcCXDu/mtmbesFIaTeOqQyzAjXzvx65aarCrg9Z6VAYBvxKXgBLrYMpyxQwvwmA3bpkN4xPibhznllPxek15sO/DFqPpXG+Dafq7RoAU2gnTwtcANgYxuCDzkb1Tr9oPeU309+T7z
X-Gm-Message-State: AOJu0Yxg5xv0fLJpxEfTmOZwUVMRmVE9Y/97DB+I903L5WeXQp4STyqP
	Wd86ffGi5h6s5RVsM8VU/LQG3oc5urABxk4YfCK3vlm4jlKFkfsf47+2bu0WYdbAAhFjAfnV9aS
	X7eh8ochwTksF6vlbHcmCht0DHu4=
X-Google-Smtp-Source: AGHT+IFUkxASTfr6kUI9b9huZmglHUE9T952Z7XdRzsNguJ3X2T+ZQSSBykmkMWcO8VrT434z3zuJVKd57OPjBZO0jM=
X-Received: by 2002:a05:6122:4d0f:b0:4c8:df97:139d with SMTP id
 fi15-20020a0561224d0f00b004c8df97139dmr4748249vkb.2.1708401681914; Mon, 19
 Feb 2024 20:01:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219082040.7495-1-ryncsn@gmail.com> <20240219173147.3f4b50b7c9ae554008f50b66@linux-foundation.org>
 <CAMgjq7DgBOJhDJStwGuD+C6-FNYZBp-cu6M_HAgRry3gBSf7GA@mail.gmail.com>
In-Reply-To: <CAMgjq7DgBOJhDJStwGuD+C6-FNYZBp-cu6M_HAgRry3gBSf7GA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 17:01:10 +1300
Message-ID: <CAGsJ_4zyf5OOq_WA7VjsDKp1ciaDwzM23Ef95_O-24oLtr_5AQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>, 
	SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 4:42=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Feb 20, 2024 at 9:31=E2=80=AFAM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Mon, 19 Feb 2024 16:20:40 +0800 Kairui Song <ryncsn@gmail.com> wrote=
:
> >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more thread=
s
> > > swapin the same entry at the same time, they get different pages (A, =
B).
> > > Before one thread (T0) finishes the swapin and installs page (A)
> > > to the PTE, another thread (T1) could finish swapin of page (B),
> > > swap_free the entry, then swap out the possibly modified page
> > > reusing the same entry. It breaks the pte_same check in (T0) because
> > > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > > install a stalled page (A) into the PTE and cause data corruption.
> > >
> > > @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >       if (!folio) {
> > >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > >                   __swap_count(entry) =3D=3D 1) {
> > > +                     /*
> > > +                      * Prevent parallel swapin from proceeding with
> > > +                      * the cache flag. Otherwise, another thread ma=
y
> > > +                      * finish swapin first, free the entry, and swa=
pout
> > > +                      * reusing the same entry. It's undetectable as
> > > +                      * pte_same() returns true due to entry reuse.
> > > +                      */
> > > +                     if (swapcache_prepare(entry)) {
> > > +                             /* Relax a bit to prevent rapid repeate=
d page faults */
> > > +                             schedule_timeout_uninterruptible(1);
> >
> > Well this is unpleasant.  How often can we expect this to occur?
> >
>
> The chance is very low, using the current mainline kernel and ZRAM,
> even with threads set to race on purpose using the reproducer I
> provides, for 647132 page faults it occured 1528 times (~0.2%).
>
> If I run MySQL and sysbench with 128 threads and 16G buffer pool, with
> 6G cgroup limit and 32G ZRAM, it occured 1372 times for 40 min,
> 109930201 page faults in total (~0.001%).

it might not be a problem for throughput. but for real-time and tail latenc=
y,
this hurts. For example, this might increase dropping frames of UI which
is an important parameter to evaluate performance :-)

BTW, I wonder if ying's previous proposal - moving swapcache_prepare()
after swap_read_folio() will further help decrease the number?

Thanks
Barry

