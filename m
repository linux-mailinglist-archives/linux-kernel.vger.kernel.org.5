Return-Path: <linux-kernel+bounces-48861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477A3846276
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41C91F273D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07391405F7;
	Thu,  1 Feb 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn0Kx9Wy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402FA39AE1;
	Thu,  1 Feb 2024 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821768; cv=none; b=jZrUo7iK7J1S5zVtwisM7gBag0d4s4s6Cn87i/UkoQAB2r4WG7RDhfcFuISJYe9j2JA2fTbVdbK6A1v9JsS0/aBpjRRPNLH9ApgOboSy76oxSdMkc81UqsvPsO+IphPrgZC+swhuGD9w2IbWtBjXD9223xVD0uGck280H+De0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821768; c=relaxed/simple;
	bh=6v01RU+zLBfMH3ycqivUxPJyd9tsVfriHpIcjMGbkes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QG24YDyc7uIWDgX65NpZH0OkRpOJUMFnylAL7YLr0XyFri1rbr0zE1aW8GCDdWTcXIYW3K5iRnArX7xdBsWB6CU8CTbNFUzhHGWoEMb93w2XMsXuz+6fjFE4sIApFILohe8rqIIiEj50nAx5McyRUECtE2AXe4hPRSwln8XHugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn0Kx9Wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3994C43390;
	Thu,  1 Feb 2024 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706821767;
	bh=6v01RU+zLBfMH3ycqivUxPJyd9tsVfriHpIcjMGbkes=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bn0Kx9WybaQsW2pRh0Btwv1/jeZ9YrtkMLOy6D5HjMROH6mqJVGRuzWEkekfQt79H
	 szsqxSalbLFCLrIMbRzgdWINX8HtTO6iySGW5iDstwAMfsP8x5RQJkFtaWt48nIZpR
	 cp5sVZbAt0/wmSmAL4AjES7fV5+LhBCp2E3SqxF0g9aSTKtzNAmbPCHv0FPFcjvlHd
	 kdre5oOfR9jsPfz9SmN/9TNbIsEqEcee2U78ZOLJOIAdYG+IfmG30H2Q16gmYRmgQV
	 CZUjS9z8GsDB70D548p52Q3fGmsOw1uZ1MOl/aXm6gwzGBTBGA5aKXYW7DXuXUlcsi
	 RTXv55zbNJCYw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-510322d5363so2184835e87.1;
        Thu, 01 Feb 2024 13:09:27 -0800 (PST)
X-Gm-Message-State: AOJu0Yw+oIAqPPuCZopbuQyYPyTHkoRlakKS+43mqLiRwfqnSkwtRthL
	qzwP39waWHmT/ttGBPsK4bVs0tYUdD+QLJHApsJXzzuIowVr1JjeUMU0gaO2CjD084WilVc5MdN
	EnEAmu0JUE8lNHNpr4RVqgIelOQ==
X-Google-Smtp-Source: AGHT+IESdk8xIEMiHdjhEcwakMNvof5/KilzUrpxx4OTDQHF0zbvvJoEq0dv0O8IGj/3mjZHLvI28EeOsT5B/gQ7v60=
X-Received: by 2002:a05:6512:3b0:b0:511:21e4:5a69 with SMTP id
 v16-20020a05651203b000b0051121e45a69mr2724946lfp.40.1706821765984; Thu, 01
 Feb 2024 13:09:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130105236.3097126-1-dawei.li@shingroup.cn>
 <20240130105236.3097126-2-dawei.li@shingroup.cn> <20240131212938.GB2303754-robh@kernel.org>
 <F096F87333105368+Zbtr1h1ryCvzA3fB@centos8>
In-Reply-To: <F096F87333105368+Zbtr1h1ryCvzA3fB@centos8>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Feb 2024 15:09:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLC0_mLmgtATkh48963n-GrkHE-MryD_=MN5sNWBeq_RA@mail.gmail.com>
Message-ID: <CAL_JsqLC0_mLmgtATkh48963n-GrkHE-MryD_=MN5sNWBeq_RA@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: Introduce __of_phandle_update_cache
To: Dawei Li <dawei.li@shingroup.cn>
Cc: frowand.list@gmail.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, set_pte_at@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 4:01=E2=80=AFAM Dawei Li <dawei.li@shingroup.cn> wro=
te:
>
> Hi Rob,
>
> Thanks for reviewing,
>
> On Wed, Jan 31, 2024 at 03:29:38PM -0600, Rob Herring wrote:
> > On Tue, Jan 30, 2024 at 06:52:35PM +0800, Dawei Li wrote:
> > > For system with CONFIG_OF_DYNAMIC=3Dy, device nodes can be inserted/r=
emoved
> > > dynamically from device tree. Meanwhile phandle_cache is created for =
fast
> > > lookup from phandle to device node.
> >
> > Why do we need it to be fast? What's the usecase (upstream dynamic DT
> > usecases are limited) and what's the performance difference? We'll
> > already cache the new phandle on the first lookup. Plus with only 128
> > entries you are likely evicting an entry.
>
> I read the history changelog and get that a _lot_ of lookup has been
> taken before of_core_init(), so the update of cache in lookup operation
> mean a lot to performance improvement.

Yes, and there was compelling data on the performance difference to
justify the added complexity.

> > > For node detach, phandle cache of removed node is invalidated to main=
tain
> > > the mapping up to date, but the counterpart operation on node attach =
is
> > > not implemented yet.
> > >
> > > Thus, implement the cache updating operation on node attach.
> >
> > Except this patch does not do that. The next patch does.
>
> Agreed.
>
> >
> > >
> > > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> > > ---
> > >  drivers/of/base.c       | 16 ++++++++++++++++
> > >  drivers/of/of_private.h |  1 +
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > > index b0ad8fc06e80..8b7da27835eb 100644
> > > --- a/drivers/of/base.c
> > > +++ b/drivers/of/base.c
> > > @@ -163,6 +163,22 @@ void __of_phandle_cache_inv_entry(phandle handle=
)
> > >             phandle_cache[handle_hash] =3D NULL;
> > >  }
> > >
> > > +void __of_phandle_update_cache(struct device_node *np, bool lock)
> > > +{
> > > +   u32 hash;
> > > +
> > > +   if (lock)
> > > +           lockdep_assert_held(&devtree_lock);
> >
> > I don't think this is a good use of a function parameter.
>
> Yep, assertion under condition is odd.
>
> >
> > > +
> > > +   if (unlikely(!np || !np->phandle))
> > > +           return;
> > > +
> > > +   hash =3D of_phandle_cache_hash(np->phandle);
> > > +
> > > +   if (!phandle_cache[hash])
> > > +           phandle_cache[hash] =3D np;
> >
> > Okay, so you don't evict existing entries. I'm not sure what makes more
>
> Yes, the updating policy of dynamic nodes is exactly same with static nod=
es
> (the ones in of_core_init()), no eviction/invalidation on _existing_ cach=
e
> involved.
>
> > sense. I would imagine old entries are less likely to be accessed than
>
> Well, I don't think we are gonna implement a full-fledged cache replacing
> algorithm such as LRU.
>
> > new phandles for just added nodes given DT is kind of parse it all once
> > (e.g. at boot time). Again, need to understand your usecase and
> > performance differences.
>
> It's kinda awkward that no such usecases/stats are available for now.
>
> My motivation is simple as that:
> As long as detached nodes are supposed to be removed from cache entries,
> the newly inserted nodes should be added to cache entries, it is more
> balanced and symmetric.

The difference is that no entry for attach works fine while accessing
a detached node that may have been freed would be a problem.

Rob

