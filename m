Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DA37FACE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjK0V47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjK0V45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:56:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA846BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:57:03 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54b18c9b21bso3250450a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701122222; x=1701727022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0MzoXczE2pvdHgF1zgI5abaXqlolYZSijKABG1fsdo=;
        b=rsDPBhCajJDoYdYzuuGIjoQnbm3K2sFJ6429HQPVu3l0rGpEJY8MsLwn2B7+y31s6z
         opz2jt2Yw0gKuF6N5ncaSEOB6m+Dbn2f2LJK2eYPK/I/3NePkjqlYO46qd4fr5A8KNEh
         MxFaSi1X0FUx3GJkLd1VD5CVwaggO0qYOERVy9EvCav8g3ApKGi41XjIPK+1LPot3KbC
         DApz+LYWbD6T6ihqqsF3yfXuuMl+yQKHezracRlHXupSZCpA3JcRLWpCnGdXDJ6B6c8E
         TjRJFEjqHgsFNvN0kmenHL+y+BkYCmt28EsddtUWxBG/plTjb7kZ22tk4LnfrdVDCfvc
         ca6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122222; x=1701727022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0MzoXczE2pvdHgF1zgI5abaXqlolYZSijKABG1fsdo=;
        b=bilEu9rLXVvANVVGz/5ZYP0ljzFXgkZXOBpWh766hLktUPEDAXhODr85i0qlmnYPZ4
         uc1EwOZ09YIVzb3cJGgelOjV7IWRw1mHG6nUnJ2qXCVLycLH9mjpDpfO/77p/avcIH0H
         AmnxrcbJtDSADyp7dZr7NQIvhPdGgX3u6V90A9spLGwMZTff66lGXmytataaUTUEuQr4
         m41qjHoSdDQWK3BJqaDhHlBvPVpM2bMaejUZ4b3pZJ2sP9VMUQJXZKI/s2UkuTDLU32N
         8FxQJ3mM7zs2NpmpUlfCWyX8kuXfd81H7ud9YF1zRkskNIDhAVf4+zO924BvJj/kNi50
         dQxw==
X-Gm-Message-State: AOJu0YzwfVo9mLvTzZFth3ioAYt0WKUUscZiYUldRX0WVrNBEjDnDehg
        umW/5sxfRWJsWbQnjhcDZCIJKgXO0zcE0CNsMSp4kg==
X-Google-Smtp-Source: AGHT+IFT8GxbfU4ZjoWoqPk91lBLeABCByto7q81DYaCAPE6XdtZ49BCKB7mSrmDLBE/kVkErqEaO1yWce9SgUqIchQ=
X-Received: by 2002:a17:906:1083:b0:a09:e7bf:127a with SMTP id
 u3-20020a170906108300b00a09e7bf127amr7840196eju.67.1701122222013; Mon, 27 Nov
 2023 13:57:02 -0800 (PST)
MIME-Version: 1.0
References: <ZV3BWZ4ZaD5Rj_HS@tiehlicka> <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka> <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka> <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
 <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
 <ZWUKziMl6cFV2uWN@google.com>
In-Reply-To: <ZWUKziMl6cFV2uWN@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Nov 2023 13:56:26 -0800
Message-ID: <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no swap space
To:     Minchan Kim <minchan@kernel.org>
Cc:     Chris Li <chriscli@google.com>,
        "Huang, Ying" <ying.huang@intel.com>,
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

On Mon, Nov 27, 2023 at 1:32=E2=80=AFPM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
> > On Mon, Nov 27, 2023 at 12:14=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
> > > >  I agree with Ying that anonymous pages typically have different pa=
ge
> > > > access patterns than file pages, so we might want to treat them
> > > > differently to reclaim them effectively.
> > > > One random idea:
> > > > How about we put the anonymous page in a swap cache in a different =
LRU
> > > > than the rest of the anonymous pages. Then shrinking against those
> > > > pages in the swap cache would be more effective.Instead of having
> > > > [anon, file] LRU, now we have [anon not in swap cache, anon in swap
> > > > cache, file] LRU
> > >
> > > I don't think that it is necessary.  The patch is only for a special =
use
> > > case.  Where the swap device is used up while some pages are in swap
> > > cache.  The patch will kill performance, but it is used to avoid OOM
> > > only, not to improve performance.  Per my understanding, we will not =
use
> > > up swap device space in most cases.  This may be true for ZRAM, but w=
ill
> > > we keep pages in swap cache for long when we use ZRAM?
> >
> > I ask the question regarding how many pages can be freed by this patch
> > in this email thread as well, but haven't got the answer from the
> > author yet. That is one important aspect to evaluate how valuable is
> > that patch.
>
> Exactly. Since swap cache has different life time with page cache, they
> would be usually dropped when pages are unmapped(unless they are shared
> with others but anon is usually exclusive private) so I wonder how much
> memory we can save.

I think the point of this patch is not saving memory, but rather
avoiding an OOM condition that will happen if we have no swap space
left, but some pages left in the swap cache. Of course, the OOM
avoidance will come at the cost of extra work in reclaim to swap those
pages out.

The only case where I think this might be harmful is if there's plenty
of pages to reclaim on the file LRU, and instead we opt to chase down
the few swap cache pages. So perhaps we can add a check to only set
sc->swapcache_only if the number of pages in the swap cache is more
than the number of pages on the file LRU or similar? Just make sure we
don't chase the swapcache pages down if there's plenty to scan on the
file LRU?

>
> > Regarding running out of swap space. That is a good point, in server
> > workload we don't typically run out of swap device space anyway.
> >
> > Android uses ZRAM, the story might be different. Adding Minchan here.
>
> Swap is usually almost full in Android since it compacts(i.e., swapout)
> background apps aggressively.
