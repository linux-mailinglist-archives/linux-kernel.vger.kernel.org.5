Return-Path: <linux-kernel+bounces-7891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F03E81AEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4216E1C22AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76831B66F;
	Thu, 21 Dec 2023 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAC0ssrg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37510B64A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e62895336so37268e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703140107; x=1703744907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xoc5f346mwBITD9hfhI7l4joWWp7V2JrgZ3awG0UfKk=;
        b=UAC0ssrg2zD5YT4eJ4aCedlU/QZWHLUm023t3SlGjg54hsp3qb4/OXJa0anz5sGqwa
         xbHb6SbbKgkDiXl521v6OwqeTUqiaYxHGmXoLCn+d3srWYfJDfT8jFKwYpJ2SpoF4fo6
         aFNhsn3PKr5akGsJ4rfvgy3VgpdJrK0O57o2ftHLrFbVz77Ts66bruDwbtEVtlerbLJl
         7nxGNUc49LJ7+JZnGLwUPKJzcvhrKcxRQY3YBHouhglJTq7R3DEz+q5URomB1fEahRQ7
         TTmePE93EPua0FQgaPHT2PBxJoIxjQUI1wSJPfdxu3wqoMkRJ5eCN5ePzDEAkxQU3EMD
         BTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703140107; x=1703744907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xoc5f346mwBITD9hfhI7l4joWWp7V2JrgZ3awG0UfKk=;
        b=HlD/xqQb5bLKLan/3VF7aZkF6NuYjjpuwNIavBsEGjH/won37coURdAMVuAvKy3B2Y
         UrGDmGmemWOVw3jM1sGr4f7Dw7UCXd5OY9kWMFbL4KRMilVpXHWglwI26ZB7BuyF8lI0
         MsmGskkw8NXoP0YjN5HWI1rJMj3CCHbIalDZBCDwrPzgBEQtNQ+0TKdjS2shWiYHTtEw
         Vm3e5RCdVawGdBoJ6BL0EqfhplFmVRP9tgMTbZp3DhbhnfBrZ7t2ZtSGDvUA+uAPJdvg
         hvXchatGrRLvS3RfAFouPKIwQgJS+JPt+88hO1f0LUFpqZx3Vgzg/MN0aFe1Go0o4d/4
         wj6w==
X-Gm-Message-State: AOJu0YzqB5ncDFjwwaz5dRwKLyqjpr41X9vuKU6ru6ph7F6J36nBJVIL
	IVoBIj1Od/Q/06j/9Kl5qRC5UONolzW2EsFf+Vw=
X-Google-Smtp-Source: AGHT+IG4cXM/WysvMMpvkxb4609A6sU4+Vn65gDfQuqrpY8y7n0U3KMUBBBldq8UQdtTPDti8Q3eqclUieNFFnGctcY=
X-Received: by 2002:a05:6512:312b:b0:50e:2864:e90d with SMTP id
 p11-20020a056512312b00b0050e2864e90dmr127204lfd.12.1703140106968; Wed, 20 Dec
 2023 22:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220102948.1963798-1-zhaoyang.huang@unisoc.com>
 <ZYL2rbD5UTz3s8gg@casper.infradead.org> <CAGWkznFcMkkqsKJSyHJfts9ZiYsxxg_dFTccieQ4+boRDJgG4g@mail.gmail.com>
 <ZYO6bLcCRYlo290g@casper.infradead.org> <CAOUHufZ-hAAB+9iL3K-YokN4oVJoiC9dVQ+6zLu-M4Ag52TY5g@mail.gmail.com>
In-Reply-To: <CAOUHufZ-hAAB+9iL3K-YokN4oVJoiC9dVQ+6zLu-M4Ag52TY5g@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 21 Dec 2023 14:28:15 +0800
Message-ID: <CAGWkznGUvPeWkjcy42dudx_+n19dr7SU3B3GGO6JovXHB-Vyzg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: Yu Zhao <yuzhao@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:53=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Dec 20, 2023 at 9:09=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang wrote:
> > > On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > >
> > > > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > Inactive mapped folio will be promoted to active only when it is
> > > > > scanned in shrink_inactive_list, while the vfs folio will do this
> > > > > immidiatly when it is accessed. These will introduce two affectio=
ns:
> > > > >
> > > > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > > > 2. Low reclaiming efficiency caused by dummy nactive folio which =
should
> > > > >    be kept as earlier as shrink_active_list.
> > > > >
> > > > > I would like to suggest mark the folio be accessed in minor fault=
 to
> > > > > solve this situation.
> > > >
> > > > This isn't going to be as effective as you imagine.  Almost all fil=
e
> > > > faults are handled through filemap_map_pages().  So I must ask, wha=
t
> > > > testing have you done with this patch?
> > > >
> > > > And while you're gathering data, what effect would this patch have =
on your
> > > > workloads?
> > > Thanks for heads-up, I am out of date for readahead mechanism. My goa=
l
> >
> > It's not a terribly new mechanism ... filemap_map_pages() was added nin=
e
> > years ago in 2014 by commit f1820361f83d
> >
> > > is to have mapped file pages behave like other pages which could be
> > > promoted immediately when they are accessed. I will update the patch
> > > and provide benchmark data in new patch set.
> >
> > Understood.  I don't know the history of this, so I'm not sure if the
> > decision to not mark folios as accessed here was intentional or not.
> > I suspect it's entirely unintentional.
>
> It's intentional. For the active/inactive LRU, all folios start
> inactive. The first scan of a folio transfers the A-bit (if it's set
> during the initial fault) to PG_referenced; the second scan of this
> folio, if the A-bit is set again, moves it to the active list. This
> way single-use folios, i.e., folios mapped for file streaming, can be
> reclaimed quickly, since they are "demoted" rather than "promoted" on
> the second scan. This RFC would regress memory streaming workloads.
Thanks. Please correct me if I am wrong. IMO, there will be no
minor-fault for single-use folios which means RFC could behave the
same as mainline does now? I think it doesn't make sense to have
multiple-mapped pages filled in page_list to shrink_page_list since we
can distinguish them in advance.

