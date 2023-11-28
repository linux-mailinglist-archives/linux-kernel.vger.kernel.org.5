Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0977FB0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 05:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbjK1EOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbjK1EOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:14:10 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68503E6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:14:16 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a29c7eefso6521358e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 20:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701144854; x=1701749654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPUfY3E34s0ybkWQp9ENvHW5Xeh7l+OsGOithDOSDmA=;
        b=Sa3xb4t5jbBki2E4RKJ5wRmTPCprcbAITZ36z6EkiLVNCwLYeMrAMuThn7xyUdYbOs
         SSoQws8WPbKtHcSEdIETOW2f8sufzjcwa401mnET1Rxd84GYeReWhzZdBVH6J+ezDtgF
         aX56H+p6wH1mlf+vqLI3iaI382zq88wUIcTTQiMERQFYh5sBcep1nLv4qlmwgonolisu
         8B/tYPOxNswR8gnlSqXOm68q+HXK5nAcs2FUIgpPmGEw6igHcM+GwNzg1Yja45h6fztw
         R5khNtX+wGw7KmA07Ywjh8lKpqr74sVPpRZf+NiMVT+iCXYK9sAjAivMfagaS3W0uTol
         sa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701144854; x=1701749654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPUfY3E34s0ybkWQp9ENvHW5Xeh7l+OsGOithDOSDmA=;
        b=QCrvC0O6DfML2GFb9ngjdqVhn62CRHDjLVXZL/gWQvv42OCBbJZZ1SjKxLpJClcVGs
         ITEzAETPBaYrnu1eZgZYryuvkgETVyLP2VO/4jIyMM850Ib6voBZcM2BenMXmecfwsfs
         oP3E8FEOkegfHzJrJET4OtLlDNTK1MvNKcBC5r9r0SeAJyLwNHOXBY72fMzfBYy0589s
         a2yFL6/WGvLCloR7CJC8ZpveV6SxIwDlB195eUEkNFLtvVvh0IJ0aIlXUUf2BfAZWtY2
         Tcjx51SFjqdNNPnNfcHq2m7ZCbkjh2WxMXam0RySVEKQv5cgD0d+dPkpwddGWmBxHYi4
         /PsQ==
X-Gm-Message-State: AOJu0Yzqbu8LVjNWK65Pyqyr6fOc1oNu47Dsp8dH03qmmSuVyRe0z0aH
        cQKB0F/xuB1M5enc9SeGGQiQzOPkiw7XlnmT3yV7/g==
X-Google-Smtp-Source: AGHT+IHEIv7cBGSSied89o9tUhDwnR5lkDHe4fDdCb7SnRdwwbQ2me11W50eRVokucGbM1QosN4V8YbLx/LHI9U/sMw=
X-Received: by 2002:a05:6512:3d03:b0:509:8a7e:4d0d with SMTP id
 d3-20020a0565123d0300b005098a7e4d0dmr8172857lfv.0.1701144854489; Mon, 27 Nov
 2023 20:14:14 -0800 (PST)
MIME-Version: 1.0
References: <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka> <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka> <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
 <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
 <ZWUKziMl6cFV2uWN@google.com> <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
 <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkZmyzohNRqgvZvZC5L7OFHzDRm-Y3JEQHiDYcwTCz-FBQ@mail.gmail.com>
 <87fs0q5xsq.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87fs0q5xsq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Nov 2023 20:13:38 -0800
Message-ID: <CAJD7tkZKS=1BSoaCnF5wkto5z3-_sx=6GSVqdhXz=Dcw_-C3BA@mail.gmail.com>
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

On Mon, Nov 27, 2023 at 8:05=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Mon, Nov 27, 2023 at 7:21=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Yosry Ahmed <yosryahmed@google.com> writes:
> >>
> >> > On Mon, Nov 27, 2023 at 1:32=E2=80=AFPM Minchan Kim <minchan@kernel.=
org> wrote:
> >> >>
> >> >> On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
> >> >> > On Mon, Nov 27, 2023 at 12:14=E2=80=AFAM Huang, Ying <ying.huang@=
intel.com> wrote:
> >> >> > > >  I agree with Ying that anonymous pages typically have differ=
ent page
> >> >> > > > access patterns than file pages, so we might want to treat th=
em
> >> >> > > > differently to reclaim them effectively.
> >> >> > > > One random idea:
> >> >> > > > How about we put the anonymous page in a swap cache in a diff=
erent LRU
> >> >> > > > than the rest of the anonymous pages. Then shrinking against =
those
> >> >> > > > pages in the swap cache would be more effective.Instead of ha=
ving
> >> >> > > > [anon, file] LRU, now we have [anon not in swap cache, anon i=
n swap
> >> >> > > > cache, file] LRU
> >> >> > >
> >> >> > > I don't think that it is necessary.  The patch is only for a sp=
ecial use
> >> >> > > case.  Where the swap device is used up while some pages are in=
 swap
