Return-Path: <linux-kernel+bounces-14054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8404682176B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499401C211A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCA01398;
	Tue,  2 Jan 2024 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLb7H7OO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B010FD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e9e5c97e1so577709e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704173827; x=1704778627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITtNDvna4dWzdrbqw+gkqQjeHGVu03qWnYZf7TFHwEY=;
        b=BLb7H7OOL/lb3w0cC8aPiS09juwisKMs/iKW/KlDCySclRQCHkwnTW5C+L5UQF4oeF
         dPkOyaZDYUZljrKzfP5qgZnyn0Rtgb6+GE1CL39dYNBzkqEvI7xOnBoCC9qlgEk1y5cF
         HKFYFhb+dbpdXs2PsJj5c/U3NetoJVLZYhHOMBtYDfz1OjXUS8GcTYIYAK8eaFprnJHa
         hChnkMvtgB2Z+3XH3anQzmYO7M6XHF2RQ0r09gqo/ieXB5yfrPXSmI31FQBapbJL/QTJ
         hStEayBjRO3sM6UIbC+sx6G8AF2mdgzXCQ/BvsDIjWLtU92fbCkRexKX1HF0j4ooZY3D
         zEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704173827; x=1704778627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITtNDvna4dWzdrbqw+gkqQjeHGVu03qWnYZf7TFHwEY=;
        b=eQQdURVtkEa2epx+UNxjvHIN/4DOt4NPVgk9Ovw90SIX/6x7GGrOMz/TBKlQQ1S1jt
         Luw58dnGpnPIeE+3CE8P+c2kZV1E2GuE95LE/JtM9ThwiDw/d0yKNP9gO9R9rHWZ7vpR
         IQUP8F4QvVirBFzrv+oNjKCU129DfxDfFjaxDvIn8+NrcPzmddOcy+sKpFBpr/KbSnPG
         XHU4pU3zmR08nzYycRboed1lNbzw2vTG3E/1jec59YRKYt1DPJD0+KD0yruZpsme4VYs
         TmGBVi/dNhj7bhNAUg44B6Vtq71Ipcb87o/qi9dYJq18ic7n2NsKEbsrHAlUAyqD5+ei
         J/pw==
X-Gm-Message-State: AOJu0YwFi5XPB7BcZbiM2B1sxVSgBTK6dhmYUrqoKW6/OK4Te2jp408u
	M9TZVUd6YzzX2ekHQ6P1xQxU1znDE1kfUADEBWgdlv+fxTc=
X-Google-Smtp-Source: AGHT+IENiGuYGTcIJmnwCw/+D/Z4Do1c/XEczOlo7WqjAn3raCZaCSE8v6WBJCdGxRX1PfzjL1lncLa/fK8NqOlvcPQ=
X-Received: by 2002:a05:6512:e9f:b0:50e:7b20:3092 with SMTP id
 bi31-20020a0565120e9f00b0050e7b203092mr5042850lfb.33.1704173827124; Mon, 01
 Jan 2024 21:37:07 -0800 (PST)
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
 <CAGWkznGPA872eY9VrAEh4wbBRhxtHpUFibxhB6rFaEip899FSw@mail.gmail.com>
 <1703238070775.29652@unisoc.com> <CAOUHufYawpbzvaZHh30gXXEyRi0+i5Wg7QO7j4-B5OmVfQ9NiA@mail.gmail.com>
In-Reply-To: <CAOUHufYawpbzvaZHh30gXXEyRi0+i5Wg7QO7j4-B5OmVfQ9NiA@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 2 Jan 2024 13:36:55 +0800
Message-ID: <CAGWkznGbP+vTPCo9kBUtdqDtqYaVnqE=R-kHsUwmy331vMXUvA@mail.gmail.com>
Subject: Re: reply: reply: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: Yu Zhao <yuzhao@google.com>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I update the patch on v515 as below[1], which calls
mark_page_accessed(mapped_page) in filemap_map_pages and
filemap_fault<in minor fault path> to promote none-single-use pages(by
waiving major fault) earlier than the first scan does now. The patch
is verified on a 2G RAM based android system by the test script, which
loops the following 4 steps[2] for 30 times and measures the numbers
of trace event "mm_filemap_add_to_page_cache/mm_filemap_delete_from_page_ca=
che"
which can be deemed as page cache retention rate(could be thrashing
rate also). In terms of the test result, RFC could save 10% of the
add_to page in each phase and get a better APP start time(decreased
5%) .

