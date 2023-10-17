Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97977CCC2D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjJQTYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343990AbjJQTYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:24:31 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4CC4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:24:29 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a5a746e355so148810039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697570668; x=1698175468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x45oqYNDm1uCzNJ1wOxn/rjABjEKd1PH/2crQaHh9qE=;
        b=fATHKtaxTWO1mHA67kn+fhIImZnkbZQa7FZQV+O577Drv9qyAfAEVX2EwDnpxj0vmm
         Cgv7XTCWy5YxQAOsWmAqzR4xURBzaV6p5oGJQ82Ok5zcehyOzEnXi14s2At+MfjFh0IF
         Da0cRpAZnliRiH55HyLSI6JDuSgMdYPturBLHtq/LwUaDAWMnBTddJ7qd9Dg2ExJGE8W
         lijyHZ9c/fM7Y8IVesSyuj6S6sGIkwnK8DOqrt5q33IsrUObTFYNdX/lKsFnwvO99sQr
         726V7GbfR7wnRNO0tHCMJ/dMprYXq69Aubzht8nNal4FscZQMso9K9qu+6la7ovbfeyq
         tB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697570668; x=1698175468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x45oqYNDm1uCzNJ1wOxn/rjABjEKd1PH/2crQaHh9qE=;
        b=KnIaLmyif7/hTzHMs3I5X3bpjyhFff7FyaRZx9h9QSEPnqn2c0X965/P4MppKoJf/t
         0nc8Gt+UTXMT01uHkEQBywwN9JjifavzR1kiqnw1ZKl2F47kUlMnTJmaN8NXD4KYS0wK
         YPGNHWN1bplEV64FKH7Ar4is3w7TbtG0+B9YDz4T/Jk5e928ZmLAZwNSYBSmDHQTP+Yv
         kTPZyYObiS2a9LhDmIgiq9h9Bb5Q2FCF1kldkLmTnqH7kI4C+pNyrb8WAVpoVSUsLJH7
         kX8rwCpwwjyeaoJMZeXSMWwzxocR8a16nLDL00agrnnCJEGGa12kdAICsBqApafdBwwI
         iOQg==
X-Gm-Message-State: AOJu0YyeL31pCT2CEraSdtSyT+vWAoGn0RITfD5z9HAyZo9Zgj3b87fH
        afJA7S1sKbNHCjp3k+ipxTe4NMBiN3td3uhB6qA=
X-Google-Smtp-Source: AGHT+IHdNLCf+wERxrxP9ggtVWpue731CkTCZEIU+x0OhgpxDpe96F5xRSH+r0svT8Rd5my2Hu3tbGELWpI+5r8m2zw=
X-Received: by 2002:a05:6602:1651:b0:79d:27ef:23c3 with SMTP id
 y17-20020a056602165100b0079d27ef23c3mr2825049iow.5.1697570668445; Tue, 17 Oct
 2023 12:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231017003519.1426574-1-nphamcs@gmail.com> <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
 <20231017044745.GC1042487@cmpxchg.org>
In-Reply-To: <20231017044745.GC1042487@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 17 Oct 2023 12:24:17 -0700
Message-ID: <CAKEwX=Pv5cH30bFyOq=6U9Q_POGJ41qJ-6BxUZSxjjMG0yCBNw@mail.gmail.com>
Subject: Re: [PATCH 0/2] minimize swapping on zswap store failure
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, hughd@google.com,
        corbet@lwn.net, konrad.wilk@oracle.com, senozhatsky@chromium.org,
        rppt@kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 9:47=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Oct 16, 2023 at 05:57:31PM -0700, Yosry Ahmed wrote:
