Return-Path: <linux-kernel+bounces-23002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD982A642
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630A11C232F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A1E8BFB;
	Thu, 11 Jan 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hmrDv3f+"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF779E5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eabfac2b7so5416616e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704941833; x=1705546633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC4cmgp9pWBEGhOBagPxmTGQibwekEdPdcD5cLk/TkM=;
        b=hmrDv3f+KJgtkmPHbLGFCU+jQAyNAYZvM7JwzCXH2jCU5yvHaTnsA5F5L/KjC09QmE
         g4LohI/+r7kIXG+2NwQrG6wGsRPDhTr+UQZAsCxsU/2XwAISYcV0rQlNh0pr4F20TPFN
         /+Y73EzQiMmWIkfjylGAUAtLEXM+SaXOSg3eDeoFGjzqiXaqr/A35bYYT0GQrk6+hV35
         6GBWFRCXT/DIaauzHjhVx/MBInwi1IdXF+/Gwwjy6hXv9e+P7530AvFoBQyuuWTx7Gtt
         92xRrtHZaBr8IwFZiIOL/OjzIipcKCzdd5iRFueN3JqDu0+mXuod61be+XfGI4U1lB5S
         1qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704941833; x=1705546633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OC4cmgp9pWBEGhOBagPxmTGQibwekEdPdcD5cLk/TkM=;
        b=L5XE2SWN5JLFKoBR2+hEgUmeCROLSYeEAOvbcacfPbn2M29SyoAUYVj+yBHjGU5ua4
         eylF+LEtYw01oAs+SmVs7adKznKBsuiAuU5vGSiCzfLdo0Ql9E6SwhUwWAp7Cq9H2DIA
         gPIKLNV8VSX2B6eyO/Gk5PxbyWKZTEeTNfiQBoZTpcHbk3zY3kQxz/BlXkVoX2JJHeyP
         494E00Pz8JA0FqRk/CAAN5GHqOTFAW3Wuae5VMdqtbwU1DYyZwO3ngwRzEjq70Qhy6KH
         2kaHcM6Pbnd9iNygyz17ac9Kf6lZC9fc//RYZQenw2wtbidioOUDYc2/hcXTqFReHgb1
         gi9A==
X-Gm-Message-State: AOJu0YyzXUAlGQei11rCA1Pv851QfnxFnLVUCYyGVgBdFdivMqAFXE7J
	rjtmMFa25v0wE8VcD0aa7tjsisu6f7NFFEWfZuOFmhDTQdlYN62JGbJVhvEIIeGRTQ==
X-Google-Smtp-Source: AGHT+IFi/KHpOgJuGKk7ESds2OVHQsNIjmazI+pALjU16OyAHTb4jPaflRl0/gga27RS1Yj5AeEH4Gym9r/kLZu5u4Y=
X-Received: by 2002:a19:ad4b:0:b0:50e:dc99:b9d4 with SMTP id
 s11-20020a19ad4b000000b0050edc99b9d4mr148314lfd.44.1704941833114; Wed, 10 Jan
 2024 18:57:13 -0800 (PST)
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
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 11 Jan 2024 10:57:00 +0800
Message-ID: <CACSyD1OHLjM8SRURe4QdY5d=JNPY+ZS_goXOKOxO6nuBzxnoHg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, weijie.yang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 12:30=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
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
> >
> > Agree with you=EF=BC=8C I will try it.
>
> +Matthew Wilcox
>
> I think we need to figure out if it's okay to do this first, because
> it will affect pages with PG_readahead as well.

Yes, I've tested it and there is one more thing
that needs to be modified.

+       if (folio_test_reclaim(folio))
+               lruvec_add_folio_tail(lruvec, folio);
+       else
+               lruvec_add_folio(lruvec, folio);

@@ -1583,10 +1583,8 @@ void folio_end_writeback(struct folio *folio)
         * a gain to justify taking an atomic operation penalty at the
         * end of every folio writeback.
         */
-       if (folio_test_reclaim(folio)) {
+       if (folio_test_reclaim(folio) && folio_rotate_reclaimable(folio))
                folio_clear_reclaim(folio);
-               folio_rotate_reclaimable(folio);
-       }

-void folio_rotate_reclaimable(struct folio *folio)
+bool folio_rotate_reclaimable(struct folio *folio)
 {
        if (success=EF=BC=89
+               return true;
        }
+       return false;
 }

>
> >
> > >
> > > A more intrusive alternative is to introduce a folio_lru_add_tail()
> > > variant that always adds pages to the tail, and optionally call that
> > > from __read_swap_cache_async() instead of folio_lru_add() based on a
> > > new boolean argument. The zswap code can set that boolean argument
> > > during writeback to make sure newly allocated folios are always added
> > > to the tail of the lru.
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

I got it.

