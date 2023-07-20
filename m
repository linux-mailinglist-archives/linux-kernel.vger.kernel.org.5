Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D8375B99B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjGTVdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGTVdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:33:51 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6752712
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:33:49 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4436f2d8bcdso1644419137.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689888828; x=1690493628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKPKYbCnakgjeySnlcKiEAUl7NH69dLo9MLeSEw67MY=;
        b=rirawEyHLQaVJSUNIY3usdV8Ll7t5ZbgE+spjjc1WbBgrwJHk0umildcCxGgBmPo9n
         7E3Yx1HAs9FoGbpPhQqok8981LDQCqnaNxJl32mVyjmJtzvwjO9+Ju+P8VDAtCaMP/75
         CBYnjv1YO9N7vNG2vXOHvPYmEwSoEM4OTP9emXt0ndoBJhO8HgSyh5D+XgAy/9DPDNyH
         I6EXnUpUVlZMZPx208SdfA4Il8Pu49Nvcjx4frrThJZD9aeEh2VawZm0A6E5Kod3TZCh
         ONSmcG9VKzRPwLbo1Ewsq2aNU6gY7eNttS45yyvmIOZdPrMdWGAyV1clsQOyFMoSRE/l
         SqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689888828; x=1690493628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKPKYbCnakgjeySnlcKiEAUl7NH69dLo9MLeSEw67MY=;
        b=VdSPn0oWnHRqp3Est32cNU1/ITgCywa82/BFU1PJjNniokaY50PGS16bWF0g6zvlue
         +BrflghdlVp8RxRnyBfG7uGbtNsx7WRy+uT6z3O6LWD5cRsoPiIpieUiVZKKDTeHZDt+
         etUYg7xa3JugZFgGyIZ4CzwySHQB82zYEgTuWRD042rAe9X/YD4P+kjC4a0FHDJHb/17
         JOU+ahrR0LKYJnMABu9IpxJ0wHLpYME9Xeel9naUiEysyuvCWCluRSrgfC615TtcYucF
         AiyX4zW0LJjqHggkIs3AfDzuq05uzFaSWcb4qMxmtRoQbhC/0raplx01PlWvI/EZoy8/
         0Vuw==
X-Gm-Message-State: ABy/qLaGEP64lQYpXSYVCAzkJnM1zrjIL0pCt8PtdEqrSBHzefUP5L/C
        VgP0vQAYSgZbOmDr1zPO1LSfnYmPJxCPQRo14L4=
X-Google-Smtp-Source: APBJJlE+SEts6zoJANMYs9nIHUxvGIhUPlEEQ0RtPfrBibN4ET9uGZoVfjp3AKQIJnTM45nwXwoGbO1bT6GBiGfP6BU=
X-Received: by 2002:a67:fd88:0:b0:445:779:943b with SMTP id
 k8-20020a67fd88000000b004450779943bmr52437vsq.8.1689888828139; Thu, 20 Jul
 2023 14:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230713042037.980211-1-42.hyeyoo@gmail.com> <20230720071826.GE955071@google.com>
 <CAJD7tka2b-VsLJRrwfdbFAwvfKV+sHvNyRBJsG+81EmQ-=MkyA@mail.gmail.com>
 <CAB=+i9QUNVbc+pEZD5vG_DUTcLrco5JNOrkkRDdcAfj08u7vVA@mail.gmail.com> <CAJD7tkbO0W4woJtidbQU0F2iOCQcDG024c6EZ1ZOb2sLOG1ovg@mail.gmail.com>
In-Reply-To: <CAJD7tkbO0W4woJtidbQU0F2iOCQcDG024c6EZ1ZOb2sLOG1ovg@mail.gmail.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Fri, 21 Jul 2023 06:33:36 +0900
Message-ID: <CAB=+i9R+BnePZWJGm-5xi+2HEiM=_5EBZtFGmaHye+iZvVR2Vw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] mm/zsmalloc: Split zsdesc from struct page
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 3:31=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Jul 20, 2023 at 4:34=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.co=
m> wrote:
> >
> > On Thu, Jul 20, 2023 at 4:55=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Thu, Jul 20, 2023 at 12:18=E2=80=AFAM Sergey Senozhatsky
> > > <senozhatsky@chromium.org> wrote:
> > > >
> > > > On (23/07/13 13:20), Hyeonggon Yoo wrote:
> > > > > The purpose of this series is to define own memory descriptor for=
 zsmalloc,
> > > > > instead of re-using various fields of struct page. This is a part=
 of the
