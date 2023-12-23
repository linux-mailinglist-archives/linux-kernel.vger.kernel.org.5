Return-Path: <linux-kernel+bounces-10211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D681D148
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D3B284E75
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7857C1109;
	Sat, 23 Dec 2023 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZFLtxCI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF195EA3
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d3102d5d6so86945e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703299315; x=1703904115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLDWQkwvNi0zLm8nJwragHV5fsLn402XwfmayGeZHl4=;
        b=aZFLtxCImbxiuft12LbmTD/j5sUxUPTcCcRi+eo6rGubmXpWX0taEs3f/+3ctwK+Wx
         5cTdz6R3NNSWOglhyhKUUU2bTNcY8RW383PuI+8ESGTgPZktDS+2SGKq+MPMpslQDNyk
         s0vJmeco1EWqdo2UlHEDADVckfgYfeGnwFbdb+pZS52p3v/mEY2h8PyoWfRUrA5tkI/K
         cxebueYW/XpOq3nJG6GP8KxqEGHX+n6gilICYcCFhUcC/k28czbe0LoPid3hiVx3XhFR
         ZB6KY+bzDTvV3FBnU6G2aLaYhAau/1s4PiyvOE0GdP17CYftzfxtjNabX7vtt5HoatRR
         qGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703299315; x=1703904115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLDWQkwvNi0zLm8nJwragHV5fsLn402XwfmayGeZHl4=;
        b=ddYrS9uuuaynTt+sEta4fm3kYdTAO8kawjhnLvCt5uId5f49zaklt8EajJ2foEwJVV
         ItnMk7inK6E/dSd0qU7yyoWcJPfohiBr8OcVPg3kH6FvhluueQrfvjaThXmy5x/XSCLv
         x4m/HJwYPpsUNrp/L+P/yllta2wD7G+8VRww7OBA6pjgl2UIXLHWJGMqAo6SeayewSCU
         vmQdn2Uk5vU9DMWhl7zZSfIH+J1nHRxDlgNyBOnbwCk8OyS8FL03iy8p9A5PBD8VORWN
         j821r15VRS+AV8/J+ENErDWjirrYj9hQ+SMkeZeS8GQE6lfnEDcsKyuHd6R9wv/Xo/kH
         E0Ng==
X-Gm-Message-State: AOJu0YysWqIW568SBjBcaGDHgvZEy2syRsmpJX3WU/B2GokP1HDv7MPI
	LdXKmtLLKpkNmYqizXrWPR7Gtb4tv480rpRC2YgcKAL+m6kI
X-Google-Smtp-Source: AGHT+IEyTsAQO7LAmrUqusu04fQFr3m+OzSSPJ/M1KzyJphf4IMVh3ac/mrn3nHGVMUT7MPF8Z9ah6kCT6tro9NnAS8=
X-Received: by 2002:a05:600c:3b93:b0:40d:4a11:3aab with SMTP id
 n19-20020a05600c3b9300b0040d4a113aabmr103652wms.7.1703299314867; Fri, 22 Dec
 2023 18:41:54 -0800 (PST)
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
 <CAOUHufZYqeTyZ7e_QyHnEuo8V0Z-9BD5XyNsMMx8Xp1eK5aNkQ@mail.gmail.com>
 <1703226522421.22653@unisoc.com> <CAOUHufZtgkQXWpRWhTrAgFSwqxEMteDyqhxcduHuDt6B-cvpQg@mail.gmail.com>
 <CAGWkznGPA872eY9VrAEh4wbBRhxtHpUFibxhB6rFaEip899FSw@mail.gmail.com> <1703238070775.29652@unisoc.com>
In-Reply-To: <1703238070775.29652@unisoc.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 22 Dec 2023 19:41:17 -0700
Message-ID: <CAOUHufYawpbzvaZHh30gXXEyRi0+i5Wg7QO7j4-B5OmVfQ9NiA@mail.gmail.com>
Subject: Re: reply: reply: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 2:41=E2=80=AFAM =E9=BB=84=E6=9C=9D=E9=98=B3 (Zhaoya=
ng Huang)
<zhaoyang.huang@unisoc.com> wrote:
>
>
>
> On Fri, Dec 22, 2023 at 2:45=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > On Thu, Dec 21, 2023 at 11:29=E2=80=AFPM =E9=BB=84=E6=9C=9D=E9=98=B3 (Z=
haoyang Huang)
> > <zhaoyang.huang@unisoc.com> wrote:
> > >
> > >
> > > On Thu, Dec 21, 2023 at 10:53=E2=80=AFPM Zhaoyang Huang <huangzhaoyan=
g@gmail.com> wrote:
> > > >
> > > > On Thu, Dec 21, 2023 at 2:33=E2=80=AFPM Yu Zhao <yuzhao@google.com>=
 wrote:
