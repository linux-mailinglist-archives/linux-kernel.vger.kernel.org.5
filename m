Return-Path: <linux-kernel+bounces-9391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF39D81C4F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 952C328302F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E91A8F61;
	Fri, 22 Dec 2023 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SKpO8GJa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50698F40
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso8430a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703225707; x=1703830507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWaRTLWg3LMWL5DhKaonOO+YqljRMaqWOibiVDR3kcg=;
        b=SKpO8GJaHglDx955LYVz9Db9SLo6kwGWsw85yj1cu4lG5qDHG4BYANyfB4N2vvlxoC
         MJMeG10SlK9tNzdc/29/KNOzBNQVkGsVKfefpQJnXKJCw5w0UZgRuznNemwEdNZUOwTW
         tZ9wijrWxMozQFmJnsBdBjFOwstJ7VOpJ3mWgvrgnUGu7E9PKI7lNrbOp+MG+EWIJ1Dr
         5ODaCACnH0p4AGDZVwZyYXO3d1r/kvMifDXgHl748IK2aWcYDhmuiaV3IZN6KeQ4Rxlt
         qm1IlcqAgJ9jrvvusrNKqCYQGzgA1n9WaOKZZgJwZcH1MATEoWBJtqHSM/7RMq2kfZYk
         OW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703225707; x=1703830507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWaRTLWg3LMWL5DhKaonOO+YqljRMaqWOibiVDR3kcg=;
        b=HyiZ9OJWGE9MoR4qfAZ+B5Omcsy/1SuJyKP1OnOVQtpnQWDT9fT3W+mI7OboMfDN1V
         4cBuPpwBxju7xrxaW2DFGTRz3SB7wNDz6M0smkAPPsvbPVPiTS+H3ISEquNeWgWW2UPU
         lKXLFLezQ+OaEDKnzs+wKdRB00/+CxdCd7pGWkN9lEy64p8gKJ7eQyY2uoxGe6JwdEJM
         Y7um35LN4daqvnIipwt5Avc1V59hSnlZ53mOZTuMvDeZ5UH7ABgVrid7qc+eRnFRdv7d
         llWWrAilKP9dnIMZiU8/C1xvcoBAFA1bE4hlROUul7phKpfhpUaW3J4uLzpGzE6GZ+st
         viIg==
X-Gm-Message-State: AOJu0YxCpVWpN9eqYUGF3bE0UfY6nt25q8ojqpC2sf4m//b5ASDGv95O
	Y0bq/LLM2prDu24U1sG5PL+kj3Fplh0ygnD2hRIv7Bs4AszB
X-Google-Smtp-Source: AGHT+IECN++lj0A1ePVbuyw6vrcleKdovCl0zGxry4CX4mKzgacPTjRdZOt0iOehPlWAxAcsqa7WxixBslnFbYa7ggs=
X-Received: by 2002:a50:f611:0:b0:553:faf5:6841 with SMTP id
 c17-20020a50f611000000b00553faf56841mr44796edn.5.1703225706799; Thu, 21 Dec
 2023 22:15:06 -0800 (PST)
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
 <CAOUHufajdi7LjyJWNoDx7RP_i9mmN8j9dBqO7GC4A6YNPNnygw@mail.gmail.com> <CAGWkznFb2vn_+2ho7BQ1cqVDx0cyFzoffS3_nk4hYUNuRSsVGw@mail.gmail.com>
In-Reply-To: <CAGWkznFb2vn_+2ho7BQ1cqVDx0cyFzoffS3_nk4hYUNuRSsVGw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 21 Dec 2023 23:14:28 -0700
Message-ID: <CAOUHufZYqeTyZ7e_QyHnEuo8V0Z-9BD5XyNsMMx8Xp1eK5aNkQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:53=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gmai=
l.com> wrote:
>
> On Thu, Dec 21, 2023 at 2:33=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > On Wed, Dec 20, 2023 at 11:28=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@=
gmail.com> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 12:53=E2=80=AFPM Yu Zhao <yuzhao@google.com> =
wrote:
> > > >
> > > > On Wed, Dec 20, 2023 at 9:09=E2=80=AFPM Matthew Wilcox <willy@infra=
dead.org> wrote:
> > > > >
> > > > > On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang wrote:
> > > > > > On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox <willy@=
infradead.org> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang wrot=
e:
> > > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > > >
> > > > > > > > Inactive mapped folio will be promoted to active only when =
it is
> > > > > > > > scanned in shrink_inactive_list, while the vfs folio will d=
o this
> > > > > > > > immidiatly when it is accessed. These will introduce two af=
fections:
> > > > > > > >
> > > > > > > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > > > > > > 2. Low reclaiming efficiency caused by dummy nactive folio =
which should
> > > > > > > >    be kept as earlier as shrink_active_list.
> > > > > > > >
> > > > > > > > I would like to suggest mark the folio be accessed in minor=
 fault to
