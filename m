Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA3178BD40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbjH2D2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 23:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjH2D21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:28:27 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D0B110
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:28:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VqphPb9_1693279700;
Received: from 30.221.133.4(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VqphPb9_1693279700)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 11:28:21 +0800
Message-ID: <06404460-81ef-7b9d-8daf-08492261cb86@linux.alibaba.com>
Date:   Tue, 29 Aug 2023 11:28:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 6/7] mm/compaction: improve comment of
 is_via_compact_memory
To:     Kemeng Shi <shikemeng@huaweicloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
References: <20230826153617.4019189-1-shikemeng@huaweicloud.com>
 <20230826153617.4019189-7-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230826153617.4019189-7-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/2023 11:36 PM, Kemeng Shi wrote:
> We do proactive compaction with order == -1 via
> 1. /proc/sys/vm/compact_memory
> 2. /sys/devices/system/node/nodex/compact
> 3. /proc/sys/vm/compaction_proactiveness
> Add missed situation in which order == -1.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 89a1b627bc89..00b7bba6c72e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2061,8 +2061,10 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
>   }
>   
>   /*
> - * order == -1 is expected when compacting via
> - * /proc/sys/vm/compact_memory
> + * order == -1 is expected when compacting proactively via
> + * 1. /proc/sys/vm/compact_memory
> + * 2. /sys/devices/system/node/nodex/compact
> + * 3. /proc/sys/vm/compaction_proactiveness
>    */
>   static inline bool is_via_compact_memory(int order)
>   {
