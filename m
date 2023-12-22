Return-Path: <linux-kernel+bounces-9512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D138581C6C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8961F2833FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2FCA59;
	Fri, 22 Dec 2023 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIrStesy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E7C8CF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50e6a5b5e36so299884e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703234493; x=1703839293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P66lBpZdkUC3/1oyh59gObPlC1U1DYIHSlxdNgyPt2M=;
        b=MIrStesydGEKJryNV0/aC330q4qp1FC7OunSJfIMfjaVhR3o4tBCEsxNFINgAnAlRa
         00auRkLTHA9z5M4RVVQYZ3ufsoU+NF2znX6vxR+FCsR7M6WN3kytvaKirbBj/tOusmcq
         Rnxy1/i3pz0bemH5rHbtIK7tLVPDCvlZKQ9ZQRgcDd2HJppLUxItHGAwxc98suEaE0U1
         lk28pkgaOdxwEcHde92Y86zXISat40d4i1TKxo3zuqxr1EWLPC6CMDamqe+L89OylPzR
         qAxniwlTGyJByiYLJipDRU7FnyqOgWkX775l3Wzg+Ey4wuccqB2y32QTTaHa7kGIKhGo
         IYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703234493; x=1703839293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P66lBpZdkUC3/1oyh59gObPlC1U1DYIHSlxdNgyPt2M=;
        b=UsXLnh6R6TwSfOrrFGXdwgPG/+ub6GAnJdp9lthpSzaaMQ/m5Jwt8xTDGzfo4ijAnQ
         v+AbWMhf5BGWkx8cYHSY2/yQDZS/n45S9hUzlK5IL2Cs0Tb/Xq6zesfLtu9lUWEyDVsI
         RLTMhTKE5P0QjQ7mm/4wEvb7mhExeSsXWgno1Le9bKs5RMSNDMK5/GToFbKV8QdW2Fm3
         K8ocix84l5qXD5ZEl1Te6lIybbqErsCxz0pAJB0cM6xyGYUzNTmEOGXod/wY1QKXf9b0
         I6MbndVfwFMMDtAOweU9w79y8LnuyXqtG11oML1LvbqFzNr4qJHrTkHMr3ancRM7dkYD
         et4g==
X-Gm-Message-State: AOJu0Yz3t/RPxqG0zpM/Uj/TYf+wpg08KFlYotOcHEADxvwExAW+56l0
	qE0a4Yk4CYD6bEZviAYZvx8JGrhex2yqaqYuA+Y=
X-Google-Smtp-Source: AGHT+IG2nrQT3foanUnBDZVtdIc5X3o9EFTz/b9SndXd+0GOCOivRJ6tmv+4kccebxc2Y2oksPWMA8AWqQNwPvkeftA=
X-Received: by 2002:a05:6512:208e:b0:50e:6878:a71d with SMTP id
 t14-20020a056512208e00b0050e6878a71dmr362356lfr.44.1703234492506; Fri, 22 Dec
 2023 00:41:32 -0800 (PST)
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
In-Reply-To: <CAOUHufZtgkQXWpRWhTrAgFSwqxEMteDyqhxcduHuDt6B-cvpQg@mail.gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 22 Dec 2023 16:41:20 +0800
Message-ID: <CAGWkznGPA872eY9VrAEh4wbBRhxtHpUFibxhB6rFaEip899FSw@mail.gmail.com>
Subject: Re: reply: [RFC PATCH 1/1] mm: mark folio accessed in minor fault
To: Yu Zhao <yuzhao@google.com>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 2:45=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Dec 21, 2023 at 11:29=E2=80=AFPM =E9=BB=84=E6=9C=9D=E9=98=B3 (Zha=
oyang Huang)
> <zhaoyang.huang@unisoc.com> wrote:
> >
> >
> > On Thu, Dec 21, 2023 at 10:53=E2=80=AFPM Zhaoyang Huang <huangzhaoyang@=
gmail.com> wrote:
> > >
> > > On Thu, Dec 21, 2023 at 2:33=E2=80=AFPM Yu Zhao <yuzhao@google.com> w=
rote:
> > > >
> > > > On Wed, Dec 20, 2023 at 11:28=E2=80=AFPM Zhaoyang Huang <huangzhaoy=
ang@gmail.com> wrote:
> > > > >
> > > > > On Thu, Dec 21, 2023 at 12:53=E2=80=AFPM Yu Zhao <yuzhao@google.c=
om> wrote:
> > > > > >
> > > > > > On Wed, Dec 20, 2023 at 9:09=E2=80=AFPM Matthew Wilcox <willy@i=
nfradead.org> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 21, 2023 at 09:58:25AM +0800, Zhaoyang Huang wrot=
e:
> > > > > > > > On Wed, Dec 20, 2023 at 10:14=E2=80=AFPM Matthew Wilcox <wi=
lly@infradead.org> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Dec 20, 2023 at 06:29:48PM +0800, zhaoyang.huang =
wrote:
> > > > > > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > > > > > >
> > > > > > > > > > Inactive mapped folio will be promoted to active only w=
hen it is
> > > > > > > > > > scanned in shrink_inactive_list, while the vfs folio wi=
ll do this
> > > > > > > > > > immidiatly when it is accessed. These will introduce tw=
o affections:
> > > > > > > > > >
> > > > > > > > > > 1. NR_ACTIVE_FILE is not accurate as expected.
> > > > > > > > > > 2. Low reclaiming efficiency caused by dummy nactive fo=
lio which should
> > > > > > > > > >    be kept as earlier as shrink_active_list.
> > > > > > > > > >
> > > > > > > > > > I would like to suggest mark the folio be accessed in m=
inor fault to
> > > > > > > > > > solve this situation.
> > > > > > > > >
> > > > > > > > > This isn't going to be as effective as you imagine.  Almo=
st all file
> > > > > > > > > faults are handled through filemap_map_pages().  So I mus=
t ask, what
> > > > > > > > > testing have you done with this patch?
> > > > > > > > >
> > > > > > > > > And while you're gathering data, what effect would this p=
atch have on your
> > > > > > > > > workloads?
> > > > > > > > Thanks for heads-up, I am out of date for readahead mechani=
sm. My goal
> > > > > > >
> > > > > > > It's not a terribly new mechanism ... filemap_map_pages() was=
 added nine
