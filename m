Return-Path: <linux-kernel+bounces-110864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A3A8864EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB941C22350
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CC215BB;
	Fri, 22 Mar 2024 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4eHYeg/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252810E3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072371; cv=none; b=AzG60/5Mdo7p2ahP54ClwXBH7SgMAAcrX+DCW/Ujp5qRXCAKKAFAYJWNxxyz1zGloVdPr+d2YsWcvdTRUhN81LZWWllf9Swys6YwfpSPsf3/swUsas5HW1hxYWgtU5sNmhpOhNQukNMHe0G/YvU5+dxY41qhVOF2ztjLYVmyuU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072371; c=relaxed/simple;
	bh=zixhV+cNi+JOIgJjhXq4BRqfb2sgRmrwYoJUvc9l8iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WrPdxo9rf57Kz4yzav7DNYAh7h0frPsJOCQoDzFPluure1lCOrKP6Fy4oY6DGMGGx0k2h0zynL0I70MCWLVooDETmUjBa8fujA9zCpp8W1NnxSxxwk22w7xkPY2ackxPOH7F8aQX9p8v/cfk+hkkHE4eYUYerHwWmMDnmAUA6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4eHYeg/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513edc88d3cso1689459e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711072368; x=1711677168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNBMFTM15k325ob8+xUYC/3jWDb7dhwaiyxnvR1gLmo=;
        b=H4eHYeg/65sORcK/hQkB1ttcKNNcabHT3ynb2vAEHntdQexk7B57W99y/3hlxrXGHZ
         DPOwSaUuzAQrCn4h8KNGWVRFL7uS+Njzhav/t4NhbfBrBNDXvKdN3RuPrEuGPaknwK/R
         v78ASbm4GJSnRhdmf2GgCM6M2Dh8neW5hwl5zLFZ2+i6ScbZ2D2jpC3Bl3NSt2myFQgf
         lwR6Ml0M8yfTATNxFm5PTxdg8hRTcvkIItJzy9hI6BbkcAH0TXzTX8WAGU5+Szbdrq+6
         8dmmcyepAtEEyQpfDwywumqnDhNMsi380nax3syGi+7Gnwr6DbB1ZqlY64V4mzAoEXkJ
         W3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711072368; x=1711677168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNBMFTM15k325ob8+xUYC/3jWDb7dhwaiyxnvR1gLmo=;
        b=uWTIfXU7SbhfI1NT/oqCOs7I/LFNhXDpTg7aUDZ91l4hzsSs22HF8n4ol1NFpDN6Fj
         i5jyhsk0FbaD28WwL9R8kWy0WZSaLKRw0r9nKby1CBfaXzDCSk4GwBPwNH7J2lLQ4zxD
         dnzVENPbZQ2v2KkYxZXQx4E8idD9JsJbVYHdy/r7lf09GbAvDoMviscVetPuu1/Bw8RZ
         u/CVVLL9HeR5OOhMYEZyVhO8luMpZdK7//x1/XPozTU8GRI6NI2rX9B/U2inTHCwJWVT
         JCuqS2XNgkjd5nNQR+wCiMY93an70j9nmmk7aHUaWEV7SPE34W58uwW0RmBEd+RYNfX/
         y47w==
X-Forwarded-Encrypted: i=1; AJvYcCUIQC+ByjUceuYTI07kfnbwdg19uJasoNTEjiCRH5qFcrIvOXCn5bEBBEkeMTW41iViiIKZDV5MRyMYBVtzpvrOdk+Vqd3hOpUovroh
X-Gm-Message-State: AOJu0YzFPcBelQ2TKfFQWBNgbMmd0JrPht2OLW01h4pis22LAQBqZ6kS
	gFRgwaO+ooJemiz8i5+tDRsmLTXo9dfl9AYjQdbH9gTwPqo2mXYlDOW8d8XTylVob4uF5RZcWCA
	1z0qOjBSBTnahxkKGN5sAJsgQmEATOdAxErk=
