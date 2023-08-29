Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1784178C847
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjH2PF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbjH2PFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:05:30 -0400
Received: from outbound-smtp39.blacknight.com (outbound-smtp39.blacknight.com [46.22.139.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C6D7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:05:27 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp39.blacknight.com (Postfix) with ESMTPS id 96FBB1B24
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:05:26 +0100 (IST)
Received: (qmail 20754 invoked from network); 29 Aug 2023 15:05:26 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Aug 2023 15:05:26 -0000
Date:   Tue, 29 Aug 2023 16:05:23 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, willy@infradead.org
Subject: Re: [PATCH v2 5/7] mm/compaction: remove repeat
 compact_blockskip_flush check in reset_isolation_suitable
Message-ID: <20230829150523.ktn6ktdtl7n22akp@techsingularity.net>
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-6-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230826153617.4019189-6-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 11:36:15PM +0800, Kemeng Shi wrote:
> We have compact_blockskip_flush check in __reset_isolation_suitable, just
> remove repeat check before __reset_isolation_suitable in
> compact_blockskip_flush.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

The comment should move to __reset_isolation_suitable but otherwise

Acked-by: Mel Gorman <mgorman@techsingularity.net>

As a complete aside, the reset_isolation_suitable and
__reset_isolation_suitable were badly named because locking is not
involved but it's meaningless churn to fix it.

-- 
Mel Gorman
SUSE Labs
