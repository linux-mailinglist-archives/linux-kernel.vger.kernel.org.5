Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4ED7CF874
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345522AbjJSMLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjJSMLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:11:23 -0400
Received: from outbound-smtp43.blacknight.com (outbound-smtp43.blacknight.com [46.22.139.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA40121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:11:20 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp43.blacknight.com (Postfix) with ESMTPS id CE1072041
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:11:17 +0100 (IST)
Received: (qmail 17348 invoked from network); 19 Oct 2023 12:11:17 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.199.31])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Oct 2023 12:11:17 -0000
Date:   Thu, 19 Oct 2023 13:11:15 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH -V3 2/9] cacheinfo: calculate size of per-CPU data cache
 slice
Message-ID: <20231019121115.mwm6eroigcrr6bi4@techsingularity.net>
References: <20231016053002.756205-1-ying.huang@intel.com>
 <20231016053002.756205-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20231016053002.756205-3-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 01:29:55PM +0800, Huang Ying wrote:
> This can be used to estimate the size of the data cache slice that can
> be used by one CPU under ideal circumstances.  Both DATA caches and
> UNIFIED caches are used in calculation.  So, the users need to consider
> the impact of the code cache usage.
> 
> Because the cache inclusive/non-inclusive information isn't available
> now, we just use the size of the per-CPU slice of LLC to make the
> result more predictable across architectures.  This may be improved
> when more cache information is available in the future.
> 
> A brute-force algorithm to iterate all online CPUs is used to avoid
> to allocate an extra cpumask, especially in offline callback.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
