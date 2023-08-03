Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20C376F1EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHCSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjHCSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:34:52 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0898912B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:34:51 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d0e009433c4so1478999276.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691087690; x=1691692490;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nyc2gitI2vs2BzBPE2gM4dSf776t2Bqkap6SAX9jGgw=;
        b=j4ZZTUw3L8tzyfQ60uIIZQLmCPW7V3COQ5bMr151BNflpDbwZu3VUq++3RPLvFn0Vp
         cVdh6ZtsWZ5DvHoKm6S6btw6qLGyR5o/SsrLEColtzeo3VgcsyKK8EKqoA4MnRul4ruR
         MRrzpORy5/0mmVYDFe3O4DIfyYHSNc24+AKM1AH5J/jtnYcmHeu5KYeOTtLpJCddfAqr
         VvBVU7NFqgStEd38t6lIOJsIVydQzvdqsEA0wgQ96LZNS8pK/DKqipMT2ocQthJR/dqr
         42hq+jAhgmkW/hMi7BukbXPppKS55KTMteXYUlRCdccI8m6cTu7cSMTsWe0hYL9nn+yv
         D5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691087690; x=1691692490;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nyc2gitI2vs2BzBPE2gM4dSf776t2Bqkap6SAX9jGgw=;
        b=dvzwgxAMzifNgXyn2e2p8ZN79ZRIHAnue/a5QLS6yMY627EYO4i3ykLlI0tEnJdXhQ
         1+IHZsFwIJCuC8uUcSgmRR6Ftr43acgZYeN+IIcGH4cMAcet9j3vot0CYV//Tzwh8E+U
         abuA9tu/nYG271gdtYMG8XfiyrHCLZw0sZzGQLv1fCPucKR7kHS95c/ulXUQkbiTXquT
         IyObnS/b16SqUm/hqewMULN8oxGc37j0HYcw7J/mNwHEUjlyH8PKP7Zcav4o4nLBwcLU
         jZgNkK/DPkQ2ytmzXgOEm+1uGPFlFJH4fFVe15GGPbdNBfoNmmbMv4AJsFFbN3/wRD9W
         IkHA==
X-Gm-Message-State: ABy/qLZqmgVJN8HeEgvbti9RFHgnY9e6XDIQnZ6rz4bq/BT4/mJMlB7x
        uvWAfMGySbPn5wNetMnZm5iRkOfzCgWZiml1zB+bsA==
X-Google-Smtp-Source: APBJJlEG7Mv/Fp2FsNqC1nmgVx/mt5hF/Jf12KZxbp1VyjIkLYpf4NX3BUvGR61e0lC3QkL9nAthftAM244WYxSlgc4=
X-Received: by 2002:a25:24d:0:b0:c60:982f:680c with SMTP id
 74-20020a25024d000000b00c60982f680cmr18200156ybc.63.1691087689991; Thu, 03
 Aug 2023 11:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com> <20230803172652.2849981-6-surenb@google.com>
 <CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com>
 <20230803181520.yd5ao45rm3rxnsbs@revolver> <CAJuCfpHkTNrJhmQABEvEXBJd-Y0yNz+VUPn+ZX5OKHwQiwCr5A@mail.gmail.com>
In-Reply-To: <CAJuCfpHkTNrJhmQABEvEXBJd-Y0yNz+VUPn+ZX5OKHwQiwCr5A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 3 Aug 2023 11:34:38 -0700
Message-ID: <CAJuCfpHbWfKTsh1Q_3=Kr1R1d8pgrnXitzGuDxDRtnG5e02y5A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm: always lock new vma before inserting into vma tree
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        david@redhat.com, peterx@redhat.com, ldufour@linux.ibm.com,
        vbabka@suse.cz, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, hannes@cmpxchg.org, dave@stgolabs.net,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:26=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Aug 3, 2023 at 11:15=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Linus Torvalds <torvalds@linux-foundation.org> [230803 14:02]:
> > > On Thu, 3 Aug 2023 at 10:27, Suren Baghdasaryan <surenb@google.com> w=
rote:
> > > >
> > > > While it's not strictly necessary to lock a newly created vma befor=
e
> > > > adding it into the vma tree (as long as no further changes are perf=
ormed
> > > > to it), it seems like a good policy to lock it and prevent accident=
al
> > > > changes after it becomes visible to the page faults. Lock the vma b=
efore
> > > > adding it into the vma tree.
> > >
> > > So my main reaction here is that I started to wonder about the vma al=
location.
> > >
> > > Why doesn't vma_init() do something like
> > >
> > >         mmap_assert_write_locked(mm);
> > >         vma->vm_lock_seq =3D mm->mm_lock_seq;
> > >
> > > and instead we seem to expect vma_lock_alloc() to do this (and do it
> > > very badly indeed).
> > >
> > > Strange.
> > >
> > > Anyway, this observation was just a reaction to that "not strictly
> > > necessary to lock a newly created vma" part of the commentary. I feel
> > > like we could/should just make sure that all newly created vma's are
> > > always simply created write-locked.
> > >
> >
> > I thought the same thing initially, but Suren pointed out that it's not
> > necessary to hold the vma lock to allocate a vma object.  And it seems
> > there is at least one user (arch/ia64/mm/init.c) which does allocate
> > outside the lock during ia64_init_addr_space(), which is fine but I'm
> > not sure it gains much to do it this way - the insert needs to take the
> > lock anyways and it is hardly going to be contended.
>
> Yeah, I remember discussing that. At the time of VMA creation the
> mmap_lock might not be write-locked, so mmap_assert_write_locked()
> would trigger and mm->mm_lock_seq is not stable. Maybe we can
> necessitate holding mmap_lock at the time of VMA creation but that
> sounds like an unnecessary restriction. IIRC some drivers also create
> vm_are_structs without holding mmap_lock... I'll double-check.

Yeah, there are places like an initcall gate_vma_init() which call
vma_init(). I don't think these are called with a locked mmap_lock.

>
> >
> > Anywhere else besides an address space setup would probably introduce a
> > race.
> >
> > Thanks,
> > Liam
> >
