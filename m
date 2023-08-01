Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A0C76A729
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjHACp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHACp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:45:26 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0E51BFD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:45:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VojMvcl_1690857906;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VojMvcl_1690857906)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:45:07 +0800
Message-ID: <726ad4b3-3f80-f32c-7a3b-7299f82b0381@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 10:45:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] mm/compaction: corret comment of cached migrate pfn
 update
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-6-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230728171037.2219226-6-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/2023 1:10 AM, Kemeng Shi wrote:
> Commit e380bebe47715 ("mm, compaction: keep migration source private to
> a single compaction instance") moved update of async and sync
> compact_cached_migrate_pfn from update_pageblock_skip to
> update_cached_migrate but left the comment behind.
> Move the relevant comment to correct this.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 09c36251c613..1eebb61a1f63 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -464,6 +464,7 @@ static void update_cached_migrate(struct compact_control *cc, unsigned long pfn)
>   
>   	pfn = pageblock_end_pfn(pfn);
>   
> +	/* Update where async and sync compaction should restart */
>   	if (pfn > zone->compact_cached_migrate_pfn[0])
>   		zone->compact_cached_migrate_pfn[0] = pfn;
>   	if (cc->mode != MIGRATE_ASYNC &&
> @@ -485,7 +486,6 @@ static void update_pageblock_skip(struct compact_control *cc,
>   
>   	set_pageblock_skip(page);
>   
> -	/* Update where async and sync compaction should restart */
>   	if (pfn < zone->compact_cached_free_pfn)
>   		zone->compact_cached_free_pfn = pfn;
>   }
