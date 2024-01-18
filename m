Return-Path: <linux-kernel+bounces-30490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE40831F70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FA3B24B43
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BD2E626;
	Thu, 18 Jan 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZSXbB50"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A952E407;
	Thu, 18 Jan 2024 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705604436; cv=none; b=tB8DkHU9K2LXO/nfCbcVnJ6tmnS2Xt6yyOuTBjvbyPKRBlnD1mUAZS4uKbAFEcp4rkWXXHMyDAn+cCmaukYCC+bsh7gUBgjALO6XMmI71lKdh0zSbq18aK9tw4SsdKNOUq2eMRzQ5QLoaEQuv2jRcuf2QFmv9iQw/b6rVyuO8cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705604436; c=relaxed/simple;
	bh=XAcMAf7Ovbr7Vmhjkv9al2GrF4OlxBEV2eCDppGIUMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hOBj5oCPUQW2P8T1t+PNHCkJ5pQlPLD0Ud4qaLfVHfF0nG6ebamjNf2av5iN0cFTMWAK/hmZp2rINcQfb9W9QtDU0kkwdFBGyEuuI6XRUCdQo7yeE9AsZLQPZfBYWgdJTWgM/rlvkyekm6saCrqUME78OzcwLbOFfW+X9swAh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZSXbB50; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cec32dedf3so6296634a12.0;
        Thu, 18 Jan 2024 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705604434; x=1706209234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XAcMAf7Ovbr7Vmhjkv9al2GrF4OlxBEV2eCDppGIUMw=;
        b=OZSXbB50PevpVekoHkthR2aJ7eH6KD6owRxRRAVObjJwNndkYJDTS+1rJc6F5dzVoQ
         OrG8yfWPfvrDjsLlWtj23ZmAz5IyiyluRyvdMprDBg2+/z2jLKjnW+AsTLkXJY14AHRT
         +dPxfP1ebWynn5jSkjNCMe7PVCf07XFVmjyw5NPMdgAi7xfUr2Kh+yaE3hjgCnL37o39
         j+BinNF1iXWtiCwTHRY9l6f6iBcfAyRsAzZ9TygSqoRA9+Er6B4+Gass0GqGjBpzeTiU
         r82VPXhzujyiydLWuWksiyhsmYMBngI+0aI1WDs4KDLNDVwc/wxgGHePXnAQdPgO8KNE
         4TWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705604434; x=1706209234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAcMAf7Ovbr7Vmhjkv9al2GrF4OlxBEV2eCDppGIUMw=;
        b=fdWAbog1CYzpCypVObLp+EXYNJTWtltQQwkWnoQw6gBlNnsmuRLeL6RDqNiK6NKL8G
         PVLj8ySQLQPfijyF49/DbPPCYg7klY8B2o3brWGxIv3wFCcEuPUzwaZEM8zMPC4luhs3
         WS3fQPuKPBomeOoClY8fdmNEc9lcAUtIInnBIo6qyPnERP5igAJwmtCsAAK+AoP9tiBP
         aAoOvBK+hRpdi/DhfnZj0lFWN9r2aaueZlJgz0aPZzmkY7ctSeHVeQcY1DEc2nkIjy8i
         qxUREEFFy3bNJETssQT4xfea7++wq9SfMaN/tK6gQQqB/Rzy9YlE4X71w04vok34xKw9
         Eq0g==
X-Gm-Message-State: AOJu0YxLHZL0qxNuGNSsXUgZj3ebbNS2A3fy5tlqyRkROi9vySchopLQ
	8hkrcL4qvOQr5YuL7foe7fwbhiYV/spaymCgiqsIrxzAKFJJd/WCAuT3vrMKKD568LXH1dEDQZ0
	Ny6+/ZnfoXaxjWeAjhokWsLxJrMw=
X-Google-Smtp-Source: AGHT+IHEy7skCBtgPdajoz9zt08QL2GTIY08k+U/TB1G5WRO8gUmPuqTc+lXn0jliCoNccW6sdsaD4y0e3hcNPKw2Go=
X-Received: by 2002:a17:90b:3ec3:b0:28c:3042:f8cb with SMTP id
 rm3-20020a17090b3ec300b0028c3042f8cbmr1067312pjb.21.1705604434386; Thu, 18
 Jan 2024 11:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <ZakqQyL9t2ffNUIf@tiehlicka>
 <Zakq-54DFdPu0c2U@tiehlicka> <CAAa6QmTN2B-JAO=38A09hMtUp=srLiUfs=sDbck7Chkr=W-dCw@mail.gmail.com>
In-Reply-To: <CAAa6QmTN2B-JAO=38A09hMtUp=srLiUfs=sDbck7Chkr=W-dCw@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 18 Jan 2024 11:00:21 -0800
Message-ID: <CAHbLzkphG+kmLvYQFB6WZuuGadPsRvsH4Os9CwnxvizKAfwuvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: "Zach O'Keefe" <zokeefe@google.com>
Cc: Michal Hocko <mhocko@suse.com>, Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, 
	david@redhat.com, songmuchun@bytedance.com, peterx@redhat.com, 
	mknyszek@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 6:59=E2=80=AFAM Zach O'Keefe <zokeefe@google.com> w=
