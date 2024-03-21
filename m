Return-Path: <linux-kernel+bounces-109781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D21F8855A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4EE81F2361C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFB25820D;
	Thu, 21 Mar 2024 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iviqO6Lm"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB42E41A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009522; cv=none; b=vDT9fZnMU/1ozeYWYoW1Cm+JKJ9ha4jFABVuU6d1MLsXTziOxy0JK429+yEVPOJJtwAuartprfPGq5Rj+VvYAa0TysQDnEbRA7DELn4La6numczBusWWOhYKa6COxlPRcfzrv5yUu+SYLay3asNP3mZnLp9tD2GrLmF1Ch+OFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009522; c=relaxed/simple;
	bh=LzEEEuJhrZDVzMkFhAuJzfgPjUFLTvXQXIbHUD4/Ee8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tShWq0KbrexYjxA6xoXRZ1my8Fpq0lpOjAAE+Eh+rRsww0yGy+2dmo0g9dBolQP5QoW37BFf86uTfrN89jX0Lb+QaZdJpdwgqV2niDL8LljeptWZsWwOh7ilQE9nvGJiyCYf1zW/Bd8FVocoA8JDsfRX/nE90sOT/M5Hif4mTLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iviqO6Lm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6a1af9c07so5162751fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711009519; x=1711614319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvfbnVb1eXdw0nR56d+eGwaeQ98n3D2nelDDY84opWQ=;
        b=iviqO6LmJnRTq6HdLblc9DWickc6+4RTBuclw/cwdBgG0F/Q7KZ6IfcQczdh4n/QJp
         CrpCb3c9CoThWbABzuzBO/VMPG1KaXMwYVbqq9R1wk17uhlpqm9Wc+6izRnImULqVqh1
         3/olk5EYcUjMOwvKyxmGWiTK8QOMfRvJF/pH35TIaMJPgQ+EDcSVo2sobo9ZPY/Sp9Z3
         EycicbOUoHI9qw7+UD8ZIPu9I6ZbbUvdryHTqDZYtF9An0BIO7eXm6NxUk2g06ouTQUf
         3HvmorJcnI16b5w4kXpQ+fQLBV425RAhThfBJSDDtsARpbRBmWPRRypG9jxTcbWv23PH
         HjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711009519; x=1711614319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvfbnVb1eXdw0nR56d+eGwaeQ98n3D2nelDDY84opWQ=;
        b=ZhUZ6T/eOlMN0gdC+7ZuL9bGrkRfu4YRkySCL1Ca1nLQQRnBj+K8F548qSiYctYUJQ
         oGIoRfV5gQHojywdTyw8rG2BKZ5+qFJc2oE3F30PVmx6o7MRMJenTVpNnR5slkWyRBCI
         JdvBxyT2dlNUloM6o4zgTsWeozTATTQgQqglNzRV/dgCeZE/5WeYsrTn01jQ/Kcz+Ec6
         Qm8n8tFkO6soYPh8x+ijKUW7v+Jl+APATqyBysRZTeWhAXoeT/g11mQjI1ETdEr3hB6b
         D2Pno8TwQuAHl4vIsZGSXPs55SeGIYdb4RrHNKFZR5IBhOCUbshcGjfJuhnkGyvw7FOQ
         SfmA==
X-Forwarded-Encrypted: i=1; AJvYcCX3KB/jO5Sv3oodBilDpwbgrB6HP2/EajUHolqGGB6Y7w+fhb+JsuGPF0ZHan1Uug7/yKymATsPYqycsBmngO0fIygfrEHVgCl5JiC5
X-Gm-Message-State: AOJu0Yylpvu5kohP3ygXbRze2J8/hvd8Fpa2L+2KcaEr1j2OR618WYvw
	9wHulw0ayp6WiG+WpDeLx9TqXZ4JQ62jUvS3UTWWQ29VWypTaV/ACj+dIqIZchuhnFQ8S7QpW3S
	+jWIOqLZfQcu9GJjCZMOd1/fx98U=
X-Google-Smtp-Source: AGHT+IEt9k1X56Zro5+ZK8rC3NFut05nGKVcN4ug/t1dqN8rznCmffdfbnf8H7J+klnU07T6GWNLrSGA7labS9v/1LQ=
X-Received: by 2002:a2e:95c8:0:b0:2d4:7285:b997 with SMTP id
 y8-20020a2e95c8000000b002d47285b997mr12064943ljh.27.1711009518775; Thu, 21
 Mar 2024 01:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>
 <Zfg0WLrcOmCtdn_M@casper.infradead.org> <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
 <Zfj_-LbiIsAVWcPX@casper.infradead.org>
In-Reply-To: <Zfj_-LbiIsAVWcPX@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 21 Mar 2024 16:25:07 +0800
Message-ID: <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:01=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Mar 19, 2024 at 08:48:42AM +0800, Zhaoyang Huang wrote:
> > BTW, damon_pa_pageout is a potential risk over this race
>
> No it isn't.
>
>                struct folio *folio =3D damon_get_folio(PHYS_PFN(addr));
>
>                 if (!folio)
>                         continue;
>
>                 if (damos_pa_filter_out(s, folio))
>                         goto put_folio;
>
>                 folio_clear_referenced(folio);
>                 folio_test_clear_young(folio);
>                 if (!folio_isolate_lru(folio))
>                         goto put_folio;
>                 if (folio_test_unevictable(folio))
>                         folio_putback_lru(folio);
>                 else
>                         list_add(&folio->lru, &folio_list);
> put_folio:
>                 folio_put(folio);
>
> It clearly has a folio reference when it calls folio_isolate_lru().

ok. Could the scenario below be suspicious on leaving an orphan folio
in step 7 and introduce the bug in step 8. In the scenario,
Thread_filemap behaves as a backdoor for Thread_madv by creating the
pte after Thread_truncate finishes cleaning all page tables.

0. Thread_bad gets the folio by folio_get_entry and stores it in its
local fbatch_bad and go to sleep

1. Thread_filemap get the folio via
filemap_map_pages->next_uptodate_folio->xas_next_entry and gets
preempted
    refcnt =3D=3D 1(page_cache), PG_lru =3D=3D true

2. Thread_truncate get the folio via
truncate_inode_pages_range->find_lock_entries
    refcnt =3D=3D 2(fbatch_trunc, page_cache), PG_lru =3D=3D true

3. Thread_truncate proceed to truncate_cleanup_folio
    refcnt =3D=3D 2(fbatch_trunc, page_cache), PG_lru =3D=3D true

4. Thread_truncate proceed to delete_from_page_cache_batch
    refcnt =3D=3D 1(fbatch_trunc), PG_lru =3D=3D true

5. Thread_filemap schedule back and proceed to setup a pte and have
folio->_mapcnt =3D 0 & folio->refcnt +=3D 1
    refcnt =3D=3D 2(pte, fbatch_temp), PG_lru =3D=3D true

6. Thread_madv clear folio's PG_lru by
madvise_xxx_pte_range->folio_isolate_lru->folio_test_clear_lru
    refcnt =3D=3D 2(pte,fbatch_temp), PG_lru =3D=3D false

7. Thread_truncate call folio_fbatch_release and failed in freeing
folio as refcnt not reach 0
    refcnt =3D=3D 1(pte), PG_lru =3D=3D false
********folio becomes an orphan here which is not on the page cache
but on the task's VM**********

8. Thread_xxx scheduled back from 0 to do release_pages(fbatch_bad)
and have the folio introduce the bug.

