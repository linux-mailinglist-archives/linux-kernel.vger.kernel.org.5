Return-Path: <linux-kernel+bounces-150911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8F38AA69F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6211C21D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045117FD;
	Fri, 19 Apr 2024 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIVv3o8u"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55181362;
	Fri, 19 Apr 2024 01:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491186; cv=none; b=epJ99AGPLCSzgAIwDk382eoW/3QAVdKd/TU/4uQ5ZEzfNacxhTKwyRWp9qcdg8U7FEyspxIjPgRD1Fe9u7hHGLu+OwnMEGbKticwLuaV8RvThcJWJx/gz1w6Uh8FtxzYr1iB2CU7oBVotOIS3uXubLHUMD7OcHMcBQVJ1d1c3rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491186; c=relaxed/simple;
	bh=nhN2ooBVErN5htWBuXgzgNQ9MRrVRm4yKvVjJ6Nzxos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZd1DW8fyxcbR52/NaAe2WmJw1dIl4MJ7Qaro3NtfTM2picrr2C8VE9zddqbTUhS/NiJNqgNJfdVOEtVugDRSlBWmOS9q2KQJ8d7YxYjzqcx1VB8WiLrIilP75rubhRKQj2EIgDF+M3HMF7zyPDBym8u/rC3zp0iz8Nu7sYnIVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIVv3o8u; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3481bb34e7dso845700f8f.3;
        Thu, 18 Apr 2024 18:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713491182; x=1714095982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhN2ooBVErN5htWBuXgzgNQ9MRrVRm4yKvVjJ6Nzxos=;
        b=aIVv3o8uodpf3DZffhJI6rKJlasLxY54YVAaxxzXG8iXj5EmL4a6SLJNwPBRyRM3vq
         kU+kTEipY9uZSkNXuKKDdvQGhGlS4uNn10IkpxIH3xgfrEV9aYar4w5dDbyNuVEY6s7D
         yaheK+0knVUBaqj989fOLcSxhXlxVkDrPoK7mWcvfiZ/4wb42aDDW9CGX9NRAhLnAlaS
         ptKQuSd+nNgFqFxivtCPNfNnna/wQo2xURKDyVnckh3rTzoUcSeI720d04pFgdFFCUQj
         BafUex4SPjTiCuE6xLrG0XeGKKJqFzk/H+9tpZd1kp/QnKmG04znrkBycnaztke3HRoJ
         +Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713491182; x=1714095982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhN2ooBVErN5htWBuXgzgNQ9MRrVRm4yKvVjJ6Nzxos=;
        b=RCcCEx6inxg1eS6jqp731bEhubxuLIFBJ7v0anHsUDn7SMaP8ymlfSR8UIFDVxGJJg
         gxtm3VN5LWbJX3avyVdw3C6K5DyRnBNFVufmqsJau/+Ka+qb62TnPTXs/uNQMr8VDJre
         J7sVRheDFnc/lCT+ktHo6dUqgZOljDPsMWf79p30DV17KtafG9Nfgv4d4TNE97O8fMkE
         O8WeGc3aGkI7ibAL/DvRiMCknMjwKjnM38Y+r8BHeGhZoE1F8VTP8TxShxTj10DtxflH
         nBOxm6YldXnMfhZqwg/GINc2gav7hEdM12+yv80hCM4EKp7MecHks4bp5qEOW3NLbAf+
         SjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwbkdgOac3YiZUUImfiTU+h4gsljcoaaqJv83/Vxz8KG3y591o3T9PICTS1fCh534zmVZ8wwDvaCUL6Ye9PYGjqlYHoIInf3n5PuWU8MjUeClCQJLDR8wCJ0VK1S3SUc9Ezojb88m/Yw==
X-Gm-Message-State: AOJu0Yy7t14MuudCSWFdd0/3a2gM+iFPHfHcQB+o0zK22LIPBYG/KXry
	tI8oXjRtNqagGICJKo1zzrQ7WebCPY8y6fq6ahhwHDAA6OkZlEs4tnxkcgzyJ0ad3AieEz7cTpB
	OLIVft6LBDPxbky4ah0mSeTpfS5I=
