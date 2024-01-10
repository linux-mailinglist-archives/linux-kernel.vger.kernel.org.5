Return-Path: <linux-kernel+bounces-22655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876882A0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5248281653
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D824EB27;
	Wed, 10 Jan 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fG4/0U93"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B244EB22
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 19:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbed179f0faso3709628276.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 11:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704914655; x=1705519455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00Yi17YMYf+/drsG/cIwBnmgomwMdlxbviIy1sqifXU=;
        b=fG4/0U933WQXj73VK2hsqaHJiCASBCtnDnooc40hmELV7E9JmZBdSXEax5C5ecTIts
         Kgy2G6O6GVJNM3GNN7hH/3MxaG8VKGl1I9b6hs3BaT7P0jUCewAinzE0xoSchFyNE49o
         e/VGIH2X25jywU4gAv/uxgUaRV1gaPW802gzIDsgzpCuJyO0w3FpZuVFJrLhyPPyapPO
         5djdgTsAcya7Eqm+bZSI98XhfGXm0cIm/VX5d3VosPlgKhfKfwcP8f7W7QoMkykTZFv+
         krpeoK+aZFLocvqJaI1HhYabG0HFa3fIffBc2n1OFC/LTO6z5muglYoTxjejyAmdG0Dx
         hU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704914655; x=1705519455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00Yi17YMYf+/drsG/cIwBnmgomwMdlxbviIy1sqifXU=;
        b=htud+k9WFGFrLFr0aNyW9BCedn70pfk0fjuVj9ks0CnWA/bMR5aXCabyaUbNIE88ck
         n0DBl2XqoO6+aElSzeEQ5v+bpcpL1fm7esk0IMz9paB5K2KtukPucnU3aZHwoa29OS6h
         dK+3NjFEcHVTudLIuc/Vpyb9fbUfosPc4wnsZEqY2r23hKDnvTMfDUOWQd0sDKeo49Bf
         OJInP5TRLef0y6NQ18ahIvPjJ8H//rUVLjq8GwAAhN+ort5feGG8AxezrqovEhXfiUip
         xZWT0sfN75sICqah/kzOODUSr+wnia9dIdeA+HYr7uQk5mWPyg/hvbSDekkkuVdMo47P
         IUIA==
X-Gm-Message-State: AOJu0YyjMbZL8iBvZHRLmBMtjgwGFgN+4A2XaqV3mKoaqOqvxSjcx5Eu
	NNw02Any/PTBY9Zb5tjCDbYcAHBODxa9EEDy4GJqJDs0Zf+g
X-Google-Smtp-Source: AGHT+IGK59DptdLBDkoMvQ5Mq82HCYvcaLO4aXCyrQUiVlQWIeFXtW818NFvZMbl9+P3PeQrUjB7YlAScK90ulv7518=
X-Received: by 2002:a25:a121:0:b0:dbd:e213:4122 with SMTP id
 z30-20020a25a121000000b00dbde2134122mr359240ybh.35.1704914654914; Wed, 10 Jan
 2024 11:24:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <931f2e6d-30a1-5f10-e879-65cb11c89b85@google.com> <20231222154037.62823-1-henry.hj@antgroup.com>
In-Reply-To: <20231222154037.62823-1-henry.hj@antgroup.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 10 Jan 2024 11:24:02 -0800
Message-ID: <CAJj2-QG3jJcA=71n5imx+OjhMapPMN-1bfT5XQRjswxOPG9MvA@mail.gmail.com>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
To: Henry Huang <henry.hj@antgroup.com>
Cc: rientjes@google.com, akpm@linux-foundation.org, 
	=?UTF-8?B?6LCI6Ym06ZSL?= <henry.tjf@antgroup.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?= <teawater@antgroup.com>, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:40=E2=80=AFAM Henry Huang <henry.hj@antgroup.com>=
 wrote:
> > - are pages ever shared between different memcg hierarchies?  You
> >   mentioned sharing between processes in A and A/B, but I'm wondering
> >   if there is sharing between two different memcg hierarchies where roo=
t
> >   is the only common ancestor?
>
> Yes, there is a another really common case:
> If docker graph driver is overlayfs, different docker containers use the
> same image, or share same low layers, would share file cache of public bi=
n or
> lib(i.e libc.so).
Does this present a problem with setting memcg limits or OOMs? It
seems like deterministically charging shared pages would be highly
desirable. Mina Almasry previously proposed a memcg=3D mount option to
implement deterministic charging[1], but it wasn't a generic sharing
mechanism. Nonetheless, the problem remains, and it would be
interesting to learn if this presents any issues for you.

[1] https://lore.kernel.org/linux-mm/20211120045011.3074840-1-almasrymina@g=
oogle.com/
>
> > - do you anticipate a shorter scan period at some point?  Proactively
> >   reclaiming all memory colder than one hour is a long time :)  Are you
> >   concerned at all about the cost of doing your current idle bit
> >   harvesting approach becoming too expensive if you significantly reduc=
e
> >   the scan period?
>
> We don't want the owner of the application to feel a significant
> performance downgrade when using swap. There is a high risk to reclaim pa=
ges
> which idle age are less than 1 hour. We have internal test and
> data analysis to support it.
>
> We disabled global swappiness and memcg swapinness.
> Only proactive reclaim can swap anon pages.
>
> What's more, we see that mglru has a more efficient way to scan pte acces=
s bit.
> We perferred to use mglru scan help us scan and select idle pages.
I'm working on a kernel driver/per-memcg interface to perform aging
with MGLRU, including configuration for the MGLRU page scanning
optimizations. I suspect scanning the PTE accessed bits for pages
charged to a foreign memcg ad-hoc has some performance implications,
and the more general solution is to charge in a predetermined way,
which makes the scanning on behalf of the foreign memcg a bit cleaner.
This is possible nonetheless, but a bit hacky. Let me know you have
any ideas.
>
> > - is proactive reclaim being driven by writing to memory.reclaim, by
> >   enforcing a smaller memory.high, or something else?
>
> Because all pages info and idle age are stored in userspace, kernel can't=
 get
> these information directly. We have a private patch include a new reclaim=
 interface
> to support reclaim pages with specific pfns.
Thanks for sharing! It's been enlightening to learn about different
prod environments.

