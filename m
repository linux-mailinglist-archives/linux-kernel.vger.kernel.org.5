Return-Path: <linux-kernel+bounces-157989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECA88B19DE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CE31287E62
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E174381B8;
	Thu, 25 Apr 2024 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaFI/HNP"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A80381A1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714018671; cv=none; b=bHzZSh578xmmNUKcVwju/8y3gxAU9f+p3Og9YT+Yxri4kJK7rnjy0iYDuDXfWHKyda6KpNW91lUlUfgE0OWS1jPrAPXASh5NhgUytKL8RwWD6645VrWJ96hBfTwvZqR+MO6P6Uoo4HQa6bKyiV5uY4saC19Lj1dypnCSdm7dY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714018671; c=relaxed/simple;
	bh=aTJpYtcXJix8jBrR3BkmXNYTay+jk0LXMT/Jk/423xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZO23EZqW+UpH3EM7I6JUwsyiqcqMV9IccKC8UQ0ocEOKLQcwRE/ABleCEYGxCRkJTurHDGHqNSyMJ/jXAG5b9reVAKMeQpJSdJHm6TfXeLeOpzEO5F7EWYSF/TVJkadwN7wRB36pO3A0392ke6OGkIjMoD6g1nwvuaR/0OTh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaFI/HNP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso7300051fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714018668; x=1714623468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORT3V7drp4Vta7329poh3R+2iUUd0iHJIKKVjSlmMcs=;
        b=IaFI/HNPVNn1OuG3CQlsehm6SJhAVloJ24ZHLPLvWI5CABfHl4HbSjlMgX5nl1QCZh
         5lMq2HK+53ACr0B6lqAugyUffy2GzOp9sxvap1SFOrffhPnfmF668oJ4YidDkQZvlKDl
         Lu/to8S5onvxhAxLWEcT+tnP3gaV3U7OLdeNRMnbk9PpGwv57shGHxbUDHCoUtIRg6So
         ddBaksVBHQWdfKl1JKN3gLUOqYy4Eujo0XGwikTwahpOQgnccYQqlgCjiI58yRgp6goa
         3/BeKzHFCtPbH3s7NLj8Na99EZ3vcoS/a8pcZY8SX0ZjkN40/CN/dxc8gNkcdWvRBucL
         gV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714018668; x=1714623468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORT3V7drp4Vta7329poh3R+2iUUd0iHJIKKVjSlmMcs=;
        b=roO+d9Di5uVe6NBqowFpM4wCr+wl46FBLAEU2wI2Ye+oWqx3rdyeWOscIUN0Iq7yRx
         9fUYPJ1MTHTuJN82zuOxndAhvf83ZAOIabHc6oREwKOMojGaR9UIPuyaI9X7iTo4hdFp
         HTqZKnNxauS0MWH87MUZdG4Jv46toO3pMq3z3B/5CyNgCnHxrnRVNhOyf4aqYuQSi/5I
         3Ks1MHhc3q8Qll96VnC1ZfRIcCwZ34SNaJ1GApxgEZjB3cnETugCzknD/w9Xo4Ga4q1A
         dtKfxqsV5E/0YkVu3MywJhLSJJ5DjxCB1h/pjYMjHu+RBEpngPJTB5vpT/qd5OWFE+78
         YQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+C1uEBXar5gzQ8QP4rRi2yaRdBviyw42luSZvLYn5P+k9yFtr2tIqZuHZKd9jyfYXVbHeMlsy1RambGOoQz0mZFDGTIH+kAwWlj+v
X-Gm-Message-State: AOJu0YyZ2yF5zPWFwE2XjUV7UoATFCix6q5LNNiNqMAINv8ZEelqajBm
	lO0JyC/DDolnBxyWrqwA1nwfSh3/fzhNPZuO0SVxhCyRN/TZ5xuchtEJfG0K/wHpbn8ut7zifU6
	lFORcW7k7EQKP0+2L8t1QLlrwyFo=
X-Google-Smtp-Source: AGHT+IEo/He7+zlhE0aKh+ypaRnDjGU5zKmKF+wrxUe/Z5AcuKiJy15+2JFqdUBtDFRLBtqgFfLXhLQTE8iW/SndMp4=
X-Received: by 2002:a2e:7a1a:0:b0:2d8:d0c9:1ffc with SMTP id
 v26-20020a2e7a1a000000b002d8d0c91ffcmr3106078ljc.1.1714018667996; Wed, 24 Apr
 2024 21:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422055213.60231-1-ioworker0@gmail.com> <ZiiHSwG_bnLJbwfb@casper.infradead.org>
 <1a0ca018-8ad3-42b0-b98a-8e6b6862fc7a@redhat.com> <333181FE-C2E6-4859-AF6A-0667A1F42037@nvidia.com>
 <51ba6efa-ce5a-49cf-b90e-62310db2c561@redhat.com>
In-Reply-To: <51ba6efa-ce5a-49cf-b90e-62310db2c561@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 25 Apr 2024 12:17:36 +0800
Message-ID: <CAK1f24nb6FkipH3OZa0uwbBWkefS3f2BrJ_GTxkS2j6+6bgODQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during shrink_folio_list()
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	maskray@google.com, ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Zi, David,

Thanks for taking time to review!

On Wed, Apr 24, 2024 at 11:58=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 24.04.24 17:57, Zi Yan wrote:
> > On 24 Apr 2024, at 3:17, David Hildenbrand wrote:
> >
> >> On 24.04.24 06:15, Matthew Wilcox wrote:
> >>> On Mon, Apr 22, 2024 at 01:52:13PM +0800, Lance Yang wrote:
> >>>> When the user no longer requires the pages, they would use
> >>>> madvise(MADV_FREE) to mark the pages as lazy free. IMO, they would n=
ot
> >>>> typically rewrite to the given range.
> >>>>
> >>>> At present, PMD-mapped THPs that are marked as lazyfree during
> >>>> shrink_folio_list() are unconditionally split, which may be unnecess=
ary.
> >>>> If the THP is clean, its PMD is also clean, and there are no unexpec=
ted
> >>>> references, then we can attempt to remove the PMD mapping from it. T=
his
> >>>> change will improve the efficiency of memory reclamation in this cas=
e.
> >>>
> >>> Does this happen outside of benchmarks?  I'm really struggling to see
> >>> how we end up in this situation.  We have a clean THP without swap
> >>> backing, so it's full of zeroes, but for some reason we haven't used =
the
> >>> shared huge zero page?  What is going on?
> >>
> >> It's not full of zeroes.
> >>
> >> User space called MADV_FREE on a PMD-mapped THP.
> >>
> >> During MADV_FREE, we mark the PTEs as clean, the folio as clean and sd=
 "lazyfree" (no swap backend). If, during memory reclaim, we detect that (a=
) the folio is still clean (b) the PTEs are still clean and (c) there are n=
o unexpected references (GUP), user space didn't re-write to that memory ag=
ain, so we can just discard the memory "lazily".
> >
> > It seems that try_to_unmap_one() does not support unmapping PMD-mapped =
folios.
> > Maybe adding that support instead of a special case handling?
>
> I was thinking the same, and finding a way to avoid TTU_LAZYFREE_THP.

Thanks for the suggestions!

Yep, I completely agreed. Adding support for unmapping PMD-mapped folios to
try_to_unmap_one() would make it more future-proof.

Thanks again for the review!
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

