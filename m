Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5300C7828E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjHUMV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbjHUMV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:21:28 -0400
Received: from outbound-smtp23.blacknight.com (outbound-smtp23.blacknight.com [81.17.249.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C926CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:21:26 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 98A5EBEFD9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:21:24 +0100 (IST)
Received: (qmail 31679 invoked from network); 21 Aug 2023 12:21:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Aug 2023 12:21:24 -0000
Date:   Mon, 21 Aug 2023 13:21:02 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, willy@infradead.org
Subject: Re: [PATCH 2/2] mm/page_alloc: use get_pfnblock_migratetype to avoid
 extra page_to_pfn
Message-ID: <20230821122102.uybh63ifycgmqm3a@techsingularity.net>
References: <20230811115945.3423894-1-shikemeng@huaweicloud.com>
 <20230811115945.3423894-3-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230811115945.3423894-3-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:59:45PM +0800, Kemeng Shi wrote:
> We have get_pageblock_migratetype and get_pfnblock_migratetype to get
> migratetype of page. get_pfnblock_migratetype accepts both page and pfn
> from caller while get_pageblock_migratetype only accept page and get pfn
> with page_to_pfn from page.
> In case we already record pfn of page, we can simply call
> get_pfnblock_migratetype to avoid a page_to_pfn.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
