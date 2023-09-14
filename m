Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BB77A0124
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbjINKDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237747AbjINKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:03:47 -0400
Received: from outbound-smtp55.blacknight.com (outbound-smtp55.blacknight.com [46.22.136.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49881BE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:03:42 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id ECF89FAC41
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 11:03:40 +0100 (IST)
Received: (qmail 9226 invoked from network); 14 Sep 2023 10:03:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Sep 2023 10:03:40 -0000
Date:   Thu, 14 Sep 2023 11:03:39 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] mm: page_alloc: fix move_freepages_block() range
 error
Message-ID: <20230914100339.3dhgvsc6aprb5bbx@techsingularity.net>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-5-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230911195023.247694-5-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:41:45PM -0400, Johannes Weiner wrote:
> When a block is partially outside the zone of the cursor page, the
> function cuts the range to the pivot page instead of the zone
> start. This can leave large parts of the block behind, which
> encourages incompatible page mixing down the line (ask for one type,
> get another), and thus long-term fragmentation.
> 
> This triggers reliably on the first block in the DMA zone, whose
> start_pfn is 1. The block is stolen, but everything before the pivot
> page (which was often hundreds of pages) is left on the old list.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Oops

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