X-Google-Smtp-Source: AGHT+IEeVnwKVqQhi5/EAi48TQmP5Pco8j9Rxqyao2UqtcVj/zE0WgShGkJiiYVvCS1gy/WZno//xhIZGU07s18k74g=
X-Received: by 2002:ac2:5eca:0:b0:515:90e8:f873 with SMTP id
 d10-20020ac25eca000000b0051590e8f873mr594954lfq.35.1711072367413; Thu, 21 Mar
 2024 18:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <be75859d7e4245939d825da5e881902c@BJMBX01.spreadtrum.com>
 <Zfg0WLrcOmCtdn_M@casper.infradead.org> <CAGWkznGhiuzkqfeewNq-ykKehvFTBjH2v_==xAS2_7iFqsFk5A@mail.gmail.com>
 <Zfj_-LbiIsAVWcPX@casper.infradead.org> <CAGWkznHOWVPpKHOuvvDF2zppkTT0_x4WyJ5S75j+EghhZmEDdg@mail.gmail.com>
 <ZfwpuRjAZV07_lc3@casper.infradead.org>
In-Reply-To: <ZfwpuRjAZV07_lc3@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 22 Mar 2024 09:52:36 +0800
Message-ID: <CAGWkznFtez1fj2L2CtFnA5k-Tn4WtxmDOw=fjOWPg-ZGJX=VWw@mail.gmail.com>
Subject: Re: summarize all information again at bottom//reply: reply: [PATCH]
 mm: fix a race scenario in folio_isolate_lru
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?B?6buE5pyd6ZizIChaaGFveWFuZyBIdWFuZyk=?= <zhaoyang.huang@unisoc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?5bq357qq5ruoIChTdGV2ZSBLYW5nKQ==?= <Steve.Kang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 8:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Mar 21, 2024 at 04:25:07PM +0800, Zhaoyang Huang wrote:
> > ok. Could the scenario below be suspicious on leaving an orphan folio
> > in step 7 and introduce the bug in step 8. In the scenario,
> > Thread_filemap behaves as a backdoor for Thread_madv by creating the
> > pte after Thread_truncate finishes cleaning all page tables.
> >
> > 0. Thread_bad gets the folio by folio_get_entry and stores it in its
> > local fbatch_bad and go to sleep
>
> There's no function called folio_get_entry(), but clearly thread_bad
> should have a refcount on it at this point.
>
> > 1. Thread_filemap get the folio via
> > filemap_map_pages->next_uptodate_folio->xas_next_entry and gets
> > preempted
> >     refcnt =3D=3D 1(page_cache), PG_lru =3D=3D true
>
> so the refcount should be 2 here.
>
> > 2. Thread_truncate get the folio via
> > truncate_inode_pages_range->find_lock_entries
> >     refcnt =3D=3D 2(fbatch_trunc, page_cache), PG_lru =3D=3D true
> >
> > 3. Thread_truncate proceed to truncate_cleanup_folio
> >     refcnt =3D=3D 2(fbatch_trunc, page_cache), PG_lru =3D=3D true
> >
> > 4. Thread_truncate proceed to delete_from_page_cache_batch
> >     refcnt =3D=3D 1(fbatch_trunc), PG_lru =3D=3D true
> >
> > 5. Thread_filemap schedule back and proceed to setup a pte and have
> > folio->_mapcnt =3D 0 & folio->refcnt +=3D 1
> >     refcnt =3D=3D 2(pte, fbatch_temp), PG_lru =3D=3D true
> >
> > 6. Thread_madv clear folio's PG_lru by
> > madvise_xxx_pte_range->folio_isolate_lru->folio_test_clear_lru
> >     refcnt =3D=3D 2(pte,fbatch_temp), PG_lru =3D=3D false
> >
> > 7. Thread_truncate call folio_fbatch_release and failed in freeing
> > folio as refcnt not reach 0
> >     refcnt =3D=3D 1(pte), PG_lru =3D=3D false
> > ********folio becomes an orphan here which is not on the page cache
> > but on the task's VM**********
> >
> > 8. Thread_xxx scheduled back from 0 to do release_pages(fbatch_bad)
> > and have the folio introduce the bug.
>
> ... because if these steps happen as 7, 8, 6, you hit the BUG in
> folio_isolate_lru().
Thanks for the comments. fix the typo and update the timing sequence
by amending possible preempt points to have the refcnt make sense.

