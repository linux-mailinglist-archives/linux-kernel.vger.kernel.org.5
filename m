Return-Path: <linux-kernel+bounces-9418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7E81C53D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB514287238
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBB98F49;
	Fri, 22 Dec 2023 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vM1orHdg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDB79C4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso25855e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 22:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703227545; x=1703832345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQ4VfcRvr0MADFt4gCHCPAhzbnR2i2y5RChAnLHuZ/E=;
        b=vM1orHdgYDaOcBsPQnrq5T8f12NJIMzs4yVIobZ6V9itLssgZw/5SH1gBIbGZjOknY
         UFvJirywsJoQm6uSybsK7RoAybtOpatTR6uj71hO5t/c62W20aWzWn9+fp3kANn6hbjm
         6IzphoeODgqfiXIx2czi47jPataaehhLzmeqtqlkDkBZ29LLBUuxSPPQqv4hXLUT0VaH
         YzcQCyl1G135fSHlKXbp8ie0cbTGAJ35H2rTJpmdbFS8/MncXjfR1vC0A2cC8YlmBL4m
         IL1mFl06bPALou0+FRAnZMTmdSPq5qs6M2AVcAXR5mWgzSWnct5Gim/3uUeYRkFol7I7
         0xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703227545; x=1703832345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQ4VfcRvr0MADFt4gCHCPAhzbnR2i2y5RChAnLHuZ/E=;
        b=hckGSL1muCpj8Be8aTqcuyIt9YjmR3MmfAT5XOq4Yw2+RCHhva2aFWBnl6nC3fhM6B
         BX0loal+S6PgMd+k+0IeT8apivarRLbD1NVebBri8nUIc0GJyOvXrcxbuALfw24yrWtj
         SNAk4bofUdytxrlfR9DFgeB6e6e4qprspt0vQJqoXf47guPbMMHHCQTdKnSLtUaRCGz6
         i51hdipMtcb6bI+sUlEriNwj+YLSaMVOv6KWJbMM9aOFZukEl5Z4eYfNbdNYm9+5EUQJ
         s43lyr7CguXv8xM0FrlDxQnWXx4ZRNK6t2do4m7S36xVGbWCMGCzDhV4WMlH2PzpRMq6
         1rzQ==
X-Gm-Message-State: AOJu0YxnLIKGOmMnU7bJOAgnG3TrQx7/T132oeW7Lc8bWS3QxwsJ4iik
	Xmxg6xYgWDoz4tQWyHzG01GBoG86Ca3uqPSUu3J1wxzXYNRp
X-Google-Smtp-Source: AGHT+IFV/k1kQj4oUD0tJUKcq5ukW7isBwambmMGS4xUkqeUxUKXb7h7vP7wEadJ3FoUpA4Nj8uDdmBRzatjDO7i/YE=
X-Received: by 2002:a05:600c:4e4c:b0:40d:3f65:7e8b with SMTP id
 e12-20020a05600c4e4c00b0040d3f657e8bmr51366wmq.1.1703227545006; Thu, 21 Dec
 2023 22:45:45 -0800 (PST)
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
 <CAOUHufajdi7LjyJWNoDx7RP_i9mmN8j9dBqO7GC4A6YNPNnygw@mail.gmail.com>
 <CAGWkznFb2vn_+2ho7BQ1cqVDx0cyFzoffS3_nk4hYUNuRSsVGw@mail.gmail.com>
 <CAOUHufZYqeTyZ7e_QyHnEuo8V0Z-9BD5XyNsMMx8Xp1eK5aNkQ@mail.gmail.com> <1703226522421.22653@unisoc.com>
