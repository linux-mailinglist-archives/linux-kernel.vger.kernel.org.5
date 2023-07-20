Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282C075B6D5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjGTSbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGTSbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:31:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD675E47
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:31:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so16667021fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689877897; x=1690482697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrkFFvhCDJb8jzV4vfT/0jPY3RsaSNNqzn4aYV8R2Cs=;
        b=m5mX4VS30OmUMkZ/G4ry1B4ELa9sEbB7lDPhBwdjeD7O2pRls71f6H0h//qa1Cck+B
         7rt4dNLeKGXLeFI94ATkHwYPSgllaoUaJh4Xg+dGtHKXyOYE2wBrse7NDqIYpR8MOwqX
         HiDlViZfqEBtqAURT6ykbrUMhj0IzH11ROq7SEKVrs8yUEojlDXiGiPkYOq+EvYihD8Q
         6FAu97w8KIqxwEub7Ne+dIWdGM7cahPln4DkJvA9zOjGgWD5TcQnaFpuhsLsGzr0BehK
         7xQLfNw6AM6wiDM+DzOM3M09l+pAvK4m2ZN3YdM+F+pEkokXOEGyZ2I+wxjmZAfp1tbU
         2NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689877897; x=1690482697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrkFFvhCDJb8jzV4vfT/0jPY3RsaSNNqzn4aYV8R2Cs=;
        b=Wfwvxhv9KHzXQ/Lxp8PmVcXbjjuvQCNCvA+cWis9b6pU4NV0yzukgYYzVH20Oh7aeP
         Mv3ePNu6LH3hPJth6zM4Uiwcwjzoo/uPYgY0+oZclEQmzfJl6XqDMx9/Wh0WZw34bYif
         IN8A6dzdoZWgyQCUB2ELuuUHjpiR7lEcgLmzu3MCRbqdiUDNQTmWhhKrNCAGNJBv458+
         p1D8K2mMvQeaTrJgQCqDGU37Z56v1eUWX1Dyk9TazbaMybtuD4cw1tHZnsKpe2shXqh7
         bhGlARfU5XJEknlKavoXgs2t+Ecmqhw1qRnkd/OFC4CLFbvLVoIg4oH+50ZNTSTqH95T
         mFkg==
X-Gm-Message-State: ABy/qLbGRdvUpzsQLm72BrTu6AKwrMHTfAD3eD1sElUVMO8YmwsfPkci
        wraDmAIZfAJ5jlvjMpSn2K++gwNz6qfObfyK3dxivtYN18pFl+HqCJF39w==
X-Google-Smtp-Source: APBJJlE1BjjSg2woF/XJDLyNu/ayF8F8B6HCNXDFXwHIE5YnroYP7jQXWe5Vgzm3KTmEcJ6zOtUbG2PIILbLvjZqEXU=
X-Received: by 2002:a2e:a28c:0:b0:2b4:45bc:7bd with SMTP id
 k12-20020a2ea28c000000b002b445bc07bdmr3118296lja.4.1689877896635; Thu, 20 Jul
 2023 11:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230713042037.980211-1-42.hyeyoo@gmail.com> <20230720071826.GE955071@google.com>
 <CAJD7tka2b-VsLJRrwfdbFAwvfKV+sHvNyRBJsG+81EmQ-=MkyA@mail.gmail.com> <CAB=+i9QUNVbc+pEZD5vG_DUTcLrco5JNOrkkRDdcAfj08u7vVA@mail.gmail.com>
In-Reply-To: <CAB=+i9QUNVbc+pEZD5vG_DUTcLrco5JNOrkkRDdcAfj08u7vVA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 11:31:00 -0700
Message-ID: <CAJD7tkbO0W4woJtidbQU0F2iOCQcDG024c6EZ1ZOb2sLOG1ovg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] mm/zsmalloc: Split zsdesc from struct page
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
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

