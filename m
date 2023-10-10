Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E477C0065
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjJJPbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjJJPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:31:31 -0400
Received: from outbound-smtp05.blacknight.com (outbound-smtp05.blacknight.com [81.17.249.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77834B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:31:27 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp05.blacknight.com (Postfix) with ESMTPS id 60FFFCCF95
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:31:25 +0100 (IST)
Received: (qmail 9382 invoked from network); 10 Oct 2023 15:31:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Oct 2023 15:31:25 -0000
Date:   Tue, 10 Oct 2023 16:31:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] bounds: Support non-power-of-two CONFIG_NR_CPUS
Message-ID: <20231010153122.iqdv5ezmrjowug53@techsingularity.net>
References: <20231010145549.1244748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20231010145549.1244748-1-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:55:49PM +0100, Matthew Wilcox (Oracle) wrote:
> ilog2() rounds down, so for example when PowerPC 85xx sets CONFIG_NR_CPUS
> to 24, we will only allocate 4 bits to store the number of CPUs instead
> of 5.  Use bits_per() instead, which rounds up.  Found by code inspection.
> The effect of this would probably be a misaccounting when doing NUMA
> balancing, so to a user, it would only be a performance penalty.
> The effects may be more wide-spread; it's hard to tell.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 90572890d202 ("mm: numa: Change page last {nid,pid} into {cpu,pid}")
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Rik van Riel <riel@surriel.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
