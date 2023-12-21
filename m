Return-Path: <linux-kernel+bounces-7893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A281AECB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CF21C22AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25B11CAB;
	Thu, 21 Dec 2023 06:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+MjnkwB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBAB1172C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso22915e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703140392; x=1703745192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XLaf/t8QZCPicOYEZHL1NswpRFe8OmInfrsmUccFuo=;
        b=v+MjnkwBfZiQ9VJuJxpUrgH/h2KJtPEW0xsM6GOPk8pVJuSgBEdFCoTWtabNenx9/H
         lZmbdQPB6FpvvJ+6ZxWpaxnrkdpHNnr0QuCmL+a08y4PitvMt6EFNt6pLkXZbdrRsZwL
         FEU2Lp5sAq3JmSJRRRHgy67plxqlMiUgdNd5r3j3uPP99RdLiyAzwZcgDiRFG0P3xNMS
         e4un0oLZ2WEumoVHxBANck+4VUxGevx0dJ9TM2sT2PA9PIwASz94EqM441WvS9IDy9aj
         TTy9m7RGTDeuCnIYo1OcDuD3p8qiV+rS//7PG4ODr+VRcawgIoyObUM7LkItf2UAbbHh
         udcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703140392; x=1703745192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XLaf/t8QZCPicOYEZHL1NswpRFe8OmInfrsmUccFuo=;
        b=dPrGmeNAYffYpFxF5vLj314TPSSd/uv4py9XUbez6z81JbOl7fqcM9Mt4q+Mu90jAR
         ronidKxcE2+ihg+ibRpzT4fRICG4YpEUhNiaOpREs5ZHUTel5e/fvwK65CQtYxV+vYzi
         lI0KugqRFVtcOel/rML34pWARJgLhbeucBXraEoZLI+ww6p3rNnfRoSN+CdN1FqWtNwI
         5IlynhvBho0o+6fqslpMs565xEnub+GDXEnMYBhSV9F2myFj2UtU2PxwSYUmd1b5t3QA
         LYWWaj3b8d3mUVSbBeM7gV3dnfnT1KjzR30ljfdo7s4hlRc4R7vmsFknS4caskDnAKmz
         XJvw==
X-Gm-Message-State: AOJu0Yy/bHh9BHlCoFzAJg7+FObT1irGDihUvnH6FP6wbJyV4LIeziAT
	OQ2Iu+OEq3wtt9UNoJ/5urvKHfUNi+xDepRsRhLLFfbqqn1C
X-Google-Smtp-Source: AGHT+IGY75EmIU0eB5GLh9y7veQOGX13D9QV7QVXa+jRYUYg+CX044PEkIJvqDgjXljnRIdy1U2TEtu8uhsKBzAJ6o0=
X-Received: by 2002:a05:600c:4b10:b0:40d:3f65:7e8b with SMTP id
 i16-20020a05600c4b1000b0040d3f657e8bmr17501wmp.1.1703140391796; Wed, 20 Dec
 2023 22:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220102948.1963798-1-zhaoyang.huang@unisoc.com>
 <ZYL2rbD5UTz3s8gg@casper.infradead.org> <CAGWkznFcMkkqsKJSyHJfts9ZiYsxxg_dFTccieQ4+boRDJgG4g@mail.gmail.com>
 <ZYO6bLcCRYlo290g@casper.infradead.org> <CAOUHufZ-hAAB+9iL3K-YokN4oVJoiC9dVQ+6zLu-M4Ag52TY5g@mail.gmail.com>
 <CAGWkznGUvPeWkjcy42dudx_+n19dr7SU3B3GGO6JovXHB-Vyzg@mail.gmail.com>
In-Reply-To: <CAGWkznGUvPeWkjcy42dudx_+n19dr7SU3B3GGO6JovXHB-Vyzg@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 20 Dec 2023 23:32:35 -0700
Message-ID: <CAOUHufajdi7LjyJWNoDx7RP_i9mmN8j9dBqO7GC4A6YNPNnygw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 11:28=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmai=
l.com> wrote:
>
> On Thu, Dec 21, 2023 at 12:53=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrot=
e:
> >
> > On Wed, Dec 20, 2023 at 9:09=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang wrote:
> > > > On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox <willy@infr=
adead.org> wrote:
> > > > >
> > > > > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang wrote:
> > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > >
> > > > > > Inactive mapped folio will be promoted to active only when it i=
s
> > > > > > scanned in shrink_inactive_list, while the vfs folio will do th=
is
> > > > > > immidiatly when it is accessed. These will introduce two affect=
ions:
> > > > > >
> > > > > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > > > > 2. Low reclaiming efficiency caused by dummy nactive folio whic=
h should
> > > > > >    be kept as earlier as shrink_active_list.
> > > > > >
> > > > > > I would like to suggest mark the folio be accessed in minor fau=
lt to
> > > > > > solve this situation.
> > > > >
> > > > > This isn't going to be as effective as you imagine.  Almost all f=
ile
> > > > > faults are handled through filemap_map_pages().  So I must ask, w=
hat
> > > > > testing have you done with this patch?
> > > > >
> > > > > And while you're gathering data, what effect would this patch hav=
e on your
> > > > > workloads?
> > > > Thanks for heads-up, I am out of date for readahead mechanism. My g=
oal
> > >
> > > It's not a terribly new mechanism ... filemap_map_pages() was added n=
ine
> > > years ago in 2014 by commit f1820361f83d
> > >
> > > > is to have mapped file pages behave like other pages which could be
> > > > promoted immediately when they are accessed. I will update the patc=
h
> > > > and provide benchmark data in new patch set.
> > >
> > > Understood.  I don't know the history of this, so I'm not sure if the
> > > decision to not mark folios as accessed here was intentional or not.
> > > I suspect it's entirely unintentional.
> >
> > It's intentional. For the active/inactive LRU, all folios start
> > inactive. The first scan of a folio transfers the A-bit (if it's set
> > during the initial fault) to PG_referenced; the second scan of this
> > folio, if the A-bit is set again, moves it to the active list. This
> > way single-use folios, i.e., folios mapped for file streaming, can be
> > reclaimed quickly, since they are "demoted" rather than "promoted" on
> > the second scan. This RFC would regress memory streaming workloads.
> Thanks. Please correct me if I am wrong. IMO, there will be no
> minor-fault for single-use folios

Why not? What prevents a specific *access pattern* from triggering minor fa=
ults?

> which means RFC could behave the
> same as mainline does now? I think it doesn't make sense to have
> multiple-mapped pages filled in page_list to shrink_page_list since we
> can distinguish them in advance.

