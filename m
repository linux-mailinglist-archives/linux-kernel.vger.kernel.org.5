Return-Path: <linux-kernel+bounces-9380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A43E81C4CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4A9B24A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C6A9468;
	Fri, 22 Dec 2023 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4b/goL8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8299447
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e659880a9so981380e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703224410; x=1703829210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCXnfWI0LxEg9yxOXziwsaTzEl1G0IzRUjonaTXiIjk=;
        b=e4b/goL8krh6cBW9gYUGAksGR0uLhzjgb1TiMIGueM5uc9JtEDDMrevs8E5Z/TyScx
         CuE1gnVrQgUR1jw3zvNnWqccGry+Rrw7JekmVPCXZyzi0jHitvEF+Pmyn5f1sE7m/mw7
         5Dq4C91BeK+l1cpLPjWB7XbjfK98L41+oj6uhSoPhNgzUdoZdzJpY8ix5fWD1aLEHWZ1
         8GHCCxBWyJkFRZhbgWeIRbjWf6gs70f4+RZNGeaX+PHB1262dc/aKAs9CdBbxijSIjMe
         SDGjSI8ZVaSOz97Vru0N3a0IZ5Xwds0Y+w7lmWDXLEKEgPNuIDyDGuzg2IezP8qoUTU9
         f04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703224410; x=1703829210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCXnfWI0LxEg9yxOXziwsaTzEl1G0IzRUjonaTXiIjk=;
        b=PFa8JT7JXRn3f5oEXvHXq8YcoG3B293Onb69ChL14LbhJJoquJFXVxsw14wz4xbK3J
         Gi9pFDxpsdKyGgGcL1N+ElcUDHIrVlVrGJGSxNeMQDzHxvT6A9k4vVJJP6qcJy5Jf3Kc
         pamhmW4WOBnmSSup+ryt/6dJBHlXQ9DFP4Ju20jfBqNx9zT9e7Ebbc5pO+L1fHpenvdK
         Hi2pVdlU8fD81cEr+cg7IfrQ2I3WGaYxy4YdLz8MjcS1B9u5UstM/2t1XI+H4+nLZibr
         HcWLkFoF1T1yfhqwvOZH016emweBNsNjonoqAVq2tQmvXy8XU+gvZ20p1CZPy2Z9FAJl
         iENw==
X-Gm-Message-State: AOJu0YzqfAPFYav4Hv1eYJ363eHrqtgER5ttxDTmTXWDsXeftyFPe4RY
	PYabSI0KNeU5/woLSKU9xO7IcL2aTVvVKITbkFqw3hFZKrs=
X-Google-Smtp-Source: AGHT+IHKTJQV20SqN966boq3YGZXb9F2xuhOMuEW9nnI1UdL30Ja2FCgktsO8PUQmrOO9RXatIMRUO6e7i1G/X8p2rQ=
X-Received: by 2002:a19:7611:0:b0:50e:4b94:61b0 with SMTP id
 c17-20020a197611000000b0050e4b9461b0mr367462lff.56.1703224410197; Thu, 21 Dec
 2023 21:53:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220102948.1963798-1-zhaoyang.huang@unisoc.com>
 <ZYL2rbD5UTz3s8gg@casper.infradead.org> <CAGWkznFcMkkqsKJSyHJfts9ZiYsxxg_dFTccieQ4+boRDJgG4g@mail.gmail.com>
 <ZYO6bLcCRYlo290g@casper.infradead.org> <CAOUHufZ-hAAB+9iL3K-YokN4oVJoiC9dVQ+6zLu-M4Ag52TY5g@mail.gmail.com>
 <CAGWkznGUvPeWkjcy42dudx_+n19dr7SU3B3GGO6JovXHB-Vyzg@mail.gmail.com> <CAOUHufajdi7LjyJWNoDx7RP_i9mmN8j9dBqO7GC4A6YNPNnygw@mail.gmail.com>
In-Reply-To: <CAOUHufajdi7LjyJWNoDx7RP_i9mmN8j9dBqO7GC4A6YNPNnygw@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 22 Dec 2023 13:53:18 +0800
Message-ID: <CAGWkznFb2vn_+2ho7BQ1cqVDx0cyFzoffS3_nk4hYUNuRSsVGw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: Yu Zhao <yuzhao@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 2:33=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Dec 20, 2023 at 11:28=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gm=
ail.com> wrote:
> >
> > On Thu, Dec 21, 2023 at 12:53=E2=80=AFPM Yu Zhao <yuzhao@google.com> wr=
ote:
> > >
> > > On Wed, Dec 20, 2023 at 9:09=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang wrote:
> > > > > On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox <willy@in=
fradead.org> wrote:
> > > > > >
> > > > > > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang wrote:
> > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > >
> > > > > > > Inactive mapped folio will be promoted to active only when it=
 is
