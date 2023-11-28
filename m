Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D158C7FB166
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343553AbjK1Fmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 00:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1Fm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 00:42:29 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC84CC4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:42:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a02ba1f500fso719335866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 21:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701150153; x=1701754953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q5Ao6kkaSp6ntRr5jYTJ0UF0vBlRA6OurkdKyp1VkQ=;
        b=aAMuUkOchABJYb6Q0bDMA7m8QZWvNRiYeVA3AQ8ex7sK8kM9KXGU2+FiKPl/wO7nCu
         bcM/Ronm0E1VOxP7Ft2vp/fZ2VYYRNPWPigLTUYOM8as7Fxuks9+gBdAlsVzWfu2fFvb
         EkhbxP4E3CyO6WKN4cxqGveDBgzHtC/YRXYhkj0ghJc0yNpFdb0sIRXKBaDV3ugp/u0l
         z0rCGx85CKsFzpJTwpxunoFirJ7XFxNogAhDKTIlTK8f1eQfj35xPnHCUJnUYvrDa2aZ
         KTc+XbzqbVc6sTbycm/oqz3A8uMcjV9iItmLDAQPUfkEEcuFi88B4m2rp+nnS51Km86G
         AuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701150153; x=1701754953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/q5Ao6kkaSp6ntRr5jYTJ0UF0vBlRA6OurkdKyp1VkQ=;
        b=OHZZI2nvIryqrTEDrmuIfFJbT+k71dQWcQ3jDWAuYudDlnHKIaw9Nhx5KoyteNK0eY
         OXatLjffqOP2TtmBV6r6IMzYRbLb8Z1BfKViqfumHCsFg0Z8JRRNVttmPATd5ZMsidWy
         VKG27xjQCu+BzU/X6YHKa0PWjWYUXhVys/BvgbLGmPDh5N7fuH2uEyCYJ6MpvQLBMTns
         NdHOkW4QZwoOCTzvnN69Y6Zwr6Xe9B2Q/UzDhgb/IWYrPcLGPUY416NJLWEVsF7Z+RTE
         tKFH7xIdMgOTXhfvLQH4pKzrzzlRBt+xRw7/uH3fwPlFv73laSvM7OusnBfUYzKBRG2t
         Ho5w==
X-Gm-Message-State: AOJu0YzCZ6zythwObpQ0g8jrYijGrbyAP9CxJ21bK5fvsvewV2DpBAKV
        9KSAMhnEpkor/u/pt27tjr9xc0FBB3To/BbCir59sg==
X-Google-Smtp-Source: AGHT+IGG9T6aRbPaRWTVnBmWs0xDlUd+awySyMmO96LVP9S96Rltx1iOrej1rIz/glTs0p1wejc1wrNoThvjnBG9w+Q=
X-Received: by 2002:a17:906:eb17:b0:a03:6fd8:f14b with SMTP id
 mb23-20020a170906eb1700b00a036fd8f14bmr10117355ejb.28.1701150153208; Mon, 27
 Nov 2023 21:42:33 -0800 (PST)
MIME-Version: 1.0
References: <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka> <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka> <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
 <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
 <ZWUKziMl6cFV2uWN@google.com> <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
 <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkZmyzohNRqgvZvZC5L7OFHzDRm-Y3JEQHiDYcwTCz-FBQ@mail.gmail.com>
 <87fs0q5xsq.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAJD7tkZKS=1BSoaCnF5wkto5z3-_sx=6GSVqdhXz=Dcw_-C3BA@mail.gmail.com>
 <87bkbe5tha.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87bkbe5tha.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Nov 2023 21:41:54 -0800
Message-ID: <CAJD7tkbgPo1_Gij+EL==tedRh=nJe_etuZors-6Y-obYu44FMQ@mail.gmail.com>
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

On Mon, Nov 27, 2023 at 9:39=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Yosry Ahmed <yosryahmed@google.com> writes:
>
> > On Mon, Nov 27, 2023 at 8:05=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Yosry Ahmed <yosryahmed@google.com> writes:
> >>
> >> > On Mon, Nov 27, 2023 at 7:21=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Yosry Ahmed <yosryahmed@google.com> writes:
> >> >>
> >> >> > On Mon, Nov 27, 2023 at 1:32=E2=80=AFPM Minchan Kim <minchan@kern=
el.org> wrote:
> >> >> >>
> >> >> >> On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
> >> >> >> > On Mon, Nov 27, 2023 at 12:14=E2=80=AFAM Huang, Ying <ying.hua=
ng@intel.com> wrote:
> >> >> >> > > >  I agree with Ying that anonymous pages typically have dif=
ferent page
> >> >> >> > > > access patterns than file pages, so we might want to treat=
 them
> >> >> >> > > > differently to reclaim them effectively.
> >> >> >> > > > One random idea:
> >> >> >> > > > How about we put the anonymous page in a swap cache in a d=
ifferent LRU
> >> >> >> > > > than the rest of the anonymous pages. Then shrinking again=
st those
> >> >> >> > > > pages in the swap cache would be more effective.Instead of=
 having
> >> >> >> > > > [anon, file] LRU, now we have [anon not in swap cache, ano=
n in swap
> >> >> >> > > > cache, file] LRU
> >> >> >> > >
> >> >> >> > > I don't think that it is necessary.  The patch is only for a=
 special use
> >> >> >> > > case.  Where the swap device is used up while some pages are=
 in swap
