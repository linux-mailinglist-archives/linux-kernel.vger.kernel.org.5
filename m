Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4FE7CB9D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjJQErx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJQEru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:47:50 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68191A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:47:47 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d134a019cso34012576d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 21:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697518066; x=1698122866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/PhEfIj7SJbCh9k3JCM4ljo+v9VHnZesYcsA6g8vYnM=;
        b=sJRE8rsnV9edoPfmfmaobkIhvkQU/Q/G9MlAnK/i5bFFkY9XK4uQXC14kzvtpe7tVI
         8xDmHyR7At/RIlQ/PU5+KBFyRqbkvFAR40K/l4+j6epd10ln3P4oqvWc18s/2xZ+tqNY
         /hddnZINPeyaTOYxPmDk+IqT9M5hb438bnDXK1hV6awNjsELJkcpKUks1y6K5IPd6DzD
         nNYsCiDIzNuR5hEzL6yTDPLF/a1KeOzrM5yv+1q+sVfNfjUgSlLRSK/ZSDxD0CbwLJAz
         4cCcQ5meftSj+dxBd5uWajDoYGhvvSyjx/PxPyHsfRI3gJwe3ENHJ1Bi+p33FhHxIQmz
         yytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697518066; x=1698122866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PhEfIj7SJbCh9k3JCM4ljo+v9VHnZesYcsA6g8vYnM=;
        b=ad/7fS9z+xUw+U3RTRPouO3gWs/wlE7PX5fI8bMJ97Huxszgr8Qw3Cz2W43nRStqeK
         Fu7DdjG6/kqkwZ0YmFuFHcUr+bu8zau+9WtOKRDvOR2TyDdfCmI8iBcJH3U6L/OaPBu0
         RVKcyyUOMu2MBJKLZ/SXWG0DjkoSapiuYaIdrv+psHm9Eio5SWaQij6VjGXsAj8qPb5M
         RcC+eZ8f76cCnJziGOLthpqH3/KBj2bxyQ94Y2a2ksT3QzuboiUyUFIw0ydJfNTeCUzF
         vkYBvy1cgt2YOX0IAQDXXeK+O/0NyUO6UJ+lOwXioIQKXwm9Zb/Q+rQltZJ79BtKI0Sg
         Zl7g==
X-Gm-Message-State: AOJu0YxuHHyurlYfkEl/kVz/2tu0DfP2t9YSDiKXgx/Um9lhbn93Lk+/
        IXupjRCibiwNC/qGUYq79OzM4Q==
X-Google-Smtp-Source: AGHT+IHefjwi1GPQUVjs5er2OOSVNscN4hSxv/7E2+1W71PV0h0lh3xE8FyABUAGwi0zU6OEDp1BGA==
X-Received: by 2002:ad4:576e:0:b0:66d:3636:8a9 with SMTP id r14-20020ad4576e000000b0066d363608a9mr1498132qvx.63.1697518066456;
        Mon, 16 Oct 2023 21:47:46 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id o5-20020ac86985000000b00419ab6ffedasm328432qtq.29.2023.10.16.21.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 21:47:46 -0700 (PDT)
Date:   Tue, 17 Oct 2023 00:47:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, hughd@google.com,
        corbet@lwn.net, konrad.wilk@oracle.com, senozhatsky@chromium.org,
        rppt@kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, david@ixit.cz
Subject: Re: [PATCH 0/2] minimize swapping on zswap store failure
Message-ID: <20231017044745.GC1042487@cmpxchg.org>
References: <20231017003519.1426574-1-nphamcs@gmail.com>
 <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 05:57:31PM -0700, Yosry Ahmed wrote:
