Return-Path: <linux-kernel+bounces-122394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C2388F621
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4086B24102
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1281A39FE4;
	Thu, 28 Mar 2024 04:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+++a+v3"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBBA291E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598597; cv=none; b=JWzSMHviXNNaFIQfgLn1b6mUqr4p5c13G8lfzmXYK3Y9OyOwTivDWsMgdz135oSKR7vkzh7IVqQkkQltdqXgh/hD7qIJQ7fU4cX+UwbEnsMtXU1Mx0TE+Q4VR3xXQjIn752sUQTY12UJMg11TD/+tMWJ0mgF9+ld3hZMcaa2OPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598597; c=relaxed/simple;
	bh=MHiwrnlxm3X9TucZVoG5eoIPRM8WLETsvftNaUwZtSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgNqK5hsPBrKPAPTRHxFeYiF6VWezc20G+9tyFAOVNfYWwboGiQvQINlO7Ka+NZ407odkQB7DB863WxS80bg2u4g+wJOaaKeufh3JMYSf9Bs7TfzPgBt0rdrUr/eb6KSQ5o/2zt+0MrP7TaZA2HNs9XHMK80J6MfDxyH3ibuuSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+++a+v3; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51588f70d2dso509993e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711598594; x=1712203394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y26LU5IaRA0ySvMRHMq2FysiOdELeoSdL42Vw4YgFQU=;
        b=K+++a+v3lvVHubTAIOkzeIvdYKCRDHYhYT/GKCrrhOGxROYXd8NwDkZyV6SBCmNjEu
         OlgXJABENBYrcE+ZKHTiFrrdeq3S3hmRCRrLhS0Iwj/ljYgaldH6vQHzmnijvBz7sV8l
         GQ/bHK6pczOHdDNsYNvugW8u83gMl5W/amX8HG6B46wRNeEabycCBvCxXKGvMj6MDpMy
         XFW6olHf0uj5Rmzy9pJSoQXtpQl9OPIHvnVL5ICNTdW0KMO/sKAWjtEJrXyx/ZWkWnJ9
         qNQCkcQVkk4qJ47jNYJ5o6rRzGeWlGFyk+Qju5oU5SGVDJQvc4UJ+Zh93Y31bP34TBdw
         NBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711598594; x=1712203394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y26LU5IaRA0ySvMRHMq2FysiOdELeoSdL42Vw4YgFQU=;
        b=XCtWaGf4utq8FIbAQyhKKvu+pw0Y+k1iOZfsiE6SSjp9k+7ypsQGqvGPREzYI11tbb
         B++4rTBkwaTz+uR+C+gMQ0DjJB+AxU+NzzqOPy0I18gqKgyexrAZtfrOGdfezSEqk1DO
         I1vWY+Fp8hq457UiaRFL24IQYghjYcnrI6Wrgwp4M4dwbwYLfdVvv3q5ZZ737ZaDF4Xa
         14mYrWJtzDb2wBOBlye6UKxkiIWrP3bD8cKj5lavmXq4IaD1gplmKxELQh6Rm24T7ZME
         np3IVKhksY1QdbMBeBerRsf1V+juc/YKpVuBxf4UwzG0KnpehkszxLFvAfZsR2sj3qNO
         7Psw==
X-Forwarded-Encrypted: i=1; AJvYcCXBwy2X/mVxWsEb5i+Fa+yl7BFBwQTDH/ZfmxFvpI3WBnxy5TKr81wGRFBwtEEQ+9oUgkRHDClVyn1ZRw01datmipPdP7JaEVDQXWrf
X-Gm-Message-State: AOJu0Yx0+o0Tk8PUEU6ARCOzoPOTxcyjF2s8ypwbit3Kvcof3PoOQ3jO
	R+9icnvF6KTHFoh9dO6OimKqvITe/K2aljnsU43pb4G+aNP7xnIHwsGErX19/YDRbkUVxWsN8te
	0X6l+meuxQNhg/jjlH3AHhM/5FgM=
