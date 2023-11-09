Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8B97E7493
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbjKIWya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjKIWy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:54:29 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DCA4228
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:54:27 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28028f92709so1200424a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 14:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699570467; x=1700175267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIZdn5XykZif1npBwqP+hLZnRaUDtVjzaMva9504omU=;
        b=Kr0hasuVfegQF/+QYmyL3HC20zeJplOhacc+aa6iR80ndvmMQR5FnsQN2ZXnvCanN2
         07Sk+wVkry9GLpjkaDsg4/4N08Ky6+98+aTvA4WumJyqD8mIAJoRS4B+CwYyx42lqiWP
         hQWVmlKTThaBK2F9UVJX1Sy9P9G+qqOf9oYzG7YwnkUL17tNnH8nICy6+dHjQPnMT615
         f+WdMISkqvZ6yOec0LkFb7fnx1f4KZob7uZbeMCwv7hl+jZjFpkY0o693TFigdorZbI6
         9YpwVmKuno1pStdzM+Ve2H9RgfxXgTZZ7insyRM77fEOSto6qMjrFoY+fXiEomFHpBHM
         DJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699570467; x=1700175267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIZdn5XykZif1npBwqP+hLZnRaUDtVjzaMva9504omU=;
        b=FTdBkRiYqMWUPt0DZn/sCfiToOFA1uV5Xq6yyf17Pgiv9wIf9eG1pZrQX3Qise+qzn
         idaVYa9eTGNovX55mCougI+foUPL25Yz/33VYSn28cahWxQsP3iW/buUl6twe7kZbt22
         3EOCloQNYlTGrNfBGgwAY0ww9rcPYXTlK39bAn1Gvo0/fA4fYMgXE/hJViKzJbgcSC7v
         Ds/uPHTuKWK+f8Tvh2OKyleQ1VPrkh2avdpY1Hk7cFa6Byvb4WA1hh+2rpHTfW1sT3g4
         xmiS8Nrh0PMUt8NfQCL3JZkf9xkwNLPjk6M7SsKMhqiEPFHq+8XkL5PYKzWJPAv9vXBh
         XhKQ==
X-Gm-Message-State: AOJu0Yz/k7uwZsXrmY9CeQhHq3441OQBEG1BN+RoYj2f+7fivPtqt/BR
        5usVD2QVv6MMmWGja8fxv+dll2kGyS7qnbsPVVw=
X-Google-Smtp-Source: AGHT+IG6IaoVKh1ZSoJU8uXbc5Gn3Y0Jrl1qPtYPEoHh5YTH+VRqcY2zdlsPjHv/eRW6+UAE7FSUC051ONuR6Jto/8Y=
X-Received: by 2002:a17:90a:f6ce:b0:280:22bc:686 with SMTP id
 er14-20020a17090af6ce00b0028022bc0686mr997046pjb.6.1699570466977; Thu, 09 Nov
 2023 14:54:26 -0800 (PST)
MIME-Version: 1.0
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
In-Reply-To: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 9 Nov 2023 14:54:15 -0800
Message-ID: <CAHbLzkqEytFbRoHU3=Y85tmTQ--XVQpwhVEXgDN0ss_PPv8VGA@mail.gmail.com>
Subject: Re: [Question]: major faults are still triggered after mlockall when
 numa balancing
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
        lstoakes@gmail.com, hughd@google.com, david@redhat.com,
        fengwei.yin@intel.com, vbabka@suse.cz, peterz@infradead.org,
        mgorman@suse.de, mingo@redhat.com, riel@redhat.com,
        ying.huang@intel.com, hannes@cmpxchg.org,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 5:48=E2=80=AFAM zhangpeng (AS) <zhangpeng362@huawei.=
com> wrote:
>
> Hi everyone,
>
> There is a performance issue that has been bothering us recently.
> This problem can reproduce in the latest mainline version (Linux 6.6).
>
> We use mlockall(MCL_CURRENT | MCL_FUTURE) in the user mode process
> to avoid performance problems caused by major fault.
>
> There is a stage in numa fault which will set pte as 0 in do_numa_page() =
:
> ptep_modify_prot_start() will clear the vmf->pte, until
> ptep_modify_prot_commit() assign a value to the vmf->pte.
>
> For the data segment of the user-mode program, the global variable area
> is a private mapping. After the pagecache is loaded, the private
> anonymous page is generated after the COW is triggered. Mlockall can
> lock COW pages (anonymous pages), but the original file pages cannot
> be locked and may be reclaimed. If the global variable (private anon page=
)
> is accessed when vmf->pte is zero which is concurrently set by numa fault=
,
> a file page fault will be triggered.
>
> At this time, the original private file page may have been reclaimed.
> If the page cache is not available at this time, a major fault will be
> triggered and the file will be read, causing additional overhead.
>
> Our problem scenario is as follows:
>
> task 1                      task 2
> ------                      ------
> /* scan global variables */
> do_numa_page()
>    spin_lock(vmf->ptl)
>    ptep_modify_prot_start()
>    /* set vmf->pte as null */
>                              /* Access global variables */
>                              handle_pte_fault()
>                                /* no pte lock */
>                                do_pte_missing()
>                                  do_fault()
>                                    do_read_fault()
>    ptep_modify_prot_commit()
>    /* ptep update done */
>    pte_unmap_unlock(vmf->pte, vmf->ptl)
>                                      do_fault_around()
>                                      __do_fault()
>                                        filemap_fault()
>                                          /* page cache is not available
>                                          and a major fault is triggered *=
/
>                                          do_sync_mmap_readahead()
>                                          /* page_not_uptodate and goto
>                                          out_retry. */
>
> Is there any way to avoid such a major fault?

IMHO I don't think it is a bug. The man page quoted by Willy says "All
mapped pages are guaranteed to be resident in RAM when the call
returns successfully", but the later COW already made the file page
unmapped, right? The PTE pointed to the COW'ed anon page.
Hypothetically if we kept the file page mlocked and unmapped,
munlock() would have not munlocked the file page at all, it would be
mlocked in memory forever.

>
> --
> Best Regards,
> Peng
>
