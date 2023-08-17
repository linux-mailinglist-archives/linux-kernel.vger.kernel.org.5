Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4177FD96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354231AbjHQSOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354238AbjHQSOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:14:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5394426A5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:14:15 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so1154a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296054; x=1692900854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwDKgeuDQ3yDX0vpP5yrJsNnDd62QRt5AHduSLOizpo=;
        b=zPVWY7ImzUQAjZ6ug9gn47FS315cN5J3OSX4KN5vIYd+3I8lPC+E1EDUGgP0IELOLI
         lSwlZ4/COpws7Y1O3au+KW/gnvcDdq9ZxcCEXP+SctjF5w3wq9BfH+FboPHOnW4SdMa+
         gg22zIghHGPAz30ZD+AjCKojfsPy4/+RRFQaVH8gwe5FOUjp2PysGWszfuPjzoe36CvZ
         D37f4YftXGjyu5edFV8XTNOOyEA2B21/DAnindpwQtNLmz1ryqTGzRnkBKSnxlSJoSz2
         LcLJ2jvDzWHJRvm3EzmGDklURxquU+q3lxVRzWsoZrIS+LoUSSVKzLJfkUtNhHpWT9wa
         Khuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296054; x=1692900854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwDKgeuDQ3yDX0vpP5yrJsNnDd62QRt5AHduSLOizpo=;
        b=l6DITJ/CtT0aDOtxQggFygWqxAoAWwsSkrBcsz7Ik8e/8Jv4sYjOH9RnHhZE6XOeGP
         NgV8MjxKsL9BJWjPovIAdfV7wwinDN7HGOzsduG+/U/NgtBIIvvy7hzRR0k5fnTVOCWq
         /M3+nvvp5m51GKIDa1rKw//lq4h9/10Mk1OZB4LZxByIblMiFursLe/LOj2HS/CIqwdy
         hPc3dZ/OR7gyMCL3T6vbbprzYAsehjdKPTtI7G50cR0Bsn6qwAj12GeX6wHCpG1I7ShN
         dqNLEmRIZLZRFQRtM8UgaiSv2gACYyEW/Y6t04KfqADIiXH6aX9cwkbtV++NZt897cDN
         hWEQ==
X-Gm-Message-State: AOJu0YxThqNc7+tXXU0A2IvBZjmH4q3/e24VmlC151WlfsMCFQApnBYp
        6G/9TXJ13wPe1tW0fubNjkivZ4n7/4GYwECSkVuBUuJusKD0dmNHpYA=
X-Google-Smtp-Source: AGHT+IG44HNJtNBPQmMhWG+y988LlX5RCYoDcwPF/0YQawQk64rzt5DyU6j03E5dRJb29Eb+A7Q1/oyb5Dr1wpLNlIQ=
X-Received: by 2002:a50:d4da:0:b0:523:193b:5587 with SMTP id
 e26-20020a50d4da000000b00523193b5587mr14812edj.6.1692296053641; Thu, 17 Aug
 2023 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org> <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org> <CAAa6QmTA8aADSYbpxXU8kne0KqyeY7fCw5_QYSj0T7bCtPKmfA@mail.gmail.com>
 <ZN4QFNZlx8mK9pQm@casper.infradead.org>
In-Reply-To: <ZN4QFNZlx8mK9pQm@casper.infradead.org>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 17 Aug 2023 11:13:36 -0700
Message-ID: <CAAa6QmTi99exY+NtNDZFi74cs7AB2xpaZ_kej3pSaZVdAtbrKA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 5:18=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Aug 16, 2023 at 02:31:06PM -0700, Zach O'Keefe wrote:
> > On Mon, Aug 14, 2023 at 7:24=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > So if we find a large folio that is PMD mappable, and there's nothing
> > > at vmf->pmd, we install a PMD-sized mapping at that spot.  If that
> > > fails, we install the preallocated PTE table at vmf->pmd and continue=
 to
> > > trying set one or more PTEs to satisfy this page fault.
> >
> > Aha! I see. I did not expect ->fault() to have this logic, as I had
> > incorrectly thought (aka assumed) the pmd vs pte-mapping logic split
> > at create_huge_pmd(); i.e. do_huge_pmd_anonymous_page(), or
> > ->huge_fault(), or fallback to pte-mapping. It seems very weird to me
> > that hugepage_vma_check() "artificially" says "no" to file and shmem
> > along the fault path, so they can go and do their own thing in
> > ->fault().
>
> Wow, hugepage_vma_check() is a very complicated function.  I'm glad I
> ignored it!

Ya it's a tangly area. Far better now though, then before Yang
centralized everything. But yes, now I need to figure out what to do
with it..

> > IIUC then, there is a bug in smaps THPeligible code when
> > CONFIG_READ_ONLY_THP_FOR_FS is not set. Not obvious, but apparently
> > this config is (according to it's Kconfig desc) khugepaged-only, so it
> > should be fine for it to be disabled, yet allow
> > do_sync_mmap_readahead() to install a pmd for file-backed memory.
> > hugepage_vma_check() will need to be patched to fix this.
>
> I guess so ...

The easiest and most satisfying way to handle this -- and I think we
talked about this before -- is relaxing that complicated
file_thp_enabled() check when the file's mapping supports large
folios. I think that makes sense to me, though I don't know all the
details fs-side. Will we need any hook to give fs the chance to update
any internal state on collapse?

> > But I have a larger question for you: should we care about
> > /sys/kernel/mm/transparent_hugepage/enabled for file-fault? We
> > currently don't. Seems weird that we can transparently get a hugepage
> > when THP=3D"never". Also, if THP=3D"always", we might as well skip the
> > VM_HUGEPAGE check, and try the final pmd install (and save khugepaged
> > the trouble of attempting it later).
>
> I deliberately ignored the humungous complexity of the THP options.
> They're overgrown and make my brain hurt. [..]

Same

> [..] Instead, large folios are
> adaptive; they observe the behaviour of the user program and choose based
> on history what to do.  This is far superior to having a sysadmin tell
> us what to do!

I had written a bunch on this, but I arrived to the conclusion that
(a) pmd-mapping here is ~ a free win, and (b) I'm not the best  person
to argue for these knobs, given MADV_COLLAPSE ignores them entirely :P

..But (sorry) what about MMF_DISABLE_THP?
