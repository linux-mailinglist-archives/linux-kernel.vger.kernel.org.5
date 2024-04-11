Return-Path: <linux-kernel+bounces-140604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA48A16C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68011F22C43
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC22414F9F7;
	Thu, 11 Apr 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JisgZmeT"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07E14F13A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844477; cv=none; b=cTWS7PeQSd+KEP9sTnIMRM1eoeilWZl1pTNU0TT+mvjlysPGIgX4QNB3JhlrQmJSg5bAByFlpe9GBVbys+rXCN90yLRI94C41UP/iOZVxRKt/+pxqXR8RluqjCXKtJxvS6ye/3QuD4jRj96c8Ej7XlPBY5k2+/GS7nxclZB/fww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844477; c=relaxed/simple;
	bh=GBHJD1CXoTQ6QhanCSyGg15cYGpVD8SKu7aeUf9LeMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hbytdt+TwRdG2EjfSK5Wu1fbSoQlsFM27kMiuqPJljLPYEFIK6Kt5lh/ENp0HlPUkiRf2Hzp0FZMauPHkkGl3DO7iFJg4nEYvDMirsxseGZ16dojFLhD4MBwXdmBp73n8SVqC/XTjAbw6H/GGd/k0TdyrjWqgWerwWQgxRJbsF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JisgZmeT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d6e23253so6751595e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712844474; x=1713449274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J38jC41ZnXO8P/sDoUEYs23U4kjiSY7r3l3MjCcuEUU=;
        b=JisgZmeTsa+5Wfl2DhMkbAeg0DrKjOQsuvGe6lsKpv1gP6L+YLGgpCIVoYbjqucel7
         4bdqsXab628YAZICq7lVDIo4XBckTfNubEZNuexOU1J2eaAspcajQwHXozKqt/MO+rTN
         suFh5oEfRJ0yl50JDf5M8X2q6FMrq+q4Z7JDW+yOtA8svfrayXqzQHDAOeJ+cdT0j0Mp
         rAqGK2cvSyXZsAVJGZc0ZeOe0CDCjJidx93HWqwOfqC+z9GoxX/FDgXF0Pl7QSBdij1O
         9KS6mPWEFS2Au/KvNjqkrLb3JORbbru54NxNZql25w1O3iUa1CoRgK+sq4dgrBCxH9rK
         jq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844474; x=1713449274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J38jC41ZnXO8P/sDoUEYs23U4kjiSY7r3l3MjCcuEUU=;
        b=lu9JK3ze9m4LgB6wDU/+OrjMdK8n2gpNPI0YUqtX0sKMsnpCVKbaofKTvzSQfmg+qr
         6/sB+V6wYLI6+66OaNOw0jfKzbxD+4bVCKrE7Z55CHXtL5wSe+40BIXQ08XWW8lKZDVm
         9ukbJEh7ZqETH+cEWfeqOZAUkh1pmDS9KyElyz2x2j4oY8Pe4/UpSVNCWHOKIp4xaBd/
         ZCq/z1ZG/vok2F2EJ6qZmcKWVBnmtuknhWZaAa42+Qrd4aqAw3KqRxAgarbSTUyeI934
         BChZP7nbfQZId76MIuPhSetVsj/tDnlrhc6q7JGIcSRpnb51upIrokn/H8JvvEv6oX/T
         406A==
X-Forwarded-Encrypted: i=1; AJvYcCXxaHIXt894fHZ5dejxtGOQc2URX5FFt6eSaMvIeJ+ansEiIgMk/hqVwcGGoGNJ99fn28xdI7/FExnb1Lqx6c3WhtfO6BjbCQor/Us6
X-Gm-Message-State: AOJu0Yw2NbLw8unOHsr90mNdR5TBkMvQ4NOO6VaYUc8MjxMEe/Fipj3c
	GZYx/IFzcWDGekedOBq4a4gEAqlEFN+DBdPyjCy8fM9pvByollF14YhlQffdIsGtUeqoWQUvjiD
	9XFGS2R8obIA7W/Hydw6PsUZXf1I=
X-Google-Smtp-Source: AGHT+IHlerrNBE4rq62fuxk45DgLm/ezBp+R0RfTPd1jA0utTaKgjRUNhyba8Ae4iLhdPRqsKk7DDJigP0jq+G8uEi8=
X-Received: by 2002:ac2:434e:0:b0:517:87ba:aff1 with SMTP id
 o14-20020ac2434e000000b0051787baaff1mr2215510lfl.31.1712844473425; Thu, 11
 Apr 2024 07:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408042437.10951-1-ioworker0@gmail.com> <20240408042437.10951-2-ioworker0@gmail.com>
 <38c4add8-53a2-49ca-9f1b-f62c2ee3e764@arm.com> <CAK1f24kh-vN3_6ZLUZWXu_g1UOPBuoVXq2jsnx_GBbGFXyXRFQ@mail.gmail.com>
 <3cda8e87-7095-4aad-beb1-6a420912df34@arm.com>
In-Reply-To: <3cda8e87-7095-4aad-beb1-6a420912df34@arm.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 11 Apr 2024 22:07:42 +0800
Message-ID: <CAK1f24k6mhQZwws7fjvL0ynme4FtjqBM3T6ZYuFPytH0fG=v6w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, 21cnbao@gmail.com, 
	mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com, 
	shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 9:48=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> [...]
>
> >>> +
> >>> +             if (!folio_trylock(folio))
> >>> +                     continue;
> >>
> >> This is still wrong. This should all be protected by the "if
> >> (folio_test_swapcache(folio) || folio_test_dirty(folio))" as it was pr=
eviously
> >> so that you only call folio_trylock() if that condition is true. You a=
re
> >> unconditionally locking here, then unlocking, then relocking below if =
the
> >> condition is met. Just put everything inside the condition and lock on=
ce.
> >
> > I'm not sure if it's safe to call folio_mapcount() without holding the
> > folio lock.
> >
> > As mentioned earlier by David in the v2[1]
> >> What could work for large folios is making sure that #ptes that map th=
e
> >> folio here correspond to the folio_mapcount(). And folio_mapcount()
> >> should be called under folio lock, to avoid racing with swapout/migrat=
ion.
> >
> > [1] https://lore.kernel.org/all/5cc05529-eb80-410e-bc26-233b0ba0b21f@re=
dhat.com/
>
> But I'm not suggesting that you should call folio_mapcount() without the =
lock.
> I'm proposing this:
>
>                 if (folio_test_swapcache(folio) || folio_test_dirty(folio=
)) {
>                         if (!folio_trylock(folio))
>                                 continue;
>                         /*
> -                        * If folio is shared with others, we mustn't cle=
ar
> -                        * the folio's dirty flag.
> +                        * If we have a large folio at this point, we kno=
w it is
> +                        * fully mapped so if its mapcount is the same as=
 its
> +                        * number of pages, it must be exclusive.
>                          */
> -                       if (folio_mapcount(folio) !=3D 1) {
> +                       if (folio_mapcount(folio) !=3D folio_nr_pages(fol=
io)) {
>                                 folio_unlock(folio);
>                                 continue;
>                         }

IIUC, if the folio is clean and not in the swapcache, we still need to
compare the number of batched PTEs against folio_mapcount().

Thanks,
Lance

>
> What am I missing?
>

