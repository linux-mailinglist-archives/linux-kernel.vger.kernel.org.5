Return-Path: <linux-kernel+bounces-23980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB50282B4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365641F28BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFEB1F60F;
	Thu, 11 Jan 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BLOEg84O"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2939F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed729a4f2so4948191276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704997838; x=1705602638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fY44QehQLsPtLxgWQHF6aw3Iv2rADsazU3iCR26tI4=;
        b=BLOEg84OGqP6/LxGRTOKdsqFBMG7UiFoYcbh4XQzJVwo124HhclJOxVEoM/wVUTnat
         IkfJP9crixkeBwLRZuW8r7v+UkCzsWyJHmRHPgd6xjsgsoFLh24wyBPhEjxyIj3qvWMD
         jQWtrrEfo+CV1iiDuEFpO+TtN+Tq+yZUbL99TzP4uEfKIQ5+J2ai5fY/ZM3KROdz5jQP
         A8AESvEgnF3peje86XWACFPCypqw8DUfv291uofkSqoWiT3vtF4HWELXFgXwXrq1Iw/F
         2X7Jg3cBiUGy8WyviOvM1jX3Mi2/CqAsCHpSRimhzq9hA3RCSJSJ9KbfabIU8sNbrjTw
         cvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704997838; x=1705602638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fY44QehQLsPtLxgWQHF6aw3Iv2rADsazU3iCR26tI4=;
        b=E7j/AZGAxAMBknOW42E4bk6kDE7eh/gv4Tu5GulzcncVS+vyDAVWsJX3qN9F2D66Yt
         0noWeZ/rQUPisVKCr7/PQxbGaZ6qH+o05y9PXQEavJsj2k+lb/YjZdAhKhInkMW/K0BI
         pvV6lu02r4TPXadZr5G2DQgWypjm1uks26KIyajHyjrmABy1IGZMjE6aYFrucqTHnI7X
         j/DdSstjksjujhUprr7U1+ObECIs7xG7ObhgijB9pEpwxHHdM/aWcc6JivDDJj40Yd8z
         qEiMb0RKctdmWJJRbYWSp3bEFSoVOVyCb6AbDJ9YwwAa6Wdm1IV+k4GmTYjyHnQPXPqy
         nKYw==
X-Gm-Message-State: AOJu0YxTvRFpxbkM9CF1vFbHsyVcHvimye40t6s4OsiiXEwZQPMcRkXz
	5QqeTWNzcMVlue4ifvoWA5FWDNPgcFHx177dsp+O+Cp6M/fr
X-Google-Smtp-Source: AGHT+IGu8xM1mI1IuVg0Xh1NHzyABL7jO33XxIfjwVz0zOvSd0/h6PSkZLOyDnDcac1Pu/0tOy/PQ5be2Aq836WKPSw=
X-Received: by 2002:a5b:8:0:b0:dbf:23cd:c05c with SMTP id a8-20020a5b0008000000b00dbf23cdc05cmr66460ybp.13.1704997838063;
 Thu, 11 Jan 2024 10:30:38 -0800 (PST)
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
 <CACw3F53PddeCHUHb=m8OSO6yYQJoM==urn+Axp=Xi1szozJH9A@mail.gmail.com>
 <6bacbd7c-88cb-1399-8bd0-db98c93a1adf@oracle.com> <ZaAtjVVTETdQDR4B@casper.infradead.org>
 <39b90dce-fe0f-e1d8-3094-75cabbfa38a3@oracle.com>
In-Reply-To: <39b90dce-fe0f-e1d8-3094-75cabbfa38a3@oracle.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Thu, 11 Jan 2024 10:30:25 -0800
Message-ID: <CACw3F52B9ckzqUmGzzQxpskJGRZu+3m+tVRoSekhgsX-mQaeBw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] selftests/mm: add tests for HWPOISON hugetlbfs read
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, linmiaohe@huawei.com, 
	mike.kravetz@oracle.com, naoya.horiguchi@nec.com, akpm@linux-foundation.org, 
	songmuchun@bytedance.com, shy828301@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, jthoughton@google.com, 
	"kernel@collabora.com" <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:11=E2=80=AFAM Sidhartha Kumar
