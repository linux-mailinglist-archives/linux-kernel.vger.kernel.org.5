Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCE7771D49
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHGJmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHGJmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:42:17 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F310C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 02:42:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VpEKeuw_1691401328;
Received: from 30.97.48.53(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VpEKeuw_1691401328)
          by smtp.aliyun-inc.com;
          Mon, 07 Aug 2023 17:42:09 +0800
Message-ID: <7d687e10-32a8-1404-e714-4c6784e45f99@linux.alibaba.com>
Date:   Mon, 7 Aug 2023 17:42:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/8] mm/compaction: correct comment of
 fast_find_migrateblock in isolate_migratepages
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com
References: <20230804110454.2935878-1-shikemeng@huaweicloud.com>
 <20230804110454.2935878-5-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230804110454.2935878-5-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2023 7:04 PM, Kemeng Shi wrote:
> After 90ed667c03fe5 ("Revert "Revert "mm/compaction: fix set skip in
> fast_find_migrateblock"""), we remove skip set in fast_find_migrateblock.
> Correct comment that fast_find_block is used to avoid isolation_suitable
> check for pageblock returned from fast_find_migrateblock because
> fast_find_migrateblock will mark found pageblock skipped.
> Instead, comment that fast_find_block is used to avoid a redundant check
> of fast found pageblock which is already checked skip flag inside
> fast_find_migrateblock.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 9a2f0bd5394a..4bf2dc936add 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1988,9 +1988,9 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>   		block_start_pfn = cc->zone->zone_start_pfn;
>   
>   	/*
> -	 * fast_find_migrateblock marks a pageblock skipped so to avoid
> -	 * the isolation_suitable check below, check whether the fast
> -	 * search was successful.
> +	 * fast_find_migrateblock() has already ensured the pageblock is not
> +	 * set with a skipped flag, so to avoid the isolation_suitable check
> +	 * below again, check whether the fast search was successful.
>   	 */
>   	fast_find_block = low_pfn != cc->migrate_pfn && !cc->fast_search_fail;
>   
