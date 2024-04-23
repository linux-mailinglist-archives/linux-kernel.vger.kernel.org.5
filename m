Return-Path: <linux-kernel+bounces-154367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC2E8ADB48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEBDFB22C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8F9D26A;
	Tue, 23 Apr 2024 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4DwEXFM"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804A322A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713833547; cv=none; b=DtH9Vp6N2kThEWXnRx8JZmyQYYQf/f0eAOZk626aBzJOVOnyMfPyx8xGKb2Mp/v8shuSgQyXS0iailXjhV2uUlptkPK1i+c9SD0ElqiGZsB5rb3hEytjTVQ5tlYj0Ds4MkhJ6kIbspZnRp8RhWFpWyxNkI3zKQ0wlVWRUb6uhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713833547; c=relaxed/simple;
	bh=uclba+Y0I2KbZEt7WfVM1d6DNt4IOCvoMxSQvBBaLoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6PLaU13jbciwvTeMjYTKGTJz9xZhwEs0lPgzmf/T5XGEgEKx/jWWDq7mAuexjQkL/nVvDt9lMMpz16utVabwCbKCfHMSRu4dCfuwD0V4bmKYM1ekhwi3n1h8hBurgfmnP2dmDcq1ugU7MJ5f/rZXn6CFv1tL+SsEYW6vOQJgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4DwEXFM; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47a21267aa8so1673876137.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 17:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713833545; x=1714438345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClL00ZKNnFMRV8+vNcFNoNRUVtaZiDabBBHCITme6cw=;
        b=N4DwEXFMsXbL6Wk9IFHZQzhlWYNH1/Ft42oSXV/hONC6Ida74bTCBEkmofMGptqZlu
         qrtWeQEoSaeMdXRs8O3hpAdU3iB4vI+IFwQRpKveVI3aW7kck/v41lR5iMkHevKSxv1F
         +cnRXlh7sJ2T7f+Fiq/hjJyYMJVYNBi0jUpwmlK9LTAJJmjwdZ20dNuzQ51z3JKQUQua
         GG9pU3kwuDNTNQ0N+vTWDK+8301E4tCeWWR8wHfVUl444Jj9avrOhELC4SMDLOtZTXe1
         QwSv7NxiJtoK64oyGI91QnFjjd5AtpPO0y+QVeU3IB8katUwOrnokX2J4C1Rc4+37dgZ
         hXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713833545; x=1714438345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClL00ZKNnFMRV8+vNcFNoNRUVtaZiDabBBHCITme6cw=;
        b=cYGXUR2k4cECarMz+nA0UU3E4JHiMnwdKPzKmgjySn6THkwrseS81iqXOGrmsQvGkX
         ye7azYFGDvC4GC/g90EoYYWd0+u51Gv+Q97kzWNCFqMYRWGSU1deIrySHomKQ7ldv/HX
         I7ERwBVzPa+DBXJCoFxUCcl+aDbk5HyQallBpUkKpnu8YbrCyiOmNhjJhHP5zhVY9BMK
         vpYTLHLINEU4KCzI8tbR9aoWDaAg2iSgUVlSY6LoFDbwye5lT5JkLYp2E2p7TgQm4/24
         q4YgW1NxNlsffMlZC0COrt8rwlHQneB8LsTkv2zVxx1xDP301D4EYQzNOg0ZGX/uCuFQ
         3ppQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiZogcm+mT8ZdaIZ+qieZblTkotx8Blx0/XBruO7fG4gUtlLRDTHtieWclkjlneLk944CduogycpxrPKIOw3M7/fUQkY5wUjrPW5Ur
X-Gm-Message-State: AOJu0YzdbK7MNX1sATZBY1UvAeVrxpWALar9+dXkpHjM9lAKE/1QskMl
	7r63LoLYccsmbBbrso8NTWaSyleAWiKg7/wnsCKRg/Ub1A5S2/1mchAtyAqK3KWoKqaVRavn4Ag
	Mu5NE28F2/o36R9z7+pH9ZiqjVws=
X-Google-Smtp-Source: AGHT+IENNvKCUqce8Ft/mi66QsvWsVY3Pw7F+95jKA9kCDhY7lkaTazybKLRjabVwnQCPTqkuemT6qY6lpY0d+gtQs4=
X-Received: by 2002:a67:e24c:0:b0:47b:bf92:691 with SMTP id
 w12-20020a67e24c000000b0047bbf920691mr13868061vse.1.1713833544690; Mon, 22
 Apr 2024 17:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419101643.11534-1-hailong.liu@oppo.com> <CAGsJ_4zUhnAAUb77ktJxDvAQpZhGrs00+8iQU3dhwpy=C_CjDA@mail.gmail.com>
 <20240422103857.qw5mrcnj4rgej2jh@oppo.com>
In-Reply-To: <20240422103857.qw5mrcnj4rgej2jh@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 23 Apr 2024 08:52:13 +0800
Message-ID: <CAGsJ_4wwrnO_Fri6acjoTDTr+G0rmCZsPie-ahVzM9runHQpTw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix return value of vb_alloc if size
 is 0.
To: Hailong Liu <hailong.liu@oppo.com>
Cc: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	lstoakes@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 6:39=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> =
wrote:
>
> On Mon, 22. Apr 11:46, Barry Song wrote:
> > On Fri, Apr 19, 2024 at 6:17=E2=80=AFPM <hailong.liu@oppo.com> wrote:
> > >
> > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > >
> > > vm_map_ram check return value of vb_alloc by IS_ERR. if
> > > vm_map_ram(page, 0, 0) , vb_alloc(0, GFP_KERNEL) would return NULL
> > > which cause kernel panic by vmap_pages_range_noflush=E3=80=82fix this=
 by
> > > return ERR_PTR(-EINVAL) if size is 0.
> > >
> > > Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
> > > ---
> > > Changes since v1 [1]:
> > > - Return ERR_PTR(-EINVAL) or not check IS_ERR_OR_NULL
> > >
> > > BTW,  Barry suggests me that if count is 0, return directly, in my
> > > opinion, change return value is more resonable.
> > >
> > > [1] https://lore.kernel.org/all/84d7cd03-1cf8-401a-8edf-2524db0bd6d5@=
oppo.com/
> > >
> > >  mm/vmalloc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index a3fedb3ee0db..c430a999805b 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -2173,7 +2173,7 @@ static void *vb_alloc(unsigned long size, gfp_t=
 gfp_mask)
> > >                  * get_order(0) returns funny result. Just warn and t=
erminate
> > >                  * early.
> > >                  */
> > > -               return NULL;
> > > +               return ERR_PTR(-EINVAL);
> >
> > might be ZERO_SIZE_PTR.
>
> Hi Barry,
> Hi Barry, I use ERR_PTR(-EINVAL) to keep consistency with the return
> value of the function alloc_vmap_area.
>
>         if (unlikely(!size || offset_in_page(size) || !is_power_of_2(alig=
n)))
>                 return ERR_PTR(-EINVAL);
>
> IMO, ZERO_SIZE_PTR is used by slab and can not be catched by IS_ERR().

Ok. it seems not worth to change two places.

Reviewed-by: Barry Song <baohua@kernel.org>

>
> --
> Best Regards,
> Hailong.