> >> >> >> > > cache.  The patch will kill performance, but it is used to a=
void OOM
> >> >> >> > > only, not to improve performance.  Per my understanding, we =
will not use
> >> >> >> > > up swap device space in most cases.  This may be true for ZR=
AM, but will
> >> >> >> > > we keep pages in swap cache for long when we use ZRAM?
> >> >> >> >
> >> >> >> > I ask the question regarding how many pages can be freed by th=
is patch
> >> >> >> > in this email thread as well, but haven't got the answer from =
the
> >> >> >> > author yet. That is one important aspect to evaluate how valua=
ble is
> >> >> >> > that patch.
> >> >> >>
> >> >> >> Exactly. Since swap cache has different life time with page cach=
e, they
> >> >> >> would be usually dropped when pages are unmapped(unless they are=
 shared
> >> >> >> with others but anon is usually exclusive private) so I wonder h=
ow much
> >> >> >> memory we can save.
> >> >> >
> >> >> > I think the point of this patch is not saving memory, but rather
> >> >> > avoiding an OOM condition that will happen if we have no swap spa=
ce
> >> >> > left, but some pages left in the swap cache. Of course, the OOM
> >> >> > avoidance will come at the cost of extra work in reclaim to swap =
those
> >> >> > pages out.
> >> >> >
> >> >> > The only case where I think this might be harmful is if there's p=
lenty
> >> >> > of pages to reclaim on the file LRU, and instead we opt to chase =
down
> >> >> > the few swap cache pages. So perhaps we can add a check to only s=
et
> >> >> > sc->swapcache_only if the number of pages in the swap cache is mo=
re
> >> >> > than the number of pages on the file LRU or similar? Just make su=
re we
> >> >> > don't chase the swapcache pages down if there's plenty to scan on=
 the
> >> >> > file LRU?
> >> >>
> >> >> The swap cache pages can be divided to 3 groups.
> >> >>
> >> >> - group 1: pages have been written out, at the tail of inactive LRU=
, but
> >> >>   not reclaimed yet.
> >> >>
> >> >> - group 2: pages have been written out, but were failed to be recla=
imed
> >> >>   (e.g., were accessed before reclaiming)
> >> >>
> >> >> - group 3: pages have been swapped in, but were kept in swap cache.=
  The
> >> >>   pages may be in active LRU.
> >> >>
> >> >> The main target of the original patch should be group 1.  And the p=
ages
> >> >> may be cheaper to reclaim than file pages.
> >> >>
> >> >> Group 2 are hard to be reclaimed if swap_count() isn't 0.
> >> >>
> >> >> Group 3 should be reclaimed in theory, but the overhead may be high=
.
> >> >> And we may need to reclaim the swap entries instead of pages if the=
 pages
> >> >> are hot.  But we can start to reclaim the swap entries before the s=
wap
> >> >> space is run out.
> >> >>
> >> >> So, if we can count group 1, we may use that as indicator to scan a=
non
> >> >> pages.  And we may add code to reclaim group 3 earlier.
> >> >>
> >> >
> >> > My point was not that reclaiming the pages in the swap cache is more
> >> > expensive that reclaiming the pages in the file LRU. In a lot of
> >> > cases, as you point out, the pages in the swap cache can just be
> >> > dropped, so they may be as cheap or cheaper to reclaim than the page=
s
> >> > in the file LRU.
> >> >
> >> > My point was that scanning the anon LRU when swap space is exhausted
> >> > to get to the pages in the swap cache may be much more expensive,
> >> > because there may be a lot of pages on the anon LRU that are not in
> >> > the swap cache, and hence are not reclaimable, unlike pages in the
> >> > file LRU, which should mostly be reclaimable.
> >> >
> >> > So what I am saying is that maybe we should not do the effort of
> >> > scanning the anon LRU in the swapcache_only case unless there aren't=
 a
> >> > lot of pages to reclaim on the file LRU (relatively). For example, i=
f
> >> > we have a 100 pages in the swap cache out of 10000 pages in the anon
> >> > LRU, and there are 10000 pages in the file LRU, it's probably not
> >> > worth scanning the anon LRU.
> >>
> >> For group 1 pages, they are at the tail of the anon inactive LRU, so t=
he
> >> scan overhead is low too.  For example, if number of group 1 pages is
> >> 100, we just need to scan 100 pages to reclaim them.  We can choose to
> >> stop scanning when the number of the non-group-1 pages reached some
> >> threshold.
> >>
> >
> > We should still try to reclaim pages in groups 2 & 3 before OOMing
> > though. Maybe the motivation for this patch is group 1, but I don't
> > see why we should special case them. Pages in groups 2 & 3 should be
> > roughly equally cheap to reclaim. They may have higher refault cost,
> > but IIUC we should still try to reclaim them before OOMing.
>
> The scan cost of group 3 may be high, you may need to scan all anonymous
> pages to identify them.  The reclaim cost of group 2 may be high, it may
> just cause trashing (shared pages that are accessed by just one
> process).  So I think that we can allow reclaim group 1 in all cases.
> Try to reclaim swap entries for group 3 during normal LRU scanning after
> more than half of swap space of limit is used.  As a last resort before
> OOM, try to reclaim group 2 and group 3.  Or, limit scan count for group
> 2 and group 3.

It would be nice if this can be done auto-magically without having to
keep track of the groups separately.

>
> BTW, in some situation, OOM is not the worst situation.  For example,
> trashing may kill interaction latency, while killing the memory hog (may
> be caused by memory leak) saves system response time.

I agree that in some situations OOMs are better than thrashing, it's
not an easy problem.