> > > > > > > years ago in 2014 by commit f1820361f83d
> > > > > > >
> > > > > > > > is to have mapped file pages behave like other pages which =
could be
> > > > > > > > promoted immediately when they are accessed. I will update =
the patch
> > > > > > > > and provide benchmark data in new patch set.
> > > > > > >
> > > > > > > Understood.  I don't know the history of this, so I'm not sur=
e if the
> > > > > > > decision to not mark folios as accessed here was intentional =
or not.
> > > > > > > I suspect it's entirely unintentional.
> > > > > >
> > > > > > It's intentional. For the active/inactive LRU, all folios start
> > > > > > inactive. The first scan of a folio transfers the A-bit (if it'=
s set
> > > > > > during the initial fault) to PG_referenced; the second scan of =
this
> > > > > > folio, if the A-bit is set again, moves it to the active list. =
This
> > > > > > way single-use folios, i.e., folios mapped for file streaming, =
can be
> > > > > > reclaimed quickly, since they are "demoted" rather than "promot=
ed" on
> > > > > > the second scan. This RFC would regress memory streaming worklo=
ads.
> > > > > Thanks. Please correct me if I am wrong. IMO, there will be no
> > > > > minor-fault for single-use folios
> > > >
> > > > Why not? What prevents a specific *access pattern* from triggering =
minor faults?
> > > Please find the following chart for mapped page state machine
> > > transfication.
> >
> > > I'm not sure what you are asking me to look at -- is the following
> > > trying to illustrate something related to my question above?
> >
> > sorry for my fault on table generation, resend it, I am trying to prese=
nt how RFC performs in a page's stat transfer
> >
> > 1. RFC behaves the same as the mainline in (1)(2)
> > 2. VM_EXEC mapped pages are activated earlier than mainline which help =
improve scan efficiency in (3)(4)
> > 3. none VM_EXEC mapped pages are dropped as vfs pages do during 3rd sca=
n.
> >
> > (1)
> >                                   1st access         shrink_active_list=
              1st scan(shink_folio_list)       2nd scan(shrink_folio_list')
> > mainline                     INA/UNR                        NA         =
                 INA/REF                               DROP
> > RFC                           INA/UNR                        NA        =
                   INA/REF                              DROP
>
> I don't think this is the case -- with this RFC, *readahead* folios,
> which are added into pagecache as INA/UNR, become PG_referenced upon
> the initial fault (first access), i.e., INA/REF. The first scan will
> actually activate them, i.e., they become ACT/UNR, because they have
> both PG_referenced and the A-bit.
No,Sorry for the confusion. This RFC actually aims at minor fault of
the faulted pages(with one pte setup). In terms of the readahead
pages, can we solve it by add one criteria as bellow, which unifies
all kinds of mapped pages in RFC.

@@ -3273,6 +3273,12 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
         */
        folio =3D filemap_get_folio(mapping, index);
        if (likely(!IS_ERR(folio))) {
+               /*
+                * try to promote inactive folio here when it is accessed
+                * as minor fault
+                */
+               if(folio_mapcount(folio))
+                       folio_mark_accessed(folio);
                /*
                 * We found the page, so try async readahead before waiting=
 for
                 * the lock.

>
> So it doesn't behave the same way the mainline does for the first case
> you listed. (I didn't look at the rest of the cases.)

