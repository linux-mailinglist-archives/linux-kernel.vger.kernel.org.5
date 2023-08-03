Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6031076F1D5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjHCS1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjHCS06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:26:58 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EED110
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:26:57 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d2b8437d825so1342684276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 11:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691087217; x=1691692017;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJY6KKzyPwphhQ98P/1zZEUfDdFiMUyJJPp/8Vkg4G4=;
        b=1dpeZTUnhOGV3DZJjOZDR3Hqj6ownpypLiqKU+MHOfvcc8XTZG71vJuCdY2CMpyfTI
         xnU0i8rCzOd9HFVgbgk0+zMKh5Z+mhSCZBMpmU6WOtFnahrIP9Wz2rUfI7jVfPomPrZi
         VO+J+aVB51uZa0vL3OJfxB908uxB5bdKteoHHi4qKj/MEwexITEwQPdjIy5czq9rJeyi
         htXb/vtJSJQ16PsQp5y2B+lxwmxdn3K1NMp5yYBy4VqRVCtyyUVEnCMBOQ0ZKRdU8KaD
         SqdKhVe3Q+O/5vF/Uf/UbwNOefjkDeEKVYXv5nSscqOW0DroIEXoHyGmWeor0VpkuDWD
         goEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691087217; x=1691692017;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJY6KKzyPwphhQ98P/1zZEUfDdFiMUyJJPp/8Vkg4G4=;
        b=bka5gZ/GyE5XNeEUWstQwnmFm3bElIsqXBQbLvmUPzcq2CHN0kbBdsLrONLUkF3GKj
         sgV8nb1OSjOYQai2gGeFVlHzXWM88NxwsgtP1Y6yuLcXCrQ05Elp9vCK9bAYgqewZvSG
         GMvk6a4usp2kkaYD8BX0bkSXdQM9e4cfAUdEPC8IlIBI3AuQWKIWfDF2CuGTjINwGGe4
         qIhBwbKKMkzqh9erfZwslSlWzbwHRE0+XkTEBLQQTKmZ8z1QKopvUIbpkfDpDBXjUDc6
         cDGFLXn1M04uIUxFoNQBZQEQH2cV1/DaxnSHXTH8/3fz6r6/k0IDsnlXqcKjUXA9RowA
         U8EA==
X-Gm-Message-State: ABy/qLZCmTCtKUPtbMamIVCX6n5E8e3AiBhl1DaXobHAsLBWFgEVggir
        u82yP5XixEaWdITqfP0xPbiU6zW8LylYyX2I4vqSrg==
X-Google-Smtp-Source: APBJJlEJ/xQ6/X6lCi6Xal+GKcDNnYyzTSSA5nVnsb2xznOb20eo88GXdM78peIHKOQPxZrl7saNIhLRp6CaJzdXdww=
X-Received: by 2002:a25:d1d8:0:b0:ce8:e6f:4408 with SMTP id
 i207-20020a25d1d8000000b00ce80e6f4408mr18331813ybg.7.1691087216765; Thu, 03
 Aug 2023 11:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com> <20230803172652.2849981-6-surenb@google.com>
 <CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com> <20230803181520.yd5ao45rm3rxnsbs@revolver>
In-Reply-To: <20230803181520.yd5ao45rm3rxnsbs@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 3 Aug 2023 11:26:43 -0700
Message-ID: <CAJuCfpHkTNrJhmQABEvEXBJd-Y0yNz+VUPn+ZX5OKHwQiwCr5A@mail.gmail.com>
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

On Thu, Aug 3, 2023 at 11:15=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Linus Torvalds <torvalds@linux-foundation.org> [230803 14:02]:
> > On Thu, 3 Aug 2023 at 10:27, Suren Baghdasaryan <surenb@google.com> wro=
te:
> > >
> > > While it's not strictly necessary to lock a newly created vma before
> > > adding it into the vma tree (as long as no further changes are perfor=
med
> > > to it), it seems like a good policy to lock it and prevent accidental
> > > changes after it becomes visible to the page faults. Lock the vma bef=
ore
> > > adding it into the vma tree.
> >
> > So my main reaction here is that I started to wonder about the vma allo=
cation.
> >
> > Why doesn't vma_init() do something like
> >
> >         mmap_assert_write_locked(mm);
> >         vma->vm_lock_seq =3D mm->mm_lock_seq;
> >
> > and instead we seem to expect vma_lock_alloc() to do this (and do it
> > very badly indeed).
> >
> > Strange.
> >
> > Anyway, this observation was just a reaction to that "not strictly
> > necessary to lock a newly created vma" part of the commentary. I feel
> > like we could/should just make sure that all newly created vma's are
> > always simply created write-locked.
> >
>
> I thought the same thing initially, but Suren pointed out that it's not
> necessary to hold the vma lock to allocate a vma object.  And it seems
> there is at least one user (arch/ia64/mm/init.c) which does allocate
> outside the lock during ia64_init_addr_space(), which is fine but I'm
> not sure it gains much to do it this way - the insert needs to take the
> lock anyways and it is hardly going to be contended.

Yeah, I remember discussing that. At the time of VMA creation the
mmap_lock might not be write-locked, so mmap_assert_write_locked()
would trigger and mm->mm_lock_seq is not stable. Maybe we can
necessitate holding mmap_lock at the time of VMA creation but that
sounds like an unnecessary restriction. IIRC some drivers also create
vm_are_structs without holding mmap_lock... I'll double-check.

>
> Anywhere else besides an address space setup would probably introduce a
> race.
>
> Thanks,
> Liam
>
