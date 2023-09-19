Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07607A6B35
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjISTLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjISTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:11:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853EB3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4nrO/ONzDiDjbB4Tp6jWWkgieHtxH3014RZB5SX0WLY=; b=hO7wWlcs8QuM6DoAp8Aa7x/kFe
        hxu/nj9/XV9ym8a7p1I8Min8oeeQwO0o4pbdbJh8djcmo7u6p36os4wA5WnAY/d/254g0n3AtSsah
        xKaokJ5YxuzR113Yx8kBvJ3Dk+T0KTcEogunvt7PqZzi5mzTkK/MoVKNbycjybm4MK4fNvCRfnH9S
        MoCL+mKr6Jpih3tkq8SBcIBHCvG0rxPmjwdZtpXXRDpnWkq5d0RaZPZxHcz13gNEIqSl1YfrWLBVr
        a9aZGXJu37TiG+z/w3pNTiZHpGRqYAYN4xLOSCgrEwV9G9D+b2N8htijJEXXnunCXTg17vHqZmChs
        3aNqT9EA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qig7t-00DpGW-1O;
        Tue, 19 Sep 2023 19:11:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89E5D300585; Tue, 19 Sep 2023 21:11:14 +0200 (CEST)
Date:   Tue, 19 Sep 2023 21:11:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, rppt@kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>,
        kernel test robot <oliver.sang@intel.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [RFC PATCH V1 0/6] sched/numa: Enhance disjoint VMA scanning
Message-ID: <20230919191114.GB424@noisy.programming.kicks-ass.net>
References: <cover.1693287931.git.raghavendra.kt@amd.com>
 <20230919092830.GF21729@noisy.programming.kicks-ass.net>
 <20230919162215.2cszdylo2skevnr6@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919162215.2cszdylo2skevnr6@suse.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 05:22:15PM +0100, Mel Gorman wrote:

> I've been trying my best to find the necessary time and it's still on my
> radar for this week. 

OK, no hurry! Take your time.