0. Thread_bad gets the folio by find_get_entry and preempted before
take refcnt(could be the second round scan of
truncate_inode_pages_range)
    refcnt =3D=3D 1(page_cache), PG_lru =3D=3D true, PG_lock =3D=3D false
    find_get_entry
        folio =3D xas_find
        <preempted>
        folio_try_get_rcu

1. Thread_filemap get the folio via
filemap_map_pages->next_uptodate_folio->xas_next_entry and gets preempted
    refcnt =3D=3D 1(page_cache), PG_lru =3D=3D true, PG_lock =3D=3D false
    filemap_map_pages
        next_uptodate_folio
           xas_next_entry
           <preempted>
           folio_try_get_rcu

2. Thread_truncate get the folio via
truncate_inode_pages_range->find_lock_entries
    refcnt =3D=3D 2(page_cache, fbatch_truncate), PG_lru =3D=3D true, PG_lo=
ck =3D=3D true

3. Thread_truncate proceed to truncate_cleanup_folio
    refcnt =3D=3D 2(page_cache, fbatch_truncate), PG_lru =3D=3D true, PG_lo=
ck =3D=3D true

4. Thread_truncate proceed to delete_from_page_cache_batch
    refcnt =3D=3D 1(fbatch_truncate), PG_lru =3D=3D true, PG_lock =3D=3D tr=
ue

4.1 folio_unlock
    refcnt =3D=3D 1(fbatch_truncate), PG_lru =3D=3D true, PG_lock =3D=3D fa=
lse

5. Thread_filemap schedule back from '1' and proceed to setup a pte
and have folio->_mapcnt =3D 0 & folio->refcnt +=3D 1
    refcnt =3D=3D 1->2(+fbatch_filemap)->3->2(pte, fbatch_truncate),
PG_lru =3D=3D true, PG_lock =3D=3D true->false

6. Thread_madv clear folio's PG_lru by
madvise_xxx_pte_range->folio_isolate_lru->folio_test_clear_lru
    refcnt =3D=3D 2(pte,fbatch_truncate), PG_lru =3D=3D false, PG_lock =3D=
=3D false

7. Thread_truncate call folio_fbatch_release and failed in freeing
folio as refcnt not reach 0
    refcnt =3D=3D 1(pte), PG_lru =3D=3D false, PG_lock =3D=3D false
********folio becomes an orphan here which is not on the page cache
but on the task's VM**********

8. Thread_bad scheduled back from '0' to be collected in fbatch_bad
    refcnt =3D=3D 2(pte, fbatch_bad), PG_lru =3D=3D false, PG_lock =3D=3D t=
rue

9. Thread_bad clear one refcnt wrongly when doing filemap_remove_folio
as it take this refcnt as the page cache one
    refcnt =3D=3D 1(fbatch_bad), PG_lru =3D=3D false, PG_lock =3D=3D true->=
false
    truncate_inode_folio
        filemap_remove_folio
             filemap_free_folio
******refcnt decreased wrongly here by being taken as the page cache one **=
****

10. Thread_bad calls release_pages(fbatch_bad) and has the folio
introduce the bug.
    release_pages
        folio_put_testzero =3D=3D true
        folio_test_lru =3D=3D false
        list_add(folio->lru, pages_to_free)

