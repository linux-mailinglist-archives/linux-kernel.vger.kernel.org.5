Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6953A7FAC90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjK0Vb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0Vbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:31:55 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA238101
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:32:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso3753063b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701120721; x=1701725521; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01/TtnGunSRoNeQivqkO3yp5gEABKRtIPv7V4mD6Leg=;
        b=G7r9BuoKe5uH1VVgO33xAYale+5Zu1z3Rx8psVbVkUAc9wZcRe96neF0HgnFSGluJf
         96cdqG+fZefjH5qMyOaLl9uB60CyGRY3k+EsyMh8TWHu/YrRF7o3pS5Jxgm8IfrtqG20
         v4PkbYv1VO1QY47x/ok207mh1utFr6Nd8l+iMGHwpj0ljQRMarTZOcNDXmxIbX/ohWDE
         yvh3L+AlKCMtsQAw+TMNwjXKuLxW9CvnGVbvvnvEbjvk7vSwJrDJtNR6Re7Yimloyy46
         LZrItCD3D0LS0DUW6OoNrTghvv10IIiWhW0OBUGYMqoZATBxyO8OV2B/WpRu1vvMyQF1
         KU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701120721; x=1701725521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01/TtnGunSRoNeQivqkO3yp5gEABKRtIPv7V4mD6Leg=;
        b=nnEwJBgSRznLbfWubLblRdXFntYwIWqGPEdAZM/HegFcExWk+gN8/q4e+tWQPGOvEl
         CsVsZ+sSAsJHA76jhHn15PkRABhB4rPzcwi3nyxx9bvl1oDWLl/SMJ+Fy7wfDqT7xN/k
         hGG1zcQnim9Fhdq/zyk2bMrS8r7nV4/NKSSHtlgZrE4IrNYRd39CjRxfw+OaXcDMj6wf
         PUS/3bx00CiAiBUXg1JFtHxp82lmCd7qRrLL1s9N66lVcdOW/mFDfvuGDmxQOL1tPL8H
         332MpnYL6E+a/hkZ1DqVe8SA0C999u424YmflbH8wth/00FehSztZ0AXSLx3Z0NtMu51
         SS8Q==
X-Gm-Message-State: AOJu0YyS549Htu+dz09lcVrG64/X5qJyxtgS+/i+GX8YThSH/Wqe3HWX
        fY5GGUl1y9wZDN0WuuuejdY=
X-Google-Smtp-Source: AGHT+IEFYl+6KKsimxSvgft+inPv0eWS+fc/a1z5KjjOVU6stzEhEqtiE6ubO4hduUvwWHuMnV+TTg==
X-Received: by 2002:a05:6a20:4419:b0:187:4ee0:e95e with SMTP id ce25-20020a056a20441900b001874ee0e95emr15332849pzb.52.1701120721242;
        Mon, 27 Nov 2023 13:32:01 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:393c:1828:9438:b99d])
        by smtp.gmail.com with ESMTPSA id 37-20020a631365000000b005b8ea15c338sm8104364pgt.62.2023.11.27.13.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:32:00 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 27 Nov 2023 13:31:58 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Li <chriscli@google.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
Message-ID: <ZWUKziMl6cFV2uWN@google.com>
References: <ZV3BWZ4ZaD5Rj_HS@tiehlicka>
 <ZV3TQCElHpcp0h0V@tiehlicka>
 <CAJD7tka0=JR1s0OzQ0+H8ksFhvB2aBHXx_2-hVc97Enah9DqGQ@mail.gmail.com>
 <ZV3_6UH28KMt0ZDb@tiehlicka>
 <87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZWDPuR5Ssx07nBHb@tiehlicka>
 <87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuOcMDpqZV+9+QjK-hsoJLGhoBzBOczAc7+UMypVJresSw@mail.gmail.com>
 <87bkbf7gz6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8kJuNKH_vcF-=6nw3zP5cMaZHLudHZfxNDtHm0K2BXJ+EAgA@mail.gmail.com>
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

On Mon, Nov 27, 2023 at 12:22:59AM -0800, Chris Li wrote:
> On Mon, Nov 27, 2023 at 12:14 AM Huang, Ying <ying.huang@intel.com> wrote:
> > >  I agree with Ying that anonymous pages typically have different page
> > > access patterns than file pages, so we might want to treat them
> > > differently to reclaim them effectively.
> > > One random idea:
> > > How about we put the anonymous page in a swap cache in a different LRU
> > > than the rest of the anonymous pages. Then shrinking against those
> > > pages in the swap cache would be more effective.Instead of having
> > > [anon, file] LRU, now we have [anon not in swap cache, anon in swap
> > > cache, file] LRU
> >
> > I don't think that it is necessary.  The patch is only for a special use
> > case.  Where the swap device is used up while some pages are in swap
> > cache.  The patch will kill performance, but it is used to avoid OOM
> > only, not to improve performance.  Per my understanding, we will not use
> > up swap device space in most cases.  This may be true for ZRAM, but will
> > we keep pages in swap cache for long when we use ZRAM?
> 
> I ask the question regarding how many pages can be freed by this patch
> in this email thread as well, but haven't got the answer from the
> author yet. That is one important aspect to evaluate how valuable is
> that patch.

Exactly. Since swap cache has different life time with page cache, they
would be usually dropped when pages are unmapped(unless they are shared
with others but anon is usually exclusive private) so I wonder how much
memory we can save.

> Regarding running out of swap space. That is a good point, in server
> workload we don't typically run out of swap device space anyway.
> 
> Android uses ZRAM, the story might be different. Adding Minchan here.

Swap is usually almost full in Android since it compacts(i.e., swapout)
background apps aggressively.
