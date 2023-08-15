Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4BF77CDF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbjHOOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237613AbjHOOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:20:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8371BCF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:20:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so77355e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692109215; x=1692714015;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yfq66RGthh/jDqLnx2XGtN7DUux5G0QrMF1Og9o03N4=;
        b=BVXUKbGSM5V7XRh64ju6Qv9qJH+89VMWUSArDhe4Bpmz+kwCgWOoAOtk5qvjRUF9K4
         LE+kaCv9g/Zt3nm2XEb8qZF87hcQV7Y2wWg48nz2cgMPPU9Nuo16QQTMr19QnBIcuLjc
         XWx1xHtaWaBxZFKSd3JN7F9SmjnGxkiEIGKfefemy5RLBRq9f6+SfDGpCWSudcyiOhLk
         ojDMyu/5bjL3HGNTDL0K0JoLPBIbA0v+lfVKsD22174SivhjsZaGDzOyWdPn/H/Jr2sj
         4nli5743tvc0w52S0izo1ZpHd61Wn9uq5AB0UI21YvYfYCChc/le0LVK1ILfrbsKDjBv
         TTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109215; x=1692714015;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yfq66RGthh/jDqLnx2XGtN7DUux5G0QrMF1Og9o03N4=;
        b=KoDjMoU5xN15Od9CCbJNIsT4+hkyv5azKAHbZ9NxTmw1cr+yJE508Oh9J858oDf/KP
         NmwRCF027BKP+tY43d9+KctCnVLucM8UkNjZGG8kzNoq4odFi2UPLKUskefCO0seaApw
         1mfl/0GQsBzh/KWWdDqMpZvhComi5ycKGrVM5xaPo4g1jN4Ncwg/RiN6W9K3sOGSFjHc
         sq726YFycfqAfK/Xcec9pxNGmC56m6UPAGJ5rxJywiKw4tPx2YWiXEquhP/V6rgIPp7i
         gzFNeoyJJEBWiB0w6GXrzmIfS/cGe2ug4P3O/c9LB656fMziuy3nbeo7fWalHoQsVgKv
         5+SQ==
X-Gm-Message-State: AOJu0YxpQlHb8C1/vfNcZdBNrGznZ3eZFoBiqxNKym3CLrD3MC6RqiA1
        kO3lZLtn2FZgy/ufeMeex/aQyGLC55yWFedDbIuNyg==
X-Google-Smtp-Source: AGHT+IHaqR5H5RDLoB3/4IaWducuvBcmXayHOupbcGnkyyMS+481wUOHO1Qsp00nIl/NatF0z0rPhJZD9YUumpwsljA=
X-Received: by 2002:a05:600c:1d8e:b0:3fe:5ec3:447f with SMTP id
 p14-20020a05600c1d8e00b003fe5ec3447fmr391880wms.1.1692109215503; Tue, 15 Aug
 2023 07:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
 <20230724183157.3939892-16-Liam.Howlett@oracle.com> <CAG48ez09ELhVYZftGtcxrvUaW6pF+k9RzwFtjRs-pcRx1aUweQ@mail.gmail.com>
 <20230814191835.jzj7ryvhi6dqwruy@revolver> <CAG48ez2UbpFb41gfcwyoA73ado=+YEiRtU2KmKt560_M_B7JUw@mail.gmail.com>
 <20230815072907.fsvetn4dzohgt2z5@revolver>
In-Reply-To: <20230815072907.fsvetn4dzohgt2z5@revolver>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 15 Aug 2023 16:19:38 +0200
Message-ID: <CAG48ez2OTwhdbN2NsYEoU4mayfdCBT+4NirdxMQ=5fZvKFjq6w@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] mm/mmap: Change vma iteration order in do_vmi_align_munmap()
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, Aug 15, 2023 at 9:29=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jann Horn <jannh@google.com> [230814 17:22]:
> > On Mon, Aug 14, 2023 at 10:32=E2=80=AFPM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > > * Jann Horn <jannh@google.com> [230814 11:44]:
> > > > @akpm
> > > >
> > > > On Mon, Jul 24, 2023 at 8:31=E2=80=AFPM Liam R. Howlett <Liam.Howle=
tt@oracle.com> wrote:
> > > > > Since prev will be set later in the function, it is better to rev=
erse
> > > > > the splitting direction of the start VMA (modify the new_below ar=
gument
> > > > > to __split_vma).
> > > >
> > > > It might be a good idea to reorder "mm: always lock new vma before
> > > > inserting into vma tree" before this patch.
> > > >
> > > > If you apply this patch without "mm: always lock new vma before
> > > > inserting into vma tree", I think move_vma(), when called with a st=
art
> > > > address in the middle of a VMA, will behave like this:
> > > >
> > > >  - vma_start_write() [lock the VMA to be moved]
> > > >  - move_page_tables() [moves page table entries]
> > > >  - do_vmi_munmap()
> > > >    - do_vmi_align_munmap()
> > > >      - __split_vma()
> > > >        - creates a new VMA **covering the moved range** that is **n=
ot locked**
> > > >        - stores the new VMA in the VMA tree **without locking it** =
[1]
> > > >      - new VMA is locked and removed again [2]
> > > > [...]
> > > >
> > > > So after the page tables in the region have already been moved, I
> > > > believe there will be a brief window (between [1] and [2]) where pa=
ge
> > > > faults in the region can happen again, which could probably cause n=
ew
> > > > page tables and PTEs to be created in the region again in that wind=
ow.
> > > > (This can't happen in Linus' current tree because the new VMA creat=
ed
> > > > by __split_vma() only covers the range that is not being moved.)
> > >
> > > Ah, so my reversing of which VMA to keep to the first split call open=
s a
> > > window where the VMA being removed is not locked.  Good catch.
>
> Looking at this again, I think it exists in Linus' tree and my change
> actually removes this window:
>
> -               error =3D __split_vma(vmi, vma, start, 0);
> +               error =3D __split_vma(vmi, vma, start, 1);
>                 if (error)
>                         goto start_split_failed;
>
> The last argument is "new_below", which means the new VMA will be at the
> lower address.  I don't love the argument of int or the name, also the
> documentation is lacking for the split function.
>
> So, once we split at "start", vm_end =3D "start" in the new VMA while
> start will be in the old VMA.  I then lock the old vma to be removed
> (again) and add it to the detached maple tree.
>
> Before my patch, we split the VMA and took the new unlocked VMA for
> removal.. until I locked the new vma to be removed and add it to the
> detached maple tree.  So there is a window that we write the new split
> VMA into the tree prior to locking the VMA, but it is locked before
> removal.
>
> This change actually aligns the splitting with the other callers who use
> the split_vma() wrapper.

Oooh, you're right. Sorry, I misread that.

> > >
> > > >
> > > > Though I guess that's not going to lead to anything bad, since
> > > > do_vmi_munmap() anyway cleans up PTEs and page tables in the region=
?
> > > > So maybe it's not that important.
> > >
> > > do_vmi_munmap() will clean up PTEs from the end of the previous VMA t=
o
> > > the start of the next
> >
> > Alright, I guess no action is needed here then.
>
> I don't see a difference between this and the race that exists after the
> page fault ends and a task unmaps the area prior to the first task using
> the faulted areas?

Yeah, you're right. I was thinking about it in terms of "this is a
weird situation and it would be dangerous if something relied on there
not being any non-empty PTEs in the range", but there's nothing that
relies on it, so that's fine.
