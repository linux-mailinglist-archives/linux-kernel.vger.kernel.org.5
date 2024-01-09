Return-Path: <linux-kernel+bounces-21110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F9828A05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A135284C58
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4239AFA;
	Tue,  9 Jan 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ita5Ke6W"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96613A8C6
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cce6c719caso35181691fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 08:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704817801; x=1705422601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMTSVlU7RTdc+zeD484Z8Pn79vBbZJpar+lOeRauq/0=;
        b=Ita5Ke6WzrjTrF7OMGYoWmQkLZ/2QOxFu6/bcuOHR6ZOXhPmpLgpmiMeZqPT8ZLY+Y
         4tkgpUM/ve88lejNicBrcTX6ym5lE6b5Ni+20oFMcTceOBzAAfeHctH9NseUvf7PVez/
         8uiA6KwT1TGVl4Gz/5RZAUOKwThpweanjddQyomTaY0SnhhiyTR5kvQ/t4XggbH8eBri
         t4pmMOv+NG0+XYNrsd2XOqpYLB5UTeElcbgGE/9JOOUJpcD0B5eZFfRMV/urUnAslhBF
         nUahejgq3QfaxFjEZXELaan6End5CtbqE0P2m7iRZU2DjlzPCURD5+3iqwhCYFIWdw9G
         oFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704817801; x=1705422601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMTSVlU7RTdc+zeD484Z8Pn79vBbZJpar+lOeRauq/0=;
        b=A0pOSk0fpT2thcOok63Cg97c3EsU9xN8ygN6GS5PWCmZVnn+fkHYscDJ2R4qvuiCKC
         mRJRB3/ZJcAXX4SFAbjH+YujnO2cFBMjINSFlJrvMtv13pv3JvR3QOGGsK01FOgxdEzc
         CordryyUV/0h3HViuZONGU98u1O0+sO3duY5IO3zLcAKs2uOr1/uhIkB+8ru0HusAJAX
         69jOKcp9C9S+4Qzeq4dphDPV+ivVtFArLLTHpXpyn+w/tUddOLVekM9t3kB7K32gh7pi
         V77KdZkl+obq6w+i3s4Ykr8xCDOdJI0QESqwX+st1WgeHApbM4YxaY8/PoXIXpy/Fdzw
         l5pg==
X-Gm-Message-State: AOJu0Yxy699gWRy7jjDcvnbHdwjV+Ob6KFfH6nrf0IRuSUSCM0Vu0VyV
	CciVP07QAH+higUJEgZ+GcUK8xZcxplk2zHMoG0av2ECw+Y0
X-Google-Smtp-Source: AGHT+IFz0v1wegOzYxO/7PMwQmiYhnbtWntcR/xxKMtQoIibJ46zD9IsD+2QhGH6yc6aCbud+YeyKBh34Wxbt0ITzW0=
X-Received: by 2002:ac2:53b7:0:b0:50e:3c6f:9207 with SMTP id
 j23-20020ac253b7000000b0050e3c6f9207mr2131377lfh.60.1704817800623; Tue, 09
 Jan 2024 08:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024142706.195517-1-hezhongkun.hzk@bytedance.com>
 <CAKEwX=OiNB+pPhb-3Tf7O=F7psKE3EOpwmbPSeLSOyuHpj3i+Q@mail.gmail.com>
 <CACSyD1P6HmH9tSvONnNxYv8P+am_hH2dK3UJQd9_+o6EWkPsXA@mail.gmail.com>
 <CAKEwX=PC3C-PrWAH3XiYGyR4ujqBJQBBX6uRa2jXKCy9VMyRCQ@mail.gmail.com>
 <CACSyD1O7t0+BXUujJ81RAdEys3MUnmpu0sRADLazoyvayx5DLA@mail.gmail.com>
 <CAKEwX=P5AC+ubnunnZr5vMiC6fFU+E_E7jg_FZztWwZRYSxTWQ@mail.gmail.com>
 <CACSyD1Nnc_w3epbt6+EMt7a-4pAzgW1hbE=G5Fy5Tc5R5+uxKw@mail.gmail.com>
 <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com> <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
In-Reply-To: <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 9 Jan 2024 08:29:24 -0800
Message-ID: <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, weijie.yang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 7:13=E2=80=AFPM Zhongkun He <hezhongkun.hzk@bytedanc=
e.com> wrote:
>
> Hi Yosry, glad to hear from you and happy new year!
>
> > Sorry for being late to the party. It seems to me that all of this
> > hassle can be avoided if lru_add_fn() did the right thing in this case
> > and added the folio to the tail of the lru directly. I am no expert in
> > how the page flags work here, but it seems like we can do something
> > like this in lru_add_fn():
> >
> > if (folio_test_reclaim(folio))
> >     lruvec_add_folio_tail(lruvec, folio);
> > else
> >     lruvec_add_folio(lruvec, folio);
> >
> > I think the main problem with this is that PG_reclaim is an alias to
> > PG_readahead, so readahead pages will also go to the tail of the lru,
> > which is probably not good.
>
> Agree with you=EF=BC=8C I will try it.

+Matthew Wilcox

I think we need to figure out if it's okay to do this first, because
it will affect pages with PG_readahead as well.

>
> >
> > A more intrusive alternative is to introduce a folio_lru_add_tail()
> > variant that always adds pages to the tail, and optionally call that
> > from __read_swap_cache_async() instead of folio_lru_add() based on a
> > new boolean argument. The zswap code can set that boolean argument
> > during writeback to make sure newly allocated folios are always added
> > to the tail of the lru.
>
> I have the same idea and also find it intrusive. I think the first soluti=
on
> is very good and I will try it. If it works, I will send the next version=
.

One way to avoid introducing folio_lru_add_tail() and blumping a
boolean from zswap is to have a per-task context (similar to
memalloc_nofs_save()), that makes folio_add_lru() automatically add
folios to the tail of the LRU. I am not sure if this is an acceptable
approach though in terms of per-task flags and such.