> > On Mon, Oct 16, 2023 at 5:35=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > Currently, when a zswap store attempt fails, the page is immediately
> > > swapped out. This could happen for a variety of reasons. For instance=
,
> > > the compression algorithm could fail (such as when the data is not
> > > compressible), or the backend allocator might not be able to find a
> > > suitable slot for the compressed page. If these pages are needed
> > > later on, users will incur IOs from swapins.
> > >
> > > This issue prevents the adoption of zswap for potential users who
> > > cannot tolerate the latency associated with swapping. In many cases,
> > > these IOs are avoidable if we just keep in memory the pages that zswa=
p
> > > fail to store.
> > >
> > > This patch series add two new features for zswap that will alleviate
> > > the risk of swapping:
> > >
> > > a) When a store attempt fail, keep the page untouched in memory
> > > instead of swapping it out.
> >
> > What about writeback when the zswap limit is hit? I understand the
> > problem, but I am wondering if this is the correct way of fixing it.
> > We really need to make zswap work without a backing swapfile, which I
> > think is the correct way to fix all these problems. I was working on
> > that, but unfortunately I had to pivot to something else before I had
> > something that was working.
> >
> > At Google, we have "ghost" swapfiles that we use just to use zswap
> > without a swapfile. They are sparse files, and we have internal kernel
> > patches to flag them and never try to actually write to them.
> >
> > I am not sure how many bandaids we can afford before doing the right
> > thing. I understand it's a much larger surgery, perhaps there is a way
> > to get a short-term fix that is also a step towards the final state we
> > want to reach instead?
>
> I agree it should also stop writeback due to the limit.
>
> Note that a knob like this is still useful even when zswap space is
> decoupled from disk swap slots. We still are using disk swap broadly
> in the fleet as well, so a static ghost file setup wouldn't be a good
> solution for us. Swapoff with common swapfile sizes is often not an
> option during runtime, due to how slow it is, and the destabilizing
> effect it can have on the system unless that's basically completely
> idle. As such, we expect to continue deploying swap files for physical
> use, and switch the zswap-is-terminal knob depending on the workload.
>
> The other aspect to this is that workloads that do not want the
> swapout/swapin overhead for themselves are usually co-located with
> system management software, and/or can share the host with less
> latency sensitive workloads, that should continue to use disk swap.
>
> Due to the latter case, I wonder if a global knob is actually
> enough. More likely we'd need per-cgroup control over this.
>
> [ It's at this point where the historic coupling of zswap to disk
>   space is especially unfortunate. Because of it, zswap usage counts
>   toward the memory.swap allowance. If these were separate, we could
>   have easily set memory.zswap.max=3Dmax, memory.swap.max=3D0 to achieve
>   the desired effect.
>
>   Alas, that ship has sailed. Even after a decoupling down the line it
>   would be difficult to change established memory.swap semantics. ]
>
> So I obviously agree that we still need to invest in decoupling zswap
> space from physical disk slots. It's insanely wasteful, especially
> with larger memory capacities. But while it would be a fantastic
> optimization, I don't see how it would be an automatic solution to the
> problem that inspired this proposal.
>
> We still need some way to reasonably express desired workload policy
> in a setup that supports multiple, simultaneous modes of operation.
>
> > > b) If the store attempt fails at the compression step, allow the page
> > > to be stored in its uncompressed form in the zswap pool. This maintai=
ns
> > > the LRU ordering of pages, which will be helpful for accurate
> > > memory reclaim (zswap writeback in particular).
> >
> > This is dangerous. Johannes and I discussed this before. This means
> > that reclaim can end up allocating more memory instead of freeing.
> > Allocations made in the reclaim path are made under the assumption
> > that we will eventually free memory. In this case, we won't. In the
> > worst case scenario, reclaim can leave the system/memcg in a worse
> > state than before it started.
>
> Yeah, this is a concern. It's not such a big deal if it's only a few
> pages, and we're still shrinking the footprint on aggregate. But it's
> conceivable this can happen systematically with some datasets, in
> which case reclaim will drive up the memory consumption and cause
> OOMs, or potentially deplete the reserves with PF_MEMALLOC and cause
> memory deadlocks.
>
> This isn't something we can reasonably accept as worst-case behavior.
>
> > Perhaps there is a way we can do this without allocating a zswap entry?
> >
> > I thought before about having a special list_head that allows us to
> > use the lower bits of the pointers as markers, similar to the xarray.
> > The markers can be used to place different objects on the same list.
> > We can have a list that is a mixture of struct page and struct
> > zswap_entry. I never pursued this idea, and I am sure someone will
> > scream at me for suggesting it. Maybe there is a less convoluted way
> > to keep the LRU ordering intact without allocating memory on the
> > reclaim path.
>
> That should work. Once zswap has exclusive control over the page, it
> is free to muck with its lru linkage. A lower bit tag on the next or
> prev pointer should suffice to distinguish between struct page and
> struct zswap_entry when pulling stuff from the list.

Hmm I'm a bit iffy about pointers bit hacking, but I guess that's
the least involved way to store the uncompressed page in the zswap
LRU without allocating a zswap_entry for it.

Lemme give this a try. If it looks decently clean I'll send it out :)

>
> We'd also have to teach vmscan.c to hand off the page. It currently
> expects that it either frees the page back to the allocator, or puts
> it back on the LRU. We'd need a compromise where it continues to tear
> down the page and remove the mapping, but then leaves it to zswap.
>
> Neither of those sound impossible. But since it's a bigger
> complication than this proposal, it probably needs a new cost/benefit
> analysis, with potentially more data on the problem of LRU inversions.
>
> Thanks for your insightful feedback, Yosry.
