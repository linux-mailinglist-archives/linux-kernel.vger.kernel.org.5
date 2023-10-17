Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DAF7CCB97
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbjJQTD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbjJQTDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:03:24 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9476BF9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:03:22 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fe8986355so233219639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569402; x=1698174202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEf0Vev2dH/Kch+Ne/BhspaobL0pi1FdS7NjhmirXTQ=;
        b=VTS6NNVAbO0RIB5lJUnisyqugkREXeNPWKE+ckFjmB+ovG370yiyUloEZew9DaDidN
         PW815ZrInXuBeYF/6Pu1WmbZnTMRobLqu1oYTKXGaDjcPlHidZL5LQJdUub1nOHOLhFb
         PdDTgY4t4DbnAVn8LXWwpUPrTrteDA7qBijt3pCE9SWwrgYMaglbCOJD/NPJSRZCj/eU
         zHw3dp0oZdqw/tH2CW8u8b6N0+3T92pMrl/fdJ9OuBbFfM/6TZAMlz6LDdj37WTDlXRp
         oiVKogKWk0keU+KeDX52gq7ZDn5dQ8CqnPBiwFrUKeK9o0kxktPQaAYQFTgyqV4D9RM4
         qChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569402; x=1698174202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEf0Vev2dH/Kch+Ne/BhspaobL0pi1FdS7NjhmirXTQ=;
        b=XjvWETM3o1Q9rC0HncO0GJwgjFlU4czhQ/r5hou/M8jKckyoafDm2HPfa3AySRZNJ7
         NrGBYzPfYE6xW2mr+0Rge/ZfeD4qBSctvang8bOq/LgPsd5nPVZXbngSoR9EvOlPTz1B
         LPbtCdy63GSQHNdrAUHvztqoZScq0IPR9hZ8Ct3YGMdm7m/1vnmYa7wBgqr9V3KDaVoq
         FhDn5iKsgeAlpP2w1sL9wIwxfBHnoeyG67JmXNPAG5PKLsD27I2hwyn9eRo4RtKn8uj9
         0w4uGxD++wfh6dhFORDwPBTv2rW7FJ3bosp4CUHDrc7CPVCRZdkAZz00wcxQozxMSusz
         hvwQ==
X-Gm-Message-State: AOJu0YzIz9Wq0fgD6OETDPCx7woAlTbG7UMLDwwxbSsOLw1DCz8IaNFz
        CbuHcmKN8nNn3GhhXiIi9cDlsXxFqxDP4rLpqiU=
X-Google-Smtp-Source: AGHT+IGQPdI3bWDIsmK/c4iwpiHjOx91l6Y6vRth+VJNYCFlTwX6snGxGP/5yQ5syddLPz3FEGw79P7ytK5vVESnvqU=
X-Received: by 2002:a05:6602:3fc8:b0:787:1472:3181 with SMTP id
 fc8-20020a0566023fc800b0078714723181mr4135503iob.3.1697569401810; Tue, 17 Oct
 2023 12:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231017003519.1426574-1-nphamcs@gmail.com> <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
In-Reply-To: <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 17 Oct 2023 12:03:10 -0700
Message-ID: <CAKEwX=Npoa5pxeqOHqNTreqVEKpnFQ2rg=yN6eOgFQngBp6X+w@mail.gmail.com>
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

On Mon, Oct 16, 2023 at 5:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Oct 16, 2023 at 5:35=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
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

Regarding the writeback - I'll make sure to also short-circuit writeback
when the bypass_swap option is enabled in v2 :) I'll probably send out
v2 after

I absolutely agree that we must decouple zswap and swap (and would
be happy to help out in any capacity I could - we have heard similar
concerns/complaints about swap wastage from internal parties as well).

However, as Johannes has pointed out, this feature still has its place,
given our already existing swapfile deployments. I do agree that a
global knob is insufficient tho. I'll add a per-cgroup knob in v2 so that
we can enable/disable this feature on a per-workload basis.

>
> >
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
>
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

Hmm yeah you're right about these concerns. That seems like a lot more
involved than what I envisioned initially.

Let's put this aside for now. I'll just send the first patch in v2, and we =
can
work on + discuss more about uncompressed pages storing later on.

>
> >
> > These features could be enabled independently via two new zswap module
> > parameters.
> >
> > Nhat Pham (2):
> >   swap: allows swap bypassing on zswap store failure
> >   zswap: store uncompressed pages when compression algorithm fails
> >
> >  Documentation/admin-guide/mm/zswap.rst | 16 +++++++
> >  include/linux/zswap.h                  |  9 ++++
> >  mm/page_io.c                           |  6 +++
> >  mm/shmem.c                             |  8 +++-
> >  mm/zswap.c                             | 64 +++++++++++++++++++++++---
> >  5 files changed, 95 insertions(+), 8 deletions(-)
> >
> > --
> > 2.34.1
