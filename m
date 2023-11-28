Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA427FC99E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346709AbjK1Wha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344653AbjK1Wh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:37:28 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B91998
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:37:33 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c398717726so5138842b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701211053; x=1701815853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A2AafIo5QVv/abJyPMu6Yqz0MbRVWfdchikKuUJez54=;
        b=RP3zeivu/gmiDVIvkcCDfyAJNHmYr/+5LYfLHUSPk5NHvtkxJpGZ9tC8zFGZdV50nP
         zD14LYVW2jd8iqEgHhsUDQ7hFDFZ29OzZl5bB4Plw4Ou9fUUi2Coskpsla7PYCahV6SM
         R2Fl9aTsM28psnNjPsjDGzVDnyApOzzyi2H55ch+U0YoUKLffwcOpOzrXyGAmrEqNNmb
         hoNXpbs+tuytg7L5AdcDbKnfs10aBILqaUU6mW564TObQfXhuGWwfF/fx43g6Isimcd8
         v0iKATzLzuZ+Ly//rJSDaH3JEVWPd2snhy5DYPK48N86BHWgSVYOCAP6agtcCQqi9sNe
         mG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211053; x=1701815853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2AafIo5QVv/abJyPMu6Yqz0MbRVWfdchikKuUJez54=;
        b=ezSeaFy/BqdIYT6hayPn1ciIDLHUFynkRONqXUaz5qooqnt2XjbfJ4cBLwiaYzXQMu
         3+E8Wtd9kI8zFyW49L436sgJdUlLCoiWfeK6MRws49gRAGYPNeHeffteDtGGHE72yz5p
         yPbFSn4A+1GFN4s1eRDfDIFM9GYz+GvbBew6uSgSO+yDe+7wkO81s08Qrnmlmx1QsLLM
         yrkKUnXvkndS77e2sjJvYtfVhpewa7M7UgAGdU/6VGqfz+cRQzO6+IDBgynsc/BPhPrH
         qquuac08M9Xx6Wc7gzSG8EaTY6Qdlkn2NGbvNGjCNvJWF13BHRleKACEUR88wDuPBFGG
         xKdw==
X-Gm-Message-State: AOJu0YzoTBrRHzL/AbhivGoMjcqSQpndFa9ciMgNhdpp+7sPeWQdHtCJ
        EHeLqRkXG4A7S/v4dgOT1kI=
X-Google-Smtp-Source: AGHT+IF5LKYG5wWLL23x6Qo8kVxiGHz9+o5SWD7Gsfczr/JsiHvaa/wL1My767AMj+AHMfmdtL1GLQ==
X-Received: by 2002:a05:6a00:3989:b0:6c3:1b90:8552 with SMTP id fi9-20020a056a00398900b006c31b908552mr17819915pfb.17.1701211052890;
        Tue, 28 Nov 2023 14:37:32 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:8fd0:78d2:c604:3ac8])
        by smtp.gmail.com with ESMTPSA id t20-20020aa79394000000b006cdc6b9f0ecsm263540pfe.81.2023.11.28.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:37:31 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 28 Nov 2023 14:37:28 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Chris Li <chriscli@google.com>, Michal Hocko <mhocko@suse.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZWZrqFC-Wc92UBou@google.com>
References: <ZV3_6UH28KMt0ZDb@tiehlicka>
 <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka>
 <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
 <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
 <ZWUKziMl6cFV2uWN@google.com>
 <CAJD7tkZNa_3mWYeix_Xc-BFRNVMkBF3uzL0JCkZOYw5ubAaj9w@mail.gmail.com>
 <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msuy5zuv.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 11:19:20AM +0800, Huang, Ying wrote:
> Yosry Ahmed <yosryahmed@google.com> writes:
> 
> > On Mon, Nov 27, 2023 at 1:32 PM Minchan Kim <minchan@kernel.org> wrote:
> >>
> >> On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
> >> > On Mon, Nov 27, 2023 at 12:14 AM Huang, Ying <ying.huang@intel.com> wrote:
> >> > > >  I agree with Ying that anonymous pages typically have different page
> >> > > > access patterns than file pages, so we might want to treat them
> >> > > > differently to reclaim them effectively.
> >> > > > One random idea:
> >> > > > How about we put the anonymous page in a swap cache in a different LRU
> >> > > > than the rest of the anonymous pages. Then shrinking against those
> >> > > > pages in the swap cache would be more effective.Instead of having
> >> > > > [anon, file] LRU, now we have [anon not in swap cache, anon in swap
> >> > > > cache, file] LRU
> >> > >
> >> > > I don't think that it is necessary.  The patch is only for a special use
> >> > > case.  Where the swap device is used up while some pages are in swap
> >> > > cache.  The patch will kill performance, but it is used to avoid OOM
> >> > > only, not to improve performance.  Per my understanding, we will not use
> >> > > up swap device space in most cases.  This may be true for ZRAM, but will
> >> > > we keep pages in swap cache for long when we use ZRAM?
> >> >
> >> > I ask the question regarding how many pages can be freed by this patch
> >> > in this email thread as well, but haven't got the answer from the
> >> > author yet. That is one important aspect to evaluate how valuable is
> >> > that patch.
> >>
> >> Exactly. Since swap cache has different life time with page cache, they
> >> would be usually dropped when pages are unmapped(unless they are shared
> >> with others but anon is usually exclusive private) so I wonder how much
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

Yeah, that's common for asynchronous swap devices and that's popular. Then,
How about freeing those memory as soon as the writeback is done instead of
keep adding more tricks to solve the issue?

https://lkml.kernel.org/linux-mm/1368411048-3753-1-git-send-email-minchan@kernel.org/

I remember it's under softIRQ context so there were some issues to change
locking rules for memcg and swap. And there was some concern to increase
softirq latency due to page freeing but both were not the main obstacle to
be fixed.

> 
> Group 2 are hard to be reclaimed if swap_count() isn't 0.

"were accessed before reclaiming" would be rare.

> 
> Group 3 should be reclaimed in theory, but the overhead may be high.
> And we may need to reclaim the swap entries instead of pages if the pages
> are hot.  But we can start to reclaim the swap entries before the swap
> space is run out.

I thought the swap-in path will reclaim the swap slots once it detects
swapspace wasn't enough(e.g., vm_swap_full or mem_cgroup_swap-full)?

> 
> So, if we can count group 1, we may use that as indicator to scan anon
> pages.  And we may add code to reclaim group 3 earlier.
