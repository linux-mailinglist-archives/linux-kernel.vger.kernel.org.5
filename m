Return-Path: <linux-kernel+bounces-23938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8778882B42D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD671C24223
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A33524B9;
	Thu, 11 Jan 2024 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wb2KseaM"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC09B51007
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbe78430946so4648007276.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704994481; x=1705599281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaPlkJTNB6VnjXnr1dR+X3Ih9MlJ8cpJxgiuigImRZw=;
        b=wb2KseaMPD99Fl/EL5sPY1SASverEgXzwFSE7U37WYvC6068OAGVEsAFS4eEbkWf7S
         uah9eamYjW7XTItQjf3gcpFwXSOUozjwC2jl9zlzfr1TC1aqDrb12gczACThf11ZVDzU
         v1pLio03o9lDvHKoqdeSmCvz0Sx+NHY0K36CQrjoFiwnTgm0pM7qc99BJLooyxmDqlFT
         D1kdVr41505goD9mJqKxpTuyvSJjoAPu/PCEBk8zD32q3n+THAHS2rJOUZ719ZP7fdtJ
         XGsz8ZuWp9p02KKjNQLN2Ww74D2KDVNdCUIF8UJPdgEHYnQZRXgXddECf7g5fkIja/j+
         y7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994481; x=1705599281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaPlkJTNB6VnjXnr1dR+X3Ih9MlJ8cpJxgiuigImRZw=;
        b=kAJI7fJX7cm6yDRf6EAYvtT2AWnlwNJczEiKNpOHte6B9etgw94ZBHbKzQLaqftfgV
         N7CLSUZKLmjbbNvJN/FxfosJIeTunPF7kbJYpppE33nHjashiO9+y6N37a0MOqiQn7OY
         6QlQH+k2rpZTgNFf8iCwBSzQj79/ctFLBsReQl4Pupw1x86aE9sXoAlqzima8qCzLrvG
         xxuVngXHgcCUEmZfh8ZeMFdw+3vGAwwryp+RKLmB4dT5xzykPTOa28zEcoEW77u1ac+i
         dcx5LQs0BToCmTpN+IKxoPLwDsaa59V6LA2B2UU7uEOL6mbZ0CxSx0OTvtwLdItH1KH+
         /lmQ==
X-Gm-Message-State: AOJu0YzNW0zVX9SncyaehJ/g17USB/vLHxw3cYGJRTsotGk1dRXbtAtq
	Z++zwUAMEzEBLOfomSxHJ1e9MH7k7M/m4tMGrrciYtlaDDsu
X-Google-Smtp-Source: AGHT+IFVkK7feMZmkx+zG0zXzBX9px0Y83Jk5ITlB19psOzUZzxFg58M/+X60McAtFtNfI0XCDbdWnfX97Tkx3VO7Aw=
X-Received: by 2002:a25:bfce:0:b0:dbe:32a8:12b2 with SMTP id
 q14-20020a25bfce000000b00dbe32a812b2mr1371253ybm.106.1704994481401; Thu, 11
 Jan 2024 09:34:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713001833.3778937-1-jiaqiyan@google.com> <20230713001833.3778937-5-jiaqiyan@google.com>
 <be3976b5-0a9c-41c6-8160-88e6c1e5d63e@collabora.com> <CACw3F51WvZDVCpVg9j4j8WmnmAFOsnK+FZDDoVqhgLqVwhPTCA@mail.gmail.com>
 <e68488e4-764e-4b25-8a47-05bf8976bd19@collabora.com> <079335ab-190f-41f7-b832-6ffe7528fd8b@collabora.com>
 <a20e7bdb-7344-306d-e8f5-5ee69af7d5ea@oracle.com> <dd96e476-e1ad-4cb5-b5d1-556f720acd17@collabora.com>
In-Reply-To: <dd96e476-e1ad-4cb5-b5d1-556f720acd17@collabora.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 11 Jan 2024 09:34:28 -0800
Message-ID: <CACw3F53PddeCHUHb=m8OSO6yYQJoM==urn+Axp=Xi1szozJH9A@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs read
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>, linmiaohe@huawei.com, 
	mike.kravetz@oracle.com, naoya.horiguchi@nec.com, akpm@linux-foundation.org, 
	songmuchun@bytedance.com, shy828301@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, jthoughton@google.com, 
	"kernel@collabora.com" <kernel@collabora.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 12:48=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> On 1/11/24 7:32 AM, Sidhartha Kumar wrote:
> > On 1/10/24 2:15 AM, Muhammad Usama Anjum wrote:
> >> On 1/10/24 11:49 AM, Muhammad Usama Anjum wrote:
> >>> On 1/6/24 2:13 AM, Jiaqi Yan wrote:
> >>>> On Thu, Jan 4, 2024 at 10:27=E2=80=AFPM Muhammad Usama Anjum
> >>>> <usama.anjum@collabora.com> wrote:
> >>>>>
> >>>>> Hi,
> >>>>>
> >>>>> I'm trying to convert this test to TAP as I think the failures
> >>>>> sometimes go
> >>>>> unnoticed on CI systems if we only depend on the return value of th=
e
> >>>>> application. I've enabled the following configurations which aren't
> >>>>> already
> >>>>> present in tools/testing/selftests/mm/config:
> >>>>> CONFIG_MEMORY_FAILURE=3Dy
> >>>>> CONFIG_HWPOISON_INJECT=3Dm
> >>>>>
> >>>>> I'll send a patch to add these configs later. Right now I'm trying =
to
> >>>>> investigate the failure when we are trying to inject the poison pag=
e by
> >>>>> madvise(MADV_HWPOISON). I'm getting device busy every single time. =
The
> >>>>> test
> >>>>> fails as it doesn't expect any business for the hugetlb memory. I'm=
 not