> > > > > effort to reduce the size of struct page to unsigned long and ena=
ble
> > > > > dynamic allocation of memory descriptors.
> > > > >
> > > > > While [1] outlines this ultimate objective, the current use of st=
ruct page
> > > > > is highly dependent on its definition, making it challenging to s=
eparately
> > > > > allocate memory descriptors.
> > > >
> > > > I glanced through the series and it all looks pretty straight forwa=
rd to
> > > > me. I'll have a closer look. And we definitely need Minchan to ACK =
it.
> > > >
> > > > > Therefore, this series introduces new descriptor for zsmalloc, ca=
lled
> > > > > zsdesc. It overlays struct page for now, but will eventually be a=
llocated
> > > > > independently in the future.
> > > >
> > > > So I don't expect zsmalloc memory usage increase. On one hand for e=
ach
> > > > physical page that zspage consists of we will allocate zsdesc (extr=
a bytes),
> > > > but at the same time struct page gets slimmer. So we should be even=
, or
> > > > am I wrong?
> > >
> > > Well, it depends. Here is my understanding (which may be completely w=
rong):
> > >
> > > The end goal would be to have an 8-byte memdesc for each order-0 page=
,
> > > and then allocate a specialized struct per-folio according to the use
> > > case. In this case, we would have a memdesc and a zsdesc for each
> > > order-0 page. If sizeof(zsdesc) is 64 bytes (on 64-bit), then it's a
> > > net loss. The savings only start kicking in with higher order folios.
> > > As of now, zsmalloc only uses order-0 pages as far as I can tell, so
> > > the usage would increase if I understand correctly.
> >
> > I partially agree with you that the point of memdesc stuff is
> > allocating a use-case specific
> > descriptor per folio. but I thought the primary gain from memdesc was
> > from anon and file pages
> > (where high order pages are more usable), rather than zsmalloc.
> >
> > And I believe enabling a memory descriptor per folio would be
> > impossible (or inefficient)
> > if zsmalloc and other subsystems are using struct page in the current
> > way (or please tell me I'm wrong?)
> >
> > So I expect the primary gain would be from high-order anon/file folios,
> > while this series is a prerequisite for them to work sanely.
>
> Right, I agree with that, sorry if I wasn't clear. I meant that
> generally speaking, we see gains from memdesc from higher order
> folios, so for zsmalloc specifically we probably won't see seeing any
> savings, and *might* see some extra usage (which I might be wrong
> about, see below).

Yeah, even if I said, "oh, we don't necessarily need to use extra
memory for zsdesc"
below, a slight increase wouldn't hurt too much in that perspective,
because there
will be savings from other users of memdesc.

> > > It seems to me though the sizeof(zsdesc) is actually 56 bytes (on
> > > 64-bit), so sizeof(zsdesc) + sizeof(memdesc) would be equal to the
> > > current size of struct page. If that's true, then there is no loss,
> >
> > Yeah, zsdesc would be 56 bytes on 64 bit CPUs as memcg_data field is
> > not used in zsmalloc.
> > More fields in the current struct page might not be needed in the
> > future, although it's hard to say at the moment.
> > but it's not a loss.
>
> Is page->memcg_data something that we can drop? Aren't there code
> paths that will check page->memcg_data even for kernel pages (e.g.
> __folio_put() -> __folio_put_small() -> mem_cgroup_uncharge() ) ?

zsmalloc pages are not accounted for via __GFP_ACCOUNT,
and IIUC the current implementation of zswap memcg charging does not
use memcg_data
either - so I think it can be dropped.

I think we don't want to increase memdesc to 16 bytes by adding memcg_data.
It should be in use-case specific descriptors if it can be charged to memcg=
?

> > > and there's potential gain if we start using higher order folios in
> > > zsmalloc in the future.
> >
> > AFAICS zsmalloc should work even when the system memory is fragmented,
> > so we may implement fallback allocation (as currently discussed in
> > large anon folios thread).
>
> Of course, any usage of higher order folios in zsmalloc must have a
> fallback logic, although it might be simpler for zsmalloc than anon
> folios. I agree that's off topic here.
> > It might work, but IMHO the purpose of this series is to enable memdesc
> > for large anon/file folios, rather than seeing a large gain in zsmalloc=
 itself.
> > (But even in zsmalloc, it's not a loss)
> >
> > > (That is of course unless we want to maintain cache line alignment fo=
r
> > > the zsdescs, then we might end up using 64 bytes anyway).
> >
> > we already don't require cache line alignment for struct page. the curr=
ent
> > alignment requirement is due to SLUB's cmpxchg128 operation, not cache
> > line alignment.
>
> I thought we want  struct page to be cache line aligned (to avoid
> having to fetch two cache lines for one struct page), but I can easily
> be wrong.

Right. I admit that even if it's not required to be cache line
aligned, it is 64 bytes
in commonly used configurations. and changing it could affect some workload=
s.

But I think for zsdesc it would be better not to align by cache line
size, before
observing degradations due to alignment. By the time zsmalloc is intensivel=
y
used, it shouldn't be a huge issue.

> > I might be wrong in some aspects, so please tell me if I am.
> > And thank you and Sergey for taking a look at this!
>
> Thanks to you for doing the work!

No problem! :)
