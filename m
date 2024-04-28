Return-Path: <linux-kernel+bounces-161374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6C48B4B45
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608D81F213BC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70AF3FB2F;
	Sun, 28 Apr 2024 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guWRDSzT"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561521101;
	Sun, 28 Apr 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714300615; cv=none; b=pjKX2WjZgL8iIOn/kLRk/ByO6NVSgQKTVws1JKuMWcewZoENRu8NKQdo7eFDQmNEsVUbtK+jdFp4E+daDrHVlgJsNruSO5IETk32ajju/Cfss/88cMmJT6vro7cpuu7IRUAWaQe/KD4h038TaRCNXoGDDWbqcq+WtacViIeeXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714300615; c=relaxed/simple;
	bh=A3nivpRe23n35pamaYeQ0NQo4GANL/bYE1cAUfQv3ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTQI0LxrwOvTiJkEp4OuOlWIhRul7DccageVG/tvqHBW2OLQBBkXTDadS8bjohG7UFLNTwrLU4lL5BAk645HMQz6qRB9yJJB1jaxPhED3SNJVHr4jdkyRmHJ4RXV3O36wzKjCLL1LGTF+M/Nt0pIpiWsQWZPEewJf7MQ4jPxeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guWRDSzT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51ae315bb20so4261914e87.1;
        Sun, 28 Apr 2024 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714300612; x=1714905412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3nivpRe23n35pamaYeQ0NQo4GANL/bYE1cAUfQv3ns=;
        b=guWRDSzT/woGVEnn+h3lmqSXzjFX/Pg9Sbm54hzK54t7GgabRQV6mlt7v2UAmEule3
         Zehw+4gpd1joqkf5sGQ8hFVdy1/IuCjYq6zwTYfk0jrK6mhLZ8flFU59mESrGwBjkmX7
         WTY3ZgTj9WMnoLCPELqL91cXJDuq0e/MhNMX9T3Ij4722CZV+3j70IxqWCFqLkSlURAC
         U6TNI+oe8B0naC7rjCt6Tib18TGnEY/qETrkplEsKYicLf+VTBojzgta/uYC9CfAro1l
         M4QQmn2MZZDh0SS//zyxETEKdRy71HM87RpQ4tBQuIvYz3KruJoStXFyTtmVVQLmCaVu
         os7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714300612; x=1714905412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3nivpRe23n35pamaYeQ0NQo4GANL/bYE1cAUfQv3ns=;
        b=iT7TCvbTDavCXq8NQb1WmTKS64sJIfLgydvFmV87j7scA+QaaUMKlTpvVZxRwUN2iL
         UR0kfkPMpu8vPKUDbT0eolZAx3kxhQLMUb2FbwVQ6OSCb7U8/T9Hpbp+XwbJ+bNxiv0G
         Quu/z2NgqPHFugiwcUkc7pWpvsD/PiJIk6pDnQoj5YtnO2ATZhcPucwNv2z2d9P1KSru
         IpJObcdCNYXFgyKUpKehsuIoK9IbpcVuvt1y3c5+iFFQmLw5g7CPcmA+CV4OaeJCpNjz
         JToTrAH+lWc6cTs8UCdyUkFPPkcmW+wZTl3k5hn9EbldjRkWcRQjllJomGue13YWrgQ1
         O8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUoHr9OMZpZtp9bSLJd04sDXzUeWwn4jVBrMqkYimUz1HeJmGKwOdzu7LuEBQDT9kz9N3sk3nWeXVcUzY4rCiF96IZWkgytWNz9Jf5lpfgMr0IEpf/daM+COjwaN6eP+jtaY874C8Rfg==
X-Gm-Message-State: AOJu0Yz4OQmDRoamemydAxfrObXx0WaN7YGouVUxRI2auH670q6eF5YT
	MJET/sDrS8/luK0kcsh39NK8FSXxJViBSLsiM0xVXeo+GQ+Q27MioXPHTaSgRQYtdG22CdD/U8Z
	tS6LPjGgjatPK1aijQMMwNNBAVeSRFVfl
