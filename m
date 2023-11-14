Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066217EA854
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjKNBlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjKNBlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:41:45 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F28D45
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:41:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-28014fed9efso4292760a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 17:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699926102; x=1700530902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEeUiwyJOdjcPLVMB9NgU6wAX2Pgk56yEjQQSh56OSQ=;
        b=EMh28kz9Lp0wplsVFdWli1wh8FeV3LAEyWZn1wgh/cOQeA4T5ayB49QMk3/LENHZqJ
         QqP+qOv+AUskJ3at3jzDwoLVY4LNAJYkZDVvdybEs8pJBszTDd2nld5vLsksDE+FSoBj
         7EB5VAZ4zpqQ7BS9v54EjftU6GXwAzmMxSQgjH2/AL9Fhq6XtEn0rpNKqbE/McAtDlh8
         FsSyPd33dfqCy/8xZ7KM46N/3JaeslHFQHYFFcTzI+rMkeB4UmTK3d3PcFxxN6ihQwmD
         J8/E7iH1wVW9mlcG2zfPTpXUIS2AesfQT7t1qmemUdH1CExzqwQtxWl3vLEAGTWMfrzk
         TkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699926102; x=1700530902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEeUiwyJOdjcPLVMB9NgU6wAX2Pgk56yEjQQSh56OSQ=;
        b=lMd4frjsu4pBW/0oZjVqJOUjWEsFOITz7ig3rIvJtSp7wjj6IM0hHnbirgCVpRsXzO
         xoMUmkn4rLgyOod4hpkJFpBE0lRHzEtkajY/gXSshTZ88uwWaCP6e3vFrPefSKY480r5
         n7j8JqmAIC9e5zrW+58BBua3LmEIPLQiNs90YsCtP6qG8l8ioDokbhLXQsXvmrDTDhCT
         L0VeMNKiGACdQCOnxr0I1FBbpVoJljWQ09aQZZFqFphrM/gA0WoLuT0pTcyvOs+9i2y2
         6pgn9ME/bQXp5poyPAgs0wDg1XT5N9RuTsPrlZE+CF0bq0/WBletRy2gL7r1hFM+Iszt
         aRAw==
X-Gm-Message-State: AOJu0Ywe49njY6BWx1x0hQgp8IU9OxKUxlPP1ci02aoESNWv4SS4X6Bf
        PYb+aZEX53buVC4BAMcmwaPGKyP29YqWXp+/BnE=
X-Google-Smtp-Source: AGHT+IHSdGjr5fWGKFB8RgkBNC2lvRJ5l6hmgO2Mi0AvIn7Cek6EiLA0WjbQzmd5OddmLan5y9ORhGFHYhMNRE7WSqE=
X-Received: by 2002:a17:90b:3b52:b0:280:c576:31bc with SMTP id
 ot18-20020a17090b3b5200b00280c57631bcmr6400618pjb.32.1699926101834; Mon, 13
 Nov 2023 17:41:41 -0800 (PST)
MIME-Version: 1.0
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
 <CAHbLzkqEytFbRoHU3=Y85tmTQ--XVQpwhVEXgDN0ss_PPv8VGA@mail.gmail.com> <648aa9dc-fc42-4f28-af9a-b24adfdcd43d@intel.com>
In-Reply-To: <648aa9dc-fc42-4f28-af9a-b24adfdcd43d@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 13 Nov 2023 17:41:30 -0800
Message-ID: <CAHbLzkokzDAAfWoB8gsUpSUubAq+V-Gu_0pjpaGvKb83kA0Vww@mail.gmail.com>
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     "zhangpeng (AS)" <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Matthew Wilcox <willy@infradead.org>, lstoakes@gmail.com,
        hughd@google.com, david@redhat.com, vbabka@suse.cz,
        peterz@infradead.org, mgorman@suse.de, mingo@redhat.com,
        riel@redhat.com, ying.huang@intel.com, hannes@cmpxchg.org,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 5:57=E2=80=AFPM Yin, Fengwei <fengwei.yin@intel.com>=
 wrote:
>
>
>
> On 11/10/2023 6:54 AM, Yang Shi wrote:
> > On Thu, Nov 9, 2023 at 5:48=E2=80=AFAM zhangpeng (AS) <zhangpeng362@hua=
wei.com> wrote:
> >>
> >> Hi everyone,
> >>
> >> There is a performance issue that has been bothering us recently.
> >> This problem can reproduce in the latest mainline version (Linux 6.6).
> >>
> >> We use mlockall(MCL_CURRENT | MCL_FUTURE) in the user mode process
> >> to avoid performance problems caused by major fault.
> >>
> >> There is a stage in numa fault which will set pte as 0 in do_numa_page=
() :
> >> ptep_modify_prot_start() will clear the vmf->pte, until
> >> ptep_modify_prot_commit() assign a value to the vmf->pte.
> >>
> >> For the data segment of the user-mode program, the global variable are=
a
> >> is a private mapping. After the pagecache is loaded, the private
> >> anonymous page is generated after the COW is triggered. Mlockall can
> >> lock COW pages (anonymous pages), but the original file pages cannot
> >> be locked and may be reclaimed. If the global variable (private anon p=
age)
> >> is accessed when vmf->pte is zero which is concurrently set by numa fa=
ult,
> >> a file page fault will be triggered.
> >>
> >> At this time, the original private file page may have been reclaimed.
> >> If the page cache is not available at this time, a major fault will be
> >> triggered and the file will be read, causing additional overhead.
> >>
> >> Our problem scenario is as follows:
> >>
> >> task 1                      task 2
> >> ------                      ------
> >> /* scan global variables */
> >> do_numa_page()
> >>    spin_lock(vmf->ptl)
> >>    ptep_modify_prot_start()
> >>    /* set vmf->pte as null */
> >>                              /* Access global variables */
> >>                              handle_pte_fault()
> >>                                /* no pte lock */
> >>                                do_pte_missing()
> >>                                  do_fault()
> >>                                    do_read_fault()
> >>    ptep_modify_prot_commit()
> >>    /* ptep update done */
> >>    pte_unmap_unlock(vmf->pte, vmf->ptl)
> >>                                      do_fault_around()
> >>                                      __do_fault()
> >>                                        filemap_fault()
> >>                                          /* page cache is not availabl=
e
> >>                                          and a major fault is triggere=
d */
> >>                                          do_sync_mmap_readahead()
> >>                                          /* page_not_uptodate and goto
> >>                                          out_retry. */
> >>
> >> Is there any way to avoid such a major fault?
> >
> > IMHO I don't think it is a bug. The man page quoted by Willy says "All
> > mapped pages are guaranteed to be resident in RAM when the call
> > returns successfully", but the later COW already made the file page
> > unmapped, right? The PTE pointed to the COW'ed anon page.
> > Hypothetically if we kept the file page mlocked and unmapped,
> > munlock() would have not munlocked the file page at all, it would be
> > mlocked in memory forever.
> But in this case, even the COW page is mlocked. There is small window
> that PTE is set to null in do_numa_page(). data segment access (it's to
> COW page which has nothing to do with original page cache) happens in
> this small window will trigger filemap_fault() to fault in original
> page cache.

Yes, my point is this may not break the mlockall, but the potential
optimization by avoiding the major fault may still stand.

>
> I had thought to do double check whether vmf->pte is NULL in do_read_faul=
t().
> But it's not reliable enough.
>
> Matthew's idea to use protnone to block both hardware accessing and
> do_pte_missing() looks more promising to me.
>
>
> Regards
> Yin, Fengwei
>
> >
> >>
> >> --
> >> Best Regards,
> >> Peng
> >>