> > > > > > > > solve this situation.
> > > > > > >
> > > > > > > This isn't going to be as effective as you imagine.  Almost a=
ll file
> > > > > > > faults are handled through filemap_map_pages().  So I must as=
k, what
> > > > > > > testing have you done with this patch?
> > > > > > >
> > > > > > > And while you're gathering data, what effect would this patch=
 have on your
> > > > > > > workloads?
> > > > > > Thanks for heads-up, I am out of date for readahead mechanism. =
My goal
> > > > >
> > > > > It's not a terribly new mechanism ... filemap_map_pages() was add=
ed nine
> > > > > years ago in 2014 by commit f1820361f83d
> > > > >
> > > > > > is to have mapped file pages behave like other pages which coul=
d be
> > > > > > promoted immediately when they are accessed. I will update the =
patch
> > > > > > and provide benchmark data in new patch set.
> > > > >
> > > > > Understood.  I don't know the history of this, so I'm not sure if=
 the
> > > > > decision to not mark folios as accessed here was intentional or n=
ot.
> > > > > I suspect it's entirely unintentional.
> > > >
> > > > It's intentional. For the active/inactive LRU, all folios start
> > > > inactive. The first scan of a folio transfers the A-bit (if it's se=
t
> > > > during the initial fault) to PG_referenced; the second scan of this
> > > > folio, if the A-bit is set again, moves it to the active list. This
> > > > way single-use folios, i.e., folios mapped for file streaming, can =
be
> > > > reclaimed quickly, since they are "demoted" rather than "promoted" =
on
> > > > the second scan. This RFC would regress memory streaming workloads.
> > > Thanks. Please correct me if I am wrong. IMO, there will be no
> > > minor-fault for single-use folios
> >
> > Why not? What prevents a specific *access pattern* from triggering mino=
r faults?
> Please find the following chart for mapped page state machine
> transfication.

I'm not sure what you are asking me to look at -- is the following
trying to illustrate something related to my question above?

> We can find that:
> 1. RFC behaves the same as the mainline in (1)(2)
> 2. VM_EXEC mapped pages are activated earlier than mainline which help
> improve scan efficiency in (3)(4)
> 3. none VM_EXEC mapped pages are dropped as vfs pages do during 3rd scan.
>
> (1)
>                                   1st access
> shrink_active_list              1st scan(shink_folio_list)
> 2nd scan(shrink_folio_list')
> mainline                     INA/UNR                        NA
>                           INA/REF
> DROP
> RFC                           INA/UNR                        NA
>                            INA/REF
> DROP
>
> (2)
>                                   1st access                   2nd
> access                        shrink_active_list          1st
> scan(shink_folio_list)
> mainline                     INA/UNR                     INA/UNR
>                       NA                                 ACT/REF
> RFC                           INA/UNR                     INA/REF
>                         NA                                 ACT/REF
>
> (3)
>                                   1st access
> shrink_active_list        1st scan(shink_folio_list)       2nd access
>       2nd scan(shrink_active_list)     3rd scan(shink_folio_list)
> mainline                     INA/UNR                        NA
>                           INA/REF                           INA/REF
>                 NA                                     ACT/REF
> RFC                           INA/UNR                        NA
>                            INA/REF                           ACT/REF
>                 ACT/REF                           NA
> (VM_EXEC)
> RFC                           INA/UNR                        NA
>                            INA/REF                           ACT/REF
>                 INA/REF                            DROP
> (non VM_EXEC)
>
> (4)
>                                   1st access                   2nd
> access                         3rd access
> shrink_active_list                   shink_folio_list
> mainline                     INA/UNR                       INA/UNR
>                        INA/UNR                          NA
>                            ACT/REF
> RFC                           INA/UNR                       INA/REF
>                          ACT/REF                         ACT/REF
>                        NA
> (VM_EXEC)
> RFC                           INA/UNR                       INA/REF
>                          ACT/REF                         ACT/REF
>                        NA
> (Non VM_EXEC)
> >
> > > which means RFC could behave the
> > > same as mainline does now? I think it doesn't make sense to have
> > > multiple-mapped pages filled in page_list to shrink_page_list since w=
e
> > > can distinguish them in advance.

