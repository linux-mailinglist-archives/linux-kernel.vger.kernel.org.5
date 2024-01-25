Return-Path: <linux-kernel+bounces-38119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F783BB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279161F26D78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4B0175AE;
	Thu, 25 Jan 2024 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTEkWIeh"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061A1758F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169594; cv=none; b=BXvM/VE5V5fRM4vHIBxa5M83TjHl3BiZta2wUOgdnZskOpyKMN+p3MDIDKHEBSN/+UrySjDQyiTFRW1axn9RV6yCkHVHuC/acCfUGxb9qYKBrvOOZXyRoZx3Kl2mDC9I2RMKWHOq6zWgM+BuNWIVuswaTj/gCE4Q48Oi6X6xkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169594; c=relaxed/simple;
	bh=bQELMkFcYFews4tzTwFizOFP2dATmO+CBSBN1CERlhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnB1/JPTqUWrTxzXrNYWOV2CK0ZtS0wf+4LrbArw4HAZLrD9IGrys0LUzWR+ePUgnHot67Y5sL58i5VV9RsYIxtnWtvBme6EHKrOFqY8PzmcyLvkYYQru5YSwOyMMX0LGl+6pLre1w7t7MaD8wvAWkNHSL6G6doJ5KxdyLZXsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTEkWIeh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a30ed6dbdadso217106666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 23:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706169591; x=1706774391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1H6lVGRWuFfz+Z1+0jRYL727Z9vnxtvrMU1rUX5Q8w=;
        b=NTEkWIehmGP4+Y/Xiitej7z/zMJCLUDi9tFgnsS3r3J32mxyDaryfUAjzLSFf/1/FB
         2DaAH/+Gj5boKvUFXBGmX7POADzTo3g76X0S9x97/7Y4Z7mBEw9btS6XolpojDGcJ9qg
         TW+GT1xb1aUkAmrihLBlhFmGRkeVNUlVC+gKeCZDawEP/ag4lTEhMUxapDiS4UoXc9kQ
         qPLqyYeYrrXL0gx7XIUqDBYT0I62lUm//wZdoKVPHxXfViJP7ljEAwzPdmifWUOZKmHc
         52YE6FnSOBNHyqo+wSMCe26TabeRjiE1dZxTa0G+u3GwhSvmI2JPEvzpxugD5D1RFSOC
         1iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706169591; x=1706774391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1H6lVGRWuFfz+Z1+0jRYL727Z9vnxtvrMU1rUX5Q8w=;
        b=jCCQmq8xgH4EvW9cW1kF5e4aoijql0EmqYtkMjo385zLsvbKu53bBUF/vFPnOWqcsz
         DAun8MInreWCPB8HkKaHKWfbwICiMfSOe1Fn/fQquujCxx1kACJtIfX0onkkVoy3eMZb
         FGDlgwm17nJUSAU5IF4saEhLFY+U93tiAlnsEFJtf6MrHnG3jS13+cWOEI+0GdHscnUk
         Y9CSzVbMFo1KQ2JQJslG1IIk1P4SdxSYBJmaug1jfsqSpSGSS78GCYt96FdXvH2Uct+o
         7tOUnJvixYGykhFldBXsKhayRTXOuOmcdVXJCFUE7/7mMmJH7eU++JW5cn+tb/NScKt4
         ZkYA==
X-Gm-Message-State: AOJu0YwK43tr75JUT0we4bEm1m+2A5gWvbBFfxBDT8hima3vchdpnee2
	lf7NbxPjzm550eKjl0S5WmQV+nGmfuLBaME6ZvryISGwPIQA/VcdYIYzZ3NumTNrs71lkubCarA
	vJ4CuYm9bdeZesgiO4kv7ij3rCl8VP1P6aCAd
X-Google-Smtp-Source: AGHT+IEvyok96y4xvtk9mejVkFC+Yj+gray9xkaI9A2frC6J9UtpcfEu2BzocGyZkRxBJTYr6tHNwqdIbQMto9kX8ow=
X-Received: by 2002:a17:906:b78c:b0:a2c:88d3:754c with SMTP id
 dt12-20020a170906b78c00b00a2c88d3754cmr349013ejb.40.1706169590452; Wed, 24
 Jan 2024 23:59:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org> <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
 <CAJD7tkaVdJ9B_UDQs+o1nLdbs62CeKgbCyEXbMdezaBgOruEWw@mail.gmail.com> <CAF8kJuNkwGNw=Nnu1MVOewKiqT0ahj5DkKV_Z4VDqSpu+v=vmw@mail.gmail.com>
In-Reply-To: <CAF8kJuNkwGNw=Nnu1MVOewKiqT0ahj5DkKV_Z4VDqSpu+v=vmw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Jan 2024 23:59:14 -0800
Message-ID: <CAJD7tkZViJot2+vFr_yAyRsRf7jTRPsb8wchqkf4R1tSsvLG+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Chris Li <chriscli@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 9:29=E2=80=AFPM Chris Li <chriscli@google.com> wrot=
e:
>
> Hi Yosry,
>
> On Tue, Jan 23, 2024 at 10:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
>
> > >
> > > Thanks for the great analysis, I missed the swapoff/swapon race mysel=
f :)
> > >
> > > The first solution that came to mind for me was refcounting the zswap
> > > tree with RCU with percpu-refcount, similar to how cgroup refs are
> > > handled (init in zswap_swapon() and kill in zswap_swapoff()). I think
> > > the percpu-refcount may be an overkill in terms of memory usage
> > > though. I think we can still do our own refcounting with RCU, but it
> > > may be more complicated.
> >
> > FWIW, I was able to reproduce the problem in a vm with the following
> > kernel diff:
>
> Thanks for the great find.
>
> I was worry about the usage after free situation in this email:
>
> https://lore.kernel.org/lkml/CAF8kJuOvOmn7wmKxoqpqSEk4gk63NtQG1Wc+Q0e9FZ9=
OFiUG6g@mail.gmail.com/
>
> Glad you are able to find a reproducible case. That is one of the
> reasons I change the free to invalidate entries in my xarray patch.
>
> I think the swap_off code should remove the entry from the tree, just
> wait for each zswap entry to drop to zero.  Then free it.

This doesn't really help. The swapoff code is already removing all the
entries from the trees before zswap_swapoff() is called through
zswap_invalidate(). The race I described occurs because the writeback
code is accessing the entries through the LRU, not the tree. The
writeback code could have isolated a zswap entry from the LRU before
swapoff, then tried to access it after swapoff. Although the zswap
entry itself is referenced and safe to use, accessing the tree to grab
the tree lock and check if the entry is still in the tree is the
problem.

>
> That way you shouldn't need to refcount the tree. The tree refcount is
> effectively the combined refcount of all the zswap entries.

The problem is that given a zswap entry, you have no way to stabilize
the zswap tree before trying to deference it with the current code.
Chengming's suggestion of moving the swap cache pin before accessing
the tree seems like the right way to go.

> Having refcount on the tree would be very high contention.

A percpu refcount cannot be contended by definition :)