> On Mon, Oct 16, 2023 at 5:35 PM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > Currently, when a zswap store attempt fails, the page is immediately
> > swapped out. This could happen for a variety of reasons. For instance,
> > the compression algorithm could fail (such as when the data is not
> > compressible), or the backend allocator might not be able to find a
> > suitable slot for the compressed page. If these pages are needed
> > later on, users will incur IOs from swapins.
> >
> > This issue prevents the adoption of zswap for potential users who
> > cannot tolerate the latency associated with swapping. In many cases,
> > these IOs are avoidable if we just keep in memory the pages that zswap
> > fail to store.
> >
> > This patch series add two new features for zswap that will alleviate
> > the risk of swapping:
> >
> > a) When a store attempt fail, keep the page untouched in memory
> > instead of swapping it out.
> 
> What about writeback when the zswap limit is hit? I understand the
> problem, but I am wondering if this is the correct way of fixing it.
> We really need to make zswap work without a backing swapfile, which I
> think is the correct way to fix all these problems. I was working on
> that, but unfortunately I had to pivot to something else before I had
> something that was working.
>
> At Google, we have "ghost" swapfiles that we use just to use zswap
> without a swapfile. They are sparse files, and we have internal kernel
> patches to flag them and never try to actually write to them.
> 
> I am not sure how many bandaids we can afford before doing the right
> thing. I understand it's a much larger surgery, perhaps there is a way
> to get a short-term fix that is also a step towards the final state we
> want to reach instead?

I agree it should also stop writeback due to the limit.

Note that a knob like this is still useful even when zswap space is
decoupled from disk swap slots. We still are using disk swap broadly
in the fleet as well, so a static ghost file setup wouldn't be a good
solution for us. Swapoff with common swapfile sizes is often not an
option during runtime, due to how slow it is, and the destabilizing
effect it can have on the system unless that's basically completely
idle. As such, we expect to continue deploying swap files for physical
use, and switch the zswap-is-terminal knob depending on the workload.

The other aspect to this is that workloads that do not want the
swapout/swapin overhead for themselves are usually co-located with
system management software, and/or can share the host with less
latency sensitive workloads, that should continue to use disk swap.

Due to the latter case, I wonder if a global knob is actually
enough. More likely we'd need per-cgroup control over this.

[ It's at this point where the historic coupling of zswap to disk
  space is especially unfortunate. Because of it, zswap usage counts
  toward the memory.swap allowance. If these were separate, we could
  have easily set memory.zswap.max=max, memory.swap.max=0 to achieve
  the desired effect.

  Alas, that ship has sailed. Even after a decoupling down the line it
  would be difficult to change established memory.swap semantics. ]

So I obviously agree that we still need to invest in decoupling zswap
space from physical disk slots. It's insanely wasteful, especially
with larger memory capacities. But while it would be a fantastic
optimization, I don't see how it would be an automatic solution to the
problem that inspired this proposal.

We still need some way to reasonably express desired workload policy
in a setup that supports multiple, simultaneous modes of operation.

> > b) If the store attempt fails at the compression step, allow the page
> > to be stored in its uncompressed form in the zswap pool. This maintains
> > the LRU ordering of pages, which will be helpful for accurate
> > memory reclaim (zswap writeback in particular).
> 
> This is dangerous. Johannes and I discussed this before. This means
> that reclaim can end up allocating more memory instead of freeing.
> Allocations made in the reclaim path are made under the assumption
> that we will eventually free memory. In this case, we won't. In the
> worst case scenario, reclaim can leave the system/memcg in a worse
> state than before it started.

Yeah, this is a concern. It's not such a big deal if it's only a few
pages, and we're still shrinking the footprint on aggregate. But it's
conceivable this can happen systematically with some datasets, in
which case reclaim will drive up the memory consumption and cause
OOMs, or potentially deplete the reserves with PF_MEMALLOC and cause
memory deadlocks.

This isn't something we can reasonably accept as worst-case behavior.

> Perhaps there is a way we can do this without allocating a zswap entry?
>
> I thought before about having a special list_head that allows us to
> use the lower bits of the pointers as markers, similar to the xarray.
> The markers can be used to place different objects on the same list.
> We can have a list that is a mixture of struct page and struct
> zswap_entry. I never pursued this idea, and I am sure someone will
> scream at me for suggesting it. Maybe there is a less convoluted way
> to keep the LRU ordering intact without allocating memory on the
> reclaim path.

That should work. Once zswap has exclusive control over the page, it
is free to muck with its lru linkage. A lower bit tag on the next or
prev pointer should suffice to distinguish between struct page and
struct zswap_entry when pulling stuff from the list.

We'd also have to teach vmscan.c to hand off the page. It currently
expects that it either frees the page back to the allocator, or puts
it back on the LRU. We'd need a compromise where it continues to tear
down the page and remove the mapping, but then leaves it to zswap.

Neither of those sound impossible. But since it's a bigger
complication than this proposal, it probably needs a new cost/benefit
analysis, with potentially more data on the problem of LRU inversions.

Thanks for your insightful feedback, Yosry.
