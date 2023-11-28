Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62DE7FB097
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjK1D2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjK1D2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:28:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F38A1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:28:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a03a900956dso941732766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701142095; x=1701746895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52k2p5CyGPUAHKSXeNr7BKmEfDoFNmiiCRt1xrKRz/g=;
        b=CidLbP3JSP4VZimniBjZc9xXFte8/D+upOzfHIOjkV/Q51TYlwjJarP9QSmxSDKsyF
         Wk6iEVMr6DztgicHNJis3+L+PhDI85ACoQyiN1VcVw0bZaD9pP7aZZBaFyGnmCx2lUeB
         HvDbEVQaPl5LVWDNZu3tYwMq9KCgL7K24fZ32ebXXbDe1feV0P5KniLDj91wGV5CLAG+
         nXQyUakWOUYsb/SanHoB7PFLJRIL8dbwUpe3ngriv0LRI0wxKEedbABlvhsw4WiIOhuj
         int2ECpLJ9iQh+EdE4kQvSuGDcsD/42ofeYKkVODX2D8RjW/q5H7ZYAkm30mX1h84zgQ
         j4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701142095; x=1701746895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52k2p5CyGPUAHKSXeNr7BKmEfDoFNmiiCRt1xrKRz/g=;
        b=f0t9mI/3tkmg9tzIm0hEKq+xC1sosqtv3tiI/VgySnXKAZEm/DikFdBz/7qeOtA2xC
         nemMdZXeTBSNXJtPaTXnIrcxgFcAEDoF9DWpD4UEocQD+iC9DsjvxPTATbBxBD3wA/5B
         NNEKfT1uU+D1HzIdwMP2sACKFP8uutl5XP7UsrWuVqN6ag1oMhBUMYQ9myiKcG/0Mfu2
         pKF3nSvbMHCSFR8CqZhyp0gkOVB3QxY6zx38VptaR/pHho2Ir/yStblJ6e7Te1BHxISH
         KzUD29TWQDPAdRPLJuYetkSDyvlf1aeGFAt4CKo8r59AI+tjo64hYACqixXJZ+Buw0BW
         SHzg==
X-Gm-Message-State: AOJu0YwXEMHXACdJheKjY1TI5hH+bfRzu825QfgIDBpojRpcdmw7riL+
        wy7sQXGYC64KeZViPAh1SJNtonUdccVbT6BjCxt4dpJfyJgEkvpGWZ2AZA==
X-Google-Smtp-Source: AGHT+IEx8LNvwobnDx8T7P4u06cc4stnXOlF9kWWIeNLvdVuv2+mne0/S4GlmVWguwn8jwd+aU1VZ9grdt9uhMK+RRo=
X-Received: by 2002:a17:906:2bd1:b0:9e8:2441:5cd4 with SMTP id
 n17-20020a1709062bd100b009e824415cd4mr10023918ejg.17.1701142094665; Mon, 27
 Nov 2023 19:28:14 -0800 (PST)
MIME-Version: 1.0
References: <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka> <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka> <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
 <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
 <ZWUKziMl6cFV2uWN@google.com> <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
 <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Nov 2023 19:27:36 -0800
Message-ID: <CAJD7tkZmyzohNRqgvZvZC5L7OFHzDRm-Y3JEQHiDYcwTCz-FBQ@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Minchan Kim <minchan@kernel.org>, Chris Li <chriscli@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Mon, Nov 27, 2023 at 7:21=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Mon, Nov 27, 2023 at 1:32=E2=80=AFPM Minchan Kim <minchan@kernel.org=
> wrote:
> >>
> >> On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
> >> > On Mon, Nov 27, 2023 at 12:14=E2=80=AFAM Huang, Ying <ying.huang@int=
el.com> wrote:
> >> > > >  I agree with Ying that anonymous pages typically have different=
 page
