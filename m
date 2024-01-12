Return-Path: <linux-kernel+bounces-24353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C945D82BB78
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A361F25820
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5F55C902;
	Fri, 12 Jan 2024 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gwDTPXA0"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91C381B7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e78f1f41fso6488387e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 23:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705043348; x=1705648148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2axIAZPMzrhQEXZe+OtGDs+tak3gwoRFY7MWaUZjPE=;
        b=gwDTPXA0XNHWuCTr4lrRjuH+H++qCt2HOG8w4waSsA/kp/l6/mX89orijCSRPM45tD
         2oNryQe2FaCNOI/8QZFPlyZL3vSYsSVU6NonwkDximFyh/HdR5QH1xP8z8XIlVAme9ji
         4JeownQokalfANRa/eoxva1myYLpEDiTPgraPkGnzyI4ZuoDMnchhUElB/mtUEMHx9UB
         y++M0pwhShEPxF0guKsVKQD5YUY0iZM0MmiJdgLl4ocZPcM+wVCKjmahEBy/I3exEa36
         SJVqpuMzmUNPYjQ4mfa2mavS1QGbQF9sOHwPZPnFL0Kh6V8m3JWzvUzGbgjVBM+zOwOs
         knyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705043348; x=1705648148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2axIAZPMzrhQEXZe+OtGDs+tak3gwoRFY7MWaUZjPE=;
        b=fmvO0aQO9nZm2jVnL+bGoDEN9nHSjj/a0MTTpXNuktEC9BiKjZ58GUnk1AmcdgrqQ7
         6YSpDyjHa2KbZTOhgTHORxpFHql7i71GMZv5dnCoTtJNpAWMDD6T9nipqF9Hsal+venc
         5iw9MFzT3fy4uE/oVwrJyNbszB5wIak+Zm8kqY48lBEYspB7541+4fgG5vkS4Ckuk3lM
         t92qibalb4ZxR+a98d3EHpbWxjZn0b9c8tNo4yKU/efG0bBbJXzKIiuN/HIgbpnV7iRN
         YO7VY6jmJoCLJ/M9NwuiKtMuZvTVv/OuB1O6GZfN9dfwMjQw3gRAaUf5f3N+jmpj+tKQ
         cCtA==
X-Gm-Message-State: AOJu0YxuuklffnRAoPoMRQsfPh1L0/BwdvfAKxfXAHQC7ysl5+SX6iJQ
	n9tJV+BXBokzWPJ4aO1z4doDiP/snalkALFj35cqP8oqzkbr5A==
X-Google-Smtp-Source: AGHT+IHlIZs0OR6a4sDwKPWdFqFXG+l9K8s9gqZcD9ZAf7IQnYsQgAB4rz2ercoFOLwQCg5T3wkbHblPGlddWKM3zj0=
X-Received: by 2002:ac2:4c05:0:b0:50e:27a9:167e with SMTP id
 t5-20020ac24c05000000b0050e27a9167emr348204lfq.59.1705043348345; Thu, 11 Jan
 2024 23:09:08 -0800 (PST)
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
 <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
 <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com> <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com>
In-Reply-To: <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Fri, 12 Jan 2024 15:08:54 +0800
Message-ID: <CACSyD1NgqoFKuHSgdw_bzgK_StsLrNQ+7wHVBqsnHcB-2rD2ow@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 3:25=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Wed, Jan 10, 2024 at 7:49=E2=80=AFPM Zhongkun He
> <hezhongkun.hzk@bytedance.com> wrote:
> >
> > >
> > > This sounds dangerous. This is going to introduce a rather large
> > > unexpected side effect - we're changing the readahead behavior in a
> > > seemingly small zswap optimization. In fact, I'd argue that if we do
> > > this, the readahead behavior change will be the "main effect", and th=
e
> > > zswap-side change would be a "happy consequence". We should run a lot
> > > of benchmarking and document the change extensively if we pursue this
> > > route.
> > >
> >
> > I agree with the unexpected side effect,  and here I need
> > to clarify the original intention of this patch.Please see the memory
> > offloading steps below.
> >
> >
> > memory      zswap(reclaim)          memory+swap (writeback)
> > 1G                 0.5G                        1G(tmp memory) + 1G=EF=
=BC=88swap=EF=BC=89
> >
> > If the decompressed memory cannot be released in time,
> > zswap's writeback has great side effects(mostly clod pages).
> > On the one hand, the memory space has not been reduced,
> > but has increased (from 0.5G->1G).
> > At the same time, it is not put the pages to the tail of the lru.
> > When the memory is insufficient, other pages will be squeezed out
> > and released early.
> > With this patch=EF=BC=8C we can put the tmp pages to the tail and recla=
im it
> > in time when the memory is insufficient or actively reclaimed.
> > So I think this patch makes sense and hope it can be fixed with a
> > suitable approaches.
>
> Makes sense to me. IIUC, that's the original intention behind calling
> SetPageReclaim() - unfortunately that doesn't work :) And IIRC, your
> original attempt shows reduction in swap usage (albeit at the cost of
> performance regression), which means we're onto something. I believe
> that the folio_lru_add_tail() approach will work :)
>
> Please include a version of the clarification paragraph above in your
> later version to explain the goal of the optimization, along with
> suitable benchmark numbers to show the effect (such as minimal change
> in performance, and reduction in some metrics). Maybe include the link
> to the original patch that introduces SetPageReclaim() too, to show
> the motivation behind all of this :) It'd be nice to have all the
> contexts readily available, in case we need to revisit this in the
> future (as was the case with the SetPageReclaim() here).
>

OK.

> >
> > >
> > > Unless some page flag/readahead expert can confirm that the first
> > > option is safe, my vote is on this option. I mean, it's fairly minima=
l
> > > codewise, no? Just a bunch of plumbing. We can also keep the other
> > > call sites intact if we just rename the old versions - something alon=
g
> > > the line of:
> > >
> > > __read_swap_cache_async_head(..., bool add_to_lru_head)
> > > {
> > > ...
> > > if (add_to_lru_head)
> > >   folio_add_lru(folio)
> > > else
> > >   folio_add_lru_tail(folio);
> > > }
> > >
> > > __read_swap_cache_async(...)
> > > {
> > >    return __read_swap_cache_async_tail(..., true);
> > > }
> > >
> > > A bit boilerplate? Sure. But this seems safer, and I doubt it's *that=
*
> > > much more work.
> > >
> >
> > Yes=EF=BC=8C agree. I will try it again.
>
> Look forward to seeing it! Thanks for your patience and for working on th=
is.

Thanks for your time.