In-Reply-To: <1703226522421.22653@unisoc.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 21 Dec 2023 23:45:06 -0700
Message-ID: <CAOUHufZtgkQXWpRWhTrAgFSwqxEMteDyqhxcduHuDt6B-cvpQg@mail.gmail.com>
Subject: Re: reply: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:29=E2=80=AFPM =E9=BB=84=E6=9C=9D=E9=98=B3 (Zhaoy=
ang Huang)
<zhaoyang.huang@unisoc.com> wrote:
>
>
> On Thu, Dec 21, 2023 at 10:53=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@gm=
ail.com> wrote:
> >
> > On Thu, Dec 21, 2023 at 2:33=E2=80=AFPM Yu Zhao <yuzhao@google.com> wro=
te:
> > >
> > > On Wed, Dec 20, 2023 at 11:28=E2=80=AFPM Zhaoyang Huang <huangzhaoyan=
g@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 21, 2023 at 12:53=E2=80=AFPM Yu Zhao <yuzhao@google.com=
> wrote:
> > > > >
> > > > > On Wed, Dec 20, 2023 at 9:09=E2=80=AFPM Matthew Wilcox <willy@inf=
radead.org> wrote:
> > > > > >
> > > > > > On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang wrote:
> > > > > > > On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox <will=
y@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang wr=
ote:
> > > > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > > > >
> > > > > > > > > Inactive mapped folio will be promoted to active only whe=
n it is
> > > > > > > > > scanned in shrink_inactive_list, while the vfs folio will=
 do this
> > > > > > > > > immidiatly when it is accessed. These will introduce two =
affections:
> > > > > > > > >
> > > > > > > > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > > > > > > > 2. Low reclaiming efficiency caused by dummy nactive foli=
o which should
> > > > > > > > >    be kept as earlier as shrink_active_list.
> > > > > > > > >
> > > > > > > > > I would like to suggest mark the folio be accessed in min=
or fault to
> > > > > > > > > solve this situation.
> > > > > > > >
> > > > > > > > This isn't going to be as effective as you imagine.  Almost=
 all file
> > > > > > > > faults are handled through filemap_map_pages().  So I must =
ask, what
> > > > > > > > testing have you done with this patch?
> > > > > > > >
> > > > > > > > And while you're gathering data, what effect would this pat=
ch have on your
> > > > > > > > workloads?
> > > > > > > Thanks for heads-up, I am out of date for readahead mechanism=
. My goal
> > > > > >
> > > > > > It's not a terribly new mechanism ... filemap_map_pages() was a=
dded nine
> > > > > > years ago in 2014 by commit f1820361f83d
> > > > > >
> > > > > > > is to have mapped file pages behave like other pages which co=
uld be
> > > > > > > promoted immediately when they are accessed. I will update th=
e patch
> > > > > > > and provide benchmark data in new patch set.
> > > > > >
> > > > > > Understood.  I don't know the history of this, so I'm not sure =
if the
> > > > > > decision to not mark folios as accessed here was intentional or=
 not.
> > > > > > I suspect it's entirely unintentional.
> > > > >
> > > > > It's intentional. For the active/inactive LRU, all folios start
> > > > > inactive. The first scan of a folio transfers the A-bit (if it's =
set
> > > > > during the initial fault) to PG_referenced; the second scan of th=
is
> > > > > folio, if the A-bit is set again, moves it to the active list. Th=
is
> > > > > way single-use folios, i.e., folios mapped for file streaming, ca=
n be
> > > > > reclaimed quickly, since they are "demoted" rather than "promoted=
" on
> > > > > the second scan. This RFC would regress memory streaming workload=
s.
> > > > Thanks. Please correct me if I am wrong. IMO, there will be no
> > > > minor-fault for single-use folios
> > >
> > > Why not? What prevents a specific *access pattern* from triggering mi=
nor faults?
> > Please find the following chart for mapped page state machine
> > transfication.
>
> > I'm not sure what you are asking me to look at -- is the following
> > trying to illustrate something related to my question above?
>
> sorry for my fault on table generation, resend it, I am trying to present=
 how RFC performs in a page's stat transfer
>
> 1. RFC behaves the same as the mainline in (1)(2)
> 2. VM_EXEC mapped pages are activated earlier than mainline which help im=
prove scan efficiency in (3)(4)
> 3. none VM_EXEC mapped pages are dropped as vfs pages do during 3rd scan.
>
> (1)
>                                   1st access         shrink_active_list  =
            1st scan(shink_folio_list)       2nd scan(shrink_folio_list')
> mainline                     INA/UNR                        NA           =
               INA/REF                               DROP
> RFC                           INA/UNR                        NA          =
                 INA/REF                              DROP

I don't think this is the case -- with this RFC, *readahead* folios,
which are added into pagecache as INA/UNR, become PG_referenced upon
the initial fault (first access), i.e., INA/REF. The first scan will
actually activate them, i.e., they become ACT/UNR, because they have
both PG_referenced and the A-bit.

So it doesn't behave the same way the mainline does for the first case
you listed. (I didn't look at the rest of the cases.)

