Return-Path: <linux-kernel+bounces-24007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5340982B530
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AB91F25D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974954FB4;
	Thu, 11 Jan 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdUu5dX8"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267323CA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bed944f553so130802439f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705001129; x=1705605929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg6FnkVOdWEv0+8ytRIEDXW7BwqBOcvuaxdwffWiGI0=;
        b=LdUu5dX8/P3biQturS00dvvltV9+zl+H/BixXPc0ZdaGHxxAXwQpcYlEIEPdKYBne1
         MJCVLM/8N62/A75iqxe/Lb0XLJqOA4mvQ3o/MLchUfz4YJDCWYRaenM0FVgPciSd9JDv
         a7tOhqZKePKIOuyq8k3xszYKA+gLL7rJcSof+Wo2kdRh6YO6ClFQMFfuf5YEfsii56Es
         odvRpm0a1Yy8/El+3NS0/Del45/1XYWCbm8TuLQEcofvisQF2ULqM5uBQq8Eg5O1bJwG
         iyEjKQAtcmZVX/V6/aYgBA4pXDIiU+myZ5UbUUfWBmLplQ/mVN4REAgvFBpaprzl4DRA
         quFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705001129; x=1705605929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vg6FnkVOdWEv0+8ytRIEDXW7BwqBOcvuaxdwffWiGI0=;
        b=j+k0pChOUMrUcZOR/AMa/qDTBnP5NK4ggsuBIoFXl4lTbxNtF9yAmjUP37Cq0iB6dK
         a6OtEoLFrA8D/rkANB3qNS0UVEr16FjqyO6Y5OskexhLL9MJgx2qVOL7wDR2IlOX+u1d
         bb9g3+ShRRP7PwKMZkOq3VoJ0vz7tHtpiDbSLnnLbhnT2pxh+4SgoMRRkCt2/VOinp+8
         EyILWqhw4cH4glRodn+eqbQ+d00eFqs/vkDiC67N9I2q0gLGjnPZXN9GwegH7zKU2BgW
         +HnJNYCDJQqLhOrT48LRSztOyfWYEFi41XphLGEBvBF4OsqDdil52CwGa8Ei9JPBRRks
         8sug==
X-Gm-Message-State: AOJu0YzDu3fecmb4A5CBWjxdmJNpPuKs3TJsTktkAe1VJfc7lM6+j2Wp
	48tdA5Hz0hwXeQyCXBYlP6yaxjmpTMLNmDy2SzU=
X-Google-Smtp-Source: AGHT+IHE+qXVynwxYNyO5DvdOo23alqFfocIn59zqDm7cPaShqSZHiYuVVyN6gJUAu6G5pb6cEnkqXug0iax5iy0E1A=
X-Received: by 2002:a6b:f107:0:b0:7ba:b744:bb0 with SMTP id
 e7-20020a6bf107000000b007bab7440bb0mr160243iog.35.1705001129464; Thu, 11 Jan
 2024 11:25:29 -0800 (PST)
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
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 11 Jan 2024 11:25:18 -0800
Message-ID: <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
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

Makes sense to me. IIUC, that's the original intention behind calling
SetPageReclaim() - unfortunately that doesn't work :) And IIRC, your
original attempt shows reduction in swap usage (albeit at the cost of
performance regression), which means we're onto something. I believe
that the folio_lru_add_tail() approach will work :)

Please include a version of the clarification paragraph above in your
later version to explain the goal of the optimization, along with
suitable benchmark numbers to show the effect (such as minimal change
in performance, and reduction in some metrics). Maybe include the link
to the original patch that introduces SetPageReclaim() too, to show
the motivation behind all of this :) It'd be nice to have all the
contexts readily available, in case we need to revisit this in the
future (as was the case with the SetPageReclaim() here).

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

Look forward to seeing it! Thanks for your patience and for working on this=
.

