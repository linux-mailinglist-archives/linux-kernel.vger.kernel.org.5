Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050177CCBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjJQTEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:04:50 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F496D3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:04:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77acb04309dso242360639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569488; x=1698174288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjdScQE3k6FbfKXgTzIU4GGDXOuCuyF0SItNvgyGISI=;
        b=VjakNZ/RSviAXyp7BX5XCTV98nz7SKD6UQULyiPpsxaZlg5oMuxw8VkaVpFEjyuE4V
         h8sjtugCi6NqmscBQIz1mQYZUJI7XhD/L8zzczcx4N0zaMS3zl3XPQaSsVgl8TpeQ1D/
         fv7mf2avVHN8EegAMUfQxu+U522WMRJVSESfQKM9C8tzeAFj9bR0bXB9Z2fTIKLdYNL2
         MtI6lIkwESAqckp5lBG+nHwmytjZmJwKAKJVsW4NqpswlnLCu4I0Ufw2EZBVpXhaFDJd
         v0Qdcz474xU3o6ca0IhKcVedjiyS6afNl7afkI7b3Ul8XW5RabdHEDLwh+xysetGWaZ0
         1Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569488; x=1698174288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjdScQE3k6FbfKXgTzIU4GGDXOuCuyF0SItNvgyGISI=;
        b=Wd+P67j48MVFV6OKD+6zHWwlPvrQ+PGgMvZ/ZZn2517MDIN9xPatBd6URoX5/S9P4O
         zilEUb/MudAg/ev5vMnfcdzF3PO+surakHAWSIuI+SqwZVAGKR4P5L9o2ZyzwybKxrGA
         lONJjjkn/3eypr0MDPDMDPyW7pL/nGCNewCwBYEQSu1YDspgopqO4/7RIx2YHzcglVXn
         yZdJi/pAgWtidd8y2sxeJ8lsRyWY8P+NBC3IqN4VOJUPiVIvqAssPsBG8yc5kSGTF/I+
         4zUaw4zBEpK4xax1ffQgsh8+7g6mLJQz5A4GSseP0dpgJW98R9EgJGJElvkNn/tXb4mX
         Y2zQ==
X-Gm-Message-State: AOJu0YziYHYN7SnK8l2Apt/LT2p++g0Zlgn7Fc+oy6U0cFMYkklKAGB6
        Pge4MdHOfU6yUzDo0nSDism97BOjQ3JebyX2eV4=
X-Google-Smtp-Source: AGHT+IF4xs2e95iRO9jLPBFf/6nJyjuMoUgYnBZ6W+hFWZb6D/9pfhuWOEZn2nMN36Qr6X+g45UyDO6pCt2XHSjApCE=
X-Received: by 2002:a05:6602:2c86:b0:787:34d:f1ea with SMTP id
 i6-20020a0566022c8600b00787034df1eamr4259898iow.8.1697569488326; Tue, 17 Oct
 2023 12:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231017003519.1426574-1-nphamcs@gmail.com> <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
 <CAKEwX=Npoa5pxeqOHqNTreqVEKpnFQ2rg=yN6eOgFQngBp6X+w@mail.gmail.com>
In-Reply-To: <CAKEwX=Npoa5pxeqOHqNTreqVEKpnFQ2rg=yN6eOgFQngBp6X+w@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 17 Oct 2023 12:04:37 -0700
Message-ID: <CAKEwX=OpVojN27yxQRXmOJcHYnHSoQqTW3dzxOveTzvbEu7vaA@mail.gmail.com>
Subject: Re: [PATCH 0/2] minimize swapping on zswap store failure
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
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

On Tue, Oct 17, 2023 at 12:03=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Mon, Oct 16, 2023 at 5:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
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
> Regarding the writeback - I'll make sure to also short-circuit writeback
> when the bypass_swap option is enabled in v2 :) I'll probably send out
> v2 after

... I gather all these feedbacks.

> I absolutely agree that we must decouple zswap and swap (and would
> be happy to help out in any capacity I could - we have heard similar
> concerns/complaints about swap wastage from internal parties as well).
>
> However, as Johannes has pointed out, this feature still has its place,
> given our already existing swapfile deployments. I do agree that a
> global knob is insufficient tho. I'll add a per-cgroup knob in v2 so that
> we can enable/disable this feature on a per-workload basis.
>
> >
> > >
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
> >
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
> Hmm yeah you're right about these concerns. That seems like a lot more
> involved than what I envisioned initially.
>
> Let's put this aside for now. I'll just send the first patch in v2, and w=
e can
> work on + discuss more about uncompressed pages storing later on.
>
> >
> > >
> > > These features could be enabled independently via two new zswap modul=
e
> > > parameters.
> > >
> > > Nhat Pham (2):
> > >   swap: allows swap bypassing on zswap store failure
> > >   zswap: store uncompressed pages when compression algorithm fails
> > >
> > >  Documentation/admin-guide/mm/zswap.rst | 16 +++++++
> > >  include/linux/zswap.h                  |  9 ++++
> > >  mm/page_io.c                           |  6 +++
> > >  mm/shmem.c                             |  8 +++-
> > >  mm/zswap.c                             | 64 +++++++++++++++++++++++-=
--
> > >  5 files changed, 95 insertions(+), 8 deletions(-)
> > >
> > > --
> > > 2.34.1
