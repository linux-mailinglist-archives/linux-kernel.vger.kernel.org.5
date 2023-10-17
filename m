Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1567CBA31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbjJQFeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbjJQFeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:34:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A0BF2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:34:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a6190af24aso869462766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 22:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697520843; x=1698125643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz/4Nv/Pi/BmjZt/Tm3iO+wXoh8fdTpmJ29M1nJbe88=;
        b=TCvKhQJXU+k5OqBwZdOi0u+Cm/rQFq7U6WIiN/0qQFhlGmtTSPddssf+87vDQqIIaL
         Onxk7ozOYe5ihuV3/J9EBsA+5zBb11QCbsX9wUZRBlJ4f9FRKP6vILWhHu4G1dbFQ0P9
         WpJuBb96jqZc8yoQ1R36znggV3V3wgbhTIqkcvENyxhEtqtr2i3PL4e+BviiZtKbCBxq
         eGIdm+m28VdgsS44x7yl3tRU04AuvmmLYBfmEi+mo59CkTsiNDzChJ0wbMToRby1Q/GD
         HJI3LIR8KkTBCqzTiLlGd3Mck2tlB2Ug4EYslbnpV/MW4Ot4kT4dawy71ph7BNXWvQwI
         7JXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697520843; x=1698125643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz/4Nv/Pi/BmjZt/Tm3iO+wXoh8fdTpmJ29M1nJbe88=;
        b=Vcg/mEVpfWeVSRDqmwZhd2gws4YsyI4n5DChv/MvCN4fOyhxh+9sHUG0l3P/iPisv7
         PAecV7EuayViGsBoz89kgqIOdGW/n9KuLrWmNMXbrDUxXGsQrJ/xqALJ4DXIYilU4NYE
         CqSNGm7V/9kidYCode1UJbn0rwsIvvt7feengIBBp2Lo+hIO1zLPkBQB8CxEWvE+VjsF
         gaa5I+CE0QFvKTGAj+GAynAnxoGjUiKoxYmzX3Yi3eiD5bF1KFgYYOcW8KLec+0/mHjI
         yWvgJsIJaIKHoeGAgrU3e5R1yzHTGikHbiEZFNHibcrs/6nyJcLqg/Sv9VKEUj8xk8EZ
         MFDw==
X-Gm-Message-State: AOJu0YzttZ24QcRDkwAfru2Kz+23TDDFnLCxXSQXlsyaN747K9qznaGL
        d9BCiIUnJMl2fifTMSJQfSuR8705NP8qz95o8nZRaw==
X-Google-Smtp-Source: AGHT+IE8YGCi6YMLuJ7SPZiyiFZVWgOC7cRRv8mMpc2DaDSjzrVF6ikAXRTRx9PGjn0DcV9w2JnDgYee0wZSLg8fscQ=
X-Received: by 2002:a17:907:749:b0:9a6:1446:852c with SMTP id
 xc9-20020a170907074900b009a61446852cmr813495ejb.27.1697520842460; Mon, 16 Oct
 2023 22:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231017003519.1426574-1-nphamcs@gmail.com> <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
 <20231017044745.GC1042487@cmpxchg.org>
In-Reply-To: <20231017044745.GC1042487@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 16 Oct 2023 22:33:23 -0700
Message-ID: <CAJD7tkbEJDczxPqp2ZcZiz1ZWYdUWZLaiovxiGWcM57md-URhA@mail.gmail.com>
Subject: Re: [PATCH 0/2] minimize swapping on zswap store failure
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, hughd@google.com,
        corbet@lwn.net, konrad.wilk@oracle.com, senozhatsky@chromium.org,
        rppt@kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, david@ixit.cz,
        Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>,
        Greg Thelen <gthelen@google.com>
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

In conjunction with ghost swapfiles, we have a knob to determine the
type of swapfile to use for each cgroup (normal, ghost, either, or
none). This achieves what you are describing, allowing different
workloads on the same machine to use zswap only or disk swap, although
in practice we only use zswap now.

I am not saying that's necessarily the correct way of doing it. Having
a zswap-is-terminal knob per-cgroup is another way to achieve this. I
will loop in folks maintaining this code internally to see what they
think.

>
> [ It's at this point where the historic coupling of zswap to disk
>   space is especially unfortunate. Because of it, zswap usage counts
>   toward the memory.swap allowance. If these were separate, we could
>   have easily set memory.zswap.max=3Dmax, memory.swap.max=3D0 to achieve
>   the desired effect.
>
>   Alas, that ship has sailed. Even after a decoupling down the line it
>   would be difficult to change established memory.swap semantics. ]

Fully agree here. This is unfortunate.

>
> So I obviously agree that we still need to invest in decoupling zswap
> space from physical disk slots. It's insanely wasteful, especially
> with larger memory capacities. But while it would be a fantastic
> optimization, I don't see how it would be an automatic solution to the
> problem that inspired this proposal.

Well, in my head, I imagine such a world where we have multiple
separate swapping backends with cgroup knob(s) that control what
backends are allowed for each cgroup. A zswap-is-terminal knob is
hacky-ish way of doing that where the backends are only zswap and disk
swap.

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

Right.

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

Right.

We handle incompressible memory internally in a different way, we put
them back on the unevictable list with an incompressible page flag.
This achieves a similar effect.

A missing point here is that those pages, if dirtied, may be
compressible again. When we have them on the LRUs, we rely on periodic
scanning (similar to the MGLRU-based periodic scanning we proposed
before) to check the dirty bit and make those pages evictable again.

If we leave them on the zswap LRU, we will incur a fault instead to
pull them back to the LRUs. For anon pages, that's probably fine, as
in both cases by the time we reach zswap the page has been unmapped,
and accessing it again incurs a fault anyway (whether it's in zswap
LRUs or in the reclaim LRUs). For shmem though, we put the
incompressible pages back in the page cache, preventing a page fault
on the next access. This is a drawback of the zswap LRU approach
AFAICT. Not sure how much it matters in practice.

>
> We'd also have to teach vmscan.c to hand off the page. It currently
> expects that it either frees the page back to the allocator, or puts
> it back on the LRU. We'd need a compromise where it continues to tear
> down the page and remove the mapping, but then leaves it to zswap.

Right.

>
> Neither of those sound impossible. But since it's a bigger
> complication than this proposal, it probably needs a new cost/benefit
> analysis, with potentially more data on the problem of LRU inversions.

Makes sense.

>
> Thanks for your insightful feedback, Yosry.