[1]
diff --git a/mm/filemap.c b/mm/filemap.c
index 279380c..308e415 100644
+++ b/mm/filemap.c

@@ -3124,6 +3125,7 @@
  filemap_invalidate_lock_shared(mapping);
  mapping_locked =3D true;
  }
+ mark_page_accessed(page);
  } else {
  /* No page in the page cache at all */
  count_vm_event(PGMAJFAULT);
@@ -3147,7 +3149,7 @@
  goto out_retry;
  filemap_invalidate_unlock_shared(mapping);
  return VM_FAULT_OOM;
  }
 }

  if (!lock_page_maybe_drop_mmap(vmf, page, &fpin))
@@ -3388,8 +3390,10 @@

  /* We're about to handle the fault */
  if (vmf->address =3D=3D addr)
   ret =3D VM_FAULT_NOPAGE;

+ if (page_mapcount(page))
+ mark_page_accessed(page);
  do_set_pte(vmf, page, addr);
  /* no need to invalidate: a not-present page won't be cached */
  update_mmu_cache(vma, addr, vmf->pte);

[2]
1. start an APP
2. malloc and mlock 512MB pages
3. restart the APP
4. kill the APP

[3]
                                                               v515
                                                      RFC
                                                               add_to
              delete_from                    add_to
delete_from
1. start an APP                                       41290
     88279                             32235                    79305
2. malloc and mlock 512MB pages        342103               374396
                      304310                  339048
3. restart the APP                                   46552
    162456                           42279                    176368
4. kill the APP

On Sat, Dec 23, 2023 at 10:41=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>
> On Fri, Dec 22, 2023 at 2:41=E2=80=AFAM =E9=BB=84=E6=9C=9D=E9=98=B3 (Zhao=
yang Huang)
> <zhaoyang.huang@unisoc.com> wrote:
> >
> >
> >
> > On Fri, Dec 22, 2023 at 2:45=E2=80=AFPM Yu Zhao <yuzhao@google.com> wro=
te:
> > >
> > > On Thu, Dec 21, 2023 at 11:29=E2=80=AFPM =E9=BB=84=E6=9C=9D=E9=98=B3 =
(Zhaoyang Huang)
> > > <zhaoyang.huang@unisoc.com> wrote:
> > > >
> > > >
> > > > On Thu, Dec 21, 2023 at 10:53=E2=80=AFPM Zhaoyang Huang <huangzhaoy=
ang@gmail.com> wrote:
> > > > >
> > > > > On Thu, Dec 21, 2023 at 2:33=E2=80=AFPM Yu Zhao <yuzhao@google.co=
m> wrote:
> > > > > >
> > > > > > On Wed, Dec 20, 2023 at 11:28=E2=80=AFPM Zhaoyang Huang <huangz=
haoyang@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 21, 2023 at 12:53=E2=80=AFPM Yu Zhao <yuzhao@goog=
le.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Dec 20, 2023 at 9:09=E2=80=AFPM Matthew Wilcox <wil=
ly@infradead.org> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang =
wrote:
> > > > > > > > > > On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox=
 <willy@infradead.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.hu=
