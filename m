Return-Path: <linux-kernel+bounces-150925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF518AA6C7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 04:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AE11C218F2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 02:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43AF46B5;
	Fri, 19 Apr 2024 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZFHrZjR"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C215A4;
	Fri, 19 Apr 2024 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713492009; cv=none; b=SZB+SyrSzg9EB8XfT6SdNOXt1Aj9uG+eeXERLJombGtFHudyWMxdr2lpchd5yaK2eiDwQceHvf4RdIVWUnVTizZDJ0eY/ufJ05HCIEp2+rHLGcCCUAuHObNoS0pukRoQmG08JXUerTU9AxUOKB5sgT2Gl6T70TYDbRMksynxdms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713492009; c=relaxed/simple;
	bh=myK5cv7xJ6bkxPtg1bm9hdmjPYBSUqgEBd63LDUYwz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkQJTF//Qi8JJvbyQ6fFBRhZm5Cd+UBFtVMpQWKadM43yJgVZZAV1cKWYzxd62RGX8viXq9qCASpEc0AoXVgp8eXQvnTq0eQKydWGLs2nRfdUQxRn8FvEIvtJ9D7fyoas4rmq286SeM3p9tWtJo4hkPUwQncMUHRq6XG6b4V67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZFHrZjR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-346b96f1483so850051f8f.1;
        Thu, 18 Apr 2024 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713492006; x=1714096806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myK5cv7xJ6bkxPtg1bm9hdmjPYBSUqgEBd63LDUYwz4=;
        b=RZFHrZjRBAXLamiYy1bbRRjwRA4q0I/OUkU/gEOXJcgTMkw62Zpt4b1A7eNDGAQw+s
         Oqm8lsI5O+maRl8PIrRzXCwTf2FrQx6QJHEeea/F8L/Lp+IPaS9xiMSWDKn3Of+qDhWn
         aoVP3D3O7uwohXybXcQyMjPWsb+eS2TpRYh15YRw4l6+D5MWMhwBVRab46j8pb+x/vHl
         6l/ZE1qnKUd/qL/8VxFaWO3BXWrC2u6wZLK8e/0qJWX6HYHd4EUbSg/I0ogY5zqHpCRs
         FFvExWlRad34Vbvt7Satvi+pj/7l6f44Ib8Xl3EVOyiz+n2CNdKYP24SdHwE9OuCOith
         KLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713492006; x=1714096806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myK5cv7xJ6bkxPtg1bm9hdmjPYBSUqgEBd63LDUYwz4=;
        b=Q6tVu3iFDmCK9KzaX3zjY6eZcJyu4gmVU1qzlz5osAHPsv5i5NKWGgixBM8To6uDxa
         IONmB1Csl4HqIEJ1cf8ZCtuFL3j+EovEJl4IAAug6I9TVKJSgNYty5OF6tq+3m6ON0gf
         fnVA4fr/D5tecb5U97b8JOva5UpTsIF4zpj0olfJBe6vdUknuDtjv92G8H5tsoGxW3nM
         YxOSzaiopaFh+ks0ReBUFUMsD8/M1bwvzDQ9Pd8AilmDI/bW0zpNdT/AXde/an8CPnTk
         8NQan0Ot674wwmx2stU/bDpf1WupCyjHWpHmvkofPbKEcTLVZK4eyFxh2deldM+BuvKF
         6M/g==
X-Forwarded-Encrypted: i=1; AJvYcCUjACtCrUcVoEzK6jmYnyKW1AiiShNU5/IUV0PQxe8oO/8mpMdsfqVn5FiqlgxjZto1w/sTH/YQBrz8oM2TvPSs+caieiFJ7A/tsHV3mI9swKzls2cYOr9Rco09Y9AiH3D/mIEbVMPfgQ==
X-Gm-Message-State: AOJu0YyxHCpEvGgsqp+9ltjeF5ywiwz9w73+//D/198rDyG5EtP9OEjW
	cThS8+JLw9fJ8RkueMqyU8/lhnGkMFFkQWYjpS/4v0CQGhLQd6bbez2kc2tAiiLxGnHy8TrkFLR
	kjzsLl350d3BIeaq6NYhRqGlG0HU=
