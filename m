Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641BA77EBE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbjHPVbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346576AbjHPVbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:31:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40461BE8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:31:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so1473a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692221503; x=1692826303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jpiFyBqyB7GEQ4UWrE0SW3sqFRGgppX7U6JuEt4HtU=;
        b=TxeYRwWDVYHfd9uxbK3fhjziQdOpSjFLnx5FCZR3j+hN0ph/TWOrQT7d+PHOR8QWym
         gEXrZIVyvoufGajBIXvj13/i7rJoRiIyyRbgvU1fzJk3DRt0x+QzaMzcgkCOWNf40m9T
         37B8+e9L7cB1/anxay/UpKznyy4/m2EGeSaTcksjSr78wqQ+Cg3h4d+db2llRHDUVzzv
         lXxdbhR5IENQ0nCIYihWR15VPzKAP+FsDzR2TGeKbPZQZB/yihavoyM9+TkBaQaXDePr
         +0yQcXqV46hqrHHs543eaDwZuF1WBNa6jyjbky9Re4cWQ5b+vq3HtJ7h01IBrnKd+T+S
         /TZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692221503; x=1692826303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jpiFyBqyB7GEQ4UWrE0SW3sqFRGgppX7U6JuEt4HtU=;
        b=ap+73R+F0bRXtixnuoNQ5syQrkahKJ4WRR9+6OTq/S8SHndM+DsaaAW8pEvHTpX6Xb
         tGvQxKjMFSRvGXcXiFXXE3mGwHLNn+MS38NHWYeTpMRr7RO6fOret/FncIRooA/sSxml
         RdYpe4oo8ZvX7RipgykzUdQtjmChh4gVLOs6nzcumG90asD5WGjsVMTkIHLXHGOWNh0Q
         rcx3PJFo+IlOxtRtD6uIHxJXnRIQ9xQ+dvlsXkfYNAYb6QsFAJzLXIWN8C/JAwFqKp2a
         a00UpjBVdK2ntyr0RVswmivh6Apq0Up/kavbh3btTUgl5BS79H2M5fnjh+L+3bpbY/dc
         T+6g==
X-Gm-Message-State: AOJu0YwhIo8TOTKuy47R+KDLprsdnww4GG8MTXC2FGPTiSP6lk4+kgWB
        Kh6YWU8GZk2ngrC4OskGBJCLY0UX+ildsyvIehjrEw==
X-Google-Smtp-Source: AGHT+IHI2ZvcVIAINadCqQ5irpfw4urDyIeFJW7lkcFNTkgk8/0tcrZmU7TZsQ2BfRehvcruporPMLnB/cRrubjUCzI=
X-Received: by 2002:a50:9fae:0:b0:522:28a1:2095 with SMTP id
 c43-20020a509fae000000b0052228a12095mr9721edf.3.1692221502915; Wed, 16 Aug
 2023 14:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org> <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org>
In-Reply-To: <ZNrh6w9ICu4rMrhV@casper.infradead.org>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 16 Aug 2023 14:31:06 -0700
Message-ID: <CAAa6QmTA8aADSYbpxXU8kne0KqyeY7fCw5_QYSj0T7bCtPKmfA@mail.gmail.com>
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

On Mon, Aug 14, 2023 at 7:24=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Aug 14, 2023 at 05:04:47PM -0700, Zach O'Keefe wrote:
> > > From a large folios perspective, filesystems do not implement a speci=
al
> > > handler.  They call filemap_fault() (directly or indirectly) from the=
ir
> > > ->fault handler.  If there is already a folio in the page cache which
> > > satisfies this fault, we insert it into the page tables (no matter wh=
at
> > > size it is).  If there is no folio, we call readahead to populate tha=
t
> > > index in the page cache, and probably some other indices around it.
> > > That's do_sync_mmap_readahead().
> > >
> > > If you look at that, you'll see that we check the VM_HUGEPAGE flag, a=
nd
> > > if set we align to a PMD boundary and read two PMD-size pages (so tha=
t we
> > > can do async readahead for the second page, if we're doing a linear s=
can).
> > > If the VM_HUGEPAGE flag isn't set, we'll use the readahead algorithm =
to
> > > decide how large the folio should be that we're reading into; if it's=
 a