rote:
>
> On Thu, Jan 18, 2024 at 5:43=E2=80=AFAM Michal Hocko <mhocko@suse.com> wr=
ote:
> >
> > Dang, forgot to cc linux-api...
> >
> > On Thu 18-01-24 14:40:19, Michal Hocko wrote:
> > > On Thu 18-01-24 20:03:46, Lance Yang wrote:
> > > [...]
> > >
> > > before we discuss the semantic, let's focus on the usecase.
> > >
> > > > Use Cases
> > > >
> > > > An immediate user of this new functionality is the Go runtime heap =
allocator
> > > > that manages memory in hugepage-sized chunks. In the past, whether =
it was a
> > > > newly allocated chunk through mmap() or a reused chunk released by
> > > > madvise(MADV_DONTNEED), the allocator attempted to eagerly back mem=
ory with
> > > > huge pages using madvise(MADV_HUGEPAGE)[2] and madvise(MADV_COLLAPS=
E)[3]
> > > > respectively. However, both approaches resulted in performance issu=
es; for
> > > > both scenarios, there could be entries into direct reclaim and/or c=
ompaction,
> > > > leading to unpredictable stalls[4]. Now, the allocator can confiden=
tly use
> > > > process_madvise(MADV_F_COLLAPSE_LIGHT) to attempt the allocation of=
 huge pages.
>
> Aside: The thought was a MADV_F_COLLAPSE_LIGHT _flag_; so it'd be
> process_madvise(..., MADV_COLLAPSE, MADV_F_COLLAPSE_LIGHT)
>
> > > IIUC the primary reason is the cost of the huge page allocation which
> > > can be really high if the memory is heavily fragmented and it is call=
ed
> > > synchronously from the process directly, correct? Can that be worked
> > > around by process_madvise and performing the operation from a differe=
nt
> > > context? Are there any other reasons to have a different mode?
> > >
> > > I mean I can think of a more relaxed (opportunistic) MADV_COLLAPSE -
> > > e.g. non blocking one to make sure that the caller doesn't really blo=
ck
> > > on resource contention (be it locks or memory availability) because t=
hat
> > > matches our non-blocking interface in other areas but having a LIGHT
> > > operation sounds really vague and the exact semantic would be
> > > implementation specific and might change over time. Non-blocking has =
a
> > > clear semantic but it is not really clear whether that is what you
> > > really need/want.
>
> IIUC, usecase from Go is unbounded latency due to sync compaction in a
> context where the latency is unacceptable. Working w/ them to
> understand how things can be improved -- it's possible the changes can
> occur entirely on their side, w/o any additional kernel support.
>
> The non-blocking case awkwardly sits between MADV_COLLAPSE today, and
> khugepaged; esp when common case is that the allocation can probably
> be satisfied in fast path.
>
> The suggestion for something like "LIGHT" was intentionally vague
> because it could allow for other optimizations / changes down the
> line, as you point out. I think that might be a win, vs tying to a
> specific optimization (e.g. like a MADV_F_COLLAPSE_NODEFRAG). But I
> could be alone on that front, given the design of
> /sys/kernel/mm/transparent_hugepage.

Per the description Go marks the address spaces with MADV_HUGEPAGE. It
means the application really wants to have huge page back the address
space so kernel will try as hard as possible to get huge page. This is
the default behavior of MADV_HUGEPAGE. If they don't want to enter
direct reclaim, they can configure the defrag mode to "defer", which
means no direct reclaim and wakeup kswapd and kcompactd, and rely on
khugepaged to install huge page later on. But this mode is not
supported by khugepaged defrag, so MADV_COLLAPSE may not support it
(IIRC MADV_COLLAPSE uses khugepaged defrag mode). Or they can just not
call MADV_HUGEPAGE and leave the decision to the users, IIRC Java does
so (specifying a flag to indicate use huge page or not by the users).

>
> But circling back, I agree w/ you that the first order of business is to
> iron out a real usecase. As of right now, it's not clear something
> like this is required or helpful.
>
> Thanks,
> Zach
>
>
>
>
> > > > [1] https://github.com/torvalds/linux/commit/7d8faaf155454f8798ec56=
404faca29a82689c77
> > > > [2] https://github.com/golang/go/commit/8fa9e3beee8b0e6baa733374099=
6181268b60a3a
> > > > [3] https://github.com/golang/go/commit/9f9bb26880388c5bead158e9eca=
3be4b3a9bd2af
> > > > [4] https://github.com/golang/go/issues/63334
> > > >
> > > > [v1] https://lore.kernel.org/lkml/20240117050217.43610-1-ioworker0@=
gmail.com/
> > > --
> > > Michal Hocko
> > > SUSE Labs
> >
> > --
> > Michal Hocko
> > SUSE Labs