> >> >> > > cache.  The patch will kill performance, but it is used to avoi=
d OOM
> >> >> > > only, not to improve performance.  Per my understanding, we wil=
l not use
> >> >> > > up swap device space in most cases.  This may be true for ZRAM,=
 but will
> >> >> > > we keep pages in swap cache for long when we use ZRAM?
> >> >> >
> >> >> > I ask the question regarding how many pages can be freed by this =
patch
> >> >> > in this email thread as well, but haven't got the answer from the
> >> >> > author yet. That is one important aspect to evaluate how valuable=
 is
> >> >> > that patch.
> >> >>
> >> >> Exactly. Since swap cache has different life time with page cache, =
they
> >> >> would be usually dropped when pages are unmapped(unless they are sh=
ared
> >> >> with others but anon is usually exclusive private) so I wonder how =
much
> >> >> memory we can save.
> >> >
> >> > I think the point of this patch is not saving memory, but rather
> >> > avoiding an OOM condition that will happen if we have no swap space
> >> > left, but some pages left in the swap cache. Of course, the OOM
> >> > avoidance will come at the cost of extra work in reclaim to swap tho=
se
> >> > pages out.
> >> >
> >> > The only case where I think this might be harmful is if there's plen=
ty
> >> > of pages to reclaim on the file LRU, and instead we opt to chase dow=
n
> >> > the few swap cache pages. So perhaps we can add a check to only set
> >> > sc->swapcache_only if the number of pages in the swap cache is more
> >> > than the number of pages on the file LRU or similar? Just make sure =
we
> >> > don't chase the swapcache pages down if there's plenty to scan on th=
e
> >> > file LRU?
> >>
> >> The swap cache pages can be divided to 3 groups.
> >>
> >> - group 1: pages have been written out, at the tail of inactive LRU, b=
ut
> >>   not reclaimed yet.
> >>
> >> - group 2: pages have been written out, but were failed to be reclaime=
d
> >>   (e.g., were accessed before reclaiming)
> >>
> >> - group 3: pages have been swapped in, but were kept in swap cache.  T=
he
> >>   pages may be in active LRU.
> >>
> >> The main target of the original patch should be group 1.  And the page=
s
> >> may be cheaper to reclaim than file pages.
> >>
> >> Group 2 are hard to be reclaimed if swap_count() isn't 0.
> >>
> >> Group 3 should be reclaimed in theory, but the overhead may be high.
> >> And we may need to reclaim the swap entries instead of pages if the pa=
ges
> >> are hot.  But we can start to reclaim the swap entries before the swap
> >> space is run out.
> >>
> >> So, if we can count group 1, we may use that as indicator to scan anon
> >> pages.  And we may add code to reclaim group 3 earlier.
> >>
> >
> > My point was not that reclaiming the pages in the swap cache is more
> > expensive that reclaiming the pages in the file LRU. In a lot of
> > cases, as you point out, the pages in the swap cache can just be
> > dropped, so they may be as cheap or cheaper to reclaim than the pages
> > in the file LRU.
> >
> > My point was that scanning the anon LRU when swap space is exhausted
> > to get to the pages in the swap cache may be much more expensive,
> > because there may be a lot of pages on the anon LRU that are not in
> > the swap cache, and hence are not reclaimable, unlike pages in the
> > file LRU, which should mostly be reclaimable.
> >
> > So what I am saying is that maybe we should not do the effort of
> > scanning the anon LRU in the swapcache_only case unless there aren't a
> > lot of pages to reclaim on the file LRU (relatively). For example, if
> > we have a 100 pages in the swap cache out of 10000 pages in the anon
> > LRU, and there are 10000 pages in the file LRU, it's probably not
> > worth scanning the anon LRU.
>
> For group 1 pages, they are at the tail of the anon inactive LRU, so the
> scan overhead is low too.  For example, if number of group 1 pages is
> 100, we just need to scan 100 pages to reclaim them.  We can choose to
> stop scanning when the number of the non-group-1 pages reached some
> threshold.
>

We should still try to reclaim pages in groups 2 & 3 before OOMing
though. Maybe the motivation for this patch is group 1, but I don't
see why we should special case them. Pages in groups 2 & 3 should be
roughly equally cheap to reclaim. They may have higher refault cost,
but IIUC we should still try to reclaim them before OOMing.