> > > random read workload, we'll stick to order-0 pages, but if we're gett=
ing
> > > good hit rate from the linear scan, we'll increase the size (although
> > > we won't go past PMD size)
> > >
> > > There's also the ->map_pages() optimisation which handles page faults
> > > locklessly, and will fail back to ->fault() if there's even a light
> > > breeze.  I don't think that's of any particular use in answering your
> > > question, so I'm not going into details about it.
> > >
> > > I'm not sure I understand the code that's being modified well enough =
to
> > > be able to give you a straight answer to your question, but hopefully
> > > this is helpful to you.
> >
> > Thank you, this was great info. I had thought, incorrectly, that large
> > folio work would eventually tie into that ->huge_fault() handler
> > (should be dax_huge_fault() ?)
> >
> > If that's the case, then faulting file-backed, non-DAX memory as
> > (pmd-mapped-)THPs isn't supported at all, and no fault lies with the
> > aforementioned patches.
>
> Ah, wait, hang on.  You absolutely can get a PMD mapping by calling into
> ->fault.  Look at how finish_fault() works:
>
>         if (pmd_none(*vmf->pmd)) {
>                 if (PageTransCompound(page)) {
>                         ret =3D do_set_pmd(vmf, page);
>                         if (ret !=3D VM_FAULT_FALLBACK)
>                                 return ret;
>                 }
>
>                 if (vmf->prealloc_pte)
>                         pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_=
pte);
>
> So if we find a large folio that is PMD mappable, and there's nothing
> at vmf->pmd, we install a PMD-sized mapping at that spot.  If that
> fails, we install the preallocated PTE table at vmf->pmd and continue to
> trying set one or more PTEs to satisfy this page fault.

Aha! I see. I did not expect ->fault() to have this logic, as I had
incorrectly thought (aka assumed) the pmd vs pte-mapping logic split
at create_huge_pmd(); i.e. do_huge_pmd_anonymous_page(), or
->huge_fault(), or fallback to pte-mapping. It seems very weird to me
that hugepage_vma_check() "artificially" says "no" to file and shmem
along the fault path, so they can go and do their own thing in
->fault().

But this has been the way non-anon has supported THP fault since the
start ... with Kiril's commit 4.8 commit 101024596441 ("mm: introduce
do_set_pmd()") as part of the original "THP-enabled tmpfs/shmem using
compound pages" series. I just did not know about it :/

But thanks for prompting this -- I learnt a lot reading further down
do_fault(). shmem's ability to fault THP will depend on how the file
was constructed to begin with (i.e the huge=3D mount option). For file,
our ability to pmd-map the folio will depend on if the folio was
assembled in the pagecache as a large folio or not -- which depends on
the fs' AS_LARGE_FOLIO_SUPPORT (for which, only xfs, erofs, and afs
support today).

I tested things on xfs, and it does actually work. Cool :)

IIUC then, there is a bug in smaps THPeligible code when
CONFIG_READ_ONLY_THP_FOR_FS is not set. Not obvious, but apparently
this config is (according to it's Kconfig desc) khugepaged-only, so it
should be fine for it to be disabled, yet allow
do_sync_mmap_readahead() to install a pmd for file-backed memory.
hugepage_vma_check() will need to be patched to fix this.

But I have a larger question for you: should we care about
/sys/kernel/mm/transparent_hugepage/enabled for file-fault? We
currently don't. Seems weird that we can transparently get a hugepage
when THP=3D"never". Also, if THP=3D"always", we might as well skip the
VM_HUGEPAGE check, and try the final pmd install (and save khugepaged
the trouble of attempting it later).

WDYT?

Aside: should have brought this to Cabal meeting today, but hadn't
finished going through things

>
> So why, you may be asking, do we have ->huge_fault.  Well, you should
> ask the clown who did commit b96375f74a6d ... in fairness to me,
> finish_fault() did not exist at the time, and the ability to return
> a PMD-sized page was added later.
>

:P

But that patch seems super reasonable? At least my naive initial
reading assumed exactly what that commit description says.
