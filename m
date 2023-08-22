Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0444784C36
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjHVVqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjHVVq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:46:29 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A591AF3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:46:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565334377d0so3533412a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 14:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692740786; x=1693345586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MUJPUxcmVBLaTsgRdKXZfBt6MGT8IKSbca8jhVu0H8=;
        b=BK9+Wr29EKwyTgCbAH6TYt3AcRs4x/XUqyjnbCXOowFeU6f8e4YjWTD0J17tl3fvFV
         ijsHrtXjtkIvHOTdpmpQK2azcKdx58urLrRgotip/dmjXiCurUiRQBWYu6pQheQYeHFP
         U7G8z63zQ1ELkz6KYu6/MPWa72Dh+7Aj7a6kszh5f2jKW2oiT5dYYRuWfy+vHDgX2HdL
         VI3UKdE7U9biI76hKcGsVF7l12SgCNC6HQim5zXfw/JBw6f+61NhZi1jxJC+8UwDkMyl
         f6PlWxkTDSDwZ4OZcB3tp7rpRiMBgHsZO1I5lZ7JbVKgEVNnKGtvVAxryhxwyc8V5L6Z
         zewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692740786; x=1693345586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MUJPUxcmVBLaTsgRdKXZfBt6MGT8IKSbca8jhVu0H8=;
        b=fbK911c/OocPN3S+0ZMazCVIcWsfOuMR045w+Pm8FmJVwv/tMSc34yH+edhiwAsYMl
         Bxf0SBKIAQC4GS0fZ67DL36Q1gWHXWjdL7FIRHPS9S34jURFzfn5yZyf4J1sgtuxsyL3
         /zNvspsok6hTORg92Zh8dZDbHFa0hbesUxopCTXxGvSu+iWoo54ovZ7yWAmLS1cHqbRo
         B/EREYBg88sgcKVg5L8Wqrg5kmPu/bL014MLP9+HOBm1aGNra36D3VeLa1CHmFKDtkv6
         YZQNgqIfyqkzhFjGC2sUhvdpRLdwVDPgEVFuFibcLXIQP7641t5qHU6qblbZx1zCICH7
         DF1g==
X-Gm-Message-State: AOJu0Yy2YJnizGOAppL2i/sEdvvIGQmEeIJ+WZ7prqfgxRXUQD1bJ4n8
        7lyv7UMyoDZHOq6caXXaRsmVGMwYS3Xa4+BBDvbH6g==
X-Google-Smtp-Source: AGHT+IEkmUBMh1jGZn1Usgdro918qJSGC6E5Yneo+/9vM4FTAUAx1UyRZ2pcZLap390DZPfpko6TJKuSq0Bcl8cr2H0=
X-Received: by 2002:a17:90a:c68a:b0:26d:1e39:faae with SMTP id
 n10-20020a17090ac68a00b0026d1e39faaemr9137213pjt.22.1692740785827; Tue, 22
 Aug 2023 14:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230817-free_pcppages_bulk-v1-0-c14574a9f80c@kernel.org>
 <20230821103225.qntnsotdzuthxn2y@techsingularity.net> <6a18b295-92ac-1633-0b79-6aaf18a8496d@huaweicloud.com>
 <CAF8kJuNq2Y5AAAQn66bTEfjkQ8kfPokmGgBLDPwEWUC=MO9NcQ@mail.gmail.com>
 <CAADnVQJNQ+9D+3y-jLh3KVczcSo_Piz2O9-V9Grh3c1NQZujsA@mail.gmail.com>
 <CAF8kJuOT5cSQNqO6-gf=M+hFxb2-nHT1eZnEvqGYGGC8qHn39Q@mail.gmail.com> <CAADnVQK-xqJxqcfpje0fvBKADB-nd_hQFuyoMMwqajEVKBG7Ng@mail.gmail.com>
In-Reply-To: <CAADnVQK-xqJxqcfpje0fvBKADB-nd_hQFuyoMMwqajEVKBG7Ng@mail.gmail.com>
From:   Chris Li <chriscli@google.com>
Date:   Tue, 22 Aug 2023 14:46:14 -0700
Message-ID: <CAF8kJuM-sO3ouRcNCEhzz2ZmXiHvKs5LD_65zwOLwvPua6LT9Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] mm/page_alloc: free_pcppages_bulk safeguard
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, Aug 22, 2023 at 2:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 22, 2023 at 2:29=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > On Tue, Aug 22, 2023 at 2:19=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > The execution sequence is like this:
> > > >
> > > >        count =3D min(pcp->count, count);
> > > >
> > > >         /* Ensure requested pindex is drained first. */
> > > >         pindex =3D pindex - 1;
> > > >         bpf_injected_spin_lock_irqsave {
> > > >                  alloc_page();
> > > >                  original spin_lock_irqsave(&zone->lock, flags) ;
> > > >         }
> > >
> > > bpf doesn't call into alloc_page() or slab alloc or pcpu alloc from
> > > tracing progs.
> > > All memory is preallocated.

That is good to know. Thanks.

> >
> > Here is the other patch submission thread which have more detail of
> > how to reproduce it:
> > https://lore.kernel.org/linux-mm/20230817-free_pcppages_bulk-v1-1-c1457=
4a9f80c@kernel.org/
> >
> > It is on older version of the kernel.
>
> Please demonstrate the issue on the latest kernel.
> It's an unnecessary time sink for everyone to review patches
> targeting an issue in the old kernel.

Thanks, that is the answer I am looking for. That is why I tag it
as RFC.

>
> > > Can you reproduce the issue on the latest upstream kernel?
> >
> > Hope, the fix on the BPF side went in as commit c66a36af7ba3a628.
> > I am not aware of other cases.
>
> That was a temporary workaround on perf side.
> bpf task local storage was properly fixed later.

Ack.

> > It seems the consensus is so far is that we don't support BPF doing
> > nested allocation on spin locks.
> > That will implite any function called under the spinlocks as well.
>
> We're still talking past each other. bpf uses preallocated memory.
> It might look like bpf prog is allocating, but it's actually
> not calling into slab.

Ack.


> > Do we care about adding more warnings on this kind of allocation at all=
?
>
> bpf doesn't mess with mm state.
> If you somehow managed to cause mm splat with bpf prog talk to bpf folks =
first.
> It's a bug somewhere in bpf. Not with mm.

Noted. It started as a MM clean up patch. Should include you earlier.

I will spit out the part 2 of the patch as clean up without touching
pcp->count then.

Chris
