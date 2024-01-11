Return-Path: <linux-kernel+bounces-23485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2082AD60
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBAB91C2339B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB8415488;
	Thu, 11 Jan 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3jlpGM+"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32C014F97
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2a17f3217aso585256166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704972502; x=1705577302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r4p8EZizALAha2W0BpFV/ugv3SVBdRsaxVwbhdyofU=;
        b=q3jlpGM+7f3viLraFKsP1bjc0pynslWLdE4jNaANsFv+gTTURDv60tiLh/q9YzmJS3
         BG7+TYcANaX/Y0NC3Z76RnWCwph9UOPHR7E62l2duBj2YPytZZA7Gn9gLZQS4tVt2vIl
         XKSMKELuF5ELtQUAKuE+UAijSzyI6wR1cWAmpYDk9+NkkEW3Q6XxVjQGHcco/k/AnNOo
         jUMF/YUwFwe8xaTNJvaBGdkhJrcWjGVAl9rKK1nJlBI+IEQ9VPR82oJ1ougVyquunh/z
         xMG1hfKWntqCT4YcBsNsWcFV2lOXkjeNf0FwX4mOl/lRzV399s/OD2sYwrtnnGyxVRGH
         vShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704972502; x=1705577302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r4p8EZizALAha2W0BpFV/ugv3SVBdRsaxVwbhdyofU=;
        b=n17XHV8RSZsGm4umB/41Bm0eU7Rba7agVkG1uBYwOWqjvxSAR5v26140nHoB12UWaJ
         046aQ6XWGnMhhWZm2i/W6pwGzl90d0re71lvbLopcGeMC5wj4cZEcF5DqCPIpYADNyE/
         Tlsyl8UrjOO23A8wIv9+3diUeDe4Hx9RN2FZaaEE9rPyC1z9PldcvDP3nUQCGwc3rYIS
         viNVrMRlHX3YxReNtaCZ+hGjHAOFSxg6sQ+2yP2MkqGb0kv7PdTmlSZIhHVc8MYDmX4f
         3hNs0nIAx02cdbv+F4XGBsjevSoSN5l4E/TSKEpiKSFnTGb0LgOjY9HvFVGiwllYqYyM
         gTbg==
X-Gm-Message-State: AOJu0Ywq5CYg87cQa/lt4udib8HlYTI70sW2cJ0s8Fjz/V990OWDpKZt
	r15b3xbg60J1exSSwOJlZCxx0zg5P1XCJTN6YqKObymXrb2g
X-Google-Smtp-Source: AGHT+IEufoHkvLSX8vgq4YGEOXKsTE0opFs0mnugITz8vjU8xo4oJO5CX6Yg+X0XoMd4DWqJkwdFdlvpvUFOV4j5AXg=
X-Received: by 2002:a17:906:2496:b0:a2c:4a17:1d66 with SMTP id
 e22-20020a170906249600b00a2c4a171d66mr425894ejb.47.1704972501963; Thu, 11 Jan
 2024 03:28:21 -0800 (PST)
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
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
 <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
 <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com> <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
In-Reply-To: <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 11 Jan 2024 03:27:44 -0800
Message-ID: <CAJD7tkYmOCCR7iipEFF69woXQxOr7byj+GuafGQVBL=UCHUK5A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 7:49=E2=80=AFPM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> >
> > This sounds dangerous. This is going to introduce a rather large
> > unexpected side effect - we're changing the readahead behavior in a
> > seemingly small zswap optimization. In fact, I'd argue that if we do
> > this, the readahead behavior change will be the "main effect", and the
> > zswap-side change would be a "happy consequence". We should run a lot
> > of benchmarking and document the change extensively if we pursue this
> > route.
> >
>
> I agree with the unexpected side effect,  and here I need
> to clarify the original intention of this patch.Please see the memory
> offloading steps below.
>
>
> memory      zswap(reclaim)          memory+swap (writeback)
> 1G                 0.5G                        1G(tmp memory) + 1G=EF=BC=
=88swap=EF=BC=89
>
> If the decompressed memory cannot be released in time,
> zswap's writeback has great side effects(mostly clod pages).
> On the one hand, the memory space has not been reduced,
> but has increased (from 0.5G->1G).
> At the same time, it is not put the pages to the tail of the lru.
> When the memory is insufficient, other pages will be squeezed out
> and released early.
> With this patch=EF=BC=8C we can put the tmp pages to the tail and reclaim=
 it
> in time when the memory is insufficient or actively reclaimed.
> So I think this patch makes sense and hope it can be fixed with a
> suitable approaches.
>
> >
> > Unless some page flag/readahead expert can confirm that the first
> > option is safe, my vote is on this option. I mean, it's fairly minimal
> > codewise, no? Just a bunch of plumbing. We can also keep the other
> > call sites intact if we just rename the old versions - something along
> > the line of:
> >
> > __read_swap_cache_async_head(..., bool add_to_lru_head)
> > {
> > ...
> > if (add_to_lru_head)
> >   folio_add_lru(folio)
> > else
> >   folio_add_lru_tail(folio);
> > }
> >
> > __read_swap_cache_async(...)
> > {
> >    return __read_swap_cache_async_tail(..., true);
> > }
> >
> > A bit boilerplate? Sure. But this seems safer, and I doubt it's *that*
> > much more work.
> >
>
> Yes=EF=BC=8C agree. I will try it again.

I agree with Nhat here. Unless someone with enough readahead/page
flags knowledge says putting PG_readahead pages at the tail of the LRU
is okay (doubtful), I think we should opt for introducing a
folio_add_lru_tail() as I initially suggested.