On Thu, Jul 20, 2023 at 4:34=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> On Thu, Jul 20, 2023 at 4:55=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, Jul 20, 2023 at 12:18=E2=80=AFAM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (23/07/13 13:20), Hyeonggon Yoo wrote:
> > > > The purpose of this series is to define own memory descriptor for z=
smalloc,
> > > > instead of re-using various fields of struct page. This is a part o=
f the
> > > > effort to reduce the size of struct page to unsigned long and enabl=
e
> > > > dynamic allocation of memory descriptors.
> > > >
> > > > While [1] outlines this ultimate objective, the current use of stru=
ct page
> > > > is highly dependent on its definition, making it challenging to sep=
arately
> > > > allocate memory descriptors.
> > >
> > > I glanced through the series and it all looks pretty straight forward=
 to
> > > me. I'll have a closer look. And we definitely need Minchan to ACK it=
.
> > >
> > > > Therefore, this series introduces new descriptor for zsmalloc, call=
ed
> > > > zsdesc. It overlays struct page for now, but will eventually be all=
ocated
> > > > independently in the future.
> > >
> > > So I don't expect zsmalloc memory usage increase. On one hand for eac=
h
> > > physical page that zspage consists of we will allocate zsdesc (extra =
bytes),
> > > but at the same time struct page gets slimmer. So we should be even, =
or
> > > am I wrong?
> >
> > Well, it depends. Here is my understanding (which may be completely wro=
ng):
> >
> > The end goal would be to have an 8-byte memdesc for each order-0 page,
> > and then allocate a specialized struct per-folio according to the use
> > case. In this case, we would have a memdesc and a zsdesc for each
> > order-0 page. If sizeof(zsdesc) is 64 bytes (on 64-bit), then it's a
> > net loss. The savings only start kicking in with higher order folios.
> > As of now, zsmalloc only uses order-0 pages as far as I can tell, so
> > the usage would increase if I understand correctly.
>
> I partially agree with you that the point of memdesc stuff is
> allocating a use-case specific
> descriptor per folio. but I thought the primary gain from memdesc was
> from anon and file pages
> (where high order pages are more usable), rather than zsmalloc.
>
> And I believe enabling a memory descriptor per folio would be
> impossible (or inefficient)
> if zsmalloc and other subsystems are using struct page in the current
> way (or please tell me I'm wrong?)
>
> So I expect the primary gain would be from high-order anon/file folios,
> while this series is a prerequisite for them to work sanely.

Right, I agree with that, sorry if I wasn't clear. I meant that
generally speaking, we see gains from memdesc from higher order
folios, so for zsmalloc specifically we probably won't see seeing any
savings, and *might* see some extra usage (which I might be wrong
about, see below).

>
> > It seems to me though the sizeof(zsdesc) is actually 56 bytes (on
> > 64-bit), so sizeof(zsdesc) + sizeof(memdesc) would be equal to the
> > current size of struct page. If that's true, then there is no loss,
>
> Yeah, zsdesc would be 56 bytes on 64 bit CPUs as memcg_data field is
> not used in zsmalloc.
> More fields in the current struct page might not be needed in the
> future, although it's hard to say at the moment.
> but it's not a loss.

Is page->memcg_data something that we can drop? Aren't there code
paths that will check page->memcg_data even for kernel pages (e.g.
__folio_put() -> __folio_put_small() -> mem_cgroup_uncharge() ) ?

>
> > and there's potential gain if we start using higher order folios in
> > zsmalloc in the future.
>
> AFAICS zsmalloc should work even when the system memory is fragmented,
> so we may implement fallback allocation (as currently discussed in
> large anon folios thread).

Of course, any usage of higher order folios in zsmalloc must have a
fallback logic, although it might be simpler for zsmalloc than anon
folios. I agree that's off topic here.

>
> It might work, but IMHO the purpose of this series is to enable memdesc
> for large anon/file folios, rather than seeing a large gain in zsmalloc i=
tself.
> (But even in zsmalloc, it's not a loss)
>
> > (That is of course unless we want to maintain cache line alignment for
> > the zsdescs, then we might end up using 64 bytes anyway).
>
> we already don't require cache line alignment for struct page. the curren=
t
> alignment requirement is due to SLUB's cmpxchg128 operation, not cache
> line alignment.

I thought we want  struct page to be cache line aligned (to avoid
having to fetch two cache lines for one struct page), but I can easily
be wrong.

>
> I might be wrong in some aspects, so please tell me if I am.
> And thank you and Sergey for taking a look at this!

Thanks to you for doing the work!

> --
> Hyeonggon