X-Google-Smtp-Source: AGHT+IGMM6WvEeHCFsP0durYALfdmEcqAVN7qtB7KCkQGpoHepqjoPVrIuLoFwp9cfouiTjqt/vPONXazz/nSwS3fao=
X-Received: by 2002:a5d:678e:0:b0:349:d7dd:9e4d with SMTP id
 v14-20020a5d678e000000b00349d7dd9e4dmr284626wru.48.1713491182132; Thu, 18 Apr
 2024 18:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linux-mm@kvack.org> <20240416120635.361838-1-skseofh@gmail.com>
 <20240416120635.361838-2-skseofh@gmail.com> <Zh9l_LpThq9aFUR7@kernel.org>
 <CAATEi5kywwC2yUaYjgs+Gm=4HM5o=KHTqH1ALKJijWE_gge0=g@mail.gmail.com> <ZiFgYWydIwvnpIIY@kernel.org>
In-Reply-To: <ZiFgYWydIwvnpIIY@kernel.org>
From: DaeRo Lee <skseofh@gmail.com>
Date: Fri, 19 Apr 2024 10:46:10 +0900
Message-ID: <CAATEi5kFt8iUeWSkrj_bVTyPO_tfQzG77D719P5dLsr2j6Zkzw@mail.gmail.com>
Subject: Re: [PATCH v2] memblock: add no-map alloc functions
To: Mike Rapoport <rppt@kernel.org>
Cc: robh@kernel.org, saravanak@google.com, akpm@linux-foundation.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Daero Lee <daero_le.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 19=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 3:04, M=
ike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Thu, Apr 18, 2024 at 11:54:15PM +0900, DaeRo Lee wrote:
> > 2024=EB=85=84 4=EC=9B=94 17=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:0=
3, Mike Rapoport <rppt@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Tue, Apr 16, 2024 at 09:06:35PM +0900, skseofh@gmail.com wrote:
> > > > From: Daero Lee <daero_le.lee@samsung.com>
> > > >
> > > > Like reserved-memory with the 'no-map' property and only 'size' pro=
perty
> > > > (w/o 'reg' property), there are memory regions need to be allocated=
 in
> > > > memblock.memory marked with the MEMBLOCK_NOMAP flag, but should not=
 be
> > > > allocated in memblock.reserved.
> > >
> > > This still does not explain why you need such regions.
> > >
> > > As Wei Yang explained, memblock does not allocate memory from
> > > memblock.reserved. The memblock.reserved array represents memory that=
 is in
> > > use by firmware or by early kernel allocations and cannot be freed to=
 page
> > > allocator.
> > Thank you for your comments. I used the wrong word.
> > When I use 'allocate', I mean that the region 'adds' to the memblock.re=
served.
> >
> > >
> > > If you have a region that's _NOMAP in memblock.memory and is absent i=
n
> > > memblock.reserved it will not be mapped by the kernel page tables, bu=
t it
> > > will be considered as free memory by the core mm.
> > >
> > > Is this really what you want?
> > If my understanding is right, before freeing (memory && !reserved)
> > area, we marked the memblock.reserved regions and memblock.memory
> > regions with no-map flag. And when we free (memory && !reserved) area,
> > we skip the memblock.memory regions with no-map(see
> > should_skip_region). So, I think that the memory regions with no-map
> > flag will not be considered as free memory.
>
> You are right here.
>
> But I still don't understand *why* do you want to change the way
> early_init_dt_alloc_reserved_memory_arch() works.

In memmap_init_reserved_pages, we mark memblock.reserved as
PageReserved first and mark the memblock.reserved with nomap flag
also.
-> Isn't this duplicated work? (If we add no-map region to
memblock.reserved 'and' mark in memblock.memory..)
So, I think that for the no-map region, we don't need to add to the
memblock.reserved.
This is what we do now in early_init_dt_reserve_memory. the nomap
region is not added to the memblock.reserved.

In early_init_dt_alloc_reserved_memory_arch, if 'nomap' is true, we
mark the memblock.memory region as _NOMAP. And if the return value
'err' is not zero(which is '-ENOMEM' from memblock_isolate_range), we
free the region.
- 'nomap' is true -> memblock_mark_nomap : success -> not free the region

: fail -> free the region
And it can be said that we add the region to the memblock.reserved
using memblock_phys_alloc_range and if the region is nomap, then we
can free the region from memblock.reserved. But is it necessary to add
it to memblock.reserved? We just need the region in memblock.memory to
mark nomap.

So, here is what I think:
- reserved-memory w/ nomap region -> mark only to memblock.memory
- reserved-memory w/o nomap region -> add to the memblock.reserved

Regards,
DaeRo Lee

