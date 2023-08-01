Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ADF76A730
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHACwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHACwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:52:40 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB72114
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:52:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VojoVVU_1690858355;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VojoVVU_1690858355)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:52:36 +0800
Message-ID: <89d7ec1d-ac48-64e5-1d3c-d3ee5c66a26f@linux.alibaba.com>
Date:   Tue, 1 Aug 2023 10:53:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 7/8] mm/compaction: remove unnecessary return for void
 function
To:     Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, willy@infradead.org, david@redhat.com
References: <20230728171037.2219226-1-shikemeng@huaweicloud.com>
 <20230728171037.2219226-8-shikemeng@huaweicloud.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230728171037.2219226-8-shikemeng@huaweicloud.com>
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
> Remove unnecessary return for void function
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/compaction.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 6052cb519de1..188d610eb3b6 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1420,8 +1420,6 @@ fast_isolate_around(struct compact_control *cc, unsigned long pfn)
>   	/* Skip this pageblock in the future as it's full or nearly full */
>   	if (start_pfn == end_pfn)
>   		set_pageblock_skip(page);
> -
> -	return;
>   }
>   
>   /* Search orders in round-robin fashion */
> @@ -2863,7 +2861,7 @@ int compaction_register_node(struct node *node)
>   
>   void compaction_unregister_node(struct node *node)
>   {
> -	return device_remove_file(&node->dev, &dev_attr_compact);
> +	device_remove_file(&node->dev, &dev_attr_compact);
>   }
>   #endif /* CONFIG_SYSFS && CONFIG_NUMA */
>   
