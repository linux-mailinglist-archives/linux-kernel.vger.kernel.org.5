Return-Path: <linux-kernel+bounces-21640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC909829231
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55D0285A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6ED2579;
	Wed, 10 Jan 2024 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rkw20A1T"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB323B1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bb5fda069bso157444739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704850369; x=1705455169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy/+8Nh5YVQL6ancyhJaCNvmncSiIldyq1TK0W/GXJI=;
        b=Rkw20A1TO9GJtEDWypWIiDk06ut8nc7NYZ42D5CgP3nYQOUTHCVC2/SHizzxIZ3qXs
         ANq28MtrasaZ2ube8tl/hL8rXesFV7lCrAg1RCG+Qux8W0yQ+nK7fH0XLOMZLunnTnjU
         pzgqx/Gx0t/y3mhwR5LbCmwQnVMrKGeTOrOrfK8lZGZESjUiyXYW4gO+YIoFqh+a1rWc
         CaGcc05tZMqmJughTyiitKxK3SBqzt4yurLL+BK9xHiQXBQHgJhsFHTpbSpR2xY15EJz
         QJkX9Rfny2BTdHQNgNsyftK38jGNqJXKrV/oIcohbAoH6b3YWMxaa/guwHK8/y6UCMAA
         iZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704850369; x=1705455169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oy/+8Nh5YVQL6ancyhJaCNvmncSiIldyq1TK0W/GXJI=;
        b=jEQFW3RXeRUpd9vC53hHyG3QBIN5jeBIGA06OeSZ12NsVpRg5dLYdXgyxfWThBs155
         +GkFyTuu0Qw3W1DhsjRw1swtfSmbtVrx0zO4WvI12CWvOwI872KJiMSoOL1VwxnZXkKh
         98NEs1NB+DngnWuzd4DRAk6LnvQ05cs/dT0aLhi4Lx/GwWrgwwjmqLg1lxMyFtQl2W28
         MBcF1BRe2IreXmQIDIk3bVm776g89Y1FC7s0lOuD5oSbF8sjH3iJ6GEdu8CTtWltzMj5
         Qk6myNRt3N2KnQnfadLhpQWTDGKX9BfcySHoHbNxFpCd4wQEVnxpduOtewTLwO52hXID
         YP3g==
X-Gm-Message-State: AOJu0YxZ19Hdnq4Y7DFTX/etiKBTw88SzN2k9H1UXx59zYpZF+nPcdsT
	dnz8QcD+WsEMd3nKomFddNA3Ks+KIjauVrKoNwHJsPSVoTM=
X-Google-Smtp-Source: AGHT+IFvauRnV16Rr5gJqSs9omwROWYh0k1h0vtgUKuZrm/hxCDaYclvSr8h4GOJwOKMZFch4kJoXZ+iFppikIYNqXU=
X-Received: by 2002:a5d:8717:0:b0:7be:e84e:9cc8 with SMTP id
 u23-20020a5d8717000000b007bee84e9cc8mr360272iom.31.1704850368958; Tue, 09 Jan
 2024 17:32:48 -0800 (PST)
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
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com> <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
In-Reply-To: <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 9 Jan 2024 17:32:37 -0800
Message-ID: <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 8:30=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Mon, Jan 8, 2024 at 7:13=E2=80=AFPM Zhongkun He <hezhongkun.hzk@byteda=
nce.com> wrote:
> >
> > Hi Yosry, glad to hear from you and happy new year!
> >
> > > Sorry for being late to the party. It seems to me that all of this
> > > hassle can be avoided if lru_add_fn() did the right thing in this cas=
e
> > > and added the folio to the tail of the lru directly. I am no expert i=
n
> > > how the page flags work here, but it seems like we can do something
> > > like this in lru_add_fn():
> > >
> > > if (folio_test_reclaim(folio))
> > >     lruvec_add_folio_tail(lruvec, folio);
> > > else
> > >     lruvec_add_folio(lruvec, folio);
> > >
> > > I think the main problem with this is that PG_reclaim is an alias to
> > > PG_readahead, so readahead pages will also go to the tail of the lru,
> > > which is probably not good.

This sounds dangerous. This is going to introduce a rather large
unexpected side effect - we're changing the readahead behavior in a
seemingly small zswap optimization. In fact, I'd argue that if we do
this, the readahead behavior change will be the "main effect", and the
zswap-side change would be a "happy consequence". We should run a lot
of benchmarking and document the change extensively if we pursue this
route.

> >
> > Agree with you=EF=BC=8C I will try it.
>
> +Matthew Wilcox
>
> I think we need to figure out if it's okay to do this first, because
> it will affect pages with PG_readahead as well.
>
> >
> > >
> > > A more intrusive alternative is to introduce a folio_lru_add_tail()
> > > variant that always adds pages to the tail, and optionally call that
> > > from __read_swap_cache_async() instead of folio_lru_add() based on a
> > > new boolean argument. The zswap code can set that boolean argument
> > > during writeback to make sure newly allocated folios are always added
> > > to the tail of the lru.

Unless some page flag/readahead expert can confirm that the first
option is safe, my vote is on this option. I mean, it's fairly minimal
codewise, no? Just a bunch of plumbing. We can also keep the other
call sites intact if we just rename the old versions - something along
the line of:

__read_swap_cache_async_head(..., bool add_to_lru_head)
{
..
if (add_to_lru_head)
  folio_add_lru(folio)
else
  folio_add_lru_tail(folio);
}

__read_swap_cache_async(...)
{
   return __read_swap_cache_async_tail(..., true);
}

A bit boilerplate? Sure. But this seems safer, and I doubt it's *that*
much more work.

> >
> > I have the same idea and also find it intrusive. I think the first solu=
tion
> > is very good and I will try it. If it works, I will send the next versi=
on.
>
> One way to avoid introducing folio_lru_add_tail() and blumping a
> boolean from zswap is to have a per-task context (similar to
> memalloc_nofs_save()), that makes folio_add_lru() automatically add
> folios to the tail of the LRU. I am not sure if this is an acceptable
> approach though in terms of per-task flags and such.

This seems a bit hacky and obscure, but maybe it could work.