> > > > > > > scanned in shrink_inactive_list, while the vfs folio will do =
this
> > > > > > > immidiatly when it is accessed. These will introduce two affe=
ctions:
> > > > > > >
> > > > > > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > > > > > 2. Low reclaiming efficiency caused by dummy nactive folio wh=
ich should
> > > > > > >    be kept as earlier as shrink_active_list.
> > > > > > >
> > > > > > > I would like to suggest mark the folio be accessed in minor f=
ault to
> > > > > > > solve this situation.
> > > > > >
> > > > > > This isn't going to be as effective as you imagine.  Almost all=
 file
> > > > > > faults are handled through filemap_map_pages().  So I must ask,=
 what
> > > > > > testing have you done with this patch?
> > > > > >
> > > > > > And while you're gathering data, what effect would this patch h=
ave on your
> > > > > > workloads?
> > > > > Thanks for heads-up, I am out of date for readahead mechanism. My=
 goal
> > > >
> > > > It's not a terribly new mechanism ... filemap_map_pages() was added=
 nine
> > > > years ago in 2014 by commit f1820361f83d
> > > >
> > > > > is to have mapped file pages behave like other pages which could =
be
> > > > > promoted immediately when they are accessed. I will update the pa=
tch
> > > > > and provide benchmark data in new patch set.
> > > >
> > > > Understood.  I don't know the history of this, so I'm not sure if t=
he
> > > > decision to not mark folios as accessed here was intentional or not=
.
> > > > I suspect it's entirely unintentional.
> > >
> > > It's intentional. For the active/inactive LRU, all folios start
> > > inactive. The first scan of a folio transfers the A-bit (if it's set
> > > during the initial fault) to PG_referenced; the second scan of this
> > > folio, if the A-bit is set again, moves it to the active list. This
> > > way single-use folios, i.e., folios mapped for file streaming, can be
> > > reclaimed quickly, since they are "demoted" rather than "promoted" on
> > > the second scan. This RFC would regress memory streaming workloads.
> > Thanks. Please correct me if I am wrong. IMO, there will be no
> > minor-fault for single-use folios
>
> Why not? What prevents a specific *access pattern* from triggering minor =
faults?
Please find the following chart for mapped page state machine
transfication. We can find that:
1. RFC behaves the same as the mainline in (1)(2)
2. VM_EXEC mapped pages are activated earlier than mainline which help
improve scan efficiency in (3)(4)
3. none VM_EXEC mapped pages are dropped as vfs pages do during 3rd scan.

(1)
                                  1st access
shrink_active_list              1st scan(shink_folio_list)
2nd scan(shrink_folio_list')
mainline                     INA/UNR                        NA
                          INA/REF
DROP
RFC                           INA/UNR                        NA
                           INA/REF
DROP

(2)
                                  1st access                   2nd
access                        shrink_active_list          1st
scan(shink_folio_list)
mainline                     INA/UNR                     INA/UNR
                      NA                                 ACT/REF
RFC                           INA/UNR                     INA/REF
                        NA                                 ACT/REF

(3)
                                  1st access
shrink_active_list        1st scan(shink_folio_list)       2nd access
      2nd scan(shrink_active_list)     3rd scan(shink_folio_list)
mainline                     INA/UNR                        NA
                          INA/REF                           INA/REF
                NA                                     ACT/REF
RFC                           INA/UNR                        NA
                           INA/REF                           ACT/REF
                ACT/REF                           NA
(VM_EXEC)
RFC                           INA/UNR                        NA
                           INA/REF                           ACT/REF
                INA/REF                            DROP
(non VM_EXEC)

(4)
                                  1st access                   2nd
access                         3rd access
shrink_active_list                   shink_folio_list
mainline                     INA/UNR                       INA/UNR
                       INA/UNR                          NA
                           ACT/REF
RFC                           INA/UNR                       INA/REF
                         ACT/REF                         ACT/REF
                       NA
(VM_EXEC)
RFC                           INA/UNR                       INA/REF
                         ACT/REF                         ACT/REF
                       NA
(Non VM_EXEC)
>
> > which means RFC could behave the
> > same as mainline does now? I think it doesn't make sense to have
> > multiple-mapped pages filled in page_list to shrink_page_list since we
> > can distinguish them in advance.