ang wrote:
> > > > > > > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > > > > > > >
> > > > > > > > > > > > Inactive mapped folio will be promoted to active on=
ly when it is
> > > > > > > > > > > > scanned in shrink_inactive_list, while the vfs foli=
o will do this
> > > > > > > > > > > > immidiatly when it is accessed. These will introduc=
e two affections:
> > > > > > > > > > > >
> > > > > > > > > > > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > > > > > > > > > > 2. Low reclaiming efficiency caused by dummy nactiv=
e folio which should
> > > > > > > > > > > >    be kept as earlier as shrink_active_list.
> > > > > > > > > > > >
> > > > > > > > > > > > I would like to suggest mark the folio be accessed =
in minor fault to
> > > > > > > > > > > > solve this situation.
> > > > > > > > > > >
> > > > > > > > > > > This isn't going to be as effective as you imagine.  =
Almost all file
> > > > > > > > > > > faults are handled through filemap_map_pages().  So I=
 must ask, what
> > > > > > > > > > > testing have you done with this patch?
> > > > > > > > > > >
> > > > > > > > > > > And while you're gathering data, what effect would th=
is patch have on your
> > > > > > > > > > > workloads?
> > > > > > > > > > Thanks for heads-up, I am out of date for readahead mec=
hanism. My goal
> > > > > > > > >
> > > > > > > > > It's not a terribly new mechanism ... filemap_map_pages()=
 was added nine
> > > > > > > > > years ago in 2014 by commit f1820361f83d
> > > > > > > > >
> > > > > > > > > > is to have mapped file pages behave like other pages wh=
ich could be
> > > > > > > > > > promoted immediately when they are accessed. I will upd=
ate the patch
> > > > > > > > > > and provide benchmark data in new patch set.
> > > > > > > > >
> > > > > > > > > Understood.  I don't know the history of this, so I'm not=
 sure if the
> > > > > > > > > decision to not mark folios as accessed here was intentio=
nal or not.
> > > > > > > > > I suspect it's entirely unintentional.
> > > > > > > >
> > > > > > > > It's intentional. For the active/inactive LRU, all folios s=
tart
> > > > > > > > inactive. The first scan of a folio transfers the A-bit (if=
 it's set
> > > > > > > > during the initial fault) to PG_referenced; the second scan=
 of this
> > > > > > > > folio, if the A-bit is set again, moves it to the active li=
st. This
> > > > > > > > way single-use folios, i.e., folios mapped for file streami=
ng, can be
> > > > > > > > reclaimed quickly, since they are "demoted" rather than "pr=
omoted" on
> > > > > > > > the second scan. This RFC would regress memory streaming wo=
rkloads.
> > > > > > > Thanks. Please correct me if I am wrong. IMO, there will be n=
o
> > > > > > > minor-fault for single-use folios
> > > > > >
> > > > > > Why not? What prevents a specific *access pattern* from trigger=
ing minor faults?
> > > > > Please find the following chart for mapped page state machine
> > > > > transfication.
> > > >
> > > > > I'm not sure what you are asking me to look at -- is the followin=
g
> > > > > trying to illustrate something related to my question above?
> > > >
> > > > sorry for my fault on table generation, resend it, I am trying to p=
resent how RFC performs in a page's stat transfer
> > > >
> > > > 1. RFC behaves the same as the mainline in (1)(2)
> > > > 2. VM_EXEC mapped pages are activated earlier than mainline which h=
elp improve scan efficiency in (3)(4)
> > > > 3. none VM_EXEC mapped pages are dropped as vfs pages do during 3rd=
 scan.