<sidhartha.kumar@oracle.com> wrote:
>
> On 1/11/24 10:03 AM, Matthew Wilcox wrote:
> > On Thu, Jan 11, 2024 at 09:51:47AM -0800, Sidhartha Kumar wrote:
> >> On 1/11/24 9:34 AM, Jiaqi Yan wrote:
> >>>> -                       if (!folio_test_has_hwpoisoned(folio))
> >>>> +                       if (!folio_test_hwpoison(folio))
> >>>
> >>> Sidhartha, just curious why this change is needed? Does
> >>> PageHasHWPoisoned change after commit
> >>> "a08c7193e4f18dc8508f2d07d0de2c5b94cb39a3"?
> >>
> >> No its not an issue PageHasHWPoisoned(), the original code is testing =
for
> >> the wrong flag and I realized that has_hwpoison and hwpoison are two
> >> different flags. The memory-failure code calls folio_test_set_hwpoison=
() to
> >> set the hwpoison flag and does not set the has_hwpoison flag. When
> >> debugging, I realized this if statement was never true despite the cod=
e
> >> hitting folio_test_set_hwpoison(). Now we are testing the correct flag=
.
> >>
> >>  From page-flags.h
> >>
> >> #ifdef CONFIG_MEMORY_FAILURE
> >>      PG_hwpoison,            /* hardware poisoned page. Don't touch */
> >> #endif
> >>
> >> folio_test_hwpoison() checks this flag ^^^
> >>
> >> /* At least one page in this folio has the hwpoison flag set */
> >> PG_has_hwpoisoned =3D PG_error,
> >>
> >> while folio_test_has_hwpoisoned() checks this flag ^^^
> >
> > So what you're saying is that hugetlb behaves differently from THP
> > with how memory-failure sets the flags?
>
> I think so, in memory_failure() THP goes through this path:
>
>         hpage =3D compound_head(p);
>         if (PageTransHuge(hpage)) {
>                 /*
>                  * The flag must be set after the refcount is bumped
>                  * otherwise it may race with THP split.
>                  * And the flag can't be set in get_hwpoison_page() since
>                  * it is called by soft offline too and it is just called
>                  * for !MF_COUNT_INCREASED.  So here seems to be the best
>                  * place.
>                  *
>                  * Don't need care about the above error handling paths f=
or
>                  * get_hwpoison_page() since they handle either free page
>                  * or unhandlable page.  The refcount is bumped iff the
>                  * page is a valid handlable page.
>                  */
>                 SetPageHasHWPoisoned(hpage);
>
> which sets has_hwpoisoned flag while hugetlb goes through
> folio_set_hugetlb_hwpoison() which calls folio_test_set_hwpoison().

Yes, hugetlb sets HWPoison flag as the whole hugepage is poisoned once
a raw page is poisoned. It can't split to make other supages still
available as THP. This "Improve hugetlbfs read on HWPOISON hugepages"
patchset only improves fs case as splitting is not needed.

I found commit a08c7193e4f18 ("mm/filemap: remove hugetlb special
casing in filemap.c") has the following changes in inode.c:

--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -334,7 +334,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb
*iocb, struct iov_iter *to)
        ssize_t retval =3D 0;

        while (iov_iter_count(to)) {
-               struct page *page;
+               struct folio *folio;
                size_t nr, copied, want;

                /* nr is the maximum number of bytes to copy from this page=
 */
@@ -352,18 +352,18 @@ static ssize_t hugetlbfs_read_iter(struct kiocb
*iocb, struct iov_iter *to)
                }
                nr =3D nr - offset;


                /* nr is the maximum number of bytes to copy from this page=
 */
@@ -352,18 +352,18 @@ static ssize_t hugetlbfs_read_iter(struct kiocb
*iocb, struct iov_iter *to)
                }
                nr =3D nr - offset;

-               /* Find the page */
-               page =3D find_lock_page(mapping, index);
-               if (unlikely(page =3D=3D NULL)) {
+               /* Find the folio */
+               folio =3D filemap_lock_hugetlb_folio(h, mapping, index);
+               if (IS_ERR(folio)) {
                        /*
                         * We have a HOLE, zero out the user-buffer for the
                         * length of the hole or request.
                         */
                        copied =3D iov_iter_zero(nr, to);
                } else {
-                       unlock_page(page);
+                       folio_unlock(folio);

-                       if (!PageHWPoison(page))
+                       if (!folio_test_has_hwpoisoned(folio))
                                want =3D nr;

So I guess this "PageHWPoison =3D> folio_test_has_hwpoisoned" change is
another regression aside from the refcount thing?