X-Google-Smtp-Source: AGHT+IHzBB5BE4wkdjBcQa3vtvJxJMwjioX8sSJ6Iq2xnP7W5vs4ebeFf+Ne1PlWH+u4CtNF05ij9hGjddgmpD9xqYo=
X-Received: by 2002:a5d:67c6:0:b0:346:46cf:9b3 with SMTP id
 n6-20020a5d67c6000000b0034646cf09b3mr469613wrw.27.1713492003891; Thu, 18 Apr
 2024 19:00:03 -0700 (PDT)
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
In-Reply-To: <CAATEi5kFt8iUeWSkrj_bVTyPO_tfQzG77D719P5dLsr2j6Zkzw@mail.gmail.com>
From: DaeRo Lee <skseofh@gmail.com>
Date: Fri, 19 Apr 2024 10:59:52 +0900
Message-ID: <CAATEi5ksY-v7-LEqNZWFV5hsHiegNEtrh4LpMWOQ=vT7hC0Rng@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
To: Mike Rapoport <rppt@kernel.org>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Daero Lee <daero_le.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 19=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 10:46, =
DaeRo Lee <skseofh@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 2024=EB=85=84 4=EC=9B=94 19=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 3:04,=
 Mike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > On Thu, Apr 18, 2024 at 11:54:15PM +0900, DaeRo Lee wrote:
> > > 2024=EB=85=84 4=EC=9B=94 17=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3=
:03, Mike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > > >
> > > > On Tue, Apr 16, 2024 at 09:06:35PM +0900, skseofh@gmail.com wrote:
> > > > > From: Daero Lee <daero_le.lee@samsung.com>
> > > > >
> > > > > Like reserved-memory with the 'no-map' property and only 'size' p=
roperty
> > > > > (w/o 'reg' property), there are memory regions need to be allocat=
ed in
> > > > > memblock.memory marked with the MEMBLOCK_NOMAP flag, but should n=
ot be
> > > > > allocated in memblock.reserved.
> > > >
> > > > This still does not explain why you need such regions.
> > > >
> > > > As Wei Yang explained, memblock does not allocate memory from
> > > > memblock.reserved. The memblock.reserved array represents memory th=
at is in
> > > > use by firmware or by early kernel allocations and cannot be freed =
to page
> > > > allocator.
> > > Thank you for your comments. I used the wrong word.
> > > When I use 'allocate', I mean that the region 'adds' to the memblock.=
reserved.
> > >
> > > >
> > > > If you have a region that's _NOMAP in memblock.memory and is absent=
 in
> > > > memblock.reserved it will not be mapped by the kernel page tables, =
but it
> > > > will be considered as free memory by the core mm.
> > > >
> > > > Is this really what you want?
> > > If my understanding is right, before freeing (memory && !reserved)
> > > area, we marked the memblock.reserved regions and memblock.memory
> > > regions with no-map flag. And when we free (memory && !reserved) area=
,
> > > we skip the memblock.memory regions with no-map(see
> > > should_skip_region). So, I think that the memory regions with no-map
> > > flag will not be considered as free memory.
> >
> > You are right here.
> >
> > But I still don't understand *why* do you want to change the way
> > early_init_dt_alloc_reserved_memory_arch() works.
>
> In memmap_init_reserved_pages, we mark memblock.reserved as
> PageReserved first and mark the memblock.reserved with nomap flag
> also.
Sorry. This is my mistake. 'memblock.memory with nomap flag' is right.

> -> Isn't this duplicated work? (If we add no-map region to
> memblock.reserved 'and' mark in memblock.memory..)
> So, I think that for the no-map region, we don't need to add to the
> memblock.reserved.
> This is what we do now in early_init_dt_reserve_memory. the nomap
> region is not added to the memblock.reserved.
>
> In early_init_dt_alloc_reserved_memory_arch, if 'nomap' is true, we
> mark the memblock.memory region as _NOMAP. And if the return value
> 'err' is not zero(which is '-ENOMEM' from memblock_isolate_range), we
> free the region.
> - 'nomap' is true -> memblock_mark_nomap : success -> not free the region
>
> : fail -> free the region
> And it can be said that we add the region to the memblock.reserved
> using memblock_phys_alloc_range and if the region is nomap, then we
> can free the region from memblock.reserved. But is it necessary to add
> it to memblock.reserved? We just need the region in memblock.memory to
> mark nomap.
>
> So, here is what I think:
> - reserved-memory w/ nomap region -> mark only to memblock.memory
> - reserved-memory w/o nomap region -> add to the memblock.reserved
>
> Regards,
> DaeRo Lee