> >> > > > access patterns than file pages, so we might want to treat them
> >> > > > differently to reclaim them effectively.
> >> > > > One random idea:
> >> > > > How about we put the anonymous page in a swap cache in a differe=
nt LRU
> >> > > > than the rest of the anonymous pages. Then shrinking against tho=
se
> >> > > > pages in the swap cache would be more effective.Instead of havin=
g
> >> > > > [anon, file] LRU, now we have [anon not in swap cache, anon in s=
wap
> >> > > > cache, file] LRU
> >> > >
> >> > > I don't think that it is necessary.  The patch is only for a speci=
al use
> >> > > case.  Where the swap device is used up while some pages are in sw=
ap
> >> > > cache.  The patch will kill performance, but it is used to avoid O=
OM
> >> > > only, not to improve performance.  Per my understanding, we will n=
ot use
> >> > > up swap device space in most cases.  This may be true for ZRAM, bu=
t will
> >> > > we keep pages in swap cache for long when we use ZRAM?
> >> >
> >> > I ask the question regarding how many pages can be freed by this pat=
ch
> >> > in this email thread as well, but haven't got the answer from the
> >> > author yet. That is one important aspect to evaluate how valuable is
> >> > that patch.
> >>
> >> Exactly. Since swap cache has different life time with page cache, the=
y
> >> would be usually dropped when pages are unmapped(unless they are share=
d
> >> with others but anon is usually exclusive private) so I wonder how muc=
h
> >> memory we can save.
> >
> > I think the point of this patch is not saving memory, but rather
> > avoiding an OOM condition that will happen if we have no swap space
> > left, but some pages left in the swap cache. Of course, the OOM
> > avoidance will come at the cost of extra work in reclaim to swap those
> > pages out.
> >
> > The only case where I think this might be harmful is if there's plenty
> > of pages to reclaim on the file LRU, and instead we opt to chase down
> > the few swap cache pages. So perhaps we can add a check to only set
> > sc->swapcache_only if the number of pages in the swap cache is more
> > than the number of pages on the file LRU or similar? Just make sure we
> > don't chase the swapcache pages down if there's plenty to scan on the
> > file LRU?
>
> The swap cache pages can be divided to 3 groups.
>
> - group 1: pages have been written out, at the tail of inactive LRU, but
>   not reclaimed yet.
>
> - group 2: pages have been written out, but were failed to be reclaimed
>   (e.g., were accessed before reclaiming)
>
> - group 3: pages have been swapped in, but were kept in swap cache.  The
>   pages may be in active LRU.
>
> The main target of the original patch should be group 1.  And the pages
> may be cheaper to reclaim than file pages.
>
> Group 2 are hard to be reclaimed if swap_count() isn't 0.
>
> Group 3 should be reclaimed in theory, but the overhead may be high.
> And we may need to reclaim the swap entries instead of pages if the pages
> are hot.  But we can start to reclaim the swap entries before the swap
> space is run out.
>
> So, if we can count group 1, we may use that as indicator to scan anon
> pages.  And we may add code to reclaim group 3 earlier.
>

My point was not that reclaiming the pages in the swap cache is more
expensive that reclaiming the pages in the file LRU. In a lot of
cases, as you point out, the pages in the swap cache can just be
dropped, so they may be as cheap or cheaper to reclaim than the pages
in the file LRU.

My point was that scanning the anon LRU when swap space is exhausted
to get to the pages in the swap cache may be much more expensive,
because there may be a lot of pages on the anon LRU that are not in
the swap cache, and hence are not reclaimable, unlike pages in the
file LRU, which should mostly be reclaimable.

So what I am saying is that maybe we should not do the effort of
scanning the anon LRU in the swapcache_only case unless there aren't a
lot of pages to reclaim on the file LRU (relatively). For example, if
we have a 100 pages in the swap cache out of 10000 pages in the anon
LRU, and there are 10000 pages in the file LRU, it's probably not
worth scanning the anon LRU.
