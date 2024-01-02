Return-Path: <linux-kernel+bounces-14063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 460C182177E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2DF1F21A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A692585;
	Tue,  2 Jan 2024 05:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHW7s4pi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F9256D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e835800adso5161184e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704174628; x=1704779428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo66bPCJZwsfoyBeR7AxEooHw9Y9qb4nCq2SNMlkiOs=;
        b=cHW7s4piqtcsVmCNh3H1NHZ1Ai28x+pRqgAdMkzxCsh7QBdTaKJx/pfLFi5As+FQRt
         8f4U/k8KgIMasAezBJHvj5MFunQwCfa+8S4+qG/L6o4Vc9/tvoumYRo/fi2TfPKSuNNy
         MWoh/6AhQVKkMtM6YO4FY/Vrm3RWvKxb7OXzi6sHvSgiU0nmQLp2Dw7detx5rVxIFFzb
         S8EZUaEfGY7OKIR/BzE/uPXQKCbyDXmV3N0J3jsygTt+puvZiyF2V53U1flG+6x8kK9m
         W3Lb3ju8eEQiuzRh9RZAcBDAzEtZGgoNYIryMN7MB7sYOB7yeONshWDYjMIloJstfY4+
         8aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704174628; x=1704779428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo66bPCJZwsfoyBeR7AxEooHw9Y9qb4nCq2SNMlkiOs=;
        b=iIPqsWa53kcxbl6fo3JXQaaoKClFeQFkHehCyd6BQ05FM/yZelX/QrWUmpLWxd32cP
         41rYt9xzMG7y+8q5wcdkqreU25tAh+MP9EomgHC4u+77trD+XZHcuf2FZUaSgoK2BM/t
         AgkXOwW1v+EZcZKm4gSvA3Nkq2HbDORs03Cxfe8TUzE+HCX1PutlsG2+FOWTIRCJlano
         S0X+7W3HF+Evq2CwqE59EVAky6E3FPcqnt2mOlpJkQF9Vy1trAuHWKtFYSCSJBqQk64H
         teVxTIQ/sEFQI8TkKf/qsKzhX44WyTZqWIhrvtd8wNkXBqXs2ac8yzqi3RFF697fIyPh
         2ZkA==
X-Gm-Message-State: AOJu0YzuJ1FlM6O/c1qlDO+HbqJM5/ukr9fEB1rZjpEdZDg2VHgz4HPz
	bpfpWtDHKX3hCz5W1amf+bynX6zqp/m9dIeSiWE=
X-Google-Smtp-Source: AGHT+IE/OosRdnUFrDEAr6O2/c83yieAFzIFOgjaKUhGHLr278fzXsmE5hbGHkR9C+Mnq5AEdHZw4OfQCUa6vibKcz0=
X-Received: by 2002:a05:6512:3f1f:b0:50e:8762:3c0 with SMTP id
 y31-20020a0565123f1f00b0050e876203c0mr2807772lfa.48.1704174628348; Mon, 01
 Jan 2024 21:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016071245.2865233-1-zhaoyang.huang@unisoc.com>
 <20231107172820.GA3745089@cmpxchg.org> <CAGWkznGbGciTocrqMowepCc=aStYFHPt8RPGYjWxQ4TRG1ZqXQ@mail.gmail.com>
 <20231229114032.64d5320a97a7c776e10e8acf@linux-foundation.org>
In-Reply-To: <20231229114032.64d5320a97a7c776e10e8acf@linux-foundation.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 2 Jan 2024 13:50:16 +0800
Message-ID: <CAGWkznFLP7ACf0mxkSoLefewzaoRL38RJ13PXvFmZCgcvx+63A@mail.gmail.com>
Subject: Re: [PATCHv6 1/1] mm: optimization on page allocation when CMA enabled
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com, Vlastimil Babka <vbabka@suse.cz>, 
	Mel Gorman <mgorman@techsingularity.net>, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2023 at 3:40=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 8 Nov 2023 16:55:19 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com=
> wrote:
>
> > > > +static bool use_cma_first(struct zone *zone, unsigned int order, u=
nsigned int alloc_flags)
> > > > +{
> > > > +     unsigned long watermark;
> > > > +     bool cma_first =3D false;
> > > > +
> > > > +     watermark =3D wmark_pages(zone, alloc_flags & ALLOC_WMARK_MAS=
K);
> > > > +     /* check if GFP_MOVABLE pass previous zone_watermark_ok via t=
he help of CMA */
> > > > +     if (zone_watermark_ok(zone, order, watermark, 0, alloc_flags =
& (~ALLOC_CMA))) {
> > > > +             /*
> > > > +              * Balance movable allocations between regular and CM=
A areas by
> > > > +              * allocating from CMA when over half of the zone's f=
ree memory
> > > > +              * is in the CMA area.
> > > > +              */
> > ok, thanks for point out.
> > Could we simple it like this, which will mis-judge kmalloc within
> > ioctl as GFP_USER. I think it is ok as it is rare
> >              if (current_is_kswapd() || !current->mm)
> >                  gfp_flags =3D GFP_KERNEL;
> >              else
> >                  gfp_flags =3D GFP_USER;
> >             free_pages =3D zone_page_state(zone, NR_FREE_PAGES);
> >             free_pages -=3D zone->lowmem_reserve[gfp_zone(gfp_flags)];
> >             free_pages -=3D wmark_pages(zone, alloc_flags & ALLOC_WMARK=
_MASK);
> >             cma_first =3D free_pages > zone_page_state(zone, NR_FREE_PA=
GES) / 2);
> >
>
> This went all quiet.  Do we feel that "mm: optimization on page
> allocation when CMA enabled" should be merged as-is, or dropped in the
> expectation that something based on Johannes's suggestion will be
> developed?
I just establish a v6.6 environment and will provide comparison
results with and without the patch
>