> > > >
> > > > (1)
> > > >                                   1st access         shrink_active_=
list              1st scan(shink_folio_list)       2nd scan(shrink_folio_li=
st')
> > > > mainline                     INA/UNR                        NA     =
                     INA/REF                               DROP
> > > > RFC                           INA/UNR                        NA    =
                       INA/REF                              DROP
> > >
> > > > I don't think this is the case -- with this RFC, *readahead* folios=
,
> > > > which are added into pagecache as INA/UNR, become PG_referenced upo=
n
> > > > the initial fault (first access), i.e., INA/REF. The first scan wil=
l
> > > > actually activate them, i.e., they become ACT/UNR, because they hav=
e
> > > > both PG_referenced and the A-bit.
> > > No,Sorry for the confusion. This RFC actually aims at minor fault of
> > > the faulted pages(with one pte setup). In terms of the readahead
> > > pages, can we solve it by add one criteria as bellow, which unifies
> > > all kinds of mapped pages in RFC.
>
> Again this is still wrong -- how do you know the other process mapping
> this folio isn't also streaming the file?
>
> It'd be best to take a step back and think through my original
> question: what prevents a specific *access pattern* from triggering
> minor faults? The simple answer is that you can't.
I agree with that and get more puzzled. The RFC's goal is that the
more minor faults over the page the sooner it gets promoted as vfs
pages do.

It's intentional. For the active/inactive LRU, all folios start
inactive. The first scan of a folio transfers the A-bit (if it's set
during the initial fault) to PG_referenced;
[RFC behaves the same as above]
the second scan of this folio, if the A-bit is set again, moves it to
the active list.
[RFC is NOT against this but just let minor faults promote the page in adva=
nce]
This way single-use folios, i.e., folios mapped for file streaming,
can be reclaimed quickly, since they are "demoted" rather than
"promoted" on the second scan. This RFC would regress memory streaming
workloads.


>
> > > @@ -3273,6 +3273,12 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
> > >         */
> > >        folio =3D filemap_get_folio(mapping, index);
> > >        if (likely(!IS_ERR(folio))) {
> > > +               /*
> > > +                * try to promote inactive folio here when it is acce=
ssed
> > > +                * as minor fault
> > > +                */
> > > +               if(folio_mapcount(folio))
> > > +                       folio_mark_accessed(folio);
> > >                /*
> > >                 * We found the page, so try async readahead before wa=
iting for
> > >                 * the lock.
> > >
> > Please find bellow for the stat machine table of updated RFC, where RFC=
 behaves same or enhances the scan efficiency by promoting the page in shri=
nk_active_list.
> >
> > (1)
> >                                   1st access         shrink_active_list=
              1st scan(shink_folio_list)       2nd scan(shrink_folio_list')
> > mainline                     INA/UNR                        NA         =
                 INA/REF                               DROP
> > RFC                           INA/UNR                        NA        =
                  INA/REF                              DROP
> > RA                              INA/UNR                        NA      =
                    INA/REF                              DROP
> >
> > (2)
> >                                   1st access                 2nd access=
               shrink_active_list          1st scan(shink_folio_list)
> > mainline                     INA/UNR                     INA/UNR       =
                NA                                 ACT/REF
> > RFC                           INA/UNR                     INA/REF      =
                 NA                                 ACT/REF
> > RA                              INA/UNR                     INA/REF    =
                   NA                                 ACT/REF
> >
> > (3)
> >                                   1st access        1st scan(shink_foli=
o_list)       2nd access      2nd scan(shrink_active_list)     3rd scan(shr=
ink_folio_list)
> > mainline                     INA/UNR                    INA/REF        =
                   INA/REF                NA                               =
      ACT/REF
> > RFC                           INA/UNR                    INA/REF       =
                    ACT/REF                ACT/REF                         =
  NA
> > (VM_EXEC)
> > RFC                           INA/UNR                    INA/REF       =
                    ACT/REF                INA/REF                         =
   DROP
> > (non VM_EXEC)
> > RA                              INA/UNR                    INA/REF     =
                      INA/REF                NA                            =
         ACT/REF
> >
> > (4)
> >                                   1st access                   2nd acce=
ss                   3rd access          1st scan(shrink_active_list)   2nd=
 scan(shink_folio_list)
> > mainline                     INA/UNR                       INA/UNR     =
                  INA/UNR                    NA                            =
     ACT/REF
> > RFC                           INA/UNR                       INA/REF    =
                     ACT/REF                  ACT/REF                      =
 NA
> > (VM_EXEC)
> > RFC                           INA/UNR                       INA/REF    =
                    ACT/REF                   ACT/REF                      =
 NA
> > (Non VM_EXEC)
> > RA                              INA/UNR                       INA/REF  =
                      ACT/REF                   ACT/REF                    =
   NA
> > > >
> > > > So it doesn't behave the same way the mainline does for the first c=
ase
> > > > you listed. (I didn't look at the rest of the cases.)