> > > > >
> > > > > On Wed, Dec 20, 2023 at 11:28=E2=80=AFPM Zhaoyang Huang <huangzha=
oyang@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, Dec 21, 2023 at 12:53=E2=80=AFPM Yu Zhao <yuzhao@google=
.com> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 20, 2023 at 9:09=E2=80=AFPM Matthew Wilcox <willy=
@infradead.org> wrote:
> > > > > > > >
> > > > > > > > On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang wr=
ote:
> > > > > > > > > On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox <=
willy@infradead.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huan=
g wrote:
> > > > > > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > > > > > >
> > > > > > > > > > > Inactive mapped folio will be promoted to active only=
 when it is
> > > > > > > > > > > scanned in shrink_inactive_list, while the vfs folio =
will do this
> > > > > > > > > > > immidiatly when it is accessed. These will introduce =
two affections:
> > > > > > > > > > >
> > > > > > > > > > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > > > > > > > > > 2. Low reclaiming efficiency caused by dummy nactive =
folio which should
> > > > > > > > > > >    be kept as earlier as shrink_active_list.
> > > > > > > > > > >
> > > > > > > > > > > I would like to suggest mark the folio be accessed in=
 minor fault to
> > > > > > > > > > > solve this situation.
> > > > > > > > > >
> > > > > > > > > > This isn't going to be as effective as you imagine.  Al=
most all file
> > > > > > > > > > faults are handled through filemap_map_pages().  So I m=
ust ask, what
> > > > > > > > > > testing have you done with this patch?
> > > > > > > > > >
> > > > > > > > > > And while you're gathering data, what effect would this=
 patch have on your