X-Google-Smtp-Source: AGHT+IH/DaS669Bmyaz9/X/48TD9TThgeNs7jYyoIAffpLAI+oq1Xd0RSZ+Q9R5j/jQkIkEOPbhalxhibL/MZSvUjXQ=
X-Received: by 2002:a05:6512:3f17:b0:51a:a400:785e with SMTP id
 y23-20020a0565123f1700b0051aa400785emr5299909lfa.43.1714300612066; Sun, 28
 Apr 2024 03:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linux-mm@kvack.org> <20240416120635.361838-1-skseofh@gmail.com>
 <20240416120635.361838-2-skseofh@gmail.com> <Zh9l_LpThq9aFUR7@kernel.org>
 <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com>
 <ZiFgYWydIwvnpIIY@kernel.org> <CAATEi5kFt8iUeWSkrj_bVTyPO_tfQzG77D719P5dLsr2j6Zkzw@mail.gmail.com>
 <CAATEi5ksY-v7-LEqNZWFV5hsHiegNEtrh4LpMWOQ=vT7hC0Rng@mail.gmail.com>
 <Ziy8AsAGZyKCyXX_@kernel.org> <CAATEi5=Z0qirM-fyGJL_UPcr7-iyCFtOW9d3XsdN50Tkhpm0iA@mail.gmail.com>
 <Zi3twYLGvhtJa9Yh@kernel.org>
In-Reply-To: <Zi3twYLGvhtJa9Yh@kernel.org>
From: DaeRo Lee <skseofh@gmail.com>
Date: Sun, 28 Apr 2024 19:36:40 +0900
Message-ID: <CAATEi5nOQE7xi5ztV0BFO6MRqSGwUPT4V9dqpMT+p4r7iZQwRQ@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
To: Mike Rapoport <rppt@kernel.org>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Daero Lee <daero_le.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 28=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 3:35, M=
ike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Apr 27, 2024 at 07:24:23PM +0900, DaeRo Lee wrote:
> > 2024=EB=85=84 4=EC=9B=94 27=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 5:5=
0, Mike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Fri, Apr 19, 2024 at 10:59:52AM +0900, DaeRo Lee wrote:
> > > > 2024=EB=85=84 4=EC=9B=94 19=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84=
 10:46, DaeRo Lee <skseofh@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > > > >
> > > > > In memmap_init_reserved_pages, we mark memblock.reserved as
> > > > > PageReserved first and mark the memblock.reserved with nomap flag
> > > > > also.
> > > > Sorry. This is my mistake. 'memblock.memory with nomap flag' is rig=
ht.
> > > >
> > > > > -> Isn't this duplicated work? (If we add no-map region to
> > > > > memblock.reserved 'and' mark in memblock.memory..)
> > > > > So, I think that for the no-map region, we don't need to add to t=
he
> > > > > memblock.reserved.
> > > > > This is what we do now in early_init_dt_reserve_memory. the nomap
> > > > > region is not added to the memblock.reserved.
> > > > >
> > > > > In early_init_dt_alloc_reserved_memory_arch, if 'nomap' is true, =
we
> > > > > mark the memblock.memory region as _NOMAP. And if the return valu=
e
> > > > > 'err' is not zero(which is '-ENOMEM' from memblock_isolate_range)=
, we
> > > > > free the region.
> > > > > - 'nomap' is true -> memblock_mark_nomap : success -> not free th=
e region
> > > > >
> > > > > : fail -> free the region
> > > > > And it can be said that we add the region to the memblock.reserve=
d
> > > > > using memblock_phys_alloc_range and if the region is nomap, then =
we
> > > > > can free the region from memblock.reserved. But is it necessary t=
o add
> > > > > it to memblock.reserved? We just need the region in memblock.memo=
ry to
> > > > > mark nomap.
> > > > >
> > > > > So, here is what I think:
> > > > > - reserved-memory w/ nomap region -> mark only to memblock.memory
> > > > > - reserved-memory w/o nomap region -> add to the memblock.reserve=
d
> > >
> > > NOMAP and memblock.reserved are semantically different, and at makes =
sense
> > > to have a "reserved nomap" node in fdt recorded in both memblock.memo=
ry and
> > > memblock.reserved.
> > >
> > > memblock.reserved represents the memory that is used by firmware or e=
arly
> > > kernel allocation, so reserved memory in fdt should be reserved in me=
mblock
> > > as well. I believe it's an oversight that early_init_dt_reserve_memor=
y()
> > > does not call memblock_reserve() for nomap memory.
> > >
> > > NOMAP is a property of a memory region that says that that region sho=
uld
> > > not be mapped in the linear map, it's not necessarily in use.
> >
> > I agree that the NOMAP region should be added to memblock.reserved.
> >
> > So, I think we need to clean-up memmap_init_reserved_pages, because in
> > this function we call reserve_bootmem_region for memblock.reserved and
> > memblock.memory with nomap. We don't need to call
> > reserve_bootmem_region for nomap.
>
> Read the comment about memblock_mark_nomap()
I read the comment about memblock_mark_nomap() and understood that
regions with nomap flags should be treated as PageReserved.
But, if we add this nomap region to memblock.reserved, the region with
nomap flag will be processed in the first for-loop in
memmap_init_reserved_pages.

Am I thinking wrong?

Regards,
DaeRo Lee

