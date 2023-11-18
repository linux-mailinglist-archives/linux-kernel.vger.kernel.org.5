Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513867F020C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjKRSoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjKRSoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:44:10 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A077EB7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 10:44:06 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35af2b4242eso3078765ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 10:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700333046; x=1700937846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Rqm8c2mzVlSTmByITnlTNyQf2tve+K1Yem5CIyuqsE=;
        b=BSzTUHlM7Vc1IWWIlshukayDw658gjpFV1Dq3wNHd/f6/ioFImq7oNYm9bMtU4hxUx
         XIqH4HkPR9TrhTb90dnRuvXqRIrXhjklZ+pvZMCmHtewqajFV1KQbMxY85I+jdW1qtmR
         1m1Ziq6J2jiuNTvDeP7jImAJDHbBErl8wvJ/XTG6hqnVFoIczZMkoW3lGb0yyVK2JLIR
         QJ6QRlN1ntAjIHsRhDh2mRla69J/P5buDfjMTEMPu3uNgiQeo5EAjqMhGlTrSgvPEQlA
         IuoosWhQKt2faXfSm9c6NpBepBW0S7k5rWRKdw19lKXfyK9PEaKq1nX67JAugJQm6fy1
         in4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700333046; x=1700937846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Rqm8c2mzVlSTmByITnlTNyQf2tve+K1Yem5CIyuqsE=;
        b=V/YRjtXVycr23VXKLAmSHz0X37d6znl5BB+lv2ZkZ7VK4TbdwfQy6TgdKafyWNd9Rk
         Ft/Urssgm4rlBkTnzUD318t5Cm3B8LN/hK4fyhyaqM58mJoB5VHy/F6QAmBbN1hlv51b
         u1UvvuT8mFyzBGyzBCdnwBfaDTPNQMvvsXnwAFytPlNmuGNWc42UaBFx1kkB/RR4dkH2
         ZrNhc1wkySeEwqgONdvmmz+Zq580Ctlf9h/GR1CCLluG/uPt7BcFHPeTYNoeh2Zt0XQi
         HqB7aBjMU2dIyzk6lx9m8WpKLCbgF3jHpk8DlK/uobm15EUfzza7keob1Tup/HBwcwuB
         jpBw==
X-Gm-Message-State: AOJu0YxaHACLnMzyOoCwh66UyJCgu9Ynko41qarsHS2rPAwH8Cf983zo
        YINCGQVyE+aYfyr6WY/O/5QOYGNeYQ94N3GWU7I=
X-Google-Smtp-Source: AGHT+IF7/hs76dDRD4AQ6K8kq8hrcgN/GH2w2K664VsS4PmHylTT4IBWCsmfWelXzq4uTSxvrKl2LNwom7FJ1o0rgBM=
X-Received: by 2002:a92:bf10:0:b0:359:3b36:9abf with SMTP id
 z16-20020a92bf10000000b003593b369abfmr3070557ilh.4.1700333045868; Sat, 18 Nov
 2023 10:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <CACSyD1NJ4ycr74pXHNus3ZjA=LvZP+aMNyz=iWyHuDODpx7aww@mail.gmail.com>
 <CAF8kJuPymUX+DwouwgH6og0BO6ZYheGXsk=GYqYuMjKMz-Xqbw@mail.gmail.com> <CACSyD1P-6mQ7n+ghsZQ0Gp4AxyTTi6=UZHz2DnXWuCWke2fkPw@mail.gmail.com>
In-Reply-To: <CACSyD1P-6mQ7n+ghsZQ0Gp4AxyTTi6=UZHz2DnXWuCWke2fkPw@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sat, 18 Nov 2023 13:43:52 -0500
Message-ID: <CAKEwX=O0eNmoFRsnRXpkY55UGHBOiGL2aQW6um8Kq5hgGH=c_A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 8:46=E2=80=AFPM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> Hi Chris, thanks for your time.
>
> >
> > On Fri, Nov 17, 2023 at 1:56=E2=80=AFAM Zhongkun He
> > <hezhongkun.hzk@bytedance.com> wrote:
> > > Hi Chris, thanks for your feedback.  I have the same concerns,
> > > maybe we should just move the zswap_invalidate() out of batches,
> > > as Yosry mentioned above.
> >
> > As I replied in the previous email, I just want to understand the
> > other side effects of the change better.
> >
> > To me, this patching is actually freeing the memory that does not
> > require actual page IO write from zswap. Which means the memory is
> > from some kind of cache. It would be interesting if we can not
> > complicate the write back path further. Instead, we can drop those
> > memories from the different cache if needed. I assume those caches are
> > doing something useful in the common case. If not, we should have a
> > patch to remove these caches instead.  Not sure how big a mess it will
> > be to implement separate the write and drop caches.
> >
> > While you are here, I have some questions for you.
> >
> > Can you help me understand how much memory you can free from this
> > patch? For example, are we talking about a few pages or a few GB?
> >
> > Where does the freed memory come from?
> > If the memory comes from zswap entry struct. Due to the slab allocator
> > fragmentation. It would take a lot of zswap entries to have meaningful
> > memory reclaimed from the slab allocator.
> >
> > If the memory comes from the swap cached pages, that would be much
> > more meaningful. But that is not what this patch is doing, right?
> >
> > Chris
>
> It's my bad for putting two cases together. The memory released in both
> cases comes from zswap entry struct and zswap compressed page.
>
> The original intention of this patch is to solve the problem that
> shrink_work() fails to reclaim memory in two situations.
>
> For case (1),  the zswap_writeback_entry() will failed for the
> __read_swap_cache_async return NULL because the swap has been
> freed but cached in swap_slots_cache, so the memory come from
> the zswap entry struct and compressed page.
> Count =3D SWAP_BATCH * ncpu.
> Solution: move the zswap_invalidate() out of batches, free it once the sw=
ap
> count equal to 0.
>
> For case (2),  the zswap_writeback_entry() will failed for !page_was_allo=
cated
> because zswap_load will have two copies of the same page in memory
>   (compressed and uncompressed) after faulting in a page from zswap when
> zswap_exclusive_loads disabled. The amount of memory is greater but depen=
ds
> on the usage.
>
> Why do we need  to release them?
> Consider this scenario,there is a lot of data cached in memory and zswap,
> hit the limit=EF=BC=8Cand shrink_worker will fail. The new coming data wi=
ll be written
> directly to swap due to zswap_store failure. Should we free the last one
> to store the latest one in zswap.

Shameless plug: zswap will much less likely hit the limit (global or
cgroup) with the shrinker enabled ;) It will proactively reclaim the
objects way ahead of the limit.

It comes with its own can of worms, of course - it's unlikely to work
for all workloads in its current form, but perhaps worth experimenting
with/improved upon?


>
> According to the previous discussion, the writeback is inevitable.
> So I want to make zswap_exclusive_loads_enabled the default behavior
> or make it the only way to do zswap loads. It only makes sense when
> the page is read and no longer dirty. If the page is read frequently, it
> should stay in cache rather than zswap. The benefit of doing this is
> very small, i.e. two copies of the same page in memory.
>
> Thanks again.
