Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF737828DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjHUMUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjHUMUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:20:51 -0400
Received: from outbound-smtp29.blacknight.com (outbound-smtp29.blacknight.com [81.17.249.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE9DCC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:20:48 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 008A8BEFD9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:20:46 +0100 (IST)
Received: (qmail 15072 invoked from network); 21 Aug 2023 12:20:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.20.191])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Aug 2023 12:20:46 -0000
Date:   Mon, 21 Aug 2023 13:20:42 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        david@redhat.com, willy@infradead.org
Subject: Re: [PATCH 1/2] mm/page_alloc: remove unnecessary inner
 __get_pfnblock_flags_mask
Message-ID: <20230821122042.4axbx7cg2nndvxaz@techsingularity.net>
References: <20230811115945.3423894-1-shikemeng@huaweicloud.com>
 <20230811115945.3423894-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230811115945.3423894-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:59:44PM +0800, Kemeng Shi wrote:
> Function get_pfnblock_flags_mask just calls inline inner
> __get_pfnblock_flags_mask without any extra work. Just opencode
> __get_pfnblock_flags_mask in get_pfnblock_flags_mask and replace call
> to __get_pfnblock_flags_mask with call to get_pfnblock_flags_mask to
> remove unnecessary __get_pfnblock_flags_mask.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