> > > > > > > > > > workloads?
> > > > > > > > > Thanks for heads-up, I am out of date for readahead mecha=
nism. My goal
> > > > > > > >
> > > > > > > > It's not a terribly new mechanism ... filemap_map_pages() w=
as added nine
> > > > > > > > years ago in 2014 by commit f1820361f83d
> > > > > > > >
> > > > > > > > > is to have mapped file pages behave like other pages whic=
h could be
> > > > > > > > > promoted immediately when they are accessed. I will updat=
e the patch
> > > > > > > > > and provide benchmark data in new patch set.
> > > > > > > >
> > > > > > > > Understood.  I don't know the history of this, so I'm not s=
ure if the
> > > > > > > > decision to not mark folios as accessed here was intentiona=
l or not.
> > > > > > > > I suspect it's entirely unintentional.
> > > > > > >
> > > > > > > It's intentional. For the active/inactive LRU, all folios sta=
rt
> > > > > > > inactive. The first scan of a folio transfers the A-bit (if i=
t's set
> > > > > > > during the initial fault) to PG_referenced; the second scan o=
f this
> > > > > > > folio, if the A-bit is set again, moves it to the active list=
. This
> > > > > > > way single-use folios, i.e., folios mapped for file streaming=
, can be
> > > > > > > reclaimed quickly, since they are "demoted" rather than "prom=
oted" on
> > > > > > > the second scan. This RFC would regress memory streaming work=
loads.
> > > > > > Thanks. Please correct me if I am wrong. IMO, there will be no
> > > > > > minor-fault for single-use folios
> > > > >
> > > > > Why not? What prevents a specific *access pattern* from triggerin=
g minor faults?
> > > > Please find the following chart for mapped page state machine
> > > > transfication.
> > >
> > > > I'm not sure what you are asking me to look at -- is the following
> > > > trying to illustrate something related to my question above?
> > >
> > > sorry for my fault on table generation, resend it, I am trying to pre=
sent how RFC performs in a page's stat transfer
> > >
> > > 1. RFC behaves the same as the mainline in (1)(2)
> > > 2. VM_EXEC mapped pages are activated earlier than mainline which hel=
p improve scan efficiency in (3)(4)
> > > 3. none VM_EXEC mapped pages are dropped as vfs pages do during 3rd s=
can.
> > >
> > > (1)
> > >                                   1st access         shrink_active_li=
st              1st scan(shink_folio_list)       2nd scan(shrink_folio_list=
')
> > > mainline                     INA/UNR                        NA       =
                   INA/REF                               DROP
> > > RFC                           INA/UNR                        NA      =
                     INA/REF                              DROP
> >
> > > I don't think this is the case -- with this RFC, *readahead* folios,
> > > which are added into pagecache as INA/UNR, become PG_referenced upon
> > > the initial fault (first access), i.e., INA/REF. The first scan will
> > > actually activate them, i.e., they become ACT/UNR, because they have
> > > both PG_referenced and the A-bit.
> > No,Sorry for the confusion. This RFC actually aims at minor fault of
> > the faulted pages(with one pte setup). In terms of the readahead
> > pages, can we solve it by add one criteria as bellow, which unifies
> > all kinds of mapped pages in RFC.

Again this is still wrong -- how do you know the other process mapping
this folio isn't also streaming the file?

It'd be best to take a step back and think through my original
question: what prevents a specific *access pattern* from triggering
minor faults? The simple answer is that you can't.

> > @@ -3273,6 +3273,12 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> >         */
> >        folio =3D filemap_get_folio(mapping, index);
> >        if (likely(!IS_ERR(folio))) {
> > +               /*
> > +                * try to promote inactive folio here when it is access=
ed
> > +                * as minor fault
> > +                */
> > +               if(folio_mapcount(folio))
> > +                       folio_mark_accessed(folio);
> >                /*
> >                 * We found the page, so try async readahead before wait=
ing for
> >                 * the lock.
> >
> Please find bellow for the stat machine table of updated RFC, where RFC b=
ehaves same or enhances the scan efficiency by promoting the page in shrink=
_active_list.
>
> (1)
>                                   1st access         shrink_active_list  =
            1st scan(shink_folio_list)       2nd scan(shrink_folio_list')
> mainline                     INA/UNR                        NA           =
               INA/REF                               DROP
> RFC                           INA/UNR                        NA          =
                INA/REF                              DROP
> RA                              INA/UNR                        NA        =
                  INA/REF                              DROP
>
> (2)
>                                   1st access                 2nd access  =
             shrink_active_list          1st scan(shink_folio_list)
> mainline                     INA/UNR                     INA/UNR         =
              NA                                 ACT/REF
> RFC                           INA/UNR                     INA/REF        =
               NA                                 ACT/REF
> RA                              INA/UNR                     INA/REF      =
                 NA                                 ACT/REF
>
> (3)
>                                   1st access        1st scan(shink_folio_=
list)       2nd access      2nd scan(shrink_active_list)     3rd scan(shrin=
k_folio_list)
> mainline                     INA/UNR                    INA/REF          =
                 INA/REF                NA                                 =
    ACT/REF
> RFC                           INA/UNR                    INA/REF         =
                  ACT/REF                ACT/REF                           =
NA
> (VM_EXEC)
> RFC                           INA/UNR                    INA/REF         =
                  ACT/REF                INA/REF                           =
 DROP
> (non VM_EXEC)
> RA                              INA/UNR                    INA/REF       =
                    INA/REF                NA                              =
       ACT/REF
>
> (4)
>                                   1st access                   2nd access=
                   3rd access          1st scan(shrink_active_list)   2nd s=
can(shink_folio_list)
> mainline                     INA/UNR                       INA/UNR       =
                INA/UNR                    NA                              =
   ACT/REF
> RFC                           INA/UNR                       INA/REF      =
                   ACT/REF                  ACT/REF                       N=
A
> (VM_EXEC)
> RFC                           INA/UNR                       INA/REF      =
                  ACT/REF                   ACT/REF                       N=
A
> (Non VM_EXEC)
> RA                              INA/UNR                       INA/REF    =
                    ACT/REF                   ACT/REF                      =
 NA
> > >
> > > So it doesn't behave the same way the mainline does for the first cas=
e
> > > you listed. (I didn't look at the rest of the cases.)