> >>>>> sure if the poison handling code has issues or test isn't robust en=
ough.
> >>>>>
> >>>>> ./hugetlb-read-hwpoison
> >>>>> Write/read chunk size=3D0x800
> >>>>>   ... HugeTLB read regression test...
> >>>>>   ...  ... expect to read 0x200000 bytes of data in total
> >>>>>   ...  ... actually read 0x200000 bytes of data in total
> >>>>>   ... HugeTLB read regression test...TEST_PASSED
> >>>>>   ... HugeTLB read HWPOISON test...
> >>>>> [    9.280854] Injecting memory failure for pfn 0x102f01 at process
> >>>>> virtual
> >>>>> address 0x7f28ec101000
> >>>>> [    9.282029] Memory failure: 0x102f01: huge page still referenced=
 by
> >>>>> 511
> >>>>> users
> >>>>> [    9.282987] Memory failure: 0x102f01: recovery action for huge
> >>>>> page: Failed
> >>>>>   ...  !!! MADV_HWPOISON failed: Device or resource busy
> >>>>>   ... HugeTLB read HWPOISON test...TEST_FAILED
> >>>>>
> >>>>> I'm testing on v6.7-rc8. Not sure if this was working previously or=
 not.
> >>>>
> >>>> Thanks for reporting this, Usama!
> >>>>
> >>>> I am also able to repro MADV_HWPOISON failure at "501a06fe8e4c
> >>>> (akpm/mm-stable, mm-stable) zswap: memcontrol: implement zswap
> >>>> writeback disabling."
> >>>>
> >>>> Then I checked out the earliest commit "ba91e7e5d15a (HEAD -> Base)
> >>>> selftests/mm: add tests for HWPOISON hugetlbfs read". The
> >>>> MADV_HWPOISON injection works and and the test passes:
> >>>>
> >>>>   ... HugeTLB read HWPOISON test...
> >>>>   ...  ... expect to read 0x101000 bytes of data in total
> >>>>   ...  !!! read failed: Input/output error
> >>>>   ...  ... actually read 0x101000 bytes of data in total
> >>>>   ... HugeTLB read HWPOISON test...TEST_PASSED
> >>>>   ... HugeTLB seek then read HWPOISON test...
> >>>>   ...  ... init val=3D4 with offset=3D0x102000
> >>>>   ...  ... expect to read 0xfe000 bytes of data in total
> >>>>   ...  ... actually read 0xfe000 bytes of data in total
> >>>>   ... HugeTLB seek then read HWPOISON test...TEST_PASSED
> >>>>   ...
> >>>>
> >>>> [ 2109.209225] Injecting memory failure for pfn 0x3190d01 at process
> >>>> virtual address 0x7f75e3101000
> >>>> [ 2109.209438] Memory failure: 0x3190d01: recovery action for huge
> >>>> page: Recovered
> >>>> ...
> >>>>
> >>>> I think something in between broken MADV_HWPOISON on hugetlbfs, and =
we
> >>>> should be able to figure it out via bisection (and of course by
> >>>> reading delta commits between them, probably related to page
> >>>> refcount).
> >>> Thank you for this information.
> >>>
> >>>>
> >>>> That being said, I will be on vacation from tomorrow until the end o=
f
> >>>> next week. So I will get back to this after next weekend. Meanwhile =
if
> >>>> you want to go ahead and bisect the problematic commit, that will be
> >>>> very much appreciated.
> >>> I'll try to bisect and post here if I find something.
> >> Found the culprit commit by bisection:
> >>
> >> a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3
> >> mm/filemap: remove hugetlb special casing in filemap.c

Thanks Usama!

> >>
> >> hugetlb-read-hwpoison started failing from this patch. I've added the
> >> author of this patch to this bug report.
> >>
> > Hi Usama,
> >
> > Thanks for pointing this out. After debugging, the below diff seems to =
fix
> > the issue and allows the tests to pass again. Could you test it on your
> > configuration as well just to confirm.
> >
> > Thanks,
> > Sidhartha
> >
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index 36132c9125f9..3a248e4f7e93 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -340,7 +340,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *io=
cb,
> > struct iov_iter *to)
> >                 } else {
> >                         folio_unlock(folio);
> >
> > -                       if (!folio_test_has_hwpoisoned(folio))
> > +                       if (!folio_test_hwpoison(folio))

Sidhartha, just curious why this change is needed? Does
PageHasHWPoisoned change after commit
"a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3"?

> >                                 want =3D nr;
> >                         else {
> >                                 /*
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index d8c853b35dbb..87f6bf7d8bc1 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -973,7 +973,7 @@ struct page_state {
> >  static bool has_extra_refcount(struct page_state *ps, struct page *p,
> >                                bool extra_pins)
> >  {
> > -       int count =3D page_count(p) - 1;
> > +       int count =3D page_count(p) - folio_nr_pages(page_folio(p));
> >
> >         if (extra_pins)
> >                 count -=3D 1;
> >
> Tested the patch, it fixes the test. Please send this patch.
>
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
> --
> BR,
> Muhammad Usama Anjum

