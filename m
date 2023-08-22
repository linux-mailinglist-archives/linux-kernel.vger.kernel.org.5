Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C7784C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjHVVgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHVVgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:36:13 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77CBCE8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:36:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bbad32bc79so83644581fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692740170; x=1693344970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LHjOWGMbGUokbA8qWX5eAKbU40dKCMt10ItvXVx9pk=;
        b=QrxdTx2A/tl6u8hz5Vk/lr1Bx45IZkwv3u8lQZ7sYP5yZmQSX8QoQNz8lkzSRpmfIN
         FdYsuqhbzuUZNaqyLMFwb4QMllt1U6J/varAT5eUPY3lm2IkRCB/MV+R7ONL28uO006P
         tqIk1lUeb5J1JelPWkPBhdQ9/PUKSwtTJ7BtEpgVtlECXgCylbGn9YQDtQr+uqkcaibE
         aLeFIixp+Tnn2B0nRTD/jhx2z2o0VpbWyfmgiboxQsC9qxqBI6g02tQ1AidnOqPDOx77
         043q3LrYnShKd9eUbDTVyDq5nAB9OD2lW4PFyaX0tucKZtMVR2tXaxaQrjxm1peTFNcD
         aXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740170; x=1693344970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LHjOWGMbGUokbA8qWX5eAKbU40dKCMt10ItvXVx9pk=;
        b=dREDQDTpDaV4OTwp6rQ144+N1y3NjFqejNaHq9tOy/wNjhMFICoZbevXLcw55pHh1P
         WJs3qNWka62a8jZk1rBaUDgncvQkQjQSiQ3XbVYHgx7LyLMUQWfMAmQkyaQkXb0U72b3
         HKyR2n/dqouh3kvLroeZHAO9oVjvLL2ez6rpGMr1aP5oh50NEnQOsqB0zXTQmk9d0DPV
         w/IjEi2Am81y9/BBOM/VzesGbcTvJo+7696QDLs5c58YsPlWAQMim2/LlefVeH/KFiey
         0ewes2FMOmlQcCNKsu/EQKlTlO2dMJu3F2v0MHnYiME/i57IRFJ5jwLbwcfTIxl6kCC/
         6znw==
X-Gm-Message-State: AOJu0Yy6WdQe+geilr+k0+11F4v7aA5ioccy8zwPPkkUSfeT1DhpCJgl
        oJah6zQGw1zV2VqlEtdB8S6nGyyaj/U05AqziHU=
X-Google-Smtp-Source: AGHT+IHctqN/U8j4Kr4pwXmL967EF0ND3jL7m0J3rg6bQN/XuHej33P3WqFfMPURTOnlFWl5drp+ei5ZFFpIgWOxefE=
X-Received: by 2002:a2e:3207:0:b0:2b8:3ff3:cd93 with SMTP id
 y7-20020a2e3207000000b002b83ff3cd93mr7174536ljy.7.1692740170040; Tue, 22 Aug
 2023 14:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net> <6a18b295-92ac-1633-0b79-6aaf18a8496d@huaweicloud.com>
 <CAF8kJuNq2Y5AAAQn66bTEfjkQ8kfPokmGgBLDPwEWUC=MO9NcQ@mail.gmail.com>
 <CAADnVQJNQ+9D+3y-jLh3KVczcSo_Piz2O9-V9Grh3c1NQZujsA@mail.gmail.com> <CAF8kJuOT5cSQNqO6-gf=M+hFxb2-nHT1eZnEvqGYGGC8qHn39Q@mail.gmail.com>
In-Reply-To: <CAF8kJuOT5cSQNqO6-gf=M+hFxb2-nHT1eZnEvqGYGGC8qHn39Q@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 22 Aug 2023 14:35:58 -0700
Message-ID: <CAADnVQK-xqJxqcfpje0fvBKADB-nd_hQFuyoMMwqajEVKBG7Ng@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
To:     Chris Li <chrisl@kernel.org>
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        baolin.wang@linux.alibaba.com, Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Namhyung Kim <namhyung@google.com>,
        Greg Thelen <gthelen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        John Sperbeck <jsperbeck@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>
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

On Tue, Aug 22, 2023 at 2:29=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Aug 22, 2023 at 2:19=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > >
> > > The execution sequence is like this:
> > >
> > >        count =3D min(pcp->count, count);
> > >
> > >         /* Ensure requested pindex is drained first. */
> > >         pindex =3D pindex - 1;
> > >         bpf_injected_spin_lock_irqsave {
> > >                  alloc_page();
> > >                  original spin_lock_irqsave(&zone->lock, flags) ;
> > >         }
> >
> > bpf doesn't call into alloc_page() or slab alloc or pcpu alloc from
> > tracing progs.
> > All memory is preallocated.
>
> Here is the other patch submission thread which have more detail of
> how to reproduce it:
> https://lore.kernel.org/linux-mm/20230817-free_pcppages_bulk-v1-1-c14574a=
9f80c@kernel.org/
>
> It is on older version of the kernel.

Please demonstrate the issue on the latest kernel.
It's an unnecessary time sink for everyone to review patches
targeting an issue in the old kernel.

> > Can you reproduce the issue on the latest upstream kernel?
>
> Hope, the fix on the BPF side went in as commit c66a36af7ba3a628.
> I am not aware of other cases.

That was a temporary workaround on perf side.
bpf task local storage was properly fixed later.

> It seems the consensus is so far is that we don't support BPF doing
> nested allocation on spin locks.
> That will implite any function called under the spinlocks as well.

We're still talking past each other. bpf uses preallocated memory.
It might look like bpf prog is allocating, but it's actually
not calling into slab.

> Do we care about adding more warnings on this kind of allocation at all?

bpf doesn't mess with mm state.
If you somehow managed to cause mm splat with bpf prog talk to bpf folks fi=
rst.
It's a bug somewhere in bpf. Not with mm.