X-Google-Smtp-Source: AGHT+IHWYxXbkvHuAYVca52UgrVPta+8NGXkypikoZTNY3AvWAgzhKMpCVfrkv3KLZQu53L40XNZDPiZmlO+yqZb6cY=
X-Received: by 2002:a05:6512:3f0:b0:515:96ab:4183 with SMTP id
 n16-20020a05651203f000b0051596ab4183mr742364lfq.37.1711598593481; Wed, 27 Mar
 2024 21:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfwpuRjAZV07_lc3@casper.infradead.org> <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
 <Zfz4_GJAHRInB8ul@casper.infradead.org> <CAGWkznEzpcWi4oXVn_WFahnQj3dHcwc_4VW6m1Ss-KJ8mD3F3Q@mail.gmail.com>
 <ZgDt9mwN-Py5Y-xr@casper.infradead.org> <CAGWkznHO27EpVVpFyKnv-SX-JTYCXQxb0MG+EW07gaupocR4RQ@mail.gmail.com>
 <ZgK91II_eSYY6D2F@casper.infradead.org> <CAGWkznGLySzLE17+rCe=UoA26vx=iM375o2zkruKM9ssG05QzA@mail.gmail.com>
 <ZgQRtQ60mrvOUKXo@casper.infradead.org> <CAGWkznF3GfCs8odhR-Hue5H8MZ=eXb82V20ZoCCjeoSjAPQ9cw@mail.gmail.com>
 <ZgThg-pzQzRl3ckF@casper.infradead.org>
In-Reply-To: <ZgThg-pzQzRl3ckF@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 28 Mar 2024 12:03:02 +0800
Message-ID: <CAGWkznEMCXQSe10E-pbdxk2uFgQO038wH6g=iojtSU6-N+GJdg@mail.gmail.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:18=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Mar 28, 2024 at 09:27:31AM +0800, Zhaoyang Huang wrote:
> > ok, I missed the refcnt from alloc_pages. However, I still think it is
> > a bug to call readahead_folio in read_pages as the refcnt obtained by
> > alloc_pages should be its final guard which is paired to the one which
> > checked in shrink_folio_list->__remove_mapping->folio_ref_freeze(2)(thi=
s
> > 2 represent alloc_pages & page cache). If we removed this one without
>
> __remove_mapping()  requires that the caller holds the folio locked.
> Since the readahead code unlocks the folio, __remove_mapping() cannot
> be run because the caller of __remove_mapping() will wait for the folio
> lock.
repost the whole timing sequence to make it more clear and fix
incorrect description of previous feedback

Follow the refcount through.

In page_cache_ra_unbounded():

                folio =3D filemap_alloc_folio(gfp_mask, 0);
(folio has refcount 1)
                ret =3D filemap_add_folio(mapping, folio, index + i, gfp_ma=
sk);
(folio has refcount 2, PG_lru)

Then we call read_pages()
First we call ->readahead() which for some reason stops early.
Then we call readahead_folio() which calls folio_put()
(folio has refcount 1)
Then we call folio_get()
(folio has refcount 2)
Then we call filemap_remove_folio()
(folio has refcount 1)
Then we call folio_unlock()
Then we call folio_put()

Amending steps for previous timing sequence below where [1] races with
[2] that has nothing to do with __remove_mapping(). IMO, no file_folio
should be freed by folio_put as the refcnt obtained by alloc_pages
keep it always imbalanced until shrink_folio_list->__remove_mapping,
where the folio_ref_freeze(2) implies the refcnt of alloc_pages and
isolation should be the last two. release_pages is a special scenario
that the refcnt of alloc_pages is freed implicitly in
delete_from_page_cache_batch->filemap_free_folio.

    folio_put()
    {
         if(folio_put_test_zero())
*** we should NOT be here as the refcnt of alloc_pages should NOT be droppe=
d ***
         if (folio_test_lru())
***  preempted here with refcnt =3D=3D 0 and pass PG_lru check ***
[1]
         lruvec_del_folio()
Then thread_isolate call folio_isolate_lru()
      folio_isolate_lru()
      {
         folio_test_clear_lru()
         folio_get()
[2]
         lruvec_del_folio()
      }
---------------------------------------------------------------------------=
-----------------
shrink_folio_list()
{
    __remove_mapping()
    {
        refcount =3D 1 + folio_nr_pages;
*** the refcount =3D 1 + 1 implies there should be only the refcnt of
alloc_pages and previous isolation for a no-busy folio as all PTE has
gone***
        if (!folio_ref_freeze(refcount))
             goto keeplock;
     }
}

